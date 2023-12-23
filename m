Return-Path: <netdev+bounces-60088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0502181D469
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 15:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53BEDB2158D
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 14:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABA9DDB3;
	Sat, 23 Dec 2023 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="RowDf2CY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75F5E56B
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-77f8308616eso201585585a.2
        for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 06:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703340138; x=1703944938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2qaiD8GmZiqa5r3mLnEbXbwwvsEsQgPYHKI0Z94tmc=;
        b=RowDf2CYpGG2CUoJhxJDaSmK62SCWr1wreRIk08V19J1A5AfsPxQtLUmRATUtrN1KW
         4HxUsNmqGOQOjJR8sOVeZInu7/PVWgNpSQO6qMQ85i03BY7lNDueZMSFQDo7tiZU6G2C
         tWiRuZSvWPlKRPfLK0tb9ioxbaVj3NAd8sazmB5pqnnx5P1fC4Y0Auv+Q5LTlm/CfTi0
         +ICGKps1mEDHDLch/r/vdKwlZlPxB4oA4vBQEvwVT5NObij121khpNfgpmVroi9sp7zI
         2GhGKsoqXgzyylZkAh83lVOUOU340Gqs6PrjJxM4cxQNywUjn8JZZQMy/uzQspSo2i+i
         J8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703340138; x=1703944938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2qaiD8GmZiqa5r3mLnEbXbwwvsEsQgPYHKI0Z94tmc=;
        b=B9SYq8WQwbfn0zxvH5RfdFBp9Qd3l09p5FUlnuPnLNHVnrkuCwT+8XwfjJVyDNIH+s
         8DscFuIofEM3TfOSEnXPOx1olFlMvtVsm9jZZpos3sYyypTHjC0xFHv4q1Kaf01e1BxL
         jOPPTAkhAWNKfw68v/F7T8c9vyJKCQKGhpnBxXjR0lfQf80z3vfvQWV8H3waVuCD+Hzv
         WS0wzUz2tk0zZ/XWYwu0kiWnkPSm3hf/2bLL4LYRph+f0imaSMfvzdSNQTK99fJNnthD
         EuaZe/QbsVoLcVHUP11DYFRffZyHX+Lt9MLxZYRhSl/45AuKhpNvZa+ud11t1AEh1gFD
         xrsA==
X-Gm-Message-State: AOJu0Yz4BBhdOlEnzlJ+oH5LRCZPk9jazfoA455JP9gBVWarIFQNx9k2
	jYbgAHeUYXpEvti+yW5Gqvb6sofvJL+j
X-Google-Smtp-Source: AGHT+IHYfuDk06ibzexHEfBGMjzBztmWmE//HV73GyS+lyyaJxvL34W2a7sJ4e9f8OHoBfUGWZAgZA==
X-Received: by 2002:a05:620a:880c:b0:781:2db2:49c9 with SMTP id qj12-20020a05620a880c00b007812db249c9mr2720329qkn.43.1703340138530;
        Sat, 23 Dec 2023 06:02:18 -0800 (PST)
Received: from majuu.waya ([174.91.6.24])
        by smtp.gmail.com with ESMTPSA id 25-20020a05620a04d900b0077f0a4bd3c6sm2062968qks.77.2023.12.23.06.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 06:02:17 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com
Cc: jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	netdev@vger.kernel.org,
	stephen@networkplumber.org,
	dsahern@gmail.com,
	pctammela@mojatatu.com,
	victor@mojatatu.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net-next 5/5] net/sched: Remove uapi support for CBQ qdisc
