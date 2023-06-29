Return-Path: <netdev+bounces-14541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C82742462
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 12:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CDB51C20A1B
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 10:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C4C174CD;
	Thu, 29 Jun 2023 10:46:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161B0174CC
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 10:46:24 +0000 (UTC)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B7B1FD8
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:46:20 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-793f262b6a9so181121241.1
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688035579; x=1690627579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSj03i1wnsRgJBrjh6y9L+gGo6rRslKBApmI0qd7+II=;
        b=Is4F8AhYzyy2x5V69CK/XN9Sc1EmIDn6Z2wR/F0wqhZ2lx7ieqB1sbvrGc7TkBkQe/
         +7Ln8W9i0bprj0+UESQn8aeUnwwCwt7zztnoh3RuFxoYimcSl6pqDssH/GQchSGu6gVs
         Mpi3r9gBXmyN8gUxtoyHQZTST8Gsv7s+ZVgu3rT6RDyV5JBFnucPa625dIctNEiEumen
         XII0/8+QUwWxu0Ntit40kzQd7pnprbFXzYROreazrrm7UdjGzXrLbx/zIHOyLfUbBEQK
         MwAoegsakxWuAzkff3scz+6mf87fCZgWDrrzr3Xh92IJ462AjLfE6S7CHcAfUWnkfI/2
         THVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688035579; x=1690627579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSj03i1wnsRgJBrjh6y9L+gGo6rRslKBApmI0qd7+II=;
        b=ZlwFI4G/MgDFXVNd13CeXbETL8j+PLztheJfiRQvR3eL0XoxoZ3V5WX2njFBrQRSMp
         agVO2VPAhTA9Y6xO4weMZkTNbuLrVu/zfRHRGi3/hl9zWZql/MLbShB1CscKoEHBjPWH
         JBFS0h3//PF05Qf+juzg/XVw/l/dI5mYSRJ0Dy93rkMBkyGZTZs7UsgwrWqv8A6KyNPR
         tvl//Pk7lHvFUNkD6XQavVzASknNpDg7BkIO9aQJBRK4lwi+HqJTVCsYeP3pd0UQdpRV
         U/CI9MuImqf13jCeug6UORG/XVSkJwwX1kmHJCBErxm7DzvlWVhu9AclDLsbomgaJMde
         NvDQ==
X-Gm-Message-State: AC+VfDw9HH44Ss3KL72SvRyrpwVOv5/rD1P4MUSZcMxh8Ct4To6RiUsy
	UnrihL0q9t7aWb79D719jTCpfLafKz6FqbI3yuA=
X-Google-Smtp-Source: ACHHUZ7SqtggONITeSRjMTGQv5P3KWTnUEI5KmoQ1IbCt+SWGwYmsX6C5J2a24151oecXdWpxnuvxg==
X-Received: by 2002:a05:6102:398:b0:443:67a0:fb79 with SMTP id m24-20020a056102039800b0044367a0fb79mr5732402vsq.21.1688035577654;
        Thu, 29 Jun 2023 03:46:17 -0700 (PDT)
Received: from majuu.waya (bras-base-oshwon9577w-grc-12-142-114-148-137.dsl.bell.ca. [142.114.148.137])
        by smtp.gmail.com with ESMTPSA id o9-20020a056214180900b006362d4eeb6esm538453qvw.144.2023.06.29.03.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 03:46:17 -0700 (PDT)
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
Subject: [PATCH RFC v3 net-next 20/21] selftests: tc-testing: add P4TC table entries control path tdc tests
Date: Thu, 29 Jun 2023 06:45:37 -0400
Message-Id: <20230629104538.40863-21-jhs@mojatatu.com>
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
 .../tc-tests/p4tc/table_entries.json          | 3818 +++++++++++++++++
 1 file changed, 3818 insertions(+)
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/p4tc/table_entries.json

