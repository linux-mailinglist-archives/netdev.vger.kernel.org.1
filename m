Return-Path: <netdev+bounces-293322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMZDJm6yGmoH7ggAu9opvQ
	(envelope-from <netdev+bounces-293322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 11:48:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F3660BF74
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 11:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02D51301AF03
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 09:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C696636920C;
	Sat, 30 May 2026 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtn8GRiD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A028E39FCDC
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780134503; cv=none; b=c7m5gcczISu4uDTD1bnC9S+hwEdAWuZG6mhVTaDhPGslU7UDgz6yKnN+JFhxwfeDM3Y3zpErEseZYqSZY8wgjT4yzLutBYGAimJ/m7rDAdB3V5K7QnBqp+rhQhg+Nl267pE/3AuBd49dd6KwydXggWeXHWghI+rh3+oDk6K0m60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780134503; c=relaxed/simple;
	bh=udc1SyCF7VSS4+LIxaWs2+kyiLV1/lJ+NobNmCXau3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxibdPubU158OMp2T+mA8uPdibymgbmLKQm4Olhfh971XnhlYGKUi3lauOqU7KXnzhi7sGMc7c8mbH4ghNoZBxyeozej/nV7xPcugmy/q6xP4Z9yC6DeJxYrG+l0L2o1/yGbk1+K9iLSf6JG6SwEFlOhqRDzvVDNbNv1Tstaf/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtn8GRiD; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bd80b3aa13so96588835ad.0
        for <netdev@vger.kernel.org>; Sat, 30 May 2026 02:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780134501; x=1780739301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J5P8ezayUktMUJpCuTOw6j295sXtS6RK6x7W/G4VqJg=;
        b=dtn8GRiDOa5Im12LVdqgWtEzk9ZOwfwegnS8rgLQYVSIVVx6MHTIK6rwGc8twhqxGK
         sXmqObfrf+QS8woF1U/4g+/Qm1MHgs74OMchssyJbNwGeOQy2Y8ZBpq0poYmmW0rjoIy
         cBpmPO35Ulk7C2yykt0H25UzmpuLamHKGtIjPvxTi04ppSc5HIkOBzXeGkoq6QxklBUz
         6jAXSf3iXz5O0BQF5MQ1B7x8XV7HzBIDpWiVc+x1MEyokp6QDg4xjcIf8Dof5N8BFWV7
         67BOS8rpuKQcleewwHb5S3EQTga+/iKMFrZ1S7rekjPG9hPz4n6UnC/rEWPMAfCVPKT7
         HuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780134501; x=1780739301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5P8ezayUktMUJpCuTOw6j295sXtS6RK6x7W/G4VqJg=;
        b=hRdIP01pDJ2BOaBA/WfMPHoHKV8TB+DfP/e8gZ1QQPhZF38FDNqAgXoQupZASiPxsJ
         c3O3/OBiyvxp1BVm1FnxzyXVwlg77KFvl2wudJXd9Z2WWYCELuokovYiVTVBULOgkGNm
         U6Yeht10LRPTLBh+OUzRTv5y3/d9f70kgow5d3o0xRbTudzVhrVIa7IhZgBPUvVGyjs3
         atbBTvWIl3Id+uXhuDoAii3IOOMmeUj/O7blpnQOyX7WDmpMBTnU4Ia3D9cPchPU4MuY
         /7R0RN0lTxBXhlMn+OHQgdzF3r1od+6b/eWdfPYsYddXS5G9Zq/dwsHLIdw+F6iLpctB
         yP/g==
X-Gm-Message-State: AOJu0YwC2xNRhDBQjxorXWUiw3St1Z1hkxgf6Hi1CkHD++m9swXMAM6K
	8IaVfh4JiNRzA4glu0oeWt228lCeZ5p9c6xGvmfy9jHWy2jZUC9+UG8I
X-Gm-Gg: Acq92OG/vWR3UaGuIR7XQ2IWpTYwQI4TYl+Zu10XGADorkvvw3GznQkPwihjaxE5wsj
	5Ldt82GOBeB38Ke6dR2fnIH3VePFooqqtmu6CE1QkhW7PuiphXulcwpH/+P2/lcV21vumLVOJnh
	6HptD1SMyWQEp3BPCGtr9JIp6f257dT4Mpycz7BlSNtWsqqlfFVyqIVegmKIoUr5U6GYvpcKgoq
	ItIRzd5fm6oNqbg8mNpmIRjETTjd2yeF5h0XCaNKrP2/P87ZSEgzUk6pGKymLW04vc5rakpwOIc
	0jjldIv3ME+k+7W3eG0UdRMTMr3FZn+7WUIqQUcLKHwXMOgR9vd1UATF320xMQC/SbsM4PQYfwL
	OifrCutzuNbk/lqXQNbs2aKVaPYfRFosV65IDvE0KMq61izkmAAvtU5M0SfRYtXvoWDOmncSGgZ
	vlfx+fcsknRlCXvHL0Q7q8NUlMsycyjHl7wYvjeiAwauoTHL1HLTY5IQ==
X-Received: by 2002:a17:903:986:b0:2bd:2de3:519a with SMTP id d9443c01a7336-2bf367939b7mr37530755ad.7.1780134500813;
        Sat, 30 May 2026 02:48:20 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e5c6dsm43649965ad.17.2026.05.30.02.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 02:48:20 -0700 (PDT)
Date: Sat, 30 May 2026 18:48:16 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Cc: netdev@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net] ipv4: protect egress device access in the output
 path with rcu_read_lock
