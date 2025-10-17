Return-Path: <netdev+bounces-230490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38949BE91F3
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 16:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380D21AA2009
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 14:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4565232C928;
	Fri, 17 Oct 2025 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Arpm9A9O"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F88A32C924;
	Fri, 17 Oct 2025 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710456; cv=none; b=dcXNXUp04YIlueYkiEbKeYIms+FF6e/ltAYNa6C1UGcItXviEGHpfnqFmh2LpOEBONPRy2WhFRrkU6Er/SHny0aUSw7EGKJwSBj0cxR+CXyE+CQxPfuL7uwNMmsIUwPIQmNKj8NwKUfG5MZoaBg+hthhucBGEX6WTGsif90PHq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710456; c=relaxed/simple;
	bh=QYQqRTcp8A/geB7A9/E0yxzmXaEU4W1lxA8D4eW1+oA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfhVNCcDxhEGfsnExW+8oY+3epCzQT6yZ3XCHJQl2dGyn03Hb2mTQyHX3PktkCrmHvQG0Of+HPNmK4h/TbIsOeRfDW8ZVqqDZN92feeGhYjKQgR007MxfzMGePqStiJg88ARyJDR9g4udHdSO8IYcrxpMRBc5bDxR8iWJZXRCX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Arpm9A9O; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 800384E41144;
	Fri, 17 Oct 2025 14:14:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4CBB6606DB;
	Fri, 17 Oct 2025 14:14:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B6758102F235A;
	Fri, 17 Oct 2025 16:13:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760710445; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=MuAoz+V2YdChsKDB39UbimB2KEWOPHvxJjC4UXDWnig=;
	b=Arpm9A9OBvgEKac+NiV1ZGQn15/YYbia7KI4e1jFMpKpOU0TTJdEpbNdI2hnjdUJVhT7yb
	PvsJv9qGJn5HA4Ehfp7rW7Q1wuse5EcZSRA9e1Lvci6rPhqkJ8kVH14PmNNdhjmGIFZH8n
	WidX9RUsOVCBymMSMx7+GQgq/OTQPbDIvzhDN+U9xFIwkiE55WOxYmRajK/LiygrEyTRhh
	5I8n0StC23Z5eQ47cw6OEqmKsZ+0lcxW3pXxbGCHR0EEIT6xtJnskYuVbbERq9CgddhxIu
	aqnRPdydrgnPjN2mGcPwHOSaDeJQ864Aq0AWwetufhuOmzgViXxiqIsNv/xAWQ==
Message-ID: <3e268abd-620c-470b-ba3b-222a0c39cac5@bootlin.com>
Date: Fri, 17 Oct 2025 16:13:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/5] ethtool: introduce core UAPI and driver
 API for PHY MSE diagnostics
To: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Kory Maincent <kory.maincent@bootlin.com>, Nishanth Menon <nm@ti.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 linux-doc@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
 Roan van Dijk <roan@protonic.nl>
References: <20251017104732.3575484-1-o.rempel@pengutronix.de>
 <20251017104732.3575484-2-o.rempel@pengutronix.de>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251017104732.3575484-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Oleksij,

On 17/10/2025 12:47, Oleksij Rempel wrote:
> Add the base infrastructure for Mean Square Error (MSE) diagnostics,
> as proposed by the OPEN Alliance "Advanced diagnostic features for
> 100BASE-T1 automotive Ethernet PHYs" [1] specification.
> 
> The OPEN Alliance spec defines only average MSE and average peak MSE
> over a fixed number of symbols. However, other PHYs, such as the
> KSZ9131, additionally expose a worst-peak MSE value latched since the
> last channel capture. This API accounts for such vendor extensions by
> adding a distinct capability bit and snapshot field.
> 
> Channel-to-pair mapping is normally straightforward, but in some cases
> (e.g. 100BASE-TX with MDI-X resolution unknown) the mapping is ambiguous.
> If hardware does not expose MDI-X status, the exact pair cannot be
> determined. To avoid returning misleading per-channel data in this case,
> a LINK selector is defined for aggregate MSE measurements.
> 
> All investigated devices differ in MSE capabilities, such
> as sample rate, number of analyzed symbols, and scaling factors.
> For example, the KSZ9131 uses different scaling for MSE and pMSE.
> To make this visible to userspace, scale limits and timing information
> are returned via get_mse_capability().
> 
> Some PHYs sample very few symbols at high frequency (e.g. 2 us update
> rate). To cover such cases and allow for future high-speed PHYs with
> even shorter intervals, the refresh rate is reported as u64 in
> picoseconds.
> 
> This patch defines new UAPI enums for MSE capability flags and channel
> selectors in ethtool_netlink (generated from YAML), kernel-side
> `struct phy_mse_capability` and `struct phy_mse_snapshot`, and new
> phy_driver ops:
> 
>   - get_mse_capability(): report supported capabilities, scaling, and
>     sampling parameters for the current link mode
>   - get_mse_snapshot(): retrieve a correlated set of MSE values from
>     the latest measurement window
> 
> These definitions form the core API; no driver implements them yet.
> 
> Standardization notes:
> OPEN Alliance defines presence and interpretation of some metrics but does
> not fix numeric scales or sampling internals:
> 
> - SQI (3-bit, 0..7) is mandatory; correlation to SNR/BER is informative
>   (OA 100BASE-T1 v1.0 6.1.2; OA 1000BASE-T1 v2.2 6.1.2).
> - MSE is optional; OA recommends 2^16 symbols and scaling to 0..511,
>   with a worst-case latch since last read (OA 100BASE-T1 v1.0 6.1.1; OA
>   1000BASE-T1 v2.2 6.1.1). Refresh is recommended (~0.8-2.0 ms for
>   100BASE-T1; ~80-200 us for 1000BASE-T1). Exact scaling/time windows
>   are vendor-specific.
> - Peak MSE (pMSE) is defined only for 100BASE-T1 as optional, e.g.
>   128-symbol sliding window with 8-bit range and worst-case latch (OA
>   100BASE-T1 v1.0 6.1.3).
> 
> Therefore this UAPI exposes which measures and selectors a PHY supports,
> and documents where behavior is standard-referenced vs vendor-specific.
> 
> [1] <https://opensig.org/wp-content/uploads/2024/01/
>      Advanced_PHY_features_for_automotive_Ethernet_V1.0.pdf>
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

This looks good to me,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