diff --git a/tools/testing/selftests/tc-testing/tc-tests/p4tc/table_entries.json b/tools/testing/selftests/tc-testing/tc-tests/p4tc/table_entries.json
new file mode 100644
index 000000000..231e3ae48
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/tc-tests/p4tc/table_entries.json
@@ -0,0 +1,3818 @@
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 keysz 32 key action gact index 3 postactions gact index 4",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname2 srcPort  80 dstPort  443 prio 16",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname2 srcPort  80 dstPort  443 prio 16",
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
+                        "key": "0x1bb0050",
+                        "mask": "0xffffffff",
+                        "create_whodunnit": "tc",
+                        "permissions": "-RUD--R--X"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname2 srcPort  80 dstPort  443 prio 16",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 keysz 32 key action gact index 3 postactions gact index 4",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname2 srcPort  80 dstPort  443 prio 16",
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
+                "$TC p4 del ptables/table/cb/tname2 srcPort  80 dstPort  443 prio 16",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname keysz 64 key action gact index 3 postactions gact index 4",
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
+                        "key": "0xa8c0000a0a0a",
+                        "mask": "0xffff00ffffff",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 keysz 104 key action gact index 3 postactions gact index 4",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
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
+                        "key1": "0x7f0000005cff",
+                        "key2": "0",
+                        "mask1": "0xffffffffffffffff",
+                        "mask2": "0xffffffffff"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 keysz 104 key action gact index 3 postactions gact index 4",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/ randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104 key action gact index 3 postactions gact index 4",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname3 prio 1",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104 key action gact index 3 postactions gact index 4",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4 get ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
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
+                        "prio": 1,
+                        "key1": "0x7f0000005cff",
+                        "key2": "0",
+                        "mask1": "0xffffffffffffffff",
+                        "mask2": "0xffffffffff",
+                        "create_whodunnit": "tc"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC -j p4 del ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
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
+        "id": "dff1",
+        "name": "Try to get table entry without specifying priority",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+	    [
+                "$TC p4template create action/ptables/cb/reclassify actid 7 cmd act kernel.gact.4",
+		0
+	    ],
+	    [
+                "$TC p4template update action/ptables/cb/reclassify state active",
+		0
+	    ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104 key action gact index 3 postactions gact index 4 table_acts act name ptables/cb/reclassify flags tableonly",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1 action ptables/cb/reclassify",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 2  action ptables/cb/reclassify",
+        "expExitCode": "0",
+        "verifyCmd": "$TC p4 get ptables/table/cb/tname3/ randomKey1  255 randomKey2  92 randomKey3  127",
+        "matchCount": "1",
+        "matchPattern": "Error: Must specify table entry priority.*",
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127 prio 2",
+                0
+            ],
+            [
+                "$TC p4 del ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname keysz 64 tentries 1 key action gact index 3 postactions gact index 4",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname keysz 64 tentries 3 key action gact index 3 postactions gact index 4",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname keysz 64 tentries 1 key action gact index 3 postactions gact index 4",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname keysz 64 key action gact index 3 postactions gact index 4",
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
+                        "key": "0xa8c0000a0a0a",
+                        "mask": "0xffff00ffffff",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname keysz 64 key action gact index 3 postactions gact index 4",
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
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.1.0/16 prio 15",
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
+                        "key": "0x1a8c0000a0a0a",
+                        "mask": "0xffff00ffffff",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname keysz 64 key action gact index 3 postactions gact index 4",
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
+                        "key": "0xa8c0000a0a0a",
+                        "mask": "0xffff00ffffff",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname keysz 64 key action gact index 3 postactions gact index 4",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 keysz 32 key action gact index 3 postactions gact index 4",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname2 srcPort  80 dstPort  443 prio 16 action noexist index 1",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname2 srcPort  80 dstPort  443 prio 16",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 keysz 32 key action gact index 3 postactions gact index 4",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname2 srcPort  80 dstPort  443 prio 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 update ptables/table/cb/tname2 srcPort  80 dstPort  443 prio 16 action noexist index 1",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname2 srcPort  80 dstPort  443 prio 16",
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
+                        "key": "0x1bb0050",
+                        "mask": "0xffffffff",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+	    [
+                "$TC p4template create action/ptables/cb/reclassify actid 7 cmd act kernel.gact.4",
+		0
+	    ],
+	    [
+                "$TC p4template update action/ptables/cb/reclassify state active",
+		0
+	    ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104 key action gact index 3 postactions gact index 4 table_acts act name ptables/cb/reclassify flags tableonly",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 update ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1 action ptables/cb/reclassify",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4 get ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
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
+                        "prio": 1,
+                        "key1": "0x7f0000005cff",
+                        "key2": "0",
+                        "mask1": "0xffffffffffffffff",
+                        "mask2": "0xffffffffff",
+                        "create_whodunnit": "tc",
+                        "update_whodunnit": "tc",
+                        "actions": {
+                            "actions": [
+                                {
+                                    "order": 1,
+                                    "kind": "ptables/cb/reclassify",
+                                    "index": 1,
+                                    "ref": 1,
+                                    "bind": 1,
+                                    "params": [],
+                                    "operations": [
+                                      {
+                                        "instruction": "act",
+                                        "control_action": {
+                                          "type": "pipe"
+                                        },
+                                        "operands": {
+                                          "OPA": {
+                                            "type": "action",
+                                            "pname": "kernel",
+                                            "id": "gact"
+                                          }
+                                        }
+                                      }
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
+                "$TC p4 del ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+	    [
+                "$TC p4template create action/ptables/cb/reclassify actid 7 cmd act kernel.gact.4",
+		0
+	    ],
+	    [
+                "$TC p4template update action/ptables/cb/reclassify state active",
+		0
+	    ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104 key action gact index 3 postactions gact index 4 table_acts act name ptables/cb/reclassify flags tableonly",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1 action ptables/cb/reclassify",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 update ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1 action ptables/cb/reclassify index 2",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4 get ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
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
+                        "prio": 1,
+                        "key1": "0x7f0000005cff",
+                        "key2": "0",
+                        "mask1": "0xffffffffffffffff",
+                        "mask2": "0xffffffffff",
+                        "create_whodunnit": "tc",
+                        "update_whodunnit": "tc",
+                        "actions": {
+                            "actions": [
+                            {
+                                "order": 1,
+                                "kind": "ptables/cb/reclassify",
+                                "index": 2,
+                                "ref": 1,
+                                "bind": 1,
+                                "params": [],
+                                "operations": [
+                                  {
+                                    "instruction": "act",
+                                    "control_action": {
+                                      "type": "pipe"
+                                    },
+                                    "operands": {
+                                      "OPA": {
+                                        "type": "action",
+                                        "pname": "kernel",
+                                        "id": "gact"
+                                      }
+                                    }
+                                  }
+                                ]
+                            }
+                            ]
+                        }
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+	    [
+                "$TC p4template create action/ptables/cb/reclassify actid 7 cmd act kernel.gact.4",
+		0
+	    ],
+	    [
+                "$TC p4template update action/ptables/cb/reclassify state active",
+		0
+	    ],
+            [
+                "$TC actions add action ptables/cb/reclassify index 1",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104 key action gact index 3 postactions gact index 4 table_acts act name ptables/cb/reclassify flags tableonly",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1 action ptables/cb/reclassify index 1",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 update ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1 action ptables/cb/reclassify index 2; sleep 1;",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions get action ptables/cb/reclassify index 1",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "ptables/cb/reclassify",
+                        "index": 1,
+                        "ref": 1,
+                        "bind": 0,
+                        "params": [],
+                        "operations": [
+                          {
+                            "instruction": "act",
+                            "control_action": {
+                              "type": "pipe"
+                            },
+                            "operands": {
+                              "OPA": {
+                                "type": "action",
+                                "pname": "kernel",
+                                "id": "gact"
+                              }
+                            }
+                          }
+                        ]
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104 key action gact index 3 postactions gact index 4",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 update ptables/table/ tblid 3 randomKey1  255 randomKey2  1 randomKey3  127 prio 1",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
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
+                        "prio": 1,
+                        "key1": "0x7f0000005cff",
+                        "key2": "0",
+                        "mask1": "0xffffffffffffffff",
+                        "mask2": "0xffffffffff",
+                        "create_whodunnit": "tc"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+	    [
+                "$TC p4template create action/ptables/cb/reclassify actid 7 cmd act kernel.gact.4",
+		0
+	    ],
+	    [
+                "$TC p4template update action/ptables/cb/reclassify state active",
+		0
+	    ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104 key action gact index 3 postactions gact index 4 table_acts act name ptables/cb/reclassify flags tableonly",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 update ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 action ptables/cb/reclassify",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
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
+                        "prio": 1,
+                        "key1": "0x7f0000005cff",
+                        "key2": "0",
+                        "mask1": "0xffffffffffffffff",
+                        "mask2": "0xffffffffff",
+                        "create_whodunnit": "tc"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
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
+        "name": "Try update table entry without specifying table name or id",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104 key action gact index 3 postactions gact index 4",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 update ptables/table/ randomKey1  255 randomKey2  92 randomKey3  127 prio 1 action gact index 2",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
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
+                        "prio": 1,
+                        "key1": "0x7f0000005cff",
+                        "key2": "0",
+                        "mask1": "0xffffffffffffffff",
+                        "mask2": "0xffffffffff",
+                        "create_whodunnit": "tc"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104 key action gact index 3 postactions gact index 4",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 del ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
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
+        "id": "9bb5",
+        "name": "Delete table entry specifying tblid",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104 key action gact index 3 postactions gact index 4",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 del ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4 get ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104 key action gact index 3 postactions gact index 4",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 del ptables/table/ randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname3/ randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
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
+                        "prio": 1,
+                        "key1": "0x7f0000005cff",
+                        "key2": "0",
+                        "mask1": "0xffffffffffffffff",
+                        "mask2": "0xffffffffff"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
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
+        "id": "e79d",
+        "name": "Try to delete table entry without specifying prio",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104 key action gact index 3 postactions gact index 4",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 2",
+        "expExitCode": "0",
+        "verifyCmd": "$TC p4 del ptables/table/cb/tname3/ randomKey1  255 randomKey2  92 randomKey3  127",
+        "matchCount": "1",
+        "matchPattern": "Error: Must specify table entry priority.*",
+        "teardown": [
+            [
+                "$TC p4 del ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127 prio 2",
+                0
+            ],
+            [
+                "$TC p4 del ptables/table/cb/tname3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+	    [
+                "$TC p4template create action/ptables/cb/reclassify actid 7 cmd act kernel.gact.4",
+		0
+	    ],
+	    [
+                "$TC p4template update action/ptables/cb/reclassify state active",
+		0
+	    ],
+            [
+                "$TC actions add action ptables/cb/reclassify index 1",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104 key action gact index 3 postactions gact index 4 table_acts act name ptables/cb/reclassify flags tableonly",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1 action ptables/cb/reclassify",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 del ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1; sleep 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j actions get action ptables/cb/reclassify index 1",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "ptables/cb/reclassify",
+                        "index": 1,
+                        "ref": 1,
+                        "bind": 0,
+                        "params": [],
+                        "operations": [
+                          {
+                            "instruction": "act",
+                            "control_action": {
+                              "type": "pipe"
+                            },
+                            "operands": {
+                              "OPA": {
+                                "type": "action",
+                                "pname": "kernel",
+                                "id": "gact"
+                              }
+                            }
+                          }
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname3 tblid 3 keysz 104 key action gact index 3 postactions gact index 4",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 del ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/ tblid 3 randomKey1  255 randomKey2  92 randomKey3  127 prio 1",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname keysz 64 key action gact index 3 postactions gact index 4",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname keysz 64 key action gact index 3 postactions gact index 4",
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
+        "id": "5618",
+        "name": "Flush table entries using tblid",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname keysz 64 key action gact index 3 postactions gact index 4",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname keysz 64 key action gact index 3 postactions gact index 4",
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
+                        "key": "0x38a8c0000a0a0a",
+                        "mask": "0xffffff00ffffff",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname keysz 64 key action gact index 3 postactions gact index 4",
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
+                        "key": "0x38a8c0000a0a0a",
+                        "mask": "0xffffff00ffffff",
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
+        "id": "044c",
+        "name": "Dump table entries specifying tblid",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname keysz 64 key action gact index 3 postactions gact index 4",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname srcAddr 10.10.10.0/24 dstAddr 192.168.56.0/24 prio 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j p4 get ptables/table/ tblid 1",
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
+                        "key": "0x38a8c0000a0a0a",
+                        "mask": "0xffffff00ffffff",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname keysz 64 key action gact index 3 postactions gact index 4",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname keysz 64 key action gact index 3 postactions gact index 4",
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
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname keysz 64 key action gact index 3 postactions gact index 4",
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
+                        "key": "0xa8c0000a0a0a",
+                        "mask": "0xffff00ffffff",
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 16,
+                        "key": "0xa8c0000a0a0a",
+                        "mask": "0xffff00ffffff",
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 15,
+                        "key": "0xa8c0000a0a0a",
+                        "mask": "0xffff00ffffff",
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 14,
+                        "key": "0xa8c0000a0a0a",
+                        "mask": "0xffff00ffffff",
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 13,
+                        "key": "0xa8c0000a0a0a",
+                        "mask": "0xffff00ffffff",
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 12,
+                        "key": "0xa8c0000a0a0a",
+                        "mask": "0xffff00ffffff",
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 11,
+                        "key": "0xa8c0000a0a0a",
+                        "mask": "0xffff00ffffff",
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 10,
+                        "key": "0xa8c0000a0a0a",
+                        "mask": "0xffff00ffffff",
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 9,
+                        "key": "0xa8c0000a0a0a",
+                        "mask": "0xffff00ffffff",
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 8,
+                        "key": "0xa8c0000a0a0a",
+                        "mask": "0xffff00ffffff",
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 7,
+                        "key": "0xa8c0000a0a0a",
+                        "mask": "0xffff00ffffff",
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 6,
+                        "key": "0xa8c0000a0a0a",
+                        "mask": "0xffff00ffffff",
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 5,
+                        "key": "0xa8c0000a0a0a",
+                        "mask": "0xffff00ffffff",
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 4,
+                        "key": "0xa8c0000a0a0a",
+                        "mask": "0xffff00ffffff",
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 3,
+                        "key": "0xa8c0000a0a0a",
+                        "mask": "0xffff00ffffff",
+                        "create_whodunnit": "tc"
+                    },
+                    {
+                        "tblid": 1,
+                        "prio": 2,
+                        "key": "0xa8c0000a0a0a",
+                        "mask": "0xffff00ffffff",
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
+                        "key": "0xa8c0000a0a0a",
+                        "mask": "0xffff00ffffff",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 22 keysz 32 permissions 0x1FF key action gact index 3 preactions gact index 4 postactions gact index 4",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname2 srcPort 80 dstPort 443 prio 16",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname2 srcPort 80 dstPort 443 prio 16",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 22 keysz 32 permissions 0x3C9 key action gact index 3 preactions gact index 4 postactions gact index 4",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname2 srcPort 80 dstPort 443 prio 16 permissions 0x1CF",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname2 srcPort 80 dstPort 443 prio 16",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 22 keysz 32 permissions 0x3FF key action gact index 3 preactions gact index 4 postactions gact index 4",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname2 srcPort 80 dstPort 443 prio 16 permissions 0x16F",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 update ptables/table/cb/tname2 srcPort 80 dstPort 443 prio 16",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname2 srcPort 80 dstPort 443 prio 16",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "entries": [
+                    {
+                        "tblid": 22,
+                        "prio": 16,
+                        "key": "0x1bb0050",
+                        "mask": "0xffffffff",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 22 keysz 32 permissions 0x3FF key action gact index 3 preactions gact index 4 postactions gact index 4",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname2 srcPort 80 dstPort 443 prio 16 permissions 0x1AF",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 del ptables/table/cb/tname2 srcPort 80 dstPort 443 prio 16",
+        "expExitCode": "255",
+        "verifyCmd": "$TC -j p4 get ptables/table/cb/tname2 srcPort 80 dstPort 443 prio 16",
+        "matchCount": "1",
+        "matchJSON": [
+            {
+                "pname": "ptables",
+                "pipeid": 22
+            },
+            {
+                "entries": [
+                    {
+                        "tblid": 22,
+                        "prio": 16,
+                        "key": "0x1bb0050",
+                        "mask": "0xffffffff",
+                        "create_whodunnit": "tc",
+                        "permissions": "-RU-X-RUDX"
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            [
+                "$TC p4 update ptables/table/cb/tname2 srcPort 80 dstPort 443 prio 16 permissions 0x1EF",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 22 keysz 32 permissions 0x3FF key action gact index 3 preactions gact index 4 postactions gact index 4",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname2 srcPort 80 dstPort 443 prio 16",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4template update table/ptables/cb/tname2 permissions 0x1FF",
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
+                        "tblid": 22,
+                        "prio": 16,
+                        "key": "0x1bb0050",
+                        "mask": "0xffffffff",
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
+                "$TC actions add action reclassify index 4",
+                0,
+                1,
+                255
+            ],
+            [
+                "$TC p4template create pipeline/ptables pipeid 22 maxrules 1 numtables 1 preactions action gact index 1 postactions action gact index 2",
+                0
+            ],
+            [
+                "$TC p4template create table/ptables/cb/tname2 tblid 22 keysz 32 permissions 0x3FF key action gact index 3 preactions gact index 4 postactions gact index 4",
+                0
+            ],
+            [
+                "$TC p4template update pipeline/ptables state ready",
+                0
+            ],
+            [
+                "$TC p4 create ptables/table/cb/tname2 srcPort 80 dstPort 443 prio 16",
+                0
+            ],
+            [
+                "$TC p4template update table/ptables/cb/tname2 permissions 0x1FF",
+                0
+            ]
+        ],
+        "cmdUnderTest": "$TC p4 create ptables/table/cb/tname2 srcPort 53 dstPort 53 prio 17",
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
+                        "tblid": 22,
+                        "prio": 16,
+                        "key": "0x1bb0050",
+                        "mask": "0xffffffff",
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
+    }
+]
-- 
2.34.1


