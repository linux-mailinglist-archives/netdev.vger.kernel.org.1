Return-Path: <netdev+bounces-225629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FF4B96276
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B9C3A1ABA
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 14:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E66A219A8A;
	Tue, 23 Sep 2025 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mmfI7w5e"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E81C1DF994
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758636612; cv=none; b=H0uXQEgNOfoEKOLFFW35rKtdYLwUkLH/d4NR3jaGCfg4UmpLKmEuRkBe8qUQUpbbXNSdv8F2NomsnY5nH+fWFywNvFT1SaiFowkqB2F/vWXG9Gbog0NrencupLoV7TY9SXzrF1SZ4CKysul0dudtMuHeVfXfUprqYZMxmEHge0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758636612; c=relaxed/simple;
	bh=9WCf9bmBIBRqk22K93pUAM9eZ7SWbnvhwGOnYi0z6zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/aYlDjftW3g9l2tQgg5xSkVMB6j56BTFwYjWeIJCtLewBbTBAv/oC7g0C8Z4Uu7Yk9eEKRO/xHGh7sSvOFUE9ETphBUkkcoMfoGhnpDQchWDZXS6K1Pv2VPG5ppzCfxFpgUyBYR/lqbjKOqCgpL+gwurcVEx3kB7aJjqw4Z3ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mmfI7w5e; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 09A05C01FB4;
	Tue, 23 Sep 2025 14:09:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0686760690;
	Tue, 23 Sep 2025 14:10:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ABCC4102F190F;
	Tue, 23 Sep 2025 16:09:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758636606; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=4DukHAljRLEAyr8m6U7o38VUfR/uV1WnyVeEUjrVjW8=;
	b=mmfI7w5e/fwO1dbJfiJiKTFlDB6GlSMiPyPvV6nfqszIXotRRsr+okXrUUyjKmjPkhKC3+
	RoVtHl9f9Ak9LRf/4iRwBY+ykJZRkgXIBLbXwYejGDdHv1/5HE/zBD2hDPv22jW9Gcmtxx
	wWM9/GxDOqyi5cb9s3Y31468ZB1Z5T5zy1mFKKWkOTd7gyq0IeHTY5I/eenH02wd91XYIS
	xGnaTwuBKX0PwhLAQA8tTdQ9Ouv63mePARKs6grtbizYG7z9xB/cvvIm0DRtAn4/FE4GIQ
	6KlL35wkYLyM8d9AU72fjBOwxEy5/4fPxLjJwEbiZVVEjxBNxGawI1O2g1LIIg==
Message-ID: <bf7f7637-dfcf-41fd-aff3-82a0ecac4db9@bootlin.com>
Date: Tue, 23 Sep 2025 19:39:34 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/6] net: stmmac: yet more cleanups
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Russell,

On 23/09/2025 16:55, Russell King (Oracle) wrote:
> Building on the previous cleanup series, this cleans up yet more stmmac
> code.
> 
> - Move stmmac_bus_clks_config() into stmmac_platform() which is where
>    its onlny user is.
> 
> - Move the xpcs Clause 73 test into stmmac_init_phy(), resulting in
>    simpler code in __stmmac_open().
> 
> - Move "can't attach PHY" error message into stmmac_init_phy().
> 
> We then start moving stuff out of __stmac_open() into stmmac_open()
> (and correspondingly __stmmac_release() into stmmac_release()) which
> is not necessary when re-initialising the interface on e.g. MTU change.
> 
> - Move initialisation of tx_lpi_timer
> - Move PHY attachment/detachment
> - Move PHY error message into stmmac_init_phy()
> 
> Finally, simplfy the paths in stmmac_init_phy().
> 
>   drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   1 -
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 111 ++++++++-------------
>   .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |  32 ++++++
>   3 files changed, 73 insertions(+), 71 deletions(-)
> 

For the series,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks for the cleanup,

Maxime

