Return-Path: <netdev+bounces-61734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DFE824C2F
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 01:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C74284146
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 00:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22CB380;
	Fri,  5 Jan 2024 00:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="OFEZyNsd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2169A110A
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 00:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28beb1d946fso877585a91.0
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 16:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1704415102; x=1705019902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aeqm6MfkDPgW8joZXvD5HPa2N+HgjnGCsZuUtvcyjcM=;
        b=OFEZyNsd0iBcFcojw2IrOoJCG6aLtw8ZQqF1WVdUNlwApkHhjZigx0ofK/BwgmEsLZ
         AZ6Rd7XtkUl12lK91dvbBAvatsaFxjUNs2YQpKIlN3mwRgR0eU2mVKwm6ebRsOGDStud
         VcSRyj0kbGWlq7yLB1ilsv7eeOaiKyjNQ0QPrZ2NkaCLXQ+mOQJK2n2RGLH7v79b4Jc5
         JpR5KfazqJjNrxECh3KtoFIBB5mzw7t8UB3hgqGGjQBOEYJjpvrJTphtUBQR6rnvcMXj
         sLqDS4mBicGncwRJM2Wc0Ld2vBXz264ick0ZDS2H4uXybWkNIifi3EqjsPFebgVRO55Q
         GNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704415102; x=1705019902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aeqm6MfkDPgW8joZXvD5HPa2N+HgjnGCsZuUtvcyjcM=;
        b=aK+mbLOocjI0CSMinnOvkb0TwQUB28QnkjyEBSD4P6g/2SshT/37+Br8aCJMysZh/c
         T6krdkQzH/e15eREqGKHOwF1+PbVwuHENEiR4P/2sp2aWOolPl5xNGWZZB3vw0BngSol
         bI1x+STnCUMh+DIFD7cgqIkI5A7L1+bHe+3TZpO53qIKXeQHbxT1JYpHz1dcATwch+S7
         VgPZYFjlqxqUFfDej3EOemGNJih8oXnihNKDiy9/VsBi27wn9O+RP/yNuofmfJTm6F34
         bnvLQ7xdpbRXvh7/gcYC6k0XWp6f3wl08AfcbFO8fRimhX4Nw7Lbr+O16xAszNdt/GKz
         /b8w==
X-Gm-Message-State: AOJu0Yxcnx7aV1i+ISdsgn62xQR4ulFXtioYmUXHSlaw7pB00jbohn/N
	yHUbbM+2bi1oEpE8r8x0sXlYd1l4+qnDubPFkywJsqHy5Ipg
X-Google-Smtp-Source: AGHT+IE0I4LlOEHfRC54zXiC2nUx9e9GYuQPoWl3MtTmOH+e2Mq2PZjF6bEkRDaImavEpoc8KmoIVw==
X-Received: by 2002:a17:90a:8a01:b0:286:a502:dfe2 with SMTP id w1-20020a17090a8a0100b00286a502dfe2mr1364230pjn.52.1704415102223;
        Thu, 04 Jan 2024 16:38:22 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902e84300b001d3abc86c9fsm196030plg.195.2024.01.04.16.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 16:38:21 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	Pedro Tammela <pctammela@mojatatu.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next v2] net/sched: simplify tc_action_load_ops parameters
Date: Thu,  4 Jan 2024 21:38:10 -0300
Message-Id: <20240105003810.2056224-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using two bools derived from a flags passed as arguments to
the parent function of tc_action_load_ops, just pass the flags itself
to tc_action_load_ops to simplify its parameters.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 include/net/act_api.h |  3 +--
 net/sched/act_api.c   | 10 +++++-----
 net/sched/cls_api.c   |  5 ++---
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 447985a45ef6..e1e5e72b901e 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -208,8 +208,7 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 		    struct nlattr *est,
 		    struct tc_action *actions[], int init_res[], size_t *attr_size,
 		    u32 flags, u32 fl_flags, struct netlink_ext_ack *extack);
-struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, bool police,
-					 bool rtnl_held,
+struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 flags,
 					 struct netlink_ext_ack *extack);
 struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *tp,
 				    struct nlattr *nla, struct nlattr *est,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index ef70d4771811..3e30d7260493 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1324,10 +1324,10 @@ void tcf_idr_insert_many(struct tc_action *actions[], int init_res[])
 	}
 }
 
-struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, bool police,
-					 bool rtnl_held,
+struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 flags,
 					 struct netlink_ext_ack *extack)
 {
+	bool police = flags & TCA_ACT_FLAGS_POLICE;
 	struct nlattr *tb[TCA_ACT_MAX + 1];
 	struct tc_action_ops *a_o;
 	char act_name[IFNAMSIZ];
@@ -1359,6 +1359,8 @@ struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, bool police,
 	a_o = tc_lookup_action_n(act_name);
 	if (a_o == NULL) {
 #ifdef CONFIG_MODULES
+		bool rtnl_held = !(flags & TCA_ACT_FLAGS_NO_RTNL);
+
 		if (rtnl_held)
 			rtnl_unlock();
 		request_module("act_%s", act_name);
@@ -1475,9 +1477,7 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 	for (i = 1; i <= TCA_ACT_MAX_PRIO && tb[i]; i++) {
 		struct tc_action_ops *a_o;
 
-		a_o = tc_action_load_ops(tb[i], flags & TCA_ACT_FLAGS_POLICE,
-					 !(flags & TCA_ACT_FLAGS_NO_RTNL),
-					 extack);
+		a_o = tc_action_load_ops(tb[i], flags, extack);
 		if (IS_ERR(a_o)) {
 			err = PTR_ERR(a_o);
 			goto err_mod;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index adf5de1ff773..4b8ff5b4eb18 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -3300,12 +3300,11 @@ int tcf_exts_validate_ex(struct net *net, struct tcf_proto *tp, struct nlattr **
 		if (exts->police && tb[exts->police]) {
 			struct tc_action_ops *a_o;
 
-			a_o = tc_action_load_ops(tb[exts->police], true,
-						 !(flags & TCA_ACT_FLAGS_NO_RTNL),
+			flags |= TCA_ACT_FLAGS_POLICE | TCA_ACT_FLAGS_BIND;
+			a_o = tc_action_load_ops(tb[exts->police], flags,
 						 extack);
 			if (IS_ERR(a_o))
 				return PTR_ERR(a_o);
-			flags |= TCA_ACT_FLAGS_POLICE | TCA_ACT_FLAGS_BIND;
 			act = tcf_action_init_1(net, tp, tb[exts->police],
 						rate_tlv, a_o, init_res, flags,
 						extack);
-- 
2.40.1


