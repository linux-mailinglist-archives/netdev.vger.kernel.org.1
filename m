Return-Path: <netdev+bounces-38369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F137BA956
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 20:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9C022281572
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC013D990;
	Thu,  5 Oct 2023 18:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="jHPTE37W"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5C328DD7
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 18:43:03 +0000 (UTC)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1BAAB
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 11:43:01 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5809d5fe7f7so916070a12.3
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 11:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696531381; x=1697136181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQdD3nl8ItlAuxCdP4SZ4kytJJ0umljUsnA6H0dBsr8=;
        b=jHPTE37WO+jfdZ4hCzTkRd99euxt8/l0xtqx3qde7ok9yyrGMQ3PuWOhU7+CKtVNCY
         lcgoEpBzxEeXV1p/1Me+7A016fj6QVbrRsv3AsODvIj2GVyfCbJBgLkldu0zMSv1sFjr
         3pJO0MyXTXKDvh3yfM1JaZRcSfQ8wUbZANLMjjHIpZpCbIRSScAMAK8+/TZwYdwIT1Hm
         TgmEfQYuxMzOFcHTlL+1ahnBZTd3NFH/kCnKcl4yJeUwKMXWbuORXmDCmCSaxj7zYWhu
         NLgRK0U31MRFyR0GYTKsajKcIeV6G2Zi2Ou5YsXF96CiaLsioC6EgSVqjFT/t84rP+oL
         FUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696531381; x=1697136181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQdD3nl8ItlAuxCdP4SZ4kytJJ0umljUsnA6H0dBsr8=;
        b=CykHj2U0H5ag3v1hy9fupKTLfwmuiF9/3vRJGykmXa4BgHxNm04AJ8CKzHr5SZ+/hm
         ActwBx5K3w7WFoEokCJy8XDBBGAM6/YvqjbFlBcnZZKDdkO0l/kuQeYjOO5C6cxtEr6H
         6copB8vYI54HtzjHreX9vPBntaBPJDTFaAk0kaxAObU4vNNrmyc24MPpvMztVWWNvCWA
         zp/ChkRZ0QbPTCeO+gO+6BYDT7mVZyJAxINcSADGNySgFs9WXKg6Gpialb3fqvDWx+FB
         NYlXfnNq0k2ALpgRffp+fPu/oLhbMgGUXYHFVHkH98cOvwkBDPEYBwKObV+Rfgr+BcJn
         Krbg==
X-Gm-Message-State: AOJu0YzrWGsboCUwVXsnjEvNTHVX4r8ZAPQvY0aCDSZJKhFeFwp9Meun
	AQh4hDIKESUEx3Tlni7dpyIxZMYu5OYN+8ADvnQ=
X-Google-Smtp-Source: AGHT+IHr4IkLdIgmlQHiYn9lvJ+XFaoFbc0ixzKbzf1FNc50yTEaqPNIjx/yGwJ9jIZzY+g3+hI/zw==
X-Received: by 2002:a05:6a21:788a:b0:15c:b7ba:ea44 with SMTP id bf10-20020a056a21788a00b0015cb7baea44mr6871526pzc.60.1696531380674;
        Thu, 05 Oct 2023 11:43:00 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c2:b6b7:54d9:6465:eb2f:5366])
        by smtp.gmail.com with ESMTPSA id x28-20020aa793bc000000b00690d4c16296sm1725831pff.154.2023.10.05.11.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 11:43:00 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	kuba@kernel.org
Cc: mleitner@redhat.com,
	vladbu@nvidia.com,
	simon.horman@corigine.com,
	pctammela@mojatatu.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next v4 3/3] net/sched: act_blockcast: Introduce blockcast tc action
Date: Thu,  5 Oct 2023 15:42:28 -0300
Message-ID: <20231005184228.467845-4-victor@mojatatu.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231005184228.467845-1-victor@mojatatu.com>
References: <20231005184228.467845-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This action takes advantage of the presence of tc block ports set in the
datapath and broadcast a packet to all ports on that set with exception of
the port in which it arrived on.

Example usage:
    $ tc qdisc add dev ens7 ingress block 22
    $ tc qdisc add dev ens8 ingress block 22

