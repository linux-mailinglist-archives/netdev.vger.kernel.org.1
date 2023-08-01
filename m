Return-Path: <netdev+bounces-23177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2306C76B395
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C93281281
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6168A25146;
	Tue,  1 Aug 2023 11:38:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4858F25142
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:38:53 +0000 (UTC)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F77E43
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 04:38:50 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-79ae250266cso30214241.2
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 04:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690889929; x=1691494729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AmFqV+UT6uEwvUlSo06yXZCDoURkc4KlD5kXIoCLfk=;
        b=SW2ZzDIE/7R7jKHSPYChU2l5nXs6KpTdlM0lqjLmpymbsWHhP4hGuHjapn24DpkQa5
         NkgjPZpNurRPg2LD5ZUE87dwPuHdFKTYT5sxA2kK3TmJuqhjhSxT9gWovTR4qyt92OG9
         o98DS7Nhnp0nOSRB8vA0PZ8RilCr6Ftg4Ojl67ROhMIQr00w6AGUFbbsar/EcxIYUbnL
         yEA2YJoiFVagykNxlScQvRGLwCOMEX3zAAqcU20oOyGMYrbs/lk/XN8Hz1fv+3WAySTL
         LsqftMnI2mGgmGPViIGzZdTwcmjOaBcAgWB0ZnELefGp8S3r7Kn32F2oTrZ83Zf/1Xy1
         t0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690889929; x=1691494729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AmFqV+UT6uEwvUlSo06yXZCDoURkc4KlD5kXIoCLfk=;
        b=ELvY3md9eKAKyohUiK0HFFfND02qjkPeZMGsKrlVORHAu45ZOGv1lsAX2Jda2D3ZeJ
         PcJOdRvuDMX3bV+Z/7w+Z3tl8037OitHuxl/fdNH1kJw8t/c//G8L/8mb8yvSPqbKSBq
         jSDULIEHTI1rkZE3aPq0HIP8P+uA/YUhDtxOuOm3TLg336Q/efb7FMVb+e9dFeL3NJ1A
         neFCoQC3cnULIEx3Mbe7wjXU4Dt3x2drVPZJ3bxkkoPYxBYCDW6h7rxqhPSNoT51U+iP
         IWQYVhDDGgkScwOspEfITquBOnsKAcoRr4CnSsVGNrzVzH1ZxOWBU9lQwUgDlz5dR3Vy
         G+Qg==
X-Gm-Message-State: ABy/qLbnMYoK8TxOG4N55kq+z3/sYFegoh9kRxXiOKW2H6497Y4fKnaz
	oKQHgj4CG1jRr5SrNYbzKefXbImNNxajS9C86N3dqw==
X-Google-Smtp-Source: APBJJlGRI//QqjExh6bv3M9lAL1dXo5pXuvQsxBLvQf03u2TsUpTgeqEWJrj3Om6sEVTVcRd3Q9cmQ==
X-Received: by 2002:a67:f7c6:0:b0:443:66b9:b8e9 with SMTP id a6-20020a67f7c6000000b0044366b9b8e9mr1847601vsp.20.1690889928752;
        Tue, 01 Aug 2023 04:38:48 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id j1-20020a0cf501000000b0063d26033b74sm4643738qvm.39.2023.08.01.04.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 04:38:47 -0700 (PDT)
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
	john.andy.fingerhut@intel.com
Subject: [PATCH RFC v5 net-next 19/23] selftests: tc-testing: add P4TC pipeline control path tdc tests
Date: Tue,  1 Aug 2023 07:38:03 -0400
Message-Id: <20230801113807.85473-20-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801113807.85473-1-jhs@mojatatu.com>
References: <20230801113807.85473-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
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
 .../tc-testing/tc-tests/p4tc/pipeline.json    | 1448 +++++++++++++++++
 1 file changed, 1448 insertions(+)
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/p4tc/pipeline.json

