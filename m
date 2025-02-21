Return-Path: <netdev+bounces-168691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A1AA4031D
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 23:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE0E3BC04E
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 22:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313A52500B1;
	Fri, 21 Feb 2025 22:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRmW6HFe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E6A1EE028;
	Fri, 21 Feb 2025 22:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740178687; cv=none; b=PT/Bpx2lCmnlX80D96smwAR9Bj2f2tAauI8IsIQCtT2w7gP/1g1k6x4NQ4i8+XjCDZ1rZybPBIKDtca9xUFbZnZzXW216w65Lau9yPQpUUa0eBdAZJBjFAcFsGum1y/NMzxfOek7ePPatFUUtnVCi116t7oyFXS/8ks02PJ3eI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740178687; c=relaxed/simple;
	bh=UD1mJc3L2/1M1eMRVEKmlNYviOU+pPZbwPDjudm8YBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6PZWLzW+v9ILkCGQd5abSMDK5sBnWmMY5BXc7X7r1LJZelfUGZSXVzSjcZTstHmydBWAem6n1JX3oyv5YrlQbmZwNVCBZdaH96GVAKAzdqmXwtN3Q/tN+gG4RQuLKx8JtEHmm5mVXLwMESAodZYa/EwvhjJ/vMsveu9zAF+bpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRmW6HFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4604FC4CED6;
	Fri, 21 Feb 2025 22:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740178686;
	bh=UD1mJc3L2/1M1eMRVEKmlNYviOU+pPZbwPDjudm8YBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nRmW6HFetk9gBcJVjmGedrpzJc9A5xydWmGgUh72T7lAekfxLErtovTbwri7P6iWX
	 9UpIEdRt4wWFLLz+i05k8TMksdeLUu/AnBTFceKjeUKU3HyDcQdVt42LBkR99aoTS9
	 9w5KKoRClz6TH5MDMLblw7fg+1uscFK6m8bzj7SAHNHeQr01+JEIz6FVAjUq4TfjOx
	 6yKWSE9D9fiWAV/qs+aFIiseALoM4d5P1SSRP0X2UWgORso08uI5MEeAo+eEHpKrGc
	 dlf/bIAkk2+VV+9t1I/9fZH9n4YXh6OLkUWsS4c52sLAm992bUDUG4zyiAywOtxuj5
	 ZfspYHi4bM9sw==
Date: Fri, 21 Feb 2025 16:58:04 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	devicetree@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Woojung Huh <woojung.huh@microchip.com>, kernel@pengutronix.de,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: stm32: Add Plymovent AQM board
Message-ID: <174017868413.223507.11279781037859848554.robh@kernel.org>
References: <20250220090155.2937620-1-o.rempel@pengutronix.de>
 <20250220090155.2937620-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220090155.2937620-3-o.rempel@pengutronix.de>


On Thu, 20 Feb 2025 10:01:54 +0100, Oleksij Rempel wrote:
> Add support for the Plymovent AQM board based on the ST STM32MP151 SoC
> to the STM32 devicetree bindings.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v3:
> - fix alphabetical order
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


