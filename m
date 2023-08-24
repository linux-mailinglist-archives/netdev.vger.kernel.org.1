Return-Path: <netdev+bounces-30431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA58378746B
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 17:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1EC28165A
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A51213FE8;
	Thu, 24 Aug 2023 15:38:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E93A14AB1
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 15:38:20 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF6D1B2
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 08:38:19 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-5733aa10291so13319eaf.3
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 08:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692891498; x=1693496298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWMTLVgpsotux2HCiEsaqtQ0jN7tVo2VvE2kwnaFxwE=;
        b=ATSxeagqJQd9t+iT4O3dIwDLgolMX+gbLermzIdJEdCVU0B73bm9oskYwd9rbmSWVY
         RTJNp7bW7muzozjwqrtcklEA2guAYOoPifpSYsf6x6/jPihv2KlLxkojN6+9H/Ob+YEi
         X7A9IBr+BpqYGzAE4P2f1h4GirVb6r7f/guDFtRy706lb6lNDhLr6k5rZI+k6+Yz84nd
         hxNmLt/ICN2egj1gGLdozR71GgIAk9LfB8HKLHs119keuHmkLBEYN01Oi3Qor0xX/yxU
         J3+oCtQbj7VoCe9xsQ/C6kp6d3IHPLslGyypdekfw09wx6T6f17/B1/x2i1Q8CYiGXG/
         ZLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692891498; x=1693496298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWMTLVgpsotux2HCiEsaqtQ0jN7tVo2VvE2kwnaFxwE=;
        b=FAEcM5C/7SHTaKw3Bg7ScHb+EP5FXuU8uCyN6rDaBkLXNj6xoTQgAbAmlRInwBNLJh
         Cn6EPGIeZz0TgSXYblByJXV30capy9ySluwriZhuiOgwabazGfBGSOwDKh8FQCHhlpcF
         tTs8WeIw/i5p/YrL2weqCof6JOsI9ZUbtesvnS0y+BbKcbzzT+kc3Wh4dr+LeOGr1a/j
         Or1t/8TzlfaFM1y3MOnjgShyJRyH/bjRmJuYXAn/PxdriKk39wxv03jox/daGarbi4U/
         ATYbk2MeegTgnAYsL0cXzi899HPzFtedKyOlmu6Qk62YoYInw/Ai0MHJflr7lGE1wP7I
         OYtA==
X-Gm-Message-State: AOJu0YxBs+pOgeSaVgH51npLM/ZrHJhyoeOFue/XkbBmU3Sc3T9VVLRQ
	Gn5LkQMZ3kBIkk21na6HCYdXlIMbuKgiIzSXa1A=
X-Google-Smtp-Source: AGHT+IF4f5OzqkJ/f8zXbEyxEc+bUWV7ojo9hsEjIG26U+40LaxhiVx4+Qy28hoxGpTxGhdhbcrjJQ==
X-Received: by 2002:a05:6820:41:b0:56e:5a8e:654f with SMTP id v1-20020a056820004100b0056e5a8e654fmr2662509oob.8.1692891497798;
        Thu, 24 Aug 2023 08:38:17 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:ebd6:5010:2cd8:55fb])
        by smtp.gmail.com with ESMTPSA id q126-20020a4a4b84000000b0056c81dedb3bsm7592392ooa.8.2023.08.24.08.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 08:38:17 -0700 (PDT)
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
	shaozhengchao@huawei.com,
	victor@mojatatu.com,
	dcaratti@redhat.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH RFC net-next v2 4/4] selftests/tc-testing: update tdc documentation
Date: Thu, 24 Aug 2023 12:37:36 -0300
Message-Id: <20230824153736.629961-5-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824153736.629961-1-pctammela@mojatatu.com>
References: <20230824153736.629961-1-pctammela@mojatatu.com>
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


