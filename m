Return-Path: <netdev+bounces-19335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B7775A4FD
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 06:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9BC3281461
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 04:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DD61C04;
	Thu, 20 Jul 2023 04:12:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A391843
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 04:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72A6C433C7;
	Thu, 20 Jul 2023 04:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689826357;
	bh=3AHdDFL2C0BAHYVyKANj1zL7AGecfNpV115jPkuHkwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HCpndoyA8eGRaZwEAIZ5eAIvWa1UeWuwHoS8+lWLp7Or7/SKZsbhFOBSgobJo0rJL
	 MAhkyCABXiwnAJGHJIxevi8/sd+j+nNXbDZBW1ReYpK3kVjNe9aNcWMtgFWxgs15Ld
	 PiTvWapDgxWT1hKwb65i8shckyB9ULl8Y7lRAajvc31XUrxRnhJnB35XYnRv793Ti6
	 gqwZpyFe+A9XhecDDAbpOsKcrRhXSC+b5etDY8PhHsVu71Cu2cKcX0lnLQ2abD0uOO
	 1/CmuVYMV0aehFssABrVcqyaWJ0C5zCDqz7XX3ebEopddshNbgzn9ST18Oo+vHdpzb
	 eRJlJ2uFD+b0g==
Date: Wed, 19 Jul 2023 21:12:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 2/2] net: stmmac: add support for phy-supply
Message-ID: <20230719211235.1758bbc0@kernel.org>
In-Reply-To: <20230718132049.3028341-2-m.felsch@pengutronix.de>
References: <20230718132049.3028341-1-m.felsch@pengutronix.de>
	<20230718132049.3028341-2-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jul 2023 15:20:49 +0200 Marco Felsch wrote:
> Add generic phy-supply handling support to control the phy regulator to
> avoid handling it within the glue code. Use the generic stmmac_platform
> code to register a possible phy-supply and the stmmac_main code to
> handle the power on/off.
> 
> Changelog
> ---
> 
> v2:
> - adapt stmmac_phy_power
> - move power-on/off into stmmac_main to handle WOL
> - adapt commit message
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---

Format should be:

Bla bla bla

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Changelog

v2:
 bla bla bla


Please fix and rebase because the current version does not apply to
net-next/main.
-- 
pw-bot: cr

