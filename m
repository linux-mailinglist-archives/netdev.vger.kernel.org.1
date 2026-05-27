Return-Path: <netdev+bounces-292304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCxOMkT0Fmo6ygcAu9opvQ
	(envelope-from <netdev+bounces-292304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:40:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F975E52FA
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC41E3008D0C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 13:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469B130C171;
	Wed, 27 May 2026 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aXss1Vx7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52B93FD14F
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888939; cv=none; b=uz3aAkS+STaoLX8rKnpRvKP51//KoRt/kIE5PFWxRKso7konEnXFaG5Lv6+eskiwFHAzpuDItIvBYMEsCHyyeHTMtI71h8PBk9zelHPbMCg5z3FrKc3jUYvb4CBNtIUZNfKabDK6EIs6EdvJls8qGnY3vkCVEGn9QXvtq6YBPWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888939; c=relaxed/simple;
	bh=BlXHFRZYrWKydKNVC6LtW/fFHh/v4i9ECQF0MGnYZlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0IiTE5e0Q/e/qshzMM+/EmcAF1cfek7P8zJzPaJniQxTRE7XxLCYqhJCMbYqfomfhsAopoTgQPqpetgGnGKn1cM+k4wuzKj8+Shf7wALyQ2QkyxcD9ypJZELnjbDlDVLmrLIjaEnFfyS5kEbdNJKkMyIeqX2CF3XYlBF/RSnCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aXss1Vx7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+0+xv48AwBHVdWtFyRfOuyF+vN2kA2JFjvwPtDj6RKs=; b=aXss1Vx7UdioGIB5S5w/V4ruTN
	zCyi46/jcwT0Ae9XQWiSMCKCELh9v1865FK1MTiQsDoUOF8rS7oiRLUI563Am7QvsIiCeZw3vHQ3q
	XB9A6HwfCoKtlveO2yOgN2WbWhAy1zjk/GKeFhZ89JZkGPqSEI39G4IN/POnyCgalXKM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSEQ2-004kjC-1s; Wed, 27 May 2026 15:35:34 +0200
Date: Wed, 27 May 2026 15:35:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Walle <mwalle@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Subject: Re: phylink and an unusual PHY/SFP setup
Message-ID: <061815ee-e95e-4723-aa2a-d84bc3ad6233@lunn.ch>
References: <DITB8QZ1OEQF.327XUI9E0SXQ3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DITB8QZ1OEQF.327XUI9E0SXQ3@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TAGGED_FROM(0.00)[bounces-292304-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 09F975E52FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 10:19:18AM +0200, Michael Walle wrote:
> Hi,
> 
> I have a board with a rather unusual network link setup:
> 
>  MAC/PCS (fman) <-SerDes-> PHY (M88E1112) <-SerDes-> SFP
> 
> or even
> 
>  MAC/PCS (fman) <-SerDes-> PHY (M88E1112) <-SerDes-> Copper SFP with PHY

Such setups do exist already, but with a different PHY. The Marvel 10G
PHY is sometimes placed in the middle like this. And there are other
PHYs.

Take a look at

commit 35d1a5464b476aa98b7b76ce41bb4de748cebfc2
Author: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date:   Thu Jan 8 09:00:35 2026 +0100

    net: phy: marvell10g: Support SFP through phy_port
    
    Convert the Marvell10G driver to use the generic SFP handling, through a
    dedicated .attach_port() handler to populate the port's supported
    interfaces.
    
    As the 88x3310 supports multiple MDI, the .attach_port() logic handles
    both SFP attach with 10GBaseR support, and support for the "regular"
    port that usually is a BaseT port.

Also, marvell-88x2222.c.

	Andrew