Now we can add a filter using the block index:
$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action blockcast

Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 include/net/tc_wrapper.h     |   5 +
 include/uapi/linux/pkt_cls.h |   1 +
 net/sched/Kconfig            |  13 ++
 net/sched/Makefile           |   1 +
 net/sched/act_blockcast.c    | 297 +++++++++++++++++++++++++++++++++++
 5 files changed, 317 insertions(+)
 create mode 100644 net/sched/act_blockcast.c

diff --git a/include/net/tc_wrapper.h b/include/net/tc_wrapper.h
index a6d481b5bcbc..8ef848968be7 100644
--- a/include/net/tc_wrapper.h
+++ b/include/net/tc_wrapper.h
@@ -28,6 +28,7 @@ TC_INDIRECT_ACTION_DECLARE(tcf_csum_act);
 TC_INDIRECT_ACTION_DECLARE(tcf_ct_act);
 TC_INDIRECT_ACTION_DECLARE(tcf_ctinfo_act);
 TC_INDIRECT_ACTION_DECLARE(tcf_gact_act);
+TC_INDIRECT_ACTION_DECLARE(tcf_blockcast_run);
 TC_INDIRECT_ACTION_DECLARE(tcf_gate_act);
 TC_INDIRECT_ACTION_DECLARE(tcf_ife_act);
 TC_INDIRECT_ACTION_DECLARE(tcf_ipt_act);
