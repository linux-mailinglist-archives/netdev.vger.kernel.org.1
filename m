Return-Path: <netdev+bounces-167765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29376A3C25A
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 15:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E609916B56A
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 14:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57B41EFFBF;
	Wed, 19 Feb 2025 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPzs/yLc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A64E1AA1DC;
	Wed, 19 Feb 2025 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976008; cv=none; b=jKMYFZH9JTvgIaIwopsy82nUCd0TEu9qAmjOSCjp5z1UZ0pqrLtuM7XKbDhUorKuPjWRsVOt4S0U5Z3/yPh8oALvfM9vu+d2aeH2bv30d6ph4bOOK2+l5873eSzRXsgyCQb6r3KODxdTLo94jN8fwUp2qB+2y8t8QOHqJP5lW/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976008; c=relaxed/simple;
	bh=jdFP+pG8eE/suF77w3qUAgnNowmIQyc6GvRrUtbVNdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXszeD2SmlDIMOkVp55D/WgDVYSlfmiUssX2C+R7gHQY7VKkayyj+bLiUYiQbhPScfQ65xZsJmrBDg+rBfHvhSO0H6tI5aLxEaay/NXyZkLgv/WLlVP50h3pjX9C/XwbkdDGnJiIg9Fu/rNqpJf9h66zBn47PA6tksJKjPnhRFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPzs/yLc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37ABC4CED1;
	Wed, 19 Feb 2025 14:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739976008;
	bh=jdFP+pG8eE/suF77w3qUAgnNowmIQyc6GvRrUtbVNdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qPzs/yLc3PJbsymD8yQ3W+TRpyoMkqXsfki62C12C+KBAEml45hki0QRY5xgdwIQj
	 gp3bOsPIm6TtaKIhPus0cyOgrSqbNPr/JqacRkCoOSUW5r9vbMyLR0SKVPRQBXI6q4
	 86zsmmoJnn3R3DQpvGE6Rxt4EGDfHc6kgY9eVhUoiHxJ/j2x8JVzBvz+MJxCLbo8Qy
	 9R2ncuTSSvEm4kwwhYAMEPIYhukY75xwUNLidYdLoP3pv1lRQ/7zNRVa7rPcC6J8k0
	 0Q2t0aeAufMt/S4MOFuLGDBJE9t9UdbDweM5jdpWBqa1McsJL7fIIkneGF6YN4Oed3
	 QKcHUO6LKQ9BA==
Date: Wed, 19 Feb 2025 08:40:07 -0600
From: Rob Herring <robh@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: stm32: Add Plymovent AQM board
Message-ID: <20250219144007.GA2550036-robh@kernel.org>
References: <20250210104748.396399-1-o.rempel@pengutronix.de>
 <20250210104748.396399-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210104748.396399-3-o.rempel@pengutronix.de>

On Mon, Feb 10, 2025 at 11:47:47AM +0100, Oleksij Rempel wrote:
> Add support for the Plymovent AQM board based on the ST STM32MP151 SoC
> to the STM32 devicetree bindings.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> index 2cea166641c5..734c4b8ac881 100644
> --- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> +++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> @@ -65,6 +65,7 @@ properties:
>                - prt,prtt1a   # Protonic PRTT1A
>                - prt,prtt1c   # Protonic PRTT1C
>                - prt,prtt1s   # Protonic PRTT1S
> +              - ply,plyaqm   # Plymovent AQM board

Alphabetical order please.

>            - const: st,stm32mp151
>  
>        - description: DH STM32MP135 DHCOR SoM based Boards
> -- 
> 2.39.5
> 

