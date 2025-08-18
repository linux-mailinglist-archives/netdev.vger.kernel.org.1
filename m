Return-Path: <netdev+bounces-214725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62840B2B0DE
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 20:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6228918A6398
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 18:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6A926FD8F;
	Mon, 18 Aug 2025 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3vXP1eM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6246A204F8C;
	Mon, 18 Aug 2025 18:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543044; cv=none; b=VuOhbgYDhePWw+DgloEtm0fBx8WNUY1iSw/mdoeEmxyx8Q+TMwDYW2E9CNoYmf6fbRPzDUhRT0kTdBlXCscJG3s+L+Ea64bLgzZopTUVasUWJlEbrQ3Fp7wbOn7j0n/bxgY9IIgwh/gb5ugxKOhjnjDoHyT6+eN6zBvx5hxRBWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543044; c=relaxed/simple;
	bh=O7W48Fc++HUPE3zXQ8Whd5Cxn4EyCN0S+wvkwo8T5RE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kq/uWc2Q+oL3ArvFZSMKq9VRxs7q7cj3kGFuRHaQiZXC1qNH4Ba/6soQ5izpdE0u9f38gidws6bt2L3R0F8ZLIbhZE/7PD1T9ihigFzdubAKghQU49lDIhoFpMi4M7aDaL3bA7r2o0bYhEMvwcxN9OkOo3A9pyXrSXNBhdxkWwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3vXP1eM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CF6C4CEEB;
	Mon, 18 Aug 2025 18:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755543042;
	bh=O7W48Fc++HUPE3zXQ8Whd5Cxn4EyCN0S+wvkwo8T5RE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t3vXP1eM67XEvvowb0QFpyCezDN/pZI5ZonNHywmtRNwjqYiwwo4HOOkRTBUzUiqh
	 zRxRu+B7O0nMt/iXbOMtr8GdI5eyMt3HjI2JwE6p/b3P9y9BZt3r/gr4kg/jMRIUaE
	 z4EgCJcsh+WymXdCGnjgiZsg7tp8a98/L3Gpd3lAVsgtqieOk559Jnsf+xUPuE41Tr
	 bgNN8BZo8r4jw9s2r8eNna1mjOQzZFYMFpKts6aMsJsnXyTQzzVz9OBu7hrpr8XTxI
	 LGY7FyLcMhw75D1yy7mBAOtpn3Ek/s8IUQUF2GBqwITGDW0nKyJpU52Awn1N1ybQh8
	 dvaOQQaUpAUvw==
Date: Mon, 18 Aug 2025 11:50:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Stanimir Varbanov <svarbanov@suse.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrea della Porta <andrea.porta@suse.com>, Nicolas
 Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Phil Elwell <phil@raspberrypi.com>, Jonathan
 Bell <jonathan@raspberrypi.com>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 0/5] Add ethernet support for RPi5
Message-ID: <20250818115041.71041ad6@kernel.org>
In-Reply-To: <4c454b3c-f62c-4086-a665-282aa2f4a0e1@broadcom.com>
References: <20250815135911.1383385-1-svarbanov@suse.de>
	<4c454b3c-f62c-4086-a665-282aa2f4a0e1@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 11:02:15 -0700 Florian Fainelli wrote:
> > Few patches to enable support of ethernet on RPi5.
> > 
> >   - first patch is setting upper 32bits of DMA RX ring buffer in case of
> >     RX queue corruption.
> >   - second patch is adding a new compatible in cdns,macb yaml document
> >   - third patch adds compatible and configuration for raspberrypi,rp1-gem
> >   - forth and fifth patches are adding and enabling ethernet DT node on
> >     RPi5.
> > 
> > Comments are welcome!  
> 
> netdev maintainers, do you mind if I take patches 2, 4 and 5 via the 
> Broadcom ARM SoC tree to avoid generating conflicts down the road? You 
> can take patches 1 and 3. Thanks

4, 5 make perfect sense, why patch 2? We usually take bindings.

