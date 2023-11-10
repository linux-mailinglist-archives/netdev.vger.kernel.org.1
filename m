Return-Path: <netdev+bounces-47155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 557FB7E853E
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 22:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7792C1C20966
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 21:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843DF3C6B3;
	Fri, 10 Nov 2023 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="YdENny5+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53D13C68C
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 21:46:41 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04206131
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 13:46:40 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6c320a821c4so2316487b3a.2
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 13:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1699652799; x=1700257599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDjZB/hj6CmjEUlhzRn/Vqn+C70fXR3R3e9xIBFslro=;
        b=YdENny5+AfvwJT6GXRvUC+4/Ew1emb6+LAIOKZPieDyx//CDrjYgWILO2tMD5w6jHC
         LeFh3gffm0cUvWA3HVOBfOOuy3KgqZ1DsiZRYAWwXWHghsz24hn2FSCnVM/xctvi2NG9
         KcpfvlymCZ/VZqLcCmUMkIfOKVxKSDpYxne4JE5LQrWX36RGRm6lABqgGfll2JLfaxB6
         Pd/4+UBh/qeBIMHoTFnaPsT/bXZkiGIhHZUN1rx8eh/s8P1gNLRStxS7AEFLwD4wS7Zc
         YNDioSNMnQqPg04I82fkNcQkukXbKYKt09tQpk8g44xKrgDetmCasNpGkkjB8YbC+DX1
         plxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699652799; x=1700257599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDjZB/hj6CmjEUlhzRn/Vqn+C70fXR3R3e9xIBFslro=;
        b=UpOzAaFH/kS+DLsT+YGbcwtIGigOJJNGfuWvFgNNrKpeijnvSLr+/F1tiQUe3Xx3su
         KVr67BUaHmkqFvGABYUQEEVvzKp5OscqMZsaq7vGoqFM+QqaiGIyKRWkQZPmsdln5I9D
         eai4sbD1ieqRCNhWS06eRwLUjqbWXapM89mePzV1vV+wEiyhTc3h/VcaHlYnm/ePZGPY
         O0VFpNJSS0rFUcb2xHPWb31itTauVeXad7dnFesGVVTxwB/2o56u8om/o95ZrU16Eh3L
         1jfxTz6MrnR9OgZOQNnkz955SPpMcpd5fJPyrThDcCyRF8E16s2U6dPKnw5eFmCc0/Qv
         k/Iw==
X-Gm-Message-State: AOJu0YwwHUIhfv6PUCFguNcLiymlW7aVyS09+ctyF89xqauCAophy3fX
	RlAkReU5L8dqqaznaSMLtkrNmg==
X-Google-Smtp-Source: AGHT+IEXc3+n3ITo1xFARBiXdT63ocMfApbn7Izz3pVb5jSZ+JMEinYmsbkbP/V8YRl5S1E4615FXQ==
X-Received: by 2002:a05:6a20:54a1:b0:163:5bfd:ae5b with SMTP id i33-20020a056a2054a100b001635bfdae5bmr485867pzk.15.1699652799394;
        Fri, 10 Nov 2023 13:46:39 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c3:6a74:a464:c4ff:7a79:ee97])
        by smtp.gmail.com with ESMTPSA id d13-20020a056a00244d00b006b90f1706f1sm166343pfj.134.2023.11.10.13.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 13:46:39 -0800 (PST)
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
Subject: [PATCH net-next RFC v5 4/4] net/sched: act_blockcast: Introduce blockcast tc action
Date: Fri, 10 Nov 2023 18:46:18 -0300
Message-ID: <20231110214618.1883611-5-victor@mojatatu.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231110214618.1883611-1-victor@mojatatu.com>
References: <20231110214618.1883611-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This action takes advantage of the presence of tc block ports set in the
datapath and multicasts a packet to ports on a block. By default, it will
broadcast the packet to a block, that is send to all members of the block except
the port in which the packet arrived on. However, the user may specify
the option "tx_type all", which will send the packet to all members of the
block indiscriminately.

Example usage:
    $ tc qdisc add dev ens7 ingress_block 22
    $ tc qdisc add dev ens8 ingress_block 22

Now we can add a filter to broadcast packets to ports on ingress block id 22:
$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action blockcast blockid 22

