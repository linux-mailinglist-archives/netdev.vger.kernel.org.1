Return-Path: <netdev+bounces-84157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBEA895C84
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 21:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C27B1F26789
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 19:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECBD15B996;
	Tue,  2 Apr 2024 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xYxi/123"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879C915B986
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 19:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085980; cv=none; b=KH3dzf1KrRLo+r1ubJnACdq3FrXjJLLGjC5fLjYWPf2x/NLoN4xOPGMni4u5FZPnjIBAaPpNMjw8859Y6aZkUbLFp1o5U/xe4ixLDRx5npqMUU9D+Gx6df9YLCJGlj7Jv4dnDL4bq5NpLoNXxqCAKlmurX7NruZSeRQxL8lRwr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085980; c=relaxed/simple;
	bh=ptB98lMtwKkoKq4ytHuX4F/W50klb77RFsreVvl42Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZN0R+RM0+brylpNGMRGvcnqemQ8ZoCL5fPOiAzrZLDPOxr0YTDf6cT6j/lPaBkRqt+eX4Y/WVr0dgzLFCwgpiRcfZai2XXaxb+MOpgSaqS1tDtlI6iWURbo8lpzVa07S8c/ZqbbuKdywWnu8vdyede/etlMPqFHpBUe5WkdVQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xYxi/123; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oPz/pxLKckTgY8duuOzV2LO6+Gxx/SHwuhVEw7FV0no=; b=xYxi/1235lmf+dqLT3mDhRoPPQ
	AvoA8uKTpajlg3MA9W4pYTF1NI8QY75DXOcd6T6skAwpPMOaSO0DeRIF9CxRwTIrPxT3weinTeP+9
	7BXWC/SJpX3GVKNscvXdRZyeWq4DddGAZugYjoP5n30xEDLp1TyA13kiZ2MNMIR1p65gcfivuxqvp
	OXO1+77WBtiwdCKL9Nqr6i2Zu6l5lp6gf6ojNvsESRs62MkFN6wYJJZh9nd1bdAXDAYywvainxQWW
	fAj/eGrmF7BwPoE/5Ra6okgj0eVcCF6dtNmL0zhzmjKI8PJPMBzgQNrh7SLRW7K0YFofk4gW93C6G
	Jg96TyCA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44632)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rrjlq-0007Fy-1H;
	Tue, 02 Apr 2024 20:26:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rrjlq-0007CE-Ik; Tue, 02 Apr 2024 20:26:10 +0100
Date: Tue, 2 Apr 2024 20:26:10 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next 3/6] net: phy: realtek: Add driver instances
 for rtl8221b via Clause 45
Message-ID: <Zgxb0gjfm9mexi4G@shell.armlinux.org.uk>
References: <20240402055848.177580-1-ericwouds@gmail.com>
 <20240402055848.177580-4-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240402055848.177580-4-ericwouds@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 02, 2024 at 07:58:45AM +0200, Eric Woudstra wrote:
> From: Marek Behún <kabel@kernel.org>
> 
> Collected from several commits in [PATCH net-next]
> "Realtek RTL822x PHY rework to c45 and SerDes interface switching"
> 
> The instances are used by Clause 45 only accessible PHY's on several sfp
> modules, which are using RollBall protocol.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>
> [ Added matching functions to differentiate C45 instances ]
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

