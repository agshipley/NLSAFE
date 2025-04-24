#[cfg(test)]
mod tests {
    use super::*;
    use serde_json::json;

    #[test]
    fn test_extract_build_id() {
        let bep_json = json!({
            "id": "test-build-id"
        });

        let result = extract_build_id(&bep_json).unwrap();
        assert_eq!(result, "test-build-id");
    }

    #[test]
    fn test_extract_artifacts() {
        let bep_json = json!({
            "events": [
                {
                    "action": {
                        "completed": {
                            "outputs": [
                                {
                                    "name": "artifact1",
                                    "digest": "sha256:1234"
                                },
                                {
                                    "name": "artifact2",
                                    "digest": "sha256:5678"
                                }
                            ]
                        }
                    }
                }
            ]
        });

        let result = extract_artifacts(&bep_json).unwrap();
        assert_eq!(result.len(), 2);
        assert_eq!(result[0], ("artifact1".to_string(), "sha256:1234".to_string()));
        assert_eq!(result[1], ("artifact2".to_string(), "sha256:5678".to_string()));
    }
}
