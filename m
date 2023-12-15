Return-Path: <netdev+bounces-57975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D160814A4A
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 15:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F282D281773
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 14:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F7A30333;
	Fri, 15 Dec 2023 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="knM48HUv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099D22F87A
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3363aa2bbfbso616948f8f.0
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 06:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702649938; x=1703254738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zY+bD+rYAdYqzqqFu48DVPOTQb0YNRBEHqsquaw/weY=;
        b=knM48HUvDEh6paR3yZ06AwIgG6jewQlki3EZWgVIZwcdsOXRYrH+yzKcOZfGXF+Xi4
         oQs3H5VCtNvQv1EfPtTPYE0cNNwa+x6xCQcsG5mplYbEor5gT1wBzvRs6WnS7TinO6Tr
         dzAPoxuMYY6GP9prIuq2uM6KkAvxE0I80r+fdWmdPyF6D8MzNMBGLUNWE5HIeUathm7Z
         FrQusmi4cxOoPPxpRSbppJo/fYPeC4gVCDf3fcVePELEmXn8dJQRBWwsw43IENCunBZh
         mnHSljM5cMRMD6VkpSosNlbaCbbIPm8HK8gPaCEOJiNlCK1W/1CGpIaA7KGCbuhytAJK
         IcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702649938; x=1703254738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zY+bD+rYAdYqzqqFu48DVPOTQb0YNRBEHqsquaw/weY=;
        b=hG7SKrYR74wjpRBnnC1f7lcyv4tRq/TZTzrXk1o8LfXNigOuk3/XQ8BC3c8jz+YcL6
         +jlrk6RqV6QvAfAo/SiD8JQM4Q9K5DC7Ej9Fo7PggVI+TI56qo3cbtPCl38pDAEidu/g
         7XqiwoV1dttntO9pe+HitnCyg38Wi1zhkQPYrEDbeGEK/9spSkusVndCsrvKlo+temYk
         1aiboYN8yYQSGxARWXwaVPoz0lXlOoDZCR1yp7DlEugCKF8WbNsmnKfAi5GH5MB8NkS7
         ItEwtrinAcLgH7AQNn7gfU1E2GjwJM49Odn6nKRDUiWuIp3G1ARksCynPLO5jMvYovSZ
         yvzQ==
X-Gm-Message-State: AOJu0YwGp+PwA2UxZptb0cROX08m1wQvKTa6VwkbV7fCmCs1ZgQk0IRH
	fIJt2xe9S3vBrAeeW6oEu9IaxZNG3dn0ZLM2vC8=
X-Google-Smtp-Source: AGHT+IG6gur+N1OWGGuMJ0kLXoyeUxHnQxkKUR04Z/Mc1XRGrIOjgH5UeksMnBqMOFDS58cDajdTig==
X-Received: by 2002:a05:6000:1b8c:b0:336:1adc:fe09 with SMTP id r12-20020a0560001b8c00b003361adcfe09mr4959847wru.16.1702649937873;
        Fri, 15 Dec 2023 06:18:57 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k20-20020a5d5254000000b003365b5df349sm190863wrc.93.2023.12.15.06.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 06:18:57 -0800 (PST)
Date: Fri, 15 Dec 2023 15:18:56 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com,
	mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com,
	pctammela@mojatatu.com, netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH net-next v7 3/3] net/sched: act_mirred: Allow mirred to
 block
Message-ID: <ZXxgUHVzFp4BVZl3@nanopsycho>
References: <20231215111050.3624740-1-victor@mojatatu.com>
 <20231215111050.3624740-4-victor@mojatatu.com>
 <ZXxPZoaIQoa7jlJv@nanopsycho>
 <1d08f20e-a363-4405-ad97-1107cd34628a@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d08f20e-a363-4405-ad97-1107cd34628a@mojatatu.com>

