Return-Path: <netdev+bounces-17216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFBC750CF5
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A36D281AB0
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8287D20F9F;
	Wed, 12 Jul 2023 15:40:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B9B20F9D
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 15:40:34 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D898F1BCC
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:40:30 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-6348a8045a2so46570836d6.1
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689176429; x=1691768429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHeP672P3/pMV2LrpWFMPrX6ZRn2F3+38saxnBmkAtE=;
        b=FFwUj1pYrlL80FNXCqtXuTwix9t6rtBvUJP8Wj48dMhk2YFYqvvay0CiSEuNaB3cKJ
         lANfxPofUpKEaBQcTh+MQOx24n+Jt5ofxsZaELJ6TX1ru6VCfajOPFrJ2NfwoEB+TkfT
         6NNhR0MhszCIbq/neOWlhTosxXQv0ialiYzNfXL400ZzdGM3JDfZ0zNW/Iunih++Obws
         osdHpkhq4KeLePzATdqOehiNpk8QBRum7lXzAs3vETODgotDElk90lNjgeLML7k4Utk8
         bQunCtCbfhAQNlTfT2GEuKFPi5WGf+N4A1LtdglWilqwzYAw4vO7f1k9r84cMJq2kvtG
         3oXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689176429; x=1691768429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHeP672P3/pMV2LrpWFMPrX6ZRn2F3+38saxnBmkAtE=;
        b=I9kq/pTbZeFoZ50gA7Zd6QO0+SvXilL/pN8bnVGUgfTXwnNhLTmT23jmInC2Og74FO
         wfy1GdBI/zgKllTih9IhhwfjK8UOQ/3UxB3YCj0wBWaxyUwNmNzLEu2j8nzZQDmV1DYS
         3JTC89OUkQ1u2qWErOLNysiuutbl23WiFxeKsza0lmfwaaQhrikN6jPF0M2G98Bd3KOr
         uSQMxeLfstOGiR71B19PWkvvYP5SGmV/4cEaXVLPlQ57RhlTtF4rrcGpHTZg2xNpj0tF
         ZeCwQt2qh9DPAKNS/H6QrHmOmaT8icKP35yk0PBtAvmzMii/Aq1z/7Rxz6Nhxexb8XiH
         17PQ==
X-Gm-Message-State: ABy/qLZCUgDnaqJ4gTWrnkWa4+pjSN9smiB/BIlTsot1eTFzyXVxyFY/
	diQEvL6HDNuyBeWym8Zr5hTdF6KDAkf/QfI4IBBAxg==
X-Google-Smtp-Source: APBJJlG3YSk5ICzN1KjoeEeRrU9Wp/52L0QrpkGQwinbe3SkIZKxsJrP4TYaBL9bofl6mnNlq/04PQ==
X-Received: by 2002:a0c:8e43:0:b0:630:463:3650 with SMTP id w3-20020a0c8e43000000b0063004633650mr16973712qvb.39.1689176428336;
        Wed, 12 Jul 2023 08:40:28 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id r3-20020a0ccc03000000b0063211e61875sm2283827qvk.14.2023.07.12.08.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:40:27 -0700 (PDT)
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
Subject: [PATCH RFC v4 net-next 19/22] selftests: tc-testing: add P4TC action templates tdc tests
Date: Wed, 12 Jul 2023 11:39:46 -0400
Message-Id: <20230712153949.6894-20-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712153949.6894-1-jhs@mojatatu.com>
References: <20230712153949.6894-1-jhs@mojatatu.com>
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

Introduce tdc tests for P4TC table types, which are focused on the
control path. We test table type create, update, delete, flush and
dump.

Here is a basic description of what we test for each operation:

Create:
    - Create valid action template
    - Create action templates with all possible param types
    - Try to create action template with param of invalid type
    - Create valid action template and instantiate action of new kind
    - Try to create action template with name > IFNAMSIZ
    - Try to create action template with param type > ACTPARAMNAMSIZ
    - Create action template with more than one param
    - Create action template with no params
    - Try to create action template with same ID twice
    - Try to create action template with same name twice
    - Try to create action template with two params and one of unknown type
    - Create valid action template, instantiate it and update the
      instance
    - Create valid action template, create two instances of it and dump
    - Create action template, add instance and bind action to filter
    - Create action template, add instance, bind action to filter and send
      packet

