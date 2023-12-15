Return-Path: <netdev+bounces-57933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147438148B9
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 14:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A581C22A63
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 13:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9B72D033;
	Fri, 15 Dec 2023 13:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="FJYDXopw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE9C2DB67
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c38de1ee4so6223815e9.0
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 05:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702645608; x=1703250408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R1xNFHHezv1CLJEnvAaLL47nUlvUbiqoNX5LXzMdimw=;
        b=FJYDXopwuO8vhfphZGbuHCFTkHyH6D2D2wGFJRCN/A+TV91jbpYpyiip+QuYypIdUf
         D7G9ntY6/Y4DMV+HpZkU0w/bhQWzilrPcYrGEgO0zc7AOnFecYpGAOS9RO3rQ/7syRGJ
         q9LVwnZirtvHncFbbgrK4SJaIg/W7lF8XEVeO4pxESxoMlmdTbulGQkJh+/uOgl5HJLF
         X7Bde76n+s78Ye0p6CPcDu4cLDn4v7PVi6o1YLfr+LUvukZWEJWOSFQF4wUzAqxwDD2C
         tqZ6vtDexO7nDUj8DtMOMHvxvzSFoOZ88yFFNcpxr3Q+05XAvkKopK7kGqDwv2xxvtQb
         xHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702645608; x=1703250408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1xNFHHezv1CLJEnvAaLL47nUlvUbiqoNX5LXzMdimw=;
        b=sUerNaoX8ecEbA7Bbibj7A4sC9vzWDZ9Bix5CGyWEzEabkIJdATSfeTlfDPdriOKz4
         zh3uGStXMxddKqzpwbiGAa4yiRWP0ofIQvgcaUDfwFtlTR+80c2tht3mK7+0Ro8gn9JQ
         ITQlbVOcntXo7DrjbGCUIaVEG+IkVoWi9zMGGG2CgEyNL2IV8dXTtwYb2U47eSHxbXnE
         5RLeVxKO4vkyrNtWdeflmuXgcRun0Yyl4QCEPsCj2sMS3pucQBjJhD77lJf9gv0BeHOa
         a5A2g6oTpMRfyfPvfD4fiuiZS0rsZ/LUXrOOKDznxM1eW9nxCz8uYcx9u2WUJ31CTtqT
         NSNw==
X-Gm-Message-State: AOJu0YzYInRztriUXCraFUU/c7mCRRI6i7tdgVVSGOKC3gqTFn5sNBOF
	4KZSANadJHbcpQXSYnFE3MARKg==
X-Google-Smtp-Source: AGHT+IFKm6J1Xmbkr5u96R36lxKXtp3bL0a9jORurz6Mn47NDIi/MtSGxZIeHXltkIG9YcHGGT1roQ==
X-Received: by 2002:a05:600c:4fc7:b0:40c:3984:49a7 with SMTP id o7-20020a05600c4fc700b0040c398449a7mr6022909wmq.103.1702645608502;
        Fri, 15 Dec 2023 05:06:48 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c191200b0040c6b667dccsm2164862wmq.25.2023.12.15.05.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 05:06:47 -0800 (PST)
Date: Fri, 15 Dec 2023 14:06:46 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com,
	mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com,
	pctammela@mojatatu.com, netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH net-next v7 3/3] net/sched: act_mirred: Allow mirred to
 block
Message-ID: <ZXxPZoaIQoa7jlJv@nanopsycho>
References: <20231215111050.3624740-1-victor@mojatatu.com>
 <20231215111050.3624740-4-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215111050.3624740-4-victor@mojatatu.com>

