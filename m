Return-Path: <netdev+bounces-204861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D096AFC51D
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2CA1BC1AF9
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 08:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F220E29C340;
	Tue,  8 Jul 2025 08:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXafSZxA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53CA29B8EA;
	Tue,  8 Jul 2025 08:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962324; cv=none; b=pbgtakI1Bl1hEG9wNnOi/+EJlOcOMnU41swy8D2jSGJqtcqW9a7xQfPuZYlELXCdqYqSuWmlPvvgtJjnGNiH3Oamsp7vKVzvI8C96a9LHrolfqsfK8VbPFlSDvocU7n/WwUfEKh6PWLgCShhLqiNEsRJ78extSFDUkUUd24bCPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962324; c=relaxed/simple;
	bh=HAW1EPTiRkCXvNP7fS3zulptyhBHluAlgq8T1LKiR2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ND70ZhiM4yDewzMfOIkgzDVEE7IEL3RjNCL/QgN1BB9zo5xYbDll7/DVKDnaWr6pwBQR2nidNr+wkGmovg86/amU2G1nvW6zd5QsSRmZI3gSQ7n16XMMhftw6oB5zmR14fLL4NxEjrBH5IBOgTyGdYBRwrvW+TOi5g/9pZqCsBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXafSZxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E4AC4CEED;
	Tue,  8 Jul 2025 08:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751962324;
	bh=HAW1EPTiRkCXvNP7fS3zulptyhBHluAlgq8T1LKiR2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uXafSZxAUIrSUo6LKjiMqbvEBlYfwJHOm8x3y6HVWlBKsuYSnVgr/7JM2sKBy8t8I
	 m0md2htj+rMyqJKJz5w5SjO4IeSyLvjrB7wKAJYmYtJA+Lp2oKFkYaWeErNXCVpg6x
	 3DKL2Cr1DZ8qFuNu8PnGy6AkmOVYUuTYtrvmYNOHFSs2c6LU7Pyo/oJ9GhRh0EsQxP
	 J8wjRVePa8hRa48Xlq4pTmxwYOdDKWOuY8j62l+wGKmfnedt5OWX67AxMv641I7Tig
	 61aGfz9Ply61fD0H95T017MwNIRfpFdjGwwoN40WXwbX+y9fd87y9K4fSsF/cCdEK+
	 k6nK3/c/p9dBw==
Date: Tue, 8 Jul 2025 10:12:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Marek Vasut <marex@denx.de>, 
	UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/6 v2] dt-bindings: net: dsa: microchip: Add
 KSZ8463 switch support
Message-ID: <20250708-fractal-silver-mushroom-9b4fc7@krzk-bin>
References: <20250708031648.6703-1-Tristram.Ha@microchip.com>
 <20250708031648.6703-2-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250708031648.6703-2-Tristram.Ha@microchip.com>

On Mon, Jul 07, 2025 at 08:16:43PM -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> KSZ8463 switch is a 3-port switch based from KSZ8863.  Its register
> access is significantly different from the other KSZ SPI switches.
> 
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> ---
>  Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


