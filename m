Return-Path: <netdev+bounces-294658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UhVcJVPbH2r9rAAAu9opvQ
	(envelope-from <netdev+bounces-294658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:44:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AF8635572
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:44:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=C9lzNMsI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294658-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294658-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D8D3304EFCE
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B783A75B1;
	Wed,  3 Jun 2026 07:42:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2371E520A
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:42:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472555; cv=none; b=TTwFD/psUTwEKPt4ERTxD00KFEmWFvEKME4hMNfjSoCAKl3O5OJAymvyO48sxPVeheQQykQKoc2cjnoI+lqLF+FLZKwCYNhiZsmXY/FtGFS/cI4+vomTUcKtGFhYCXWEfnbS1eqMQ/zFYrW0VtRE5rBDboJyTKIFL7muCkdu554=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472555; c=relaxed/simple;
	bh=Dd989IhXkzX9QYjDCgjPHufnRLsGXYvrz7qXcd44nf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGE5A6p3OUBbYYXVYJ8e62slhkk6UsRIpUwduxdkqMBrnWRWVksresDn9rH0fbR00qgXYotLUcUGOaCV+hEbo6p/vxa+jHVLbNqQOJPR4YLn0XZhojpWxXhqK9QRlXXG5inAWkpeJNxWtIU/w+Vit7w6wnmreZ+QeiGmM3sXF2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=C9lzNMsI; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45eec22fab7so3287384f8f.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 00:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780472552; x=1781077352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=usd1BN+uxeuX7r43CS+pz+Pm4brdzbI6RUN4pOaKMsw=;
        b=C9lzNMsI9JK92s3pURmOPTfACgwvycpTzTyPfc9H2vbJJDmfWTJVhB7Tep9NiqkjOn
         oppoH7mFRQOiKDrzQJcZn40Mqq+yX0Ers7UjjwLiCs/S/syycwaeb2qxpUl+PlCs0aOP
         Ea4Nd0Qn3XIeup3KgR1a1VS2ptFxO4L7fLQFnTPs3Q/MOD+ufgZMQMwx08IgTLx8sxYq
         66MpjFTXF7ugd1bxLQV3E6UK1DoM1ea9+x8/GPndPIsOlGD2BsiYRukBeUWbYl83pSG0
         3uTxzagD7KnDR4Y+boy7KBbU9JDrq4E9Qearq695ysR0qDFNa+QBYAMeJynRNrSfVy+o
         NM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780472552; x=1781077352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=usd1BN+uxeuX7r43CS+pz+Pm4brdzbI6RUN4pOaKMsw=;
        b=hIyuYxLaYyjeZVZ1a9Ba9U434xqlc6zG3bRXbk8F4IEls+L/YATo9YQtq3mzbQkT/P
         8PH1dLYsZFQ7tOIXugCmEDQD44EwKNZr3fY7MoL07hMmEhJ1Zknc1U0S3ppGiYEUbAgC
         SZR2phPQ07Q8BdpAs01e7sKRoCU2LVRb0fVPdTVlwUB2J6j14x3sfJwU/zEAG5FMGSG2
         rGQB59RJL1ETicyjFKI5VmWnh71IWJB2LzeIdaDjDj7tQ6KgnjfWc4cM4r4HPUKDgbwW
         zSlJc2YUOyfyXxF5JQRw1s/lIOOSOEoZ6O/hJ0ivEO6fLBIQ1tvbUUndKtn/zs925YN2
         AN/w==
X-Forwarded-Encrypted: i=1; AFNElJ/NnpxiDMJxrfa7EbUIYgBsgvQG/F3d1sc/hJUKui23Y4x82f+gs1GKhkEEj7iUhH1F2zYs6X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFinWM15Py0FTP+s/+0hHoNeV8smkY7xG+xS67NWKAMUjaNGgf
	Ybno6oGcmVmYPDTA3XEsUlQNezUUZ5G+tHXII8CESnfi6nwno9yKFUPXIZJt2KNRchc=
X-Gm-Gg: Acq92OGCc91B1gcGdRmuAXFpk+gZhgnkQ4rUnOmp47ZLriCxku9BPFiUTS+sS+QPThx
	g8Ls5+wIAYV8yl1yw8Bk4gRJ7g85uioqjqE0El1otxWTf/iMTUrmAUyC9Ss8uKRVvEy83fmG/C2
	xWSG5Wb5RjMVDu9607qNd9y75diuUzIZLGUSoYUHpL97G2GwYSlKwbdFrJHL5HdA6kifH8SIewM
	RutOQydIgtLraAk48pj4pyPbMhDvFIpwG7tFFJJERsReorsE8SfcypMftIBozpc7d9Ogc42kl/3
	hNrjYFf+y6209/8E4LMWs7LzAEG+k8jRQf9xWKcT6/rh5Rxt9kYT5PqlVItZFkHkvd0F15ZDEIg
	V29VhlGj/LI2NjWrtVWv+/4BJaQcbqcb4wfSudT9OERaQMun8Q9xfdnyIMSDOJEUUpx+aQYdAtF
	Mlls+JcTg10sucHKTTIW0ksIFyV8Dbc7NUOpxRPhQpUI+6bUxe6kpKPCZqAK80jszR
X-Received: by 2002:a05:6000:2905:b0:460:ff2:63e5 with SMTP id ffacd0b85a97d-4602181e60fmr2505388f8f.18.1780472552559;
        Wed, 03 Jun 2026 00:42:32 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc294sm8472471f8f.7.2026.06.03.00.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 00:42:32 -0700 (PDT)
Message-ID: <cd628559-aaea-404f-b8db-d75ad1f75d61@blackwall.org>
Date: Wed, 3 Jun 2026 10:42:31 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 02/11] bridge: add bridge_flags_bit enum
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260603062043.3911278-1-edumazet@google.com>
 <20260603062043.3911278-3-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260603062043.3911278-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294658-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,blackwall.org:mid,blackwall.org:dkim,blackwall.org:from_mime,blackwall.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33AF8635572