Or if we wish to send to all ports in the block:
$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action blockcast blockid 22 tx_type all

Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 include/net/tc_act/tc_blockcast.h        |  16 ++
 include/net/tc_wrapper.h                 |   5 +
 include/uapi/linux/pkt_cls.h             |   1 +
 include/uapi/linux/tc_act/tc_blockcast.h |  32 +++
 net/sched/Kconfig                        |  12 +
 net/sched/Makefile                       |   1 +
 net/sched/act_blockcast.c                | 283 +++++++++++++++++++++++
 7 files changed, 350 insertions(+)
 create mode 100644 include/net/tc_act/tc_blockcast.h
 create mode 100644 include/uapi/linux/tc_act/tc_blockcast.h
 create mode 100644 net/sched/act_blockcast.c

diff --git a/include/net/tc_act/tc_blockcast.h b/include/net/tc_act/tc_blockcast.h
new file mode 100644
index 000000000000..513d6622db66
--- /dev/null
+++ b/include/net/tc_act/tc_blockcast.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __NET_TC_BLOCKCAST_H
+#define __NET_TC_BLOCKCAST_H
+
+#include <net/act_api.h>
+#include <linux/tc_act/tc_blockcast.h>
+
+struct tcf_blockcast_act {
+	struct tc_action common;
+	u32 blockid;
+	enum tc_blockcast_tx_type tx_type;
+};
+
+#define to_blockcast_act(a) ((struct tcf_blockcast_act *)a)
+
+#endif /* __NET_TC_BLOCKCAST_H */
diff --git a/include/net/tc_wrapper.h b/include/net/tc_wrapper.h
index a6d481b5bcbc..5525544ee6ee 100644
--- a/include/net/tc_wrapper.h
+++ b/include/net/tc_wrapper.h
@@ -28,6 +28,7 @@ TC_INDIRECT_ACTION_DECLARE(tcf_csum_act);
 TC_INDIRECT_ACTION_DECLARE(tcf_ct_act);
 TC_INDIRECT_ACTION_DECLARE(tcf_ctinfo_act);
 TC_INDIRECT_ACTION_DECLARE(tcf_gact_act);
+TC_INDIRECT_ACTION_DECLARE(tcf_blockcast_act);
 TC_INDIRECT_ACTION_DECLARE(tcf_gate_act);
 TC_INDIRECT_ACTION_DECLARE(tcf_ife_act);
 TC_INDIRECT_ACTION_DECLARE(tcf_ipt_act);
@@ -57,6 +58,10 @@ static inline int tc_act(struct sk_buff *skb, const struct tc_action *a,
 	if (a->ops->act == tcf_mirred_act)
 		return tcf_mirred_act(skb, a, res);
 #endif
+#if IS_BUILTIN(CONFIG_NET_ACT_BLOCKCAST)
+	if (a->ops->act == tcf_blockcast_act)
+		return tcf_blockcast_act(skb, a, res);
+#endif
 #if IS_BUILTIN(CONFIG_NET_ACT_PEDIT)
 	if (a->ops->act == tcf_pedit_act)
 		return tcf_pedit_act(skb, a, res);
diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index c7082cc60d21..e12fc51c1be1 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -139,6 +139,7 @@ enum tca_id {
 	TCA_ID_MPLS,
 	TCA_ID_CT,
 	TCA_ID_GATE,
+	TCA_ID_BLOCKCAST,
 	/* other actions go here */
 	__TCA_ID_MAX = 255
 };
diff --git a/include/uapi/linux/tc_act/tc_blockcast.h b/include/uapi/linux/tc_act/tc_blockcast.h
new file mode 100644
index 000000000000..fe43d0af439d
--- /dev/null
+++ b/include/uapi/linux/tc_act/tc_blockcast.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __LINUX_TC_BLOCKCAST_H
+#define __LINUX_TC_BLOCKCAST_H
+
+#include <linux/types.h>
+#include <linux/pkt_cls.h>
+
+struct tc_blockcast {
+	tc_gen;
+	__u32                   blockid;  /* block ID to which we'll blockcast */
+};
+
+enum {
+	TCA_BLOCKCAST_UNSPEC,
+	TCA_BLOCKCAST_TM,
+	TCA_BLOCKCAST_PARMS,
+	TCA_BLOCKCAST_TX_TYPE,
+	TCA_BLOCKCAST_PAD,
+	__TCA_BLOCKCAST_MAX
+};
+
+#define TCA_BLOCKCAST_MAX (__TCA_BLOCKCAST_MAX - 1)
+
+enum tc_blockcast_tx_type {
+	TCA_BLOCKCAST_TX_TYPE_BROADCAST,
+	TCA_BLOCKCAST_TX_TYPE_ALL,
+	__TCA_BLOCKCAST_TX_TYPE_MAX,
+};
+
+#define TCA_BLOCKCAST_TX_TYPE_MAX (__TCA_BLOCKCAST_TX_TYPE_MAX - 1)
+
+#endif
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 470c70deffe2..ca1deecdd6ae 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -780,6 +780,18 @@ config NET_ACT_SIMP
 	  To compile this code as a module, choose M here: the
 	  module will be called act_simple.
 
+config NET_ACT_BLOCKCAST
+	tristate "TC block Multicast"
+	depends on NET_CLS_ACT
+	help
+	  Say Y here to add an action that will multicast an skb to egress of
+	  netdevs that belong to a tc block
+
+	  If unsure, say N.
+
+	  To compile this code as a module, choose M here: the
+	  module will be called act_blockcast.
+
 config NET_ACT_SKBEDIT
 	tristate "SKB Editing"
 	depends on NET_CLS_ACT
diff --git a/net/sched/Makefile b/net/sched/Makefile
index b5fd49641d91..2cdcf30645eb 100644
--- a/net/sched/Makefile
+++ b/net/sched/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_NET_ACT_IPT)	+= act_ipt.o
 obj-$(CONFIG_NET_ACT_NAT)	+= act_nat.o
 obj-$(CONFIG_NET_ACT_PEDIT)	+= act_pedit.o
 obj-$(CONFIG_NET_ACT_SIMP)	+= act_simple.o