Message-ID: <ahqyYBb22QxcyPYN@v4bel>
References: <ahqIg6vURwYI0LJ5@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahqIg6vURwYI0LJ5@v4bel>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293322-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 97F3660BF74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 30, 2026 at 03:49:39PM +0900, Hyunwoo Kim wrote:
> ip_mc_output(), __ip_local_out() and xfrm4_output() read the egress
> network device from rt->dst.dev / skb_dst_dev(skb) and then pass that
> pointer as the 'out' device argument of NF_HOOK without holding
> rcu_read_lock.
> 
> dst->dev is a field protected by RCU. When a device is unregistered its
> value is replaced with blackhole_netdev, and the previous device is
> freed after an RCU grace period. A section that reads dst->dev and uses
> that pointer must therefore hold rcu_read_lock. The three functions
> above are missing this protection, so when the egress device is
> unregistered concurrently with transmission, a LOCAL_OUT / POST_ROUTING
> hook (nft meta oif, selinux_ip_postroute_compat, etc.) can reference a
> device pointer that is no longer valid.
> 
> In all three leaves, wrap the section that reads the device and runs
> NF_HOOK in rcu_read_lock(), and read the device through the RCU
> accessors (skb_dst_dev_rcu() / dst_dev_rcu()). As a result, the RCU
> grace period cannot complete while a transmission is in flight, so the
> egress device is not freed and the hook always references a valid
> device.
> 
> Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/ipv4/ip_output.c    | 27 +++++++++++++++++++--------
>  net/ipv4/xfrm4_output.c | 13 +++++++++----
>  2 files changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 5bcd73cbdb41..92a70b7e74a6 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -102,6 +102,7 @@ EXPORT_SYMBOL(ip_send_check);
>  int __ip_local_out(struct net *net, struct sock *sk, struct sk_buff *skb)
>  {
>  	struct iphdr *iph = ip_hdr(skb);
> +	int err;
>  
>  	IP_INC_STATS(net, IPSTATS_MIB_OUTREQUESTS);
>  
> @@ -117,9 +118,12 @@ int __ip_local_out(struct net *net, struct sock *sk, struct sk_buff *skb)
>  
>  	skb->protocol = htons(ETH_P_IP);
>  
> -	return nf_hook(NFPROTO_IPV4, NF_INET_LOCAL_OUT,
> -		       net, sk, skb, NULL, skb_dst_dev(skb),
> -		       dst_output);
> +	rcu_read_lock();
> +	err = nf_hook(NFPROTO_IPV4, NF_INET_LOCAL_OUT,
> +		      net, sk, skb, NULL, skb_dst_dev_rcu(skb),
> +		      dst_output);
> +	rcu_read_unlock();
> +	return err;
>  }
>  
>  int ip_local_out(struct net *net, struct sock *sk, struct sk_buff *skb)
> @@ -368,7 +372,11 @@ static int ip_mc_finish_output(struct net *net, struct sock *sk,
>  int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  {
>  	struct rtable *rt = skb_rtable(skb);
> -	struct net_device *dev = rt->dst.dev;
> +	struct net_device *dev;
> +	int ret;
> +
> +	rcu_read_lock();
> +	dev = dst_dev_rcu(&rt->dst);
>  
>  	/*
>  	 *	If the indicated interface is up and running, send the packet.
> @@ -407,6 +415,7 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  
>  		if (ip_hdr(skb)->ttl == 0) {
>  			kfree_skb(skb);
> +			rcu_read_unlock();
>  			return 0;
>  		}
>  	}
> @@ -419,10 +428,12 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  				ip_mc_finish_output);
>  	}
>  
> -	return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
> -			    net, sk, skb, NULL, skb->dev,
> -			    ip_finish_output,
> -			    !(IPCB(skb)->flags & IPSKB_REROUTED));
> +	ret = NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
> +			   net, sk, skb, NULL, skb->dev,
> +			   ip_finish_output,
> +			   !(IPCB(skb)->flags & IPSKB_REROUTED));
> +	rcu_read_unlock();
> +	return ret;
>  }
>  
>  int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb)
> diff --git a/net/ipv4/xfrm4_output.c b/net/ipv4/xfrm4_output.c
> index 0ae67d537499..d5dc084777a3 100644
> --- a/net/ipv4/xfrm4_output.c
> +++ b/net/ipv4/xfrm4_output.c
> @@ -30,10 +30,15 @@ static int __xfrm4_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  
>  int xfrm4_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  {
> -	return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
> -			    net, sk, skb, skb->dev, skb_dst_dev(skb),
> -			    __xfrm4_output,
> -			    !(IPCB(skb)->flags & IPSKB_REROUTED));
> +	int ret;
> +
> +	rcu_read_lock();
> +	ret = NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
> +			   net, sk, skb, skb->dev, skb_dst_dev_rcu(skb),
> +			   __xfrm4_output,
> +			   !(IPCB(skb)->flags & IPSKB_REROUTED));
> +	rcu_read_unlock();
> +	return ret;
>  }
>  
>  void xfrm4_local_error(struct sk_buff *skb, u32 mtu)
> -- 
> 2.43.0
> 

Further analysis confirmed that raw_send_hdrinc(), xfrm_output_resume() 
and vrf_output() are affected by the same issue.

I will post a v2 covering these additional cases after 24 hours.


Best regards,
Hyunwoo Kim