Fri, Dec 15, 2023 at 02:56:48PM CET, victor@mojatatu.com wrote:
>On 15/12/2023 10:06, Jiri Pirko wrote:
>> Fri, Dec 15, 2023 at 12:10:50PM CET, victor@mojatatu.com wrote:
>> > So far the mirred action has dealt with syntax that handles mirror/redirection for netdev.
>> > A matching packet is redirected or mirrored to a target netdev.
>> > 
>> > In this patch we enable mirred to mirror to a tc block as well.
>> > IOW, the new syntax looks as follows:
>> > ... mirred <ingress | egress> <mirror | redirect> [index INDEX] < <blockid BLOCKID> | <dev <devname>> >
>> > 
>> > Examples of mirroring or redirecting to a tc block:
>> > $ tc filter add block 22 protocol ip pref 25 \
>> >   flower dst_ip 192.168.0.0/16 action mirred egress mirror blockid 22
>> > 
>> > $ tc filter add block 22 protocol ip pref 25 \
>> >   flower dst_ip 10.10.10.10/32 action mirred egress redirect blockid 22
>> > 
>> > Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>> > Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
>> > Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>> > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>> > ---
>> > include/net/tc_act/tc_mirred.h        |   1 +
>> > include/uapi/linux/tc_act/tc_mirred.h |   1 +
>> > net/sched/act_mirred.c                | 278 +++++++++++++++++++-------
>> > 3 files changed, 206 insertions(+), 74 deletions(-)
>> > 
>> > diff --git a/include/net/tc_act/tc_mirred.h b/include/net/tc_act/tc_mirred.h
>> > index 32ce8ea36950..75722d967bf2 100644
>> > --- a/include/net/tc_act/tc_mirred.h
>> > +++ b/include/net/tc_act/tc_mirred.h
>> > @@ -8,6 +8,7 @@
>> > struct tcf_mirred {
>> > 	struct tc_action	common;
>> > 	int			tcfm_eaction;
>> > +	u32                     tcfm_blockid;
>> > 	bool			tcfm_mac_header_xmit;
>> > 	struct net_device __rcu	*tcfm_dev;
>> > 	netdevice_tracker	tcfm_dev_tracker;
>> > diff --git a/include/uapi/linux/tc_act/tc_mirred.h b/include/uapi/linux/tc_act/tc_mirred.h
>> > index 2500a0005d05..54df06658bc8 100644
>> > --- a/include/uapi/linux/tc_act/tc_mirred.h
>> > +++ b/include/uapi/linux/tc_act/tc_mirred.h
>> > @@ -20,6 +20,7 @@ enum {
>> > 	TCA_MIRRED_UNSPEC,
>> > 	TCA_MIRRED_TM,
>> > 	TCA_MIRRED_PARMS,
>> > +	TCA_MIRRED_BLOCKID,
>> 
>> You just broke uapi. Make sure to add new attributes to the end.
>
>My bad, don't know how we missed this one.
>Will fix in v8.
>
>> 
>> > 	TCA_MIRRED_PAD,
>> > 	__TCA_MIRRED_MAX
>> > };
>> > diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
>> > index 0a711c184c29..8b6d04d26c5a 100644
>> > --- a/net/sched/act_mirred.c
>> > +++ b/net/sched/act_mirred.c
>> > @@ -85,10 +85,20 @@ static void tcf_mirred_release(struct tc_action *a)
>> > 
>> > static const struct nla_policy mirred_policy[TCA_MIRRED_MAX + 1] = {
>> > 	[TCA_MIRRED_PARMS]	= { .len = sizeof(struct tc_mirred) },
>> > +	[TCA_MIRRED_BLOCKID]	= { .type = NLA_U32 },
>> > };
>> > 
>> > static struct tc_action_ops act_mirred_ops;
>> > 
>> > +static void tcf_mirred_replace_dev(struct tcf_mirred *m, struct net_device *ndev)
>> > +{
>> > +	struct net_device *odev;
>> > +
>> > +	odev = rcu_replace_pointer(m->tcfm_dev, ndev,
>> > +				   lockdep_is_held(&m->tcf_lock));
>> > +	netdev_put(odev, &m->tcfm_dev_tracker);
>> > +}
>> > +
>> > static int tcf_mirred_init(struct net *net, struct nlattr *nla,
>> > 			   struct nlattr *est, struct tc_action **a,
>> > 			   struct tcf_proto *tp,
>> > @@ -126,6 +136,13 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
>> > 	if (exists && bind)
>> > 		return 0;
>> > 
>> > +	if (tb[TCA_MIRRED_BLOCKID] && parm->ifindex) {
>> > +		NL_SET_ERR_MSG_MOD(extack,
>> > +				   "Mustn't specify Block ID and dev simultaneously");
>> > +		err = -EINVAL;
>> > +		goto release_idr;
>> > +	}
>> > +
>> > 	switch (parm->eaction) {
>> > 	case TCA_EGRESS_MIRROR:
>> > 	case TCA_EGRESS_REDIR:
>> > @@ -142,9 +159,9 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
>> > 	}
>> > 
>> > 	if (!exists) {
>> > -		if (!parm->ifindex) {
>> > +		if (!parm->ifindex && !tb[TCA_MIRRED_BLOCKID]) {
>> > 			tcf_idr_cleanup(tn, index);
>> > -			NL_SET_ERR_MSG_MOD(extack, "Specified device does not exist");
>> > +			NL_SET_ERR_MSG_MOD(extack, "Must specify device or block");
>> > 			return -EINVAL;
>> > 		}
>> > 		ret = tcf_idr_create_from_flags(tn, index, est, a,
>> > @@ -170,7 +187,7 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
>> > 	spin_lock_bh(&m->tcf_lock);
>> > 
>> > 	if (parm->ifindex) {
>> > -		struct net_device *odev, *ndev;
>> > +		struct net_device *ndev;
>> > 
>> > 		ndev = dev_get_by_index(net, parm->ifindex);
>> > 		if (!ndev) {
>> > @@ -179,11 +196,14 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
>> > 			goto put_chain;
>> > 		}
>> > 		mac_header_xmit = dev_is_mac_header_xmit(ndev);
>> > -		odev = rcu_replace_pointer(m->tcfm_dev, ndev,
>> > -					  lockdep_is_held(&m->tcf_lock));
>> > -		netdev_put(odev, &m->tcfm_dev_tracker);
>> > +		tcf_mirred_replace_dev(m, ndev);
>> 
>> This could be a separate patch, for better readability of the patches.
>> 
>> Skimming thought the rest of the patch, this is hard to follow (-ETOOBIG).
>> What would help is to cut this patch into multiple ones. Do preparations
>> first, then you finally add TCA_MIRRED_BLOCKID processin and blockid
>> forwarding. Could you?
>
>Will transform this one into two separate patches.

More please.

>
>> 
>> > 		netdev_tracker_alloc(ndev, &m->tcfm_dev_tracker, GFP_ATOMIC);
>> > 		m->tcfm_mac_header_xmit = mac_header_xmit;
>> > +		m->tcfm_blockid = 0;
>> > +	} else if (tb[TCA_MIRRED_BLOCKID]) {
>> > +		tcf_mirred_replace_dev(m, NULL);
>> > +		m->tcfm_mac_header_xmit = false;
>> > +		m->tcfm_blockid = nla_get_u32(tb[TCA_MIRRED_BLOCKID]);
>> > 	}
>> > 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
>> > 	m->tcfm_eaction = parm->eaction;
>> 
>> [...]

