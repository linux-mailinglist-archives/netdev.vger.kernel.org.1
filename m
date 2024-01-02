Return-Path: <netdev+bounces-60846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 069B4821AB8
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 12:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA76B20D38
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 11:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFC6DDCA;
	Tue,  2 Jan 2024 11:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jz8jexp/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EACEDDB6
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 11:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Z40OMmO58gMhMjZcWSV3knsK1+WDEL30WXxQsne5s64=; b=jz8jexp/LUO4EzGYEuc4uQI+tS
	Cv2ZOQiovsrE3atOf2+8JToZ53GKNqckmZUEpI8w0xgtoBJnYrmh0LrXqTaJQgnaEkt1774KItfkw
	tUyHvnSBWlwDAt9QxJO6+RtOYJp4FXSOOqZd2oNNd629MZfxzITk7RusNhGNA94N5ln9HVL5YYl+N
	sXr6IkIGigvuGCmXgPWz9X/p9pynSfpv1Je/LgPSqUhnty55Gw2KrHciLZtLWQ59Rq0qS+zJmDDgO
	InR2eszkAskDOFb+lqbsQvAUy0d2Zt6k9N1NXjBPJhYyO/T0md2QX0qNHRejTJq4VXUHT6TyKRQkk
	ekFxtDJw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49788)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKckH-0006Rt-2z;
	Tue, 02 Jan 2024 11:15:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKckK-0005EJ-87; Tue, 02 Jan 2024 11:15:44 +0000
Date: Tue, 2 Jan 2024 11:15:44 +0000
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
Subject: Re: [PATCH net-next 02/15] net: phy: export indirect MMD register
 accessors
Message-ID: <ZZPwYM9nnqgq8Tvv@shell.armlinux.org.uk>
References: <20231220155518.15692-1-kabel@kernel.org>
 <20231220155518.15692-3-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231220155518.15692-3-kabel@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 20, 2023 at 04:55:05PM +0100, Marek Behún wrote:
> Export mmd_phy_read_indirect() and mmd_phy_write_indirect(), the
> indirect MMD accessors, so that the functions can be used from the
> .read_mmd / .write_mmd phy_driver methods.
> 
> Add a __ prefix to these functions.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

