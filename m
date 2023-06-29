Return-Path: <netdev+bounces-14536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02E274244C
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 12:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BABA280D90
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 10:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD4116408;
	Thu, 29 Jun 2023 10:46:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF5A168AF
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 10:46:17 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E7C1BE8
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:46:14 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-635f1c7412cso4990376d6.0
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688035573; x=1690627573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcQ4N+ZleoInMJqaZX/mqbgyL0lzix0GunMwVaxXcs4=;
        b=rWw03JqUAR3Sv+nfUDpa0cIAyYaxsnZOFqIFbaTvM31QKEijj19FAAseQCIl1LULjB
         gU21lJMgQQl9Nl+Ykc5dGulnTKkXRUhbpaN3lOZJwfFavmkmSO2yc9lPpPCePMcMYwf9
         1nfIq4eO0yLW0blsueqvukIMpzwPqOYpWhvlYB3xYMwDM0qLkSSLzw6j1rh8QbM7ONB1
         JCU/wAYsT0+mNApD2gCCsEPXgFMcHxDl82wvUCzc6gBRebzc3I1aqI74THBUoIOn6b0Q
         kh0aCU40bAi4W3hbCC8QFsiOjUQ6/Uqpp1PtLg5alb6w+fyzil6I3j/c36D53HxoXLQq
         rBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688035573; x=1690627573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcQ4N+ZleoInMJqaZX/mqbgyL0lzix0GunMwVaxXcs4=;
        b=hqFHPUZVBhSP44gFD3xuYaTTr0ACU1yJ4aWTNzCL0CP8j3gc+J+xPHL4+qKn+QZbvL
         u9F7P8uUY8Y9I3wGMducbk61hh0ADwVZhlY6Sf91BgfHW1rkIwbfb/JmdYfkjdgqS4ND
         oEmaouGeDG8qxVSzT3LHKj+unt9dvOiMNz5J6eNUck8/rNo4kths8tKuXNjKa0WnnFqc
         4sHXmZd2Z1F+10R38khVPl0ABl2QP6mmDuMCI79H09EhF6BFmvrX1vnCEinvnSKaObwY
         cu725cmd3QMAlXo2u1gg2zs2ujVyOxSTNtF1BgpsLB7UuQ6w59exrHSULrnZ+9PEqajq
         lssQ==
X-Gm-Message-State: AC+VfDxm5Jj7XMIEeDedNVUG1mwknhlTW9nc9N4ROTjjvNVL37hnRudA
	EOhv6a+3Yv1NlKitxcU1192DhnCEkBgt3nrr8ig=
X-Google-Smtp-Source: ACHHUZ63gOb+wCh1cYjDY139g39jOOR7AxDXJIkg9hIU1UGyokw8mPyMlc6YFYo3KFRWg6RSFpMwgw==
X-Received: by 2002:a05:6214:2b0f:b0:634:7c34:6c6a with SMTP id jx15-20020a0562142b0f00b006347c346c6amr20319744qvb.5.1688035572692;
        Thu, 29 Jun 2023 03:46:12 -0700 (PDT)
Received: from majuu.waya (bras-base-oshwon9577w-grc-12-142-114-148-137.dsl.bell.ca. [142.114.148.137])
        by smtp.gmail.com with ESMTPSA id o9-20020a056214180900b006362d4eeb6esm538453qvw.144.2023.06.29.03.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 03:46:12 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	Vipin.Jain@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	simon.horman@corigine.com,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com,
	kernel@mojatatu.com,
	john.andy.fingerhut@intel.com
Subject: [PATCH RFC v3 net-next 17/21] selftests: tc-testing: add P4TC pipeline control path tdc tests
Date: Thu, 29 Jun 2023 06:45:34 -0400
Message-Id: <20230629104538.40863-18-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629104538.40863-1-jhs@mojatatu.com>
References: <20230629104538.40863-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Introduce first tdc tests for P4TC pipeline, which are focused on the
control path. We test pipeline create, update, delete and dump.

