Return-Path: <netdev+bounces-57886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EE8814673
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940451F23AA1
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041701CF95;
	Fri, 15 Dec 2023 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="sMHdLjjI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186BF208BD
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59067f03282so400050eaf.0
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702638669; x=1703243469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vs//5zmxgt48nIPUZlKe2UeKImhdieR3yewmQYhxp4=;
        b=sMHdLjjI3M/auqY3zmR80bNTaMBAsEaZZZzQtrgn0Bwwt1NfwFMR94G0OtYsnvx2Ey
         IcNJYZEWOhCwh8xJZvTC5rTC8nkt9nq35fW/RP0Rl6580yw8L3w/2GHV880p8FM4QTD7
         QjTGR+VWVkuQmcpKw/KRYHLHKxLg8npcnqguuOyVjW4jUTRwfBRCDGtxHQTd9/rKo3WL
         KLB2Iep1975s4lzWCYBWWR1rmw0H+eOusVxodCitA/7X+Bs2MQbKChPCjoXdSghIcn83
         EyXFb+SRnJU4Q/L/VwsXTSuZEutuIWAQdxwcBXvJKRKVHy/6EvcvfOfiW9wiMb3hCW6L
         TjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638669; x=1703243469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vs//5zmxgt48nIPUZlKe2UeKImhdieR3yewmQYhxp4=;
        b=paIhtarQKCMDgbM2YHglvLtYpBqeUls60t72NI9U8611wrdi2b55knC6QXQLjXoiw3
         icroZ610DP3/T8LNS4CfBPwS6aJKAYu+YiRWkv7BxOc94l4uLG70nXkqo7Omz76dKLug
         1ROZwpPOKHF1F1QNvr/pWtBsOfuY+8k2zc/TBT185B5oE/STDpRRWFk2PeHuI9QugLbK
         e3GzaFAuZQT2YBv5X6eNU+D4ghItU942tKrmDTmeqpuxuiJqZHnWXWHVMzDOfXnQVXMh
         m3M/Lm2PqPeUSRx4ApI9Yz2BJvhYZeb/ph0f4TlLvIKZqv3RoJ9j/nvYJBQ4hI3nJ9dZ
         t6GA==
X-Gm-Message-State: AOJu0YzM+hSQt1l+b1i6nnNcnudlhLSesvqJtmtmnbHPYQAUAxhH3W3O
	ZXo9CG3zAjUgGZ/IyNrAuwl3WQ==
X-Google-Smtp-Source: AGHT+IGlg7uvRaltDPArUX7wiFQMGNofkePK/IHpEBWwYVBJjhplJUUPX8ZjxQrVYQ8e7MlMdORA2w==
X-Received: by 2002:a05:6358:e4a1:b0:170:cc09:2e3e with SMTP id by33-20020a056358e4a100b00170cc092e3emr12216576rwb.60.1702638669101;
        Fri, 15 Dec 2023 03:11:09 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:60e3:4c1:486f:7eda:5fb5])
        by smtp.gmail.com with ESMTPSA id s16-20020a056a00195000b006cb574445efsm13329045pfk.88.2023.12.15.03.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:11:08 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Cc: mleitner@redhat.com,
	vladbu@nvidia.com,
	paulb@nvidia.com,
	pctammela@mojatatu.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next v7 3/3] net/sched: act_mirred: Allow mirred to block
Date: Fri, 15 Dec 2023 08:10:50 -0300
Message-ID: <20231215111050.3624740-4-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215111050.3624740-1-victor@mojatatu.com>
References: <20231215111050.3624740-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So far the mirred action has dealt with syntax that handles mirror/redirection for netdev.
A matching packet is redirected or mirrored to a target netdev.

In this patch we enable mirred to mirror to a tc block as well.
IOW, the new syntax looks as follows:
... mirred <ingress | egress> <mirror | redirect> [index INDEX] < <blockid BLOCKID> | <dev <devname>> >

Examples of mirroring or redirecting to a tc block:
$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action mirred egress mirror blockid 22

$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 10.10.10.10/32 action mirred egress redirect blockid 22

Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 include/net/tc_act/tc_mirred.h        |   1 +
 include/uapi/linux/tc_act/tc_mirred.h |   1 +
 net/sched/act_mirred.c                | 278 +++++++++++++++++++-------
 3 files changed, 206 insertions(+), 74 deletions(-)

