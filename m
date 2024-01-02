Return-Path: <netdev+bounces-60842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A9E821AAB
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 12:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D74A282C4A
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 11:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DFBDDC1;
	Tue,  2 Jan 2024 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="er+pxP4x"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D82DDB3
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+1NpISA5WcEHVn6gBbEayLHBx6qIC3rJYSJQYccQ3Fg=; b=er+pxP4xcbgnejRVRWYEGcFMdN
	CffoGxOFrkbQEeHVStzhgIKQw6s+iyVMbV4kvSPNjY4BSU5GhMPk5gRFruH6AmdoGz84O/AvelUvv
	6ri3iir6gAZ9qV4zIGGFnTGbKfP9ei3c8XrKBt+h8S54gYtsmauKB6RIJIgUJXFBLNOzm8/pIoFM3
	7pscJG/UXcrKBeDI7I1NVaZKyEMb/PVX6eA9X/fA+Xoe5pEDEh9dn3DK65wnQYyjOGy7kqBkEoUjX
	0W6W9/12IaHPScLfeOg30kiXiix1KeoPS79XIQdLwksG6YSPKYvU6IOQ7a+E3G6WquWoByUQURNQk
	3K2BYRQw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54608)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKcbN-0006R7-1I;
	Tue, 02 Jan 2024 11:06:29 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKcbQ-0005D7-19; Tue, 02 Jan 2024 11:06:32 +0000
Date: Tue, 2 Jan 2024 11:06:31 +0000
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
Subject: Re: [PATCH net-next 06/15] net: phy: realtek: use generic MDIO
 constants
Message-ID: <ZZPuNyHvEj375+Cp@shell.armlinux.org.uk>
References: <20231220155518.15692-1-kabel@kernel.org>
 <20231220155518.15692-7-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231220155518.15692-7-kabel@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 20, 2023 at 04:55:09PM +0100, Marek Behún wrote:
> Drop the ad-hoc MDIO constants used in the driver and use generic
> constants instead.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>

Great, all for using our generic constants!

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

