Return-Path: <netdev+bounces-211525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9257B19EF2
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 11:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5F9189B737
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 09:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED660246BC9;
	Mon,  4 Aug 2025 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aewUqEyq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2721DF248
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300781; cv=none; b=QrcyGoRBc0T9EQZjhgCG7ZEjPdINPitqRQFir6RQfASfXz7KjEST+uApLEpnqsMD/cSAFCppLkbE37hilG363nX+cC1XM0PDebWSLczoUh/l4yjdCWn3w7db1zCBJtUx351nxkF3bombBTg5osqLgySp1JXTawEwK+YIv+G5HBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300781; c=relaxed/simple;
	bh=sbpEUy+IHNJrT/EXXE1dkoE8JydAdaaoiU96/4ue5PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiXNav11fdh3+Qj5NFXn78G51XhCY/m2ON2P6DKhzxPStvk3OTeqce+DU4hPuNekfkCxLSKvLvS1k/0UuuisXlm4J4zHhS1SGP50xLURqZe3z1v+THeHsz9izZ/UbAQOoOs76UPBWCftmVjB0mVbSTRS3vF0+xiV1fscgGSeWlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aewUqEyq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=avCyiE5TX2b0tKKcgmawJ/BtqFUGJZqctR8MT7Yk6IE=; b=aewUqEyqYAzS6Rl1m7CGJivchh
	I/depk9fWSXEJTptItIyC5+9s99FP+l2gH3QGXb61n8gbnzRY+4t5mzRluNfpa8LkpeIsEPb9Hckg
	gl3WqwjZWTSb229njHU5v9fcJ+w7llHyYYBT/3GaBMC2fSAnXp0Eqa+9iKChzW9ZaKGgvsVD6Z7LE
	G8cXk8VBfk6e4fTRSI2bnR25SlAiwHJeEcBHtq8snwvrZjF6FlB5vWrm3yh0czalOr1s/hyDiRUMM
	/IFVt/w2KGHW2/xRXR+qQHL/+/11CGthUTeUZ2GKdzSPmfZQpa2KAqT0x9Vh6cYXGK99Rrnfcxz73
	hIa9Gdcg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39640)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uirlb-0001Qk-0q;
	Mon, 04 Aug 2025 10:46:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uirlY-0004yk-0q;
	Mon, 04 Aug 2025 10:46:00 +0100
Date: Mon, 4 Aug 2025 10:46:00 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kanglong Wang <wangkanglong@loongson.cn>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: Questions about the -ENODEV judgment of PHYID
Message-ID: <aJCBWIXEe50h11bV@shell.armlinux.org.uk>
References: <8efa43ec-10bf-2c4f-e1f2-45f4b3a0afa0@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8efa43ec-10bf-2c4f-e1f2-45f4b3a0afa0@loongson.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Aug 04, 2025 at 05:22:55PM +0800, Kanglong Wang wrote:
> I hope you're having a great day.
> 
> When reading the code, I see that when phy_id is 0x1fffff, it is judged to
> be -ENODEV, but I don 't see this description in the IEEE 802.3 document.
> 
> I am writing to ask the following drivers/net/phy/phy_device.c file in the
> get_phy_c22_id function about phy_id judgment whether there is any other
> document basis ?
> 
> The commits are as follows:
> 
>         ee951005e95e net: phy: clean up get_phy_c22_id() invalid ID handling
>         48c543887bc5 net: phy: clean up get_phy_c45_ids() failure handling
>         e63062616df3 net: phy: clean up PHY ID reading         454a78d17845
> net: phy: clean up cortina workaround

Thanks for asking on the mailing list instead of emailing privately.

While there may not be anything in 802.3, the point of the code is to
detect whether there is actually a PHY present.

The MDIO data line is pulled high. If there is no response from a PHY,
then while the data is being read, the MDIO data line will remain high
and thus we read '1' bits. The result is that a register reads as
0xffff. As the PHY ID covers 32-bits across two registers, when we
assemble the PHY ID, a non-present PHY will read as 0xffffffff.

I can't say for certain why we ignore the top three bits of register 2.
My best guess is that there are systems which either sporadically
return random noise in those bits or similar, leading to false PHY
detection and systems that fail.

These seem to be the relevant commits:

6436cbcd735a ("phy: fix phy_id detection also for broken hardware.")
3ee82383f009 ("phy: fix phy address bug")

Commit 3ee82383f009 was definitely wrong, and introduced a bug where
non-present PHYs in properly functioning hardware would be detected.
Commit 6436cbcd735a happened a week later to fix this patch.

Sadly, it seems that the mailing list archives for netdev around this
time no longer exist (at least as far as Google is concerned) so I
suspect the context behind these two patches has been lost.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

