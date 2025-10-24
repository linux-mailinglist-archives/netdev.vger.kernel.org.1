Return-Path: <netdev+bounces-232356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4138DC048C1
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 08:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D93E3BAADE
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 06:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7DB273D6C;
	Fri, 24 Oct 2025 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KYtGg25+"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827A51EE7DC
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761288267; cv=none; b=Q5ea39D3set9YtI5AaPs/XP6w04FxUvm7BbGHLPE/Q5LRsSaxblI5i5OgFw+HsAgmeQVaVZbois0jKw2EPCeM1z5dg+dTr3VlLEQ2PdAlUd/RVjuE3Ow/zGMoMI4ZRfrZRhfNcUcs+ExNVARk9sBneu/YUPvTkF2XUA2ElFbp8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761288267; c=relaxed/simple;
	bh=OMrkExLxeo5n6zdxsI3+y2dFchD/7zAtf9EgEGt265Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8QIRKLpSh33VvjwYaSf1yU7OM4D0XBqQGPN4DmKdRdc4z2OjXb34ZCUDU1pIjoTtAier/lzUmfnflpPT3VJUfLkEFNzxo5kd4emz0BG7YsVSK+6hN84PNv+CkV/Mna6uA99urPLlITwgiDRwg+onkNUh8m4tSy/UwtQ0TFfAJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KYtGg25+; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3A3BD1A1636;
	Fri, 24 Oct 2025 06:44:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0E44660703;
	Fri, 24 Oct 2025 06:44:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 689A9102F244A;
	Fri, 24 Oct 2025 08:44:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761288259; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=23XHfjip0xavJrBGmNRM/VDGO8Z67OrHnHQ9YooOSIE=;
	b=KYtGg25+hcycycAL+yfAnApj7zKCwrcjHD0C1XmCTEWz6G7WnS9cc30XTSyOgJ7icxC/Rk
	BqgI0luB56xoC4ypAxklxqw+6dS0yUfe7IIHk658RN8QGGhIaoGUoyCH36Ds/llVKwuL2G
	cyXkCiSkeGeITCYPhWpveysp++p/PCtKkPKbcYWiK1O9O1S2hTqj3/KiknDuIrbPbEwx8N
	9f89N0J4qw/LPTkrbdvkIapLZMRr96Mp0gc71NlRrw8JLnVAG48SlzxBF5BCoE0yj4PYzr
	Lm2PpayjuUmiKTH+iCuMujhGHnik45A6axwDm0WHsU+hp71f45Jyrhhu62cuqA==
Message-ID: <28d91eca-28dd-4e5b-ae60-021e777ee064@bootlin.com>
Date: Fri, 24 Oct 2025 08:44:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/8] net: stmmac: hwif.c cleanups
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
References: <aPn3MSQvjUWBb92P@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aPn3MSQvjUWBb92P@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Russell,

On 23/10/2025 11:36, Russell King (Oracle) wrote:
> Hi,
> 
> This series cleans up hwif.c:
> 
> - move the reading of the version information out of stmmac_hwif_init()
>   into its own function, stmmac_get_version(), storing the result in a
>   new struct.
> 
> - simplify stmmac_get_version().
> 
> - read the version register once, passing it to stmmac_get_id() and
>   stmmac_get_dev_id().
> 
> - move stmmac_get_id() and stmmac_get_dev_id() into
>   stmmac_get_version()
> 
> - define version register fields and use FIELD_GET() to decode
> 
> - start tackling the big loop in stmmac_hwif_init() - provide a
>   function, stmmac_hwif_find(), which looks up the hwif entry, thus
>   making a much smaller loop, which improves readability of this code.
> 
> - change the use of '^' to '!=' when comparing the dev_id, which is
>   what is really meant here.
> 
> - reorganise the test after calling stmmac_hwif_init() so that we
>   handle the error case in the indented code, and the success case
>   with no indent, which is the classical arrangement.
> 
>  drivers/net/ethernet/stmicro/stmmac/common.h |   3 +
>  drivers/net/ethernet/stmicro/stmmac/hwif.c   | 166 +++++++++++++++------------
>  2 files changed, 98 insertions(+), 71 deletions(-)

I didn't have the bandwidth to do a full review, however I ran tests
with this series on dwmac-socfpga and dwmac-stm32, no regressions found.

For the series,

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

