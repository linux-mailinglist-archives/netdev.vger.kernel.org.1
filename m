Return-Path: <netdev+bounces-247324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9938FCF755F
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 09:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E31953022F0C
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 08:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BBC309EF7;
	Tue,  6 Jan 2026 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xtJTlPZr"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371DDDF76;
	Tue,  6 Jan 2026 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767689102; cv=none; b=hlfhVb52NzLym74nptEyGS6IsIh1DMwQgE0y2BhM6+zTrmif5lnHqPPmCR5BaUsyxwjYRyvhgGxTMjNTYHVhjqqKfcG8MrNhEd7FfrmPUYbdrUFtDmMe82YxQ447fqAL2b+gjQnVlJ3g4mZcBHegDPmA6UjHKDCeTYl8e/DjxH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767689102; c=relaxed/simple;
	bh=94bAVZ52l0KeJaZiEMSm/OASvaUJtYZtqxylN11cdcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G59XsmdeGQrgrsEGdLlV8LODJg8TG0stIzsUbMrvSQ84SpJ6Bbz4CnnZcPXwfkL/IW1cBmf1At17Z5YLmYOJ1boAgGOAVf08PPSvBOL5kk4WZPNL+67+JHBUUMkNuQ9tXOmdnoHtNoL4x/RJPJuLGE52oj4KP5wvoHv/7RhvfCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xtJTlPZr; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2D536C1E4A6;
	Tue,  6 Jan 2026 08:44:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 27A8260739;
	Tue,  6 Jan 2026 08:44:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA65A103C8144;
	Tue,  6 Jan 2026 09:44:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767689091; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=tamMdge4qbsDWP+XZCmZSUNv3pozpuz2jKgDkw1Lk/4=;
	b=xtJTlPZr7MGvTIQfcBMHcsgDXGaeuE+y6On4q2uscEfxBNs9yTcAJC0HP6OyFv1mLrRkGw
	7Z1TibJso+LQnBlQwZqoz825oY9dy9m84fcgtNhsaF1rXAOMvIe3EyveRGcExoAaX9OFYx
	0SdLp3KGeT0NcfQFoie4iHpnsLIfwBYzRU2szeYMFOJe/RIB6qav4cSJ/u027jpvkOGTvw
	21gCYSpa52o5Va4eO4O9KRPZldUnSEbiNPwqZTOFfIZDBGrY9R3inoJeTKgenjZmUdi4eD
	6pnb2mfC+6xdvkSgkUc5AAano+RxvzMFagAeFqrkjQ3hSWkk43KP28lRKugzPA==
Message-ID: <2c63fc58-7081-4e6b-a8ee-3d1e9aaffbe9@bootlin.com>
Date: Tue, 6 Jan 2026 09:44:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/5] net: phy: realtek: fix whitespace in
 struct phy_driver initializers
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Michael Klein <michael@fossekall.de>, Aleksander Jan Bajkowski
 <olek2@wp.pl>, Bevan Weiss <bevan.weiss@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1767630451.git.daniel@makrotopia.org>
 <42b0fac53c5c5646707ce3f3a6dacd2bc082a5b2.1767630451.git.daniel@makrotopia.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <42b0fac53c5c5646707ce3f3a6dacd2bc082a5b2.1767630451.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Daniel,

On 05/01/2026 17:37, Daniel Golle wrote:
> Consistently use tabs instead of spaces in struct phy_driver
> initializers.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


