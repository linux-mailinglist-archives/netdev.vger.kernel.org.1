Return-Path: <netdev+bounces-287952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGpYA1vCBWpMbAIAu9opvQ
	(envelope-from <netdev+bounces-287952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:38:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3A6541C2C
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7ED58300B5A7
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E39738F248;
	Thu, 14 May 2026 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QjmHFawb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0C2371CEA;
	Thu, 14 May 2026 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762328; cv=none; b=FJ/t3zXiXm2yWi64sUD5ukJ3sl/HJt93VAN2Wpaw/AUnIpzhhSmPtdRkQqLEras+NiFq9apPdZEwbSOeTGhiCVbKs0u5+ByTQ2fGrMuGSgElbJlXjtWugndNh1MBEfoNSc5wEg8gU3JY8xv47YajBce7AlQ4XQHslqqECdUD9b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762328; c=relaxed/simple;
	bh=zWmVSuOgrFx51FDZzQojiSgITlx5YgwbIqfqoUYMURo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hE4H7gt3CqR64u6jZF0wYer7YBOsL0rNslEvulDhhkccRQ0HpOhYvdeTtqitrtTT6xnFs2ILDYH0IaUOX4W+dlDphdHBzdVtG+shvaavML+Sn2+ngnKkRbDWtyx99G/XnRtEq4+nrjSz5WCX1CHZ77cvgv4y0sV8cUPlLcl1ytE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QjmHFawb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2xEwYBD7GagzT6CruFdf67vbh8/JqmRvWZaxxBCLXcM=; b=QjmHFawb31++YGJsLD0zsFiwDd
	eBTn/aXlLC9pcwy2PdPfMTQ+sTyuSBB6ZPMbsMR2KZ/dPfe1isbiQ5sNtog6jYH4trrvCG9+0UExX
	ZeZAu8swYAzTqXB88o5FdoJyaLE4YbrTzFG71gUuspZIk/apxGBsx0rf3RFbSqG2RMJA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNVKm-002u5P-Fu; Thu, 14 May 2026 14:38:36 +0200
Date: Thu, 14 May 2026 14:38:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
	linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] net: lan743x: rename is_sgmii_en to is_pcs_en
Message-ID: <d67d44a7-26c3-48ec-aaf2-9b6dd73bfa83@lunn.ch>
References: <20260514105028.42942-1-thangaraj.s@microchip.com>
 <20260514105028.42942-2-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514105028.42942-2-thangaraj.s@microchip.com>
X-Rspamd-Queue-Id: 8F3A6541C2C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287952-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 04:20:24PM +0530, Thangaraj Samynathan wrote:
> The flag is_sgmii_en indicates whether the PCS interface is enabled.
> However, the name implies that the interface is strictly SGMII, which is
> misleading.
> 
> Rename the variable to is_pcs_en to better reflect that the flag
> represents the PCS enable state rather than a specific interface mode.
> Update all references and logs accordingly (but keep device registers
> unchanged to match its documentation).

So the documentation is also broken?

Can you get the documentation fixes, and then replace all references
of SGMII to PCS?

> -	if (adapter->is_pci11x1x && adapter->is_sgmii_en)
> +	if (adapter->is_pci11x1x && adapter->is_pcs_en)
>  		adapter->phy_interface = PHY_INTERFACE_MODE_SGMII;

Maybe this is in a later patch in this series, but i assume
PHY_INTERFACE_MODE_1000BASEX is also a potential mode?

	Andrew

