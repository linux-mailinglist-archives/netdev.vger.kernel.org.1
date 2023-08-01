Return-Path: <netdev+bounces-23179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B59376B39D
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877A71C206FD
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6DB2515D;
	Tue,  1 Aug 2023 11:38:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D2E214ED
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:38:59 +0000 (UTC)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A53E6F
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 04:38:54 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-44768e056e1so1830036137.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 04:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690889933; x=1691494733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pu0plkMtDiBLL0OU3zcJktjIYAsrFK9THwj8aq0OXyQ=;
        b=H9BEx1ezTvRuJezfdXMOWcAeDAWyzrBy9KIV1AqW2JwT7mlMwlL8Jjq11VLDDtigeZ
         WvoAIN9muMiMHBl3PqgEQ3tVMhIxVIOPYR0xpNvc+etV4fui3bTJrfLO7+LFRdzApyP8
         mp+fCzj0QOZmH1LEhsiMxmOneOYLZ9v11GGnxQeLG3uqNZ1pih7ERCi6gFrv2chmo8LS
         tkTh1L4p6YC1yJlr1BpcitvNd3wefRJ71iDl9F0A7f6pTU0ZjlRh/7r8ptSxVMaKVpgl
         k6vjHSYqsvsa8G1SLFyjaCqu9esBQaBQFZV8Zs7Wii+8ocYwlA2Oyuw5oz/Q1L9pqH1R
         SYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690889933; x=1691494733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pu0plkMtDiBLL0OU3zcJktjIYAsrFK9THwj8aq0OXyQ=;
        b=lydDqfDPOvjnPas3M5YWmBz3ursT5pcazwdxCJ6ZiMU7NOLmoy/fLk+oQk/6dxwoFg
         t6FflMbhOhfEWR1OSd5vyzI1uUM+SxNkP1SdSu2Cbck3LX4KYFH17GYpRl2sfa/gv1Hw
         BDq3qWkfadFewM76exi1o4yM0HUcYI54LiwryPR3sttrGSQxqwuoGKw9SBlTtuMT4taM
         McX4Ro9Gzl/YSIor9rC6OLfULqVAAhr7gu2LAAvslOurdwIUb9lQktcXAwxZnIe2HKdi
         WTCe5T8rH9+EU04py+mAQutCyg+Nq8BUamKYCP5rDkAAdt+kCq2BkjwAQqzyST9mGBzi
         DuVA==
X-Gm-Message-State: ABy/qLZaafWcKXHbf5Fn3kUhdVfCFY0PBNbeydanCe2BdDatuw8CoXjq
	vFE6C7LHlnfJiYCqf01za6Y2qd2SeJ7oKwiwVwLI1w==
X-Google-Smtp-Source: APBJJlF0/HAghOpwgRhzpCcFlplOV07DUnCnvqNiyhhqsBb2Df1qjYd4eOsZ5cdD8eYADA7yThPmfg==
X-Received: by 2002:a67:ff1a:0:b0:443:70bd:719b with SMTP id v26-20020a67ff1a000000b0044370bd719bmr1899004vsp.0.1690889932374;
        Tue, 01 Aug 2023 04:38:52 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id j1-20020a0cf501000000b0063d26033b74sm4643738qvm.39.2023.08.01.04.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 04:38:51 -0700 (PDT)
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
Subject: [PATCH RFC v5 net-next 21/23] selftests: tc-testing: add P4TC table control path tdc tests
Date: Tue,  1 Aug 2023 07:38:05 -0400
Message-Id: <20230801113807.85473-22-jhs@mojatatu.com>
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

Introduce tdc tests for P4TC table, which are focused on the
control path. We test table create, update, delete, flush and
dump.

Here is a basic description of what we test for each operation:

Create:
    - Create valid table
    - Try to create table without specifying mandatory arguments
    - Create table without specifying optional arguments and check
      optional values after creation
    - Try to create table passing invalid arguments
    - Try to create table with same name twice
    - Try to create table with same id twice
    - Create a table with table id == INX_MAX (2147483647) and
      check for overflow warning when traversing table IDR
    - Try to create table with name length > TTYPENAMSIZ
    - Try to create table without specifying pipeline name or id
    - Create valid table with more than one key
    - Try to create table adding more than P4TC_MAXPARSE_KEYS keys
    - Create table and update pipeline state
    - Create table, update pipeline state and try to update pipeline
      after pipeline is sealed
    - Create table, update pipeline state and try to update table
      type after pipeline is sealed
    - Create table with keys with more than one action

