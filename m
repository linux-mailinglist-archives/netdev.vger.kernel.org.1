Return-Path: <netdev+bounces-62163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95169825F9B
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 14:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC47283995
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 13:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579036FC8;
	Sat,  6 Jan 2024 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="y3ClUUYl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4455C6FCB
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5983341fd30so39468eaf.3
        for <netdev@vger.kernel.org>; Sat, 06 Jan 2024 05:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1704546693; x=1705151493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ylEUqgG5u/Dqe8TMOcL3B5H3bQ72WpY1bO29p1ogas=;
        b=y3ClUUYl6N2lHJF9KWtn1n3cfWt/lol923OBJjXrJlXIuvd5V7zPzRZFjA4dWvvy3g
         1GE7Y7OSomSmZL5ZhcWEVVZu8jeWTc0cJnw5dnnvYTdIgj3WQTk3of9E9HIJUPQbjdFU
         /bHHvYDHAE/t+r4bZZxDfybI0QZHV7DiGN41g89W+V3c90L/lgdXOGfuqLQ+5BTIY6hX
         xGRVKit33ukDz8hXSM6QY841zCp4MW40FJYhiv3NkaQ+wKMvD7O+Y9drCgqK1z4Oa73D
         TfVD1pLHjhzm1v0UdmfClNkTmScbJcWa+grvFFl3iZa+hPGOt8xia9jLHG43BZJx+mY7
         e8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704546693; x=1705151493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ylEUqgG5u/Dqe8TMOcL3B5H3bQ72WpY1bO29p1ogas=;
        b=dBUF9mnjE64oJMi81XfwCSBVAhUxKE5s1L2N28BZPEZq7s4ZkGE0zO2uoGAM5ivUZi
         JoOQ5/zeOOm1phM11eLvOpeojzh5Wwbi0lm+uh+95DQPT/CNfh/PIBsgyC0Jq32fK4jc
         YSLUt0d+gpXRGZaHTRqLdpTT/Qa75HkYCA33fTGo1aJqixVLoiEhNRR7Dv7ni92J1j6j
         /17W+CX6+ib4boeD+ehR/6WY429FlaIKvIDhos/oFscKWfIEEXPtk1kEhMiqU+feL4yN
         AUa1hlwqWh4mWX1lNKaJoMJe0XeFW/JmKTp6uqWPEgLFKSN8Q46PtwV2ZSQg+nVYzdqU
         nxpA==
X-Gm-Message-State: AOJu0YwEYEGzY0vwxLXs/LAgQTKZF6XoWZjozRnoxFUTIEg4KSfJSRSh
	7oGUYFLTLvNFkNm0zlVc/J9moFvG0ajA
X-Google-Smtp-Source: AGHT+IHzC2Igva/YfnYpvVLJMMJdklvVIDIjvnkMRf+APujDPQxFomOrx67+TLiAAN0Ou/3EaUT3mg==
X-Received: by 2002:a05:6359:5c30:b0:175:4c7c:dac4 with SMTP id pu48-20020a0563595c3000b001754c7cdac4mr760808rwb.16.1704546693188;
        Sat, 06 Jan 2024 05:11:33 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1618w-grc-15-174-91-6-24.dsl.bell.ca. [174.91.6.24])
        by smtp.gmail.com with ESMTPSA id b8-20020ac812c8000000b004281ccccdfcsm1644006qtj.51.2024.01.06.05.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 05:11:32 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com
