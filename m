Return-Path: <netdev+bounces-59018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F51D818FA1
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 19:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DACFD288AEB
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 18:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB92E38FB6;
	Tue, 19 Dec 2023 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Pd/ksgh9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906C13B198
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d3d0faf262so15180985ad.3
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 10:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703009810; x=1703614610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Wj1EI+jejrr1+80FmGs2fBTfDHOu3WlruoLPf7+2Tc=;
        b=Pd/ksgh9ZtJMUuMQbAPGCjczMKEHyKD81shuV9I/wlTUDsG3RGrcBb+iPe+94GXgV+
         PUvt/R5R4m+URBTwUI6CmGXl22A4fb2Q0uobjacMCrY9SiqDViKPLZrgq/bwSlbk31Zi
         dTuLED/54oGwNBFa8Gg4OGrkyiWmixXyWT5bK+6XELB/iOLuCvyJc3c3RInC6+dCAaaA
         sgnixDpm0TYdZ064YKg+xwKcAP9BqI8P9RmTz8ou/Q51w6qu4LljhwxfpuYdnNfQ+bsR
         h4IWZosmu8d6uhzHMdzrwEKR1UFNIGzv9pMF+l2/QVRQKyPgF9A5SHGeQESQsTJdewt4
         ZHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703009810; x=1703614610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Wj1EI+jejrr1+80FmGs2fBTfDHOu3WlruoLPf7+2Tc=;
        b=AyII31TrhLeIyIkHVwzL7mlNRROCpOIzdlXvgTVYylX7XC8t79yURH8RP9jgE0DXzJ
         xxeRpQ/OfahgafSDytvPx4a8nnXOKCk0OrPSMdsI5X8lQSOqbFITVu5bHYB4nSJ2+P9s
         Pfayst60UoUDw6XZV3H09LrRuh0k1m0qnNlnT9xBM/jhBcYiy7lk7l7Q5/k9boEWWDM/
         gGzJPQO1RPuNq9uSH2wfxCYfS7h0hW38K+dsotthATLgH/VSta6dt0UFwVvGwXy2sKmE
         gy0no5emd89BGeOp1wJOAqYEzYVI3DILfba8h5HKv8eDc5af12+dQVtXcY9qYaE6FIE0
         AkdQ==
X-Gm-Message-State: AOJu0YwGXLt4tmN6RTDsteF0mw0OYkiSjNKi6gdNQFVXD775cuqmkaZh
	Om2vSK+l/rvMUfZ6flmSf2rZEA==
X-Google-Smtp-Source: AGHT+IEmQznYsHPA6tB4eW4jLpKiNxYWA1C6I8aJ8JgK+NKTFZ6fCFjZ6mgfFQ0sYTVIkrWhcbcd5g==
X-Received: by 2002:a17:902:6bc4:b0:1d0:acd7:97fa with SMTP id m4-20020a1709026bc400b001d0acd797famr18562411plt.127.1703009809983;
        Tue, 19 Dec 2023 10:16:49 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:60e3:4c1:486f:7eda:5fb5])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f54b00b001d348571ccesm4372188plf.240.2023.12.19.10.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:16:49 -0800 (PST)
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
Subject: [PATCH net-next v8 5/5] net/sched: act_mirred: Allow mirred to block
Date: Tue, 19 Dec 2023 15:16:23 -0300
Message-ID: <20231219181623.3845083-6-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219181623.3845083-1-victor@mojatatu.com>
References: <20231219181623.3845083-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So far the mirred action has dealt with syntax that handles
mirror/redirection for netdev. A matching packet is redirected or mirrored
to a target netdev.

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
 net/sched/act_mirred.c                | 119 +++++++++++++++++++++++++-
 3 files changed, 119 insertions(+), 2 deletions(-)

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
index 2500a0005d05..c61e76f3c23b 100644
--- a/include/uapi/linux/tc_act/tc_mirred.h
+++ b/include/uapi/linux/tc_act/tc_mirred.h
@@ -21,6 +21,7 @@ enum {
 	TCA_MIRRED_TM,
 	TCA_MIRRED_PARMS,
 	TCA_MIRRED_PAD,
+	TCA_MIRRED_BLOCKID,
 	__TCA_MIRRED_MAX
 };
 #define TCA_MIRRED_MAX (__TCA_MIRRED_MAX - 1)
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index a1be8f3c4a8e..d1f9794ca9b7 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -85,6 +85,7 @@ static void tcf_mirred_release(struct tc_action *a)
 
 static const struct nla_policy mirred_policy[TCA_MIRRED_MAX + 1] = {
 	[TCA_MIRRED_PARMS]	= { .len = sizeof(struct tc_mirred) },
+	[TCA_MIRRED_BLOCKID]	= NLA_POLICY_MIN(NLA_U32, 1),
 };
 
 static struct tc_action_ops act_mirred_ops;