Update:
    - Update table with valid argument values
    - Try to update table with invalid argument values
    - Try to update table without specifying table name or id
    - Try to update table without specifying pipeline name or id
    - Try to update table with invalid values
    - Check action bind and ref values after table's key's action
    - Check action bind and ref values after table's postaction
      update
    - Update table and add new key without specifying id
    - Try to update table adding more P4TC_MAXPARSE_KEYS keys
    - Update table key with more than one action
    - Try to create more table then numtclass in pipeline

Delete:
    - Delete table by name
    - Delete table by id
    - Delete nonexistent table by name
    - Delete nonexistent table by id
    - Try to delete table without supplying pipeline name or id
    - Flush table
    - Try to flush table without supplying pipeline name or id
    - Check action bind and ref values after table deletion

Dump:
    - Dump table IDR using pipeline name to find pipeline
    - Dump table IDR using pipeline id to find pipeline
    - Try to dump table IDR without specifying pipeline name or id
    - Dump table IDR which has more than P4TC_MAXMSG_COUNT (16)
      elements

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../tc-testing/tc-tests/p4tc/table.json       | 6944 +++++++++++++++++
 1 file changed, 6944 insertions(+)
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/p4tc/table.json

diff --git a/tools/testing/selftests/tc-testing/tc-tests/p4tc/table.json b/tools/testing/selftests/tc-testing/tc-tests/p4tc/table.json
new file mode 100644
index 000000000..8d99b71d8
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/tc-tests/p4tc/table.json
@@ -0,0 +1,6944 @@
+[
+    {
+        "id": "60b7",
+        "name": "Create valid table",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname keysz 16",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 1,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "4765",
+        "name": "Try to create table without name",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/ keysz 16",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Error: Table name not found.*",
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
+        "id": "3d3c",
+        "name": "Try to create table without keysz",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Error: Table name not found.*",
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
+        "id": "b48a",
+        "name": "Try to create table with keysz zero",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname keysz 0",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Table name not found.*",
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
+        "id": "cc89",
+        "name": "Try to create table with keysz > P4TC_MAX_KEYSZ",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname keysz 513",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Table name not found.*",
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
+        "id": "efba",
+        "name": "Try to create table with tentries > P4TC_MAX_TENTRIES",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname keysz 16 tentries 16777217",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Table name not found.*",
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
+        "id": "a24a",
+        "name": "Create table with tentries = P4TC_MAX_TENTRIES",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 tentries 16777216",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 16777216,
+                        "masks": 8
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
+        "id": "67b7",
+        "name": "Try to create table with tentries zero",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname keysz 16 tentries 0",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Table name not found.*",
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
+        "id": "e8e8",
+        "name": "Try to create table with nummasks > P4TC_MAX_TMASKS",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname keysz 16 tmasks 1025",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Table name not found.*",
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
+        "id": "6b5b",
+        "name": "Create table wth nummasks = P4TC_MAX_TMASKS",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 nummasks 128",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 128
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
+        "id": "615c",
+        "name": "Try to create table with nummasks zero",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname keysz 16 nummasks 0",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Table name not found.*",
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
+        "id": "ef97",
+        "name": "Create table with specific tt_id",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname tblid 42 keysz 16",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 42,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "7a0f",
+        "name": "Try to create table same name twice",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname keysz 16",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 1,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "bd8d",
+        "name": "Try to create table same id twice",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname2 tblid 22 keysz 16",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/ tblid 22",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "eeaf",
+        "name": "Try to create table without supplying pipeline name or id",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ tblid 1 keysz 16",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Table name not found.*",
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
+        "id": "f35d",
+        "name": "Create table without supplying keys",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname keysz 16",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 1,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "b3c9",
+        "name": "Try to create table with name size > TCLASSNAMSIZ",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/7eozFYyaqVCD7H0xS3M5sMnluUqPgZewfSLnYPf4s3k0lbx8lKoR32zSqiGsh84qJ32vnLPdl7f2XcUh5yIdEP7uJy2C3iPtyU7159s9CMB0EtTAlWTVz4U1jkQ5h2advwp3KCVsZ1jlGgStoJL2op5ZxoThTSUQLR61a5RNDovoSFcq86Brh6oW9DSmTbN6SYygbG3JLnEHzRC5hh0jGmJKHq5ivBK9Y9FlNZQXC9wVwX4qTFAd8ITUTj2Au2Jg1 keysz 16",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Table name not found.*",
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
+        "id": "40b0",
+        "name": "Create table with tblid of 4 bytes",
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
+                "$TC actions add action gact pass index 1",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action gact pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname tblid 2147483647 keysz 16",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/ tblid 2147483647",
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
+                        "tblid": 2147483647,
+                        "tname": "cb/tname"
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
+        "id": "eea7",
+        "name": "Update table's key size specifying table name",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/cb/tname keysz 32",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 32,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "5d07",
+        "name": "Update table's key size specifying table id",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ pipeid 22 tblid 22 keysz 32",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 32,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "46f5",
+        "name": "Try to update table's key size with zero",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/ tblid 22 keysz 0",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "8306",
+        "name": "Try to update table's key size with > P4TC_MAX_KEYSZ",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/ tblid 22 keysz 513",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "0d12",
+        "name": "Update table's with key size = P4TC_MAX_KEYSZ",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/ tblid 22 keysz 512",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 512,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "67c0",
+        "name": "Try to update table tentries with zero",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/ tblid 22 tentries 0",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "dfd1",
+        "name": "Try to update table wth tentries > P4TC_MAX_TENTRIES",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/ tblid 22 tentries 16777217",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "36e3",
+        "name": "Update table with tentries = P4TC_MAX_TENTRIES",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/ tblid 22 tentries 16777216",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 16777216,
+                        "masks": 8
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
+        "id": "5c80",
+        "name": "Try to update table masks with zero",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/ tblid 22 nummasks 0",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "011b",
+        "name": "Try to update table with nummasks > P4TC_MAX_TMASKS",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/ tblid 22 nummasks 1025",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "102b",
+        "name": "Update table with nummasks = P4TC_MAX_TMASKS",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/ tblid 22 nummasks 128",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 128
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
+        "id": "a7f3",
+        "name": "Delete table by name",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template del table/ptables/cb/tname",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Error: Table name not found.*",
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
+        "id": "9524",
+        "name": "Delete table by id",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template del table/ptables/ tblid 22",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/ tblid 22",
+        "matchCount": "1",
+        "matchPattern": "Error: Unable to find table by id.*",
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
+        "id": "83ff",
+        "name": "Try to delete table after pipeline is sealed",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template del table/ptables/cb/tname",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "c41b",
+        "name": "Try to delete inexistent table by name",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template del table/ptables/cb/tname2",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "faca",
+        "name": "Try to delete inexistent table by id",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template del table/ptables/ tblid 44",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/ tblid 22",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "6da7",
+        "name": "Try to delete table without supplying pipeline name or id",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template del table/ tblid 22",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/ tblid 22",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "a844",
+        "name": "Flush table",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 42 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template del table/ptables/",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Error: Table name not found.*",
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
+        "id": "7f88",
+        "name": "Try to flush table without supplying pipeline name or id",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 42 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template del table/",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "778c",
+        "name": "Create table with key size > P4TC_MAX_KEYSZ",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname tblid 22 keysz 513",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Error: Table name not found.*",
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
+        "id": "64ed",
+        "name": "Create table with key size = P4TC_MAX_KEYSZ",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname tblid 22 keysz 512",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 512,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "508b",
+        "name": "Create table and update pipeline state",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 42 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update pipeline/ptables state ready",
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
+                        "pstate": "ready"
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
+        "id": "ac1a",
+        "name": "Create table, update pipeline state and try to update pipeline after pipeline is sealed",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 42 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update pipeline/ptables numtables 3",
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
+                        "pnumtables": 2,
+                        "pstate": "ready"
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
+        "id": "0fb8",
+        "name": "Create table, update pipeline state and try to update table after pipeline is sealed",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 42 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/cb/tname2 keysz 32",
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
+                        "tblid": 42,
+                        "tname": "cb/tname2",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "32a6",
+        "name": "Create table with keys with more than one action",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname tblid 42 keysz 16",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 42,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "ade0",
+        "name": "Update table key with more than one action",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action drop index 5",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 42 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/cb/tname",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 42,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "95f5",
+        "name": "Update table's key",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action drop index 5",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 42 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/cb/tname",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 42,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "e5e1",
+        "name": "Dump table using pipeline name to find pipeline",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 3",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 42 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname3 tblid 50 keysz 16",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/",
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
+                        "tname": "cb/tname"
+                    },
+                    {
+                        "tname": "cb/tname2"
+                    },
+                    {
+                        "tname": "cb/tname3"
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
+        "id": "7f04",
+        "name": "Dump table using pipeline id to find pipeline",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 3",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 42 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname3 tblid 50 keysz 16",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ pipeid 22",
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
+                        "tname": "cb/tname"
+                    },
+                    {
+                        "tname": "cb/tname2"
+                    },
+                    {
+                        "tname": "cb/tname3"
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
+        "id": "96c5",
+        "name": "Try to create more table then numtables",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 42 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname3 tblid 50 keysz 16",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/",
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
+                        "tname": "cb/tname"
+                    },
+                    {
+                        "tname": "cb/tname2"
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
+        "id": "e3fa",
+        "name": "Try to dump table without specifying pipeline name or id",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 42 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname3 tblid 50 keysz 16",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/",
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
+        "id": "6bcf",
+        "name": "Dump pipeline with amount of table > P4TC_MSGBATCH_SIZE",
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
+                "$TC actions add action gact pass index 1",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action gact pass index 2",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action gact pass index 3",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC actions add action gact pass index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 17",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname keysz 16",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname4 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname5 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname6 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname7 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname8 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname9 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname10 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname11 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname12 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname13 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname14 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname15 keysz 16",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname16 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname17 tblid 2147483647 keysz 16",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/",
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
+                        "tname": "cb/tname"
+                    },
+                    {
+                        "tname": "cb/tname2"
+                    },
+                    {
+                        "tname": "cb/tname3"
+                    },
+                    {
+                        "tname": "cb/tname4"
+                    },
+                    {
+                        "tname": "cb/tname5"
+                    },
+                    {
+                        "tname": "cb/tname6"
+                    },
+                    {
+                        "tname": "cb/tname7"
+                    },
+                    {
+                        "tname": "cb/tname8"
+                    },
+                    {
+                        "tname": "cb/tname9"
+                    },
+                    {
+                        "tname": "cb/tname10"
+                    },
+                    {
+                        "tname": "cb/tname11"
+                    },
+                    {
+                        "tname": "cb/tname12"
+                    },
+                    {
+                        "tname": "cb/tname13"
+                    },
+                    {
+                        "tname": "cb/tname14"
+                    },
+                    {
+                        "tname": "cb/tname15"
+                    },
+                    {
+                        "tname": "cb/tname16"
+                    }
+                ]
+            },
+            {
+                "pname": "ptables",
+                "pipeid": 22,
+                "obj": "table"
+            },
+            {
+                "templates": [
+                    {
+                        "tname": "cb/tname17"
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
+        "id": "2eb0",
+        "name": "Try to create valid table without control block name",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 2",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/tname keysz 16",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Error: Table name not found.*",
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
+        "id": "7c2d",
+        "name": "Create table table default_hit action",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/MyIngress/reclassify actid 7",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/MyIngress/reclassify state active",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 table_acts act name ptables/MyIngress/reclassify flags defaultonly default_hit_action action ptables/MyIngress/reclassify",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "default_hit": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/MyIngress/reclassify",
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
+        "id": "c1b0",
+        "name": "Create table table default_miss action",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/MyIngress/reclassify actid 7",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/MyIngress/reclassify state active",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 table_acts act name ptables/MyIngress/reclassify flags defaultonly default_miss_action action ptables/MyIngress/reclassify",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "default_miss": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/MyIngress/reclassify",
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
+        "id": "55a1",
+        "name": "Try to create table table specifying default_hit with no action",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/MyIngress/reclassify actid 7",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/MyIngress/reclassify state active",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 table_acts act name ptables/MyIngress/reclassify flags defaultonly default_hit_action permissions 0x37f",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Error: Table name not found.*",
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
+        "id": "3c1d",
+        "name": "Try to create table table specifying default_miss with no action",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/MyIngress/reclassify actid 7",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/MyIngress/reclassify state active",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 table_acts act name ptables/MyIngress/reclassify flags defaultonly default_miss_action permissions 0x37f",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Error: Table name not found.*",
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
+        "id": "e9da",
+        "name": "Try to create table specifying default_hit permissions with more than 10 bits",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/MyIngress/reclassify actid 7",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/MyIngress/reclassify state active",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 table_acts act name ptables/MyIngress/reclassify flags defaultonly default_hit_action permissions 0x337F action ptables/MyIngress/reclassify",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Error: Table name not found.*",
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
+        "id": "ae5f",
+        "name": "Try to create table specifying default_miss permissions with more than 10 bits",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/MyIngress/reclassify actid 7",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/MyIngress/reclassify state active",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 table_acts act name ptables/MyIngress/reclassify flags defaultonly default_miss_action permissions 0x337F action ptables/MyIngress/reclassify",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Error: Table name not found.*",
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
+        "id": "ccf7",
+        "name": "Try to create table specifying default_hit permissions without data path exexec permissions",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/MyIngress/reclassify actid 7",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/MyIngress/reclassify state active",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 table_acts act name ptables/MyIngress/reclassify flags defaultonly default_hit_action permissions 0x37E action ptables/MyIngress/reclassify",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Error: Table name not found.*",
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
+        "id": "1d7a",
+        "name": "Try to create table specifying default_miss permissions without data path exexec permissions",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/MyIngress/reclassify actid 7",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/MyIngress/reclassify state active",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 table_acts act name ptables/MyIngress/reclassify flags defaultonly default_miss_action permissions 0x37E action ptables/MyIngress/reclassify",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Error: Table name not found.*",
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
+        "id": "abc0",
+        "name": "Try to create table specifying default_hit permissions without data path read permissions",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/MyIngress/reclassify actid 7",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/MyIngress/reclassify state active",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 table_acts act name ptables/MyIngress/reclassify flags defaultonly default_hit_action permissions 0x3F7 action ptables/MyIngress/reclassify",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Error: Table name not found.*",
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
+        "id": "7c36",
+        "name": "Try to create table specifying default_miss permissions without data path read permissions",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/MyIngress/reclassify actid 7",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/MyIngress/reclassify state active",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 table_acts act name ptables/MyIngress/reclassify flags defaultonly default_miss_action permissions 0x3F7 action ptables/MyIngress/reclassify",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Error: Table name not found.*",
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
+        "id": "bca4",
+        "name": "Try to create table specifying default_hit permissions without ctrl path read permissions",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/MyIngress/reclassify actid 7",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/MyIngress/reclassify state active",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 table_acts act name ptables/MyIngress/reclassify flags defaultonly default_hit_action permissions 0x2FF action ptables/MyIngress/reclassify",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Error: Table name not found.*",
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
+        "id": "f77e",
+        "name": "Try to create table specifying default_miss permissions without ctrl path read permissions",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/MyIngress/reclassify actid 7",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/MyIngress/reclassify state active",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 table_acts act name ptables/MyIngress/reclassify flags defaultonly default_miss_action permissions 0x2FF action ptables/MyIngress/reclassify",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Error: Table name not found.*",
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
+        "id": "6d73",
+        "name": "Update table default_hit",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/MyIngress/reclassify actid 7",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/MyIngress/reclassify state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 table_acts act name ptables/MyIngress/reclassify flags defaultonly",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/ tblid 22 default_hit_action action ptables/MyIngress/reclassify",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "default_hit": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/MyIngress/reclassify",
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
+        "id": "b0e8",
+        "name": "Update table default_miss",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/MyIngress/reclassify actid 7",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/MyIngress/reclassify state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 table_acts act name ptables/MyIngress/reclassify flags defaultonly",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/ tblid 22 default_miss_action permissions 0x37F action ptables/MyIngress/reclassify",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "default_miss": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/MyIngress/reclassify",
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
+        "id": "d13e",
+        "name": "Try to update table default_hit with permissions with more than 10 bits",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/ tblid 22 default_hit_action permissions 0x337F",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "1991",
+        "name": "Try to update table default_miss with permissions with more than 10 bits",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/ tblid 22 default_miss_action permissions 0x337F",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "8d47",
+        "name": "Try to update table default_hit without data path exec permissions",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/ tblid 22 default_hit_action permissions 0x37E",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "7105",
+        "name": "Try to update table default_miss without data path exec permissions",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/ tblid 22 default_miss_action permissions 0x37E",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "4288",
+        "name": "Try to update table default_hit without data path read permissions",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/ tblid 22 default_hit_action permissions 0x3F7",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "5a31",
+        "name": "Try to update table default_miss without data path read permissions",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/ tblid 22 default_miss_action permissions 0x3F7",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "cf57",
+        "name": "Try to update table default_miss after control update permissions are off",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/MyIngress/reclassify actid 7",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/MyIngress/reclassify state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 table_acts act name ptables/MyIngress/reclassify",
+                0
+            ],
+            [
+                "$TC p4template update table/ptables/ tblid 22 default_miss_action permissions 0x37F action ptables/MyIngress/reclassify",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/ tblid 22 default_miss_action action drop",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "default_miss": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/MyIngress/reclassify",
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
+        "id": "fa6c",
+        "name": "Try to update table default_hit after control update permissions are off",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/MyIngress/reclassify actid 7",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/MyIngress/reclassify state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 table_acts act name ptables/MyIngress/reclassify",
+                0
+            ],
+            [
+                "$TC p4template update table/ptables/ tblid 22 default_hit_action permissions 0x37F action ptables/MyIngress/reclassify",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/ tblid 22 default_hit_action action drop",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "default_hit": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/MyIngress/reclassify",
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
+        "id": "7a70",
+        "name": "Delete only table default_hit",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/MyIngress/reclassify actid 7",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/MyIngress/reclassify state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 table_acts act name ptables/MyIngress/reclassify",
+                0
+            ],
+            [
+                "$TC p4template update table/ptables/ tblid 22 default_hit_action action ptables/MyIngress/reclassify",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template del table/ptables/ tblid 22 default_hit_action",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "6afa",
+        "name": "Try to delete only table default_hit when delete permissions is off",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/MyIngress/reclassify actid 7",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/MyIngress/reclassify state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 table_acts act name ptables/MyIngress/reclassify",
+                0
+            ],
+            [
+                "$TC p4template update table/ptables/ tblid 22 default_hit_action permissions 0x3BF action ptables/MyIngress/reclassify",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template del table/ptables/ tblid 22 default_hit_action",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "19cc",
+        "name": "Delete _only table default_miss",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/MyIngress/reclassify actid 7",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/MyIngress/reclassify state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 table_acts act name ptables/MyIngress/reclassify",
+                0
+            ],
+            [
+                "$TC p4template update table/ptables/ tblid 22 default_miss_action action ptables/MyIngress/reclassify",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template del table/ptables/ tblid 22 default_miss_action",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "f3b2",
+        "name": "Try to delete only table default_miss when delete permissions is off",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create action/ptables/MyIngress/reclassify actid 7",
+                0
+            ],
+            [
+                "$TC p4template update action/ptables/MyIngress/reclassify state active",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 table_acts act name ptables/MyIngress/reclassify",
+                0
+            ],
+            [
+                "$TC p4template update table/ptables/ tblid 22 default_miss_action permissions 0x3BF action ptables/MyIngress/reclassify",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template del table/ptables/ tblid 22 default_miss_action",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8
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
+        "id": "07b9",
+        "name": "Create table specifying permissions",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 permissions 0x1FF",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "permissions": "-RUDXCRUDX"
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
+        "id": "07fd",
+        "name": "Create table specifying permissions with more than 10 bits",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 permissions 0x4FF",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Error: Table name not found.*",
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
+        "id": "b635",
+        "name": "Update table permissions",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 permissions 0x1FF",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/cb/tname permissions 0x13F",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
+                        "permissions": "-R--XCRUDX"
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
+        "id": "a226",
+        "name": "Try to update table permissions with 0x400",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/cb/tname permissions 0x400",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
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
+                        "tblid": 22,
+                        "tname": "cb/tname",
+                        "keysz": 16,
+                        "max_entries": 256,
+                        "masks": 8,
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
+        "id": "9539",
+        "name": "Try to create table without specifying data execute permission",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 numtables 1",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template create table/ptables/cb/tname tblid 22 keysz 16 permissions 0x3FE",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4template get table/ptables/cb/tname",
+        "matchCount": "1",
+        "matchPattern": "Error: Table name not found.*",
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


