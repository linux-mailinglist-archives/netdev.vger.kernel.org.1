Return-Path: <netdev+bounces-289679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cUtrH+QJDWrysQUAu9opvQ
	(envelope-from <netdev+bounces-289679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:09:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3EE58677A
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC07B30107D5
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F4E2BD5B9;
	Wed, 20 May 2026 01:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ycnqpPts"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5473A2652B0
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 01:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779239393; cv=none; b=uzNXQmAzNGw2XoX18yAB6Joc/7BQBnZDytkODdjXOneUgR+hNEwm0xO1/JdQSox6hS40qgQYIUC+HIFyR8JT4zFOCF4QIWpQygb2crEacBl3cI3clRPLfyoLZvY1NICq/C9+MNdy4dgmap4qAgVZqwzfFsTzgmkLsLrJF7JD3mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779239393; c=relaxed/simple;
	bh=vaA+O6NNDw7rBBn35yIdxuzZbafQZI65CCh1ntUiqmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCMgnDWuxtt4Smue9YjmGfcVO5JiiYi6DBfVKggOCWjqOxHeTEEP4imGeXEXFLSq8FCRDp/cZEhX6Wa8IS5EEFNNOPodJynzzukuy5ZEecl+UGfmMKil/BiQuyg4LDNZKJKx4zNcSllBWfOfWzrzn9xcBXVD/a3hS2xZW/qcUQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ycnqpPts; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FTUaKu7hqlhjrHB9IMLzsE0a0hVpZmFonyggDQ+3VXg=; b=ycnqpPtsvapjQkOdrINC9+jnsw
	JmTMC/Zh/BhbVvCzZk/eyYC4umCpu4Ut8F9QeWnP2HAGUCFGCNPcpZr3RgUruzXcWILunzkLgAYH7
	lO/EeVuNnBO3PyEfLhKCLD/W+BEM3xx28jgdOPGxgXfNAC8BQvHSupNXrHfG92e9PIhg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPVRC-003kqQ-2L; Wed, 20 May 2026 03:09:30 +0200
Date: Wed, 20 May 2026 03:09:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz
Subject: Re: [PATCH 3/9] net: mdio: realtek-rtl9300: Add ports to info
 structure
Message-ID: <82214c5e-23d5-4615-b2ae-81985fb573f8@lunn.ch>
References: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
 <20260519165747.1288903-4-markus.stockhausen@gmx.de>
 <agydm8V25M-jy5o6@makrotopia.org>
 <85d5f162-8999-43d4-b879-6e5e686246f7@lunn.ch>
 <01d801dce7c2$a0a08ba0$e1e1a2e0$@gmx.de>
 <fff19211-a41a-481d-a6a6-4429a6901129@lunn.ch>
 <agzoaMnmeVpjiFC0@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agzoaMnmeVpjiFC0@makrotopia.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz];
	TAGGED_FROM(0.00)[bounces-289679-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: CB3EE58677A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> The problem is that the hardware doesn't let you access the MDIO
> busses directly -- you *have to* setup a mapping and then access each
> PHY using the mapped port index. Also hardware PHY polling *has* to be
> used to configure the MAC as there is no (known) way to directly
> configure most of the MACs (but only a small number which is typically
> used for SFPs), so setting up the mapping also for that is mandatory
> and cannot be avoided.
> 
> The driver does it's best to present MDIO busses with the PHYs available
> with their actual (ie. as on the hardware) addresses 0-31 towards Linux,
> so PHY drivers, packages or even userland tools all work as expected.
> But internally it will have to setup this mapping port->(bus, phy), and
> then reverse-resolve each (bus, phy)->port.

Do any of these MDIO busses appear on the outside? Somewhere i can
connect an external PHY, or another switch in cascade?

	Andrew

