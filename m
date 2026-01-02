Return-Path: <netdev+bounces-246582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E89ECEE933
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 13:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBEAE300927D
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 12:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172FA3115A2;
	Fri,  2 Jan 2026 12:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="u7hdaRd8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55896276051;
	Fri,  2 Jan 2026 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767358097; cv=none; b=DftIlDKr64k+MpPEkDALH4W0EpVPXUuTuG6X63wWD8GVGgbH2TObDYXDGYvEiYhw4itohbSIBRQtx3zIfI3vNT6qj2p3N0udsh4ezX7Ygo3VY5kczK5HpONHISrVRJk5kirPrizMJI6n38MN05p5U0p+JXwQIhC69jnSNljUMZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767358097; c=relaxed/simple;
	bh=Zo+CZRkOdyRlbl8uw6/U/dP7SnM8JloYGEetKK3T/eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Buc0UYhAOzzB67m8jL0bI859hLRJr7RmIdECAzCZlDBk7Ce6bN0FJXNYqX4dEiRxu53uoeWoZdUf6TzPW7VfotJOoW/IoHu36DU76P6DuXFoha5IaoVVEmedVKo+GN2STxH/5WXn2XJFrwbyNedAClcicB69/JatznuQwwGeY3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=u7hdaRd8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uFWww/jRLCfd9LAjvziNieeVlY5M972Prk3cE/F6sYg=; b=u7hdaRd8cJcERy+48wiUjfxSJx
	sKEFgjT8Jxb0a+KWxcJjcE8FRc9cZsOCMYt5pSJPfnroH34kBgIoJs9l7wgOdVKOwlybZ9wHiIWTT
	Mfkm+X1Frqa2PnJ2aTlXwNwwMRZ7wnSk41fx6R6kR3RpndrJHlCS90DbMqZrAGcMSmlrc3ZHrGgXc
	Qtc8Mt5590KFyNTeIQQ4o2fgBTAAvVteWmzneJNISm2km58SctkvORxswO4iSSxqDXDAC3FSHVwAm
	z6oXzVC7qyZEET2P69aWwu2CEPpkJbQdocc1ShMxVQiDQLB0PSkLiad3HKlX78Gy+L3q83fI5QCXa
	5H5cerrg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39354)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vbeZc-000000005zj-3kkf;
	Fri, 02 Jan 2026 12:48:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vbeZb-0000000053V-0fB6;
	Fri, 02 Jan 2026 12:48:07 +0000
Date: Fri, 2 Jan 2026 12:48:06 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Josua Mayer <josua@solid-run.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 2/2] net: sfp: support 25G long-range
 modules (extended compliance code 0x3)
Message-ID: <aVe-hq6yZfdKTT20@shell.armlinux.org.uk>
References: <20260101-cisco-1g-sfp-phy-features-v2-0-47781d9e7747@solid-run.com>
 <20260101-cisco-1g-sfp-phy-features-v2-2-47781d9e7747@solid-run.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260101-cisco-1g-sfp-phy-features-v2-2-47781d9e7747@solid-run.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 01, 2026 at 06:05:39PM +0200, Josua Mayer wrote:
> The extended compliance code value SFF8024_ECC_100GBASE_ER4_25GBASE_ER
> (0x3) means either 4-lane 100G or single lane 25G.
> 
> Set 25000baseSR_Full mode supported in addition to the already set
> 100000baseLR4_ER4_Full.
> 
> This is slightly wrong considering 25000baseSR_Full is short-range but
> the compliance code means long range.
> 
> Unfortunately ethtool.h does not (currently) provide a bit for 25G
> long-range modules.
> Should it be added?
> Are there any reasons to not have long-range variants?

Good questions, not something I can answer though.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

