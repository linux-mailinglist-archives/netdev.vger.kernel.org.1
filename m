Return-Path: <netdev+bounces-60843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6AD821AAF
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 12:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B69DC282C22
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 11:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BACDDB6;
	Tue,  2 Jan 2024 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uDYrww8J"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ED4E572
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ujah5m5dIjYJLrbPJDwlHQgHn7b4c6NjNwjQITRXFso=; b=uDYrww8JR8jTOZfojOnUAJKts+
	A+sMloNyDdVdKf3KKj36mfuQ6FpCOcXRBf0Q1Fe4d/Khmnpd9tk2KwSrjE+vLWURrRpEdnyONY103
	noAEWlOTwyyLN9bzIreWRZr2JB6hQBeY0B1Jm5J1G/D1KjDwscLifvGqWtGF6VtFkgGh/Lpx3wiJe
	imbJ2qKMpbr8NB/yxxQ1CV0souc0ZBA0wcc56uOVKktxCyodrzaldJB9zzX/qbM9g02kG4XAOqa+f
	P0GPFq2zTYrH4LKmnAM7sVLNm9h6AtVZK/wG0G+MzhAFU+PIBuXfBSOaxD8zUwzM2nlNkaQkRa7Ft
	3IjMVWjw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35714)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKceA-0006RQ-1b;
	Tue, 02 Jan 2024 11:09:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKceC-0005E7-Mw; Tue, 02 Jan 2024 11:09:24 +0000
Date: Tue, 2 Jan 2024 11:09:24 +0000
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
Subject: Re: [PATCH net-next 01/15] net: phy: fail early with error code if
 indirect MMD access fails
Message-ID: <ZZPu5DTlzNVt+7I6@shell.armlinux.org.uk>
References: <20231220155518.15692-1-kabel@kernel.org>
 <20231220155518.15692-2-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231220155518.15692-2-kabel@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 20, 2023 at 04:55:04PM +0100, Marek Behún wrote:
> Check return values of __mdiobus_write() in mmd_phy_indirect() and
> return value of mmd_phy_indirect() itself.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>

I think the reason it was done this way is based on the reasoning that
if the bus has failed then the last read/write will also fail. However,
if we had a spurious failure (and they _do_ happen) then one of the
previous writes e.g. to the indirect address register could have failed
and we could end up corrupting a different register.

Therefore, this makes sense (and some of my commentry should probably
be in the patch description to explain why the change is being made.)

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

