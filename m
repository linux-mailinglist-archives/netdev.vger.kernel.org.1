Return-Path: <netdev+bounces-121754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAC895E641
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 03:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1747F1F2103E
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 01:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F9F7E6;
	Mon, 26 Aug 2024 01:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WMc/mo2q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D11910A0D;
	Mon, 26 Aug 2024 01:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724635487; cv=none; b=R34XUiVhAXtnyIo7jomuJ+3Kh+8lM/+0dQnBER6MIUchd2lWI0E+tq9JeS5hiVUgFhrpNDqD1XLjjPJMtZWqENnf49em+N7rFnUjmsGTphJ9AldeZG7Ynvw/efJ2FnZwfaAQt6E8lMevmxQ1zN0uWxxGMedDrs7bz11ryJp5m5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724635487; c=relaxed/simple;
	bh=+zgtYQwHdj3mclsleZhbFWTZxfxk6lehfk2YWv6DqIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2rcN819px16ZndCSsrGGtrpInclMkXvQXRBblUQEKn4EyCE4VWPsxAm2YqQbje4DNlFMVMsL8Fn/bqcTZjOXvVEjMTV1PtAj2dNaRyEdxHNPjcvWC9RvdcND9GFRBfet2R/hGFcPM6yFlClqaGAOpFf0wt89YQKoqXoI1fxrA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WMc/mo2q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lwxHq6LHfc4IM7CfAbEnO0bIHUd1TlW881ZFY4sEziM=; b=WMc/mo2qTciYHDHWONwOh2FNAf
	DchjfaecmgL2WulUhR0Qvm1KZabwW/SNMof47/pRauto32i2XlKbHuIA8tJHa3W5wg6rpeyBTlIdj
	jooWBVZO3n7YCLq9/xWFOW2O9SIOHtXW2gLGCh2CSl3H7euV8wmxBDwa+LGYyILJkSHY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1siOTK-005f8w-Sk; Mon, 26 Aug 2024 03:24:42 +0200
Date: Mon, 26 Aug 2024 03:24:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, aliceryhl@google.com
Subject: Re: [PATCH net-next v7 6/6] net: phy: add Applied Micro QT2025 PHY
 driver
Message-ID: <b8023c02-df49-4bec-b525-cef9c55e1b89@lunn.ch>
References: <20240824020617.113828-1-fujita.tomonori@gmail.com>
 <20240824020617.113828-7-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824020617.113828-7-fujita.tomonori@gmail.com>

On Sat, Aug 24, 2024 at 02:06:16AM +0000, FUJITA Tomonori wrote:
61;7603;1c> This driver supports Applied Micro Circuits Corporation QT2025 PHY,
> based on a driver for Tehuti Networks TN40xx chips.
> 
> The original driver for TN40xx chips supports multiple PHY hardware
> (AMCC QT2025, TI TLK10232, Aqrate AQR105, and Marvell 88X3120,
> 88X3310, and MV88E2010). This driver is extracted from the original
> driver and modified to a PHY driver in Rust.
> 
> This has been tested with Edimax EN-9320SFP+ 10G network adapter.
> 
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

