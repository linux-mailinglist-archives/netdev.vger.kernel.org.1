Return-Path: <netdev+bounces-57970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4011E8149CD
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 14:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA75286056
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 13:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37A22E408;
	Fri, 15 Dec 2023 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="DWwmMXWi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB7F2EAF9
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d30141d108so2150885ad.2
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 05:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702648613; x=1703253413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=srBtYvSGxz/QV65rkCwm3K9NS7grj6UXdLtlAWZC+h4=;
        b=DWwmMXWib1oqnnXGtiYIVSWxVtCE0lv07dSKEvrfqInInUb9jpVRWsUz86cF+dKcJ8
         EfiJBvfGrWyqzfq1VRj+suhlQShLcPhEwlUHv+n4Np6L11VIzcHR73ja32xwMDu92T0V
         5wY+DZx5WgkU4GPssojpXvCr07fSDXG0C/Zu6BIQRTGDlKJhSz8BqAp/glBif1TuyPQ9
         com3BZkeR0QJnyofxUiVOZwa3JxZJg24NNnF0YJoVS/lfsFDTS1NJEfGYY0wI3gvoE+S
         kdtv2KVEMYdtQztbGKkcyoadDZ56cW3gd2kXmtgsI/1gMue2wzzy6xk7Sa2IPsIBxQmf
         dKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702648613; x=1703253413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=srBtYvSGxz/QV65rkCwm3K9NS7grj6UXdLtlAWZC+h4=;
        b=MOgQtcHBtwMVzxQRIsFoHvjm/zM/ujJmLQbBkWOzTZg7RyjgSBt6LSLxOZHIMc0G+7
         qeLurfeRV243wV+lgSnsDz9xi8OdcUAwL/miNP4ILrfMs8ClGfStsOdEYHjXpY/EzfMF
         7gXDLeoaASE4WvoMQ6erqkPl5EkJD93zSUcPLR5zra2+OL4ZfAbzFVOqEAmVNNDmnBNz
         ecfyRuIWQIXz54LK7oQECM6/fLMrko0u6tN/JPlQfbX4GSMrfj3a3jUbGWDPnsKz8Lby
         HTXuvotI8tV6t+1ADGVUxm8mWOraBa9yroNoBiZNmB8bFvP6cJuaM7QR2yWwjyk8gUcN
         WMaQ==
X-Gm-Message-State: AOJu0YzADQV4RFGgRkUgm36Oj0AGWmkCkWZTPUoo/fcyXeGENx/GFvD3
	zYYF5aGZSmijNKNkbP/ClH8iRQ==
X-Google-Smtp-Source: AGHT+IF9melNJGhZfFR95fnhTjL9fJPcVl8WjnJAcYruiuZSDUEglHstPdaJkFwxNc0RMC/02acdtw==
X-Received: by 2002:a17:902:a5cc:b0:1d3:7f19:9358 with SMTP id t12-20020a170902a5cc00b001d37f199358mr650678plq.0.1702648613036;
        Fri, 15 Dec 2023 05:56:53 -0800 (PST)
Received: from ?IPV6:2804:7f1:e2c0:60e3:4c1:486f:7eda:5fb5? ([2804:7f1:e2c0:60e3:4c1:486f:7eda:5fb5])
        by smtp.gmail.com with ESMTPSA id z14-20020a170903018e00b001cfc15993efsm14307184plg.163.2023.12.15.05.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 05:56:52 -0800 (PST)
Message-ID: <1d08f20e-a363-4405-ad97-1107cd34628a@mojatatu.com>
Date: Fri, 15 Dec 2023 10:56:48 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/3] net/sched: act_mirred: Allow mirred to
 block
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>
Cc: jhs@mojatatu.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com,
 mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com,
 pctammela@mojatatu.com, netdev@vger.kernel.org, kernel@mojatatu.com
