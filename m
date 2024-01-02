Return-Path: <netdev+bounces-60841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 629F5821AAA
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 12:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0271F223D1
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 11:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0FCDDB8;
	Tue,  2 Jan 2024 11:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="b9cH8hg6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C9CDDB6
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 11:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NfhidrOlDj49J58ZaDkPGQR07xIi2QCeVmu8A7WZnSQ=; b=b9cH8hg6cZt8KqKlRBLqNx3RsC
	kvVJctG1V3QkhZuQoj+Kol+/M4SgocDG5gD+IwKwaAskJft7YT/EHIHqoATeXSaR7fMlBWQbF0Wqe
	FIxyapbxOiVht66aA1jm0d0lHn2lifBdUo5fpARmlVqESvPz+xjshjvrb+yZ4fODGA/kiFY34NOaF
	6Sr1vGr+SM76gyfgnUaqfEfM5gyy0Attf/FYFVdfq6x5dTVKgRtxQUSSLcEhlQjYt04ktA1ULI1tC
	sVM9qmnJQdz/HS+kwi3WWpj4fBnZCPav4qypmBKs59a0CR2rfPJisRWi2JSO4MtLTGYUJSOLOfR5z
	zR3f3X2Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46308)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKcas-0006Qq-2t;
	Tue, 02 Jan 2024 11:05:59 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKcat-0005D0-R3; Tue, 02 Jan 2024 11:05:59 +0000
Date: Tue, 2 Jan 2024 11:05:59 +0000
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
Subject: Re: [PATCH net-next 05/15] net: mdio: add 2.5g and 5g related PMA
 speed constants
Message-ID: <ZZPuFzDlF37KdMo2@shell.armlinux.org.uk>
References: <20231220155518.15692-1-kabel@kernel.org>
 <20231220155518.15692-6-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231220155518.15692-6-kabel@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 20, 2023 at 04:55:08PM +0100, Marek Behún wrote:
> Add constants indicating 2.5g and 5g ability in the MMD PMA speed
> register.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