@@ -57,6 +58,10 @@ static inline int tc_act(struct sk_buff *skb, const struct tc_action *a,
 	if (a->ops->act == tcf_mirred_act)
 		return tcf_mirred_act(skb, a, res);
 #endif
+#if IS_BUILTIN(CONFIG_NET_ACT_BLOCKCAST)
+	if (a->ops->act == tcf_blockcast_run)
+		return tcf_blockcast_run(skb, a, res);
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
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 470c70deffe2..abf26f0c921f 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -780,6 +780,19 @@ config NET_ACT_SIMP
 	  To compile this code as a module, choose M here: the
 	  module will be called act_simple.
 
+config NET_ACT_BLOCKCAST
+	tristate "TC block Multicast"
+	depends on NET_CLS_ACT
+	help
+	  Say Y here to add an action that will multicast an skb to egress of
+	  all netdevs that belong to a tc block except for the netdev on which
+          the skb arrived on
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
index 000000000000..047023cba749
--- /dev/null
+++ b/net/sched/act_blockcast.c
@@ -0,0 +1,297 @@
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
+#include <linux/tc_act/tc_defact.h>
+
+static struct tc_action_ops act_blockcast_ops;
+
+struct tcf_blockcast_act {
+	struct tc_action	common;
+};
+
+#define to_blockcast_act(a) ((struct tcf_blockcast_act *)a)
+
+#define CAST_RECURSION_LIMIT  4
+
+static DEFINE_PER_CPU(unsigned int, redirect_rec_level);
+
+static int cast_one(struct sk_buff *skb, const u32 ifindex)
+{
+	struct sk_buff *skb2 = skb;
+	int retval = TC_ACT_PIPE;
+	struct net_device *dev;
+	unsigned int rec_level;
+	bool expects_nh;
+	int mac_len;
+	bool at_nh;
+	int err;
+
+	rec_level = __this_cpu_inc_return(redirect_rec_level);
+	if (unlikely(rec_level > CAST_RECURSION_LIMIT)) {
+		net_warn_ratelimited("blockcast: exceeded redirect recursion limit on dev %s\n",
+				     netdev_name(skb->dev));
+		goto out_shot;
+	}
+
+	dev = dev_get_by_index_rcu(dev_net(skb->dev), ifindex);
+	if (unlikely(!dev))
+		goto out_shot;
+
+	if (unlikely(!(dev->flags & IFF_UP) || !netif_carrier_ok(dev)))
+		goto out_shot;
+
+	skb2 = skb_clone(skb, GFP_ATOMIC);
+	if (!skb2)
+		goto out_shot;
+
+	nf_reset_ct(skb2);
+
+	expects_nh = !dev_is_mac_header_xmit(dev);
+	at_nh = skb->data == skb_network_header(skb);
+	if (at_nh != expects_nh) {
+		mac_len = skb_at_tc_ingress(skb) ?
+				  skb->mac_len :
+				  skb_network_header(skb) - skb_mac_header(skb);
+
+		if (expects_nh) {
+			/* target device/action expect data at nh */
+			skb_pull_rcsum(skb2, mac_len);
+		} else {
+			/* target device/action expect data at mac */
+			skb_push_rcsum(skb2, mac_len);
+		}
+	}
+
+	skb2->skb_iif = skb->dev->ifindex;
+	skb2->dev = dev;
+
+	err = dev_queue_xmit(skb2);
+	if (err)
+		goto out_shot;
+
+	goto rec_level_dec;
+
+out_shot:
+	retval = TC_ACT_SHOT;
+
+rec_level_dec:
+	__this_cpu_dec(redirect_rec_level);
+
+	return retval;
+}
+
+TC_INDIRECT_SCOPE int tcf_blockcast_run(struct sk_buff *skb,
+					const struct tc_action *a,
+					struct tcf_result *res)
+{
+	u32 block_index = qdisc_skb_cb(skb)->block_index;
+	struct tcf_blockcast_act *p = to_blockcast_act(a);
+	int action = READ_ONCE(p->tcf_action);
+	struct net *net = dev_net(skb->dev);
+	struct tcf_block *block;
+	struct net_device *dev;
+	u32 exception_ifindex;
+	unsigned long index;
+
+	block = tcf_block_lookup(net, block_index);
+	exception_ifindex = skb->dev->ifindex;
+
+	tcf_action_update_bstats(&p->common, skb);
+	tcf_lastuse_update(&p->tcf_tm);
+
+	if (!block || xa_empty(&block->ports))
+		goto act_done;
+
+	/* we are already under rcu protection, so iterating block is safe*/
+	xa_for_each(&block->ports, index, dev) {
+		int err;
+
+		if (index == exception_ifindex)
+			continue;
+
+		err = cast_one(skb, dev->ifindex);
+		if (err != TC_ACT_PIPE)
+			tcf_action_inc_overlimit_qstats(&p->common);
+	}
+
+act_done:
+	if (action == TC_ACT_SHOT)
+		tcf_action_inc_drop_qstats(&p->common);
+	return action;
+}
+
+static const struct nla_policy blockcast_policy[TCA_DEF_MAX + 1] = {
+	[TCA_DEF_PARMS]	= { .len = sizeof(struct tc_defact) },
+};
+
+static int tcf_blockcast_init(struct net *net, struct nlattr *nla,
+			      struct nlattr *est, struct tc_action **a,
+			      struct tcf_proto *tp, u32 flags,
+			      struct netlink_ext_ack *extack)
+{
+	struct tc_action_net *tn = net_generic(net, act_blockcast_ops.net_id);
+	struct tcf_blockcast_act *p = to_blockcast_act(a);
+	bool bind = flags & TCA_ACT_FLAGS_BIND;
+	struct nlattr *tb[TCA_DEF_MAX + 1];
+	struct tcf_chain *goto_ch = NULL;
+	struct tc_defact *parm;
+	bool exists = false;
+	int ret = 0, err;
+	u32 index;
+
+	if (!nla)
+		return -EINVAL;
+
+	err = nla_parse_nested(tb, TCA_DEF_MAX, nla,
+			       blockcast_policy, extack);
+	if (err < 0)
+		return err;
+
+	if (!tb[TCA_DEF_PARMS])
+		return -EINVAL;
+
+	parm = nla_data(tb[TCA_DEF_PARMS]);
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
+
+	err = tcf_action_check_ctrlact(parm->action, tp, &goto_ch, extack);
+	if (err < 0)
+		goto release_idr;
+
+	if (exists) {
+		spin_lock_bh(&p->tcf_lock);
+		goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
+		spin_unlock_bh(&p->tcf_lock);
+	} else {
+		goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
+	}
+
+	if (goto_ch)
+		tcf_chain_put_by_act(goto_ch);
+
+	return ret;
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
+	struct tc_defact opt = {
+		.index   = p->tcf_index,
+		.refcnt  = refcount_read(&p->tcf_refcnt) - ref,
+		.bindcnt = atomic_read(&p->tcf_bindcnt) - bind,
+	};
+	struct tcf_t t;
+
+	spin_lock_bh(&p->tcf_lock);
+	opt.action = p->tcf_action;
+	if (nla_put(skb, TCA_DEF_PARMS, sizeof(opt), &opt))
+		goto nla_put_failure;
+
+	tcf_tm_dump(&t, &p->tcf_tm);
+	if (nla_put_64bit(skb, TCA_DEF_TM, sizeof(t), &t, TCA_DEF_PAD))
+		goto nla_put_failure;
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
+	.act		=	tcf_blockcast_run,
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