References: <20231215111050.3624740-1-victor@mojatatu.com>
 <20231215111050.3624740-4-victor@mojatatu.com> <ZXxPZoaIQoa7jlJv@nanopsycho>
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <ZXxPZoaIQoa7jlJv@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/12/2023 10:06, Jiri Pirko wrote:
> Fri, Dec 15, 2023 at 12:10:50PM CET, victor@mojatatu.com wrote:
>> So far the mirred action has dealt with syntax that handles mirror/redirection for netdev.
>> A matching packet is redirected or mirrored to a target netdev.
>>
>> In this patch we enable mirred to mirror to a tc block as well.
>> IOW, the new syntax looks as follows:
>> ... mirred <ingress | egress> <mirror | redirect> [index INDEX] < <blockid BLOCKID> | <dev <devname>> >
>>
>> Examples of mirroring or redirecting to a tc block:
>> $ tc filter add block 22 protocol ip pref 25 \
>>   flower dst_ip 192.168.0.0/16 action mirred egress mirror blockid 22
>>
>> $ tc filter add block 22 protocol ip pref 25 \
>>   flower dst_ip 10.10.10.10/32 action mirred egress redirect blockid 22
>>
>> Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
>> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>> ---
>> include/net/tc_act/tc_mirred.h        |   1 +
>> include/uapi/linux/tc_act/tc_mirred.h |   1 +
>> net/sched/act_mirred.c                | 278 +++++++++++++++++++-------
>> 3 files changed, 206 insertions(+), 74 deletions(-)
>>
>> diff --git a/include/net/tc_act/tc_mirred.h b/include/net/tc_act/tc_mirred.h
>> index 32ce8ea36950..75722d967bf2 100644
>> --- a/include/net/tc_act/tc_mirred.h
>> +++ b/include/net/tc_act/tc_mirred.h
>> @@ -8,6 +8,7 @@
>> struct tcf_mirred {
>> 	struct tc_action	common;
>> 	int			tcfm_eaction;
>> +	u32                     tcfm_blockid;
>> 	bool			tcfm_mac_header_xmit;
>> 	struct net_device __rcu	*tcfm_dev;
>> 	netdevice_tracker	tcfm_dev_tracker;
>> diff --git a/include/uapi/linux/tc_act/tc_mirred.h b/include/uapi/linux/tc_act/tc_mirred.h
>> index 2500a0005d05..54df06658bc8 100644
>> --- a/include/uapi/linux/tc_act/tc_mirred.h
>> +++ b/include/uapi/linux/tc_act/tc_mirred.h
>> @@ -20,6 +20,7 @@ enum {
>> 	TCA_MIRRED_UNSPEC,
>> 	TCA_MIRRED_TM,
>> 	TCA_MIRRED_PARMS,
>> +	TCA_MIRRED_BLOCKID,
> 
> You just broke uapi. Make sure to add new attributes to the end.

My bad, don't know how we missed this one.
Will fix in v8.

> 
>> 	TCA_MIRRED_PAD,
>> 	__TCA_MIRRED_MAX
>> };
>> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
>> index 0a711c184c29..8b6d04d26c5a 100644
>> --- a/net/sched/act_mirred.c
>> +++ b/net/sched/act_mirred.c
>> @@ -85,10 +85,20 @@ static void tcf_mirred_release(struct tc_action *a)
>>
>> static const struct nla_policy mirred_policy[TCA_MIRRED_MAX + 1] = {
>> 	[TCA_MIRRED_PARMS]	= { .len = sizeof(struct tc_mirred) },
>> +	[TCA_MIRRED_BLOCKID]	= { .type = NLA_U32 },
>> };
>>
>> static struct tc_action_ops act_mirred_ops;
>>
>> +static void tcf_mirred_replace_dev(struct tcf_mirred *m, struct net_device *ndev)
>> +{
>> +	struct net_device *odev;
>> +
>> +	odev = rcu_replace_pointer(m->tcfm_dev, ndev,
>> +				   lockdep_is_held(&m->tcf_lock));
>> +	netdev_put(odev, &m->tcfm_dev_tracker);
>> +}
>> +
>> static int tcf_mirred_init(struct net *net, struct nlattr *nla,
>> 			   struct nlattr *est, struct tc_action **a,
>> 			   struct tcf_proto *tp,
>> @@ -126,6 +136,13 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
>> 	if (exists && bind)
>> 		return 0;
>>
>> +	if (tb[TCA_MIRRED_BLOCKID] && parm->ifindex) {
>> +		NL_SET_ERR_MSG_MOD(extack,
>> +				   "Mustn't specify Block ID and dev simultaneously");
>> +		err = -EINVAL;
>> +		goto release_idr;
>> +	}
>> +
>> 	switch (parm->eaction) {
>> 	case TCA_EGRESS_MIRROR:
>> 	case TCA_EGRESS_REDIR:
>> @@ -142,9 +159,9 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
>> 	}
>>
>> 	if (!exists) {
>> -		if (!parm->ifindex) {
>> +		if (!parm->ifindex && !tb[TCA_MIRRED_BLOCKID]) {
>> 			tcf_idr_cleanup(tn, index);
>> -			NL_SET_ERR_MSG_MOD(extack, "Specified device does not exist");
>> +			NL_SET_ERR_MSG_MOD(extack, "Must specify device or block");
>> 			return -EINVAL;
>> 		}
>> 		ret = tcf_idr_create_from_flags(tn, index, est, a,
>> @@ -170,7 +187,7 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
>> 	spin_lock_bh(&m->tcf_lock);
>>
>> 	if (parm->ifindex) {
>> -		struct net_device *odev, *ndev;
>> +		struct net_device *ndev;
>>
>> 		ndev = dev_get_by_index(net, parm->ifindex);
>> 		if (!ndev) {
>> @@ -179,11 +196,14 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
>> 			goto put_chain;
>> 		}
>> 		mac_header_xmit = dev_is_mac_header_xmit(ndev);
>> -		odev = rcu_replace_pointer(m->tcfm_dev, ndev,
>> -					  lockdep_is_held(&m->tcf_lock));
>> -		netdev_put(odev, &m->tcfm_dev_tracker);
>> +		tcf_mirred_replace_dev(m, ndev);
> 
> This could be a separate patch, for better readability of the patches.
> 
> Skimming thought the rest of the patch, this is hard to follow (-ETOOBIG).
> What would help is to cut this patch into multiple ones. Do preparations
> first, then you finally add TCA_MIRRED_BLOCKID processin and blockid
> forwarding. Could you?

Will transform this one into two separate patches.

> 
>> 		netdev_tracker_alloc(ndev, &m->tcfm_dev_tracker, GFP_ATOMIC);
>> 		m->tcfm_mac_header_xmit = mac_header_xmit;
>> +		m->tcfm_blockid = 0;
>> +	} else if (tb[TCA_MIRRED_BLOCKID]) {
>> +		tcf_mirred_replace_dev(m, NULL);
>> +		m->tcfm_mac_header_xmit = false;
>> +		m->tcfm_blockid = nla_get_u32(tb[TCA_MIRRED_BLOCKID]);
>> 	}
>> 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
>> 	m->tcfm_eaction = parm->eaction;
> 
> [...]

