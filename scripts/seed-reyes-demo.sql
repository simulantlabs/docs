-- Seed a fictional "Reyes for Senate" docs demo workspace.
-- Safe to re-run: deletes prior docs-demo workspace by slug first.

DO $$
DECLARE
  v_user uuid := '294aaad0-3274-4649-9ba0-bf7929ecd1c8';
  v_ws uuid := 'a1111111-1111-4111-8111-111111111111';
  v_ds_voter uuid := 'a2222222-2222-4222-8222-222222222221';
  v_ds_track uuid := 'a2222222-2222-4222-8222-222222222222';
  v_ds_census uuid := 'a2222222-2222-4222-8222-222222222223';
  v_cohort_swing uuid := 'a3333333-3333-4333-8333-333333333331';
  v_cohort_senior uuid := 'a3333333-3333-4333-8333-333333333332';
  v_cohort_young uuid := 'a3333333-3333-4333-8333-333333333333';
  v_cohort_rural uuid := 'a3333333-3333-4333-8333-333333333334';
  v_cohort_union uuid := 'a3333333-3333-4333-8333-333333333335';
  v_cohort_biz uuid := 'a3333333-3333-4333-8333-333333333336';
  v_creative_tv uuid := 'a4444444-4444-4444-8444-444444444441';
  v_creative_health uuid := 'a4444444-4444-4444-8444-444444444442';
  v_creative_edu uuid := 'a4444444-4444-4444-8444-444444444443';
  v_creative_tax uuid := 'a4444444-4444-4444-8444-444444444444';
  v_creative_close uuid := 'a4444444-4444-4444-8444-444444444445';
  v_flow_col uuid := 'a5555555-5555-4555-8555-555555555551';
  v_flow_health uuid := 'a5555555-5555-4555-8555-555555555552';
  v_flow_edu uuid := 'a5555555-5555-4555-8555-555555555553';
  v_flow_tax uuid := 'a5555555-5555-4555-8555-555555555554';
  v_flow_close uuid := 'a5555555-5555-4555-8555-555555555555';
  v_flow_ballot uuid := 'a5555555-5555-4555-8555-555555555556';
  v_flow_multi uuid := 'a5555555-5555-4555-8555-555555555557';
  v_test_col uuid := 'a6666666-6666-4666-8666-666666666661';
  v_test_health uuid := 'a6666666-6666-4666-8666-666666666662';
  v_test_edu uuid := 'a6666666-6666-4666-8666-666666666663';
  v_test_tax uuid := 'a6666666-6666-4666-8666-666666666664';
  v_test_close uuid := 'a6666666-6666-4666-8666-666666666665';
  v_poll_ballot uuid := 'a6666666-6666-4666-8666-666666666666';
  v_poll_approve uuid := 'a6666666-6666-4666-8666-666666666667';
  v_fg_col uuid := 'a7777777-7777-4777-8777-777777777771';
  v_fg_health uuid := 'a7777777-7777-4777-8777-777777777772';
  v_run_col uuid := 'a8888888-8888-4888-8888-888888888881';
  v_run_health uuid := 'a8888888-8888-4888-8888-888888888882';
  v_run_edu uuid := 'a8888888-8888-4888-8888-888888888883';
  v_run_tax uuid := 'a8888888-8888-4888-8888-888888888884';
  v_run_close uuid := 'a8888888-8888-4888-8888-888888888885';
  v_run_ballot uuid := 'a8888888-8888-4888-8888-888888888886';
  v_run_approve uuid := 'a8888888-8888-4888-8888-888888888887';
  v_run_fg uuid := 'a8888888-8888-4888-8888-888888888888';
  v_flow_run_col uuid := 'a9999999-9999-4999-8999-999999999991';
  v_flow_run_ballot uuid := 'a9999999-9999-4999-8999-999999999992';
  v_flow_run_multi uuid := 'a9999999-9999-4999-8999-999999999993';
  v_report uuid := 'aa111111-aaaa-4aaa-8aaa-aaaaaaaaaaa1';
  v_edition uuid := 'aa111111-aaaa-4aaa-8aaa-aaaaaaaaaaa2';
  v_memo_ws uuid := 'aa222222-aaaa-4aaa-8aaa-aaaaaaaaaaa1';
  v_memo_pers uuid := 'aa222222-aaaa-4aaa-8aaa-aaaaaaaaaaa2';
  v_agent_conv uuid := 'aa333333-aaaa-4aaa-8aaa-aaaaaaaaaaa1';
  v_old uuid;
