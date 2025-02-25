Return-Path: <netdev+bounces-169471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C778A4414F
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7753A25D1
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 13:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E5B26988C;
	Tue, 25 Feb 2025 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UP4byKOg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF54F233714;
	Tue, 25 Feb 2025 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491480; cv=none; b=lsYrSN+Arub2xzWob0VtRjBKcnTQLGVy6X9qz47/TsEWyyIF3+81sBNNKjnxrTlL7Sbp5pMLqHID1MOMAH5JGG+kpZoNiUGtpyCGOmT1Shd2oTaYoqOVEeYCbvdd6QOi7Gke6lX0cFeglEhdVawrD4Amiiw095kdeh3py6HDU4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491480; c=relaxed/simple;
	bh=PcXWHDco3CAdDPQSPgA+cZxIc/cAUc3MY9VoBBcOWbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RM52yVYfkLgm47UhxD/Q5yW8v0mCBISHt6tWFVlw8+tEWo7F+F/brgNuzwZ85ofN9KC7alemU9lzu6Z1wlUpRvbXAfPSLQYEJZPJ3byYjn46qzYcX9gKk0+g0brIM/4rx0Iw4y0idvNVrNRoI7jrNTVAH4JNMl/sl3FfJmkxPSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UP4byKOg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=e3VmXvqmgpmlkacg4yCqG6k/DWw/7LO2D1NyxSJiktc=; b=UP4byKOgV4ukVo21U5njdpdZC0
	G4UYijU2274eCrrlkKTfbuZSamLwWkZdjJYtqnNdcNL8pIQoMObhFrr6qyHdQig4KiT6Wdj18Yzhx
	yy/ckGOZzVfYTDYy1YR18vgMtRIB9TN5Uees+9P8PejyiR+5lwuHi2M5UswRsCsj1DPo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tmvKu-00HWpb-CB; Tue, 25 Feb 2025 14:51:00 +0100
Date: Tue, 25 Feb 2025 14:51:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>
Cc: "daniel@makrotopia.org" <daniel@makrotopia.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/3] net: phy: mediatek: Add 2.5Gphy firmware
 dt-bindings and dts node
Message-ID: <176f8fe1-f4cf-4bbd-9aea-5f407cef8ac5@lunn.ch>
References: <20250219083910.2255981-1-SkyLake.Huang@mediatek.com>
 <20250219083910.2255981-2-SkyLake.Huang@mediatek.com>
 <a15cfd5d-7c1a-45b2-af14-aa4e8761111f@lunn.ch>
 <Z7X5Dta3oUgmhnmk@makrotopia.org>
 <ff96f5d38e089fdd76294265f33d7230c573ba69.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff96f5d38e089fdd76294265f33d7230c573ba69.camel@mediatek.com>

> > Would using a 'reserved-memory' region be an option maybe?
> Or maybe just leave those mapped registers' addresses in driver code
> (mtk-2p5ge.c)? Like:
> #define MT7988_2P5GE_PMB_BASE (0x0f100000)
> #define MT7988_2P5GE_PMB_LEN  (0x20000)

The problem with hard coding them is you need some way to know which
set of hard coded values to use, because the hardware engineers will
not guarantee to never move them, or change the bit layout for the
next generation of devices.

PHYs don't use compatibles because they have an ID in register 2 and
3. Is this ID specific to the MT7988?

	Andrew

