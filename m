Return-Path: <netdev+bounces-247025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 447A3CF38EB
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 13:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D72730A32F3
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 12:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7DD337117;
	Mon,  5 Jan 2026 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FIz/icMe"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CD232FA35
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615838; cv=none; b=Xb+DC7B2riq6kXR7W9XP8JTIYOwYhdbBMhD36Ti+BOe799d6sOBOSzllTdqlTr2V3LgndE7y7jLyXRy3yOzvoKtyI1H8cj7GCucUl9Grk9k2qGoSDuUXzCIrCvAy6wJhQTHBbriFdyr1Oxau4cBt9k/zRHeeEWPN0dK1G0Liows=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615838; c=relaxed/simple;
	bh=jPnrVfAStRcV3rJ4+UMIksNxRfQShN7cPYUKs4GBfh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPDPvSr+8sXlG3sTagzbH5lWD3U9FMOxVRXUpRGCGzDx/s+7DgWcQof0pGHJ9SHJbcYJXuS/BWMU61v1kGfsQeAr1e0v7eriCfUDhVSXpaKl/ZfuAHorbGz92vXGvGgs4Ldq/lCfDv1gmUPQilhzufqqiDry9s9YmkgSrZN+R+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FIz/icMe; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 85B8F1A265C;
	Mon,  5 Jan 2026 12:23:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 577A160726;
	Mon,  5 Jan 2026 12:23:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A20D6103C84B1;
	Mon,  5 Jan 2026 13:23:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767615833; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=FxpdO0xpWYZr7zB9MVuZ7HLTobH136C3wl/FyW9od7w=;
	b=FIz/icMez1d+ePM8dPLynyFAZ0VZUgZUVwQmgrS5dlyfwgWOzS5LVCQpryCHkxR0zI11IM
	yOG/CSoXOXKkF13aNNmD35yHbAVkVzgpZAXPp8tGpUnG/49mZ1FYUPgzWVpkqbuKnTHYL9
	V4GaBgOT2jjloT6fuRpCF33j8pot7Uz8+EuOiwbo5tE/U5Fxpsa4aCvUdOdYflSqrwi5U4
	7booT3XccwZhIOmukcC05CxR7nlIFVhZ2a+VLMp+dd5xmvmEibXEHJ4N6BuKygHAwpwHbI
	O1ll3n3AKmmK/ipDokyyxgBlU8Nw81oM6nLE5zIt3iTIJxHQqgEt/3mdDocuIg==
Message-ID: <6ee0d55a-69de-4c28-8d9d-d7755d5c0808@bootlin.com>
Date: Mon, 5 Jan 2026 13:23:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v2] net: stmmac: dwmac: Add a fixup for
 the Micrel KSZ9131 PHY
To: Stefan Eichenberger <eichest@gmail.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, linux-stm32@st-md-mailman.stormreply.com
Cc: netdev@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 francesco.dolcini@toradex.com, robh@kernel.org,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>
References: <20260105100245.19317-1-eichest@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260105100245.19317-1-eichest@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Stefan,

On 05/01/2026 11:02, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Add a fixup to the stmmac driver to keep the preamble before the SFD
> (Start Frame Delimiter) on the Micrel KSZ9131 PHY when the driver is
> used on an NXP i.MX8MP SoC.
> 
> This allows to workaround errata ERR050694 of the NXP i.MX8MP that
> states:
> ENET_QOS: MAC incorrectly discards the received packets when Preamble
> Byte does not precede SFD or SMD.
> 
> The bit which disables this feature is not documented in the datasheet
> from Micrel, but has been found by NXP and Micrel following this
> discussion:
> https://community.nxp.com/t5/i-MX-Processors/iMX8MP-eqos-not-working-for-10base-t/m-p/2151032
> 
> It has been tested on Verdin iMX8MP from Toradex by forcing the PHY to
> 10MBit. Without bit 2 being set in the remote loopback register, no
> packets are received. With the bit set, reception works fine.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

I've also faced this issue, however I'm wondering wether this is the
correct approach to fix this. It seems that all Micrel / Microchip PHYs
have this behaviour of discaring the preamble at 10Mbps.

Some of these phys have accessible control registers to re-enable it,
however this register/bit changes depending on the PHY model. For
example, on KSZ8041, this is register 0x14 bit 6.

We may end-up with many many more fixups for this, basically for every
micrel/microchip PHY.

Wouldn't it be safer to just always enable preamble at 10M for these
PHYs, regardless of the MAC that's connected to it ? Is there any risk
always having the preamble there ?

Maxime


