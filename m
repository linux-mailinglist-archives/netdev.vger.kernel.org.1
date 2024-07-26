Return-Path: <netdev+bounces-113154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7216493CEE2
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 09:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E72282710
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 07:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3DA176248;
	Fri, 26 Jul 2024 07:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="le/D1sTF"
X-Original-To: netdev@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB27A2B9DB;
	Fri, 26 Jul 2024 07:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721979253; cv=none; b=R4W1zh1jEl4ZYCaGOJ+dwjoQ+IxxraPUbajt4x7GCOdWfozZ9oJqZpZ/58xEMdfg5NGTrEahlU5/jtHbSYAt58/TfAPtGbgGkvSPxD1q1R0L3I+whnoc5Q2ww+V4k4+FYuljmSCMeoaCEKLf/uHJs6soqmKp0VgE1xvB/EEzA8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721979253; c=relaxed/simple;
	bh=XC7U9IhbkILOumdEEuEW92lcMt4pu5DxJNaudiPgLj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJYObwL6drw0dHENImcVDZ8oEaiEkG7keMHBe56Uy1i+ZPE5akr53eFwI6grqIdx2dJvGsmxMTPe/DyyU/gmiVmS06FlOsDk+1S3bdmkWmL2npe43WYBac1lirgGZ/2wjEhuKInsrJleV60eOrL0UTnPNjREf4oDyg219shjDiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=le/D1sTF; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay3-d.mail.gandi.net (unknown [217.70.183.195])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 51416C3865;
	Fri, 26 Jul 2024 07:27:06 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 12ABD60006;
	Fri, 26 Jul 2024 07:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721978817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/6icvmHFqOGiQYYqrUIk9yubByo/S9JAwjnB/wR8f0=;
	b=le/D1sTFa3YIsZM4z284TIMxK2lKb+dwC9CC907nh+hxG3hdaAiCezrJOhB3nhC03250he
	YWi/AdqmK/Sf+D6TSvvavYOd9O+L5YrdilqMC/el6ge6mcoalHD+Kp2nEP/AO2YwHjuWRo
	Ir3jK2sj+XY8YzJ3Vp4E4QeArCSCo2wkXLU1qbUxkohpumkWVFgYOjayaI5x4eaGKyxAao
	KfqbO5mj2UX5BtnmzxN8Do8DJCNKFOOgpKsiB51Kf7pGBqWeRQ2SlJ7TeISAHlekZapddJ
	jR+DWolcPwEA3uULHGD/ED84hYw5+KpHrU8M2Xy3u3L0fHV0Cst/BWuu3S9p3g==
Date: Fri, 26 Jul 2024 09:26:55 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Mark Mentovai <mark@mentovai.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
 Jonas Gorski <jonas.gorski@gmail.com>, Russell Senior
 <russell@personaltelco.net>, =?UTF-8?B?TMOzcsOhbmQgSG9ydsOhdGg=?=
 <lorand.horvath82@gmail.com>, Mieczyslaw Nalewaj <namiltd@yahoo.com>, Shiji
 Yang <yangshiji66@outlook.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2] net: phy: realtek: add support for RTL8366S
 Gigabit PHY
Message-ID: <20240726092655.15e66731@fedora.home>
In-Reply-To: <20240725204147.69730-1-mark@mentovai.com>
References: <20240725204147.69730-1-mark@mentovai.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Mark,

On Thu, 25 Jul 2024 16:41:44 -0400
Mark Mentovai <mark@mentovai.com> wrote:

> The PHY built in to the Realtek RTL8366S switch controller was
> previously supported by genphy_driver. This PHY does not implement MMD
> operations. Since commit 9b01c885be36 ("net: phy: c22: migrate to
> genphy_c45_write_eee_adv()"), MMD register reads have been made during
> phy_probe to determine EEE support. For genphy_driver, these reads are
> transformed into 802.3 annex 22D clause 45-over-clause 22
> mmd_phy_indirect operations that perform MII register writes to
> MII_MMD_CTRL and MII_MMD_DATA. This overwrites those two MII registers,
> which on this PHY are reserved and have another function, rendering the
> PHY unusable while so configured.
> 
> Proper support for this PHY is restored by providing a phy_driver that
> declares MMD operations as unsupported by using the helper functions
> provided for that purpose, while remaining otherwise identical to
> genphy_driver.
> 
> Fixes: 9b01c885be36 ("net: phy: c22: migrate to genphy_c45_write_eee_adv()")
> Reported-by: Russell Senior <russell@personaltelco.net>
> Closes: https://github.com/openwrt/openwrt/issues/15981
> Link: https://github.com/openwrt/openwrt/issues/15739
> Signed-off-by: Mark Mentovai <mark@mentovai.com>

This looks correct to me.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

