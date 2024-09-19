Return-Path: <netdev+bounces-129014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E56697CEB7
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 23:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C25E1F2363C
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 21:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644A41474D3;
	Thu, 19 Sep 2024 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="z3qAmuPK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AEF142659
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 21:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726780369; cv=none; b=RJRz6B/sn8+iVDPwMqSjiRL7VThKdPtp0jIdCjlGvmc1iqhpCB78hnIoIDFdvld5hXshGl8YQwdrJ1I3uVaM8QPe2P+V33HOgXhJdAGcyLhLpnye13oyXPlp9+CEm3LR1mjDdK6rFHLJ5ujHr0dCHqn5wJiNgSpSpKmHq+RvtMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726780369; c=relaxed/simple;
	bh=q0wU3mu61K9AA1IfjDJ44hCfqmHIMee1AnX2llOWonk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENJwHEcScepuizdN+23Yga1ynt0aicvlnTsVcs8s6gXzjjUDDarMDHJlestY1RPvpadSya3IyTfP8sRTuizoek9PAJZ37PlME1KWQY0jIWqNwzc8J3gKDFOvGugvs3+sr00oWto93lLuO4KgpHd6e7dMxHWQhzKIy3V93jIq+Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=z3qAmuPK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xJv363aj4mE4RLz1n2tnFBbmkYyJgBi3IrAh9hfPhGo=; b=z3qAmuPK8sAudduNaYC/35P6mu
	2PKpN3rJcXWJEKntXTmVwDqzhe2kgN2yIQ0tjzNoaP1SFVGNW4y613XPEvs/NsuAMpAbA0o4sMX+4
	CYQij+y53FSv+tO7ynonuN5JXpY8glFGaH56cXu9J+qPgicicoWNgF6fZ8DrwoB287RQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1srOS9-007qjc-MP; Thu, 19 Sep 2024 23:12:41 +0200
Date: Thu, 19 Sep 2024 23:12:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Alvaro (Al-vuh-roe) Reyes" <a-reyes1@ti.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com, o.rempel@pengutronix.de,
	spatton@ti.com, r-kommineni@ti.com, e-mayhew@ti.com,
	praneeth@ti.com, p-varis@ti.com, d-qiu@ti.com
Subject: Re: [PATCH 2/5] net: phy: dp83tg720: Added SGMII Support
Message-ID: <fb07f305-e01b-455f-9568-8a62d54b63e2@lunn.ch>
References: <cover.1726263095.git.a-reyes1@ti.com>
 <dcb62e7332fae6ca41e55a7698a7011adada6d86.1726263095.git.a-reyes1@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcb62e7332fae6ca41e55a7698a7011adada6d86.1726263095.git.a-reyes1@ti.com>

> +#define MMD1F							0x1f
> +#define MMD1							0x1

MDIO_MMD_VEND2 and MDIO_MMD_PMAPMD. But i don't think MMD1 is used?

> +
>  /* MDIO_MMD_VEND2 registers */
>  #define DP83TG720_MII_REG_10			0x10
>  #define DP83TG720_STS_MII_INT			BIT(7)
> @@ -69,6 +72,13 @@

It looks like the SGMII register goes here, since it is in
MDIO_MMD_VEND2.

	Andrew

