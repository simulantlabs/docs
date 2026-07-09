DELETE FROM workspaces WHERE slug = 'reyes-for-senate';
DELETE FROM workspaces WHERE id = 'a1111111-1111-4111-8111-111111111111'::uuid;

  INSERT INTO workspaces (id, name, slug, monthly_quota)
  VALUES ('a1111111-1111-4111-8111-111111111111'::uuid, 'Reyes for Senate', 'reyes-for-senate', 200);

  INSERT INTO workspace_members (workspace_id, user_id, role)
  VALUES ('a1111111-1111-4111-8111-111111111111'::uuid, '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, 'owner');

  INSERT INTO workspace_tags (workspace_id, name, created_by) VALUES
    ('a1111111-1111-4111-8111-111111111111'::uuid, 'Hero', '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid),
    ('a1111111-1111-4111-8111-111111111111'::uuid, 'TV', '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid),
    ('a1111111-1111-4111-8111-111111111111'::uuid, 'Digital', '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid),
    ('a1111111-1111-4111-8111-111111111111'::uuid, 'Mailer', '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid),
    ('a1111111-1111-4111-8111-111111111111'::uuid, 'Ballot', '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid);

  INSERT INTO datasets (id, slug, name, kind, owner_type, origin, owner_workspace_id, provider, format, description, tags, region, category, verified, created_by)
  VALUES
    ('a2222222-2222-4222-8222-222222222221'::uuid, 'reyes-voter-file', 'Voter file', 'Custom', 'workspace', 'uploaded', 'a1111111-1111-4111-8111-111111111111'::uuid, 'upload', 'CSV',
     'Campaign voter file for the Reyes for Senate race — registration, vote history, and modeled partisanship.',
     ARRAY['voter','campaign'], 'US-MI', 'Politics', true, '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid),
    ('a2222222-2222-4222-8222-222222222222'::uuid, 'reyes-q3-tracking', 'Q3 Tracking poll', 'Survey', 'workspace', 'uploaded', 'a1111111-1111-4111-8111-111111111111'::uuid, 'upload', 'CSV',
     'Internal Q3 tracking poll of likely voters in the Detroit metro and suburban swing counties.',
     ARRAY['tracking','poll'], 'US-MI', 'Politics', true, '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid),
    ('a2222222-2222-4222-8222-222222222223'::uuid, 'reyes-acs-mi', 'ACS Michigan extract', 'Census', 'workspace', 'uploaded', 'a1111111-1111-4111-8111-111111111111'::uuid, 'upload', 'CSV',
     'American Community Survey extract for Michigan — demographics, income, and household composition.',
     ARRAY['census','demographics'], 'US-MI', 'Demographics', true, '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid);

  INSERT INTO workspace_datasets (workspace_id, dataset_id, added_by) VALUES
    ('a1111111-1111-4111-8111-111111111111'::uuid, 'a2222222-2222-4222-8222-222222222221'::uuid, '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid),
    ('a1111111-1111-4111-8111-111111111111'::uuid, 'a2222222-2222-4222-8222-222222222222'::uuid, '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid),
    ('a1111111-1111-4111-8111-111111111111'::uuid, 'a2222222-2222-4222-8222-222222222223'::uuid, '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid);

  INSERT INTO cohorts (
    id, workspace_id, name, description, config, created_by, respondent_count, origin,
    generation_params, research_report, target_spec
  ) VALUES
  (
    'a3333333-3333-4333-8333-333333333331'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Suburban Swing Voters',
    'Undecided suburban voters in Michigan swing counties, open to either party on cost of living.',
    '{"age":{"min":25,"max":54},"gender":"any","region":"MI","tags":["Cost-of-living anxious","Undecided"]}'::jsonb,
    '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, 1200, 'synthetic',
    '{"panelSize":1200,"region":"MI","population":"American adults aged 25–54 in suburban Michigan counties — undecided voters open to either party."}'::jsonb,
    '{"text":"### Suburban Swing Voters\\n\\nThis cohort represents undecided suburban adults in Michigan swing counties. Cost of living and healthcare affordability dominate their agenda. They consume local TV and Facebook more than national cable, and they punish candidates who sound partisan before they sound practical.\\n\\n### What moves them\\n\\nConcrete household math — rent, groceries, insurance premiums — outperforms abstract policy frames. Senior Voters 60+ in the same geography are more skeptical of funding claims; Young Voters under 35 respond to education and climate co-benefits."}'::jsonb,
    '{"region":"MI","size":1200}'::jsonb
  ),
  (
    'a3333333-3333-4333-8333-333333333332'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Senior Voters 60+',
    'Likely voters aged 60+ across Michigan, attentive to Medicare and Social Security.',
    '{"age":{"min":60,"max":90},"gender":"any","region":"MI","tags":["Medicare-focused","High turnout"]}'::jsonb,
    '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, 800, 'synthetic',
    '{"panelSize":800,"region":"MI"}'::jsonb, NULL, '{"region":"MI","size":800}'::jsonb
  ),
  (
    'a3333333-3333-4333-8333-333333333333'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Young Voters',
    'Urban and college-adjacent voters aged 18–34.',
    '{"age":{"min":18,"max":34},"gender":"any","region":"MI","tags":["Climate-focused","Digital-first"]}'::jsonb,
    '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, 650, 'synthetic',
    '{"panelSize":650,"region":"MI"}'::jsonb, NULL, '{"region":"MI","size":650}'::jsonb
  ),
  (
    'a3333333-3333-4333-8333-333333333334'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Rural Independents',
    'Rural and small-town independents outside the Detroit metro.',
    '{"age":{"min":30,"max":70},"gender":"any","region":"MI","tags":["Independent","Rural"]}'::jsonb,
    '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, 500, 'synthetic',
    '{"panelSize":500,"region":"MI"}'::jsonb, NULL, '{"region":"MI","size":500}'::jsonb
  ),
  (
    'a3333333-3333-4333-8333-333333333335'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Union Households',
    'Union-affiliated households in industrial and service sectors.',
    '{"age":{"min":25,"max":64},"gender":"any","region":"MI","tags":["Union","Working class"]}'::jsonb,
    '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, 450, 'synthetic',
    '{"panelSize":450,"region":"MI"}'::jsonb, NULL, '{"region":"MI","size":450}'::jsonb
  ),
  (
    'a3333333-3333-4333-8333-333333333336'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Small Business Owners',
    'Owners of firms under 50 employees across Michigan.',
    '{"age":{"min":30,"max":65},"gender":"any","region":"MI","tags":["Small business","Tax-sensitive"]}'::jsonb,
    '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, 400, 'synthetic',
    '{"panelSize":400,"region":"MI"}'::jsonb, NULL, '{"region":"MI","size":400}'::jsonb
  );

  INSERT INTO cohort_sources (cohort_id, dataset_id) VALUES
    ('a3333333-3333-4333-8333-333333333331'::uuid, 'a2222222-2222-4222-8222-222222222221'::uuid),
    ('a3333333-3333-4333-8333-333333333331'::uuid, 'a2222222-2222-4222-8222-222222222222'::uuid),
    ('a3333333-3333-4333-8333-333333333331'::uuid, 'a2222222-2222-4222-8222-222222222223'::uuid),
    ('a3333333-3333-4333-8333-333333333332'::uuid, 'a2222222-2222-4222-8222-222222222221'::uuid),
    ('a3333333-3333-4333-8333-333333333332'::uuid, 'a2222222-2222-4222-8222-222222222223'::uuid),
    ('a3333333-3333-4333-8333-333333333333'::uuid, 'a2222222-2222-4222-8222-222222222221'::uuid),
    ('a3333333-3333-4333-8333-333333333334'::uuid, 'a2222222-2222-4222-8222-222222222221'::uuid),
    ('a3333333-3333-4333-8333-333333333335'::uuid, 'a2222222-2222-4222-8222-222222222221'::uuid),
    ('a3333333-3333-4333-8333-333333333336'::uuid, 'a2222222-2222-4222-8222-222222222222'::uuid);

  INSERT INTO creatives (
    id, workspace_id, name, kind, content_type, bytes, description_input, tags, storage_key,
    pipeline_status, analysis_status, description, summary, created_by
  ) VALUES
    ('a4444444-4444-4444-8444-444444444441'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Cost-of-Living — :30 TV Spot A', 'video', 'video/mp4', 12400000,
     'Reyes kitchen-table spot on grocery and rent costs.', ARRAY['TV','Hero'],
     'docs-demo/cost-of-living-a.mp4', 'ready', 'complete',
     'A :30 TV spot featuring Reyes at a kitchen table talking through grocery bills and rent.',
     'Kitchen-table cost-of-living spot with Reyes.', '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid),
    ('a4444444-4444-4444-8444-444444444442'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Healthcare Message — Digital Video', 'video', 'video/mp4', 8200000,
     'Digital cut on insulin and premium costs.', ARRAY['Digital'],
     'docs-demo/healthcare-digital.mp4', 'ready', 'analyzing',
     'Digital video on prescription drug costs and insurance premiums.',
     'Healthcare affordability digital cut.', '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid),
    ('a4444444-4444-4444-8444-444444444443'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Education Plan — Social Cutdown', 'image', 'image/png', 420000,
     'Social still for the education plan.', ARRAY['Digital'],
     'docs-demo/education-social.png', 'ready', 'complete',
     'Static social asset summarizing the Reyes education plan.',
     'Education plan social still.', '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid),
    ('a4444444-4444-4444-8444-444444444444'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Tax Relief — Mailer Copy', 'document', 'application/pdf', 180000,
     'Mailer copy for small business tax relief.', ARRAY['Mailer'],
     'docs-demo/tax-relief-mailer.pdf', 'ready', 'complete',
     'Two-page mailer on small business tax relief.',
     'Tax relief mailer copy.', '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid),
    ('a4444444-4444-4444-8444-444444444445'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Closing Argument — 30s TV Spot', 'video', 'video/mp4', 11800000,
     'Closing argument TV spot for union households.', ARRAY['TV','Hero'],
     'docs-demo/closing-argument.mp4', 'ready', 'complete',
     'Closing argument spot aimed at union households.',
     'Closing argument TV spot.', '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid);

  INSERT INTO simulation_flows (id, workspace_id, name, description, status, graph, tags, created_by, updated_at) VALUES
  (
    'a5555555-5555-4555-8555-555555555551'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Cost-of-Living — :30 TV Spot A/B',
    'A/B test of the kitchen-table cost-of-living spot against Suburban Swing Voters.',
    'done',
    jsonb_build_object(
      'version', 1,
      'nodes', jsonb_build_array(
        jsonb_build_object('id','n-cohort','type','cohort','position',jsonb_build_object('x',80,'y',160),'data',jsonb_build_object('cohortId', 'a3333333-3333-4333-8333-333333333331'::uuid)),
        jsonb_build_object('id','n-test','type','test','position',jsonb_build_object('x',480,'y',120),'data',jsonb_build_object('recordId', 'a6666666-6666-4666-8666-666666666661'::uuid)),
        jsonb_build_object('id','n-fg','type','focus-group','position',jsonb_build_object('x',880,'y',280),'data',jsonb_build_object('recordId', 'a7777777-7777-4777-8777-777777777771'::uuid))
      ),
      'edges', jsonb_build_array(
        jsonb_build_object('id','e1','source','n-cohort','target','n-test','targetHandle','respondents'),
        jsonb_build_object('id','e3','source','n-cohort','target','n-fg','targetHandle','respondents'),
        jsonb_build_object('id','e5','source','n-test','target','n-fg','targetHandle','trigger')
      )
    ),
    ARRAY['Hero','TV'], '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, now() - interval '2 hours'
  ),
  (
    'a5555555-5555-4555-8555-555555555552'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Healthcare Message — Digital Video',
    'Digital healthcare message against Senior Voters 60+.',
    'running',
    jsonb_build_object(
      'version', 1,
      'nodes', jsonb_build_array(
        jsonb_build_object('id','n-cohort','type','cohort','position',jsonb_build_object('x',120,'y',100),'data',jsonb_build_object('cohortId', 'a3333333-3333-4333-8333-333333333332'::uuid)),
        jsonb_build_object('id','n-test','type','test','position',jsonb_build_object('x',420,'y',100),'data',jsonb_build_object('recordId', 'a6666666-6666-4666-8666-666666666662'::uuid))
      ),
      'edges', jsonb_build_array(
        jsonb_build_object('id','e1','source','n-cohort','target','n-test','targetHandle','respondents')
      )
    ),
    ARRAY['Digital'], '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, now() - interval '40 minutes'
  ),
  (
    'a5555555-5555-4555-8555-555555555553'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Education Plan — Social Cutdown',
    'Social cutdown of the education plan with Young Voters.',
    'done',
    jsonb_build_object(
      'version', 1,
      'nodes', jsonb_build_array(
        jsonb_build_object('id','n-cohort','type','cohort','position',jsonb_build_object('x',120,'y',100),'data',jsonb_build_object('cohortId', 'a3333333-3333-4333-8333-333333333333'::uuid)),
        jsonb_build_object('id','n-test','type','test','position',jsonb_build_object('x',420,'y',100),'data',jsonb_build_object('recordId', 'a6666666-6666-4666-8666-666666666663'::uuid))
      ),
      'edges', jsonb_build_array(
        jsonb_build_object('id','e1','source','n-cohort','target','n-test','targetHandle','respondents')
      )
    ),
    ARRAY['Digital'], '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, now() - interval '1 day'
  ),
  (
    'a5555555-5555-4555-8555-555555555554'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Tax Relief — Mailer Copy',
    'Mailer copy test with Small Business Owners.',
    'done',
    jsonb_build_object(
      'version', 1,
      'nodes', jsonb_build_array(
        jsonb_build_object('id','n-cohort','type','cohort','position',jsonb_build_object('x',120,'y',100),'data',jsonb_build_object('cohortId', 'a3333333-3333-4333-8333-333333333336'::uuid)),
        jsonb_build_object('id','n-test','type','test','position',jsonb_build_object('x',420,'y',100),'data',jsonb_build_object('recordId', 'a6666666-6666-4666-8666-666666666664'::uuid))
      ),
      'edges', jsonb_build_array(
        jsonb_build_object('id','e1','source','n-cohort','target','n-test','targetHandle','respondents')
      )
    ),
    ARRAY['Mailer'], '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, now() - interval '2 days'
  ),
  (
    'a5555555-5555-4555-8555-555555555555'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Closing Argument — 30s TV Spot',
    'Closing argument spot with Union Households.',
    'done',
    jsonb_build_object(
      'version', 1,
      'nodes', jsonb_build_array(
        jsonb_build_object('id','n-cohort','type','cohort','position',jsonb_build_object('x',120,'y',100),'data',jsonb_build_object('cohortId', 'a3333333-3333-4333-8333-333333333335'::uuid)),
        jsonb_build_object('id','n-test','type','test','position',jsonb_build_object('x',420,'y',100),'data',jsonb_build_object('recordId', 'a6666666-6666-4666-8666-666666666665'::uuid))
      ),
      'edges', jsonb_build_array(
        jsonb_build_object('id','e1','source','n-cohort','target','n-test','targetHandle','respondents')
      )
    ),
    ARRAY['TV','Hero'], '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, now() - interval '3 days'
  ),
  (
    'a5555555-5555-4555-8555-555555555556'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Ballot test — General',
    'Head-to-head ballot and Reyes favorability among Suburban Swing Voters.',
    'done',
    jsonb_build_object(
      'version', 1,
      'nodes', jsonb_build_array(
        jsonb_build_object('id','n-cohort','type','cohort','position',jsonb_build_object('x',120,'y',100),'data',jsonb_build_object('cohortId', 'a3333333-3333-4333-8333-333333333331'::uuid)),
        jsonb_build_object('id','n-poll','type','poll','position',jsonb_build_object('x',420,'y',100),'data',jsonb_build_object('recordId', 'a6666666-6666-4666-8666-666666666666'::uuid))
      ),
      'edges', jsonb_build_array(
        jsonb_build_object('id','e1','source','n-cohort','target','n-poll','targetHandle','respondents')
      )
    ),
    ARRAY['Ballot'], '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, now() - interval '5 hours'
  ),
  (
    'a5555555-5555-4555-8555-555555555557'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Message package — Week 12',
    'Multi-step package: approval poll, cost-of-living test, and voter focus group.',
    'draft',
    jsonb_build_object(
      'version', 1,
      'nodes', jsonb_build_array(
        jsonb_build_object('id','n-cohort','type','cohort','position',jsonb_build_object('x',80,'y',160),'data',jsonb_build_object('cohortId', 'a3333333-3333-4333-8333-333333333331'::uuid)),
        jsonb_build_object('id','n-poll','type','poll','position',jsonb_build_object('x',380,'y',40),'data',jsonb_build_object('recordId', 'a6666666-6666-4666-8666-666666666667'::uuid)),
        jsonb_build_object('id','n-test','type','test','position',jsonb_build_object('x',380,'y',200),'data',jsonb_build_object('recordId', 'a6666666-6666-4666-8666-666666666661'::uuid)),
        jsonb_build_object('id','n-fg','type','focus-group','position',jsonb_build_object('x',380,'y',360),'data',jsonb_build_object('recordId', 'a7777777-7777-4777-8777-777777777772'::uuid)),
        jsonb_build_object('id','n-asset','type','asset','position',jsonb_build_object('x',80,'y',320),'data',jsonb_build_object('creativeId', 'a4444444-4444-4444-8444-444444444441'::uuid))
      ),
      'edges', jsonb_build_array(
        jsonb_build_object('id','e1','source','n-cohort','target','n-poll','targetHandle','respondents'),
        jsonb_build_object('id','e2','source','n-cohort','target','n-test','targetHandle','respondents'),
        jsonb_build_object('id','e3','source','n-cohort','target','n-fg','targetHandle','respondents'),
        jsonb_build_object('id','e4','source','n-asset','target','n-test','targetHandle','asset-0')
      )
    ),
    ARRAY['Hero'], '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, now() - interval '8 hours'
  );

  INSERT INTO tests (id, workspace_id, name, description, status, config, cohort_id, created_by, sentiment, recall, intent, clarity, progress, creative_id, run_type, tags, flow_id, latest_run_id) VALUES
  (
    'a6666666-6666-4666-8666-666666666661'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Cost-of-Living — :30 TV Spot A/B',
    'Hypothesis: Variant A (kitchen table) outperforms Variant B (town hall) with Suburban Swing on sentiment and intent.',
    'done',
    '{"format":"Video","hypothesis":"Kitchen-table framing beats town-hall framing with suburban swing voters.","variants":[{"label":"A","name":"Kitchen table"},{"label":"B","name":"Town hall"}],"metrics":["Recall","Sentiment","Purchase intent","Clarity"],"questions":[{"id":1,"text":"What stood out to you about this ad?","type":"Open-ended"},{"id":2,"text":"How clear was the main message?","type":"Rating 1–5"}],"sampleSize":400,"controlBaseline":true,"context":{"mode":"Current"}}'::jsonb,
    'a3333333-3333-4333-8333-333333333331'::uuid, '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, 78, 71, 64, 82, 100, 'a4444444-4444-4444-8444-444444444441'::uuid, 'test', ARRAY['Hero','TV'], 'a5555555-5555-4555-8555-555555555551'::uuid, 'a8888888-8888-4888-8888-888888888881'::uuid
  ),
  (
    'a6666666-6666-4666-8666-666666666662'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Healthcare Message — Digital Video',
    'Hypothesis: Insulin framing lifts senior sentiment vs premium framing.',
    'running',
    '{"format":"Video","hypothesis":"Insulin framing lifts senior sentiment.","variants":[{"label":"A","name":"Insulin"}],"metrics":["Recall","Sentiment","Clarity"],"sampleSize":300,"controlBaseline":true,"context":{"mode":"Current"}}'::jsonb,
    'a3333333-3333-4333-8333-333333333332'::uuid, '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, NULL, NULL, NULL, NULL, 42, 'a4444444-4444-4444-8444-444444444442'::uuid, 'test', ARRAY['Digital'], 'a5555555-5555-4555-8555-555555555552'::uuid, NULL
  ),
  (
    'a6666666-6666-4666-8666-666666666663'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Education Plan — Social Cutdown',
    'Hypothesis: Debt-relief frame outperforms classroom frame with Young Voters.',
    'done',
    '{"format":"Image","hypothesis":"Debt-relief frame wins with Young Voters.","variants":[{"label":"A","name":"Debt relief"}],"metrics":["Recall","Sentiment","Intent","Clarity"],"sampleSize":350,"controlBaseline":false,"context":{"mode":"Neutral"}}'::jsonb,
    'a3333333-3333-4333-8333-333333333333'::uuid, '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, 64, 58, 61, 70, 100, 'a4444444-4444-4444-8444-444444444443'::uuid, 'test', ARRAY['Digital'], 'a5555555-5555-4555-8555-555555555553'::uuid, 'a8888888-8888-4888-8888-888888888883'::uuid
  ),
  (
    'a6666666-6666-4666-8666-666666666664'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Tax Relief — Mailer Copy',
    'Hypothesis: Specific dollar amounts beat abstract relief language with small business owners.',
    'done',
    '{"format":"Messaging","hypothesis":"Dollar amounts beat abstract relief.","variants":[{"label":"A","name":"Dollar amounts"}],"metrics":["Recall","Sentiment","Intent","Clarity"],"sampleSize":280,"controlBaseline":true,"context":{"mode":"Neutral"}}'::jsonb,
    'a3333333-3333-4333-8333-333333333336'::uuid, '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, 41, 52, 38, 55, 100, 'a4444444-4444-4444-8444-444444444444'::uuid, 'test', ARRAY['Mailer'], 'a5555555-5555-4555-8555-555555555554'::uuid, 'a8888888-8888-4888-8888-888888888884'::uuid
  ),
  (
    'a6666666-6666-4666-8666-666666666665'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Closing Argument — 30s TV Spot',
    'Hypothesis: Union-household closing argument clears 75 sentiment.',
    'done',
    '{"format":"Video","hypothesis":"Union closing argument clears 75 sentiment.","variants":[{"label":"A","name":"Closing"}],"metrics":["Recall","Sentiment","Intent","Clarity"],"sampleSize":400,"controlBaseline":true,"context":{"mode":"Current"}}'::jsonb,
    'a3333333-3333-4333-8333-333333333335'::uuid, '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, 81, 76, 72, 84, 100, 'a4444444-4444-4444-8444-444444444445'::uuid, 'test', ARRAY['TV','Hero'], 'a5555555-5555-4555-8555-555555555555'::uuid, 'a8888888-8888-4888-8888-888888888885'::uuid
  ),
  (
    'a6666666-6666-4666-8666-666666666666'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Ballot test — General',
    'Hypothesis: Reyes leads by mid-single digits among suburban swing.',
    'done',
    '{"context":{"mode":"Current"},"questions":[{"id":1,"text":"If the election for U.S. Senate were held today, who would you vote for?","type":"Single choice","options":["Maya Reyes","Jordan Hale","Undecided"]},{"id":2,"text":"Do you have a favorable or unfavorable opinion of Maya Reyes?","type":"Single choice","options":["Favorable","Unfavorable","No opinion"]}],"sampleSize":500,"controlBaseline":false}'::jsonb,
    'a3333333-3333-4333-8333-333333333331'::uuid, '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, NULL, NULL, NULL, NULL, 100, NULL, 'poll', ARRAY['Ballot'], 'a5555555-5555-4555-8555-555555555556'::uuid, 'a8888888-8888-4888-8888-888888888886'::uuid
  ),
  (
    'a6666666-6666-4666-8666-666666666667'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Reyes favorability pulse',
    'Weekly favorability pulse.',
    'draft',
    '{"context":{"mode":"Current"},"questions":[{"id":1,"text":"Do you approve of Maya Reyes''s campaign so far?","type":"Yes / No","options":["Yes","No"]}],"sampleSize":400,"controlBaseline":false}'::jsonb,
    'a3333333-3333-4333-8333-333333333331'::uuid, '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, NULL, NULL, NULL, NULL, 0, NULL, 'poll', ARRAY['Ballot'], 'a5555555-5555-4555-8555-555555555557'::uuid, NULL
  );

  INSERT INTO focus_groups (id, workspace_id, name, description, config, created_by, status, sentiment, cohort_id, tags, flow_id, latest_run_id) VALUES
  (
    'a7777777-7777-4777-8777-777777777771'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Suburban Swing — Cost-of-Living room',
    'Watch Suburban Swing Voters deliberate on the cost-of-living spot.',
    '{"objective":"Understand why Variant A resonates and where funding doubts surface.","moderator":"ai","style":"probing","prompts":["What felt true about this ad?","What felt missing or unbelievable?","Would this change how you vote?"],"length":"45 min","dynamics":{"crosstalk":true,"dissent":true,"anonymous":false,"summary":true}}'::jsonb,
    '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, 'done', 72, 'a3333333-3333-4333-8333-333333333331'::uuid, ARRAY['Hero'], 'a5555555-5555-4555-8555-555555555551'::uuid, 'a8888888-8888-4888-8888-888888888888'::uuid
  ),
  (
    'a7777777-7777-4777-8777-777777777772'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Senior Voters — Healthcare room',
    'Seniors react to the healthcare digital cut.',
    '{"objective":"Surface funding and trust objections.","moderator":"ai","style":"probing","prompts":["What did you hear about healthcare costs?","Do you trust this candidate on Medicare?"],"length":"45 min","dynamics":{"crosstalk":true,"dissent":true,"anonymous":false,"summary":true}}'::jsonb,
    '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, 'draft', NULL, 'a3333333-3333-4333-8333-333333333332'::uuid, ARRAY['Digital'], 'a5555555-5555-4555-8555-555555555557'::uuid, NULL
  );

  INSERT INTO test_runs (
    id, test_id, workspace_id, cohort_id, status, progress, respondent_count,
    metrics, segments, verbatims, results, created_by, created_at, finished_at,
    scoring_mode, run_type, engine_version
  ) VALUES
  (
    'a8888888-8888-4888-8888-888888888881'::uuid, 'a6666666-6666-4666-8666-666666666661'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'a3333333-3333-4333-8333-333333333331'::uuid, 'done', 100, 400,
    '{"recall":{"score":71,"vsControl":8},"sentiment":{"score":78,"vsControl":12},"intent":{"score":64,"vsControl":9},"clarity":{"score":82,"vsControl":6},"benchmark":70}'::jsonb,
    '[{"name":"Suburban Swing","positive":84,"neutral":10,"negative":6,"lift":14},{"name":"Senior Voters 60+","positive":52,"neutral":22,"negative":26,"lift":-3},{"name":"Young Voters","positive":71,"neutral":18,"negative":11,"lift":8}]'::jsonb,
    '[{"quote":"Finally someone talking about my grocery bill like it is real money.","tone":"positive","segment":"Suburban Swing"},{"quote":"I like the kitchen table, but who pays for this plan?","tone":"neutral","segment":"Senior Voters 60+"},{"quote":"Town hall version felt like every other politician.","tone":"negative","segment":"Suburban Swing"},{"quote":"She sounds like she has actually paid rent recently.","tone":"positive","segment":"Young Voters"}]'::jsonb,
    '{"kind":"test","themes":[{"title":"Cost-of-living resonance","count":48,"summary":"Kitchen-table framing lands as authentic and specific."},{"title":"Doubts about funding","count":31,"summary":"Seniors and rural independents ask how the plan is paid for."},{"title":"Town hall fatigue","count":22,"summary":"Variant B reads as generic political speech."}],"recommendations":["Lead with Variant A in paid TV.","Add a one-line funding proof for seniors.","Hold Variant B for earned media only."]}'::jsonb,
    '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, now() - interval '3 hours', now() - interval '2 hours', 'persona', 'test', 'docs-demo'
  ),
  (
    'a8888888-8888-4888-8888-888888888883'::uuid, 'a6666666-6666-4666-8666-666666666663'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'a3333333-3333-4333-8333-333333333333'::uuid, 'done', 100, 350,
    '{"recall":{"score":58},"sentiment":{"score":64},"intent":{"score":61},"clarity":{"score":70},"benchmark":65}'::jsonb,
    '[{"name":"Young Voters","positive":68,"neutral":20,"negative":12},{"name":"Urban","positive":72,"neutral":18,"negative":10}]'::jsonb,
    '[{"quote":"Debt relief is the only line that felt like it was for me.","tone":"positive","segment":"Young Voters"}]'::jsonb,
    '{"kind":"test","themes":[{"title":"Debt relief salience","count":40,"summary":"Student debt frame outperforms classroom imagery."}],"recommendations":["Keep debt relief as the hero line on social."]}'::jsonb,
    '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, now() - interval '1 day', now() - interval '23 hours', 'persona', 'test', 'docs-demo'
  ),
  (
    'a8888888-8888-4888-8888-888888888884'::uuid, 'a6666666-6666-4666-8666-666666666664'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'a3333333-3333-4333-8333-333333333336'::uuid, 'done', 100, 280,
    '{"recall":{"score":52,"vsControl":2},"sentiment":{"score":41,"vsControl":-4},"intent":{"score":38,"vsControl":-6},"clarity":{"score":55,"vsControl":1},"benchmark":60}'::jsonb,
    '[{"name":"Small Business Owners","positive":34,"neutral":28,"negative":38,"lift":-5}]'::jsonb,
    '[{"quote":"Sounds nice until I ask what it does to my quarterly estimate.","tone":"negative","segment":"Small Business Owners"}]'::jsonb,
    '{"kind":"test","themes":[{"title":"Skepticism on specifics","count":36,"summary":"Owners want numbers, not slogans."}],"recommendations":["Rewrite with concrete dollar examples.","Needs review before mail drop."]}'::jsonb,
    '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, now() - interval '2 days', now() - interval '2 days', 'persona', 'test', 'docs-demo'
  ),
  (
    'a8888888-8888-4888-8888-888888888885'::uuid, 'a6666666-6666-4666-8666-666666666665'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'a3333333-3333-4333-8333-333333333335'::uuid, 'done', 100, 400,
    '{"recall":{"score":76,"vsControl":11},"sentiment":{"score":81,"vsControl":15},"intent":{"score":72,"vsControl":10},"clarity":{"score":84,"vsControl":7},"benchmark":70}'::jsonb,
    '[{"name":"Union Households","positive":86,"neutral":9,"negative":5,"lift":16}]'::jsonb,
    '[{"quote":"This one actually sounded like it was written for people who punch a clock.","tone":"positive","segment":"Union Households"}]'::jsonb,
    '{"kind":"test","themes":[{"title":"Worker identity fit","count":52,"summary":"Union households feel seen."}],"recommendations":["Heavy-up closing argument in union DMA buys."]}'::jsonb,
    '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, now() - interval '3 days', now() - interval '3 days', 'persona', 'test', 'docs-demo'
  ),
  (
    'a8888888-8888-4888-8888-888888888886'::uuid, 'a6666666-6666-4666-8666-666666666666'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'a3333333-3333-4333-8333-333333333331'::uuid, 'done', 100, 500,
    '{}'::jsonb, '[]'::jsonb, '[]'::jsonb,
    '{
      "kind":"poll",
      "questions":[
        {
          "idx":0,"ref":"q0","kind":"single","type":"Single choice",
          "text":"If the election for U.S. Senate were held today, who would you vote for?",
          "answered":500,"marginOfError":4.4,
          "options":[
            {"label":"Maya Reyes","pct":44.0,"count":220},
            {"label":"Jordan Hale","pct":39.0,"count":195},
            {"label":"Undecided","pct":17.0,"count":85}
          ],
          "segments":[
            {"name":"Suburban Swing","n":500,"top":"Maya Reyes","topPct":44.0,"mean":null},
            {"name":"Women","n":260,"top":"Maya Reyes","topPct":48.0,"mean":null},
            {"name":"Men","n":240,"top":"Jordan Hale","topPct":42.0,"mean":null}
          ],
          "verbatims":[
            {"quote":"I am still waiting to hear how she pays for the cost-of-living plan.","segment":"Suburban Swing"},
            {"quote":"Reyes feels more practical than the other guy.","segment":"Women"}
          ]
        },
        {
          "idx":1,"ref":"q1","kind":"single","type":"Single choice",
          "text":"Do you have a favorable or unfavorable opinion of Maya Reyes?",
          "answered":500,"marginOfError":4.4,
          "options":[
            {"label":"Favorable","pct":49.0,"count":245},
            {"label":"Unfavorable","pct":28.0,"count":140},
            {"label":"No opinion","pct":23.0,"count":115}
          ],
          "segments":[
            {"name":"Suburban Swing","n":500,"top":"Favorable","topPct":49.0,"mean":null}
          ],
          "verbatims":[
            {"quote":"I like her, I just do not know her yet.","segment":"Suburban Swing"}
          ]
        }
      ]
    }'::jsonb,
    '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, now() - interval '6 hours', now() - interval '5 hours', 'persona', 'poll', 'docs-demo'
  ),
  (
    'a8888888-8888-4888-8888-888888888882'::uuid, 'a6666666-6666-4666-8666-666666666662'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'a3333333-3333-4333-8333-333333333332'::uuid, 'running', 42, 126,
    '{}'::jsonb, '[]'::jsonb, '[]'::jsonb, '{}'::jsonb,
    '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, now() - interval '40 minutes', NULL, 'persona', 'test', 'docs-demo'
  );

  INSERT INTO focus_group_runs (
    id, focus_group_id, workspace_id, cohort_id, status, transcript, themes, sentiment,
    participant_count, duration_minutes, created_by, created_at, finished_at
  ) VALUES (
    'a8888888-8888-4888-8888-888888888888'::uuid, 'a7777777-7777-4777-8777-777777777771'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'a3333333-3333-4333-8333-333333333331'::uuid, 'done',
    '[
      {"speaker":"Moderator","text":"What stood out when you watched the cost-of-living spot?"},
      {"speaker":"Priya, 38 — Troy","text":"The grocery receipt. That is my week."},
      {"speaker":"Marcus, 51 — Livonia","text":"I believed her until she skipped how it is funded."},
      {"speaker":"Elena, 29 — Ann Arbor","text":"Town hall version felt like every other ad. Kitchen table felt human."},
      {"speaker":"Moderator","text":"Would this change how you vote?"},
      {"speaker":"Priya, 38 — Troy","text":"It moves me toward Reyes, but I want one sentence on the pay-for."},
      {"speaker":"Marcus, 51 — Livonia","text":"Same. Show me the math and I am in."}
    ]'::jsonb,
    '[{"title":"Kitchen-table authenticity","summary":"Participants preferred the domestic frame over the town hall."},{"title":"Funding proof gap","summary":"Several voters withhold commitment until they hear how the plan is paid for."}]'::jsonb,
    72, 6, 45, '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, now() - interval '3 hours', now() - interval '2 hours'
  );

  UPDATE focus_groups SET latest_run_id = 'a8888888-8888-4888-8888-888888888888'::uuid WHERE id = 'a7777777-7777-4777-8777-777777777771'::uuid;
  UPDATE tests SET latest_run_id = 'a8888888-8888-4888-8888-888888888881'::uuid WHERE id = 'a6666666-6666-4666-8666-666666666661'::uuid;
  UPDATE tests SET latest_run_id = 'a8888888-8888-4888-8888-888888888883'::uuid WHERE id = 'a6666666-6666-4666-8666-666666666663'::uuid;
  UPDATE tests SET latest_run_id = 'a8888888-8888-4888-8888-888888888884'::uuid WHERE id = 'a6666666-6666-4666-8666-666666666664'::uuid;
  UPDATE tests SET latest_run_id = 'a8888888-8888-4888-8888-888888888885'::uuid WHERE id = 'a6666666-6666-4666-8666-666666666665'::uuid;
  UPDATE tests SET latest_run_id = 'a8888888-8888-4888-8888-888888888886'::uuid WHERE id = 'a6666666-6666-4666-8666-666666666666'::uuid;

  INSERT INTO flow_runs (id, flow_id, workspace_id, trigger, status, created_by, created_at, finished_at) VALUES
    ('a9999999-9999-4999-8999-999999999991'::uuid, 'a5555555-5555-4555-8555-555555555551'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'manual', 'done', '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, now() - interval '3 hours', now() - interval '2 hours'),
    ('a9999999-9999-4999-8999-999999999992'::uuid, 'a5555555-5555-4555-8555-555555555556'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'manual', 'done', '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, now() - interval '6 hours', now() - interval '5 hours'),
    ('a9999999-9999-4999-8999-999999999993'::uuid, 'a5555555-5555-4555-8555-555555555552'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'manual', 'running', '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, now() - interval '40 minutes', NULL);

  INSERT INTO flow_node_runs (flow_run_id, workspace_id, node_id, node_type, status, output, test_run_id, focus_group_run_id, created_at, finished_at) VALUES
    ('a9999999-9999-4999-8999-999999999991'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'n-test', 'test', 'done', '{"kind":"test","recordId":"a6666666-6666-4666-8666-666666666661"}'::jsonb, 'a8888888-8888-4888-8888-888888888881'::uuid, NULL, now() - interval '3 hours', now() - interval '2 hours'),
    ('a9999999-9999-4999-8999-999999999991'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'n-fg', 'focus-group', 'done', '{"kind":"focus-group","recordId":"a7777777-7777-4777-8777-777777777771"}'::jsonb, NULL, 'a8888888-8888-4888-8888-888888888888'::uuid, now() - interval '3 hours', now() - interval '2 hours'),
    ('a9999999-9999-4999-8999-999999999992'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'n-poll', 'poll', 'done', '{"kind":"poll","recordId":"a6666666-6666-4666-8666-666666666666"}'::jsonb, 'a8888888-8888-4888-8888-888888888886'::uuid, NULL, now() - interval '6 hours', now() - interval '5 hours'),
    ('a9999999-9999-4999-8999-999999999993'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'n-test', 'test', 'running', '{"kind":"test","recordId":"a6666666-6666-4666-8666-666666666662"}'::jsonb, 'a8888888-8888-4888-8888-888888888882'::uuid, NULL, now() - interval '40 minutes', NULL);

  UPDATE simulation_flows SET latest_run_id = 'a9999999-9999-4999-8999-999999999991'::uuid, status = 'done' WHERE id = 'a5555555-5555-4555-8555-555555555551'::uuid;
  UPDATE simulation_flows SET latest_run_id = 'a9999999-9999-4999-8999-999999999992'::uuid, status = 'done' WHERE id = 'a5555555-5555-4555-8555-555555555556'::uuid;
  UPDATE simulation_flows SET latest_run_id = 'a9999999-9999-4999-8999-999999999993'::uuid, status = 'running' WHERE id = 'a5555555-5555-4555-8555-555555555552'::uuid;
  UPDATE simulation_flows SET status = 'done' WHERE id IN ('a5555555-5555-4555-8555-555555555553'::uuid, 'a5555555-5555-4555-8555-555555555554'::uuid, 'a5555555-5555-4555-8555-555555555555'::uuid);
  UPDATE simulation_flows SET status = 'draft' WHERE id = 'a5555555-5555-4555-8555-555555555557'::uuid;

  INSERT INTO reports (id, workspace_id, name, description, time_window, preset, sections, created_by) VALUES
    ('aa111111-aaaa-4aaa-8aaa-aaaaaaaaaaa1'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Morning brief', 'Daily readout across Reyes message tests.', '24h', 'morning-brief',
     '{"metrics":true,"takeaways":true,"sentiment":true,"topTests":true,"verbatims":true}'::jsonb, '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid);

  INSERT INTO report_editions (id, report_id, workspace_id, status, content, created_by, created_at, finished_at) VALUES
    ('aa111111-aaaa-4aaa-8aaa-aaaaaaaaaaa2'::uuid, 'aa111111-aaaa-4aaa-8aaa-aaaaaaaaaaa1'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'done',
     '{
       "title":"Morning brief — Reyes for Senate",
       "window":"24h",
       "takeaways":[
         "Cost-of-Living spot leads with Suburban Swing (84% positive).",
         "Senior Voters 60+ still doubt funding — add a pay-for line.",
         "Tax Relief mailer underperforms and needs rewrite before drop."
       ],
       "metrics":{"avgSentiment":71,"testsCompleted":4,"verbatims":4200},
       "topTests":["Cost-of-Living — :30 TV Spot A/B","Closing Argument — 30s TV Spot"],
       "verbatims":["Finally someone talking about my grocery bill like it is real money."]
     }'::jsonb,
     '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, now() - interval '1 hour', now() - interval '50 minutes');

  INSERT INTO memos (id, workspace_id, title, content, visibility, created_by, tags) VALUES
    ('aa222222-aaaa-4aaa-8aaa-aaaaaaaaaaa1'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Week 12 message decision',
     '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Lead paid TV with Cost-of-Living Variant A. Hold Tax Relief mailer until dollar amounts are rewritten. Schedule senior focus group on funding proof."}]}]}'::jsonb,
     'workspace', '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, ARRAY['Hero']),
    ('aa222222-aaaa-4aaa-8aaa-aaaaaaaaaaa2'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Questions for next tracking',
     '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Ask tracking: does a one-line pay-for move Senior Voters 60+ without hurting Suburban Swing?"}]}]}'::jsonb,
     'personal', '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid, ARRAY[]::text[]);

  INSERT INTO agent_conversations (id, workspace_id, title, created_by) VALUES
    ('aa333333-aaaa-4aaa-8aaa-aaaaaaaaaaa1'::uuid, 'a1111111-1111-4111-8111-111111111111'::uuid, 'Suburban Swing reaction to Cost-of-Living spot', '294aaad0-3274-4649-9ba0-bf7929ecd1c8'::uuid);

  INSERT INTO agent_messages (conversation_id, role, body) VALUES
    ('aa333333-aaaa-4aaa-8aaa-aaaaaaaaaaa1'::uuid, 'user', 'Which segment reacted most negatively to the Cost-of-Living spot, and why?'),
    ('aa333333-aaaa-4aaa-8aaa-aaaaaaaaaaa1'::uuid, 'assistant', 'Senior Voters 60+ are the softest segment on the Cost-of-Living spot — about 52% positive versus 84% among Suburban Swing. Their verbatims cluster on funding doubts ("who pays for this plan?") rather than rejecting the kitchen-table frame itself. Recommendation: keep Variant A, add a one-line pay-for, and validate in a senior focus group.');
