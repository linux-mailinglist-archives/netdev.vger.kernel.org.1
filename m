Return-Path: <netdev+bounces-251087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 668DAD3AA32
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39149303C608
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033B1368285;
	Mon, 19 Jan 2026 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WL75Q6Jm"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AFC36921C
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768828842; cv=none; b=lsuYNmUKBWUO5vSFd77Hm4tQMBuGjk++a7mH46NEdlWd6UIcH9I883ZuayAQ6Qm1cOaesz3iCtITwUE0tUNDu10vwbG698LkNSW7qiEaX/1pzwIDbvZbc9jWGSSP5MYK2U8kIy/gXdDrZlheKhXJem4tAUSGXAlFf2wM0hkXE20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768828842; c=relaxed/simple;
	bh=EQOm3MNiQSsW5rdGkmOFnTGQUr1SnAsHfKkJRxBdDhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jE/62Eu3gHYJXfdy/vkcuhjJlNh4h/Y3bShuoIDbk5NnoBoum/Pwy5n43AE0XoN7NQ0QCQ8Iuii6JjOnTa8M8KaUwhlvDhxwcutkOGBoBukLoq1Ij1q+xK/wOkWYC1CxaWfIZ1HHX6IWiI0n8J6OBATwV/QgYhqvOQITlV7dbDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WL75Q6Jm; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D86C11A2951;
	Mon, 19 Jan 2026 13:20:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AA6D560731;
	Mon, 19 Jan 2026 13:20:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 80CE510B6AFE7;
	Mon, 19 Jan 2026 14:20:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768828837; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=C88mVe4i3Z4l63ZcsasxWSNQLM5vvDv1/QRFfBQNgwM=;
	b=WL75Q6JmD/2Sm5piBoIA+v8gzFbjTwJz0lP7rJVdDU/Ayn+q92uePzNzCiiQNAK2CP8PRv
	ip3puZqFUHQg/9mIUqwTeSVahXjqKCGNhc/JiVR8jMg+ajzSzfDatEi0wQmTIp4Mq1xZ9z
	WvtLjHEhcnLeN2PVZCCdFgPXIqr20jYnFAVWKJJL8nPDPHvCz2VdqlrpDEyq0F3TWU2iA5
	YpKxcvARPFMLIs5De1S9LNSH57XWzurdG/MYqhgDwYsBj4xV4eyi4/nhu6/D2fufTQELal
	PeUDVjASw+xlDH/vuc62zUY42q5wgihzdX/qC9tWoWwh5m+oJRVc5Z/dSkALKQ==
Message-ID: <c6d88377-2b0f-4535-96b1-3eb01efef709@bootlin.com>
Date: Mon, 19 Jan 2026 14:20:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/14] net: stmmac: use integrated PCS for BASE-X
 modes
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
References: <aW4kakF3Ly7VaxN6@shell.armlinux.org.uk>
 <E1vhoSh-00000005H29-1LYk@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vhoSh-00000005H29-1LYk@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 19/01/2026 13:34, Russell King (Oracle) wrote:
> dwmac-qcom-ethqos supports SGMII and 2500BASE-X using the integrated
> PCS, so we need to expand the PCS support to include support for
> BASE-X modes.
> 
> Add support to the prereset configuration to detect 2500BASE-X, and
> arrange for stmmac_mac_select_pcs() to return the integrated PCS if
> its supported_interfaces bitmap reports support for the interface mode.
> 
> This results in priv->hw->pcs now being write-only, so remove it.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime



