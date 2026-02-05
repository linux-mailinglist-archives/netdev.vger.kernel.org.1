Return-Path: <netdev+bounces-257300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDd6EDP9hGl47QMAu9opvQ
	(envelope-from <netdev+bounces-257300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 21:27:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A33CCF7217
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 21:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F24BA3023E09
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 20:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12FF32C924;
	Thu,  5 Feb 2026 20:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A7kMgie1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0816B86353
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770323238; cv=none; b=pXKNPTTkZDPdNJYXYTQ5p+IA9AJaM2APnxjqntFH8ZS1YY+1bhSiU3jj0eg14+eQHlc7DANzSpws//l15k8Hgix4A72pBtk1HVnrxXtcBMXlolfTGDbvE5ZOTCLafLibvBfoWMkakeYHjRpQP1Hd/B/0e8paXdvAKXJffrtzO9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770323238; c=relaxed/simple;
	bh=I0IHd4S7QajLDAhLSaWeccoK7pbT2TRd+HbpqIWUqpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMIL47I+touVZw7T5cRyWBLZUYO/lxe8JDoGVaeGWoImjNL6moBTVas55vfA9Ie6Y3V8vkbw3IoRD4CZ9TEAjjXs27h9jeHiYCoxx0agY+XN4VnZzbCQ3ZxZoRm88U6pev4+Yw5UEDH6ASPaOIM4Odu88zGCwwxkCv0OAjDpyvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=A7kMgie1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vmFlqkIkNu6xvUvAqEBq231tObXuQzPEymlXsN9NeUA=; b=A7kMgie1OeBmxHx9znE47EBgVz
	E6Z1ET2DAGRgWJnDTIDeXAKmrDR9Q5RNUYKb3AIt0X2MqwfJfvpp0wfJwO2sdjKS8h8paQLyx9Bhk
	y9CTtWgDbWTtiMh0lrZJaFtNJ4JUOyMAgSgIopsnQ/6kE5rtVmpg6iJ1J4Qq4H569JSM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vo5HK-006Hey-3K; Thu, 05 Feb 2026 20:44:38 +0100
Date: Thu, 5 Feb 2026 20:44:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next] net: stmmac: add documentation about clocks
Message-ID: <0ddd8a12-2c24-4730-9cf3-893ad4db0c6a@lunn.ch>
References: <E1vo47h-00000007l0I-3rzN@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vo47h-00000007l0I-3rzN@rmk-PC.armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257300-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A33CCF7217
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 06:30:37PM +0000, Russell King (Oracle) wrote:
> Add documentation covering stmmac_clk, pclk, clk_ptp_ref and clk_tx_i
> in the hope that this will help understand what each of these clocks
> are for.
> 
> There is confusion around stmmac_clk and pclk which can't be easily
> resolved today as the Imagination Technologies Pistachio board that
> pclk was introduced for has no public documentation and is likely now
> obsolete. So the origins of pclk are lost to the winds of time.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> 
> Is this worth documenting, despite the vagueness of stmmac_clk vs pclk?
> Too verbose? Or not sufficient information? What do people think?

I think it is worth documenting.

I also wounder how many DT authors will look here, and be able to
translate the named used here to what snps,dwmac.yaml has:

  clock-names:
    minItems: 1
    maxItems: 10
    additionalItems: true
    contains:
      enum:
        - stmmaceth
        - pclk
        - ptp_ref

Maybe it is worth repeating this as comments here?

      Andrew

