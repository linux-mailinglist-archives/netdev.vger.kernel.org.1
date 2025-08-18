Return-Path: <netdev+bounces-214676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558B3B2AD9F
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 18:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E063B2C0F
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 15:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1E92E2283;
	Mon, 18 Aug 2025 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWgYJsUc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72942475CD
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532609; cv=none; b=QyHBSG+k8MPyM0S4IrYYZB206/RG6Z8am1CmQhGWaT9HCzjPRd8zpEzu1ryAc1VtgsFLKG8+iOoCF6nyrT7cYmp2BPdNJdgaGXZqHSdie/wI1bRntZC8n8QZxUwouV43QqVfkix9ECYxytT5WBIx+JdXRbUXwbl9mzn81ubs21c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532609; c=relaxed/simple;
	bh=XZfLczfgmcKZv3rnyhYCdADatiMRQCSZZgxbsdWLgzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHEq++s+Q1Z+MQKVenS8XZNjVnyH/w5c6DnhqY4SkxivumnWS6hnYAAy+qKM6GKFvSQMZPRaENHZ1nXF6/oSY7rSUMzVZnQ1mVoyC/0bbx5ox0bfkDT7iQWT+4G7kzsswOYu5Byf5sSk+bVBP9zs1yAAc76kfzqn/8h6xc0cs/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWgYJsUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6ABC4CEEB;
	Mon, 18 Aug 2025 15:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755532609;
	bh=XZfLczfgmcKZv3rnyhYCdADatiMRQCSZZgxbsdWLgzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rWgYJsUcZpypjGmQFr7amfSEmevQbbhCBVvUUbz5QQ+ora9BRKFKsh8DXO4xL63ht
	 NVtsuA7qamVbPH9hJbopi416Ca3lhdnRcCH80vhfaz+hwSOzww16SIp/nVUVyEdjoA
	 fOx5gbs7fEOeSAYKjJKrCK7gUthIYsaMpJY7+z2Vbf1vfd5WbQIXOphSJ0mW4IuNI3
	 xSxNbWxVU0xOTwMdw3V6/nNam2Sqpbc2EGNflJUyMrEbdo1oOrT+minCjtQteq95C7
	 RNgk68PlA16BzbDaoeHR4sYyfKJng+HCOnuokr73bHry1VcuLuzMzgVvg9H+Ov3/j9
	 R4WI3DhNMTXmQ==
Date: Mon, 18 Aug 2025 23:39:35 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [RFC] mdio demux multiplexer driver
Message-ID: <aKNJN4sBfi_YAjrF@xhacker>
References: <aJvjHrDM1U5_r1gq@xhacker>
 <5e3c5d70-f4fd-46db-90a1-e8be0ae5f750@lunn.ch>
 <aKAWe27bDtjBIkp-@xhacker>
 <2391ae0e-bfb2-4370-aac3-563fc5e70cf9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2391ae0e-bfb2-4370-aac3-563fc5e70cf9@lunn.ch>

On Sat, Aug 16, 2025 at 04:52:25PM +0200, Andrew Lunn wrote:
> > > So, why not KISS. Hard code the MMIO reg so MAC0 is connected to the
> > > PHYs, and MAC1 just uses a phy-handle pointing to the PHYs on MAC0s
> > > MDIO bus.
> > 
> > Previously, I went with this solution. But then I met an issue -- who
> > does the harcoding? bootloader or linux kernel?
> 
> Linux. The bootloader can do it as well, e.g. for TFTP booting, but
> Linux should not rely on the bootloader.

+1

> 
> > Linux? This is what this email thread ask for comment -- How does
> > linux model this?
> > 
> > Another issue is: the hardcoding maybe different on different boards.
> > E.g If only MAC1 is used, we need to hardcode the MMIO reg to let
> > MAC1 MDIO master own the single MDIO DATA and CLK line.
> 
> Both Ethernet and MDIO hardware exists, even if it is not used. I
> would separate the drivers. Have a MAC driver and an MDIO driver. List
> them as separate entities in DT. Always probe the MDIO0 driver. It can
> set the MUX registers. Don't probe MDIO1 driver. Even if it does
> probe, you know MDIO0 is one to be used, so MDIO1 can still set the
> MUX to point to MDIO0.
> 
> How messy is the address space? Are the MDIO registers in the middle
> of the MAC registers? Is this a standard, off the shelf MAC/MDIO IP?
> stmmac? Or something currently without a driver? If you are dealing

stmmac :(  And the MMIO reg doesn't sit together with MAC IP's.
As can be seen, the stmmac mdio registers sit in the middle of the
MAC regs. And current stmmac still tries to register a mdio driver for
the MDIO bus master. And to be honest, it's not the stmmac make things
messy, but the two MDIO masters sharing the single clk and data lines
makes the mess. Modeling the mmio as a demux seems a just so so but
not perfect solution.

> with a driver which already exists, it gets a bit messy.

