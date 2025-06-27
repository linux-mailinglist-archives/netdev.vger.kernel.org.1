Return-Path: <netdev+bounces-201943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E06F7AEB878
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 15:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9173BD1F1
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CB32D6600;
	Fri, 27 Jun 2025 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="S6G4uKvJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB812BEC3B;
	Fri, 27 Jun 2025 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751029643; cv=none; b=pVdXhf1eyLqXvLeD5w9zN7N91QICgJC4U41MOQmsKRrgOF8dSu0Zt3FxJ5VkRy029k4c/OKlxI4l0OzVDIvbdGjGpmqfrDOZ9Rqp7vkbds3n7m2GNRcgHXH1CgGVT3F+gfGchpvlPML172v+a3NE/IOm2iFZToQ3wVESgrJKc3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751029643; c=relaxed/simple;
	bh=oQ6nLTfijeLMSnQf916nL8fOfn5nAOCN+wyQd3Cteac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8arSXamEILUtOLJnLL5FhFuIYQbdw92kQHjKNSbgBZJ/KBxCc+eZwkcGmjbm7WnZzxEszvjGnKVFH7oXY7E8fNOsY5tGXdYdyJxGG3xLeK36gUvq3vS2Txat7Kyrk0AyMxi7Xm6lXYCLgGeTtPkaHyqYnz2TO6TDV8wFK4g+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=S6G4uKvJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=y5TCiTU8uXHfhDA2OZ05a6CmuxDLb7Yp7flt8EQe8PE=; b=S6G4uKvJ6+rsENxerUrutaI715
	S4cLWUYcDGcmk7EW0pvOd8P8hXdPSXTE07f/aBH6CIb7WCBb9jYpYtwoZYzpYB//4+vy9pYyqaS30
	yNduHf6ZWS3lSiMrM5JoUW1z2yrOblnF78HrHQf/X4OeigFXsChxe+ED9hG9zt3n6ly5+38qKUpsI
	pie74Ntjnfm4Gdh447XQTJsIhq6yfjr3l4Gatopmkm00Gb01dAj2QJbI230Dq0jHhR6IPcvOVfB4q
	pFmB75U25s/GV1k2lJLPYtIYJsT58oz/VY1x6wXuVNDXv/sYISUZsrTnDJ7ZiLu/mqQTAIPox0KK5
	B1HOZoCA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49188)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uV8nG-0001VP-1S;
	Fri, 27 Jun 2025 14:07:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uV8nC-0007bc-1v;
	Fri, 27 Jun 2025 14:06:58 +0100
Date: Fri, 27 Jun 2025 14:06:58 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	f.fainelli@gmail.com, robh@kernel.org, andrew+netdev@lunn.ch
Subject: Re: [PATCH net v2 1/4] net: phy: MII-Lite PHY interface mode
Message-ID: <aF6Xch-qv-3zzMja@shell.armlinux.org.uk>
References: <20250627112306.1191223-1-kamilh@axis.com>
 <20250627112306.1191223-2-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250627112306.1191223-2-kamilh@axis.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jun 27, 2025 at 01:23:03PM +0200, Kamil Horák - 2N wrote:
> Some Broadcom PHYs are capable to operate in simplified MII mode,
> without TXER, RXER, CRS and COL signals as defined for the MII.
> The MII-Lite mode can be used on most Ethernet controllers with full
> MII interface by just leaving the input signals (RXER, CRS, COL)
> inactive. The absence of COL signal makes half-duplex link modes
> impossible but does not interfere with BroadR-Reach link modes on
> Broadcom PHYs, because they are all full-duplex only.
> 
> Add MII-Lite interface mode, especially for Broadcom two-wire PHYs.
> 
> Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>

Very sorry, but in the last review, I missed that you aren't updating
the description of interfaces in Documentation/networking/phy.rst

Please see the section "PHY interface modes".

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

