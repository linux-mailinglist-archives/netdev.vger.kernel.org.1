Return-Path: <netdev+bounces-278954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NM1Ii6R4GmsjwAAu9opvQ
	(envelope-from <netdev+bounces-278954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 09:35:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E9940B15E
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 09:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6541A30086A9
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527AE274658;
	Thu, 16 Apr 2026 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QcOzEF8V"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB11E33D503
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 07:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776324902; cv=none; b=BzYvq+3XNQvIfd2fXFnvoZo+Ex2K7nJFZepf+UzJtErPgEAfoqJKvywJY1VWPl8PNyt3SwpiZ6j0ndMg8OGfIk9NgZqCRYbVKQEuR7F6pcrEWr6w94pzWFn4nzVG4FEZ/zFdOq6UfoxiLQoUFp3oHeC06zCe3ypFw+jXvxLc3xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776324902; c=relaxed/simple;
	bh=DbITn4yr2PYB7C90npq5IbcWOoFWiYzVBsq36wB4obk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Km+coJlPFnK/EistqnYHTRZn2F47avnv0VWiuEW0s1Tdtv1QcBZic4EfP6NQUW4zO34aC/zsZNrUwA4cDzSh9ue3wVJnysnUOaOHcuRiUOSsVqg2pyR/zboBOAerEoG7UOmZSlIXbb1FichvvI3ltvQn5/ZgGGr92Pk2rBP2F5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QcOzEF8V; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D8540C5C3C4;
	Thu, 16 Apr 2026 07:35:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CEB565FDEB;
	Thu, 16 Apr 2026 07:34:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 20A9D1045A117;
	Thu, 16 Apr 2026 09:34:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776324895; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=+lfcMBvb5fZjSzrarf6sFor1f0wiPhHjUUQenVDV4z4=;
	b=QcOzEF8V2WRZYk27ja3Q4K//Of0QvufX0GXMKJqEVtT4hLl9RMMYCW0KKAAkLN0moKTC3O
	2cKBgRYsy0y0egvMqHNDZvneU1X0rAQ0si+Vnb9I76Py9ikC6Srn6FPHayFF52iKzfGN1s
	NoWvTyHMB2buJix/1UKX5rY3yp9IdF0jPnXbTlXcrZKrJgY9ADTKbYLs8txbAoUGNvrpOb
	xXNGP5+L6lvCXTi14nMGuxoQvp87PmOXbopoPh1t/8Aj1ypCi/QpUK01NxtDSLPYw7Ezks
	VktUlV5hNw96BQZF1qKa7lF2j3Ttl1/HvZPsAiTSJLRYhFXZy5XhE9PCu1r50g==
Message-ID: <9d4e0575-e063-4fe5-b8ce-7053efa8ec2f@bootlin.com>
Date: Thu, 16 Apr 2026 09:34:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: remove redundant netdev_lock_ops() from
 conduit ethtool ops
To: Stanislav Fomichev <sdf.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, olteanv@gmail.com, horms@kernel.org,
 sdf@fomichev.me, linux-kernel@vger.kernel.org
References: <20260414231035.1917035-1-sdf@fomichev.me>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260414231035.1917035-1-sdf@fomichev.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278954-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	ASN_FAIL(0.00)[4.211.64.104.asn.rspamd.com:server fail];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com,fomichev.me,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fomichev.me:email,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: 59E9940B15E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Stanislav,

On 15/04/2026 01:10, Stanislav Fomichev wrote:
> DSA replaces the conduit (master) device's ethtool_ops with its own
> wrappers that aggregate stats from both the conduit and DSA switch
> ports. Taking the lock again inside the DSA wrappers causes a deadlock.
> 
> Stumbled upon this when booting qemu with fbnic and CONFIG_NET_DSA_LOOP=y
> (which looks like some kind of testing device that auto-populates the ports
> of eth0). `ethtool -i` is enough to deadlock. This means we have basically zero
> coverage for DSA stuff with real ops locked devs.

True, indeed I don't have physical devices here with locked ops, looking
at the current devices that use it (fbnic, bnxt, gve, mlx5, bnge) that's
not too surprising, I don't think these are often used with DSA.

> 
> Remove the redundant netdev_lock_ops()/netdev_unlock_ops() calls from
> the DSA conduit ethtool wrappers.
> 
> Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Fixes: 2bcf4772e45a ("net: ethtool: try to protect all callback with netdev instance lock")
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> (cherry picked from commit 1538c00ab3212273240112bd53692d54d95f2dd5)

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime
> ---
>  net/dsa/conduit.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/net/dsa/conduit.c b/net/dsa/conduit.c
> index a1b044467bd6..8398d72d7e4d 100644
> --- a/net/dsa/conduit.c
> +++ b/net/dsa/conduit.c
> @@ -27,9 +27,7 @@ static int dsa_conduit_get_regs_len(struct net_device *dev)
>  	int len;
>  
>  	if (ops && ops->get_regs_len) {
> -		netdev_lock_ops(dev);
>  		len = ops->get_regs_len(dev);
> -		netdev_unlock_ops(dev);
>  		if (len < 0)
>  			return len;
>  		ret += len;
> @@ -60,15 +58,11 @@ static void dsa_conduit_get_regs(struct net_device *dev,
>  	int len;
>  
>  	if (ops && ops->get_regs_len && ops->get_regs) {
> -		netdev_lock_ops(dev);
>  		len = ops->get_regs_len(dev);
> -		if (len < 0) {
> -			netdev_unlock_ops(dev);
> +		if (len < 0)
>  			return;
> -		}
>  		regs->len = len;
>  		ops->get_regs(dev, regs, data);
> -		netdev_unlock_ops(dev);
>  		data += regs->len;
>  	}
>  
> @@ -115,10 +109,8 @@ static void dsa_conduit_get_ethtool_stats(struct net_device *dev,
>  	int count, mcount = 0;
>  
>  	if (ops && ops->get_sset_count && ops->get_ethtool_stats) {
> -		netdev_lock_ops(dev);
>  		mcount = ops->get_sset_count(dev, ETH_SS_STATS);
>  		ops->get_ethtool_stats(dev, stats, data);
> -		netdev_unlock_ops(dev);
>  	}
>  
>  	list_for_each_entry(dp, &dst->ports, list) {
> @@ -149,10 +141,8 @@ static void dsa_conduit_get_ethtool_phy_stats(struct net_device *dev,
>  		if (count >= 0)
>  			phy_ethtool_get_stats(dev->phydev, stats, data);
>  	} else if (ops && ops->get_sset_count && ops->get_ethtool_phy_stats) {
> -		netdev_lock_ops(dev);
>  		count = ops->get_sset_count(dev, ETH_SS_PHY_STATS);
>  		ops->get_ethtool_phy_stats(dev, stats, data);
> -		netdev_unlock_ops(dev);
>  	}
>  
>  	if (count < 0)
> @@ -176,13 +166,11 @@ static int dsa_conduit_get_sset_count(struct net_device *dev, int sset)
>  	struct dsa_switch_tree *dst = cpu_dp->dst;
>  	int count = 0;
>  
> -	netdev_lock_ops(dev);
>  	if (sset == ETH_SS_PHY_STATS && dev->phydev &&
>  	    (!ops || !ops->get_ethtool_phy_stats))
>  		count = phy_ethtool_get_sset_count(dev->phydev);
>  	else if (ops && ops->get_sset_count)
>  		count = ops->get_sset_count(dev, sset);
> -	netdev_unlock_ops(dev);
>  
>  	if (count < 0)
>  		count = 0;
> @@ -239,7 +227,6 @@ static void dsa_conduit_get_strings(struct net_device *dev, u32 stringset,
>  	struct dsa_switch_tree *dst = cpu_dp->dst;
>  	int count, mcount = 0;
>  
> -	netdev_lock_ops(dev);
>  	if (stringset == ETH_SS_PHY_STATS && dev->phydev &&
>  	    !ops->get_ethtool_phy_stats) {
>  		mcount = phy_ethtool_get_sset_count(dev->phydev);
> @@ -253,7 +240,6 @@ static void dsa_conduit_get_strings(struct net_device *dev, u32 stringset,
>  			mcount = 0;
>  		ops->get_strings(dev, stringset, data);
>  	}
> -	netdev_unlock_ops(dev);
>  
>  	list_for_each_entry(dp, &dst->ports, list) {
>  		if (!dsa_port_is_dsa(dp) && !dsa_port_is_cpu(dp))


