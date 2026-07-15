Each time we make an architectural decision, we'll record:

Decision: Use separate raw and analytics databases.
Reason: Separate ingestion from transformation.
Alternative considered: Single database with multiple schemas.
Trade-offs: Slightly more administration, but clearer ownership and security.

This does three things:

Documents the project.
Gives you ready-made interview talking points.
Shows that you think through trade-offs instead of blindly following patterns.