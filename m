Return-Path: <netdev+bounces-28865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D253781079
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6021C20E1B
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B954C6135;
	Fri, 18 Aug 2023 16:36:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE566110
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 16:36:31 +0000 (UTC)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF30D3AAE
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:36:30 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-56d455462c2so719634eaf.2
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692376590; x=1692981390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emxBtvBizp53ATR2wa3AwEpTdXwAhDnSB3z3aMLT9nc=;
        b=Wax79MQD6Ul2/+RFyLa59dv0fDV3OgJjnjumnvHUmjrE8bXvKtrj6m+JeRtantaoug
         V8OMFg6A7hs5ht+xnmgwDoUkfzcrvZM8Ee1UlaN3sQPCCYH1dOKyv2N8U0tPDye/Oup8
         V5XRhEsY5ujGQ/4FE/t6Cc6Ns3kf50337uJz8VaJqv3FxSc7DD9gl0HhAo4GNnDtX5w/
         UXVF/tvDdDxuQZ2AUqyFQXssZtHK2UBPf68E45wSBPB45k13bcXANiz1a3S9QZ2WmzXZ
         MNGnes9eS/d6UoraAJtbnfh3K71s8cWhpYgHMJv0/N706w09wGYKs9KT7tRURyht6g/4
         tMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692376590; x=1692981390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emxBtvBizp53ATR2wa3AwEpTdXwAhDnSB3z3aMLT9nc=;
        b=Hbh7lLuVx/7Fzz3SNVtpp9NCLB6kOec7vVGalCn/cRJxLBgnrbSlJVdMpKmCxUJeqJ
         xDovZEaPLd9CZTKoTvmZC0MclNnrPkhNSHwb5S5eB56h2HkZfld1C2tcla5mQuSNptnG
         TsSngNqPArO2sG9fIODw1TdbSnfr0Et1sYsJTb86ShKfH+UP4/h7UwBPQaQiKBRvonfG
         QV8lTwt5dWZVgHnh7Prckz7vWGQT0yn9n8zLB01cXCWkEXFQYQKVnIQD1Uo6alrRvEdF
         aC2zBba6WzzJdZodR/L+I0tcc7o7urPH5h1OEDjbqKSZ9LCY1xRNcItDMxj8lyp/Zflo
         1DZA==
X-Gm-Message-State: AOJu0YyCr+wgsqNvVmypYP+ANmakbUzzMAwt9tbLUs18eIdhgLWub5+8
	vZEIesGEM5miGei9HzBbUJxT3j1j2W1DpPegSY8=
X-Google-Smtp-Source: AGHT+IG3A6+qYo3A2jUDdbnnMKzzTMxmmlB2aRQAH2YrOCdMIelpN2MMS4qZksaobs72YKSyDsCFIw==
X-Received: by 2002:a4a:6c16:0:b0:56e:a14a:f04e with SMTP id q22-20020a4a6c16000000b0056ea14af04emr957539ooc.9.1692376589947;
        Fri, 18 Aug 2023 09:36:29 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:bdfa:b54a:9d12:de38])
        by smtp.gmail.com with ESMTPSA id f200-20020a4a58d1000000b005634e8c4bbdsm561531oob.11.2023.08.18.09.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 09:36:29 -0700 (PDT)
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
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 5/5] selftests/tc-testing: cls_u32: update tests
Date: Fri, 18 Aug 2023 13:35:44 -0300
Message-Id: <20230818163544.351104-6-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818163544.351104-1-pctammela@mojatatu.com>
References: <20230818163544.351104-1-pctammela@mojatatu.com>
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

Update the u32 tests to conform to the new syntax of a terminal flowid

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../selftests/tc-testing/tc-tests/filters/u32.json     | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
index ddc7c355be0a..d4b4c767d6c9 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
@@ -15,7 +15,7 @@
         "cmdUnderTest": "$TC filter add dev $DEV1 ingress protocol ip prio 1 u32 match ip src 127.0.0.1/32 flowid 1:1 action ok",
         "expExitCode": "0",
         "verifyCmd": "$TC filter show dev $DEV1 ingress",