Here is a basic description of what we test for each operation:

Create:
    - Create valid pipeline
    - Try to create pipeline without specifying mandatory arguments
    - Create pipeline without specifying optional arguments and check
      optional values after creation
    - Try to create pipeline passing invalid values for numttypes
    - Try to create pipeline passing invalid values for maxrules
    - Try to create pipeline with same name twice
    - Try to create pipeline with same id twice
    - Create pipeline with pipeline id == INX_MAX (2147483647) and check
      for overflow warning when traversing pipeline IDR
    - Create pipeline with name length > PIPELINENAMSIZ

Update:
    - Update pipeline with valid values for numttypes, maxrules,
      preactions and postactions
    - Try to update pipeline with invalid values for maxrules and numttypes
    - Try to seal pipeline which is not ready
    - Check action bind and ref values after pipeline preaction update
    - Check action bind and ref values after pipeline postaction update

Delete:
    - Delete pipeline by name
    - Delete pipeline by id
    - Delete inexistent pipeline by name
    - Delete inexistent pipeline by id
    - Try to flush pipelines
    - Check action bind and ref values after pipeline deletion

Dump:
    - Dump pipeline IDR
    - Dump pipeline IDR when amount of pipelines > P4TC_MAXMSG_COUNT (16)

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../tc-testing/tc-tests/p4tc/pipeline.json    | 3212 +++++++++++++++++
 1 file changed, 3212 insertions(+)
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/p4tc/pipeline.json