Date: Sat, 23 Dec 2023 09:01:54 -0500
Message-Id: <20231223140154.1319084-6-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231223140154.1319084-1-jhs@mojatatu.com>
References: <20231223140154.1319084-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 051d44209842 ("net/sched: Retire CBQ qdisc") retired the CBQ qdisc.
Remove UAPI for it. Iproute2 will sync by equally removing it from user space.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/uapi/linux/pkt_sched.h       | 80 ----------------------------
 tools/include/uapi/linux/pkt_sched.h | 80 ----------------------------
 2 files changed, 160 deletions(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 28f08acdad52..a3cd0c2dc995 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -477,86 +477,6 @@ enum {
 
 #define TCA_HFSC_MAX (__TCA_HFSC_MAX - 1)
 
-
-/* CBQ section */
-
-#define TC_CBQ_MAXPRIO		8
-#define TC_CBQ_MAXLEVEL		8
-#define TC_CBQ_DEF_EWMA		5
-
-struct tc_cbq_lssopt {
-	unsigned char	change;
-	unsigned char	flags;
-#define TCF_CBQ_LSS_BOUNDED	1
-#define TCF_CBQ_LSS_ISOLATED	2
-	unsigned char  	ewma_log;
-	unsigned char  	level;
-#define TCF_CBQ_LSS_FLAGS	1
-#define TCF_CBQ_LSS_EWMA	2
-#define TCF_CBQ_LSS_MAXIDLE	4
-#define TCF_CBQ_LSS_MINIDLE	8
-#define TCF_CBQ_LSS_OFFTIME	0x10
-#define TCF_CBQ_LSS_AVPKT	0x20
-	__u32		maxidle;
-	__u32		minidle;
-	__u32		offtime;
-	__u32		avpkt;
-};
-
-struct tc_cbq_wrropt {
-	unsigned char	flags;
-	unsigned char	priority;
-	unsigned char	cpriority;
-	unsigned char	__reserved;
-	__u32		allot;
-	__u32		weight;
-};
-
-struct tc_cbq_ovl {
-	unsigned char	strategy;
-#define	TC_CBQ_OVL_CLASSIC	0
-#define	TC_CBQ_OVL_DELAY	1
-#define	TC_CBQ_OVL_LOWPRIO	2
-#define	TC_CBQ_OVL_DROP		3
-#define	TC_CBQ_OVL_RCLASSIC	4
-	unsigned char	priority2;
-	__u16		pad;
-	__u32		penalty;
-};
-
-struct tc_cbq_police {
-	unsigned char	police;
-	unsigned char	__res1;
-	unsigned short	__res2;
-};
-
-struct tc_cbq_fopt {
-	__u32		split;
-	__u32		defmap;
-	__u32		defchange;
-};
-
-struct tc_cbq_xstats {
-	__u32		borrows;
-	__u32		overactions;
-	__s32		avgidle;
-	__s32		undertime;
-};
-
-enum {
-	TCA_CBQ_UNSPEC,
-	TCA_CBQ_LSSOPT,
-	TCA_CBQ_WRROPT,
-	TCA_CBQ_FOPT,
-	TCA_CBQ_OVL_STRATEGY,
-	TCA_CBQ_RATE,
-	TCA_CBQ_RTAB,
-	TCA_CBQ_POLICE,
-	__TCA_CBQ_MAX,
-};
-
-#define TCA_CBQ_MAX	(__TCA_CBQ_MAX - 1)
-
 /* Network emulator */
 
 enum {
diff --git a/tools/include/uapi/linux/pkt_sched.h b/tools/include/uapi/linux/pkt_sched.h
index fc695429bc59..587481a19433 100644
--- a/tools/include/uapi/linux/pkt_sched.h
+++ b/tools/include/uapi/linux/pkt_sched.h
@@ -457,86 +457,6 @@ enum {
 
 #define TCA_HFSC_MAX (__TCA_HFSC_MAX - 1)
 
-
-/* CBQ section */
-
-#define TC_CBQ_MAXPRIO		8
-#define TC_CBQ_MAXLEVEL		8
-#define TC_CBQ_DEF_EWMA		5
-
-struct tc_cbq_lssopt {
-	unsigned char	change;
-	unsigned char	flags;
-#define TCF_CBQ_LSS_BOUNDED	1
-#define TCF_CBQ_LSS_ISOLATED	2
-	unsigned char  	ewma_log;
-	unsigned char  	level;
-#define TCF_CBQ_LSS_FLAGS	1
-#define TCF_CBQ_LSS_EWMA	2
-#define TCF_CBQ_LSS_MAXIDLE	4
-#define TCF_CBQ_LSS_MINIDLE	8
-#define TCF_CBQ_LSS_OFFTIME	0x10
-#define TCF_CBQ_LSS_AVPKT	0x20
-	__u32		maxidle;
-	__u32		minidle;
-	__u32		offtime;
-	__u32		avpkt;
-};
-
-struct tc_cbq_wrropt {
-	unsigned char	flags;
-	unsigned char	priority;
-	unsigned char	cpriority;
-	unsigned char	__reserved;
-	__u32		allot;
-	__u32		weight;
-};
-
-struct tc_cbq_ovl {
-	unsigned char	strategy;
-#define	TC_CBQ_OVL_CLASSIC	0
-#define	TC_CBQ_OVL_DELAY	1
-#define	TC_CBQ_OVL_LOWPRIO	2
-#define	TC_CBQ_OVL_DROP		3
-#define	TC_CBQ_OVL_RCLASSIC	4
-	unsigned char	priority2;
-	__u16		pad;
-	__u32		penalty;
-};
-
-struct tc_cbq_police {
-	unsigned char	police;
-	unsigned char	__res1;
-	unsigned short	__res2;
-};
-
-struct tc_cbq_fopt {
-	__u32		split;
-	__u32		defmap;
-	__u32		defchange;
-};
-
-struct tc_cbq_xstats {
-	__u32		borrows;
-	__u32		overactions;
-	__s32		avgidle;
-	__s32		undertime;
-};
-
-enum {
-	TCA_CBQ_UNSPEC,
-	TCA_CBQ_LSSOPT,
-	TCA_CBQ_WRROPT,
-	TCA_CBQ_FOPT,
-	TCA_CBQ_OVL_STRATEGY,
-	TCA_CBQ_RATE,
-	TCA_CBQ_RTAB,
-	TCA_CBQ_POLICE,
-	__TCA_CBQ_MAX,
-};
-
-#define TCA_CBQ_MAX	(__TCA_CBQ_MAX - 1)
-
 /* Network emulator */
 
 enum {
-- 
2.34.1


