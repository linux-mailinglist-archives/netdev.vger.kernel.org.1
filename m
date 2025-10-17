Return-Path: <netdev+bounces-230494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C60BBE9302
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 16:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87E66E0F71
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 14:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE53D339717;
	Fri, 17 Oct 2025 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ul8m4Qee"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3F5339706;
	Fri, 17 Oct 2025 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711275; cv=none; b=OcnUXcqGoXe+1r5l9Ni7qVamtljBvCXenBdiljiqzkfyWpM6Gnm7QdhDmJt/bnzKqzjyCUGSgJvkRI4tdbvNQdxSoZpSJldDS55hpvdrhqluFpe+h00+e6lgQKwPnSHRZJCQ7dNJuJWnfezpki69FT9osbE1bA8zTPNMJm4tiDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711275; c=relaxed/simple;
	bh=JWUuXmlNo3cMzbCVbs4PnRfFt/SmdSLZ7lxH4CFw8Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iWuFa/MF48po90K6BlkgzAH4UORxAxbQiNkLlrOsvQWNtNxmjhHXHJ3rRVSG+JM/YJIQownRQ99Pa+iMZf6o5qGABX7Mp3U+b5lXUXzK5M/Zt+gZjSHzMOT5nzrFn35cDxc7wCSeP6+rdOWh/1zFwounbt7dpxBehzc0sUhQ+LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ul8m4Qee; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B1F154E41145;
	Fri, 17 Oct 2025 14:27:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 82057606DB;
	Fri, 17 Oct 2025 14:27:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 862A0102F235A;
	Fri, 17 Oct 2025 16:27:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760711270; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ZexStoA/TzhtuUYik1P+asxrImB9WQ4M1cxs+bOxqkE=;
	b=ul8m4QeepyRKKZLrig8GA0T6QD7QIivEoNKhBSdBT6OeMAS9nAfQwfey44BTg0vA/sKDJ5
	fbI0ajli7HF1jBm8w4BOeFzo0Frvp9klkd0gdLYisZ91hHCHS9axhBw1vBfSlyRDEX6W1H
	Iub1MoxU1OlgEHdOMXWzUsvDyY3Un9ru5poEUBYEDFF2C5rmyVkanBylhyZ6tIyqhxlLCi
	7h87PIuwKcYHhGAAjjHfUfKKTi59lm7duW3djPaLsSWznLfzoL2xFYnIZ3zImYzF9Ga9tf
	OHfx/C0hnhi/21CHS4htcjhkQra6ld6bKH5HtG6ApyjJ7kOW6juRz1B/5qcJRw==
Message-ID: <ebc5327f-49b6-4135-bdbf-c5007f3f97ac@bootlin.com>
Date: Fri, 17 Oct 2025 16:27:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 4/5] net: phy: micrel: add MSE interface
 support for KSZ9477 family
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
 <20251017104732.3575484-5-o.rempel@pengutronix.de>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251017104732.3575484-5-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Oleksij,

On 17/10/2025 12:47, Oleksij Rempel wrote:
> Implement the get_mse_capability() and get_mse_snapshot() PHY driver ops
> for KSZ9477-series integrated PHYs to demonstrate the new PHY MSE
> UAPI.
> 
> These PHYs do not expose a documented direct MSE register, but the
> Signal Quality Indicator (SQI) registers are derived from the
> internal MSE computation. This hook maps SQI readings into the MSE
> interface so that tooling can retrieve the raw value together with
> metadata for correct interpretation in userspace.
> 
> Behaviour:
>   - For 1000BASE-T, report per-channel (A–D) values and support a
>     WORST channel selector.
>   - For 100BASE-TX, only LINK-wide measurements are available.
>   - Report average MSE only, with a max scale based on
>     KSZ9477_MMD_SQI_MASK and a fixed refresh rate of 2 µs.
> 
> This mapping differs from the OPEN Alliance SQI definition, which
> assigns thresholds such as pre-fail indices; the MSE interface
> instead provides the raw measurement, leaving interpretation to
> userspace.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

