Return-Path: <netdev+bounces-139400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE689B206D
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 21:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D481C208CE
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 20:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F9017CA09;
	Sun, 27 Oct 2024 20:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O08X3fuW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580E8538A;
	Sun, 27 Oct 2024 20:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730061484; cv=none; b=rl6r8DfUL1d485mu1msvS7glIv7kUhzpa5g/n4+uNWFtyConwg+IXec3IMqsJ/znztN0xfCc+bgj0+Qhzfkl66EeWT7uo7DxOrJ8iLi0jC63QizTSfCqgHH7iAD41ybjU4/HAJYNxvTU6gSfCPz+wXC8X9jc12TOMe5gYQuNbFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730061484; c=relaxed/simple;
	bh=XVAi1sk2jxjCgto2tP/Cdm3jLw9qfp50pYIUjyARnkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxMe863yDiyM0MkWa9XWEESkBGRkd6a/ueFvTcZR3WWr2pflUa755c7d1YszdNCkeGVvv12FNmXypXwLmIf+k5AO+v2og9Yuo3aElan8/gN6p/3OrytQJefct5EZmTOasYhC7PsOip6zNUxtGDuNch6KU9tpOx3sBOTyGyAiANk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O08X3fuW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2625AC4CEC3;
	Sun, 27 Oct 2024 20:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730061483;
	bh=XVAi1sk2jxjCgto2tP/Cdm3jLw9qfp50pYIUjyARnkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O08X3fuW1WWmGgVpPvq2rZy29QwVueFD7a87JA3OxX4D4cRxu9+xwVslSvAXnbiwE
	 dXJ8CBYNDujLFINfeo/3UlJyt6dBeu+qE70+vIVbnCdNRnA0WIn68vwwtSPDoZFUuj
	 kftqEQ6MaHWbfJhOF6El0+nmBUFJV7dVxmZz+wWfu4WzAj3GMhSxRshUir1PCEKH40
	 ps5GPx9F6fh2HpunAKbUVDJKrdW4Lids+mBUejeutozM4enLwwFp1NvskHkoIBVLQi
	 BESj+1NwAsaV4pEwXPcoK7y9+1im0zrI7VWe8yEdFozd4Z463W8rpuH67YLdBixZyK
	 zN/ArJWIPszeA==
Date: Sun, 27 Oct 2024 21:38:00 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/4] dt-bindings: net: Add support for Sophgo SG2044
 dwmac
Message-ID: <4avwff7m4puralnaoh6pat62nzpovre2usqkmp3q4r4bk5ujjf@j3jzr4p74v4a>
References: <20241025011000.244350-1-inochiama@gmail.com>
 <20241025011000.244350-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025011000.244350-3-inochiama@gmail.com>

On Fri, Oct 25, 2024 at 09:09:58AM +0800, Inochi Amaoto wrote:
> The GMAC IP on SG2044 is almost a standard Synopsys DesignWare MAC
> with some extra clock.
> 
> Add necessary compatible string for this device.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---

This should be squashed with a corrected previous patch (why do you need
to select snps,dwmac-5.30a?), so we clearly see which the fallback and
specific compatibles being added.

>  .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
>  .../bindings/net/sophgo,sg2044-dwmac.yaml     | 124 ++++++++++++++++++
>  2 files changed, 125 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml

Best regards,
Krzysztof


