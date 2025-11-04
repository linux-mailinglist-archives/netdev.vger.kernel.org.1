Return-Path: <netdev+bounces-235402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C08C4C300BD
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 09:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25683B3239
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 08:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CCF3126CD;
	Tue,  4 Nov 2025 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yNQSfwGH"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCE3306488
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 08:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245611; cv=none; b=K/sfqscxioulAm4KGLEJCJRSPqu2t2wwfMr6wbiSSv55VTt92syU2zZHD5lycfVdJvkE4edLJUG2lQqDHDfkxd39llaMDsFUqSyBHj4Gm58756vUtFO/CNp42YP3ndBOlwFS9KKr/AG0oMcaqKfsQvzyJz493QR0hO7KNuL2hlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245611; c=relaxed/simple;
	bh=fOmfcSFF9A1Q4Y/7H3SLjp+jb4/7FYshcOnLc5T7Cmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxFJxfnsu/tdZrd3NflOsME+v2g0PrFPkLJ2G/AjHPmlTUKdL0eyire9ip/z+KziDcLgxwxLSQtyuEOwVWQU8PvxjYWlzVb5nsSMlZ9t8hyADi4im2LpJ0T7QVj3Vzb6qQrhbNNP8Fy895UWNw1dyJvpEos3+mm6/vCamSUaAv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yNQSfwGH; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4B051C0E605;
	Tue,  4 Nov 2025 08:39:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2A1DE606EF;
	Tue,  4 Nov 2025 08:40:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9391010B50942;
	Tue,  4 Nov 2025 09:40:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762245606; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=1GrrzAVKwbhM2pwwU4cPrm0agxpTJFh+xbdqY2wuQCU=;
	b=yNQSfwGHj87xTdQw0a8qYLTgJA7hD2zEh0mAs9K//sl1zoCY3GSiYzaUG/7P9jloJlmpnr
	a2heFhhbOjTKI+KDbIampUvBPGWiDOjCKiLCn4DjqMjQcwjo/31JgOwhV5o94iproYdqRN
	GpOpLGeImB1tCfi0d45GqkqLHMS31lrp7XiBm6qENt0zoNjYt1BUqkpE+0VWogmqozp0W5
	b7CZvN5izyBVZ2AJBl6P5152ONvNgX7ZDeRdrbnEd/buKSUBtVnSloZAGeEbydfk+5CQCk
	TLR3hNmXQl+2wiM0aIHvzl93bI+Z1pcie7e7BHSjJoN0kKADb3RhzNKunfbNcA==
Message-ID: <dcd43a79-9858-46ad-9331-44b222ca26dc@bootlin.com>
Date: Tue, 4 Nov 2025 09:39:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/11] net: stmmac: s32: move PHY_INTF_SEL_x
 definitions out of the way
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>, Jan Petrous <jan.petrous@oss.nxp.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, s32@nxp.com,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
References: <aQiWzyrXU_2hGJ4j@shell.armlinux.org.uk>
 <E1vFt4S-0000000ChoS-2Ahi@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vFt4S-0000000ChoS-2Ahi@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 03/11/2025 12:50, Russell King (Oracle) wrote:
> S32's PHY_INTF_SEL_x definitions conflict with those for the dwmac
> cores as they use a different bitmapping. Add a S32 prefix so that
> they are unique.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

