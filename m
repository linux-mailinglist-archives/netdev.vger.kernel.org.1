Return-Path: <netdev+bounces-275592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIMLOMG002nLkgcAu9opvQ
	(envelope-from <netdev+bounces-275592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 15:27:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0923A387F
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 15:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEF4E3003E98
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 13:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6C1336896;
	Mon,  6 Apr 2026 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUZu9q2X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77208221F1F
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775482045; cv=none; b=MyhZSzrRM36DMmhWPVN9jMzlBddFiA7CRNLLk7TBdJbiSkrOAuKvUwpwkRCw2fSJEy9CKkyxwvdHrIk24zehAxugd3VXEtcvNty0/n3IWBI+s21KLiOIYFCEt+UUfNjK5Foo+WDGYOZ1hUhKrF3BMkfD5SYd+UFsugQuLDPVmts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775482045; c=relaxed/simple;
	bh=ApzFFcmb0FBSG1KpfnS/ysejnlQy0LD8hl30dgnLRpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKqjuGlsuWeWtjdIjxEIei07s+IZPEJJWApOGx+Ms4SlxPd5Fc8ybBw1EBJSrcxkVuuzeL+K5PSCg7B66O3WesnWcnpolVPG4IYHId+fua+J4mV5MT9LJSZvD1nZhaeyES0zzss3Er/onEMmD99sWIuFX1d/L8YN/gE1U/n94jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUZu9q2X; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50d876329bbso15194071cf.2
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 06:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775482043; x=1776086843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4jnVKXO2m03EwbrtAvTPLPUNSZkb1k5JxPcqKYfX1GA=;
        b=HUZu9q2X5ALaWzNGz8+RuSSUPd1siup4mkZK9gNy6covB22EUsaM3V++kFjm922Y9X
         +xEL83DYagiif+e6/mBcNdvXO4Vig7OSc9u6gdHwsMRKvmnqqSSrabYgvZja7LH3JnFb
         ZVvPGhRQ55BANJ3mPftQmwbF2QTDpfMM31PpkZBZr3zZut/TNQ5DStY3PAwpcepGTGi2
         5dOawe0FJ/G6RdcDKTzIm5zfFqsgf2hX2SsJ9SLo5YdODi4dPBFXmJraNVvod+ScPZBG
         Z2stfOgvNgw6ggdhaXFiolHjiOetBiWz1UpOPFwMybKw+8NMfnzw2qkTvBU6IGBUR2hy
         RkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775482043; x=1776086843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4jnVKXO2m03EwbrtAvTPLPUNSZkb1k5JxPcqKYfX1GA=;
        b=SND8pwHKKLc5icyjAi8l2eEa4nuLjxeiqnFEWuQvjcBzwInWS2VgoGTvtRKvwLaYGr
         LFX32yQSlYFMBD7nKZajt/0bOX/IPNGjoYFKTRIJDNgiH3k824zO2TNrzkslDn6BEHRy
         V5Du0UG9xwT7twbAch+it6I7MzzDj4NHFIa978rhDzrBV14WhW54y/9cKpJdAoZpQJQ9
         W6sfAoX5c60PQkozpuSpahrZbWhxVlS2kmhMjILX98jd/jcTCa7DhqoeQKn21A8jBuMa
         sD6u5ii1TK9VtwRYVhYt53mlGmMsm4zufmmw1xHBa1RL75rGhIVf4KfttXunyQrYglWN
         vtEg==
X-Forwarded-Encrypted: i=1; AJvYcCXQeESQJKxd7BXwXVmRPz8FgHc6D0MICCjFRsp+XjRvx19ZgqA0NUMXfnk7niqaIu1j937lAoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkjbZuUwSfeH9KnZqWXPfu3lsbKUlwGSXiWbJLvlWU8KBC4oG9
	BHuqVSUgFEm9HgUcW6d3mDmyDaLjvb69DR6oKQP9mb1vhRs/yRAYcsGP
X-Gm-Gg: AeBDievMY/KBk77hhHniXSxk5o6E0F97bdpvHpuOcbkEYTGOZ1kNn6vCPD/qoc0EBZb
	dhFeheW1yhTwR1HbCL8hguZSEcbURuhw7uB10LH6Eyh+ldCYWp7PpRYKG3ZL5TEM6LIneNpDpy2
	K7MxizMh9cWu7U+tQiMioIIc24vF538vtrvhUG0mpz/1Mkbs93ZrOfZTgbAjCajP5b5udt7D60B
	im0Fsx2OjQzPi0efrNMqsIduG2noc+8UFgpdJPzCHMPG+VO3FaTLnDaptNbdt+8FKlL8n8a5qxV
	6P63Ozkzw0FYPAp2vNTJMKY7mLy0NDT9p5307T5GbuNrMnppEJUD9UOBAwgemd8ze6App773FVC
	o5+mKxPTcgXhmfKTszDzc9kFZWjrz6ppzCzS/m/UGKPOmCDoGN1KOqUH+VUuz+5kvMwmrDPh7A3
	9VD98JHLvbv62cwmetS20BjKtW8HhQ6pWg5z5J4jFFy5l/W5RS0Bu4QWk300m8MKT3bjF+k6N9U
	+BJkR5DeCmM1iBgto18YcAorOUpGoKVSP7qgA==
X-Received: by 2002:a05:622a:5cf:b0:50d:7d8a:5d45 with SMTP id d75a77b69052e-50d7d8a69afmr122162371cf.36.1775482042018;
        Mon, 06 Apr 2026 06:27:22 -0700 (PDT)
Received: from ?IPV6:2600:4040:93b4:e600:a22c:878f:7c1a:1976? ([2600:4040:93b4:e600:a22c:878f:7c1a:1976])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b8d0904sm112070511cf.29.2026.04.06.06.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 06:27:21 -0700 (PDT)
Message-ID: <2758ac3a-50dc-451a-990a-93e4db9d4bd6@gmail.com>
Date: Mon, 6 Apr 2026 09:27:20 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 net-next 2/5] psp: add new netlink cmd for dev-assoc
 and dev-disassoc