Update:
    - Update action template with actions
    - Update action template with all param types
    - Try to add new param during update
    - Update action template param by id
    - Try to update inexistent action template by id
    - Try to update inexistent action template by name

Delete:
    - Delete action template by name
    - Delete action template by id
    - Try to delete inexistent action template by name
    - Try to delete inexistent action template by id
    - Try to delete action template without supplying pipeline name or id
    - Flush action templates
    - Try to flush action templates without supplying pipeline name or id

Dump:
    - Dump action template IDR using pipeline name to find pipeline
    - Dump action template IDR using pipeline id to find pipeline
    - Try to dump action templates IDR without specifying pipeline name or
      id
    - Dump action templates IDR which has more than P4TC_MAXMSG_COUNT (16)
      elements

Tested-by: "Khan, Mohd Arif" <mohd.arif.khan@intel.com>
Tested-by: "Pottimurthy, Sathya Narayana" <sathya.narayana.pottimurthy@intel.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../tc-tests/p4tc/action_templates.json       | 3929 +++++++++++++++++
 1 file changed, 3929 insertions(+)
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/p4tc/action_templates.json

diff --git a/tools/testing/selftests/tc-testing/tc-tests/p4tc/action_templates.json b/tools/testing/selftests/tc-testing/tc-tests/p4tc/action_templates.json
new file mode 100644
index 000000000..a825a122d
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/tc-tests/p4tc/action_templates.json
@@ -0,0 +1,3929 @@
+[
+    {
+        "id": "c494",
+        "name": "Create valid action template with param type bit32",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create action/ptables/test actid 1 param param1 type bit32",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get action/ptables/test",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "action template",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "aname": "ptables/test",
+                        "actid": 1,
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "bit32",
+                                "id": 1
+                            }
+                        ]
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
+        "id": "4964",
+        "name": "Create valid action template with param type bit8",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create action/ptables/test param param1 type bit8",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get action/ptables/test",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "action template",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "aname": "ptables/test",
+                        "actid": 1,
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "bit8",
+                                "id": 1
+                            }
+                        ]
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
+        "id": "2ed6",
+        "name": "Create valid action template with param type bit16",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create action/ptables/test param param1 type bit16",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get action/ptables/test",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "action template",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "aname": "ptables/test",
+                        "actid": 1,
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "bit16",
+                                "id": 1
+                            }
+                        ]
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
+        "id": "ec54",
+        "name": "Create valid action template with param type bit64",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create action/ptables/test param param1 type bit64",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get action/ptables/test",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "action template",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "aname": "ptables/test",
+                        "actid": 1,
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "bit64",
+                                "id": 1
+                            }
+                        ]
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
+        "id": "6c74",
+        "name": "Create valid action template with param type mac",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create action/ptables/test param param1 type macaddr",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get action/ptables/test",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "action template",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "aname": "ptables/test",
+                        "actid": 1,
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "macaddr",
+                                "id": 1
+                            }
+                        ]
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
+        "id": "bf9c",
+        "name": "Create valid action template with param type ipv4",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create action/ptables/test param param1 type ipv4",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get action/ptables/test",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "action template",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "aname": "ptables/test",
+                        "actid": 1,
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "ipv4",
+                                "id": 1
+                            }
+                        ]
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
+        "id": "03f3",
+        "name": "Create valid action template with param type bit32 and create an instance of action",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test param param1 type bit32",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/test state active",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC actions add action ptables/test param param1 type bit32 id 1 4294967295",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions get action ptables/test index 1",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "ptables/test",
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "bit32",
+                                "value": 4294967295,
+                                "id": 1
+                            }
+                        ],
+                        "index": 1,
+                        "ref": 1,
+                        "bind": 0,
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC actions flush action ptables/test",
+                0
+            ],
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
+        "id": "80f5",
+        "name": "Create valid action template with param type bit32 and try to add it to table_acts_list of another pipeline",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 3",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action pass index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test param param1 type bit32",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/test state active",
+                0
+            ],
+	    [
+		"$TC p4template create pipeline/ptables2 pipeid 23 numtables 2",
+		0
+	    ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables2/cb/tname tblid 22 keysz 16 table_acts act name ptables/test",
+        "expExitCode": "255",
+        "verifyCmd": "$TC p4template get table/ptables2/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Error: Table name not found",
+        "teardown": [
+            [
+                "$TC actions flush action ptables/test",
+                0
+            ],
+            [
+                "$TC p4template del pipeline/ptables2",
+                0
+            ],
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
+        "id": "782e",
+        "name": "Create valid action template with param type bit8 and create an instance of action",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test param param1 type bit8",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/test state active",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC actions add action ptables/test param param1 type bit8 id 1 255",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions get action ptables/test index 1",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "ptables/test",
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "bit8",
+                                "value": 255,
+                                "id": 1
+                            }
+                        ],
+                        "index": 1,
+                        "ref": 1,
+                        "bind": 0,
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC actions flush action ptables/test",
+                0
+            ],
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
+        "id": "e250",
+        "name": "Create valid action template with param type bit16 and create an instance of action",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test param param1 type bit16",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/test state active",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC actions add action ptables/test param param1 type bit16 id 1 65535",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions get action ptables/test index 1",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "ptables/test",
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "bit16",
+                                "value": 65535,
+                                "id": 1
+                            }
+                        ],
+                        "index": 1,
+                        "ref": 1,
+                        "bind": 0,
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC actions flush action ptables/test",
+                0
+            ],
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
+        "id": "99b7",
+        "name": "Create valid action template with param type bit64 and create an instance of action",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test param param1 type bit64",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/test state active",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC actions add action ptables/test param param1 type bit64 id 1 4294967295",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions get action ptables/test index 1",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "ptables/test",
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "bit64",
+                                "value": 4294967295,
+                                "id": 1
+                            }
+                        ],
+                        "index": 1,
+                        "ref": 1,
+                        "bind": 0,
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC actions flush action ptables/test",
+                0
+            ],
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
+        "id": "367c",
+        "name": "Create valid action template with param type mac and create an instance of action",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test param param1 type macaddr",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/test state active",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC actions add action ptables/test param param1 type macaddr id 1 AA:BB:CC:DD:EE:FF",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions get action ptables/test index 1",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "ptables/test",
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "macaddr",
+                                "value": "aa:bb:cc:dd:ee:ff",
+                                "id": 1
+                            }
+                        ],
+                        "index": 1,
+                        "ref": 1,
+                        "bind": 0,
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC actions flush action ptables/test",
+                0
+            ],
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
+        "id": "315c",
+        "name": "Create valid action template with param type ipv4 and create an instance of action",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test param param1 type ipv4",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/test state active",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC actions add action ptables/test param param1 type ipv4 id 1 10.10.10.0/24",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions get action ptables/test index 1",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "ptables/test",
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "ipv4",
+                                "value": "10.10.10.0/24",
+                                "id": 1
+                            }
+                        ],
+                        "index": 1,
+                        "ref": 1,
+                        "bind": 0,
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC actions flush action ptables/test",
+                0
+            ],
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
+        "id": "62b1",
+        "name": "Create valid action template with two params",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create action/ptables/test param param1 type bit32 param param2 type bit16",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get action/ptables/test",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "action template",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "aname": "ptables/test",
+                        "actid": 1,
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "bit32",
+                                "id": 1
+                            },
+                            {
+                                "name": "param2",
+                                "type": "bit16",
+                                "id": 2
+                            }
+                        ]
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
+        "id": "73a5",
+        "name": "Create valid action template with no params",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create action/ptables/test",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get action/ptables/test",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "action template",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "aname": "ptables/test",
+                        "actid": 1,
+                        "params": []
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
+        "id": "c403",
+        "name": "Try to create action template with param of unknown type",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create action/ptables/test param param1 type notvalid",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get action/ptables/test",
+        "matchCount": "1",
+        "matchPattern": "Error: Action name not found.*",
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
+        "id": "d21f",
+        "name": "Try to create action template with two params and one of unknown type",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create action/ptables/test param param1 type bit32 param param2 type notvalid",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get action/ptables/test",
+        "matchCount": "1",
+        "matchPattern": "Error: Action name not found.*",
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
+        "id": "164e",
+        "name": "Try to create action template with same name twice",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test param param1 type bit32",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create action/ptables/test param param1 type bit64",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get action/ptables/test",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "action template",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "aname": "ptables/test",
+                        "actid": 1,
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "bit32",
+                                "id": 1
+                            }
+                        ]
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
+        "id": "de27",
+        "name": "Try to create action template with same id twice",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test actid 1 param param1 type bit32",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create action/ptables/test2 actid 1 param param1 type bit64",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get action/ptables/ actid 1",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "action template",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "aname": "ptables/test",
+                        "actid": 1,
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "bit32",
+                                "id": 1
+                            }
+                        ]
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
+        "id": "b711",
+        "name": "Try to create action template with name > IFNAMSIZ",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create action/ptables/CMPCQGOzcLG8HILTQxsQYKfDg4zQQdtmNfosyAhQxhqDTC8cg10QediAAzIMvel2Y actid 1 param param1 type bit32",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get action/ptables/ actid 1",
+        "matchCount": "1",
+        "matchPattern": "Error: Unable to find action by id.*",
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
+        "id": "17f3",
+        "name": "Try to create action template with param name > ACTPARAMNAMSIZ",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create action/ptables/test actid 1 param oDXNP48egpqbhrFfRZxEMcJu4p2932zuTVO7ab81kXaYsLfJJWx1qF4QbohzvlLfBgS7j2Xo5wR3jQ9yuRARyFMNvGilXoufpvvwr8Z5bBaD8H80Lav8LleO5Qss5CjmE8l34Vomvn7LEEfeRTAzOCbPew7L2DuoQz2JQtyGFsZ8dEORnjFaZBZ6CGDPh68strQiFwEHUs6lUpbIxhxB6xarZGpwktZOyascnZLbc901mqrx96gnx939LpDkaNLij type bit32",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get action/ptables/ actid 1",
+        "matchCount": "1",
+        "matchPattern": "Error: Unable to find action by id.*",
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
+        "id": "5bbe",
+        "name": "Update action template param type to bit16",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test actid 1 param param1 type bit32",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update action/ptables/test param param1 type bit16",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get action/ptables/ actid 1",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "action template",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "aname": "ptables/test",
+                        "actid": 1,
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "bit16",
+                                "id": 1
+                            }
+                        ]
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
+        "id": "e596",
+        "name": "Update action template param type to bit8",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test actid 1 param param1 type bit32",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update action/ptables/test param param1 type bit8",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get action/ptables/ actid 1",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "action template",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "aname": "ptables/test",
+                        "actid": 1,
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "bit8",
+                                "id": 1
+                            }
+                        ]
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
+        "id": "b74b",
+        "name": "Update action template param type to bit64",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test actid 1 param param1 type bit32",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update action/ptables/test param param1 type bit64",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get action/ptables/ actid 1",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "action template",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "aname": "ptables/test",
+                        "actid": 1,
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "bit64",
+                                "id": 1
+                            }
+                        ]
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
+        "id": "5d74",
+        "name": "Update action template param type to ipv4",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test actid 1 param param1 type bit32",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update action/ptables/test param param1 type ipv4",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get action/ptables/ actid 1",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "action template",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "aname": "ptables/test",
+                        "actid": 1,
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "ipv4",
+                                "id": 1
+                            }
+                        ]
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
+        "id": "3b81",
+        "name": "Update action template param type to mac",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test actid 1 param param1 type bit32",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update action/ptables/test param param1 type macaddr",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get action/ptables/ actid 1",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "action template",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "aname": "ptables/test",
+                        "actid": 1,
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "macaddr",
+                                "id": 1
+                            }
+                        ]
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
+        "id": "cc31",
+        "name": "Try to add new param during update",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test actid 1 param param1 type bit32",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update action/ptables/test param param1 type bit16 param param2 type bit8",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get action/ptables/ actid 1",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "action template",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "aname": "ptables/test",
+                        "actid": 1,
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "bit32",
+                                "id": 1
+                            }
+                        ]
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
+        "id": "03b7",
+        "name": "Update action template param by id",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test actid 1 param param1 type bit32 id 1",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update action/ptables/test param param1 type bit16 id 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get action/ptables/ actid 1",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "action template",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "aname": "ptables/test",
+                        "actid": 1,
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "bit16",
+                                "id": 1
+                            }
+                        ]
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
+        "id": "c695",
+        "name": "Try to update inexistent action template by id",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update action/ptables/ actid 1 param param1 type bit16 id 1",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get action/ptables/ actid 1",
+        "matchCount": "1",
+        "matchPattern": "Error: Unable to find action by id.*",
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
+        "id": "86ef",
+        "name": "Try to update inexistent action template by name",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update action/ptables/test param param1 type bit16 id 1",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get action/ptables/test",
+        "matchCount": "1",
+        "matchPattern": "Error: Action name not found.*",
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
+        "id": "636f",
+        "name": "Create valid action template with param type bit32, create an instance of action and update it",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test param param1 type bit32",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/test state active",
+                0
+            ],
+            [
+                "$TC actions add action ptables/test param param1 type bit32 id 1 4294967295 index 1",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC actions replace action ptables/test param param1 type bit32 id 1 22 index 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions get action ptables/test index 1",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "ptables/test",
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "bit32",
+                                "value": 22,
+                                "id": 1
+                            }
+                        ],
+                        "index": 1,
+                        "ref": 1,
+                        "bind": 0,
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC actions flush action ptables/test",
+                0
+            ],
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
+        "id": "f13d",
+        "name": "Create valid action template with param type bit32, create an instance of action and delete it",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test param param1 type bit32",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/test state active",
+                0
+            ],
+            [
+                "$TC actions add action ptables/test param param1 type bit32 id 1 4294967295 index 1",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC actions del action ptables/test index 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions get action ptables/test index 1",
+        "matchCount": "1",
+        "matchPattern": "Error: TC action with specified index not found.*",
+        "teardown": [
+            [
+                "$TC actions flush action ptables/test",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/test state inactive",
+                0
+            ],
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
+        "id": "11f8",
+        "name": "Create valid action template with two params, create an instance of action and delete it",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test param param1 type bit32 param param2 type bit32",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/test state active",
+                0
+            ],
+            [
+                "$TC actions add action ptables/test param param1 type bit32 4294967295 param param2 type bit32 22 index 1",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC actions del action ptables/test index 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions get action ptables/test index 1",
+        "matchCount": "1",
+        "matchPattern": "Error: TC action with specified index not found.*",
+        "teardown": [
+            [
+                "$TC actions flush action ptables/test",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/test state inactive",
+                0
+            ],
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
+        "id": "cccb",
+        "name": "Create valid action template with no params, create an instance of action and delete it",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/test state active",
+                0
+            ],
+            [
+                "$TC actions add action ptables/test index 1",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC actions del action ptables/test index 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions get action ptables/test index 1",
+        "matchCount": "1",
+        "matchPattern": "Error: TC action with specified index not found.*",
+        "teardown": [
+            [
+                "$TC actions flush action ptables/test",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/test state inactive",
+                0
+            ],
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
+        "id": "8523",
+        "name": "Create valid action template with param type bit32, create two instances of action and dump",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test param param1 type bit32",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/test state active",
+                0
+            ],
+            [
+                "$TC actions add action ptables/test param param1 type bit32 id 1 4294967295 index 1",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC actions add action ptables/test param param1 type bit32 id 1 42 index 2",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions ls action ptables/test",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "total acts": 2
+            },
+            {
+                "actions": [
+                    {
+                        "order": 0,
+                        "kind": "ptables/test",
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "bit32",
+                                "value": 4294967295,
+                                "id": 1
+                            }
+                        ],
+                        "index": 1,
+                        "ref": 1,
+                        "bind": 0,
+                        "not_in_hw": true
+                    },
+                    {
+                        "order": 1,
+                        "kind": "ptables/test",
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "bit32",
+                                "value": 42,
+                                "id": 1
+                            }
+                        ],
+                        "index": 2,
+                        "ref": 1,
+                        "bind": 0,
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC actions flush action ptables/test",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/test state inactive",
+                0
+            ],
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
+        "id": "cc14",
+        "name": "Create action template, add instance and try to bind action to filter",
+        "category": [
+            "p4tc",
+            "template"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test actid 1 param param1 type bit32 id 1",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/test state active",
+                0
+            ],
+            [
+                "$TC actions add action ptables/test param param1 type bit32 id 1 4294967295",
+                0
+            ],
+            [
+                "$TC qdisc add dev $DEV1 ingress",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 prio 65535 protocol ip matchall action ptables/test index 1",
+        "expExitCode": "2",
+        "verifyCmd": "$TC -j filter get dev $DEV1 parent ffff: handle 1 prio 65535 protocol ip matchall",
+        "matchCount": "1",
+        "matchPattern": "Error: Cannot find specified filter chain.*",
+        "teardown": [
+            [
+                "$TC qdisc del dev $DEV1 ingress; sleep 1",
+                0
+            ],
+            [
+                "$TC actions flush action ptables/test",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/test state inactive",
+                0
+            ],
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
+        "id": "e3e4",
+        "name": "Dump action templates using pname to find pipeline",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test actid 1 param param1 type bit32",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test2 actid 2 param param1 type bit64",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create action/ptables/test3 param param1 type bit64",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get action/ptables/",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22,
+                "obj": "action template"
+            },
+            {
+                "templates": [
+                    {
+                        "aname": "ptables/test"
+                    },
+                    {
+                        "aname": "ptables/test2"
+                    },
+                    {
+                        "aname": "ptables/test3"
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
+        "id": "25bc",
+        "name": "Dump action templates using pipeid to find pipeline",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test actid 1 param param1 type bit32",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test2 actid 2 param param1 type bit64",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create action/ptables/test3 param param1 type bit64",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get action/ pipeid 22",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22,
+                "obj": "action template"
+            },
+            {
+                "templates": [
+                    {
+                        "aname": "ptables/test"
+                    },
+                    {
+                        "aname": "ptables/test2"
+                    },
+                    {
+                        "aname": "ptables/test3"
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
+        "id": "f1e1",
+        "name": "Dump action templates without specifying pipeid or pname",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test actid 1 param param1 type bit32",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test2 actid 2 param param1 type bit64",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create action/ptables/test3 param param1 type bit64",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get action/",
+        "matchCount": "1",
+        "matchPattern": "Error: Must specify pipeline name or id.*",
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
+        "id": "dc67",
+        "name": "Dump action templates IDR with more than P4TC_MAXMSG_COUNT elements",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test param param1 type bit32",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test2 param param1 type bit64",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test3 param param1 type bit32",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test4 param param1 type bit64",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test5 param param1 type bit32",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test6 param param1 type bit64",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test7 param param1 type bit32",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test8 param param1 type bit64",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test9 param param1 type bit32",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test10 param param1 type bit64",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test11 param param1 type bit32",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test12 param param1 type bit64",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test13 param param1 type bit32",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test14 param param1 type bit64",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test15 param param1 type bit32",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test16 param param1 type bit64",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create action/ptables/test17 param param1 type bit64",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get action/ pipeid 22",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22,
+                "obj": "action template"
+            },
+            {
+                "templates": [
+                    {
+                        "aname": "ptables/test"
+                    },
+                    {
+                        "aname": "ptables/test2"
+                    },
+                    {
+                        "aname": "ptables/test3"
+                    },
+                    {
+                        "aname": "ptables/test4"
+                    },
+                    {
+                        "aname": "ptables/test5"
+                    },
+                    {
+                        "aname": "ptables/test6"
+                    },
+                    {
+                        "aname": "ptables/test7"
+                    },
+                    {
+                        "aname": "ptables/test8"
+                    },
+                    {
+                        "aname": "ptables/test9"
+                    },
+                    {
+                        "aname": "ptables/test10"
+                    },
+                    {
+                        "aname": "ptables/test11"
+                    },
+                    {
+                        "aname": "ptables/test12"
+                    },
+                    {
+                        "aname": "ptables/test13"
+                    },
+                    {
+                        "aname": "ptables/test14"
+                    },
+                    {
+                        "aname": "ptables/test15"
+                    },
+                    {
+                        "aname": "ptables/test16"
+                    }
+                ]
+            },
+            {
+                "pname": "ptables",
+                "pipeid": 22,
+                "obj": "action template"
+            },
+            {
+                "templates": [
+                    {
+                        "aname": "ptables/test17"
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
+        "id": "fd55",
+        "name": "Flush action templates using pname to find pipeline",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test actid 1 param param1 type bit32",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test2 actid 2 param param1 type bit64",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template del action/ptables/",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get action/ptables/",
+        "matchCount": "1",
+        "matchJSON": [],
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
+        "id": "7e85",
+        "name": "Flush action templates using pipeid to find pipeline",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test actid 1 param param1 type bit32",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test2 actid 2 param param1 type bit64",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template del action/ pipeid 22",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get action/ptables/",
+        "matchCount": "1",
+        "matchJSON": [],
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
+        "id": "f444",
+        "name": "Try to flush action templates without specifying pname or pipeid",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test actid 1 param param1 type bit32",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test2 actid 2 param param1 type bit64",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template del action/",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get action/ptables/",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22,
+                "obj": "action template"
+            },
+            {
+                "templates": [
+                    {
+                        "aname": "ptables/test"
+                    },
+                    {
+                        "aname": "ptables/test2"
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
+        "id": "fced",
+        "name": "Delete action template using action name",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test param param1 type bit32",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template del action/ptables/test",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get action/ptables/test",
+        "matchCount": "1",
+        "matchPattern": "Error: Action name not found.*",
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
+        "id": "049e",
+        "name": "Delete template action by actid",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test param param1 type bit32",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template del action/ pipeid 22 actid 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get action/ pipeid 22 actid 1",
+        "matchCount": "1",
+        "matchPattern": "Error: Unable to find action by id.*",
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
+        "id": "e6e9",
+        "name": "Try to delete inexistent action template",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template del action/ pipeid 22 actid 1",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get action/ pipeid 22 actid 1",
+        "matchCount": "1",
+        "matchPattern": "Error: Unable to find action by id.*",
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
+        "id": "4817",
+        "name": "Create valid action template with param type bit32, create an instance of action and try to delete action",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test param param1 type bit32",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/test state active",
+                0
+            ],
+            [
+                "$TC actions add action ptables/test param param1 type bit32 id 1 4294967295",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template del action ptables/test",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j actions get action ptables/test index 1",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "ptables/test",
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "bit32",
+                                "value": 4294967295,
+                                "id": 1
+                            }
+                        ],
+                        "index": 1,
+                        "ref": 1,
+                        "bind": 0,
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC actions flush action ptables/test",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/test state inactive",
+                0
+            ],
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
+        "id": "4c0f",
+        "name": "Create valid action template and try to instantiate it without making it active",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test param param1 type macaddr",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC actions add action ptables/test param param1 type macaddr id 1 AA:BB:CC:DD:EE:FF",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get action/ptables/test",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "action template",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "aname": "ptables/test",
+                        "actid": 1,
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "macaddr",
+                                "id": 1
+                            }
+                        ]
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC actions flush action ptables/test",
+                0
+            ],
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
+        "id": "6756",
+        "name": "Create valid action template, make it active and try to update it",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test param param1 type macaddr",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/test state active",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update action/ptables/test param param1 type bit64",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get action/ptables/test",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "action template",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "aname": "ptables/test",
+                        "actid": 1,
+                        "params": [
+                            {
+                                "name": "param1",
+                                "type": "macaddr",
+                                "id": 1
+                            }
+                        ]
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC actions flush action ptables/test",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/test state inactive",
+                0
+            ],
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
+        "id": "a06b",
+        "name": "Create action template, and try to bind action to a filter",
+        "category": [
+            "p4tc",
+            "template"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test actid 1 param param1 type bit32 id 1",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/test state active",
+                0
+            ],
+            [
+                "$TC qdisc add dev $DEV1 ingress",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 prio 65535 protocol ip matchall action ptables/test param param1 type bit32 id 1 4294967295",
+        "expExitCode": "2",
+        "verifyCmd": "$TC -j filter get dev $DEV1 parent ffff: handle 1 prio 65535 protocol ip matchall",
+        "matchCount": "1",
+        "matchPattern": "Error: Cannot find specified filter chain.*",
+        "teardown": [
+            [
+                "$TC qdisc del dev $DEV1 ingress; sleep 1",
+                0
+            ],
+            [
+                "$TC actions flush action ptables/test",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/test state inactive",
+                0
+            ],
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
+        "id": "3495",
+        "name": "Create valid action template with param type bit32 and create an instance of action with incorrect param type",
+        "category": [
+            "p4tc",
+            "template"
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
+                "$TC actions add action pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/test param param1 type bit32",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/test state active",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC actions add action ptables/test param param1 type bit64 id 1 4294967295",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j actions get action ptables/test index 1",
+        "matchCount": "1",
+        "matchPattern": "Error: TC action with specified index not found.*",
+        "teardown": [
+            [
+                "$TC actions flush action ptables/test",
+                0
+            ],
+            [
+                "$TC p4template del pipeline/ptables",
+                0
+            ],
+            [
+                "$TC actions flush action gact",
+                0
+            ]
+        ]
+    }
+]
-- 
2.34.1


