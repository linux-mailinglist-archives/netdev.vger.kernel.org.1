Return-Path: <netdev+bounces-254878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMrVBZCce2nOGAIAu9opvQ
	(envelope-from <netdev+bounces-254878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:44:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3649FB3298
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1B813002B55
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90DC354AD9;
	Thu, 29 Jan 2026 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="moE76XG2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7DD354AC9
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708683; cv=none; b=B+q05OaG+fLIDjrA1a9YAeKOhdyBCzrAWqjsvS9Wng0xumAz0eEadKOJkvJa1ku7pNFC1obKKHZR/Nl78rnPEnQ85y6vcH10ytquqQwi13IUBI1FmaUkhXMHm9ekY0PPSzfWRl/AVD0fP1nF/RX8Ais0RxfQ4NI6sVX+SCDRRN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708683; c=relaxed/simple;
	bh=1+yQiRijDdm1QZosP5rFhGcbIIRhuWsDvRE957w2xqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAxAXffPxheMW/sDozRYG/2R6UZPUTd8NBE8jgEo4zb+ybho6WJWsTj8xfoh+J73LJas9EWWdcIiqfK0hqbJunQ/biNWuhOLdjDtRC5PXKZfvY+xlmfdRbrSO0OBr16PfPEXILmkhALTRzFlHaVBAt6qqSceTwg7ARCq/lT5XEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=moE76XG2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=y9D1drPigF3GBERuSadntJ/K8x+G3Qy3gQC2QgkpIHs=; b=moE76XG27gjdd+QZotxLBinDqt
	gFbktZYq47ZTWoMjGx+m+Dg9bIS5tKLfWmJV5Mv4HnHgXeM/cnU58XsyzJN6gRyU+un9/uM1jhVqN
	0WS+7eBSi6VrH7uGLvxWDiNyg5AtYZDyVEEOgovEWK+H9Aq0xG4ZvCug0jW+4o5fGXTI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vlW4H-005OhC-8x; Thu, 29 Jan 2026 18:44:33 +0100
Date: Thu, 29 Jan 2026 18:44:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	dan.carpenter@linaro.org, horms@kernel.org, pmenzel@molgen.mpg.de
Subject: Re: [PATCH iwl-next] ixgbe: e610: remove redundant assignment
Message-ID: <60e6bfa6-4267-4d33-9987-24b87c0d0091@lunn.ch>
References: <20260129175455.174241-1-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129175455.174241-1-piotr.kwapulinski@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254878-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3649FB3298
X-Rspamd-Action: no action

>  	/* Read sync Admin Command response */
> -	if ((hicr & IXGBE_PF_HICR_SV)) {
> -		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
> +	if ((hicr & IXGBE_PF_HICR_SV))
> +		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
>  			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
> -			raw_desc[i] = raw_desc[i];

Did you look through the history? When i see code like this it makes
me want to have an understanding why it exists, since it looks so odd.

Is it a merge conflict resolution gone bad? Is it a typo and there is
a cooked_desc[i] which could be set?

>  	/* Read async Admin Command response */
> -	if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
> -		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
> +	if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C))
> +		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
>  			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
> -			raw_desc[i] = raw_desc[i];

and it exists twice. Which makes it even odder....

    Andrew