diff --git a/tools/testing/selftests/tc-testing/tc-tests/p4tc/pipeline.json b/tools/testing/selftests/tc-testing/tc-tests/p4tc/pipeline.json
new file mode 100644
index 000000000..87acda306
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/tc-tests/p4tc/pipeline.json
@@ -0,0 +1,1448 @@
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
+        "cmdUnderTest": "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
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
+                        "pnumtables": 2,
+                        "pstate": "not ready"
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
+        "cmdUnderTest": "$TC p4template create pipeline/ pipeid 22 numtables 2",
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
+        "cmdUnderTest": "$TC p4template create pipeline/ptables pipeid 22",
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
+                        "pnumtables": 0,
+                        "pstate": "not ready"
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
+        "cmdUnderTest": "$TC p4template create pipeline/ptables pipeid 22 numtables 0",
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
+                        "pnumtables": 0,
+                        "pstate": "not ready"
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
+        "cmdUnderTest": "$TC p4template create pipeline/ptables pipeid 22 numtables 33",
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
+        "cmdUnderTest": "$TC p4template create pipeline/ptables pipeid 1 numtables 32",
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
+                        "pnumtables": 32,
+                        "pstate": "not ready"
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
+        "cmdUnderTest": "$TC p4template create pipeline/ptables pipeid 1 numtables 2",
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
+                        "pnumtables": 2,
+                        "pstate": "not ready"
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
+                "$TC p4template create pipeline/ptables pipeid 22",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create pipeline/ptables pipeid 22 numtables 4",
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
+                        "pnumtables": 0,
+                        "pstate": "not ready"
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
+                "$TC p4template create pipeline/ptables pipeid 1",
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
+                        "pnumtables": 4,
+                        "pstate": "not ready"
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
+                "$TC p4template create pipeline/ptables pipeid 1",
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
+                        "pnumtables": 0,
+                        "pstate": "not ready"
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
+                "$TC p4template create pipeline/ptables pipeid 1",
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
+                        "pnumtables": 0,
+                        "pstate": "not ready"
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
+                "$TC p4template create pipeline/ptables pipeid 1 numtables 1",
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
+                        "pnumtables": 1,
+                        "pstate": "not ready"
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
+                "$TC p4template create pipeline/ptables pipeid 1",
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
+                "$TC p4template create pipeline/ptables pipeid 42",
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
+                "$TC p4template create pipeline/ptables pipeid 42",
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
+                        "pnumtables": 0,
+                        "pstate": "not ready"
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
+                "$TC p4template create pipeline/ptables pipeid 42",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create pipeline/ptables2 pipeid 22",
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
+                "$TC p4template create pipeline/ptables pipeid 42",
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
+                "$TC p4template create pipeline/ptables pipeid 22",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create pipeline/ptables2 pipeid 22 numtables 4",
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
+                        "pnumtables": 0,
+                        "pstate": "not ready"
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
+                "$TC p4template create pipeline/ptables",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables2",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables3",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables4",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables5",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables6",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables7",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables8",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables9",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables10",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables11",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables12",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables13",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables14",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables15",
+                0
+            ],
+            [
+                "$TC p4template create pipeline/ptables16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create pipeline/ptables17 pipeid 2147483647",
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
+        "cmdUnderTest": "$TC p4template create pipeline/ptables pipeid 2147483647",
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
+        "cmdUnderTest": "$TC p4template create pipeline/",
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
+        "cmdUnderTest": "$TC p4template create pipeline/7eozFYyaqVCD7H0xS3M5sMnluUqPgZewfSLnYPf4s3k0lbx8lKoR32zSqiGsh84qJ32vnLPdl7f2XcUh5yIdEP7uJy2C3iPtyU7159s9CMB0EtTAlWTVz4U1jkQ5h2advwp3KCVsZ1jlGgStoJL2op5ZxoThTSUQLR61a5RNDovoSFcq86Brh6oW9DSmTbN6SYygbG3JLnEHzRC5hh0jGmJKHq5ivBK9Y9FlNZQXC9wVwX4qTFAd8ITUTj2Au2Jg1 pipeid 1",
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


