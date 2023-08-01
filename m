Return-Path: <netdev+bounces-23181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E5776B3A8
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E0A1C20CCD
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9358F25170;
	Tue,  1 Aug 2023 11:39:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74391214ED
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:39:00 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0991B0
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 04:38:56 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-63d0d38ff97so24867056d6.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 04:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690889935; x=1691494735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9x6r00O6kUHGstfFr1lrrH147QSK2IhtkB4z6fOnvI=;
        b=eeyT18NxnD6QlGoAUXMSM1QleSPWijWjcYWoBUH/Vk5ITGOLK4TkxM43tTeXUP5jBF
         9wFxxAeyTjuKTuNIhmGLibzETt+td3kpr8eAM4D4nW4nVKWDNJrrDbuim+H6ZeGnxz05
         xtSpQlYR2DWFxRV1Q+KzkHaUVdqoBo/ra0gWXNbU7O8hvsI/P+7va9PsjzudQHgYw/4A
         ZevqP346yrci09L/RhB6x721iEPozGKFckp7TTfYKFhMk5eWj5Kev89/GwwF7Kh1bRH2
         76CioS/SnofDEeqquwgnnyL6QNyiTnzZRzG6yidg7jtUPbMJXUX6J5TcOydYvDOVQcev
         8AYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690889935; x=1691494735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9x6r00O6kUHGstfFr1lrrH147QSK2IhtkB4z6fOnvI=;
        b=OJOXZoV/5pt2uH5+9cCTAyNEU0IcimSjR4g07rVUYLeOTqFiHg4R7BcdzOEk4g4Ii+
         PQpjtjpDzW+5oP/sQ5XJpvNiPJ0h8ATxJlB53BkwfxPvSyQ8Wfm4Vgh19AKUaWFa38G4
         3eD5pqWWg+/6dQYXHy+kCV+pDNYvphq6s7dyDNv5QNRaaQkiozbUPM3/3m7iB3HG541B
         Vt9pzp94EAoNoz6Dxuf9V2yYIlWkjoGpowFCT2OkY5VoifpxxPI3dolM1sMikkTlIZMZ
         NMhtE+oEev9Spct7u7PY9wj3H5Fm8MSX6DyviYb/4RQj1EQqUW0iZyHLqaAcGrqasj6N
         a+Rg==
X-Gm-Message-State: ABy/qLZZY9EWYiigSeTvTD0QzGJmD2aopiC0lAuNp5KioJWyGoSsOZ6g
	Bzky1JIQrZH3hrxthuaGaeP5y+AZsGYEbvL7667oIw==
X-Google-Smtp-Source: APBJJlGIhxsQxbqrY4A/Q3SI6DyO1EE2MSy3XY8Gpca9tCM1fO0hm5fRHHdyNoPFXZdO7O3zR2SD/A==
X-Received: by 2002:a0c:aa95:0:b0:636:1275:8419 with SMTP id f21-20020a0caa95000000b0063612758419mr14769913qvb.13.1690889934589;
        Tue, 01 Aug 2023 04:38:54 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id j1-20020a0cf501000000b0063d26033b74sm4643738qvm.39.2023.08.01.04.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 04:38:53 -0700 (PDT)
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
Subject: [PATCH RFC v5 net-next 22/23] selftests: tc-testing: add P4TC table entries control path tdc tests
Date: Tue,  1 Aug 2023 07:38:06 -0400
Message-Id: <20230801113807.85473-23-jhs@mojatatu.com>
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

Introduce tdc tests for P4TC table entries, which are focused on the
control path. We test table instance create, update, delete, flush and
dump.

Create:
    - Create valid table entry with all possible key types
    - Try to create table entry without specifying mandatory arguments
    - Try to create table entry passing invalid arguments
    - Try to create table entry with same key and prio twice
    - Try to create table entry without sealing the pipeline
    - Try to create table entry with action of unknown kind
    - Try to exceed max table entries count

Update:
    - Try to update table entry with action of inexistent kind
    - Try to update table entry with action of unknown kind
    - Update table entry with new action
    - Create table entry with action and then update table entry
      with another action
    - Create table entry with action, update table entry with another
      action and check action's refs and binds
    - Create table entry without action and then update table entry
      with another action
    - Try to update inexistent table entry

Delete:
    - Delete table entry
    - Try to delete inexistent table entry
    - Try to delete table entry without specifying mandatory arguments
    - Delete table entry specifying IDs for the pipeline and its
    components (table class and table instance)
    - Delete table entry specifying names for the pipeline and its
      components (table class and table instance)
    - Delete table entry with action and check action's refs and binds

Flush:
    - Flush table entries
    - Flush table entries specifying IDS for pipeline and its
    components (table class and table instance)
    - Flush table entries specifying names for pipeline and its
    components (table class and table instance)
    - Try to flush table entries without specifying mandatory arguments

Dump:
    - Dump table entries
    - Dump table entries specifying IDS for pipeline and its
    components (table class and table instance)
    - Dump table entries specifying names for pipeline and its
    components (table class and table instance)
    - Try to dump table entries without specifying mandatory arguments
    - Dump table instance with zero table entries
    - Dump table instance with more than P4TC_MAXMSG_COUNT entries

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../tc-tests/p4tc/table_entries.json          | 5872 +++++++++++++++++
 1 file changed, 5872 insertions(+)
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/p4tc/table_entries.json

