Return-Path: <netdev+bounces-132689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B523992C62
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3881C224E4
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA061CC159;
	Mon,  7 Oct 2024 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zAwhPfL1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD2F1547D4;
	Mon,  7 Oct 2024 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728305453; cv=none; b=ei+ZHqHJLDiLCtuMbM9iEv8pq5Wc9rdkr13YuUl99C4UUmm12aZ7ZIUXMENoU8r33DOSqhKRbjuEdyNq4XHguTOT038JFMi9khsX3bjQqWpyxkmv23C1HiRGerX9Ew0+C5w9Ji7XkqiYF9hpltF+SQSn6Y70mSf8ydhSpoEErB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728305453; c=relaxed/simple;
	bh=phQQ4ZGTzke66auKBb0y2BKd5o3IZGSSHyNJc1hI+BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NX5vBn/wCLtI6ObztfdzXxGpAfaVxF72J2IsE0oTYyXg6DB1A/CPzWcDobjMzRaWf30iKXZfIV9ZAJ9G5stR3mWhVhuQuSg4q9G8Tkx9tNPVDFEZmQB72gMzIeQWU4Nk1FmmAov8wfdWA1y4gOeMtxYca8y/q8X8XdNR5CBWJgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zAwhPfL1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9AUrARcn8p6Bu/y9sftMEvfU8DX72hnzGfPHJbkJ2Hs=; b=zAwhPfL1bdg6M2CC7uA2PI9pjW
	2utS/URZj81kVRJl01CClUKFBSySBcVYE+IVP77u5/e4zLHUPV2s0ndSUzeZzoEaAAQEzQAP9qk1E
	L5Ugt92TlofY3Rn5rchVv9a5NRihLUhFbn1rKc5l0gdkNUOsaSP6frSZIazyeV2dXs0Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sxnC8-009GFh-Bk; Mon, 07 Oct 2024 14:50:36 +0200
Date: Mon, 7 Oct 2024 14:50:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next 3/9] net: phy: mediatek: Move LED helper
 functions into mtk phy lib
Message-ID: <de510d94-2f30-4418-a21a-76e8139e583f@lunn.ch>
References: <20241004102413.5838-1-SkyLake.Huang@mediatek.com>
 <20241004102413.5838-4-SkyLake.Huang@mediatek.com>
 <afd441fc-7712-4905-83e2-e35e613df64a@lunn.ch>
 <3f1c73ec57aefa2803df0c32c78dcdc41fed4126.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f1c73ec57aefa2803df0c32c78dcdc41fed4126.camel@mediatek.com>

> Although this is just "moving code", we need this priv to do some
> modification for mt798x_phy_hw_led_blink_set() so that we can move it
> to mtk-phy-lib properly.

The helper is passed phydev, so it is not clear to me why the helper
cannot do:

struct mtk_socphy_priv *priv = phydev->priv;

same as the old code. Maybe you want a patch first which renames
mtk_socphy_priv to mtk_phy_priv, just to keep with the naming?

Or do you see the need for different PHYs to need different priv
structures?

	Andrew