-        "matchPattern": "filter protocol ip pref 1 u32 chain (0[ ]+$|0 fh 800: ht divisor 1|0 fh 800::800 order 2048 key ht 800 bkt 0 flowid 1:1.*match 7f000001/ffffffff at 12)",
+        "matchPattern": "filter protocol ip pref 1 u32 chain (0[ ]+$|0 fh 800: ht divisor 1|0 fh 800::800 order 2048 key ht 800 bkt 0 \\*flowid 1:1.*match 7f000001/ffffffff at 12)",
         "matchCount": "3",
         "teardown": [
             "$TC qdisc del dev $DEV1 ingress"
@@ -60,7 +60,7 @@
         "cmdUnderTest": "$TC filter replace dev $DEV1 ingress protocol ip prio 1 u32 match ip src 127.0.0.2/32 indev notexist20 flowid 1:2 action ok",
         "expExitCode": "2",
         "verifyCmd": "$TC filter show dev $DEV1 ingress",
-        "matchPattern": "filter protocol ip pref 1 u32 chain (0[ ]+$|0 fh 800: ht divisor 1|0 fh 800::800 order 2048 key ht 800 bkt 0 flowid 1:3.*match 7f000003/ffffffff at 12)",
+        "matchPattern": "filter protocol ip pref 1 u32 chain (0[ ]+$|0 fh 800: ht divisor 1|0 fh 800::800 order 2048 key ht 800 bkt 0 \\*flowid 1:3.*match 7f000003/ffffffff at 12)",
         "matchCount": "3",
         "teardown": [
             "$TC qdisc del dev $DEV1 ingress"
@@ -196,7 +196,7 @@
         "cmdUnderTest": "$TC filter replace dev $DEV1 ingress protocol ip prio 98 u32 ht 43:1 match tcp src 23 FFFF classid 1:4",
         "expExitCode": "2",
         "verifyCmd": "$TC filter show dev $DEV1 ingress",
-        "matchPattern": "filter protocol ip pref 99 u32 chain (0[ ]+$|0 fh (43|800): ht divisor 1|0 fh 43::800 order 2048 key ht 43 bkt 0 flowid 1:3.*match 00160000/ffff0000 at nexthdr\\+0)",
+        "matchPattern": "filter protocol ip pref 99 u32 chain (0[ ]+$|0 fh (43|800): ht divisor 1|0 fh 43::800 order 2048 key ht 43 bkt 0 \\*flowid 1:3.*match 00160000/ffff0000 at nexthdr\\+0)",
         "matchCount": "4",
         "teardown": [
             "$TC qdisc del dev $DEV1 ingress"
@@ -219,7 +219,7 @@
         "cmdUnderTest": "bash -c \"for mask in ff ffff ffffff ffffffff ff00ff ff0000ff ffff00ff; do $TC filter add dev $DEV1 ingress prio 99 u32 ht 1: sample u32 0x10203040 \\$mask match u8 0 0 classid 1:1; done\"",
         "expExitCode": "0",
         "verifyCmd": "$TC filter show dev $DEV1 ingress",
-        "matchPattern": "filter protocol all pref 99 u32( (chain|fh|order) [0-9:]+){3} key ht 1 bkt 40 flowid 1:1",
+        "matchPattern": "filter protocol all pref 99 u32( (chain|fh|order) [0-9:]+){3} key ht 1 bkt 40 \\*flowid 1:1",
         "matchCount": "7",
         "teardown": [
             "$TC qdisc del dev $DEV1 ingress"
@@ -242,7 +242,7 @@
         "cmdUnderTest": "bash -c \"for mask in 70 f0 ff0 fff0 ff00f0; do $TC filter add dev $DEV1 ingress prio 99 u32 ht 1: sample u32 0x10203040 \\$mask match u8 0 0 classid 1:1; done\"",
         "expExitCode": "0",
         "verifyCmd": "$TC filter show dev $DEV1 ingress",
-        "matchPattern": "filter protocol all pref 99 u32( (chain|fh|order) [0-9:]+){3} key ht 1 bkt 4 flowid 1:1",
+        "matchPattern": "filter protocol all pref 99 u32( (chain|fh|order) [0-9:]+){3} key ht 1 bkt 4 \\*flowid 1:1",
         "matchCount": "5",
         "teardown": [
             "$TC qdisc del dev $DEV1 ingress"
-- 
2.39.2