diff --git a/tools/testing/selftests/tc-testing/tc-tests/p4tc/table_entries.json b/tools/testing/selftests/tc-testing/tc-tests/p4tc/table_entries.json
new file mode 100644
index 000000000..be7d6313d
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/tc-tests/p4tc/table_entries.json
@@ -0,0 +1,5872 @@
+[
+    {
+        "id": "4bfd",
+        "name": "Create valid table entry with args bit16",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 32 ",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname2 srcPort  80 dstPort  443",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname2 srcPort  80 dstPort  443",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "entries": [
+                    {
+                        "tblid": 2,
+                        "prio": 64000,
+                        "key": [
+                            {
+                                "keyfield": "srcPort",
+                                "id": 1,
+                                "width": 16,
+                                "type": "bit16",
+                                "match_type": "exact",
+                                "fieldval": 80
+                            },
+                            {
+                                "keyfield": "dstPort",
+                                "id": 2,
+                                "width": 16,
+                                "type": "bit16",
+                                "match_type": "exact",
+                                "fieldval": 443
+                            }
+                        ],
+                        "create_whodunnit": "tc",
+                        "permissions": "-RUD--R--X"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname2 srcPort  80 dstPort  443",
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
+        "id": "d574",
+        "name": "Create valid table entry with args  and check entries count",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 32 ",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname2 srcPort  80 dstPort  443",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname2",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22,
+                "obj": "table"
+            },
+            {
+                "templates": [
+                    {
+                        "tname": "cb/tname2",
+                        "keysz": 32,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "entries": 1
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname2 srcPort  80 dstPort  443",
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
+        "id": "6c21",
+        "name": "Create valid table entry with args ipv4",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname type lpm tblid 1 keysz 64 ",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 17",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 17",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "entries": [
+                    {
+                        "tblid": 1,
+                        "prio": 17,
+                        "key": [
+                            {
+                                "keyfield": "srcAddr",
+                                "id": 1,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "10.10.10.0/24"
+                            },
+                            {
+                                "keyfield": "dstAddr",
+                                "id": 2,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "192.168.0.0/16"
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 17",
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
+        "id": "a486",
+        "name": "Create valid table entry with args bit8, bit32, bit64",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104 type exact",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "entries": [
+                    {
+                        "tblid": 3,
+                        "prio": 64000,
+                        "key": [
+                            {
+                                "keyfield": "randomKey1",
+                                "id": 1,
+                                "width": 8,
+                                "type": "bit8",
+                                "match_type": "exact",
+                                "fieldval": 255
+                            },
+                            {
+                                "keyfield": "randomKey2",
+                                "id": 2,
+                                "width": 32,
+                                "type": "bit32",
+                                "match_type": "exact",
+                                "fieldval": 92
+                            },
+                            {
+                                "keyfield": "randomKey3",
+                                "id": 3,
+                                "width": 64,
+                                "type": "bit64",
+                                "match_type": "exact",
+                                "fieldval": 127
+                            }
+                        ]
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+                0
+            ],
+            [
+                "sleep 1",
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
+        "id": "13d9",
+        "name": "Try to create table entry without table name or id",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104 ",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/ randomKey1  255 randomKey2  92 randomKey3  127",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+        "matchCount": "1",
+        "matchPattern": "Error: Unable to find entry.*",
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
+        "id": "0b7c",
+        "name": "Try to create table entry without specifying any keys",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104 ",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname3 prio 1",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+        "matchCount": "1",
+        "matchPattern": "Error: Unable to find entry.*",
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
+        "id": "c2e7",
+        "name": "Create table entry without specifying priority",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "entries": [
+                    {
+                        "tblid": 3,
+                        "prio": 64000,
+                        "key": [
+                            {
+                                "keyfield": "randomKey1",
+                                "id": 1,
+                                "width": 8,
+                                "type": "bit8",
+                                "match_type": "exact",
+                                "fieldval": 255
+                            },
+                            {
+                                "keyfield": "randomKey2",
+                                "id": 2,
+                                "width": 32,
+                                "type": "bit32",
+                                "match_type": "exact",
+                                "fieldval": 92
+                            },
+                            {
+                                "keyfield": "randomKey3",
+                                "id": 3,
+                                "width": 64,
+                                "type": "bit64",
+                                "match_type": "exact",
+                                "fieldval": 127
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC -j p4 del ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
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
+        "id": "9a1e",
+        "name": "Try to create more table entries than allowed",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname type lpm tblid 1 keysz 64 tentries 1",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.56.0/24 prio 1",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.56.0/24 prio 1",
+        "matchCount": "1",
+        "matchPattern": "Error: Unable to find entry.*",
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 16",
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
+        "id": "2095",
+        "name": "Try to create more table entries than allowed after delete",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname type lpm tblid 1 keysz 64 tentries 3",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 16",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 17",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 18",
+                0
+            ],
+            [
+                "$TC p4 del ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 18",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 18",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.56.0/24 prio 1",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.56.0/24 prio 1",
+        "matchCount": "1",
+        "matchPattern": "Error: Unable to find entry.*",
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname",
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
+        "id": "4e6a",
+        "name": "Try to create more table entries than allowed after flush",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname type lpm tblid 1 keysz 64 tentries 1",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 16",
+                0
+            ],
+            [
+                "$TC p4 del ptables/table/cb/tname",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.56.0/24 prio 1",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.56.0/24 prio 1",
+        "matchCount": "1",
+        "matchPattern": "Error: Unable to find entry.*",
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 16",
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
+        "id": "65a2",
+        "name": "Create two entries with same key and different priorities and check first one",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname type lpm tblid 1 keysz 64",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.1.0/16 prio 15",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 16",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "entries": [
+                    {
+                        "tblid": 1,
+                        "prio": 16,
+                        "key": [
+                            {
+                                "keyfield": "srcAddr",
+                                "id": 1,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "10.10.10.0/24"
+                            },
+                            {
+                                "keyfield": "dstAddr",
+                                "id": 2,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "192.168.0.0/16"
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname",
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
+        "id": "a49c",
+        "name": "Create two entries with same key and different priorities and check second one",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname type lpm tblid 1 keysz 64",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.169.0.0/16 prio 15",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.169.0.0/16 prio 15",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "entries": [
+                    {
+                        "tblid": 1,
+                        "prio": 15,
+                        "key": [
+                            {
+                                "keyfield": "srcAddr",
+                                "id": 1,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "10.10.10.0/24"
+                            },
+                            {
+                                "keyfield": "dstAddr",
+                                "id": 2,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "192.169.0.0/16"
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname",
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
+        "id": "2314",
+        "name": "Try to create same entry twice",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname type lpm tblid 1 keysz 64",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.1.0/16 prio 16",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 16",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "entries": [
+                    {
+                        "tblid": 1,
+                        "prio": 16,
+                        "key": [
+                            {
+                                "keyfield": "srcAddr",
+                                "id": 1,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "10.10.10.0/24"
+                            },
+                            {
+                                "keyfield": "dstAddr",
+                                "id": 2,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "192.168.0.0/16"
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname",
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
+        "id": "7d41",
+        "name": "Try to create table entry in unsealed pipeline",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname type lpm tblid 1 keysz 64",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.56.0/24 prio 1",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.56.0/24 prio 1",
+        "matchCount": "1",
+        "matchPattern": "Error: Unable to find entry.",
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
+        "id": "d732",
+        "name": "Try to create table entry with action of inexistent kind",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 32",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname2 srcPort  80 dstPort  443 action noexist index 1",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname2 srcPort  80 dstPort  443",
+        "matchCount": "1",
+        "matchPattern": "Error: Unable to find entry.*",
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
+        "id": "525a",
+        "name": "Try to update table entry with action of inexistent kind",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 32",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname2 srcPort  80 dstPort  443",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 update ptables/table/cb/tname2 srcPort  80 dstPort  443 action noexist index 1",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname2 srcPort  80 dstPort  443",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "entries": [
+                    {
+                        "tblid": 2,
+                        "prio": 64000,
+                        "key": [
+                            {
+                                "keyfield": "srcPort",
+                                "id": 1,
+                                "width": 16,
+                                "type": "bit16",
+                                "match_type": "exact",
+                                "fieldval": 80
+                            },
+                            {
+                                "keyfield": "dstPort",
+                                "id": 2,
+                                "width": 16,
+                                "type": "bit16",
+                                "match_type": "exact",
+                                "fieldval": 443
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname2",
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
+        "id": "ee04",
+        "name": "Update table entry and add action",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/cb/send_nh actid 1 param smac type macaddr id 1 param dmac type macaddr id 2",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/cb/send_nh state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104 table_acts act name ptables/cb/send_nh flags tableonly",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 update ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127 action send_nh param smac b8:ce:f6:4b:68:35 param dmac ac:1f:6b:e4:ff:93 index 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "entries": [
+                    {
+                        "tblid": 3,
+                        "prio": 64000,
+                        "key": [
+                            {
+                                "keyfield": "randomKey1",
+                                "id": 1,
+                                "width": 8,
+                                "type": "bit8",
+                                "match_type": "exact",
+                                "fieldval": 255
+                            },
+                            {
+                                "keyfield": "randomKey2",
+                                "id": 2,
+                                "width": 32,
+                                "type": "bit32",
+                                "match_type": "exact",
+                                "fieldval": 92
+                            },
+                            {
+                                "keyfield": "randomKey3",
+                                "id": 3,
+                                "width": 64,
+                                "type": "bit64",
+                                "match_type": "exact",
+                                "fieldval": 127
+                            }
+                        ],
+                        "create_whodunnit": "tc",
+                        "update_whodunnit": "tc",
+                        "actions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/cb/send_nh",
+                                    "index": 1,
+                                    "ref": 1,
+                                    "bind": 1,
+                                    "params": [
+                                        {
+                                            "name": "smac",
+                                            "id": 1,
+                                            "type": "macaddr",
+                                            "value": "ac:1f:6b:e4:ff:93"
+                                        },
+                                        {
+                                            "name": "dmac",
+                                            "id": 2,
+                                            "type": "macaddr",
+                                            "value": "b8:ce:f6:4b:68:35"
+                                        }
+                                    ]
+                                }
+                            ]
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
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
+        "id": "10b5",
+        "name": "Update table entry and replace action",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/cb/send_nh actid 1 param smac type macaddr id 1 param dmac type macaddr id 2",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/cb/send_nh state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104 table_acts act name ptables/cb/send_nh flags tableonly",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127 action send_nh param smac b8:ce:f6:4b:68:34 param dmac ac:1f:6b:e4:ff:92",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 update ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127 action send_nh param smac b8:ce:f6:4b:68:35 param dmac ac:1f:6b:e4:ff:93",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "entries": [
+                    {
+                        "tblid": 3,
+                        "prio": 64000,
+                        "key": [
+                            {
+                                "keyfield": "randomKey1",
+                                "id": 1,
+                                "width": 8,
+                                "type": "bit8",
+                                "match_type": "exact",
+                                "fieldval": 255
+                            },
+                            {
+                                "keyfield": "randomKey2",
+                                "id": 2,
+                                "width": 32,
+                                "type": "bit32",
+                                "match_type": "exact",
+                                "fieldval": 92
+                            },
+                            {
+                                "keyfield": "randomKey3",
+                                "id": 3,
+                                "width": 64,
+                                "type": "bit64",
+                                "match_type": "exact",
+                                "fieldval": 127
+                            }
+                        ],
+                        "create_whodunnit": "tc",
+                        "update_whodunnit": "tc",
+                        "actions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/cb/send_nh",
+                                    "index": 2,
+                                    "ref": 1,
+                                    "bind": 1,
+                                    "params": [
+                                        {
+                                            "name": "smac",
+                                            "id": 1,
+                                            "type": "macaddr",
+                                            "value": "ac:1f:6b:e4:ff:93"
+                                        },
+                                        {
+                                            "name": "dmac",
+                                            "id": 2,
+                                            "type": "macaddr",
+                                            "value": "b8:ce:f6:4b:68:35"
+                                        }
+                                    ]
+                                }
+                            ]
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+                0
+            ],
+            [
+                "sleep 1",
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
+        "id": "2d50",
+        "name": "Update table entry, replace action and check for action refs and binds",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/cb/send_nh actid 1 param smac type macaddr id 1 param dmac type macaddr id 2",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/cb/send_nh state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104 table_acts act name ptables/cb/send_nh flags tableonly",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC actions add action ptables/cb/send_nh param smac b8:ce:f6:4b:68:35 param dmac ac:1f:6b:e4:ff:93 index 1",
+                0
+            ],
+            [
+                "$TC p4runtime create ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127 action send_nh index 1",
+                0
+            ],
+            [
+                "$TC actions add action ptables/cb/send_nh param smac b8:ce:f6:4b:68:34 param dmac ac:1f:6b:e4:ff:92 index 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4runtime update ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127 action send_nh index 2",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions get action ptables/cb/send_nh index 1",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "ptables/cb/send_nh",
+                        "index": 1,
+                        "ref": 1,
+                        "bind": 0,
+                        "params": [
+                            {
+                                "name": "smac",
+                                "id": 1,
+                                "type": "macaddr",
+                                "value": "ac:1f:6b:e4:ff:93"
+                            },
+                            {
+                                "name": "dmac",
+                                "id": 2,
+                                "type": "macaddr",
+                                "value": "b8:ce:f6:4b:68:35"
+                            }
+                        ]
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+                0
+            ],
+            [
+                "sleep 1",
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
+        "id": "99ef",
+        "name": "Try to update inexistent table entry",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 update ptables/table/cb/tname3 randomKey1  255 randomKey2  1 randomKey3  127",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "entries": [
+                    {
+                        "tblid": 3,
+                        "prio": 64000,
+                        "key": [
+                            {
+                                "keyfield": "randomKey1",
+                                "id": 1,
+                                "width": 8,
+                                "type": "bit8",
+                                "match_type": "exact",
+                                "fieldval": 255
+                            },
+                            {
+                                "keyfield": "randomKey2",
+                                "id": 2,
+                                "width": 32,
+                                "type": "bit32",
+                                "match_type": "exact",
+                                "fieldval": 92
+                            },
+                            {
+                                "keyfield": "randomKey3",
+                                "id": 3,
+                                "width": 64,
+                                "type": "bit64",
+                                "match_type": "exact",
+                                "fieldval": 127
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
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
+        "id": "8868",
+        "name": "Try to update table entry without specifying priority",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/cb/send_nh actid 1 param smac type macaddr id 1 param dmac type macaddr id 2",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/cb/send_nh state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104 table_acts act name ptables/cb/send_nh flags tableonly",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 update ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127 action send_nh",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "entries": [
+                    {
+                        "tblid": 3,
+                        "prio": 64000,
+                        "key": [
+                            {
+                                "keyfield": "randomKey1",
+                                "id": 1,
+                                "width": 8,
+                                "type": "bit8",
+                                "match_type": "exact",
+                                "fieldval": 255
+                            },
+                            {
+                                "keyfield": "randomKey2",
+                                "id": 2,
+                                "width": 32,
+                                "type": "bit32",
+                                "match_type": "exact",
+                                "fieldval": 92
+                            },
+                            {
+                                "keyfield": "randomKey3",
+                                "id": 3,
+                                "width": 64,
+                                "type": "bit64",
+                                "match_type": "exact",
+                                "fieldval": 127
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
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
+        "id": "339a",
+        "name": "Try to update table entry without specifying table name or id",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 update ptables/table/ randomKey1  255 randomKey2  92 randomKey3  127 action gact index 2",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "entries": [
+                    {
+                        "tblid": 3,
+                        "prio": 64000,
+                        "key": [
+                            {
+                                "keyfield": "randomKey1",
+                                "id": 1,
+                                "width": 8,
+                                "type": "bit8",
+                                "match_type": "exact",
+                                "fieldval": 255
+                            },
+                            {
+                                "keyfield": "randomKey2",
+                                "id": 2,
+                                "width": 32,
+                                "type": "bit32",
+                                "match_type": "exact",
+                                "fieldval": 92
+                            },
+                            {
+                                "keyfield": "randomKey3",
+                                "id": 3,
+                                "width": 64,
+                                "type": "bit64",
+                                "match_type": "exact",
+                                "fieldval": 127
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
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
+        "id": "3962",
+        "name": "Delete table entry",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 del ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+        "matchCount": "1",
+        "matchPattern": "Error: Unable to find entry.*",
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
+        "id": "fcc7",
+        "name": "Try to delete table entry without specyfing tblid or table name",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 del ptables/table/ randomKey1  255 randomKey2  92 randomKey3  127",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname3/ randomKey1  255 randomKey2  92 randomKey3  127",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "entries": [
+                    {
+                        "tblid": 3,
+                        "prio": 64000,
+                        "key": [
+                            {
+                                "keyfield": "randomKey1",
+                                "id": 1,
+                                "width": 8,
+                                "type": "bit8",
+                                "match_type": "exact",
+                                "fieldval": 255
+                            },
+                            {
+                                "keyfield": "randomKey2",
+                                "id": 2,
+                                "width": 32,
+                                "type": "bit32",
+                                "match_type": "exact",
+                                "fieldval": 92
+                            },
+                            {
+                                "keyfield": "randomKey3",
+                                "id": 3,
+                                "width": 64,
+                                "type": "bit64",
+                                "match_type": "exact",
+                                "fieldval": 127
+                            }
+                        ]
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
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
+        "id": "c5be",
+        "name": "Delete table entry with action and check action's refs and binds",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/cb/send_nh actid 1 param smac type macaddr id 1 param dmac type macaddr id 2",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/cb/send_nh state active",
+                0
+            ],
+            [
+                "$TC actions add action ptables/cb/send_nh param smac b8:ce:f6:4b:68:35 param dmac ac:1f:6b:e4:ff:93 index 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104 table_acts act name ptables/cb/send_nh flags tableonly",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127 action send_nh index 1",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 del ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions get action ptables/cb/send_nh index 1",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "ptables/cb/send_nh",
+                        "index": 1,
+                        "ref": 1,
+                        "bind": 0,
+                        "params": [
+                            {
+                                "name": "smac",
+                                "id": 1,
+                                "type": "macaddr",
+                                "value": "ac:1f:6b:e4:ff:93"
+                            },
+                            {
+                                "name": "dmac",
+                                "id": 2,
+                                "type": "macaddr",
+                                "value": "b8:ce:f6:4b:68:35"
+                            }
+                        ]
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "sleep 1",
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
+        "id": "4ac6",
+        "name": "Try to delete inexistent table entry",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 del ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+        "matchCount": "1",
+        "matchPattern": "Error: Unable to find entry.*",
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
+        "id": "24a1",
+        "name": "Flush table entries",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname type lpm tblid 1 keysz 64",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 16",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.56.0/24 prio 1",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 del ptables/table/cb/tname",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.56.0/24 prio 1",
+        "matchCount": "1",
+        "matchPattern": "Error: Unable to find entry.*",
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
+        "id": "9770",
+        "name": "Flush table entries using table name",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname type lpm tblid 1 keysz 64",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 16",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.56.0/24 prio 1",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 del ptables/table/cb/tname",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.56.0/24 prio 1",
+        "matchCount": "1",
+        "matchPattern": "Error: Unable to find entry.*",
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
+        "id": "c5b9",
+        "name": "Flush table entries without specifying table name or id",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname type lpm tblid 1 keysz 64",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 16",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.56.0/24 prio 1",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 del ptables/table/",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.56.0/24 prio 1",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "entries": [
+                    {
+                        "tblid": 1,
+                        "prio": 1,
+                        "key": [
+                            {
+                                "keyfield": "srcAddr",
+                                "id": 1,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "10.10.10.0/24"
+                            },
+                            {
+                                "keyfield": "dstAddr",
+                                "id": 2,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "192.168.56.0/24"
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname",
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
+        "id": "03f7",
+        "name": "Dump table entries",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname type lpm tblid 1 keysz 64",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.56.0/24 prio 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "entries": [
+                    {
+                        "tblid": 1,
+                        "prio": 1,
+                        "key": [
+                            {
+                                "keyfield": "srcAddr",
+                                "id": 1,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "10.10.10.0/24"
+                            },
+                            {
+                                "keyfield": "dstAddr",
+                                "id": 2,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "192.168.56.0/24"
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname",
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
+        "id": "0caa",
+        "name": "Try to dump table entries without specifying table name or id",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname type lpm tblid 1 keysz 64",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.56.0/24 prio 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4 get ptables/table/",
+        "matchCount": "1",
+        "matchPattern": "Error: Must specify table name or id.*",
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname",
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
+        "id": "6a9e",
+        "name": "Try to dump table entries when no entries were created",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname type lpm tblid 1 keysz 64",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update pipeline/ptables state ready",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname",
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
+        "id": "1406",
+        "name": "Dump table with more than P4TC_MAXMSG_COUNT entries",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname type lpm tblid 1 keysz 64",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 1",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 2",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 3",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 4",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 5",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 6",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 7",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 8",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 9",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 10",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 11",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 12",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 13",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 14",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 15",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.0.0/16 prio 17",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname/",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "entries": [
+                    {
+                        "tblid": 1,
+                        "key": [
+                            {
+                                "keyfield": "srcAddr",
+                                "id": 1,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "10.10.10.0/24"
+                            },
+                            {
+                                "keyfield": "dstAddr",
+                                "id": 2,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "192.168.0.0/16"
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 16,
+                        "key": [
+                            {
+                                "keyfield": "srcAddr",
+                                "id": 1,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "10.10.10.0/24"
+                            },
+                            {
+                                "keyfield": "dstAddr",
+                                "id": 2,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "192.168.0.0/16"
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 15,
+                        "key": [
+                            {
+                                "keyfield": "srcAddr",
+                                "id": 1,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "10.10.10.0/24"
+                            },
+                            {
+                                "keyfield": "dstAddr",
+                                "id": 2,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "192.168.0.0/16"
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 14,
+                        "key": [
+                            {
+                                "keyfield": "srcAddr",
+                                "id": 1,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "10.10.10.0/24"
+                            },
+                            {
+                                "keyfield": "dstAddr",
+                                "id": 2,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "192.168.0.0/16"
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 13,
+                        "key": [
+                            {
+                                "keyfield": "srcAddr",
+                                "id": 1,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "10.10.10.0/24"
+                            },
+                            {
+                                "keyfield": "dstAddr",
+                                "id": 2,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "192.168.0.0/16"
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 12,
+                        "key": [
+                            {
+                                "keyfield": "srcAddr",
+                                "id": 1,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "10.10.10.0/24"
+                            },
+                            {
+                                "keyfield": "dstAddr",
+                                "id": 2,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "192.168.0.0/16"
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 11,
+                        "key": [
+                            {
+                                "keyfield": "srcAddr",
+                                "id": 1,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "10.10.10.0/24"
+                            },
+                            {
+                                "keyfield": "dstAddr",
+                                "id": 2,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "192.168.0.0/16"
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 10,
+                        "key": [
+                            {
+                                "keyfield": "srcAddr",
+                                "id": 1,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "10.10.10.0/24"
+                            },
+                            {
+                                "keyfield": "dstAddr",
+                                "id": 2,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "192.168.0.0/16"
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 9,
+                        "key": [
+                            {
+                                "keyfield": "srcAddr",
+                                "id": 1,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "10.10.10.0/24"
+                            },
+                            {
+                                "keyfield": "dstAddr",
+                                "id": 2,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "192.168.0.0/16"
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 8,
+                        "key": [
+                            {
+                                "keyfield": "srcAddr",
+                                "id": 1,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "10.10.10.0/24"
+                            },
+                            {
+                                "keyfield": "dstAddr",
+                                "id": 2,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "192.168.0.0/16"
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 7,
+                        "key": [
+                            {
+                                "keyfield": "srcAddr",
+                                "id": 1,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "10.10.10.0/24"
+                            },
+                            {
+                                "keyfield": "dstAddr",
+                                "id": 2,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "192.168.0.0/16"
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 6,
+                        "key": [
+                            {
+                                "keyfield": "srcAddr",
+                                "id": 1,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "10.10.10.0/24"
+                            },
+                            {
+                                "keyfield": "dstAddr",
+                                "id": 2,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "192.168.0.0/16"
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 5,
+                        "key": [
+                            {
+                                "keyfield": "srcAddr",
+                                "id": 1,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "10.10.10.0/24"
+                            },
+                            {
+                                "keyfield": "dstAddr",
+                                "id": 2,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "192.168.0.0/16"
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 4,
+                        "key": [
+                            {
+                                "keyfield": "srcAddr",
+                                "id": 1,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "10.10.10.0/24"
+                            },
+                            {
+                                "keyfield": "dstAddr",
+                                "id": 2,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "192.168.0.0/16"
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 3,
+                        "key": [
+                            {
+                                "keyfield": "srcAddr",
+                                "id": 1,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "10.10.10.0/24"
+                            },
+                            {
+                                "keyfield": "dstAddr",
+                                "id": 2,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "192.168.0.0/16"
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 2,
+                        "key": [
+                            {
+                                "keyfield": "srcAddr",
+                                "id": 1,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "10.10.10.0/24"
+                            },
+                            {
+                                "keyfield": "dstAddr",
+                                "id": 2,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "192.168.0.0/16"
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    }
+                ]
+            },
+            {
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "entries": [
+                    {
+                        "tblid": 1,
+                        "key": [
+                            {
+                                "keyfield": "srcAddr",
+                                "id": 1,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "10.10.10.0/24"
+                            },
+                            {
+                                "keyfield": "dstAddr",
+                                "id": 2,
+                                "width": 32,
+                                "type": "ipv4",
+                                "match_type": "exact",
+                                "fieldval": "192.168.0.0/16"
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname",
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
+        "id": "2515",
+        "name": "Try to create table entry without permission",
+        "category": [
+            "p4tc",
+            "template",
+            "table"
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
+            ],
+            [
+                "$TC actions add action ok index 3",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 32 permissions 0x1FF",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname2 srcPort 80 dstPort 443",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname2 srcPort 80 dstPort 443",
+        "matchCount": "1",
+        "matchPattern": "Error: Unable to find entry.*",
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
+        "id": "f803",
+        "name": "Try to create table entry without more permissions than allowed",
+        "category": [
+            "p4tc",
+            "template",
+            "table"
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
+            ],
+            [
+                "$TC actions add action ok index 3",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 32 permissions 0x3C9",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname2 srcPort 80 dstPort 443 permissions 0x1CF",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname2 srcPort 80 dstPort 443",
+        "matchCount": "1",
+        "matchPattern": "Error: Unable to find entry.*",
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
+        "id": "0de2",
+        "name": "Try to update table entry without permission",
+        "category": [
+            "p4tc",
+            "template",
+            "table"
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
+            ],
+            [
+                "$TC actions add action ok index 3",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 32 permissions 0x3FF",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname2 srcPort 80 dstPort 443 permissions 0x16F",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 update ptables/table/cb/tname2 srcPort 80 dstPort 443",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname2 srcPort 80 dstPort 443",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "entries": [
+                    {
+                        "tblid": 2,
+                        "prio": 64000,
+                        "key": [
+                            {
+                                "keyfield": "srcPort",
+                                "id": 1,
+                                "width": 16,
+                                "type": "bit16",
+                                "match_type": "exact",
+                                "fieldval": 80
+                            },
+                            {
+                                "keyfield": "dstPort",
+                                "id": 2,
+                                "width": 16,
+                                "type": "bit16",
+                                "match_type": "exact",
+                                "fieldval": 443
+                            }
+                        ],
+                        "create_whodunnit": "tc",
+                        "permissions": "-R-DX-RUDX"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname2",
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
+        "id": "4540",
+        "name": "Try to delete table entry without permission",
+        "category": [
+            "p4tc",
+            "template",
+            "table"
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
+            ],
+            [
+                "$TC actions add action ok index 3",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 32 permissions 0x3FF",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname2 srcPort 80 dstPort 443 permissions 0x1AF",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 del ptables/table/cb/tname2 srcPort 80 dstPort 443",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname2 srcPort 80 dstPort 443",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "entries": [
+                    {
+                        "tblid": 2,
+                        "prio": 64000,
+                        "key": [
+                            {
+                                "keyfield": "srcPort",
+                                "id": 1,
+                                "width": 16,
+                                "type": "bit16",
+                                "match_type": "exact",
+                                "fieldval": 80
+                            },
+                            {
+                                "keyfield": "dstPort",
+                                "id": 2,
+                                "width": 16,
+                                "type": "bit16",
+                                "match_type": "exact",
+                                "fieldval": 443
+                            }
+                        ],
+                        "create_whodunnit": "tc",
+                        "permissions": "-RU-X-RUDX"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 update ptables/table/cb/tname2 srcPort 80 dstPort 443 permissions 0x1EF",
+                0
+            ],
+            [
+                "$TC p4 del ptables/table/cb/tname2/",
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
+        "id": "51cb",
+        "name": "Simulate constant entries",
+        "category": [
+            "p4tc",
+            "template",
+            "table"
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
+            ],
+            [
+                "$TC actions add action ok index 3",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 32 permissions 0x3FF",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname2 srcPort 80 dstPort 443",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4runtime update ptables/table/cb/tname2 tbl_attrs tbl_permissions 0x1FF",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname2/",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "entries": [
+                    {
+                        "tblid": 2,
+                        "prio": 64000,
+                        "key": [
+                            {
+                                "keyfield": "srcPort",
+                                "id": 1,
+                                "width": 16,
+                                "type": "bit16",
+                                "match_type": "exact",
+                                "fieldval": 80
+                            },
+                            {
+                                "keyfield": "dstPort",
+                                "id": 2,
+                                "width": 16,
+                                "type": "bit16",
+                                "match_type": "exact",
+                                "fieldval": 443
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname2/",
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
+        "id": "3ead",
+        "name": "Simulate constant entries and try to add additional entry",
+        "category": [
+            "p4tc",
+            "template",
+            "table"
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
+            ],
+            [
+                "$TC actions add action ok index 3",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 32 permissions 0x3FF",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname2 srcPort 80 dstPort 443",
+                0
+            ],
+            [
+                "$TC p4runtime update ptables/table/cb/tname2 tbl_attrs tbl_permissions 0x1FF",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname2 srcPort 53 dstPort 53",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname2/",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "entries": [
+                    {
+                        "tblid": 2,
+                        "prio": 64000,
+                        "key": [
+                            {
+                                "keyfield": "srcPort",
+                                "id": 1,
+                                "width": 16,
+                                "type": "bit16",
+                                "match_type": "exact",
+                                "fieldval": 80
+                            },
+                            {
+                                "keyfield": "dstPort",
+                                "id": 2,
+                                "width": 16,
+                                "type": "bit16",
+                                "match_type": "exact",
+                                "fieldval": 443
+                            }
+                        ],
+                        "create_whodunnit": "tc"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname2/",
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
+        "id": "d292",
+        "name": "Create valid constant table entry with args bit16",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 32",
+                0
+            ],
+            [
+                "$TC p4template update table/ptables/cb/tname2 entry srcPort  80 dstPort  443",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update pipeline/ptables state ready",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname2 srcPort 80 dstPort 443",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "entries": [
+                    {
+                        "tblid": 2,
+                        "prio": 64000,
+                        "key": [
+                            {
+                                "keyfield": "srcPort",
+                                "id": 1,
+                                "width": 16,
+                                "type": "bit16",
+                                "match_type": "exact",
+                                "fieldval": 80
+                            },
+                            {
+                                "keyfield": "dstPort",
+                                "id": 2,
+                                "width": 16,
+                                "type": "bit16",
+                                "match_type": "exact",
+                                "fieldval": 443
+                            }
+                        ],
+                        "create_whodunnit": "tc",
+                        "permissions": "-RUD--R--X"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname2 srcPort  80 dstPort  443",
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
+        "id": "7c49",
+        "name": "Update table default_hit_action in runtime",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/ingress/drop actid 2",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/ingress/drop state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 16 table_acts act name ptables/ingress/drop flags defaultonly",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4runtime update ptables/table/cb/tname2 tbl_attrs default_hit_action action ptables/ingress/drop",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname2",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "table",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "tblid": 2,
+                        "tname": "cb/tname2",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "default_hit": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/ingress/drop",
+                                    "index": 1,
+                                    "ref": 1,
+                                    "bind": 1,
+                                    "params": []
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
+        "id": "7121",
+        "name": "Update table default_miss_action in runtime",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/ingress/drop actid 2",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/ingress/drop state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 16 table_acts act name ptables/ingress/drop flags defaultonly",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4runtime update ptables/table/cb/tname2 tbl_attrs default_miss_action action ptables/ingress/drop",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname2",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "table",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "tblid": 2,
+                        "tname": "cb/tname2",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "default_miss": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/ingress/drop",
+                                    "index": 1,
+                                    "ref": 1,
+                                    "bind": 1,
+                                    "params": []
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
+        "id": "0aba",
+        "name": "Update table default_miss_action and its permissions",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/ingress/drop actid 2",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/ingress/drop state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 16 table_acts act name ptables/ingress/drop flags defaultonly",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4runtime update ptables/table/cb/tname2 tbl_attrs default_miss_action permissions 0x37f action ptables/ingress/drop",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname2",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "table",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "tblid": 2,
+                        "tname": "cb/tname2",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "default_miss": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/ingress/drop",
+                                    "index": 1,
+                                    "ref": 1,
+                                    "bind": 1,
+                                    "params": []
+                                }
+                            ],
+                            "permissions": "CR-DXCRUDX"
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
+        "id": "ecab",
+        "name": "Update only table default_hit_action permissions in runtime",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/ingress/drop actid 2",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/ingress/drop state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 16 table_acts act name ptables/ingress/drop flags defaultonly",
+                0
+            ],
+            [
+                "$TC p4template update table/ptables/ tblid 2 default_hit_action permissions 0x37F action ptables/ingress/drop",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4runtime update ptables/table/cb/tname2 tbl_attrs default_hit_action permissions 0x37f",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname2",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "table",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "tblid": 2,
+                        "tname": "cb/tname2",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "default_hit": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/ingress/drop",
+                                    "index": 1,
+                                    "ref": 1,
+                                    "bind": 1,
+                                    "params": []
+                                }
+                            ],
+                            "permissions": "CR-DXCRUDX"
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
+        "id": "ac8c",
+        "name": "Update only table default_miss_action permissions in runtime",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/ingress/drop actid 2",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/ingress/drop state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 16 table_acts act name ptables/ingress/drop flags defaultonly",
+                0
+            ],
+            [
+                "$TC p4template update table/ptables/ tblid 2 default_miss_action permissions 0x37F action ptables/ingress/drop",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4runtime update ptables/table/cb/tname2 tbl_attrs default_miss_action permissions 0x3ff",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname2",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "table",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "tblid": 2,
+                        "tname": "cb/tname2",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "default_miss": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/ingress/drop",
+                                    "index": 1,
+                                    "ref": 1,
+                                    "bind": 1,
+                                    "params": []
+                                }
+                            ],
+                            "permissions": "CRUDXCRUDX"
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
+        "id": "a63e",
+        "name": "Try to update table default_miss_action without permission in runtime",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/ingress/drop actid 2",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/ingress/drop state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 16 table_acts act name ptables/ingress/drop flags defaultonly",
+                0
+            ],
+            [
+                "$TC p4template update table/ptables/ tblid 2 default_miss_action permissions 0x37F action ptables/ingress/drop",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4runtime update ptables/table/cb/tname2 tbl_attrs default_miss_action permissions 0x2ff action ptables/ingress/drop",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname2",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "table",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "tblid": 2,
+                        "tname": "cb/tname2",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "default_miss": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/ingress/drop",
+                                    "index": 1,
+                                    "ref": 1,
+                                    "bind": 1,
+                                    "params": []
+                                }
+                            ],
+                            "permissions": "CR-DXCRUDX"
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
+        "id": "5524",
+        "name": "Try to update table default_hit_action without permission in runtime",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/ingress/drop actid 2",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/ingress/drop state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 16 table_acts act name ptables/ingress/drop flags defaultonly",
+                0
+            ],
+            [
+                "$TC p4template update table/ptables/ tblid 2 default_hit_action permissions 0x37F action ptables/ingress/drop",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4runtime update ptables/table/cb/tname2 tbl_attrs default_hit_action permissions 0x2ff action ptables/ingress/drop",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname2",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "table",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "tblid": 2,
+                        "tname": "cb/tname2",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "default_hit": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/ingress/drop",
+                                    "index": 1,
+                                    "ref": 1,
+                                    "bind": 1,
+                                    "params": []
+                                }
+                            ],
+                            "permissions": "CR-DXCRUDX"
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
+        "id": "9890",
+        "name": "Try to update table default_hit_action permissions without data path execute",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/ingress/drop actid 2",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/ingress/drop state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 16 table_acts act name ptables/ingress/drop flags defaultonly",
+                0
+            ],
+            [
+                "$TC p4template update table/ptables/ tblid 2 default_hit_action permissions 0x37F action ptables/ingress/drop",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4runtime update ptables/table/cb/tname2 tbl_attrs default_hit_action permissions 0x3fe",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname2",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "table",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "tblid": 2,
+                        "tname": "cb/tname2",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "default_hit": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/ingress/drop",
+                                    "index": 1,
+                                    "ref": 1,
+                                    "bind": 1,
+                                    "params": []
+                                }
+                            ],
+                            "permissions": "CR-DXCRUDX"
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
+        "id": "5fdc",
+        "name": "Try to update table default_miss_action permissions without data path execute",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/ingress/drop actid 2",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/ingress/drop state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 16 table_acts act name ptables/ingress/drop flags defaultonly",
+                0
+            ],
+            [
+                "$TC p4template update table/ptables/ tblid 2 default_miss_action permissions 0x37F action ptables/ingress/drop",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4runtime update ptables/table/cb/tname2 tbl_attrs default_miss_action permissions 0x3fe",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname2",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "table",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "tblid": 2,
+                        "tname": "cb/tname2",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "default_miss": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/ingress/drop",
+                                    "index": 1,
+                                    "ref": 1,
+                                    "bind": 1,
+                                    "params": []
+                                }
+                            ],
+                            "permissions": "CR-DXCRUDX"
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
+        "id": "68cf",
+        "name": "Try to update table default_hit_action permissions without data path read",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/ingress/drop actid 2",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/ingress/drop state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 16 table_acts act name ptables/ingress/drop flags defaultonly",
+                0
+            ],
+            [
+                "$TC p4template update table/ptables/ tblid 2 default_hit_action permissions 0x37F action ptables/ingress/drop",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4runtime update ptables/table/cb/tname2 tbl_attrs default_hit_action permissions 0x3f7",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname2",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "table",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "tblid": 2,
+                        "tname": "cb/tname2",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "default_hit": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/ingress/drop",
+                                    "index": 1,
+                                    "ref": 1,
+                                    "bind": 1,
+                                    "params": []
+                                }
+                            ],
+                            "permissions": "CR-DXCRUDX"
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
+        "id": "e439",
+        "name": "Try to update table default_miss_action permissions without data path read",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/ingress/drop actid 2",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/ingress/drop state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 16 table_acts act name ptables/ingress/drop flags defaultonly",
+                0
+            ],
+            [
+                "$TC p4template update table/ptables/ tblid 2 default_miss_action permissions 0x37F action ptables/ingress/drop",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4runtime update ptables/table/cb/tname2 tbl_attrs default_miss_action permissions 0x3f7",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname2",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "table",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "tblid": 2,
+                        "tname": "cb/tname2",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "default_miss": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/ingress/drop",
+                                    "index": 1,
+                                    "ref": 1,
+                                    "bind": 1,
+                                    "params": []
+                                }
+                            ],
+                            "permissions": "CR-DXCRUDX"
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
+        "id": "56fe",
+        "name": "Try to update table default_hit_action permissions without ctrl path read",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/ingress/drop actid 2",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/ingress/drop state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 16 table_acts act name ptables/ingress/drop flags defaultonly",
+                0
+            ],
+            [
+                "$TC p4template update table/ptables/ tblid 2 default_hit_action permissions 0x37F action ptables/ingress/drop",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4runtime update ptables/table/cb/tname2 tbl_attrs default_hit_action permissions 0x2ff",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname2",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "table",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "tblid": 2,
+                        "tname": "cb/tname2",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "default_hit": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/ingress/drop",
+                                    "index": 1,
+                                    "ref": 1,
+                                    "bind": 1,
+                                    "params": []
+                                }
+                            ],
+                            "permissions": "CR-DXCRUDX"
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
+        "id": "a188",
+        "name": "Try to update table default_hit_action permissions without ctrl path read",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/ingress/drop actid 2",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/ingress/drop state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 16 table_acts act name ptables/ingress/drop flags defaultonly",
+                0
+            ],
+            [
+                "$TC p4template update table/ptables/ tblid 2 default_hit_action permissions 0x37F action ptables/ingress/drop",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4runtime update ptables/table/cb/tname2 tbl_attrs default_hit_action permissions 0x2ff",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname2",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "table",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "tblid": 2,
+                        "tname": "cb/tname2",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "default_hit": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/ingress/drop",
+                                    "index": 1,
+                                    "ref": 1,
+                                    "bind": 1,
+                                    "params": []
+                                }
+                            ],
+                            "permissions": "CR-DXCRUDX"
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
+        "id": "fb9e",
+        "name": "Update table permissions in runtime",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/ingress/drop actid 2",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/ingress/drop state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 16 table_acts act name ptables/ingress/drop flags defaultonly",
+                0
+            ],
+            [
+                "$TC p4template update table/ptables/ tblid 2 default_miss_action permissions 0x37F action ptables/ingress/drop",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4runtime update ptables/table/cb/tname2 tbl_attrs tbl_permissions 0x37f",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname2",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "table",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "tblid": 2,
+                        "tname": "cb/tname2",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "default_miss": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/ingress/drop",
+                                    "index": 1,
+                                    "ref": 1,
+                                    "bind": 1,
+                                    "params": []
+                                }
+                            ],
+                            "permissions": "CR-DXCRUDX"
+                        },
+                        "permissions": "CR-DXCRUDX"
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
+        "id": "3afd",
+        "name": "Try to update table permissions in runtime without data path exec permissions",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/ingress/drop actid 2",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/ingress/drop state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 16 table_acts act name ptables/ingress/drop flags defaultonly",
+                0
+            ],
+            [
+                "$TC p4template update table/ptables/ tblid 2 default_miss_action permissions 0x37F action ptables/ingress/drop",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4runtime update ptables/table/cb/tname2 tbl_attrs tbl_permissions 0x3fe",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname2",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "table",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "tblid": 2,
+                        "tname": "cb/tname2",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "default_miss": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/ingress/drop",
+                                    "index": 1,
+                                    "ref": 1,
+                                    "bind": 1,
+                                    "params": []
+                                }
+                            ],
+                            "permissions": "CR-DXCRUDX"
+                        },
+                        "permissions": "CRUD--R--X"
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
+        "id": "b65d",
+        "name": "Try to update table permissions in runtime without data path read permissions",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/ingress/drop actid 2",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/ingress/drop state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 16 table_acts act name ptables/ingress/drop flags defaultonly",
+                0
+            ],
+            [
+                "$TC p4template update table/ptables/ tblid 2 default_miss_action permissions 0x37F action ptables/ingress/drop",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4runtime update ptables/table/cb/tname2 tbl_attrs tbl_permissions 0x3f7",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname2",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "table",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "tblid": 2,
+                        "tname": "cb/tname2",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "default_miss": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/ingress/drop",
+                                    "index": 1,
+                                    "ref": 1,
+                                    "bind": 1,
+                                    "params": []
+                                }
+                            ],
+                            "permissions": "CR-DXCRUDX"
+                        },
+                        "permissions": "CRUD--R--X"
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
+        "id": "86b0",
+        "name": "Try to update table with permissions with more than 10 bits",
+        "category": [
+            "p4tc",
+            "entries"
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
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/ingress/drop actid 2",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/ingress/drop state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 2 keysz 16 table_acts act name ptables/ingress/drop flags defaultonly",
+                0
+            ],
+            [
+                "$TC p4template update table/ptables/ tblid 2 default_miss_action permissions 0x37F action ptables/ingress/drop",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4runtime update ptables/table/cb/tname2 tbl_attrs tbl_permissions 0x337F",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname2",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "obj": "table",
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "templates": [
+                    {
+                        "tblid": 2,
+                        "tname": "cb/tname2",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "default_miss": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/ingress/drop",
+                                    "index": 1,
+                                    "ref": 1,
+                                    "bind": 1,
+                                    "params": []
+                                }
+                            ],
+                            "permissions": "CR-DXCRUDX"
+                        },
+                        "permissions": "CRUD--R--X"
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
+    }
+]
-- 
2.34.1