BEGIN
  -- Tear down prior docs demo if present
  SELECT id INTO v_old FROM workspaces WHERE slug = 'reyes-for-senate';
  IF v_old IS NOT NULL THEN
    DELETE FROM workspaces WHERE id = v_old;
  END IF;
  DELETE FROM workspaces WHERE id = v_ws;

  INSERT INTO workspaces (id, name, slug, monthly_quota)
  VALUES (v_ws, 'Reyes for Senate', 'reyes-for-senate', 200);

  INSERT INTO workspace_members (workspace_id, user_id, role)
  VALUES (v_ws, v_user, 'owner');

  INSERT INTO workspace_tags (workspace_id, name, created_by) VALUES
    (v_ws, 'Hero', v_user),
    (v_ws, 'TV', v_user),
    (v_ws, 'Digital', v_user),
    (v_ws, 'Mailer', v_user),
    (v_ws, 'Ballot', v_user);

  -- Datasets
  INSERT INTO datasets (id, slug, name, kind, owner_type, origin, owner_workspace_id, provider, format, description, tags, region, category, verified, created_by)
  VALUES
    (v_ds_voter, 'reyes-voter-file', 'Voter file', 'Custom', 'workspace', 'uploaded', v_ws, 'upload', 'CSV',
     'Campaign voter file for the Reyes for Senate race — registration, vote history, and modeled partisanship.',
     ARRAY['voter','campaign'], 'US-MI', 'Politics', true, v_user),
    (v_ds_track, 'reyes-q3-tracking', 'Q3 Tracking poll', 'Survey', 'workspace', 'uploaded', v_ws, 'upload', 'CSV',
     'Internal Q3 tracking poll of likely voters in the Detroit metro and suburban swing counties.',
     ARRAY['tracking','poll'], 'US-MI', 'Politics', true, v_user),
    (v_ds_census, 'reyes-acs-mi', 'ACS Michigan extract', 'Census', 'workspace', 'uploaded', v_ws, 'upload', 'CSV',
     'American Community Survey extract for Michigan — demographics, income, and household composition.',
     ARRAY['census','demographics'], 'US-MI', 'Demographics', true, v_user);

  INSERT INTO workspace_datasets (workspace_id, dataset_id, added_by) VALUES
    (v_ws, v_ds_voter, v_user),
    (v_ws, v_ds_track, v_user),
    (v_ws, v_ds_census, v_user);

  -- Cohorts
  INSERT INTO cohorts (
    id, workspace_id, name, description, config, created_by, respondent_count, origin,
    generation_params, research_report, target_spec
  ) VALUES
  (
    v_cohort_swing, v_ws, 'Suburban Swing Voters',
    'Undecided suburban voters in Michigan swing counties, open to either party on cost of living.',
    '{"age":{"min":25,"max":54},"gender":"any","region":"MI","tags":["Cost-of-living anxious","Undecided"]}'::jsonb,
    v_user, 1200, 'synthetic',
    '{"panelSize":1200,"region":"MI","population":"American adults aged 25–54 in suburban Michigan counties — undecided voters open to either party."}'::jsonb,
    '{"text":"### Suburban Swing Voters\\n\\nThis cohort represents undecided suburban adults in Michigan swing counties. Cost of living and healthcare affordability dominate their agenda. They consume local TV and Facebook more than national cable, and they punish candidates who sound partisan before they sound practical.\\n\\n### What moves them\\n\\nConcrete household math — rent, groceries, insurance premiums — outperforms abstract policy frames. Senior Voters 60+ in the same geography are more skeptical of funding claims; Young Voters under 35 respond to education and climate co-benefits."}'::jsonb,
    '{"region":"MI","size":1200}'::jsonb
  ),
  (
    v_cohort_senior, v_ws, 'Senior Voters 60+',
    'Likely voters aged 60+ across Michigan, attentive to Medicare and Social Security.',
    '{"age":{"min":60,"max":90},"gender":"any","region":"MI","tags":["Medicare-focused","High turnout"]}'::jsonb,
    v_user, 800, 'synthetic',
    '{"panelSize":800,"region":"MI"}'::jsonb, NULL, '{"region":"MI","size":800}'::jsonb
  ),
  (
    v_cohort_young, v_ws, 'Young Voters',
    'Urban and college-adjacent voters aged 18–34.',
    '{"age":{"min":18,"max":34},"gender":"any","region":"MI","tags":["Climate-focused","Digital-first"]}'::jsonb,
    v_user, 650, 'synthetic',
    '{"panelSize":650,"region":"MI"}'::jsonb, NULL, '{"region":"MI","size":650}'::jsonb
  ),
  (
    v_cohort_rural, v_ws, 'Rural Independents',
    'Rural and small-town independents outside the Detroit metro.',
    '{"age":{"min":30,"max":70},"gender":"any","region":"MI","tags":["Independent","Rural"]}'::jsonb,
    v_user, 500, 'synthetic',
    '{"panelSize":500,"region":"MI"}'::jsonb, NULL, '{"region":"MI","size":500}'::jsonb
  ),
  (
    v_cohort_union, v_ws, 'Union Households',
    'Union-affiliated households in industrial and service sectors.',
    '{"age":{"min":25,"max":64},"gender":"any","region":"MI","tags":["Union","Working class"]}'::jsonb,
    v_user, 450, 'synthetic',
    '{"panelSize":450,"region":"MI"}'::jsonb, NULL, '{"region":"MI","size":450}'::jsonb
  ),
  (
    v_cohort_biz, v_ws, 'Small Business Owners',
    'Owners of firms under 50 employees across Michigan.',
    '{"age":{"min":30,"max":65},"gender":"any","region":"MI","tags":["Small business","Tax-sensitive"]}'::jsonb,
    v_user, 400, 'synthetic',
    '{"panelSize":400,"region":"MI"}'::jsonb, NULL, '{"region":"MI","size":400}'::jsonb
  );

  INSERT INTO cohort_sources (cohort_id, dataset_id) VALUES
    (v_cohort_swing, v_ds_voter),
    (v_cohort_swing, v_ds_track),
    (v_cohort_swing, v_ds_census),
    (v_cohort_senior, v_ds_voter),
    (v_cohort_senior, v_ds_census),
    (v_cohort_young, v_ds_voter),
    (v_cohort_rural, v_ds_voter),
    (v_cohort_union, v_ds_voter),
    (v_cohort_biz, v_ds_track);

  -- Assets (creatives)
  INSERT INTO creatives (
    id, workspace_id, name, kind, content_type, bytes, description_input, tags, storage_key,
    pipeline_status, analysis_status, description, summary, created_by
  ) VALUES
    (v_creative_tv, v_ws, 'Cost-of-Living — :30 TV Spot A', 'video', 'video/mp4', 12400000,
     'Reyes kitchen-table spot on grocery and rent costs.', ARRAY['TV','Hero'],
     'docs-demo/cost-of-living-a.mp4', 'ready', 'complete',
     'A :30 TV spot featuring Reyes at a kitchen table talking through grocery bills and rent.',
     'Kitchen-table cost-of-living spot with Reyes.', v_user),
    (v_creative_health, v_ws, 'Healthcare Message — Digital Video', 'video', 'video/mp4', 8200000,
     'Digital cut on insulin and premium costs.', ARRAY['Digital'],
     'docs-demo/healthcare-digital.mp4', 'ready', 'analyzing',
     'Digital video on prescription drug costs and insurance premiums.',
     'Healthcare affordability digital cut.', v_user),
    (v_creative_edu, v_ws, 'Education Plan — Social Cutdown', 'image', 'image/png', 420000,
     'Social still for the education plan.', ARRAY['Digital'],
     'docs-demo/education-social.png', 'ready', 'complete',
     'Static social asset summarizing the Reyes education plan.',
     'Education plan social still.', v_user),
    (v_creative_tax, v_ws, 'Tax Relief — Mailer Copy', 'document', 'application/pdf', 180000,
     'Mailer copy for small business tax relief.', ARRAY['Mailer'],
     'docs-demo/tax-relief-mailer.pdf', 'ready', 'complete',
     'Two-page mailer on small business tax relief.',
     'Tax relief mailer copy.', v_user),
    (v_creative_close, v_ws, 'Closing Argument — 30s TV Spot', 'video', 'video/mp4', 11800000,
     'Closing argument TV spot for union households.', ARRAY['TV','Hero'],
     'docs-demo/closing-argument.mp4', 'ready', 'complete',
     'Closing argument spot aimed at union households.',
     'Closing argument TV spot.', v_user);

  -- Simulations (flows)
  INSERT INTO simulation_flows (id, workspace_id, name, description, status, graph, tags, created_by, updated_at) VALUES
  (
    v_flow_col, v_ws, 'Cost-of-Living — :30 TV Spot A/B',
    'A/B test of the kitchen-table cost-of-living spot against Suburban Swing Voters.',
    'done',
    jsonb_build_object(
      'version', 1,
      'nodes', jsonb_build_array(
        jsonb_build_object('id','n-cohort','type','cohort','position',jsonb_build_object('x',120,'y',80),'data',jsonb_build_object('cohortId', v_cohort_swing)),
        jsonb_build_object('id','n-asset','type','asset','position',jsonb_build_object('x',120,'y',260),'data',jsonb_build_object('creativeId', v_creative_tv)),
        jsonb_build_object('id','n-test','type','test','position',jsonb_build_object('x',420,'y',160),'data',jsonb_build_object('recordId', v_test_col)),
        jsonb_build_object('id','n-fg','type','focus-group','position',jsonb_build_object('x',720,'y',160),'data',jsonb_build_object('recordId', v_fg_col))
      ),
      'edges', jsonb_build_array(
        jsonb_build_object('id','e1','source','n-cohort','target','n-test','targetHandle','respondents'),
        jsonb_build_object('id','e2','source','n-asset','target','n-test','targetHandle','asset-0'),
        jsonb_build_object('id','e3','source','n-cohort','target','n-fg','targetHandle','respondents'),
        jsonb_build_object('id','e4','source','n-asset','target','n-fg','targetHandle','asset')
      )
    ),
    ARRAY['Hero','TV'], v_user, now() - interval '2 hours'
  ),
  (
    v_flow_health, v_ws, 'Healthcare Message — Digital Video',
    'Digital healthcare message against Senior Voters 60+.',
    'running',
    jsonb_build_object(
      'version', 1,
      'nodes', jsonb_build_array(
        jsonb_build_object('id','n-cohort','type','cohort','position',jsonb_build_object('x',120,'y',100),'data',jsonb_build_object('cohortId', v_cohort_senior)),
        jsonb_build_object('id','n-test','type','test','position',jsonb_build_object('x',420,'y',100),'data',jsonb_build_object('recordId', v_test_health))
      ),
      'edges', jsonb_build_array(
        jsonb_build_object('id','e1','source','n-cohort','target','n-test','targetHandle','respondents')
      )
    ),
    ARRAY['Digital'], v_user, now() - interval '40 minutes'
  ),
  (
    v_flow_edu, v_ws, 'Education Plan — Social Cutdown',
    'Social cutdown of the education plan with Young Voters.',
    'done',
    jsonb_build_object(
      'version', 1,
      'nodes', jsonb_build_array(
        jsonb_build_object('id','n-cohort','type','cohort','position',jsonb_build_object('x',120,'y',100),'data',jsonb_build_object('cohortId', v_cohort_young)),
        jsonb_build_object('id','n-test','type','test','position',jsonb_build_object('x',420,'y',100),'data',jsonb_build_object('recordId', v_test_edu))
      ),
      'edges', jsonb_build_array(
        jsonb_build_object('id','e1','source','n-cohort','target','n-test','targetHandle','respondents')
      )
    ),
    ARRAY['Digital'], v_user, now() - interval '1 day'
  ),
  (
    v_flow_tax, v_ws, 'Tax Relief — Mailer Copy',
    'Mailer copy test with Small Business Owners.',
    'done',
    jsonb_build_object(
      'version', 1,
      'nodes', jsonb_build_array(
        jsonb_build_object('id','n-cohort','type','cohort','position',jsonb_build_object('x',120,'y',100),'data',jsonb_build_object('cohortId', v_cohort_biz)),
        jsonb_build_object('id','n-test','type','test','position',jsonb_build_object('x',420,'y',100),'data',jsonb_build_object('recordId', v_test_tax))
      ),
      'edges', jsonb_build_array(
        jsonb_build_object('id','e1','source','n-cohort','target','n-test','targetHandle','respondents')
      )
    ),
    ARRAY['Mailer'], v_user, now() - interval '2 days'
  ),
  (
    v_flow_close, v_ws, 'Closing Argument — 30s TV Spot',
    'Closing argument spot with Union Households.',
    'done',
    jsonb_build_object(
      'version', 1,
      'nodes', jsonb_build_array(
        jsonb_build_object('id','n-cohort','type','cohort','position',jsonb_build_object('x',120,'y',100),'data',jsonb_build_object('cohortId', v_cohort_union)),
        jsonb_build_object('id','n-test','type','test','position',jsonb_build_object('x',420,'y',100),'data',jsonb_build_object('recordId', v_test_close))
      ),
      'edges', jsonb_build_array(
        jsonb_build_object('id','e1','source','n-cohort','target','n-test','targetHandle','respondents')
      )
    ),
    ARRAY['TV','Hero'], v_user, now() - interval '3 days'
  ),
  (
    v_flow_ballot, v_ws, 'Ballot test — General',
    'Head-to-head ballot and Reyes favorability among Suburban Swing Voters.',
    'done',
    jsonb_build_object(
      'version', 1,
      'nodes', jsonb_build_array(
        jsonb_build_object('id','n-cohort','type','cohort','position',jsonb_build_object('x',120,'y',100),'data',jsonb_build_object('cohortId', v_cohort_swing)),
        jsonb_build_object('id','n-poll','type','poll','position',jsonb_build_object('x',420,'y',100),'data',jsonb_build_object('recordId', v_poll_ballot))
      ),
      'edges', jsonb_build_array(
        jsonb_build_object('id','e1','source','n-cohort','target','n-poll','targetHandle','respondents')
      )
    ),
    ARRAY['Ballot'], v_user, now() - interval '5 hours'
  ),
  (
    v_flow_multi, v_ws, 'Message package — Week 12',
    'Multi-step package: approval poll, cost-of-living test, and voter focus group.',
    'draft',
    jsonb_build_object(
      'version', 1,
      'nodes', jsonb_build_array(
        jsonb_build_object('id','n-cohort','type','cohort','position',jsonb_build_object('x',80,'y',160),'data',jsonb_build_object('cohortId', v_cohort_swing)),
        jsonb_build_object('id','n-poll','type','poll','position',jsonb_build_object('x',380,'y',40),'data',jsonb_build_object('recordId', v_poll_approve)),
        jsonb_build_object('id','n-test','type','test','position',jsonb_build_object('x',380,'y',200),'data',jsonb_build_object('recordId', v_test_col)),
        jsonb_build_object('id','n-fg','type','focus-group','position',jsonb_build_object('x',380,'y',360),'data',jsonb_build_object('recordId', v_fg_health)),
        jsonb_build_object('id','n-asset','type','asset','position',jsonb_build_object('x',80,'y',320),'data',jsonb_build_object('creativeId', v_creative_tv))
      ),
      'edges', jsonb_build_array(
        jsonb_build_object('id','e1','source','n-cohort','target','n-poll','targetHandle','respondents'),
        jsonb_build_object('id','e2','source','n-cohort','target','n-test','targetHandle','respondents'),
        jsonb_build_object('id','e3','source','n-cohort','target','n-fg','targetHandle','respondents'),
        jsonb_build_object('id','e4','source','n-asset','target','n-test','targetHandle','asset-0')
      )
    ),
    ARRAY['Hero'], v_user, now() - interval '8 hours'
  );

  -- Tests / polls
  INSERT INTO tests (id, workspace_id, name, description, status, config, cohort_id, created_by, sentiment, recall, intent, clarity, progress, creative_id, run_type, tags, flow_id, latest_run_id) VALUES
  (
    v_test_col, v_ws, 'Cost-of-Living — :30 TV Spot A/B',
    'Hypothesis: Variant A (kitchen table) outperforms Variant B (town hall) with Suburban Swing on sentiment and intent.',
    'done',
    '{"format":"Video","hypothesis":"Kitchen-table framing beats town-hall framing with suburban swing voters.","variants":[{"label":"A","name":"Kitchen table"},{"label":"B","name":"Town hall"}],"metrics":["Recall","Sentiment","Purchase intent","Clarity"],"questions":[{"id":1,"text":"What stood out to you about this ad?","type":"Open-ended"},{"id":2,"text":"How clear was the main message?","type":"Rating 1–5"}],"sampleSize":400,"controlBaseline":true,"context":{"mode":"Current"}}'::jsonb,
    v_cohort_swing, v_user, 78, 71, 64, 82, 100, v_creative_tv, 'test', ARRAY['Hero','TV'], v_flow_col, v_run_col
  ),
  (
    v_test_health, v_ws, 'Healthcare Message — Digital Video',
    'Hypothesis: Insulin framing lifts senior sentiment vs premium framing.',
    'running',
    '{"format":"Video","hypothesis":"Insulin framing lifts senior sentiment.","variants":[{"label":"A","name":"Insulin"}],"metrics":["Recall","Sentiment","Clarity"],"sampleSize":300,"controlBaseline":true,"context":{"mode":"Current"}}'::jsonb,
    v_cohort_senior, v_user, NULL, NULL, NULL, NULL, 42, v_creative_health, 'test', ARRAY['Digital'], v_flow_health, NULL
  ),
  (
    v_test_edu, v_ws, 'Education Plan — Social Cutdown',
    'Hypothesis: Debt-relief frame outperforms classroom frame with Young Voters.',
    'done',
    '{"format":"Image","hypothesis":"Debt-relief frame wins with Young Voters.","variants":[{"label":"A","name":"Debt relief"}],"metrics":["Recall","Sentiment","Intent","Clarity"],"sampleSize":350,"controlBaseline":false,"context":{"mode":"Neutral"}}'::jsonb,
    v_cohort_young, v_user, 64, 58, 61, 70, 100, v_creative_edu, 'test', ARRAY['Digital'], v_flow_edu, v_run_edu
  ),
  (
    v_test_tax, v_ws, 'Tax Relief — Mailer Copy',
    'Hypothesis: Specific dollar amounts beat abstract relief language with small business owners.',
    'done',
    '{"format":"Messaging","hypothesis":"Dollar amounts beat abstract relief.","variants":[{"label":"A","name":"Dollar amounts"}],"metrics":["Recall","Sentiment","Intent","Clarity"],"sampleSize":280,"controlBaseline":true,"context":{"mode":"Neutral"}}'::jsonb,
    v_cohort_biz, v_user, 41, 52, 38, 55, 100, v_creative_tax, 'test', ARRAY['Mailer'], v_flow_tax, v_run_tax
  ),
  (
    v_test_close, v_ws, 'Closing Argument — 30s TV Spot',
    'Hypothesis: Union-household closing argument clears 75 sentiment.',
    'done',
    '{"format":"Video","hypothesis":"Union closing argument clears 75 sentiment.","variants":[{"label":"A","name":"Closing"}],"metrics":["Recall","Sentiment","Intent","Clarity"],"sampleSize":400,"controlBaseline":true,"context":{"mode":"Current"}}'::jsonb,
    v_cohort_union, v_user, 81, 76, 72, 84, 100, v_creative_close, 'test', ARRAY['TV','Hero'], v_flow_close, v_run_close
  ),
  (
    v_poll_ballot, v_ws, 'Ballot test — General',
    'Hypothesis: Reyes leads by mid-single digits among suburban swing.',
    'done',
    '{"context":{"mode":"Current"},"questions":[{"id":1,"text":"If the election for U.S. Senate were held today, who would you vote for?","type":"Single choice","options":["Maya Reyes","Jordan Hale","Undecided"]},{"id":2,"text":"Do you have a favorable or unfavorable opinion of Maya Reyes?","type":"Single choice","options":["Favorable","Unfavorable","No opinion"]}],"sampleSize":500,"controlBaseline":false}'::jsonb,
    v_cohort_swing, v_user, NULL, NULL, NULL, NULL, 100, NULL, 'poll', ARRAY['Ballot'], v_flow_ballot, v_run_ballot
  ),
  (
    v_poll_approve, v_ws, 'Reyes favorability pulse',
    'Weekly favorability pulse.',
    'draft',
    '{"context":{"mode":"Current"},"questions":[{"id":1,"text":"Do you approve of Maya Reyes''s campaign so far?","type":"Yes / No","options":["Yes","No"]}],"sampleSize":400,"controlBaseline":false}'::jsonb,
    v_cohort_swing, v_user, NULL, NULL, NULL, NULL, 0, NULL, 'poll', ARRAY['Ballot'], v_flow_multi, NULL
  );

  -- Focus groups
  INSERT INTO focus_groups (id, workspace_id, name, description, config, created_by, status, sentiment, cohort_id, tags, flow_id, latest_run_id) VALUES
  (
    v_fg_col, v_ws, 'Suburban Swing — Cost-of-Living room',
    'Watch Suburban Swing Voters deliberate on the cost-of-living spot.',
    '{"objective":"Understand why Variant A resonates and where funding doubts surface.","moderator":"ai","style":"probing","prompts":["What felt true about this ad?","What felt missing or unbelievable?","Would this change how you vote?"],"length":"45 min","dynamics":{"crosstalk":true,"dissent":true,"anonymous":false,"summary":true}}'::jsonb,
    v_user, 'done', 72, v_cohort_swing, ARRAY['Hero'], v_flow_col, v_run_fg
  ),
  (
    v_fg_health, v_ws, 'Senior Voters — Healthcare room',
    'Seniors react to the healthcare digital cut.',
    '{"objective":"Surface funding and trust objections.","moderator":"ai","style":"probing","prompts":["What did you hear about healthcare costs?","Do you trust this candidate on Medicare?"],"length":"45 min","dynamics":{"crosstalk":true,"dissent":true,"anonymous":false,"summary":true}}'::jsonb,
    v_user, 'draft', NULL, v_cohort_senior, ARRAY['Digital'], v_flow_multi, NULL
  );

  -- Test runs with mock results
  INSERT INTO test_runs (
    id, test_id, workspace_id, cohort_id, status, progress, respondent_count,
    metrics, segments, verbatims, results, created_by, created_at, finished_at,
    scoring_mode, run_type, engine_version
  ) VALUES
  -- engine_version must be 'legacy' or 'simulation_engine_v1'
  (
    v_run_col, v_test_col, v_ws, v_cohort_swing, 'done', 100, 400,
    '{"recall":{"score":71,"vsControl":8},"sentiment":{"score":78,"vsControl":12},"intent":{"score":64,"vsControl":9},"clarity":{"score":82,"vsControl":6},"benchmark":70}'::jsonb,
    '[{"name":"Suburban Swing","positive":84,"neutral":10,"negative":6,"lift":14},{"name":"Senior Voters 60+","positive":52,"neutral":22,"negative":26,"lift":-3},{"name":"Young Voters","positive":71,"neutral":18,"negative":11,"lift":8}]'::jsonb,
    '[{"quote":"Finally someone talking about my grocery bill like it is real money.","tone":"positive","segment":"Suburban Swing"},{"quote":"I like the kitchen table, but who pays for this plan?","tone":"neutral","segment":"Senior Voters 60+"},{"quote":"Town hall version felt like every other politician.","tone":"negative","segment":"Suburban Swing"},{"quote":"She sounds like she has actually paid rent recently.","tone":"positive","segment":"Young Voters"}]'::jsonb,
    '{"kind":"test","themes":[{"title":"Cost-of-living resonance","count":48,"summary":"Kitchen-table framing lands as authentic and specific."},{"title":"Doubts about funding","count":31,"summary":"Seniors and rural independents ask how the plan is paid for."},{"title":"Town hall fatigue","count":22,"summary":"Variant B reads as generic political speech."}],"recommendations":["Lead with Variant A in paid TV.","Add a one-line funding proof for seniors.","Hold Variant B for earned media only."]}'::jsonb,
    v_user, now() - interval '3 hours', now() - interval '2 hours', 'persona', 'test', 'legacy'
  ),
  (
    v_run_edu, v_test_edu, v_ws, v_cohort_young, 'done', 100, 350,
    '{"recall":{"score":58},"sentiment":{"score":64},"intent":{"score":61},"clarity":{"score":70},"benchmark":65}'::jsonb,
    '[{"name":"Young Voters","positive":68,"neutral":20,"negative":12},{"name":"Urban","positive":72,"neutral":18,"negative":10}]'::jsonb,
    '[{"quote":"Debt relief is the only line that felt like it was for me.","tone":"positive","segment":"Young Voters"}]'::jsonb,
    '{"kind":"test","themes":[{"title":"Debt relief salience","count":40,"summary":"Student debt frame outperforms classroom imagery."}],"recommendations":["Keep debt relief as the hero line on social."]}'::jsonb,
    v_user, now() - interval '1 day', now() - interval '23 hours', 'persona', 'test', 'legacy'
  ),
  (
    v_run_tax, v_test_tax, v_ws, v_cohort_biz, 'done', 100, 280,
    '{"recall":{"score":52,"vsControl":2},"sentiment":{"score":41,"vsControl":-4},"intent":{"score":38,"vsControl":-6},"clarity":{"score":55,"vsControl":1},"benchmark":60}'::jsonb,
    '[{"name":"Small Business Owners","positive":34,"neutral":28,"negative":38,"lift":-5}]'::jsonb,
    '[{"quote":"Sounds nice until I ask what it does to my quarterly estimate.","tone":"negative","segment":"Small Business Owners"}]'::jsonb,
    '{"kind":"test","themes":[{"title":"Skepticism on specifics","count":36,"summary":"Owners want numbers, not slogans."}],"recommendations":["Rewrite with concrete dollar examples.","Needs review before mail drop."]}'::jsonb,
    v_user, now() - interval '2 days', now() - interval '2 days', 'persona', 'test', 'legacy'
  ),
  (
    v_run_close, v_test_close, v_ws, v_cohort_union, 'done', 100, 400,
    '{"recall":{"score":76,"vsControl":11},"sentiment":{"score":81,"vsControl":15},"intent":{"score":72,"vsControl":10},"clarity":{"score":84,"vsControl":7},"benchmark":70}'::jsonb,
    '[{"name":"Union Households","positive":86,"neutral":9,"negative":5,"lift":16}]'::jsonb,
    '[{"quote":"This one actually sounded like it was written for people who punch a clock.","tone":"positive","segment":"Union Households"}]'::jsonb,
    '{"kind":"test","themes":[{"title":"Worker identity fit","count":52,"summary":"Union households feel seen."}],"recommendations":["Heavy-up closing argument in union DMA buys."]}'::jsonb,
    v_user, now() - interval '3 days', now() - interval '3 days', 'persona', 'test', 'legacy'
  ),
  (
    v_run_ballot, v_poll_ballot, v_ws, v_cohort_swing, 'done', 100, 500,
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
    v_user, now() - interval '6 hours', now() - interval '5 hours', 'persona', 'poll', 'legacy'
  ),
  (
    v_run_health, v_test_health, v_ws, v_cohort_senior, 'running', 42, 126,
    '{}'::jsonb, '[]'::jsonb, '[]'::jsonb, '{}'::jsonb,
    v_user, now() - interval '40 minutes', NULL, 'persona', 'test', 'legacy'
  );

  -- Focus group run
  INSERT INTO focus_group_runs (
    id, focus_group_id, workspace_id, cohort_id, status, transcript, themes, sentiment,
    participant_count, duration_minutes, created_by, created_at, finished_at
  ) VALUES (
    v_run_fg, v_fg_col, v_ws, v_cohort_swing, 'done',
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
    72, 6, 45, v_user, now() - interval '3 hours', now() - interval '2 hours'
  );

  UPDATE focus_groups SET latest_run_id = v_run_fg WHERE id = v_fg_col;
  UPDATE tests SET latest_run_id = v_run_col WHERE id = v_test_col;
  UPDATE tests SET latest_run_id = v_run_edu WHERE id = v_test_edu;
  UPDATE tests SET latest_run_id = v_run_tax WHERE id = v_test_tax;
  UPDATE tests SET latest_run_id = v_run_close WHERE id = v_test_close;
  UPDATE tests SET latest_run_id = v_run_ballot WHERE id = v_poll_ballot;

  -- Flow runs
  INSERT INTO flow_runs (id, flow_id, workspace_id, trigger, status, created_by, created_at, finished_at) VALUES
    (v_flow_run_col, v_flow_col, v_ws, 'manual', 'done', v_user, now() - interval '3 hours', now() - interval '2 hours'),
    (v_flow_run_ballot, v_flow_ballot, v_ws, 'manual', 'done', v_user, now() - interval '6 hours', now() - interval '5 hours'),
    (v_flow_run_multi, v_flow_health, v_ws, 'manual', 'running', v_user, now() - interval '40 minutes', NULL);

  INSERT INTO flow_node_runs (flow_run_id, workspace_id, node_id, node_type, status, output, test_run_id, focus_group_run_id, created_at, finished_at) VALUES
    (v_flow_run_col, v_ws, 'n-test', 'test', 'done', '{}'::jsonb, v_run_col, NULL, now() - interval '3 hours', now() - interval '2 hours'),
    (v_flow_run_col, v_ws, 'n-fg', 'focus-group', 'done', '{}'::jsonb, NULL, v_run_fg, now() - interval '3 hours', now() - interval '2 hours'),
    (v_flow_run_ballot, v_ws, 'n-poll', 'poll', 'done', '{}'::jsonb, v_run_ballot, NULL, now() - interval '6 hours', now() - interval '5 hours'),
    (v_flow_run_multi, v_ws, 'n-test', 'test', 'running', '{}'::jsonb, v_run_health, NULL, now() - interval '40 minutes', NULL);

  UPDATE simulation_flows SET latest_run_id = v_flow_run_col, status = 'done' WHERE id = v_flow_col;
  UPDATE simulation_flows SET latest_run_id = v_flow_run_ballot, status = 'done' WHERE id = v_flow_ballot;
  UPDATE simulation_flows SET latest_run_id = v_flow_run_multi, status = 'running' WHERE id = v_flow_health;
  UPDATE simulation_flows SET status = 'done' WHERE id IN (v_flow_edu, v_flow_tax, v_flow_close);
  UPDATE simulation_flows SET status = 'draft' WHERE id = v_flow_multi;

  -- Reports
  INSERT INTO reports (id, workspace_id, name, description, time_window, preset, sections, created_by) VALUES
    (v_report, v_ws, 'Morning brief', 'Daily readout across Reyes message tests.', '24h', 'morning-brief',
     '{"metrics":true,"takeaways":true,"sentiment":true,"topTests":true,"verbatims":true}'::jsonb, v_user);

  INSERT INTO report_editions (id, report_id, workspace_id, status, content, created_by, created_at, finished_at) VALUES
    (v_edition, v_report, v_ws, 'done',
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
     v_user, now() - interval '1 hour', now() - interval '50 minutes');

  -- Memos
  INSERT INTO memos (id, workspace_id, title, content, visibility, created_by, tags) VALUES
    (v_memo_ws, v_ws, 'Week 12 message decision',
     '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Lead paid TV with Cost-of-Living Variant A. Hold Tax Relief mailer until dollar amounts are rewritten. Schedule senior focus group on funding proof."}]}]}'::jsonb,
     'workspace', v_user, ARRAY['Hero']),
    (v_memo_pers, v_ws, 'Questions for next tracking',
     '{"type":"doc","content":[{"type":"paragraph","content":[{"type":"text","text":"Ask tracking: does a one-line pay-for move Senior Voters 60+ without hurting Suburban Swing?"}]}]}'::jsonb,
     'personal', v_user, ARRAY[]::text[]);

  -- Agent conversation
  INSERT INTO agent_conversations (id, workspace_id, title, created_by) VALUES
    (v_agent_conv, v_ws, 'Suburban Swing reaction to Cost-of-Living spot', v_user);

  INSERT INTO agent_messages (conversation_id, role, body) VALUES
    (v_agent_conv, 'user', 'Which segment reacted most negatively to the Cost-of-Living spot, and why?'),
    (v_agent_conv, 'agent', 'Senior Voters 60+ are the softest segment on the Cost-of-Living spot — about 52% positive versus 84% among Suburban Swing. Their verbatims cluster on funding doubts ("who pays for this plan?") rather than rejecting the kitchen-table frame itself. Recommendation: keep Variant A, add a one-line pay-for, and validate in a senior focus group.');

END $$;
