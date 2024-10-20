Return-Path: <netdev+bounces-137260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7AF9A532D
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 10:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06D31F211DB
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 08:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A6378C76;
	Sun, 20 Oct 2024 08:44:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9600614A90
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729413868; cv=none; b=eoTNtIPsEwgi2r/Zsk+vR9YXFVZPvWhnXlA+j8SJuE8Y8N2PT4suvPktRayggC2YRg00VU+RCzsZ2BkbJeIPvL8f0KGlQ6WAMHGXYJKTcVnbFXHTzfE/M9i1jdRz1fPO+BWvQYGvP38do/y+oLOQEfyNWvbnC4b4FyhjG1G4cU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729413868; c=relaxed/simple;
	bh=+stGq4nb8akwH6Nh93GfnKJT4y3xPhzx01jTDLNF/xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uP/up9mwx6Cxwytk8Yp4LkCqXFIQAQ8N/T6Ee5JTJQmZb3/yGkV5pUfX4nadN07ZXLU3By/u19CgIlKTjifBZQAvs9TH6/EJUCsOF4p0Dvm5ryV70xlHZJ+PZsGZH8r96DtobRtpWqfUdev03XD6DmBeVjdUN3RLoc5xtBRVx5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1t2RXh-0000gK-OY; Sun, 20 Oct 2024 10:44:05 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t2RXg-000VCp-03;
	Sun, 20 Oct 2024 10:44:04 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t2RXf-003vtG-2w;
	Sun, 20 Oct 2024 10:44:03 +0200
Date: Sun, 20 Oct 2024 10:44:03 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lukasz Majewski <lukma@denx.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net: dsa: microchip: disable EEE for
 KSZ879x/KSZ877x/KSZ876x
Message-ID: <ZxTC006I-AWuJ3Ru@pengutronix.de>
References: <20241018160658.781564-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241018160658.781564-1-tharvey@gateworks.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Oct 18, 2024 at 09:06:58AM -0700, Tim Harvey wrote:
> The well-known errata regarding EEE not being functional on various KSZ
> switches has been refactored a few times. Recently the refactoring has
> excluded several switches that the errata should also apply to.
> 
> Disable EEE for additional switches with this errata and provide
> additional comments referring to the public errata document.
> 
> The original workaround for the errata was applied with a register
> write to manually disable the EEE feature in MMD 7:60 which was being
> applied for KSZ9477/KSZ9897/KSZ9567 switch ID's.
> 
> Then came commit 26dd2974c5b5 ("net: phy: micrel: Move KSZ9477 errata
> fixes to PHY driver") and commit 6068e6d7ba50 ("net: dsa: microchip:
> remove KSZ9477 PHY errata handling") which moved the errata from the
> switch driver to the PHY driver but only for PHY_ID_KSZ9477 (PHY ID)
> however that PHY code was dead code because an entry was never added
> for PHY_ID_KSZ9477 via MODULE_DEVICE_TABLE.
> 
> This was apparently realized much later and commit 54a4e5c16382 ("net:
> phy: micrel: add Microchip KSZ 9477 to the device table") added the
> PHY_ID_KSZ9477 to the PHY driver but as the errata was only being
> applied to PHY_ID_KSZ9477 it's not completely clear what switches
> that relates to.
> 
> Later commit 6149db4997f5 ("net: phy: micrel: fix KSZ9477 PHY issues
> after suspend/resume") breaks this again for all but KSZ9897 by only
> applying the errata for that PHY ID.
> 
> Following that this was affected with commit 08c6d8bae48c("net: phy:
> Provide Module 4 KSZ9477 errata (DS80000754C)") which removes
> the blatant register write to MMD 7:60 and replaces it by
> setting phydev->eee_broken_modes = -1 so that the generic phy-c45 code
> disables EEE but this is only done for the KSZ9477_CHIP_ID (Switch ID).
> 
> Lastly commit 0411f73c13af ("net: dsa: microchip: disable EEE for
> KSZ8567/KSZ9567/KSZ9896/KSZ9897.") adds some additional switches
> that were missing to the errata due to the previous changes.
> 
> This commit adds an additional set of switches.
> 
> Fixes: 0411f73c13af ("net: dsa: microchip: disable EEE for KSZ8567/KSZ9567/KSZ9896/KSZ9897.")
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

