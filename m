Return-Path: <netdev+bounces-262697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHfXOM+tpWleEQAAu9opvQ
	(envelope-from <netdev+bounces-262697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 16:33:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 485FE1DBE91
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 16:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D96EC3006943
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 15:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B53C41162C;
	Mon,  2 Mar 2026 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wS5/9DLI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B2B41160D;
	Mon,  2 Mar 2026 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465291; cv=none; b=pw2mwwAEZV+jceIvY4BbpAq9oOLyKbbxaDE8L6fakcju+pzXh5pPaiprLg5LorcoPqci2qmxdex7Rz9QZ5CZNtlqUR2hKojz/pVyw+BTxBnZKPuqcAepCtVGpbjfvWxnRNfH+2+rl7cGo6MeAajM/cY9bpSolzQo2iz3SUTX9/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465291; c=relaxed/simple;
	bh=rTMw7u+iOmgiZazdCS4vGhH8muOLS/mVowMwcxnOkmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXFbRpNQjPEO9FxDMyfi1UCLXs9VMaELzBdRTLpN48+FdzT2F3N6+oyF6pCwzIPaZMMhlaRqLjpM7dqVXBb8mR2+7xng5X8pjHPvW43aKmf93c0+lq8Zb5nKsc/iK2oZpuKxJwfUn4QS4xx7VsmVoG3nJ+/v0gR4xLqjZfZZ5Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wS5/9DLI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BgzFp2k4lD4rMKmZwfbbxdA75cxRC6aphPEV27AVhRw=; b=wS5/9DLIB3NH1QI34/6KB5wWFF
	vj8QnPDKG1ptOTUGGzOXuiTh5cilouM0OYxjAwhsXq318XraewjNcfUOcxofr1POO95pVBMpHvMfC
	/tRowBzuwCBr2du8j85W6pFOabAfOzbaiKFYSon7gFF7MKqMloO6y2iWQsS423DgupG8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vx5Bd-009hBT-R1; Mon, 02 Mar 2026 16:27:57 +0100
Date: Mon, 2 Mar 2026 16:27:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: sdimitropoulos@coreweave.com
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mdio: add fwnode compatible matching to
 mdio_bus_match()
Message-ID: <820a4180-fd3b-485a-bed1-df74c30c6858@lunn.ch>
References: <20260302-mdio-fwnode-match-v1-1-ac542b7c53a3@coreweave.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-mdio-fwnode-match-v1-1-ac542b7c53a3@coreweave.com>
X-Rspamd-Queue-Id: 485FE1DBE91
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262697-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:mid,coreweave.com:email]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 10:10:59AM -0500, Serapheim Dimitropoulos via B4 Relay wrote:
> From: Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>
> 
> The MDIO bus match function currently only supports Device Tree
> (of_driver_match_device) and PHY-ID-based matching (bus_match callback).
> This means MDIO drivers that rely on compatible-string matching, such as
> the mv88e6xxx DSA switch driver, cannot bind on systems that describe
> hardware topology via firmware nodes (fwnode/software nodes) rather than
> Device Tree.
> 
> This is a problem for x86/ACPI platforms where MDIO buses are created
> dynamically (e.g., USB-to-MDIO bridges) and have no Device Tree
> representation. On these systems, kernel modules or ACPI tables can
> describe the MDIO device topology using software nodes with a
> "compatible" property, but mdio_bus_match() never checks it.
> 
> Add a fallback matching path that iterates the driver's of_match_table
> and checks each compatible string against the device's fwnode using the
> existing device_is_compatible() helper. This is placed after the OF
> match (which handles DT natively) and before the bus_match callback
> (which handles PHY-ID matching), so existing match behavior is
> unchanged.
> 
> This enables DSA switch drivers like mv88e6xxx to bind on x86 systems
> where the switch topology is described via software nodes or ACPI,
> closing a gap in MDIO bus support for non-DT platforms.

Please make this patch part of a full series adding support for your
board. I presume you have something in drivers/platform? Or maybe
drivers/net/usb or drivers/net/mdio? I would like to see how this is
used.

I should also not that mv88e6xxx supports platform data. That is how
the x86 platforms i've seen do it.

    Andrew

---
pw-bot: cr


