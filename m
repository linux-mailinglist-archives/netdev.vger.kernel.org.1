Return-Path: <netdev+bounces-47422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9D57EA272
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 18:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD615B208C8
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 17:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6DA2233A;
	Mon, 13 Nov 2023 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKKga4b9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A241224C0
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 17:53:33 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F06110E5
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 09:53:31 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77891f362cfso392103785a.1
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 09:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699898010; x=1700502810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=psJZRp9gel0iZutUghh8mVYP3vXhAbNoGRhcE2FVE90=;
        b=eKKga4b9DhiSPRcLDw28OcyaVcIFcZp/Xn87X1nyqdPllZWFk7Luookslb+XGdQ4TG
         AQnPQLpr2LlxKL62wSh8/0j3eyCPnOvlVUvDYYIr/VDcmnFbtsnoPRwAH+khXq/pu258
         tBM58fIDsEs9K0HZeVOmO1kgTWtTj7bWMc9Mnmc8DVPZ4pBibnQ/xp2LKNbZghluxQ8M
         8IFSjuTOJrcX/2xPigXn1dqJ0MgmHzqKNjBvp0sJzVJymzqzH3HnwQ1FIRjriiYtw3H0
         UZuWlGySADkQ1VWrxMMsxxZLO7tWpcos+w/oYAPz4gqmtYIUFW6RCNqKYFxhPCJ5QpF8
         jwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699898010; x=1700502810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psJZRp9gel0iZutUghh8mVYP3vXhAbNoGRhcE2FVE90=;
        b=T8JxjuLNE4bB/W4n80j+d3JITuAxBriWFvgLgYeJL5Jyk/OhOVJda9WlP1l59TDrjI
         7SMOhRYGxPdzP95XUCHO7eOtV1opOjeW0SnpR3+HNFxezJf2LaZ2sfZeCOWe3nIlM4Ta
         FuRMxUDnANwAjbf12ZMqKA1jcsjY2x6zEKB5vbt3504e+7dBEunBu4N3RZ9o1VwdVza3
         RdbZfh4BHdH1aCY/Lx6PknKkHHQ8yLFD9QPRpxjeD9M5tAoYHSVBh8D6Wf715p+dlm/d
         15LEC5wmSimN9RemQM/PW5156+K0biHUMTpi4donD1ffPP/4dKHn47d3eYz/t/FDh1z8
         QcSA==
X-Gm-Message-State: AOJu0YzdLEC4HlNWLjgPt4A1/vGc40FNiIPO/pZfpWNkpv2KkyPkC/Rj
	jPoyireadaV1hapFWlJ3ptKH4BbhVhg=
X-Google-Smtp-Source: AGHT+IFjPgjROEYd+KIrJAeIWXyryQhpHJ6BxvUDxNqiFpDfxZSjdAUTnSeUMxMD6HKOFxVJL2dNPg==
X-Received: by 2002:a05:620a:178f:b0:778:8cdb:88ff with SMTP id ay15-20020a05620a178f00b007788cdb88ffmr361743qkb.31.1699898009962;
        Mon, 13 Nov 2023 09:53:29 -0800 (PST)
Received: from wsfd-netdev15.ntdv.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id qk6-20020a05620a888600b0077a02b8b504sm2026703qkn.52.2023.11.13.09.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 09:53:29 -0800 (PST)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladyslav Tarasiuk <vladyslavt@nvidia.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net] net: sched: do not offload flows with a helper in act_ct
Date: Mon, 13 Nov 2023 12:53:28 -0500
Message-Id: <f8685ec7702c4a448a1371a8b34b43217b583b9d.1699898008.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no hardware supporting ct helper offload. However, prior to this
patch, a flower filter with a helper in the ct action can be successfully
set into the HW, for example (eth1 is a bnxt NIC):

  # tc qdisc add dev eth1 ingress_block 22 ingress
  # tc filter add block 22 proto ip flower skip_sw ip_proto tcp \
    dst_port 21 ct_state -trk action ct helper ipv4-tcp-ftp
  # tc filter show dev eth1 ingress

    filter block 22 protocol ip pref 49152 flower chain 0 handle 0x1
      eth_type ipv4
      ip_proto tcp
      dst_port 21
      ct_state -trk
      skip_sw
      in_hw in_hw_count 1   <----
        action order 1: ct zone 0 helper ipv4-tcp-ftp pipe
         index 2 ref 1 bind 1
        used_hw_stats delayed

This might cause the flower filter not to work as expected in the HW.

This patch avoids this problem by simply returning -EOPNOTSUPP in
tcf_ct_offload_act_setup() to not allow to offload flows with a helper
in act_ct.

Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 include/net/tc_act/tc_ct.h | 9 +++++++++
 net/sched/act_ct.c         | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/include/net/tc_act/tc_ct.h b/include/net/tc_act/tc_ct.h
index 8a6dbfb23336..77f87c622a2e 100644
--- a/include/net/tc_act/tc_ct.h
+++ b/include/net/tc_act/tc_ct.h
@@ -58,6 +58,11 @@ static inline struct nf_flowtable *tcf_ct_ft(const struct tc_action *a)
 	return to_ct_params(a)->nf_ft;
 }
 
+static inline struct nf_conntrack_helper *tcf_ct_helper(const struct tc_action *a)
+{
+	return to_ct_params(a)->helper;
+}
+
 #else
 static inline uint16_t tcf_ct_zone(const struct tc_action *a) { return 0; }
 static inline int tcf_ct_action(const struct tc_action *a) { return 0; }
@@ -65,6 +70,10 @@ static inline struct nf_flowtable *tcf_ct_ft(const struct tc_action *a)
 {
 	return NULL;
 }
+static inline struct nf_conntrack_helper *tcf_ct_helper(const struct tc_action *a)
+{
+	return NULL;
+}
 #endif /* CONFIG_NF_CONNTRACK */
 
 #if IS_ENABLED(CONFIG_NET_ACT_CT)
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 0db0ecf1d110..b3f4a503ee2b 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1549,6 +1549,9 @@ static int tcf_ct_offload_act_setup(struct tc_action *act, void *entry_data,
 	if (bind) {
 		struct flow_action_entry *entry = entry_data;
 
+		if (tcf_ct_helper(act))
+			return -EOPNOTSUPP;
+
 		entry->id = FLOW_ACTION_CT;
 		entry->ct.action = tcf_ct_action(act);
 		entry->ct.zone = tcf_ct_zone(act);
-- 
2.39.1


