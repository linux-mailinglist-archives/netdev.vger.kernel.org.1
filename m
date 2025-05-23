Return-Path: <netdev+bounces-193115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0428AC28DC
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 19:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B041893391
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 17:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42742980C7;
	Fri, 23 May 2025 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ekxUU2c/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179CA2980B0;
	Fri, 23 May 2025 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748021840; cv=none; b=gS7OdDxa2ZKvwO1X+hNaL22l/4600pN/8suf3pQjjtvRN0ogb5xnLGLywB9ss57tPZTvhSVHyXfrHCbAzmorpfzI8kKB61V1//0RaGZowsZuak99ZivOgwN8gLD0/gpEhsiem9I0zoxnVGXsW75lTv/IvrjXyXJSyxkCo0/vZTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748021840; c=relaxed/simple;
	bh=s+HPyIbzFoIPlVtFqaNs4vFqEuL1R8mtL3pdowMdVKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POqeEBU1wDvR+zi2GAgmhBrjvG/AJh62czBFX54OqSdZc5OtuZeDwPrfAJIci3qfBSYWw4cS7dbr2K+KYeEnIcJdnntT0hmMqnp8ZF2t3D3GXr9RreuD/TZ94E3dj3PNh7egDFIXRCfjs5q14363f8Li9JuZzAcVXqcTkD6z4LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ekxUU2c/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gosBGJOfOI3HOUMue5/wB82nFVZSF9nFMZxyulkS3Uo=; b=ekxUU2c/6nB5G2HPWa+4yicJWj
	Y+vGPzCBAP7wS8NQ2fj4wXpY53P9HnWFFyevRdJIm1WHOWE3aFUDSywZSAZ6DkOBS+sWpCqhpm0zr
	QXsz+2Hz7+seHMkqj6ylw7OTE0yoZGSlI+AoZKRCdIVzYdUez8O+kQRXolc8hqlozgfBbFSoGc4fN
	fhVDJ3IGqgswd5Ov0aMiu7nzqT9LPc6SFNRdbPvbKuAXCOcS3MBQ8uT1KbGqhUQtzeAMArT/e2uRK
	GniCI7+5qbDXUymYmrHA4ZQAIQm245YkUhR8GZPttS46BfSlt5Zb0dxmUir6ZTHEWRpYiDzK5YYbU
	p01Bknlg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38556)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uIWKR-0003mp-1Y;
	Fri, 23 May 2025 18:37:07 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uIWKO-00061n-1Q;
	Fri, 23 May 2025 18:37:04 +0100
Date: Fri, 23 May 2025 18:37:04 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: Synchronize c45_ids to phy_id
Message-ID: <aDCyQOdcREDJTa-V@shell.armlinux.org.uk>
References: <20250522131918.31454-1-yajun.deng@linux.dev>
 <831a5923-5946-457e-8ff6-e92c8a0818fd@lunn.ch>
 <5d16e7c3201df22074019574d947dab1b5934b87@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d16e7c3201df22074019574d947dab1b5934b87@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, May 23, 2025 at 02:10:00AM +0000, Yajun Deng wrote:
> I noticed that. I tested the BCM89890, 88X3310 and 88Q2110 PHY devices,
> and the ID is always the same in different MMDs.

The 88x3310 PHY uses:

	Device ID	Package ID	OUI
MMD 1: 0x002b09aa	0x002b09aa	00:0a:c2
MMD 3: 0x002b09aa	0x002b09aa	00:0a:c2
MMD 4: 0x01410daa	0x01410daa	00:50:43
MMD 7: 0x002b09aa	0x002b09aa	00:0a:c2

other MMDs do not contain an ID.

According to https://hwaddress.com/oui-iab/00-0A-C2/, 00:0a:c2 is/was
Wuhan FiberHome Digital Technology Co.

00:50:43 is Marvell Semiconductor.

Not all PHYs have a single ID. IEEE 802.3 allows for this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

