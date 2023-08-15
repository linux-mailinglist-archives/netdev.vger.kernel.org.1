Return-Path: <netdev+bounces-27723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 709B977D018
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 18:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940CB1C20D51
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 16:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF675156FD;
	Tue, 15 Aug 2023 16:26:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE21415AD7
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 16:26:25 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379EAD1
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 09:26:24 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40fe3850312so43143371cf.1
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692116783; x=1692721583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MomApDLp/2T/CDgvCCBDaGq8kO9jgyrr0PVLGor6fuQ=;
        b=UcaHHTMk8fIzv4rBdZl2U7ikFx3tCLf2rzV5qN92eI8OEd551K+ZTnaeyzgrAq84g8
         bRvhX5Wg7++38HQIY0nZ0fS7rAk2h31NctFqnGPbko5FM4Ouo01sdIG2PLfPjqChY/ly
         YTuJC/5cCYhiVhkyFEBkoVKdlkwvqXmXPb2wGHMwwIoRT62r0lI7XFbA+mixJA+fpWnS
         dnYv+/gE683qfP3uoBzzHMCklDdJfY2WRkkS4pyrfLuRVMFCv0XO9teWS3sFc8qJUqwE
         g8chuHA2RJan9PPIZvAQGxhFsT8MCp97sgZ9l46kY28oP3cvuPo9vHTPs5TO+1qHjwv/
         Z1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692116783; x=1692721583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MomApDLp/2T/CDgvCCBDaGq8kO9jgyrr0PVLGor6fuQ=;
        b=H8TRN9ehxuZtboyLtVwJMru2UQ8AUXbjZCBO//FSHkKb9AHbNv4vggB127q1zjbqYe
         /6x9CA15iM6hkrxYGd6XYekEGMZa/+jcJqxFmVAmqQBfGqFLg5k8vbSIJwKla8Nv2cge
         ZddTFiRH0umvUQMYr9sUSZmEcUN0sSEpnyCzOKu8rnXzOwfIqXZ6kIZRwIFKn2AdXqZB
         aQRi3T8FobMZk8W7WSUF1GhkVr00btaCnGsui9OuDcAkC6pye8ULLkzE+Y5mxPbC621s
         KDJvLMAxA2qdFGy2U5DrUDAd96E7j2mZVDkt8jfinrcf23Xz78H/fI1CnOYZ6hmvwx96
         //Mw==
X-Gm-Message-State: AOJu0YxFF5XubvgcGlCZVxibh9daH6R3FxdTSyHIkM3eGnHhCfKqsIy5
	vJOdKJYwEQDFLyqhzFBeBGEtAA==
X-Google-Smtp-Source: AGHT+IHdN8STiHKzkVEWaN5BHyViWYiHqt37bg3Ynnk2XDBE/eiGAzTd6UfDfarPTsNQHn11Gb1Mhg==
X-Received: by 2002:a05:622a:110b:b0:40f:db89:8616 with SMTP id e11-20020a05622a110b00b0040fdb898616mr18621023qty.67.1692116783084;
        Tue, 15 Aug 2023 09:26:23 -0700 (PDT)
Received: from majuu.waya ([174.93.66.252])
        by smtp.gmail.com with ESMTPSA id q5-20020ac87345000000b003fde3d63d22sm3874640qtp.69.2023.08.15.09.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 09:26:22 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: jiri@resnulli.us
Cc: xiyou.wangcong@gmail.com,
	netdev@vger.kernel.org,
	vladbu@nvidia.com,
	mleitner@redhat.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH RFC net-next 3/3] Introduce blockcast tc action
Date: Tue, 15 Aug 2023 12:25:30 -0400
Message-Id: <20230815162530.150994-4-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815162530.150994-1-jhs@mojatatu.com>
References: <20230815162530.150994-1-jhs@mojatatu.com>
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

This action takes advantage of the presence of tc block ports set in the
datapath and broadcast a packet to all ports on that set with exception of
the port in which it arrived on..

Example usage:
    $ tc qdisc add dev ens7 ingress block 22
    $ tc qdisc add dev ens8 ingress block 22

Now we can add a filter using the block index:
$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action blockcast

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/tc_wrapper.h  |   5 +
 net/sched/Kconfig         |  13 ++
 net/sched/Makefile        |   1 +
 net/sched/act_blockcast.c | 302 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 321 insertions(+)
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
index 000000000000..1c9e49d68540
--- /dev/null
+++ b/net/sched/act_blockcast.c
@@ -0,0 +1,302 @@
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
+#define TCA_ID_BLOCKCAST 123
+#define CAST_RECURSION_LIMIT  4
+
+static DEFINE_PER_CPU(unsigned int, redirect_rec_level);
+
+//XXX: Refactor mirred code and reuse here before final version
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
+		__this_cpu_dec(redirect_rec_level);
+		return TC_ACT_SHOT;
+	}
+
+	dev = dev_get_by_index_rcu(dev_net(skb->dev), ifindex);
+	if (unlikely(!dev)) {
+		pr_notice_once("blockcast: target device %s is gone\n",
+			       dev->name);
+		__this_cpu_dec(redirect_rec_level);
+		return TC_ACT_SHOT;
+	}
+
+	if (unlikely(!(dev->flags & IFF_UP))) {
+		net_notice_ratelimited("blockcast: device %s is down\n",
+				       dev->name);
+		__this_cpu_dec(redirect_rec_level);
+		return TC_ACT_SHOT;
+	}
+
+	skb2 = skb_clone(skb, GFP_ATOMIC);
+	if (!skb2) {
+		__this_cpu_dec(redirect_rec_level);
+		return retval;
+	}
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
+		retval = TC_ACT_SHOT;
+
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
+			printk("(%d)Failed to send to dev\t%d: %s\n", err,
+			       dev->ifindex, dev->name);
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
+	err = nla_parse_nested_deprecated(tb, TCA_DEF_MAX, nla,
+					  blockcast_policy, NULL);
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
+	if (exists)
+		spin_lock_bh(&p->tcf_lock);
+	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
+	if (exists)
+		spin_unlock_bh(&p->tcf_lock);
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
2.34.1


