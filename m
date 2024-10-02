Return-Path: <netdev+bounces-131300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0334F98E089
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDBA428B689
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2611D1E74;
	Wed,  2 Oct 2024 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEC9f5UC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144AA1D0E1F;
	Wed,  2 Oct 2024 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885934; cv=none; b=ptdjXTvckO9MtaOgRqw0lwPG5rJGb7GKajJTml9eISoBaCPd3xkaYuW92+jzMlOXh+LR8hfJl5Ffg1EpR5/yI5gOMRTlfGKhbr+OvGQ3mriKpo91hdPHauiPBsJZOA8QM/C6P+nsUMtj608JNIG8Dp95tp3TcgXNfcln4zPq+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885934; c=relaxed/simple;
	bh=nVwbrYqujbJZojyB6Y+EkcNID7ORFdWYj7bFLa0mTTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F56HY5sHCiGjmp3pZs1NnjK3ByyZpDdy9MH2TXkPW1Xy61ss6xpv245UtSEz5OPL+wQ6WgDIktMLTD+Uiek7UtxTwwYPfQ5bmT9ZlovwpkwX6W7L/ESUCxPoFfH7SsOXDeN6r7+hKb9JF9QoZZj0Xk+V+8sjlrlG+ZdWp3F1XY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEC9f5UC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB85C4CEC2;
	Wed,  2 Oct 2024 16:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727885933;
	bh=nVwbrYqujbJZojyB6Y+EkcNID7ORFdWYj7bFLa0mTTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XEC9f5UCepNUGLMjWYSgzJqVJpcxG0qONVlJlXXbx3t+B0l7MHgS3zQtL1ERE4TNp
	 xAkxS95XE5SKJaFQLunuik+XAPIIzawnzXl0N6BP6bMYjcMdIpHwLNmz8x3UKA/5Fj
	 lH0ZcZ78asZaI7CbgftPUWvBTmG/ZKuMnCHDiBSeyHNNfmaf5urnBZOdu2N8Dwf1V0
	 vO7QgmDOk/6NO0RVxaRPotAWVcSgrp/lzmtiHuzwdTB008tIPN/RGTsDHJceUcssCH
	 u35LNxlXgnw5dfDuWHi+BnpeJtIM5PvXDYBMuGKNl+4GUvSqKkGX18jUHwy5WMwxcd
	 IU3H0Sva+4zLA==
Date: Wed, 2 Oct 2024 09:18:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Florian
 Fainelli <f.fainelli@gmail.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v1 1/1] Documentation: networking: add Twisted
 Pair Ethernet diagnostics at OSI Layer 1
Message-ID: <20241002091852.3437dd7b@kernel.org>
In-Reply-To: <20241002084926.9531-1-o.rempel@pengutronix.de>
References: <20241002084926.9531-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Oct 2024 10:49:26 +0200 Oleksij Rempel wrote:
> This patch introduces a diagnostic guide for troubleshooting Twisted
> Pair  Ethernet variants at OSI Layer 1. It provides detailed steps for
> detecting  and resolving common link issues, such as incorrect wiring,
> cable damage,  and power delivery problems. The guide also includes
> interface verification  steps and PHY-specific diagnostics.

build complains:

Documentation/networking/diagnostic/index.rst: WARNING: document isn't included in any toctree
-- 
pw-bot: cr

