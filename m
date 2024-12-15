Return-Path: <netdev+bounces-151977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 531239F21C1
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 03:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82340164511
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 02:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127D079DC;
	Sun, 15 Dec 2024 02:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="UGwPKOjZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539F6653;
	Sun, 15 Dec 2024 02:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734229688; cv=none; b=ukVgkfViLqs3gknNkoKwniXbEUPo/AxId5P1hIhgWgjab9NB6fiRPNL0akH0yiAPQj6zNkOhsAdbOkR2gXOBhL+2CVIjur1o/SwUuSbpmVL5JvD5M4F1JVeucUPNqhCSvTdXRRhbFj1UVDTxzo0qXVCq3THSX2F9hdMaaBCpKTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734229688; c=relaxed/simple;
	bh=MLlumoZHmHbqBzRfHsVCxREyHXeeCl7mYEijMYxIc1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RD0uq4zEIE4PJdB10rQBXU0H5uVFUbqPxdlebrR4Qzxfg064WFEduZFpNcEiItqlNKRPqp5BfuGJJdpGCEJMHDVaNiGv3BRAd+xt2lgDYOqJzFtcetsdBhJyzkyvU+srVlJzG0cW3KgWhhJst25FvBFlwJUG7FRC0Rtju9sVupI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=UGwPKOjZ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=MM7ieqR2fvWCB6DaMUqnBY6opWO9vzebBQbjF3iD90Y=; b=UGwPKOjZ5HlH8kPU
	fW8Dd08ndpIFS5EWhMCgvYqQHVI6duCZzYoJ7V1SrBgiG6ZepFOyxn35iSgEt2VkXH+9/woSdUi6X
	HE6HdD+5WIxvkZitfkZpw8mQ4eJW74/tnNpUWwSJOgOSUO1oobKJgic56zDw7znwpyyZ78B8/7sSX
	weRsKF9yDJQLuPsGoC7F2EFyc0NlaCYBmdpmfED8iXSV4YuXqvYXwxbVTBsNKqgaMR/D/Nr2eJtZ3
	OQZmSkcSRTYwrFxAGw5vNCDXzGRzrN1rN2kI4Nu948u5iyX4B0FpQlL1p3L6S1xj9R/L123+YxdDh
	ZvZ5OIG+SyyxXCY9vQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tMeMT-005RIK-1A;
	Sun, 15 Dec 2024 02:28:01 +0000
Date: Sun, 15 Dec 2024 02:28:01 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: jes@trained-monkey.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] hippi: Remove unused hippi_neigh_setup_dev
Message-ID: <Z14-sYvgzEPZSTyR@gallifrey>
References: <20241215022618.181756-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241215022618.181756-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 02:27:26 up 220 days, 13:41,  1 user,  load average: 0.05, 0.05,
 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)

Note the hippi list address bounces:

<linux-hippi@sunsite.dk>:
Sorry, no mailbox here by that name. (#5.1.1)

Dave

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> hippi_neigh_setup_dev() has been unused since
> commit e3804cbebb67 ("net: remove COMPAT_NET_DEV_OPS")
> 
> Remove it.
> 
> (I'm a little suspicious it's the only setup call removed
> by that previous commit?)
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  include/linux/hippidevice.h |  1 -
>  net/802/hippi.c             | 15 ---------------
>  2 files changed, 16 deletions(-)
> 
> diff --git a/include/linux/hippidevice.h b/include/linux/hippidevice.h
> index 07414c241e65..404bd5b2b4fc 100644
> --- a/include/linux/hippidevice.h
> +++ b/include/linux/hippidevice.h
> @@ -33,7 +33,6 @@ struct hippi_cb {
>  
>  __be16 hippi_type_trans(struct sk_buff *skb, struct net_device *dev);
>  int hippi_mac_addr(struct net_device *dev, void *p);
> -int hippi_neigh_setup_dev(struct net_device *dev, struct neigh_parms *p);
>  struct net_device *alloc_hippi_dev(int sizeof_priv);
>  #endif
>  
> diff --git a/net/802/hippi.c b/net/802/hippi.c
> index 1997b7dd265e..5e02ec1274a1 100644
> --- a/net/802/hippi.c
> +++ b/net/802/hippi.c
> @@ -126,21 +126,6 @@ int hippi_mac_addr(struct net_device *dev, void *p)
>  }
>  EXPORT_SYMBOL(hippi_mac_addr);
>  
> -int hippi_neigh_setup_dev(struct net_device *dev, struct neigh_parms *p)
> -{
> -	/* Never send broadcast/multicast ARP messages */
> -	NEIGH_VAR_INIT(p, MCAST_PROBES, 0);
> -
> -	/* In IPv6 unicast probes are valid even on NBMA,
> -	* because they are encapsulated in normal IPv6 protocol.
> -	* Should be a generic flag.
> -	*/
> -	if (p->tbl->family != AF_INET6)
> -		NEIGH_VAR_INIT(p, UCAST_PROBES, 0);
> -	return 0;
> -}
> -EXPORT_SYMBOL(hippi_neigh_setup_dev);
> -
>  static const struct header_ops hippi_header_ops = {
>  	.create		= hippi_header,
>  };
> -- 
> 2.47.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