diff --git a/include/net/tc_act/tc_mirred.h b/include/net/tc_act/tc_mirred.h
index 32ce8ea36950..75722d967bf2 100644
--- a/include/net/tc_act/tc_mirred.h
+++ b/include/net/tc_act/tc_mirred.h
@@ -8,6 +8,7 @@
 struct tcf_mirred {
 	struct tc_action	common;
 	int			tcfm_eaction;
+	u32                     tcfm_blockid;
 	bool			tcfm_mac_header_xmit;
 	struct net_device __rcu	*tcfm_dev;
 	netdevice_tracker	tcfm_dev_tracker;
diff --git a/include/uapi/linux/tc_act/tc_mirred.h b/include/uapi/linux/tc_act/tc_mirred.h
index 2500a0005d05..54df06658bc8 100644
--- a/include/uapi/linux/tc_act/tc_mirred.h
+++ b/include/uapi/linux/tc_act/tc_mirred.h
@@ -20,6 +20,7 @@ enum {
 	TCA_MIRRED_UNSPEC,
 	TCA_MIRRED_TM,
 	TCA_MIRRED_PARMS,
+	TCA_MIRRED_BLOCKID,
 	TCA_MIRRED_PAD,
 	__TCA_MIRRED_MAX
 };
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 0a711c184c29..8b6d04d26c5a 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -85,10 +85,20 @@ static void tcf_mirred_release(struct tc_action *a)
 
 static const struct nla_policy mirred_policy[TCA_MIRRED_MAX + 1] = {
 	[TCA_MIRRED_PARMS]	= { .len = sizeof(struct tc_mirred) },
+	[TCA_MIRRED_BLOCKID]	= { .type = NLA_U32 },
 };
 
 static struct tc_action_ops act_mirred_ops;
 
+static void tcf_mirred_replace_dev(struct tcf_mirred *m, struct net_device *ndev)
+{
+	struct net_device *odev;
+
+	odev = rcu_replace_pointer(m->tcfm_dev, ndev,
+				   lockdep_is_held(&m->tcf_lock));
+	netdev_put(odev, &m->tcfm_dev_tracker);
+}
+
 static int tcf_mirred_init(struct net *net, struct nlattr *nla,
 			   struct nlattr *est, struct tc_action **a,
 			   struct tcf_proto *tp,
@@ -126,6 +136,13 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
 	if (exists && bind)
 		return 0;
 
+	if (tb[TCA_MIRRED_BLOCKID] && parm->ifindex) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Mustn't specify Block ID and dev simultaneously");
+		err = -EINVAL;
+		goto release_idr;
+	}
+
 	switch (parm->eaction) {
 	case TCA_EGRESS_MIRROR:
 	case TCA_EGRESS_REDIR:
@@ -142,9 +159,9 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
 	}
 
 	if (!exists) {
-		if (!parm->ifindex) {
+		if (!parm->ifindex && !tb[TCA_MIRRED_BLOCKID]) {
 			tcf_idr_cleanup(tn, index);
-			NL_SET_ERR_MSG_MOD(extack, "Specified device does not exist");
+			NL_SET_ERR_MSG_MOD(extack, "Must specify device or block");
 			return -EINVAL;
 		}
 		ret = tcf_idr_create_from_flags(tn, index, est, a,
@@ -170,7 +187,7 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
 	spin_lock_bh(&m->tcf_lock);
 
 	if (parm->ifindex) {
-		struct net_device *odev, *ndev;
+		struct net_device *ndev;
 
 		ndev = dev_get_by_index(net, parm->ifindex);
 		if (!ndev) {
@@ -179,11 +196,14 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
 			goto put_chain;
 		}
 		mac_header_xmit = dev_is_mac_header_xmit(ndev);
-		odev = rcu_replace_pointer(m->tcfm_dev, ndev,
-					  lockdep_is_held(&m->tcf_lock));
-		netdev_put(odev, &m->tcfm_dev_tracker);
+		tcf_mirred_replace_dev(m, ndev);
 		netdev_tracker_alloc(ndev, &m->tcfm_dev_tracker, GFP_ATOMIC);
 		m->tcfm_mac_header_xmit = mac_header_xmit;
+		m->tcfm_blockid = 0;
+	} else if (tb[TCA_MIRRED_BLOCKID]) {
+		tcf_mirred_replace_dev(m, NULL);
+		m->tcfm_mac_header_xmit = false;
+		m->tcfm_blockid = nla_get_u32(tb[TCA_MIRRED_BLOCKID]);
 	}
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
 	m->tcfm_eaction = parm->eaction;
@@ -211,13 +231,14 @@ static bool is_mirred_nested(void)
 	return unlikely(__this_cpu_read(mirred_nest_level) > 1);
 }
 
-static int tcf_mirred_forward(bool want_ingress, struct sk_buff *skb)
+static int tcf_mirred_forward(bool want_ingress, bool nested_call,
+			      struct sk_buff *skb)
 {
 	int err;
 
 	if (!want_ingress)
 		err = tcf_dev_queue_xmit(skb, dev_queue_xmit);
-	else if (is_mirred_nested())
+	else if (nested_call)
 		err = netif_rx(skb);
 	else
 		err = netif_receive_skb(skb);
@@ -225,110 +246,213 @@ static int tcf_mirred_forward(bool want_ingress, struct sk_buff *skb)
 	return err;
 }
 
-TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
-				     const struct tc_action *a,
-				     struct tcf_result *res)
+static int tcf_redirect_act(struct sk_buff *skb, bool want_ingress)
 {
-	struct tcf_mirred *m = to_mirred(a);
-	struct sk_buff *skb2 = skb;
-	bool m_mac_header_xmit;
-	struct net_device *dev;
-	unsigned int nest_level;
-	int retval, err = 0;
-	bool use_reinsert;
+	skb_set_redirected(skb, skb->tc_at_ingress);
+
+	return tcf_mirred_forward(want_ingress, is_mirred_nested(), skb);
+}
+
+static int tcf_mirror_act(struct sk_buff *skb, bool want_ingress)
+{
+	return tcf_mirred_forward(want_ingress, is_mirred_nested(), skb);
+}
+
+static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
+			     struct net_device *dev,
+			     const bool m_mac_header_xmit, int m_eaction,
+			     int retval)
+{
+	struct sk_buff *skb_to_send = skb;
 	bool want_ingress;
 	bool is_redirect;
-	bool expects_nh;
 	bool at_ingress;
-	int m_eaction;
+	bool dont_clone;
+	bool expects_nh;
 	int mac_len;
 	bool at_nh;
+	int err;
 
-	nest_level = __this_cpu_inc_return(mirred_nest_level);
-	if (unlikely(nest_level > MIRRED_NEST_LIMIT)) {
-		net_warn_ratelimited("Packet exceeded mirred recursion limit on dev %s\n",
-				     netdev_name(skb->dev));
-		__this_cpu_dec(mirred_nest_level);
-		return TC_ACT_SHOT;
-	}
-
-	tcf_lastuse_update(&m->tcf_tm);
-	tcf_action_update_bstats(&m->common, skb);
+	is_redirect = tcf_mirred_is_act_redirect(m_eaction);
+	want_ingress = tcf_mirred_act_wants_ingress(m_eaction);
+	expects_nh = want_ingress || !m_mac_header_xmit;
 
-	m_mac_header_xmit = READ_ONCE(m->tcfm_mac_header_xmit);
-	m_eaction = READ_ONCE(m->tcfm_eaction);
-	retval = READ_ONCE(m->tcf_action);
-	dev = rcu_dereference_bh(m->tcfm_dev);
-	if (unlikely(!dev)) {
-		pr_notice_once("tc mirred: target device is gone\n");
-		goto out;
-	}
+	/* we could easily avoid the clone only if called by ingress and clsact;
+	 * since we can't easily detect the clsact caller, skip clone only for
+	 * ingress - that covers the TC S/W datapath.
+	 */
+	dont_clone = skb_at_tc_ingress(skb) && is_redirect &&
+		     tcf_mirred_can_reinsert(retval);
 
-	if (unlikely(!(dev->flags & IFF_UP)) || !netif_carrier_ok(dev)) {
+	if (unlikely(!(dev->flags & IFF_UP)) ||
+	    !netif_carrier_ok(dev)) {
 		net_notice_ratelimited("tc mirred to Houston: device %s is down\n",
 				       dev->name);
+		err = -ENODEV;
 		goto out;
 	}
 
-	/* we could easily avoid the clone only if called by ingress and clsact;
-	 * since we can't easily detect the clsact caller, skip clone only for
-	 * ingress - that covers the TC S/W datapath.
-	 */
-	is_redirect = tcf_mirred_is_act_redirect(m_eaction);
-	at_ingress = skb_at_tc_ingress(skb);
-	use_reinsert = at_ingress && is_redirect &&
-		       tcf_mirred_can_reinsert(retval);
-	if (!use_reinsert) {
-		skb2 = skb_clone(skb, GFP_ATOMIC);
-		if (!skb2)
+	if (!dont_clone) {
+		skb_to_send = skb_clone(skb, GFP_ATOMIC);
+		if (!skb_to_send) {
+			err =  -ENOMEM;
 			goto out;
+		}
 	}
 
-	want_ingress = tcf_mirred_act_wants_ingress(m_eaction);
+	at_ingress = skb_at_tc_ingress(skb);
 
 	/* All mirred/redirected skbs should clear previous ct info */
-	nf_reset_ct(skb2);
+	nf_reset_ct(skb_to_send);
 	if (want_ingress && !at_ingress) /* drop dst for egress -> ingress */
-		skb_dst_drop(skb2);
+		skb_dst_drop(skb_to_send);
 
-	expects_nh = want_ingress || !m_mac_header_xmit;
 	at_nh = skb->data == skb_network_header(skb);
 	if (at_nh != expects_nh) {
-		mac_len = skb_at_tc_ingress(skb) ? skb->mac_len :
+		mac_len = at_ingress ? skb->mac_len :
 			  skb_network_offset(skb);
 		if (expects_nh) {
 			/* target device/action expect data at nh */
-			skb_pull_rcsum(skb2, mac_len);
+			skb_pull_rcsum(skb_to_send, mac_len);
 		} else {
 			/* target device/action expect data at mac */
-			skb_push_rcsum(skb2, mac_len);
+			skb_push_rcsum(skb_to_send, mac_len);
 		}
 	}
 
-	skb2->skb_iif = skb->dev->ifindex;
-	skb2->dev = dev;
+	skb_to_send->skb_iif = skb->dev->ifindex;
+	skb_to_send->dev = dev;
 
-	/* mirror is always swallowed */
 	if (is_redirect) {
-		skb_set_redirected(skb2, skb2->tc_at_ingress);
-
-		/* let's the caller reinsert the packet, if possible */
-		if (use_reinsert) {
-			err = tcf_mirred_forward(want_ingress, skb);
-			if (err)
-				tcf_action_inc_overlimit_qstats(&m->common);
-			__this_cpu_dec(mirred_nest_level);
-			return TC_ACT_CONSUMED;
-		}
+		if (skb == skb_to_send)
+			retval = TC_ACT_CONSUMED;
+
+		err = tcf_redirect_act(skb_to_send, want_ingress);
+	} else {
+		err = tcf_mirror_act(skb_to_send, want_ingress);
 	}
 
-	err = tcf_mirred_forward(want_ingress, skb2);
-	if (err) {
 out:
+	if (err)
 		tcf_action_inc_overlimit_qstats(&m->common);
-		if (tcf_mirred_is_act_redirect(m_eaction))
-			retval = TC_ACT_SHOT;
+
+	return retval;
+}
+
+static int tcf_mirred_blockcast_redir(struct sk_buff *skb, struct tcf_mirred *m,
+				      struct tcf_block *block, int m_eaction,
+				      const u32 exception_ifindex, int retval)
+{
+	struct net_device *dev_prev = NULL;
+	struct net_device *dev = NULL;
+	unsigned long index;
+	int mirred_eaction;
+
+	mirred_eaction = tcf_mirred_act_wants_ingress(m_eaction) ?
+		TCA_INGRESS_MIRROR : TCA_EGRESS_MIRROR;
+
+	xa_for_each(&block->ports, index, dev) {
+		if (index == exception_ifindex)
+			continue;
+
+		if (dev_prev == NULL)
+			goto assign_prev;
+
+		tcf_mirred_to_dev(skb, m, dev_prev,
+				  dev_is_mac_header_xmit(dev),
+				  mirred_eaction, retval);
+assign_prev:
+		dev_prev = dev;
+	}
+
+	if (dev_prev)
+		return tcf_mirred_to_dev(skb, m, dev_prev,
+					 dev_is_mac_header_xmit(dev_prev),
+					 m_eaction, retval);
+
+	return retval;
+}
+
+static int tcf_mirred_blockcast(struct sk_buff *skb, struct tcf_mirred *m,
+				const u32 blockid, struct tcf_result *res,
+				int retval)
+{
+	const u32 exception_ifindex = skb->dev->ifindex;
+	struct net_device *dev = NULL;
+	struct tcf_block *block;
+	unsigned long index;
+	bool is_redirect;
+	int m_eaction;
+
+	m_eaction = READ_ONCE(m->tcfm_eaction);
+	is_redirect = tcf_mirred_is_act_redirect(m_eaction);
+
+	/* we are already under rcu protection, so can call block lookup directly */
+	block = tcf_block_lookup(dev_net(skb->dev), blockid);
+	if (!block || xa_empty(&block->ports)) {
+		tcf_action_inc_overlimit_qstats(&m->common);
+		return retval;
+	}
+
+	if (is_redirect)
+		return tcf_mirred_blockcast_redir(skb, m, block, m_eaction,
+						  exception_ifindex, retval);
+
+	xa_for_each(&block->ports, index, dev) {
+		if (index == exception_ifindex)
+			continue;
+
+		tcf_mirred_to_dev(skb, m, dev,
+				  dev_is_mac_header_xmit(dev),
+				  m_eaction, retval);
+	}
+
+	return retval;
+}
+
+TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
+				     const struct tc_action *a,
+				     struct tcf_result *res)
+{
+	struct tcf_mirred *m = to_mirred(a);
+	int retval = READ_ONCE(m->tcf_action);
+	unsigned int nest_level;
+	bool m_mac_header_xmit;
+	struct net_device *dev;
+	int m_eaction;
+	u32 blockid;
+
+	nest_level = __this_cpu_inc_return(mirred_nest_level);
+	if (unlikely(nest_level > MIRRED_NEST_LIMIT)) {
+		net_warn_ratelimited("Packet exceeded mirred recursion limit on dev %s\n",
+				     netdev_name(skb->dev));
+		retval = TC_ACT_SHOT;
+		goto dec_nest_level;
+	}
+
+	tcf_lastuse_update(&m->tcf_tm);
+	tcf_action_update_bstats(&m->common, skb);
+
+	blockid = READ_ONCE(m->tcfm_blockid);
+	if (blockid) {
+		retval = tcf_mirred_blockcast(skb, m, blockid, res, retval);
+		goto dec_nest_level;
+	}
+
+	dev = rcu_dereference_bh(m->tcfm_dev);
+	if (unlikely(!dev)) {
+		pr_notice_once("tc mirred: target device is gone\n");
+		tcf_action_inc_overlimit_qstats(&m->common);
+		goto dec_nest_level;
 	}
+
+	m_mac_header_xmit = READ_ONCE(m->tcfm_mac_header_xmit);
+	m_eaction = READ_ONCE(m->tcfm_eaction);
+
+	retval = tcf_mirred_to_dev(skb, m, dev, m_mac_header_xmit, m_eaction,
+				   retval);
+
+dec_nest_level:
 	__this_cpu_dec(mirred_nest_level);
 
 	return retval;
@@ -349,6 +473,7 @@ static int tcf_mirred_dump(struct sk_buff *skb, struct tc_action *a, int bind,
 {
 	unsigned char *b = skb_tail_pointer(skb);
 	struct tcf_mirred *m = to_mirred(a);
+	const u32 blockid = m->tcfm_blockid;
 	struct tc_mirred opt = {
 		.index   = m->tcf_index,
 		.refcnt  = refcount_read(&m->tcf_refcnt) - ref,
@@ -367,6 +492,9 @@ static int tcf_mirred_dump(struct sk_buff *skb, struct tc_action *a, int bind,
 	if (nla_put(skb, TCA_MIRRED_PARMS, sizeof(opt), &opt))
 		goto nla_put_failure;
 
+	if (blockid && nla_put_u32(skb, TCA_MIRRED_BLOCKID, m->tcfm_blockid))
+		goto nla_put_failure;
+
 	tcf_tm_dump(&t, &m->tcf_tm);
 	if (nla_put_64bit(skb, TCA_MIRRED_TM, sizeof(t), &t, TCA_MIRRED_PAD))
 		goto nla_put_failure;
@@ -397,6 +525,8 @@ static int mirred_device_event(struct notifier_block *unused,
 				 * net_device are already rcu protected.
 				 */
 				RCU_INIT_POINTER(m->tcfm_dev, NULL);
+			} else if (m->tcfm_blockid) {
+				m->tcfm_blockid = 0;
 			}
 			spin_unlock_bh(&m->tcf_lock);
 		}
-- 
2.25.1


