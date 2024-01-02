Return-Path: <netdev+bounces-60848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D99821ABE
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 12:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773F81C219B4
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 11:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E18DDC3;
	Tue,  2 Jan 2024 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fdwIyeN2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33FDDDD3
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 11:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UYjQwVgQj9nLDp29cTipZHjRBIjUz0arhV+ihOJ+wIQ=; b=fdwIyeN2qE2qe5n/Q8VMDWm9hU
	wD03d8p1RJ1mUK2UDM+V9sgjEp88HtnmRas7zUT9RK9w7ud9W5Y0VeoN/9KAxlhjwOfOxYLwi1poa
	xJSnyvM7j9Oc9UE1G0QeCWgGOu9h6IGUTnw1YvaRfemr2aV+XtDiTxnq4/Z96hpvKpPcqVBPVonAd
	IjtbCNK8mWaUljEXAPl4Z/ZRB7OIhoUSTsXpeNeFMBwlfEcmLS6jTNB3dcEemdq1BQKhnI3VgARQF
	xeMvFPilAQF/Mdqo/V9y/NJoKpHsAaxDSx8ECSIbVnC8XD4f+lElCp5puOl9FmavBOouqmegLWDxh
	AGLFPuLA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38314)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKcl6-0006SR-2Q;
	Tue, 02 Jan 2024 11:16:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKcl8-0005EX-JY; Tue, 02 Jan 2024 11:16:34 +0000
Date: Tue, 2 Jan 2024 11:16:34 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Willy Liu <willy.liu@realtek.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Marek =?iso-8859-1?Q?Moj=EDk?= <marek.mojik@nic.cz>,
	=?iso-8859-1?Q?Maximili=E1n?= Maliar <maximilian.maliar@nic.cz>
Subject: Re: [PATCH net-next 04/15] net: phy: realtek: fill .read_mmd and
 .write_mmd methods for all rtl822x PHYs
Message-ID: <ZZPwkrCNi+ZeWJrP@shell.armlinux.org.uk>
References: <20231220155518.15692-1-kabel@kernel.org>
 <20231220155518.15692-5-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231220155518.15692-5-kabel@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 20, 2023 at 04:55:07PM +0100, Marek Behún wrote:
> Fill in the .read_mmd() and .write_mmd() methods for all rtl822x PHYs,
> so that we can start reimplementing rtl822x driver methods into using
> genphy_c45_* functions.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