Fri, Dec 15, 2023 at 12:10:50PM CET, victor@mojatatu.com wrote:
>So far the mirred action has dealt with syntax that handles mirror/redirection for netdev.
>A matching packet is redirected or mirrored to a target netdev.
>
>In this patch we enable mirred to mirror to a tc block as well.
>IOW, the new syntax looks as follows:
>... mirred <ingress | egress> <mirror | redirect> [index INDEX] < <blockid BLOCKID> | <dev <devname>> >
>
>Examples of mirroring or redirecting to a tc block:
>$ tc filter add block 22 protocol ip pref 25 \
>  flower dst_ip 192.168.0.0/16 action mirred egress mirror blockid 22
>
>$ tc filter add block 22 protocol ip pref 25 \
>  flower dst_ip 10.10.10.10/32 action mirred egress redirect blockid 22
>
>Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
>Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>---
> include/net/tc_act/tc_mirred.h        |   1 +
> include/uapi/linux/tc_act/tc_mirred.h |   1 +
> net/sched/act_mirred.c                | 278 +++++++++++++++++++-------
> 3 files changed, 206 insertions(+), 74 deletions(-)
>
>diff --git a/include/net/tc_act/tc_mirred.h b/include/net/tc_act/tc_mirred.h
>index 32ce8ea36950..75722d967bf2 100644
>--- a/include/net/tc_act/tc_mirred.h
>+++ b/include/net/tc_act/tc_mirred.h
>@@ -8,6 +8,7 @@
> struct tcf_mirred {
> 	struct tc_action	common;
> 	int			tcfm_eaction;
>+	u32                     tcfm_blockid;
> 	bool			tcfm_mac_header_xmit;
> 	struct net_device __rcu	*tcfm_dev;
> 	netdevice_tracker	tcfm_dev_tracker;
>diff --git a/include/uapi/linux/tc_act/tc_mirred.h b/include/uapi/linux/tc_act/tc_mirred.h
>index 2500a0005d05..54df06658bc8 100644
>--- a/include/uapi/linux/tc_act/tc_mirred.h
>+++ b/include/uapi/linux/tc_act/tc_mirred.h
>@@ -20,6 +20,7 @@ enum {
> 	TCA_MIRRED_UNSPEC,
> 	TCA_MIRRED_TM,
> 	TCA_MIRRED_PARMS,
>+	TCA_MIRRED_BLOCKID,

You just broke uapi. Make sure to add new attributes to the end.


> 	TCA_MIRRED_PAD,
> 	__TCA_MIRRED_MAX
> };
>diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
>index 0a711c184c29..8b6d04d26c5a 100644
>--- a/net/sched/act_mirred.c
>+++ b/net/sched/act_mirred.c
>@@ -85,10 +85,20 @@ static void tcf_mirred_release(struct tc_action *a)
> 
> static const struct nla_policy mirred_policy[TCA_MIRRED_MAX + 1] = {
> 	[TCA_MIRRED_PARMS]	= { .len = sizeof(struct tc_mirred) },
>+	[TCA_MIRRED_BLOCKID]	= { .type = NLA_U32 },
> };
> 
> static struct tc_action_ops act_mirred_ops;
> 
>+static void tcf_mirred_replace_dev(struct tcf_mirred *m, struct net_device *ndev)
>+{
>+	struct net_device *odev;
>+
>+	odev = rcu_replace_pointer(m->tcfm_dev, ndev,
>+				   lockdep_is_held(&m->tcf_lock));
>+	netdev_put(odev, &m->tcfm_dev_tracker);
>+}
>+
> static int tcf_mirred_init(struct net *net, struct nlattr *nla,
> 			   struct nlattr *est, struct tc_action **a,
> 			   struct tcf_proto *tp,
>@@ -126,6 +136,13 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
> 	if (exists && bind)
> 		return 0;
> 
>+	if (tb[TCA_MIRRED_BLOCKID] && parm->ifindex) {
>+		NL_SET_ERR_MSG_MOD(extack,
>+				   "Mustn't specify Block ID and dev simultaneously");
>+		err = -EINVAL;
>+		goto release_idr;
>+	}
>+
> 	switch (parm->eaction) {
> 	case TCA_EGRESS_MIRROR:
> 	case TCA_EGRESS_REDIR:
>@@ -142,9 +159,9 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
> 	}
> 
> 	if (!exists) {
>-		if (!parm->ifindex) {
>+		if (!parm->ifindex && !tb[TCA_MIRRED_BLOCKID]) {
> 			tcf_idr_cleanup(tn, index);
>-			NL_SET_ERR_MSG_MOD(extack, "Specified device does not exist");
>+			NL_SET_ERR_MSG_MOD(extack, "Must specify device or block");
> 			return -EINVAL;
> 		}
> 		ret = tcf_idr_create_from_flags(tn, index, est, a,
>@@ -170,7 +187,7 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
> 	spin_lock_bh(&m->tcf_lock);
> 
> 	if (parm->ifindex) {
>-		struct net_device *odev, *ndev;
>+		struct net_device *ndev;
> 
> 		ndev = dev_get_by_index(net, parm->ifindex);
> 		if (!ndev) {
>@@ -179,11 +196,14 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
> 			goto put_chain;
> 		}
> 		mac_header_xmit = dev_is_mac_header_xmit(ndev);
>-		odev = rcu_replace_pointer(m->tcfm_dev, ndev,
>-					  lockdep_is_held(&m->tcf_lock));
>-		netdev_put(odev, &m->tcfm_dev_tracker);
>+		tcf_mirred_replace_dev(m, ndev);

This could be a separate patch, for better readability of the patches.

Skimming thought the rest of the patch, this is hard to follow (-ETOOBIG).
What would help is to cut this patch into multiple ones. Do preparations
first, then you finally add TCA_MIRRED_BLOCKID processin and blockid
forwarding. Could you?


> 		netdev_tracker_alloc(ndev, &m->tcfm_dev_tracker, GFP_ATOMIC);
> 		m->tcfm_mac_header_xmit = mac_header_xmit;
>+		m->tcfm_blockid = 0;
>+	} else if (tb[TCA_MIRRED_BLOCKID]) {
>+		tcf_mirred_replace_dev(m, NULL);
>+		m->tcfm_mac_header_xmit = false;
>+		m->tcfm_blockid = nla_get_u32(tb[TCA_MIRRED_BLOCKID]);
> 	}
> 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> 	m->tcfm_eaction = parm->eaction;

[...]

