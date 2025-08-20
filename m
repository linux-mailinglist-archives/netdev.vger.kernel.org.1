Return-Path: <netdev+bounces-215329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57601B2E1F0
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 18:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4251AA235EE
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 16:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8D7322A3C;
	Wed, 20 Aug 2025 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5mM/18M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9873E322C64
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755705727; cv=none; b=IwWrZRFPDJaitmj0OoYqUsE7GQhp0PtGEFhBSlOr8oS5dG4LGvCmOarIaVMbBQgCW150JhU4hFJJxnxneWcohQGHhNztYodZgTNB7m5Wl1hIwo7WQ2lT6DibWSNU3CL5Lq4fpGf2O66S2DO/SdHSj7KQYzs4DG930ajHUPXMooA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755705727; c=relaxed/simple;
	bh=v4F0O43hZvhSnre0pnLX16lkNOu42kuiMbGN3lmamkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPmBSzdEPSQLHDPDL46HUtVsn1u3mRULk3VE9LuvmNKHv7XdpASPiWZnAR2IMv8Z/RghXsRVFUhUj/kyNKd5SjWy7zeeaFm6fGUfiuobJDiHgQkOxMMWjkSiGVY5Ws0ve2/ngYxiuI7pwR7XXGb65Mc7KD/ZEWfZLtFVzcM7dZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5mM/18M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901E2C4CEE7;
	Wed, 20 Aug 2025 16:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755705727;
	bh=v4F0O43hZvhSnre0pnLX16lkNOu42kuiMbGN3lmamkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5mM/18Mp98gWAckPMwQTxjeBHcTsKQUyx+I9kQr5eTXOSZZIsoDIZN/gEsf5uOzF
	 wuAPHzegwvmVi2hrsL9tl3TM6X48B6o/zE8yM4QzzY95B8IJPjOuT5C6L3+W2niy5y
	 k8Uysg6p87k2M+eGNjqXA//Ri9iwmBLGh+0oezxt+dY5ImqWihAxe+ahd3G1djFyup
	 v9kAtCSzlniPm3nBk3dXTF+bkAqEJOu07PWdzJ7X8u0UmA8AOvB2XFFBUz8mxhXfBf
	 V3pgvIbRDb8c0GceVWJl6bGfTXXhh+SxVYYQu4yo/SwQgDaNxd83Eq4DkzOjWpl7fS
	 ZKs2y31CQvgVw==
Date: Wed, 20 Aug 2025 23:44:51 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>
Cc: Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [RFC] mdio demux multiplexer driver
Message-ID: <aKXtcw1G3-TQTf2r@xhacker>
References: <aJvjHrDM1U5_r1gq@xhacker>
 <5e3c5d70-f4fd-46db-90a1-e8be0ae5f750@lunn.ch>
 <aKAWe27bDtjBIkp-@xhacker>
 <2391ae0e-bfb2-4370-aac3-563fc5e70cf9@lunn.ch>
 <aKNJN4sBfi_YAjrF@xhacker>
 <c40dd405-9549-40c9-8cfd-88dd0b1342da@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c40dd405-9549-40c9-8cfd-88dd0b1342da@lunn.ch>

On Mon, Aug 18, 2025 at 06:27:33PM +0200, Andrew Lunn wrote:
> > > Both Ethernet and MDIO hardware exists, even if it is not used. I
> > > would separate the drivers. Have a MAC driver and an MDIO driver. List
> > > them as separate entities in DT. Always probe the MDIO0 driver. It can
> > > set the MUX registers. Don't probe MDIO1 driver. Even if it does
> > > probe, you know MDIO0 is one to be used, so MDIO1 can still set the
> > > MUX to point to MDIO0.
> > > 
> > > How messy is the address space? Are the MDIO registers in the middle
> > > of the MAC registers? Is this a standard, off the shelf MAC/MDIO IP?
> > > stmmac? Or something currently without a driver? If you are dealing
> > 
> > stmmac :(  And the MMIO reg doesn't sit together with MAC IP's.
> > As can be seen, the stmmac mdio registers sit in the middle of the
> > MAC regs. And current stmmac still tries to register a mdio driver for
> > the MDIO bus master. And to be honest, it's not the stmmac make things
> > messy, but the two MDIO masters sharing the single clk and data lines
> > makes the mess. Modeling the mmio as a demux seems a just so so but
> > not perfect solution.
> 
> So you only really have problems when MAC0 is not used. Are there any
> boards actually designed that way? If there are no such boards at the
> moment, you can delay handling that until later.
> 
> When later arrives, i would probably look at refactoring the stmmac
> MDIO code into a library. The stmmac driver can use the library, and
> you can add a new MDIO only driver around the library for when MAC0 is
> not used, but you need the MDIO bus.
> 
> For the moment, you can add setting the MUX register in the stmmac
> glue driver.

Hi Andrew, Russell

Thanks a lot for your useful inputs. I will check again and try the
demux and compare it with different solutions.

Thanks a lot!

