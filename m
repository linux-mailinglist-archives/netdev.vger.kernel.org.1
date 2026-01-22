Return-Path: <netdev+bounces-252423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGBoKMhYcmkpiwAAu9opvQ
	(envelope-from <netdev+bounces-252423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:05:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5766AB85
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 744FA30387C0
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328FF367F2A;
	Thu, 22 Jan 2026 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0XGPstaG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8582A280335;
	Thu, 22 Jan 2026 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097798; cv=none; b=fXpqIamU9Yy9EUbzdNRnFuKzen0OIL+J4UVto/NcV05rwrRC2qvsZC09vuu2DNQRAPGoaCMgAy//56gpvWWPAiGiMKizC1SCphoP3bfMwKfe5FLnh7s70+W/uN2F5Kli/TM45Q66LkkXag57aWDMh/2l4uvkMw3bD6OzzVqSI0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097798; c=relaxed/simple;
	bh=gBvQ60GKc7I9V/a3CO+WvejVjWR6BZA+gRiNMOaIiI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ykgn5Ivmwczf4UXFl+NRnH0NV7KVF2NZ/pZwWnAsjjtWyEnN4A0VsSrOqYchXqS8bqmcTUW0E7xtBdjokWszhDpiPzrmI44y9zW9+4i4FcPHsm1sVkEndjphqV8Hwo78ikO2Hus5hZHrZrwf+o71ud8/MfQ7NEqfwbV4A+DXkKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0XGPstaG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GKZNUPjuUcl3IiH9k6+6nqxg1HkcAU/xUmRgMsq4Sgk=; b=0XGPstaGKvgp6pakaMES7f0WAJ
	+9zfLPL944OOtUXCK1x7qXcdrXb+t3DXPH37LZqZEgHPihvNeS2zTOyp9jMkIIwGOeAwzkKjw31jn
	sqeFFSUdCVqvcNvGoRD1ua81TO7IinO/BH5Sd4Nz1gbOVY2vkRZ8Pp/0FpFUGzMkm54p9OdeMBtiY
	5RSK1z4FO1Ac3suhOa/iGzR4/mcIaH1XDW/4lPQ2HKy6PxkGXmM6Atzd/X5qP55Kmu1wwlSfacZsG
	YonhOxnvDHzt0VGLVp07pXX6WVdj5ovCebu5eWRnqblzHAmyUlEj3Fu27s7YeD6pXcYkTeQRw71z8
	ToTt42jw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51058)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vix9F-000000000dd-31Mk;
	Thu, 22 Jan 2026 16:03:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vix9A-0000000017C-2p65;
	Thu, 22 Jan 2026 16:03:00 +0000
Date: Thu, 22 Jan 2026 16:03:00 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: =?utf-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: Bo Gan <ganboing@gmail.com>, devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: Re: [PATCH v1 1/2] dt-bindings: ethernet: eswin: add clock
 sampling control
Message-ID: <aXJKNBAifG6qv80M@shell.armlinux.org.uk>
References: <20260109080601.1262-1-lizhi2@eswincomputing.com>
 <20260109080859.1285-1-lizhi2@eswincomputing.com>
 <00b7b42f-2f9d-402a-82f0-21641ea894a1@lunn.ch>
 <aWKZvEW7rKFFwZLG@shell.armlinux.org.uk>
 <0d54ddca-9270-40a5-aa82-d8a7b65027ff@gmail.com>
 <1a622916.2d28.19bb105feab.Coremail.lizhi2@eswincomputing.com>
 <d010a6b8-5bf0-40ff-8e76-18362a238d50@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d010a6b8-5bf0-40ff-8e76-18362a238d50@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252423-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,foss.st.com,st-md-mailman.stormreply.com,lists.infradead.org,eswincomputing.com,einfochips.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,shell.armlinux.org.uk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A5766AB85
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 02:27:34PM +0100, Andrew Lunn wrote:
> > We also intend
> > to upstream complete DTS files for EIC7700 so the bindings can be validated
> > against real hardware.
> 
> I suggest you prioritise this. ARM-SOC is pretty flexible for
> accepting work in progress support for new SoCs. All you really need
> is for the board to boot to a login prompt on a serial port using an
> initramsfs. So the .dtsi and .dts file can be very slim, CPUs, memory
> and UARTs.
> 
> Once you have that merged you can work on the other drivers, their
> bindings, etc.
> 
> As Russell pointed out, at the moment, most of the code you have in
> the kernel is unusable, so it is a candidate for being thrown out.

Indeed, and we've had drivers merged before for platforms that never
made it in, and they just hang around for decades, adding to the
maintainer's burden for no benefit what so ever.

So please, no more drivers for EIC7700 until there is functional
support for the platform, as Andrew states.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