Cc: jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	netdev@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net-next 1/1] net/sched: Remove ipt action tests
Date: Sat,  6 Jan 2024 08:11:28 -0500
Message-Id: <20240106131128.1420186-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ba24ea129126 ("net/sched: Retire ipt action") removed the ipt action
but not the testcases. This patch removes the outstanding tdc tests.

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../tc-testing/tc-tests/actions/xt.json       | 243 ------------------
 1 file changed, 243 deletions(-)
 delete mode 100644 tools/testing/selftests/tc-testing/tc-tests/actions/xt.json

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/xt.json b/tools/testing/selftests/tc-testing/tc-tests/actions/xt.json
deleted file mode 100644
index 1a92e8898fec..000000000000
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/xt.json
+++ /dev/null
@@ -1,243 +0,0 @@
-[
-    {
-        "id": "2029",
-        "name": "Add xt action with log-prefix",
-        "category": [
-            "actions",
-            "xt"
-        ],
-        "plugins": {
-           "requires": "nsPlugin"
-        },
-        "setup": [
-            [
-                "$TC actions flush action xt",
-                0,
-                1,
-                255
-            ]
-        ],
-        "cmdUnderTest": "$TC action add action xt -j LOG --log-prefix PONG index 100",
-        "expExitCode": "0",
-        "verifyCmd": "$TC action ls action xt",
-        "matchPattern": "action order [0-9]*:.*target  LOG level warning prefix \"PONG\".*index 100 ref",
-        "matchCount": "1",
-        "teardown": [
-            "$TC actions flush action xt"
-        ]
-    },
-    {
-        "id": "3562",
-        "name": "Replace xt action log-prefix",
-        "category": [
-            "actions",
-            "xt"
-        ],
-        "plugins": {
-           "requires": "nsPlugin"
-        },
-        "setup": [
-            [
-                "$TC actions flush action xt",
-                0,
-                1,
-                255
-            ],
-            [
-                "$TC action add action xt -j LOG --log-prefix PONG index 1",
-                0,
-                1,
-                255
-            ]
-        ],
-        "cmdUnderTest": "$TC action replace action xt -j LOG --log-prefix WIN index 1",
-        "expExitCode": "0",
-        "verifyCmd": "$TC action get action xt index 1",
-        "matchPattern": "action order [0-9]*:.*target  LOG level warning prefix \"WIN\".*index 1 ref",
-        "matchCount": "1",
-        "teardown": [
-            "$TC action flush action xt"
-        ]
-    },
-    {
-        "id": "8291",
-        "name": "Delete xt action with valid index",
-        "category": [
-            "actions",
-            "xt"
-        ],
-        "plugins": {
-           "requires": "nsPlugin"
-        },
-        "setup": [
-            [
-                "$TC actions flush action xt",
-                0,
-                1,
-                255
-            ],
-            [
-                "$TC action add action xt -j LOG --log-prefix PONG index 1000",
-                0,
-                1,
-                255
-            ]
-        ],
-        "cmdUnderTest": "$TC action delete action xt index 1000",
-        "expExitCode": "0",
-        "verifyCmd": "$TC action get action xt index 1000",
-        "matchPattern": "action order [0-9]*:.*target  LOG level warning prefix \"PONG\".*index 1000 ref",
-        "matchCount": "0",
-        "teardown": [
-            "$TC action flush action xt"
-        ]
-    },
-    {
-        "id": "5169",
-        "name": "Delete xt action with invalid index",
-        "category": [
-            "actions",
-            "xt"
-        ],
-        "plugins": {
-           "requires": "nsPlugin"
-        },
-        "setup": [
-            [
-                "$TC actions flush action xt",
-                0,
-                1,
-                255
-            ],
-            [
-                "$TC action add action xt -j LOG --log-prefix PONG index 1000",
-                0,
-                1,
-                255
-            ]
-        ],
-        "cmdUnderTest": "$TC action delete action xt index 333",
-        "expExitCode": "255",
-        "verifyCmd": "$TC action get action xt index 1000",
-        "matchPattern": "action order [0-9]*:.*target  LOG level warning prefix \"PONG\".*index 1000 ref",
-        "matchCount": "1",
-        "teardown": [
-            "$TC action flush action xt"
-        ]
-    },
-    {
-        "id": "7284",
-        "name": "List xt actions",
-        "category": [
-            "actions",
-            "xt"
-        ],
-        "plugins": {
-           "requires": "nsPlugin"
-        },
-        "setup": [
-            [
-                "$TC action flush action xt",
-                0,
-                1,
-                255
-            ],
-            "$TC action add action xt -j LOG --log-prefix PONG index 1001",
-            "$TC action add action xt -j LOG --log-prefix WIN index 1002",
-            "$TC action add action xt -j LOG --log-prefix LOSE index 1003"
-        ],
-        "cmdUnderTest": "$TC action list action xt",
-        "expExitCode": "0",
-        "verifyCmd": "$TC action list action xt",
-        "matchPattern": "action order [0-9]*: tablename:",
-        "matchCount": "3",
-        "teardown": [
-            "$TC actions flush action xt"
-        ]
-    },
-    {
-        "id": "5010",
-        "name": "Flush xt actions",
-        "category": [
-            "actions",
-            "xt"
-        ],
-        "plugins": {
-           "requires": "nsPlugin"
-        },
-        "setup": [
-            [
-		"$TC actions flush action xt",
-                0,
-                1,
-                255
-            ],
-            "$TC action add action xt -j LOG --log-prefix PONG index 1001",
-            "$TC action add action xt -j LOG --log-prefix WIN index 1002",
-            "$TC action add action xt -j LOG --log-prefix LOSE index 1003"
-	],
-        "cmdUnderTest": "$TC action flush action xt",
-        "expExitCode": "0",
-        "verifyCmd": "$TC action list action xt",
-        "matchPattern": "action order [0-9]*: tablename:",
-        "matchCount": "0",
-        "teardown": [
-            "$TC actions flush action xt"
-        ]
-    },
-    {
-        "id": "8437",
-        "name": "Add xt action with duplicate index",
-        "category": [
-            "actions",
-            "xt"
-        ],
-        "plugins": {
-           "requires": "nsPlugin"
-        },
-        "setup": [
-            [
-                "$TC actions flush action xt",
-                0,
-                1,
-                255
-            ],
-            "$TC action add action xt -j LOG --log-prefix PONG index 101"
-        ],
-        "cmdUnderTest": "$TC action add action xt -j LOG --log-prefix WIN index 101",
-        "expExitCode": "255",
-        "verifyCmd": "$TC action get action xt index 101",
-        "matchPattern": "action order [0-9]*:.*target  LOG level warning prefix \"PONG\".*index 101",
-        "matchCount": "1",
-        "teardown": [
-            "$TC action flush action xt"
-        ]
-    },
-    {
-        "id": "2837",
-        "name": "Add xt action with invalid index",
-        "category": [
-            "actions",
-            "xt"
-        ],
-        "plugins": {
-           "requires": "nsPlugin"
-        },
-        "setup": [
-            [
-                "$TC actions flush action xt",
-                0,
-                1,
-                255
-            ]
-        ],
-        "cmdUnderTest": "$TC action add action xt -j LOG --log-prefix WIN index 4294967296",
-        "expExitCode": "255",
-        "verifyCmd": "$TC action ls action xt",
-        "matchPattern": "action order [0-9]*:*target  LOG level warning prefix \"WIN\"",
-        "matchCount": "0",
-        "teardown": [
-            "$TC action flush action xt"
-        ]
-    }
-]
-- 
2.34.1


