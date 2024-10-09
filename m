Return-Path: <netdev+bounces-133408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BF6995D66
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 03:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016E31C21B57
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88311BC49;
	Wed,  9 Oct 2024 01:49:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D803D9E;
	Wed,  9 Oct 2024 01:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728438551; cv=none; b=kjIlo8VjQ7uCxBGccxKWwwKr4+ytxJLwZF9j5eu0FkUGMi5VmAFN0rCdRJ/ce2ywrm/5Eb6j/tuSLnRja/acS90iiyRhhAw5m7ZFU83SElhWm+xJdBLh/LUn+Akhcpwe2QWD5661YaFirfV+F1FL+SVpy1g0R02bHKQPQIWsUpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728438551; c=relaxed/simple;
	bh=DF3BtXDY7BYUmkarQzPNrfXC1j8i0Vi38SkvjVBGCZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWozI5D78GsGHVfU4uDNOxIUEAypSHK8f6xfNh7HrjIhKS+KQfQT/8XSIlcFnWVyZHpBLcgpBOA0/GCpwjEid1K8OXDxIDb/e93aSVYWfBF0uPqcFfmhpxAoyV5XpGMM2MO4/rXZXdrMMnsD4ar77BVRNBg5fQAnE7OMOh/ua/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1syLov-000000003B1-3nWX;
	Wed, 09 Oct 2024 01:48:58 +0000
Date: Wed, 9 Oct 2024 02:48:52 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next 0/9] net: phy: mediatek: Introduce mtk-phy-lib
 which integrates common part of MediaTek's internal ethernet PHYs
Message-ID: <ZwXhBG9-SpfyJjmL@makrotopia.org>
References: <20241004102413.5838-1-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004102413.5838-1-SkyLake.Huang@mediatek.com>

Hi Sky,

On Fri, Oct 04, 2024 at 06:24:04PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> This patchset is derived from patch[01/13]-patch[9/13] of Message ID:
> 20240701105417.19941-1-SkyLake.Huang@mediatek.com. This integrates
> MediaTek's built-in Ethernet PHY helper functions into mtk-phy-lib
> and add more functions into it.

I've imported the series to OpenWrt and have heavily tested it on
various boards by now. Hence for the whole series:

Tested-by: Daniel Golle <daniel@makrotopia.org>

As already discussed off-list I've noticed that

[PATCH 6/9] Hook LED helper functions in mtk-ge.c

does NOT work as expected as it seems to be impossible to control the
PHY LEDs of the MT7531 switch individually -- all changes to *any* of the
MMD registers always affects *all* PHYs.

Hence, if you repost the series, I would recommend to drop 6/9 for now
until a solution for this has been found (such as controlling LEDs
switch-wide using the built-in GPIO controller, or somehow de-coupling
them and allow access to the individual LED registers like on MT7988)

After taking care of the minor corrections which have already been
pointed out by Andrew Lunn you may add

Acked-by: Daniel Golle <daniel@makrotopia.org>

to all patches except for 6/9.


Cheers


Daniel

