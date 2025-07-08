Return-Path: <netdev+bounces-204890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5F9AFC6A4
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605D91BC435D
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0FA2BEFE9;
	Tue,  8 Jul 2025 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hMZdm+qb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B67E29AAF5;
	Tue,  8 Jul 2025 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965462; cv=none; b=sEkjbWuLhpPxxKwCpKg48CyD717WL7rg0/LT5+Lxck2hM3X9xmI5otqUyXYI0ZCTPez8iRueACc7QufuWa6bYEUP+DNw1RUSnSCifFt8eJtL2G9S1pvwjJ2uLSQ6z0CtFDmunnXBubF/ypda6CJ7jgfr4YIanDFCDTOOD79s0LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965462; c=relaxed/simple;
	bh=TrJ/fz5xVxfLODysqwKHUSrC7xxXwGGsrtahTvWVdqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrGxvjgBRThdG45nUuxM2woGJyXPKWr2UvSueGroH9sfpYaPYhRzJGXBZfzrtRiqkMX8fpSYK+C1uPxYlFc2cGyMzgjVh+ievZXpB1YvrnW2BnTjvtgxuyoOYhwWElgmHOo4j6Js4VD+BhDwKbi9XETQFyMDE2TNlucr5LcH3U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hMZdm+qb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yE51Ym9OIJa8tb30p5ieD8XKMSfUl3EBXFq8KptHEqk=; b=hMZdm+qbvF+FDnUPQ2GmHbxFOk
	ZuSWVfIKSC5jjPRs1llw6F463/lU5OOB+rmEZbRj+AhlQAzlZHLez5d1QkofVzVFBTTu7S90F8eml
	XfOWZWlGU4bx4xqFn2KdGBykHlEGJoU/5UJI3quiwfQF8QdRq2lkkyQRDTJIG8Oq8Uj+9iTEcXR8Q
	YJzC8UcToUC4Q3hvTyPcCv89VoXcnD6vtvrskugzQkfir17LjwBYj/gdWSvFcWkrKvpbdCJ4pInKk
	fjGPFjYABYPPInzFAIBX2IWRQicav3S1JhgZHmgVfkShwJFnLCxRuJG/Y5+fH7hFStLABmKIx/8ip
	aAXDHfHw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49770)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uZ4FG-0006Kl-14;
	Tue, 08 Jul 2025 10:04:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uZ4FE-0001Uj-2r;
	Tue, 08 Jul 2025 10:04:08 +0100
Date: Tue, 8 Jul 2025 10:04:08 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	robh@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org,
	corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v7 3/4] net: phy: bcm5481x: MII-Lite activation
Message-ID: <aGzfCHlHXEpq9-Gi@shell.armlinux.org.uk>
References: <20250708090140.61355-1-kamilh@axis.com>
 <20250708090140.61355-4-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250708090140.61355-4-kamilh@axis.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 08, 2025 at 11:01:39AM +0200, Kamil Horák - 2N wrote:
> Broadcom PHYs featuring the BroadR-Reach two-wire link mode are usually
> capable to operate in simplified MII mode, without TXER, RXER, CRS and
> COL signals as defined for the MII. The absence of COL signal makes
> half-duplex link modes impossible, however, the BroadR-Reach modes are
> all full-duplex only.
> Depending on the IC encapsulation, there exist MII-Lite-only PHYs such
> as bcm54811 in MLP. The PHY itself is hardware-strapped to select among
> multiple RGMII and MII-Lite modes, but the MII-Lite mode must be also
> activated by software.
> 
> Add MII-Lite activation for bcm5481x PHYs.
> 
> Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