diff --git a/tools/testing/selftests/tc-testing/tc-tests/p4tc/pipeline.json b/tools/testing/selftests/tc-testing/tc-tests/p4tc/pipeline.json
new file mode 100644
index 000000000..7b97d375b
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/tc-tests/p4tc/pipeline.json
@@ -0,0 +1,3212 @@
+[
+    {
+        "id": "2c2f",
+        "name": "Create valid pipeline",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0,
+                1,
+                255
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 2 preactions action gact index 1 postactions action gact index 2",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22,
+                "obj": "pipeline"
+            },
+            {
+                "templates": [
+                    {
+                        "pmaxrules": 1,
+                        "pnumtables": 2,
+                        "pstate": "not ready",
+                        "preactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "index": 1,
+                                    "ref": 2,
+                                    "bind": 1,
+                                    "control_action": {
+                                        "type": "pass"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    }
+                                }
+                            ]
+                        },
+                        "postactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "control_action": {
+                                        "type": "drop"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    },
+                                    "index": 2,
+                                    "ref": 2,
+                                    "bind": 1
+                                }
+                            ]
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "8a18",
+        "name": "Try to create pipeline without name",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0,
+                1,
+                255
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create pipeline/ pipeid 22 maxrules 1 numtables 2 preactions action gact index 1 postactions action gact index 2",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchPattern": "Error: Pipeline name not found.*",
+        "teardown": [
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "c0dc",
+        "name": "Create pipeline without preactions",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0,
+                1,
+                255
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 2 postactions action gact index 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22,
+                "obj": "pipeline"
+            },
+            {
+                "templates": [
+                    {
+                        "pmaxrules": 1,
+                        "pnumtables": 2,
+                        "pstate": "not ready",
+                        "postactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "control_action": {
+                                        "type": "pass"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    },
+                                    "index": 1,
+                                    "ref": 2,
+                                    "bind": 1
+                                }
+                            ]
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "248b",
+        "name": "Create pipeline without postactions",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0,
+                1,
+                255
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 2 preactions action gact index 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22,
+                "obj": "pipeline"
+            },
+            {
+                "templates": [
+                    {
+                        "pmaxrules": 1,
+                        "pnumtables": 2,
+                        "pstate": "not ready",
+                        "preactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "index": 1,
+                                    "ref": 2,
+                                    "bind": 1,
+                                    "control_action": {
+                                        "type": "pass"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    }
+                                }
+                            ]
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "0573",
+        "name": "Create pipeline without maxrules",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0,
+                1,
+                255
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create pipeline/ptables pipeid 1 numtables 2 preactions action gact index 1 postactions action gact index 2",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 1,
+                "obj": "pipeline"
+            },
+            {
+                "templates": [
+                    {
+                        "pmaxrules": 1,
+                        "pnumtables": 2,
+                        "pstate": "not ready",
+                        "preactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "index": 1,
+                                    "ref": 2,
+                                    "bind": 1,
+                                    "control_action": {
+                                        "type": "pass"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    }
+                                }
+                            ]
+                        },
+                        "postactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "control_action": {
+                                        "type": "drop"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    },
+                                    "index": 2,
+                                    "ref": 2,
+                                    "bind": 1
+                                }
+                            ]
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "b103",
+        "name": "Create pipeline without numtables",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 preactions action gact index 1 postactions action gact index 2",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22,
+                "obj": "pipeline"
+            },
+            {
+                "templates": [
+                    {
+                        "pmaxrules": 1,
+                        "pnumtables": 0,
+                        "pstate": "not ready",
+                        "preactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "index": 1,
+                                    "ref": 2,
+                                    "bind": 1,
+                                    "control_action": {
+                                        "type": "pass"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    }
+                                }
+                            ]
+                        },
+                        "postactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "control_action": {
+                                        "type": "drop"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    },
+                                    "index": 2,
+                                    "ref": 2,
+                                    "bind": 1
+                                }
+                            ]
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "ceff",
+        "name": "Create pipeline with numtables = 0",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create pipeline/ptables pipeid 22 numtables 0 maxrules 1 preactions action gact index 1 postactions action gact index 2",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22,
+                "obj": "pipeline"
+            },
+            {
+                "templates": [
+                    {
+                        "pmaxrules": 1,
+                        "pnumtables": 0,
+                        "pstate": "not ready",
+                        "preactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "index": 1,
+                                    "ref": 2,
+                                    "bind": 1,
+                                    "control_action": {
+                                        "type": "pass"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    }
+                                }
+                            ]
+                        },
+                        "postactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "control_action": {
+                                        "type": "drop"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    },
+                                    "index": 2,
+                                    "ref": 2,
+                                    "bind": 1
+                                }
+                            ]
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "7a5a",
+        "name": "Try to create pipeline with numtables > 32",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create pipeline/ptables pipeid 22 numtables 33 maxrules 1 preactions action gact index 1 postactions action gact index 2",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchPattern": "Error: Pipeline name not found.*",
+        "teardown": [
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "5dd2",
+        "name": "Create pipeline with numtables = 32",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create pipeline/ptables pipeid 1 numtables 32 maxrules 1 preactions action gact index 1 postactions action gact index 2",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 1,
+                "obj": "pipeline"
+            },
+            {
+                "templates": [
+                    {
+                        "pmaxrules": 1,
+                        "pnumtables": 32,
+                        "pstate": "not ready",
+                        "preactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "index": 1,
+                                    "ref": 2,
+                                    "bind": 1,
+                                    "control_action": {
+                                        "type": "pass"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    }
+                                }
+                            ]
+                        },
+                        "postactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "control_action": {
+                                        "type": "drop"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    },
+                                    "index": 2,
+                                    "ref": 2,
+                                    "bind": 1
+                                }
+                            ]
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "4011",
+        "name": "Try to create pipeline with maxrules = 0",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create pipeline/ptables pipeid 22 maxrules 0 preactions action gact index 1 postactions action gact index 2",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchPattern": "Error: Pipeline name not found.*",
+        "teardown": [
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "b97a",
+        "name": "Try to create pipeline with maxrules > 512",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create pipeline/ptables pipeid 22 maxrules 513 preactions action gact index 1 postactions action gact index 2",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchPattern": "Error: Pipeline name not found.*",
+        "teardown": [
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "571e",
+        "name": "Create pipeline with numtables = 256",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create pipeline/ptables pipeid 1 numtables 2 maxrules 256 preactions action gact index 1 postactions action gact index 2",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 1,
+                "obj": "pipeline"
+            },
+            {
+                "templates": [
+                    {
+                        "pmaxrules": 256,
+                        "pnumtables": 2,
+                        "pstate": "not ready",
+                        "preactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "index": 1,
+                                    "ref": 2,
+                                    "bind": 1,
+                                    "control_action": {
+                                        "type": "pass"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    }
+                                }
+                            ]
+                        },
+                        "postactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "control_action": {
+                                        "type": "drop"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    },
+                                    "index": 2,
+                                    "ref": 2,
+                                    "bind": 1
+                                }
+                            ]
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "f6f8",
+        "name": "Try to create pipeline with same name twice",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 preactions action gact index 1 postactions action gact index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create pipeline/ptables pipeid 22 numtables 4 maxrules 2 preactions action gact index 1 postactions action gact index 2",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22,
+                "obj": "pipeline"
+            },
+            {
+                "templates": [
+                    {
+                        "pmaxrules": 1,
+                        "pnumtables": 0,
+                        "pstate": "not ready",
+                        "preactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "index": 1,
+                                    "ref": 2,
+                                    "bind": 1,
+                                    "control_action": {
+                                        "type": "pass"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    }
+                                }
+                            ]
+                        },
+                        "postactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "control_action": {
+                                        "type": "drop"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    },
+                                    "index": 2,
+                                    "ref": 2,
+                                    "bind": 1
+                                }
+                            ]
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "8e88",
+        "name": "Update numtables in existing pipeline",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update pipeline/ptables numtables 4",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 1,
+                "obj": "pipeline"
+            },
+            {
+                "templates": [
+                    {
+                        "pmaxrules": 1,
+                        "pnumtables": 4,
+                        "pstate": "not ready",
+                        "preactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "index": 1,
+                                    "ref": 2,
+                                    "bind": 1,
+                                    "control_action": {
+                                        "type": "pass"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    }
+                                }
+                            ]
+                        },
+                        "postactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "control_action": {
+                                        "type": "drop"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    },
+                                    "index": 2,
+                                    "ref": 2,
+                                    "bind": 1
+                                }
+                            ]
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "b5fe",
+        "name": "Update maxrules in existing pipeline",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update pipeline/ pipeid 1 maxrules 2",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get pipeline/ pipeid 1",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 1,
+                "obj": "pipeline"
+            },
+            {
+                "templates": [
+                    {
+                        "pmaxrules": 2,
+                        "pnumtables": 0,
+                        "pstate": "not ready",
+                        "preactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "index": 1,
+                                    "ref": 2,
+                                    "bind": 1,
+                                    "control_action": {
+                                        "type": "pass"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    }
+                                }
+                            ]
+                        },
+                        "postactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "control_action": {
+                                        "type": "drop"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    },
+                                    "index": 2,
+                                    "ref": 2,
+                                    "bind": 1
+                                }
+                            ]
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "1120",
+        "name": "Update preactions in existing pipeline",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ],
+            [
+                "$TC actions add action pass index 3",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update pipeline/ pipeid 1 preactions action gact index 3",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 1,
+                "obj": "pipeline"
+            },
+            {
+                "templates": [
+                    {
+                        "pmaxrules": 1,
+                        "pnumtables": 0,
+                        "pstate": "not ready",
+                        "preactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "index": 3,
+                                    "ref": 2,
+                                    "bind": 1,
+                                    "control_action": {
+                                        "type": "pass"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    }
+                                }
+                            ]
+                        },
+                        "postactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "control_action": {
+                                        "type": "drop"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    },
+                                    "index": 2,
+                                    "ref": 2,
+                                    "bind": 1
+                                }
+                            ]
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "4bd9",
+        "name": "Update postactions in existing pipeline",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ],
+            [
+                "$TC actions add action pass index 3",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update pipeline/ pipeid 1 postactions action gact index 3",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 1,
+                "obj": "pipeline"
+            },
+            {
+                "templates": [
+                    {
+                        "pmaxrules": 1,
+                        "pnumtables": 0,
+                        "pstate": "not ready",
+                        "preactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "index": 1,
+                                    "ref": 2,
+                                    "bind": 1,
+                                    "control_action": {
+                                        "type": "pass"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    }
+                                }
+                            ]
+                        },
+                        "postactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "control_action": {
+                                        "type": "pass"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    },
+                                    "index": 3,
+                                    "ref": 2,
+                                    "bind": 1
+                                }
+                            ]
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "e08b",
+        "name": "Update maxrules and numtables in existing pipeline",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update pipeline/ptables maxrules 2 numtables 4",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 1,
+                "obj": "pipeline"
+            },
+            {
+                "templates": [
+                    {
+                        "pmaxrules": 2,
+                        "pnumtables": 4,
+                        "pstate": "not ready",
+                        "preactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "index": 1,
+                                    "ref": 2,
+                                    "bind": 1,
+                                    "control_action": {
+                                        "type": "pass"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    }
+                                }
+                            ]
+                        },
+                        "postactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "control_action": {
+                                        "type": "drop"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    },
+                                    "index": 2,
+                                    "ref": 2,
+                                    "bind": 1
+                                }
+                            ]
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "bc01",
+        "name": "Update maxrules and preactions in existing pipeline",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ],
+            [
+                "$TC actions add action pass index 3",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update pipeline/ptables maxrules 2 preactions action gact index 3",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 1,
+                "obj": "pipeline"
+            },
+            {
+                "templates": [
+                    {
+                        "pmaxrules": 2,
+                        "pnumtables": 0,
+                        "pstate": "not ready",
+                        "preactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "index": 3,
+                                    "ref": 2,
+                                    "bind": 1,
+                                    "control_action": {
+                                        "type": "pass"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    }
+                                }
+                            ]
+                        },
+                        "postactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "control_action": {
+                                        "type": "drop"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    },
+                                    "index": 2,
+                                    "ref": 2,
+                                    "bind": 1
+                                }
+                            ]
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "2cea",
+        "name": "Try to update maxrules with 0",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update pipeline/ pipeid 1 maxrules 0",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 1,
+                "obj": "pipeline"
+            },
+            {
+                "templates": [
+                    {
+                        "pmaxrules": 1,
+                        "pnumtables": 0,
+                        "pstate": "not ready",
+                        "preactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "index": 1,
+                                    "ref": 2,
+                                    "bind": 1,
+                                    "control_action": {
+                                        "type": "pass"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    }
+                                }
+                            ]
+                        },
+                        "postactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "control_action": {
+                                        "type": "drop"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    },
+                                    "index": 2,
+                                    "ref": 2,
+                                    "bind": 1
+                                }
+                            ]
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "add7",
+        "name": "Try to update maxrules with 513",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update pipeline/ pipeid 1 maxrules 513",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 1,
+                "obj": "pipeline"
+            },
+            {
+                "templates": [
+                    {
+                        "pmaxrules": 1,
+                        "pnumtables": 0,
+                        "pstate": "not ready",
+                        "preactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "index": 1,
+                                    "ref": 2,
+                                    "bind": 1,
+                                    "control_action": {
+                                        "type": "pass"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    }
+                                }
+                            ]
+                        },
+                        "postactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "control_action": {
+                                        "type": "drop"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    },
+                                    "index": 2,
+                                    "ref": 2,
+                                    "bind": 1
+                                }
+                            ]
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "9e27",
+        "name": "Update numtables with 0",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update pipeline/ pipeid 1 numtables 0",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 1,
+                "obj": "pipeline"
+            },
+            {
+                "templates": [
+                    {
+                        "pmaxrules": 1,
+                        "pnumtables": 0,
+                        "pstate": "not ready",
+                        "preactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "index": 1,
+                                    "ref": 2,
+                                    "bind": 1,
+                                    "control_action": {
+                                        "type": "pass"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    }
+                                }
+                            ]
+                        },
+                        "postactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "control_action": {
+                                        "type": "drop"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    },
+                                    "index": 2,
+                                    "ref": 2,
+                                    "bind": 1
+                                }
+                            ]
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "01a3",
+        "name": "Try to update numtables with 33",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update pipeline/ pipeid 1 numtables 33",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 1,
+                "obj": "pipeline"
+            },
+            {
+                "templates": [
+                    {
+                        "pmaxrules": 1,
+                        "pnumtables": 0,
+                        "pstate": "not ready",
+                        "preactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "index": 1,
+                                    "ref": 2,
+                                    "bind": 1,
+                                    "control_action": {
+                                        "type": "pass"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    }
+                                }
+                            ]
+                        },
+                        "postactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "control_action": {
+                                        "type": "drop"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    },
+                                    "index": 2,
+                                    "ref": 2,
+                                    "bind": 1
+                                }
+                            ]
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "db08",
+        "name": "Try to seal pipeline which is not ready",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update pipeline/ pipeid 1 state ready",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 1,
+                "obj": "pipeline"
+            },
+            {
+                "templates": [
+                    {
+                        "pmaxrules": 1,
+                        "pnumtables": 1,
+                        "pstate": "not ready",
+                        "preactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "index": 1,
+                                    "ref": 2,
+                                    "bind": 1,
+                                    "control_action": {
+                                        "type": "pass"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    }
+                                }
+                            ]
+                        },
+                        "postactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "control_action": {
+                                        "type": "drop"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    },
+                                    "index": 2,
+                                    "ref": 2,
+                                    "bind": 1
+                                }
+                            ]
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "26",
+        "name": "Delete pipeline by name",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 1 maxrules 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template del pipeline/ptables",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchPattern": "Error: Pipeline name not found.*",
+        "teardown": [
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "8855",
+        "name": "Delete pipeline by id",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 42 maxrules 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template del pipeline/ pipeid 42",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get pipeline/ pipeid 42",
+        "matchCount": "1",
+        "matchPattern": "Error: Unable to find pipeline by id.*",
+        "teardown": [
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "757e",
+        "name": "Try to delete inexistent pipeline by name",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [],
+        "cmdUnderTest": "$TC p4template del pipeline/ptables",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchPattern": "Error: Pipeline name not found.*",
+        "teardown": []
+    },
+    {
+        "id": "4bff",
+        "name": "Try to delete inexistent pipeline by id",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [],
+        "cmdUnderTest": "$TC p4template del pipeline/ pipeid 1",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get pipeline/ pipeid 1",
+        "matchCount": "1",
+        "matchPattern": "Error: Unable to find pipeline by id.*",
+        "teardown": []
+    },
+    {
+        "id": "15b3",
+        "name": "Try to flush pipelines",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 42 maxrules 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template del pipeline/",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 42,
+                "obj": "pipeline"
+            },
+            {
+                "templates": [
+                    {
+                        "pmaxrules": 1,
+                        "pnumtables": 0,
+                        "pstate": "not ready",
+                        "preactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "index": 1,
+                                    "ref": 2,
+                                    "bind": 1,
+                                    "control_action": {
+                                        "type": "pass"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    }
+                                }
+                            ]
+                        },
+                        "postactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "control_action": {
+                                        "type": "drop"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    },
+                                    "index": 2,
+                                    "ref": 2,
+                                    "bind": 1
+                                }
+                            ]
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "6051",
+        "name": "Dump pipeline list",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ],
+            [
+                "$TC actions add action pass index 3",
+                0
+            ],
+            [
+                "$TC actions add action pass index 4",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 42 preactions action gact index 1 postactions action gact index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create pipeline/ptables2 pipeid 22 preactions action gact index 3 postactions action gact index 4",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get pipeline/",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "pipeline"
+            },
+            {
+                "templates": [
+                    {
+                        "pname": "ptables2"
+                    },
+                    {
+                        "pname": "ptables"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC p4template del pipeline/ptables2",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "0944",
+        "name": "Check action bind and ref after pipeline deletion",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 42 maxrules 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template del pipeline/ pipeid 42",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions ls action gact",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "total acts": 2
+            },
+            {
+                "actions": [
+                    {
+                        "kind": "gact",
+                        "index": 1,
+                        "ref": 1,
+                        "bind": 0
+                    },
+                    {
+                        "kind": "gact",
+                        "index": 2,
+                        "ref": 1,
+                        "bind": 0
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "8dbc",
+        "name": "Check action bind and ref after pipeline preaction update",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ],
+            [
+                "$TC actions add action pass index 3",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update pipeline/ pipeid 1 preactions action gact index 3",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions get action gact index 1",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "kind": "gact",
+                        "index": 1,
+                        "ref": 1,
+                        "bind": 0
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "9170",
+        "name": "Check action bind and ref after pipeline postaction update",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ],
+            [
+                "$TC actions add action pass index 3",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update pipeline/ pipeid 1 postactions action gact index 3",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions get action gact index 2",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "kind": "gact",
+                        "index": 2,
+                        "ref": 1,
+                        "bind": 0
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "6c15",
+        "name": "Try to create pipeline with same pipeid twice",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 preactions action gact index 1 postactions action gact index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create pipeline/ptables2 pipeid 22 numtables 4 maxrules 2 preactions action gact index 1 postactions action gact index 2",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22,
+                "obj": "pipeline"
+            },
+            {
+                "templates": [
+                    {
+                        "pmaxrules": 1,
+                        "pnumtables": 0,
+                        "pstate": "not ready",
+                        "preactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "index": 1,
+                                    "ref": 2,
+                                    "bind": 1,
+                                    "control_action": {
+                                        "type": "pass"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    }
+                                }
+                            ]
+                        },
+                        "postactions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "gact",
+                                    "control_action": {
+                                        "type": "drop"
+                                    },
+                                    "prob": {
+                                        "random_type": "none",
+                                        "control_action": {
+                                            "type": "pass"
+                                        },
+                                        "val": 0
+                                    },
+                                    "index": 2,
+                                    "ref": 2,
+                                    "bind": 1
+                                }
+                            ]
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "e32a",
+        "name": "Dump pipeline when amount of pipelines > P4TC_MSGBATCH_SIZE",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ],
+            [
+                "$TC actions add action pass index 3",
+                0
+            ],
+            [
+                "$TC actions add action pass index 4",
+                0
+            ],
+            [
+                "$TC actions add action pass index 5",
+                0
+            ],
+            [
+                "$TC actions add action pass index 6",
+                0
+            ],
+            [
+                "$TC actions add action pass index 7",
+                0
+            ],
+            [
+                "$TC actions add action pass index 8",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables2 preactions action gact index 3 postactions action gact index 4",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables3 preactions action gact index 5 postactions action gact index 6",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables4 preactions action gact index 7 postactions action gact index 8",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables5 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables6 preactions action gact index 3 postactions action gact index 4",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables7 preactions action gact index 5 postactions action gact index 6",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables8 preactions action gact index 7 postactions action gact index 8",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables9 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables10 preactions action gact index 3 postactions action gact index 4",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables11 preactions action gact index 5 postactions action gact index 6",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables12 preactions action gact index 7 postactions action gact index 8",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables13 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables14 preactions action gact index 3 postactions action gact index 4",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables15 preactions action gact index 5 postactions action gact index 6",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables16 preactions action gact index 7 postactions action gact index 8",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create pipeline/ptables17 pipeid 2147483647 preactions action gact index 3 postactions action gact index 4",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get pipeline/",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "pipeline"
+            },
+            {
+                "templates": [
+                    {
+                        "pname": "ptables"
+                    },
+                    {
+                        "pname": "ptables2"
+                    },
+                    {
+                        "pname": "ptables3"
+                    },
+                    {
+                        "pname": "ptables4"
+                    },
+                    {
+                        "pname": "ptables5"
+                    },
+                    {
+                        "pname": "ptables6"
+                    },
+                    {
+                        "pname": "ptables7"
+                    },
+                    {
+                        "pname": "ptables8"
+                    },
+                    {
+                        "pname": "ptables9"
+                    },
+                    {
+                        "pname": "ptables10"
+                    },
+                    {
+                        "pname": "ptables11"
+                    },
+                    {
+                        "pname": "ptables12"
+                    },
+                    {
+                        "pname": "ptables13"
+                    },
+                    {
+                        "pname": "ptables14"
+                    },
+                    {
+                        "pname": "ptables15"
+                    },
+                    {
+                        "pname": "ptables16"
+                    }
+                ]
+            },
+            {
+                "obj": "pipeline"
+            },
+            {
+                "templates": [
+                    {
+                        "pname": "ptables17"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC p4template del pipeline/ptables2",
+                0
+            ],
+            [
+                "$TC p4template del pipeline/ptables3",
+                0
+            ],
+            [
+                "$TC p4template del pipeline/ptables4",
+                0
+            ],
+            [
+                "$TC p4template del pipeline/ptables5",
+                0
+            ],
+            [
+                "$TC p4template del pipeline/ptables6",
+                0
+            ],
+            [
+                "$TC p4template del pipeline/ptables7",
+                0
+            ],
+            [
+                "$TC p4template del pipeline/ptables8",
+                0
+            ],
+            [
+                "$TC p4template del pipeline/ptables9",
+                0
+            ],
+            [
+                "$TC p4template del pipeline/ptables10",
+                0
+            ],
+            [
+                "$TC p4template del pipeline/ptables11",
+                0
+            ],
+            [
+                "$TC p4template del pipeline/ptables12",
+                0
+            ],
+            [
+                "$TC p4template del pipeline/ptables13",
+                0
+            ],
+            [
+                "$TC p4template del pipeline/ptables14",
+                0
+            ],
+            [
+                "$TC p4template del pipeline/ptables15",
+                0
+            ],
+            [
+                "$TC p4template del pipeline/ptables16",
+                0
+            ],
+            [
+                "$TC p4template del pipeline/ptables17",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "398c",
+        "name": "Test overflow in pipeid when we search for inexistent pipeline and we have pipeid 2147483647 in idr",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create pipeline/ptables pipeid 2147483647 preactions action gact index 1 postactions action gact index 2",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables2",
+        "matchCount": "1",
+        "matchPattern": "Error: Pipeline name not found.*",
+        "teardown": [
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "cd4e",
+        "name": "Try to create pipeline without name or id",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create pipeline/ preactions action gact index 1 postactions action gact index 2",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get pipeline/ptables",
+        "matchCount": "1",
+        "matchPattern": "Error: Pipeline name not found.*",
+        "teardown": [
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    },
+    {
+        "id": "6356",
+        "name": "Create pipeline with name length > PIPELINENAMSIZ",
+        "category": [
+            "p4tc",
+            "template",
+            "pipeline"
+        ],
+        "setup": [
+            [
+                "$TC actions flush action gact",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 1",
+                0
+            ],
+            [
+                "$TC actions add action drop index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create pipeline/7eozFYyaqVCD7H0xS3M5sMnluUqPgZewfSLnYPf4s3k0lbx8lKoR32zSqiGsh84qJ32vnLPdl7f2XcUh5yIdEP7uJy2C3iPtyU7159s9CMB0EtTAlWTVz4U1jkQ5h2advwp3KCVsZ1jlGgStoJL2op5ZxoThTSUQLR61a5RNDovoSFcq86Brh6oW9DSmTbN6SYygbG3JLnEHzRC5hh0jGmJKHq5ivBK9Y9FlNZQXC9wVwX4qTFAd8ITUTj2Au2Jg1 pipeid 1 preactions action gact index 1 postactions action gact index 2",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get pipeline/ pipeid 1",
+        "matchCount": "1",
+        "matchPattern": "Error: Unable to find pipeline by id.*",
+        "teardown": [
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    }
+]
-- 
2.34.1