To: Wei Wang <weibunny.kernel@gmail.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: Wei Wang <weibunny@fb.com>
References: <20260405055853.3285534-1-weibunny.kernel@gmail.com>
 <20260405055853.3285534-3-weibunny.kernel@gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260405055853.3285534-3-weibunny.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275592-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,davidwei.uk,lunn.ch,davemloft.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fb.com:email]
X-Rspamd-Queue-Id: 3D0923A387F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/5/26 1:58 AM, Wei Wang wrote:
> From: Wei Wang <weibunny@fb.com>
>
> The main purpose of this cmd is to be able to associate a
> non-psp-capable device (e.g. veth or netkit) with a psp device.
> One use case is if we create a pair of veth/netkit, and assign 1 end
> inside a netns, while leaving the other end within the default netns,
> with a real PSP device, e.g. netdevsim or a physical PSP-capable NIC.
> With this command, we could associate the veth/netkit inside the netns
> with PSP device, so the virtual device could act as PSP-capable device
> to initiate PSP connections, and performs PSP encryption/decryption on
> the real PSP device.
>
> Signed-off-by: Wei Wang <weibunny@fb.com>
> ---
>   Documentation/netlink/specs/psp.yaml |  67 +++++-
>   include/net/psp/types.h              |  15 ++
>   include/uapi/linux/psp.h             |  13 ++
>   net/psp/psp-nl-gen.c                 |  32 +++
>   net/psp/psp-nl-gen.h                 |   2 +
>   net/psp/psp_main.c                   |  20 ++
>   net/psp/psp_nl.c                     | 319 ++++++++++++++++++++++++++-
>   7 files changed, 457 insertions(+), 11 deletions(-)
>
...
>   
> +/**
> + * Admin version of psp_device_get_locked() where it returns psd only if
> + * current netns is the same as psd->main_netdev's netns.
> + */
>   int psp_device_get_locked_admin(const struct genl_split_ops *ops,
>   				struct sk_buff *skb, struct genl_info *info)
>   {
>   	return __psp_device_get_locked(ops, skb, info, true);
>   }
>   
> +/**
> + * Non-admin version of psp_device_get_locked() where it returns psd in netns
> + * for not only psd->main_netdev but all netdevs in psd->assoc_dev_list.
> + */
>   int psp_device_get_locked(const struct genl_split_ops *ops,
>   			  struct sk_buff *skb, struct genl_info *info)
>   {
> @@ -103,11 +179,74 @@ psp_device_unlock(const struct genl_split_ops *ops, struct sk_buff *skb,
>   		sockfd_put(socket);
>   }


There's a warning that these comments have the kdoc open sequence, but 
are not proper kdoc comments.

> +
>   static int
>   psp_nl_dev_fill(struct psp_dev *psd, struct sk_buff *rsp,
>   		const struct genl_info *info)
>   {
> +	struct net *cur_net;
>   	void *hdr;
> +	int err;
> +
> +	cur_net = genl_info_net(info);
> +
> +	/* Skip this device if we're in an associated netns but have no
> +	 * associated devices in cur_net
> +	 */
> +	if (cur_net != dev_net(psd->main_netdev) &&
> +	    !psp_has_assoc_dev_in_ns(psd, cur_net))
> +		return 0;
>   


Is this branch dead code given we either arrived here via 
psp_dev_check_access(), or psp_nl_build_dev_ntf() which should only use 
associated netns's?

>   
> +int psp_nl_dev_assoc_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct psp_dev *psd = info->user_ptr[0];
> +	struct psp_assoc_dev *psp_assoc_dev;
> +	struct net_device *assoc_dev;
> +	struct sk_buff *rsp;
> +	u32 assoc_ifindex;
> +	struct net *net;
> +	int nsid;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_IFINDEX))
> +		return -EINVAL;
> +
> +	if (info->attrs[PSP_A_DEV_NSID]) {
> +		nsid = nla_get_s32(info->attrs[PSP_A_DEV_NSID]);
> +
> +		net = get_net_ns_by_id(genl_info_net(info), nsid);
> +		if (!net) {
> +			NL_SET_BAD_ATTR(info->extack,
> +					info->attrs[PSP_A_DEV_NSID]);
> +			return -EINVAL;
> +		}
> +	} else {
> +		net = get_net(genl_info_net(info));
> +	}
> +
> +	psp_assoc_dev = kzalloc(sizeof(*psp_assoc_dev), GFP_KERNEL);
> +	if (!psp_assoc_dev) {
> +		put_net(net);
> +		return -ENOMEM;
> +	}
> +
> +	assoc_ifindex = nla_get_u32(info->attrs[PSP_A_DEV_IFINDEX]);
> +	assoc_dev = netdev_get_by_index(net, assoc_ifindex,
> +					&psp_assoc_dev->dev_tracker,
> +					GFP_KERNEL);
> +	if (!assoc_dev) {
> +		put_net(net);
> +		kfree(psp_assoc_dev);
> +		NL_SET_BAD_ATTR(info->extack, info->attrs[PSP_A_DEV_IFINDEX]);
> +		return -ENODEV;
> +	}
> +
> +	/* Check if device is already associated with a PSP device */
> +	if (cmpxchg(&assoc_dev->psp_dev, NULL, RCU_INITIALIZER(psd))) {
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Device already associated with a PSP device");
> +		netdev_put(assoc_dev, &psp_assoc_dev->dev_tracker);
> +		put_net(net);
> +		kfree(psp_assoc_dev);
> +		return -EBUSY;
> +	}
> +
> +	psp_assoc_dev->assoc_dev = assoc_dev;
> +	rsp = psp_nl_reply_new(info);
> +	if (!rsp) {
> +		rcu_assign_pointer(assoc_dev->psp_dev, NULL);
> +		netdev_put(assoc_dev, &psp_assoc_dev->dev_tracker);
> +		put_net(net);
> +		kfree(psp_assoc_dev);
> +		return -ENOMEM;
> +	}
> +
> +	list_add_tail(&psp_assoc_dev->dev_list, &psd->assoc_dev_list);
> +
> +	put_net(net);
> +
> +	psp_nl_notify_dev(psd, PSP_CMD_DEV_CHANGE_NTF);
> +
> +	return psp_nl_reply_send(rsp, info);
> +}
> +


This function could probably benefit from a goto style cleanup chain, 
given the overlapping set of actions to unwind at each error.

>   
>   int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
> @@ -320,7 +617,9 @@ int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
>   
>   	psd = psp_dev_get_for_sock(socket->sk);
>   	if (psd) {
> +		mutex_lock(&psd->lock);
>   		err = psp_dev_check_access(psd, genl_info_net(info), false);
> +		mutex_unlock(&psd->lock);


This looks like a "TOCTOU" issue on the mutable assoc_dev_list, but I 
think it ends up being a benign race.


>   		if (err) {
>   			psp_dev_put(psd);
>   			psd = NULL;


Some minor comments, but otherwise:

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>



