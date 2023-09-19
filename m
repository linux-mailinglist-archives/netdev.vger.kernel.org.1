Return-Path: <netdev+bounces-34989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC097A65C9
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 15:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1481C20AEA
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB73F374FB;
	Tue, 19 Sep 2023 13:54:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD0937C8A
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 13:54:47 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6056DEC
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 06:54:45 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6c0f2addaefso3265575a34.2
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 06:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1695131684; x=1695736484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0P1i4j3AQBgGOmTiFmN3yYNXZE27ALJs79AlwNX83Go=;
        b=UUOeORb5z6PU7X2SjXKlclFFQlgQon9cuGXrZDO7JFdAFtAokhgJOZo+dyYT4QdITl
         nmH4Y4OPjOKF2u1BexgDGQTLFaTJMfKfnVfGmYfPZLESn9BBsCDrmFnDsFChZusD0drR
         yFEohXuQtSa3+qtZJchqh+b7KKkqyUcSgyH6D91282Zv+rLm28MgSQHgvj0/LGJUI0fS
         QUDLcWum92zcd38jhLh8VDUSWt5wbKSPJ3Xrq2GKCHoOXUjA0DkKZ6cIupEsXtX7n+Tz
         ciKDrn2McxiCQ8nS0bqEVDSRFFO8HJ1tr+2/aTGQEYRv35D+aMDKM0lRnp0VH/op7fzh
         EPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695131684; x=1695736484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0P1i4j3AQBgGOmTiFmN3yYNXZE27ALJs79AlwNX83Go=;
        b=M6lrLw7NiyZgJ9+67J7L0cLnP4vi8PEtWenAFD97h3b1uoTQsuhxV3NqU5IgT1IRiM
         sJL7w+7IeHUaCMhD7qNLoA0556IKppUnossytWdjdfrsbYYRT4SqvZu9J4dDgGE0MTnt
         Luf9Dcxj4xUey//d3hEiBDOVQNGOTt5yLc9TSa4QJcP9tfB9SPKWU4zN73aY1xFWx9Qi
         sylkcDqQP7lLT4rT8memwXX8rGiHMbvhVUIDmLjqTNDnNdkXx5LkKTvR/Oi6R2EOE3s9
         eIp1+jxJbDVxY9UoFd6zdA51f+uK4XuyEEoSAJGPJH3jCfvIFzOjz7BbjmnclP/2tIE8
         rPOQ==
X-Gm-Message-State: AOJu0YyzDhGf8ET8u2eEDM0knUlffMYMGAFGPjRtAtxJZNf/qdLeqfqg
	OgGgHxK6xU1clo7NebovXVM5OiAmlGYirA7xlKM=
X-Google-Smtp-Source: AGHT+IGs/pFfeWxAv8OR/S3w0pu3T7NKWd+NFwuSStD6AqWP7EBgpSqtfWjEeBv/mAJ2VMnUUSh8vA==
X-Received: by 2002:a05:6870:4185:b0:1bf:fd8a:826e with SMTP id y5-20020a056870418500b001bffd8a826emr12235942oac.55.1695131684433;
        Tue, 19 Sep 2023 06:54:44 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:cd1e:1428:689a:5af3])
        by smtp.gmail.com with ESMTPSA id h22-20020a056870a3d600b001ccab369c09sm6004270oak.42.2023.09.19.06.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 06:54:44 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	victor@mojatatu.com,
	Pedro Tammela <pctammela@mojatatu.com>,
	Davide Caratti <dcaratti@redhat.com>
Subject: [PATCH net-next 4/4] selftests/tc-testing: update tdc documentation
Date: Tue, 19 Sep 2023 10:54:04 -0300
Message-Id: <20230919135404.1778595-5-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230919135404.1778595-1-pctammela@mojatatu.com>
References: <20230919135404.1778595-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Update the documentation to reflect the changes made to tdc with regards
to minimal requirements and test definitions expectations.

Tested-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 tools/testing/selftests/tc-testing/README | 65 ++++-------------------
 1 file changed, 10 insertions(+), 55 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/README b/tools/testing/selftests/tc-testing/README
index b0954c873e2f..be7b00799b3e 100644
--- a/tools/testing/selftests/tc-testing/README
+++ b/tools/testing/selftests/tc-testing/README
@@ -9,8 +9,7 @@ execute them inside a network namespace dedicated to the task.
 REQUIREMENTS
 ------------
 
-*  Minimum Python version of 3.4. Earlier 3.X versions may work but are not
-   guaranteed.
+*  Minimum Python version of 3.8.
 
 *  The kernel must have network namespace support if using nsPlugin
 
@@ -96,6 +95,15 @@ the stdout with a regular expression.
 
 Each of the commands in any stage will run in a shell instance.
 
+Each test is an atomic unit. A test that for whatever reason spans multiple test
+definitions is a bug.
+
+A test that runs inside a namespace (requires "nsPlugin") will run in parallel
+with other tests.
+
+Tests that use netdevsim or don't run inside a namespace run serially with regards
+to each other.
+
 
 USER-DEFINED CONSTANTS
 ----------------------
@@ -116,59 +124,6 @@ COMMAND LINE ARGUMENTS
 
 Run tdc.py -h to see the full list of available arguments.
 
-usage: tdc.py [-h] [-p PATH] [-D DIR [DIR ...]] [-f FILE [FILE ...]]
-              [-c [CATG [CATG ...]]] [-e ID [ID ...]] [-l] [-s] [-i] [-v] [-N]
-              [-d DEVICE] [-P] [-n] [-V]
-
-Linux TC unit tests
-
-optional arguments:
-  -h, --help            show this help message and exit
-  -p PATH, --path PATH  The full path to the tc executable to use
-  -v, --verbose         Show the commands that are being run
-  -N, --notap           Suppress tap results for command under test
-  -d DEVICE, --device DEVICE
-                        Execute test cases that use a physical device, where
-                        DEVICE is its name. (If not defined, tests that require
-                        a physical device will be skipped)
-  -P, --pause           Pause execution just before post-suite stage
-
-selection:
-  select which test cases: files plus directories; filtered by categories
-  plus testids
-
-  -D DIR [DIR ...], --directory DIR [DIR ...]
-                        Collect tests from the specified directory(ies)
-                        (default [tc-tests])
-  -f FILE [FILE ...], --file FILE [FILE ...]
-                        Run tests from the specified file(s)
-  -c [CATG [CATG ...]], --category [CATG [CATG ...]]
-                        Run tests only from the specified category/ies, or if
-                        no category/ies is/are specified, list known
-                        categories.
-  -e ID [ID ...], --execute ID [ID ...]
-                        Execute the specified test cases with specified IDs
-
-action:
-  select action to perform on selected test cases
-
-  -l, --list            List all test cases, or those only within the
-                        specified category
-  -s, --show            Display the selected test cases
-  -i, --id              Generate ID numbers for new test cases
-
-netns:
-  options for nsPlugin (run commands in net namespace)
-
-  -N, --no-namespace
-                        Do not run commands in a network namespace.
-
-valgrind:
-  options for valgrindPlugin (run command under test under Valgrind)
-
-  -V, --valgrind        Run commands under valgrind
-
-
 PLUGIN ARCHITECTURE
 -------------------
 
-- 
2.39.2