On 03/06/2026 09:20, Eric Dumazet wrote:
> We want to use atomic operations for lockless p->flags changes
> and reads.
> 
> Add definitions for bits in addition of masks so that we can use
> test_bit(), clear_bit() and set_bit() in subsequent patches.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   include/linux/if_bridge.h | 78 ++++++++++++++++++++++++++-------------
>   1 file changed, 53 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
> index ec9ffea1e46ede3762f108f6e7085ebb1bf1d2e1..75673b8bffcb8ad6396e6a05b8af8150208fb6fe 100644
> --- a/include/linux/if_bridge.h
> +++ b/include/linux/if_bridge.h
> @@ -36,32 +36,60 @@ struct br_ip_list {
>   	struct br_ip addr;
>   };
>   
> -#define BR_HAIRPIN_MODE		BIT(0)
> -#define BR_BPDU_GUARD		BIT(1)
> -#define BR_ROOT_BLOCK		BIT(2)
> -#define BR_MULTICAST_FAST_LEAVE	BIT(3)
> -#define BR_ADMIN_COST		BIT(4)
> -#define BR_LEARNING		BIT(5)
> -#define BR_FLOOD		BIT(6)
> +enum bridge_flags_bit {
> +	BR_HAIRPIN_MODE_BIT,
> +	BR_BPDU_GUARD_BIT,
> +	BR_ROOT_BLOCK_BIT,
> +	BR_MULTICAST_FAST_LEAVE_BIT,
> +	BR_ADMIN_COST_BIT,
> +	BR_LEARNING_BIT,
> +	BR_FLOOD_BIT,
> +	BR_PROMISC_BIT,
> +	BR_PROXYARP_BIT,
> +	BR_LEARNING_SYNC_BIT,
> +	BR_PROXYARP_WIFI_BIT,
> +	BR_MCAST_FLOOD_BIT,
> +	BR_MULTICAST_TO_UNICAST_BIT,
> +	BR_VLAN_TUNNEL_BIT,
> +	BR_BCAST_FLOOD_BIT,
> +	BR_NEIGH_SUPPRESS_BIT,
> +	BR_ISOLATED_BIT,
> +	BR_MRP_AWARE_BIT,
> +	BR_MRP_LOST_CONT_BIT,
> +	BR_MRP_LOST_IN_CONT_BIT,
> +	BR_TX_FWD_OFFLOAD_BIT,
> +	BR_PORT_LOCKED_BIT,
> +	BR_PORT_MAB_BIT,
> +	BR_NEIGH_VLAN_SUPPRESS_BIT,
> +	BR_NEIGH_FORWARD_GRAT_BIT,
> +};
> +
> +#define BR_HAIRPIN_MODE		BIT(BR_HAIRPIN_MODE_BIT)
> +#define BR_BPDU_GUARD		BIT(BR_BPDU_GUARD_BIT)
> +#define BR_ROOT_BLOCK		BIT(BR_ROOT_BLOCK_BIT)
> +#define BR_MULTICAST_FAST_LEAVE	BIT(BR_MULTICAST_FAST_LEAVE_BIT)
> +#define BR_ADMIN_COST		BIT(BR_ADMIN_COST_BIT)
> +#define BR_LEARNING		BIT(BR_LEARNING_BIT)
> +#define BR_FLOOD		BIT(BR_FLOOD_BIT)
>   #define BR_AUTO_MASK		(BR_FLOOD | BR_LEARNING)
> -#define BR_PROMISC		BIT(7)
> -#define BR_PROXYARP		BIT(8)
> -#define BR_LEARNING_SYNC	BIT(9)
> -#define BR_PROXYARP_WIFI	BIT(10)
> -#define BR_MCAST_FLOOD		BIT(11)
> -#define BR_MULTICAST_TO_UNICAST	BIT(12)
> -#define BR_VLAN_TUNNEL		BIT(13)
> -#define BR_BCAST_FLOOD		BIT(14)
> -#define BR_NEIGH_SUPPRESS	BIT(15)
> -#define BR_ISOLATED		BIT(16)
> -#define BR_MRP_AWARE		BIT(17)
> -#define BR_MRP_LOST_CONT	BIT(18)
> -#define BR_MRP_LOST_IN_CONT	BIT(19)
> -#define BR_TX_FWD_OFFLOAD	BIT(20)
> -#define BR_PORT_LOCKED		BIT(21)
> -#define BR_PORT_MAB		BIT(22)
> -#define BR_NEIGH_VLAN_SUPPRESS	BIT(23)
> -#define BR_NEIGH_FORWARD_GRAT	BIT(24)
> +#define BR_PROMISC		BIT(BR_PROMISC_BIT)
> +#define BR_PROXYARP		BIT(BR_PROXYARP_BIT)
> +#define BR_LEARNING_SYNC	BIT(BR_LEARNING_SYNC_BIT)
> +#define BR_PROXYARP_WIFI	BIT(BR_PROXYARP_WIFI_BIT)
> +#define BR_MCAST_FLOOD		BIT(BR_MCAST_FLOOD_BIT)
> +#define BR_MULTICAST_TO_UNICAST	BIT(BR_MULTICAST_TO_UNICAST_BIT)
> +#define BR_VLAN_TUNNEL		BIT(BR_VLAN_TUNNEL_BIT)
> +#define BR_BCAST_FLOOD		BIT(BR_BCAST_FLOOD_BIT)
> +#define BR_NEIGH_SUPPRESS	BIT(BR_NEIGH_SUPPRESS_BIT)
> +#define BR_ISOLATED		BIT(BR_ISOLATED_BIT)
> +#define BR_MRP_AWARE		BIT(BR_MRP_AWARE_BIT)
> +#define BR_MRP_LOST_CONT	BIT(BR_MRP_LOST_CONT_BIT)
> +#define BR_MRP_LOST_IN_CONT	BIT(BR_MRP_LOST_IN_CONT_BIT)
> +#define BR_TX_FWD_OFFLOAD	BIT(BR_TX_FWD_OFFLOAD_BIT)
> +#define BR_PORT_LOCKED		BIT(BR_PORT_LOCKED_BIT)
> +#define BR_PORT_MAB		BIT(BR_PORT_MAB_BIT)
> +#define BR_NEIGH_VLAN_SUPPRESS	BIT(BR_NEIGH_VLAN_SUPPRESS_BIT)
> +#define BR_NEIGH_FORWARD_GRAT	BIT(BR_NEIGH_FORWARD_GRAT_BIT)
>   
>   #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
>   

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


