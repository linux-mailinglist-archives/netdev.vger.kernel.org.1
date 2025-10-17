Return-Path: <netdev+bounces-230493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8EEBE92D2
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 16:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A81C1509417
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 14:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAD4339700;
	Fri, 17 Oct 2025 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jnc3onl5"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766BF3396EF
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710853; cv=none; b=HyrJqRZFAMdrfJozi2HDLjgnJ22IoG2KWB2Cy9LtjTDLbKM8jCzVa60ylJLdpNiuzl6n03mtNyalW7AJmEiYuxAKB99Gi/pjlT8CPPDKYNZSdMWg4blazlzKVAKWGfl0s7hOGxcY/v/TceaS1Ciwr6+IBo8VPoYGbzWR38WR58Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710853; c=relaxed/simple;
	bh=NHEs4deoFlHNHXkObarOXeyfQfRJx+3wPu4wvN9SSQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uB8utTANh5NFa/fPlAupG22oGhQDcwqfg18+QO/haBMwl/Fa6NPOVbt/QqCujCeVdCvA6GLLFua9NJAnRcBv2HzUl61sAgGEiBybsGRW9y0Fex/Vu1SAyb0lVAKIXt95oD9efeBsGOgIQ4TUDB9Q30KVT6yIeEHJ9B8J9AfTgeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jnc3onl5; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C0BDD4E41145;
	Fri, 17 Oct 2025 14:20:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 85520606DB;
	Fri, 17 Oct 2025 14:20:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ECD4C102F235A;
	Fri, 17 Oct 2025 16:20:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760710847; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=WP8xAx5y5Q+en2HjpM/S//PGC9EOcpc+v4pYyxBt5tg=;
	b=jnc3onl5q+49Om+bXyHOC5NwC2Wq1Sp3mVfoUEzYrSf06fXpl/VIG61k8Zk3lvCTrBRr/f
	M7XIlnCscTv9n1hcM13FaOKfsHB2jRY0/ADO291zejogtuE3qHpxohZQI8G2w3d9/Fxvdm
	+HGDKtozbLTrUgJMM9uPUAV+EUG5CmvijeoB2fnR+eAzPewiYPq152g4Yh/qI7UDDvj2RA
	8g4jAtjXJYQcySMcVaMKBPVD+lw906WDo+xMTA3L/wzKilBilw+WmBtA8yY2ANFLFc2XTd
	OIUcKjahGT1LY2uCjJ0fxfYT9oqdozYGZPY13DEyoH6EES5eMtw59csC5sTH8A==
Message-ID: <fb45668f-e13b-4a90-b0aa-e989e19b3c37@bootlin.com>
Date: Fri, 17 Oct 2025 16:20:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 5/5] net: phy: dp83td510: add MSE interface
 support for 10BASE-T1L
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
 <20251017104732.3575484-6-o.rempel@pengutronix.de>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251017104732.3575484-6-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Oleksij,

On 17/10/2025 12:47, Oleksij Rempel wrote:
> Implement get_mse_capability() and get_mse_snapshot() for the DP83TD510E
> to expose its Mean Square Error (MSE) register via the new PHY MSE
> UAPI.
> 
> The DP83TD510E does not document any peak MSE values; it only exposes
> a single average MSE register used internally to derive SQI. This
> implementation therefore advertises only PHY_MSE_CAP_AVG, along with
> LINK and channel-A selectors. Scaling is fixed to 0xFFFF, and the
> refresh interval/number of symbols are estimated from 10BASE-T1L
> symbol rate (7.5 MBd) and typical diagnostic intervals (~1 ms).
> 
> For 10BASE-T1L deployments, SQI is a reliable indicator of link
> modulation quality once the link is established, but it does not
> indicate whether autonegotiation pulses will be correctly received
> in marginal conditions. MSE provides a direct measurement of slicer
> error rate that can be used to evaluate if autonegotiation is likely
> to succeed under a given cable length and condition. In practice,
> testing such scenarios often requires forcing a fixed-link setup to
> isolate MSE behaviour from the autonegotiation process.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


