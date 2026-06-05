Return-Path: <netdev+bounces-295901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wBgFD4UBI2prgQEAu9opvQ
	(envelope-from <netdev+bounces-295901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 19:04:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8FC649FF8
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 19:04:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=OurfKy3t;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295901-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295901-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92105300BC62
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 16:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C1B3B42E6;
	Fri,  5 Jun 2026 16:47:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42933B42EA
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 16:47:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780678031; cv=none; b=pFRZKDFN5Kq7AGCJFiIIFWxyjk+ct8BIfR976259G8RhvgXxkgyWH4Un6APY2ue93KqCpoV/j1c5Z6M3NZ6bjQMCu4x1CCM0BXC2chfuJlVj1PdgJ+LUp2LFTR33cOBau19BA1L/WqjbxWWuhWMI4afdw/aVs+z0Qbjy4G/XEh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780678031; c=relaxed/simple;
	bh=9ZQWCAriGC7//nhBAgyH4AqXGlpZlnaLsGPBr2HX8TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAC37o0LimLzpZ8yiAiHFewEy/jS0yXZymfhTwSwcDU4OQNaC4y61v2lZZid0cZKxA7V7RLxzbezOUnvlvTbekAxtQLMIugVdJ+d+ulocz94EvvsiQgtE7igVgz4y8HC69HCSfJhKuhf/zMCPYWRlynvShHF35gOdCjILZ+hPPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OurfKy3t; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7Yx0xoCSUnZFBwl5Y19RbiT9uE8MOdCxSvI7T6rLc28=; b=OurfKy3t7FAUTdEDf4uzqgBp3A
	RdSKDWsXmmQXLvvqI6hmX3eGQ5ffJ2yobieIBk1P9dxrYyh9jiVZsnNaYNarhH67X7dzQx9+iwVmH
	teL1dL9uGND/lPgjoiLvqCvmUrFPnMLl6TNahuqzOSyQ1k6S3UHANow2b1mAU9RSgSMI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVXhG-006GRh-IR; Fri, 05 Jun 2026 18:47:02 +0200
Date: Fri, 5 Jun 2026 18:47:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2 3/3] net: txgbe: initialize PHY interface to 0
Message-ID: <06157cab-2201-4707-804c-c915e3c4a901@lunn.ch>
References: <20260605030850.17796-1-jiawenwu@trustnetic.com>
 <20260605030850.17796-4-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605030850.17796-4-jiawenwu@trustnetic.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295901-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jiawenwu@trustnetic.com,m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F8FC649FF8

On Fri, Jun 05, 2026 at 11:08:50AM +0800, Jiawen Wu wrote:
> DECLARE_PHY_INTERFACE_MASK() does not guarantee zeroed contents. Change
> the stack variable "interfaces" to be zeroed before setting supported
> interfaces.
> 
> Fixes: 57d39faed4c9 ("net: txgbe: improve functions of AML 40G devices")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> index bdac654a2364..d73295d26b85 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> @@ -270,8 +270,8 @@ static int txgbe_sfp_to_linkmodes(struct wx *wx, struct txgbe_sff_id *id)
>  
>  static int txgbe_qsfp_to_linkmodes(struct wx *wx, struct txgbe_sff_id *id)
>  {
> +	unsigned long interfaces[PHY_INTERFACE_MODE_MAX] = {};
>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(modes) = { 0, };
> -	DECLARE_PHY_INTERFACE_MASK(interfaces);

This is not what i was meaning. Please add something like

DECLARE_PHY_INTERFACE_MASK_ZEROED(name)

where the = {0} is inside the macro. If this is next to the
DECLARE_PHY_INTERFACE_MASK() macro, it is less likely other developers
will make the same error as you have in your code.

    Andrew

---
pw-bot: cr