@@ -136,6 +137,17 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
 	if (exists && bind)
 		return 0;
 
+	if (tb[TCA_MIRRED_BLOCKID] && parm->ifindex) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot specify Block ID and dev simultaneously");
+		if (exists)
+			tcf_idr_release(*a, bind);
+		else
+			tcf_idr_cleanup(tn, index);
+
+		return -EINVAL;
+	}
+
 	switch (parm->eaction) {
 	case TCA_EGRESS_MIRROR:
 	case TCA_EGRESS_REDIR:
@@ -152,9 +164,10 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
 	}
 
 	if (!exists) {
-		if (!parm->ifindex) {
+		if (!parm->ifindex && !tb[TCA_MIRRED_BLOCKID]) {
 			tcf_idr_cleanup(tn, index);
-			NL_SET_ERR_MSG_MOD(extack, "Specified device does not exist");
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Must specify device or block");
 			return -EINVAL;
 		}
 		ret = tcf_idr_create_from_flags(tn, index, est, a,
@@ -192,6 +205,11 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
 		tcf_mirred_replace_dev(m, ndev);
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
@@ -316,6 +334,89 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 	return retval;
 }
 
+static int tcf_blockcast_redir(struct sk_buff *skb, struct tcf_mirred *m,
+			       struct tcf_block *block, int m_eaction,
+			       const u32 exception_ifindex, int retval)
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
+		if (!dev_prev)
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
+static int tcf_blockcast_mirror(struct sk_buff *skb, struct tcf_mirred *m,
+				struct tcf_block *block, int m_eaction,
+				const u32 exception_ifindex, int retval)
+{
+	struct net_device *dev = NULL;
+	unsigned long index;
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
+static int tcf_blockcast(struct sk_buff *skb, struct tcf_mirred *m,
+			 const u32 blockid, struct tcf_result *res,
+			 int retval)
+{
+	const u32 exception_ifindex = skb->dev->ifindex;
+	struct tcf_block *block;
+	bool is_redirect;
+	int m_eaction;
+
+	m_eaction = READ_ONCE(m->tcfm_eaction);
+	is_redirect = tcf_mirred_is_act_redirect(m_eaction);
+
+	/* we are already under rcu protection, so can call block lookup
+	 * directly.
+	 */
+	block = tcf_block_lookup(dev_net(skb->dev), blockid);
+	if (!block || xa_empty(&block->ports)) {
+		tcf_action_inc_overlimit_qstats(&m->common);
+		return retval;
+	}
+
+	if (is_redirect)
+		return tcf_blockcast_redir(skb, m, block, m_eaction,
+					   exception_ifindex, retval);
+
+	/* If it's not redirect, it is mirror */
+	return tcf_blockcast_mirror(skb, m, block, m_eaction, exception_ifindex,
+				    retval);
+}
+
 TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 				     const struct tc_action *a,
 				     struct tcf_result *res)
@@ -326,6 +427,7 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 	bool m_mac_header_xmit;
 	struct net_device *dev;
 	int m_eaction;
+	u32 blockid;
 
 	nest_level = __this_cpu_inc_return(mirred_nest_level);
 	if (unlikely(nest_level > MIRRED_NEST_LIMIT)) {
@@ -338,6 +440,12 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 	tcf_lastuse_update(&m->tcf_tm);
 	tcf_action_update_bstats(&m->common, skb);
 
+	blockid = READ_ONCE(m->tcfm_blockid);
+	if (blockid) {
+		retval = tcf_blockcast(skb, m, blockid, res, retval);
+		goto dec_nest_level;
+	}
+
 	dev = rcu_dereference_bh(m->tcfm_dev);
 	if (unlikely(!dev)) {
 		pr_notice_once("tc mirred: target device is gone\n");
@@ -379,6 +487,7 @@ static int tcf_mirred_dump(struct sk_buff *skb, struct tc_action *a, int bind,
 	};
 	struct net_device *dev;
 	struct tcf_t t;
+	u32 blockid;
 
 	spin_lock_bh(&m->tcf_lock);
 	opt.action = m->tcf_action;
@@ -390,6 +499,10 @@ static int tcf_mirred_dump(struct sk_buff *skb, struct tc_action *a, int bind,
 	if (nla_put(skb, TCA_MIRRED_PARMS, sizeof(opt), &opt))
 		goto nla_put_failure;
 
+	blockid = m->tcfm_blockid;
+	if (blockid && nla_put_u32(skb, TCA_MIRRED_BLOCKID, blockid))
+		goto nla_put_failure;
+
 	tcf_tm_dump(&t, &m->tcf_tm);
 	if (nla_put_64bit(skb, TCA_MIRRED_TM, sizeof(t), &t, TCA_MIRRED_PAD))
 		goto nla_put_failure;
@@ -420,6 +533,8 @@ static int mirred_device_event(struct notifier_block *unused,
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