+obj-$(CONFIG_NET_ACT_BLOCKCAST)	+= act_blockcast.o
 obj-$(CONFIG_NET_ACT_SKBEDIT)	+= act_skbedit.o
 obj-$(CONFIG_NET_ACT_CSUM)	+= act_csum.o
 obj-$(CONFIG_NET_ACT_MPLS)	+= act_mpls.o
diff --git a/net/sched/act_blockcast.c b/net/sched/act_blockcast.c
new file mode 100644
index 000000000000..dc5d1088e534
--- /dev/null
+++ b/net/sched/act_blockcast.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/act_blockcast.c	Block Cast action
+ * Copyright (c) 2023, Mojatatu Networks
+ * Authors:     Jamal Hadi Salim <jhs@mojatatu.com>
+ *              Victor Nogueira <victor@mojatatu.com>
+ *              Pedro Tammela <pctammela@mojatatu.com>
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/skbuff.h>
+#include <linux/rtnetlink.h>
+#include <net/netlink.h>
+#include <net/pkt_sched.h>
+#include <net/pkt_cls.h>
+#include <linux/if_arp.h>
+#include <net/tc_wrapper.h>
+
+#include <linux/tc_act/tc_blockcast.h>
+#include <net/tc_act/tc_blockcast.h>
+#include <net/tc_act/tc_mirred.h>
+
+static struct tc_action_ops act_blockcast_ops;
+
+#define BLOCKCAST_NEST_LIMIT    4
+static DEFINE_PER_CPU(unsigned int, blockcast_nest_level);
+
+TC_INDIRECT_SCOPE int tcf_blockcast_act(struct sk_buff *skb,
+					const struct tc_action *a,
+					struct tcf_result *res)
+{
+	struct tcf_blockcast_act *p = to_blockcast_act(a);
+	enum tc_blockcast_tx_type tx_type = READ_ONCE(p->tx_type);
+	int action = READ_ONCE(p->tcf_action);
+	unsigned int nest_level;
+	struct tcf_block *block;
+	struct net_device *dev;
+	u32 exception_ifindex;
+	unsigned long index;
+
+	nest_level = __this_cpu_inc_return(blockcast_nest_level);
+	if (unlikely(nest_level > BLOCKCAST_NEST_LIMIT)) {
+		net_warn_ratelimited("Packet exceeded blockcast recursion limit on dev %s\n",
+				     netdev_name(skb->dev));
+		__this_cpu_dec(blockcast_nest_level);
+		return TC_ACT_SHOT;
+	}
+
+	exception_ifindex = skb->dev->ifindex;
+
+	tcf_action_update_bstats(&p->common, skb);
+	tcf_lastuse_update(&p->tcf_tm);
+
+	/* we are already under rcu protection, so can call block lookup directly */
+	block = tcf_block_lookup(dev_net(skb->dev), p->blockid);
+	if (!block || xa_empty(&block->ports)) {
+		__this_cpu_dec(blockcast_nest_level);
+		return action;
+	}
+
+	xa_for_each(&block->ports, index, dev) {
+		struct sk_buff *skb_to_send;
+		struct net_device *dev;
+
+		if (tx_type == TCA_BLOCKCAST_TX_TYPE_BROADCAST &&
+		    index == exception_ifindex)
+			continue;
+
+		dev = dev_get_by_index_rcu(dev_net(skb->dev), index);
+		if (unlikely(!dev)) {
+			tcf_action_inc_overlimit_qstats(&p->common);
+			continue;
+		}
+
+		skb_to_send = tcf_mirred_common(skb, false, false,
+						!dev_is_mac_header_xmit(dev),
+						dev);
+		if (IS_ERR(skb_to_send)) {
+			tcf_action_inc_overlimit_qstats(&p->common);
+			continue;
+		}
+
+		if (tcf_mirror_act(skb_to_send, false, false))
+			tcf_action_inc_overlimit_qstats(&p->common);
+	}
+
+	__this_cpu_dec(blockcast_nest_level);
+	return action;
+}
+
+static const struct nla_policy blockcast_policy[TCA_BLOCKCAST_MAX + 1] = {
+	[TCA_BLOCKCAST_PARMS]	= NLA_POLICY_EXACT_LEN(sizeof(struct tc_blockcast)),
+	[TCA_BLOCKCAST_TX_TYPE]	= NLA_POLICY_RANGE(NLA_U8,
+						   TCA_BLOCKCAST_TX_TYPE_BROADCAST,
+						   TCA_BLOCKCAST_TX_TYPE_MAX),
+};
+
+static int tcf_blockcast_init(struct net *net, struct nlattr *nla,
+			      struct nlattr *est, struct tc_action **a,
+			      struct tcf_proto *tp, u32 flags,
+			      struct netlink_ext_ack *extack)
+{
+	struct tc_action_net *tn = net_generic(net, act_blockcast_ops.net_id);
+	bool bind = flags & TCA_ACT_FLAGS_BIND;
+	struct nlattr *tb[TCA_BLOCKCAST_MAX + 1];
+	struct tcf_chain *goto_ch = NULL;
+	struct tcf_blockcast_act *p;
+	struct tc_blockcast *parm;
+	bool exists = false;
+	int ret = 0, err;
+	u32 index;
+
+	if (!nla)
+		return -EINVAL;
+
+	err = nla_parse_nested(tb, TCA_BLOCKCAST_MAX, nla,
+			       blockcast_policy, extack);
+	if (err < 0)
+		return err;
+
+	if (!tb[TCA_BLOCKCAST_PARMS]) {
+		NL_SET_ERR_MSG_MOD(extack, "Must specify blockcast parms");
+		return -EINVAL;
+	}
+
+	parm = nla_data(tb[TCA_BLOCKCAST_PARMS]);
+	index = parm->index;
+
+	err = tcf_idr_check_alloc(tn, &index, a, bind);
+	if (err < 0)
+		return err;
+
+	exists = err;
+	if (exists && bind)
+		return 0;
+
+	if (!exists) {
+		if (!parm->blockid) {
+			tcf_idr_cleanup(tn, index);
+			NL_SET_ERR_MSG_MOD(extack, "Must specify blockid");
+			return -EINVAL;
+		}
+
+		ret = tcf_idr_create_from_flags(tn, index, est, a,
+						&act_blockcast_ops, bind, flags);
+		if (ret) {
+			tcf_idr_cleanup(tn, index);
+			return ret;
+		}
+
+		ret = ACT_P_CREATED;
+	} else {
+		if (!(flags & TCA_ACT_FLAGS_REPLACE)) {
+			err = -EEXIST;
+			goto release_idr;
+		}
+	}
+	p = to_blockcast_act(*a);
+
+	err = tcf_action_check_ctrlact(parm->action, tp, &goto_ch, extack);
+	if (err < 0)
+		goto release_idr;
+
+	if (exists) {
+		spin_lock_bh(&p->tcf_lock);
+		goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
+
+		if (tb[TCA_BLOCKCAST_TX_TYPE])
+			p->tx_type = nla_get_u8(tb[TCA_BLOCKCAST_TX_TYPE]);
+
+		p->blockid = parm->blockid ?: p->blockid;
+
+		spin_unlock_bh(&p->tcf_lock);
+	} else {
+		goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
+
+		/** Default to broadcast if none specified */
+		if (tb[TCA_BLOCKCAST_TX_TYPE])
+			p->tx_type = nla_get_u8(tb[TCA_BLOCKCAST_TX_TYPE]);
+		else
+			p->tx_type = TCA_BLOCKCAST_TX_TYPE_BROADCAST;
+
+		p->blockid = parm->blockid;
+	}
+
+	if (goto_ch)
+		tcf_chain_put_by_act(goto_ch);
+
+	return ret;
+
+release_idr:
+	tcf_idr_release(*a, bind);
+	return err;
+}
+
+static int tcf_blockcast_dump(struct sk_buff *skb, struct tc_action *a,
+			      int bind, int ref)
+{
+	unsigned char *b = skb_tail_pointer(skb);
+	struct tcf_blockcast_act *p = to_blockcast_act(a);
+	struct tc_blockcast opt = {
+		.index   = p->tcf_index,
+		.refcnt  = refcount_read(&p->tcf_refcnt) - ref,
+		.bindcnt = atomic_read(&p->tcf_bindcnt) - bind,
+	};
+	struct tcf_t t;
+
+	spin_lock_bh(&p->tcf_lock);
+	opt.action = p->tcf_action;
+	opt.blockid = p->blockid;
+	if (nla_put(skb, TCA_BLOCKCAST_PARMS, sizeof(opt), &opt))
+		goto nla_put_failure;
+
+	tcf_tm_dump(&t, &p->tcf_tm);
+	if (nla_put_64bit(skb, TCA_BLOCKCAST_TM, sizeof(t), &t,
+			  TCA_BLOCKCAST_PAD))
+		goto nla_put_failure;
+
+	if (nla_put_u8(skb, TCA_BLOCKCAST_TX_TYPE, p->tx_type))
+		goto nla_put_failure;
+
+	spin_unlock_bh(&p->tcf_lock);
+
+	return skb->len;
+
+nla_put_failure:
+	spin_unlock_bh(&p->tcf_lock);
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
+static struct tc_action_ops act_blockcast_ops = {
+	.kind		=	"blockcast",
+	.id		=	TCA_ID_BLOCKCAST,
+	.owner		=	THIS_MODULE,
+	.act		=	tcf_blockcast_act,
+	.dump		=	tcf_blockcast_dump,
+	.init		=	tcf_blockcast_init,
+	.size		=	sizeof(struct tcf_blockcast_act),
+};
+
+static __net_init int blockcast_init_net(struct net *net)
+{
+	struct tc_action_net *tn = net_generic(net, act_blockcast_ops.net_id);
+
+	return tc_action_net_init(net, tn, &act_blockcast_ops);
+}
+
+static void __net_exit blockcast_exit_net(struct list_head *net_list)
+{
+	tc_action_net_exit(net_list, act_blockcast_ops.net_id);
+}
+
+static struct pernet_operations blockcast_net_ops = {
+	.init = blockcast_init_net,
+	.exit_batch = blockcast_exit_net,
+	.id   = &act_blockcast_ops.net_id,
+	.size = sizeof(struct tc_action_net),
+};
+
+MODULE_AUTHOR("Mojatatu Networks, Inc");
+MODULE_DESCRIPTION("Action to broadcast to devices on a block");
+MODULE_LICENSE("GPL");
+
+static int __init blockcast_init_module(void)
+{
+	int ret = tcf_register_action(&act_blockcast_ops, &blockcast_net_ops);
+
+	if (!ret)
+		pr_info("blockcast TC action Loaded\n");
+	return ret;
+}
+
+static void __exit blockcast_cleanup_module(void)
+{
+	tcf_unregister_action(&act_blockcast_ops, &blockcast_net_ops);
+}
+
+module_init(blockcast_init_module);
+module_exit(blockcast_cleanup_module);
-- 
2.25.1


