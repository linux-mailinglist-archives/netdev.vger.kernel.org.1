Return-Path: <netdev+bounces-224473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEA8B8563B
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B5D1885633
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBF530DD39;
	Thu, 18 Sep 2025 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7+2GrJ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEC9243371;
	Thu, 18 Sep 2025 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207414; cv=none; b=Ot4IiVKP+Q3A9AEr07GMb74XLkqU2TWTed3hJ+r1wsXFW4UQuovX1gkPiYwbmI1Fe4HHixQNgsF/GL+brxnr6CTJA9vX3Aay5G9+SEpdmJ0GJTcLcf/tToa+6570RCqZ8nHIowDW07j7fI8Qf61gAzknaMBzirJnbKF7lL1CYFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207414; c=relaxed/simple;
	bh=8z/tnlGfcj0sHQpOOZSE8H5bYHm1R8zUOzpIG2oOSfg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OFTTUcglpedj50a+9PUSy6KtpJnmC2VYfFUSTzwsWPy2eqkgO0t9zjRaSl34TYrHMS9OfZEBbnGVImYzAV2+aZtmjrYi+eqpSp6GsFhw/NjWYeKWNNYuYwItSxqguaiEkfIaKBh4s4fawuZJNJqNPtqxEYQzNggU6cNeuYrP0oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7+2GrJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BDEC4CEFB;
	Thu, 18 Sep 2025 14:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758207413;
	bh=8z/tnlGfcj0sHQpOOZSE8H5bYHm1R8zUOzpIG2oOSfg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h7+2GrJ5h0nqFlRgGXJwT26ITp3PxhHXrt3EGfeGOqP5YDX3SVSQh8PEB2qLOI5tJ
	 JBIwLZgQU1DGIo1fwCTth+CbWPgZbpIJMfmGbMc2vQdbq+EjAF4u1miD0epVR7Nim7
	 X0xePlTmXNuxHjExwOAWwTLN6+B9Z6rO4ELnD0LrEzJZV5HmtQT1z4EZAmkRfBdmOO
	 QK2LdSFGjs9AyFaqvS/J9EDly4ZcMbiAVws363DKd8VrM9L0OlUjLDV0li80LpYeSg
	 3W+pRt9P0Nb8Mv99ihsuKFX2wMHXUtptqm1VINoC4m3yfiheX0cFX31pQNH8+tQ/k5
	 yQThWQhvXOwuw==
Date: Thu, 18 Sep 2025 07:56:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Michael Walle <mwalle@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Andrew Lunn <andrew@lunn.ch>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo
 <kristo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Roger Quadros <rogerq@kernel.org>, Simon Horman
 <horms@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH net-next] Revert "net: ethernet: ti: am65-cpsw: fixup
 PHY mode for fixed RGMII TX delay"
Message-ID: <20250918075651.4676f808@kernel.org>
In-Reply-To: <804f394db1151f1fb1f19739d5347b38a3930e8a.camel@ew.tq-group.com>
References: <20250728064938.275304-1-mwalle@kernel.org>
	<57823bd1-265c-4d01-92d9-9019a2635301@lunn.ch>
	<DBOD5ICCVSL1.23R4QZPSFPVSM@kernel.org>
	<d9b845498712e2372967e40e9e7b49ddb1f864c1.camel@ew.tq-group.com>
	<DBOEPHG2V5WY.Q47MW1V5ZJZE@kernel.org>
	<2269f445fb233a55e63460351ab983cf3a6a2ed6.camel@ew.tq-group.com>
	<88972e3aa99d7b9f4dd1967fbb445892829a9b47.camel@ew.tq-group.com>
	<84588371-ddae-453e-8de9-2527c5e15740@lunn.ch>
	<47b0406f-7980-422e-b63b-cc0f37d86b18@ti.com>
	<DBTGZGPLGJBX.32VALG3IRURBQ@kernel.org>
	<804f394db1151f1fb1f19739d5347b38a3930e8a.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 04 Aug 2025 15:45:08 +0200 Matthias Schiffer wrote:
> > > Disabling the TX delay may or may not result in an operational system.
> > > This holds true for all SoCs with various CPSW instances that are
> > > programmed by the am65-cpsw-nuss.c driver along with the phy-gmii-sel.c
> > > driver.  
> > 
> > In that case u-boot shall be fixed, soon. And to workaround older
> > u-boot versions, linux shall always enable that delay, like Andrew
> > proposed.  
> 
> I can submit my patch for U-Boot some time this week, probably tomorrow. Do you
> also want me to take care of the Linux side for enabling the MAC delay?

What's the conclusion with this regression?
If we need a fix in Linux it'd be great to have it before v6.17 is cut.

