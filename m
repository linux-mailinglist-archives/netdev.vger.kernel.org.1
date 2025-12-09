Return-Path: <netdev+bounces-244169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC120CB108A
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 21:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C598A301EE6E
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 20:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8362D7DC7;
	Tue,  9 Dec 2025 20:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQ0d2tfi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCC32C3757;
	Tue,  9 Dec 2025 20:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765312894; cv=none; b=akeNP3TGFYDAbek79RXIVTFfMzVovr96+cEsHPKEb6y219nxnZRelncZu/pKNkjYcy1ng6HbGStwrUxc+P1UQEOER6mLYB6sNI7MFkwGLk7AIIlmqNCg3YxqxUzCP1GOHKKX8nLUBOr66v6sG+Ym6JP4WtmBetqCdYT/wkri2d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765312894; c=relaxed/simple;
	bh=6UgeHwLWxOpoVYgukx4GdIpLT8XqFIfNQirBTLCXB3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nl6eqYgI90wN0DQ06XOODy2KAr+n72wrCLLzJf6oxGVZ8nwtvnuPZz9I2FU5BqwnOe6zX8TONbnwycbxMMeVugZviM686chY+K0d8gKwrIc4zmmFuH9AoONpGBGfAsRau4yNvon3pV92KFXjogm/lIKZe7dkm8NWY+/e/wMPrSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQ0d2tfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AC8C4CEF5;
	Tue,  9 Dec 2025 20:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765312893;
	bh=6UgeHwLWxOpoVYgukx4GdIpLT8XqFIfNQirBTLCXB3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQ0d2tfijNqsU6nLz8VQlelwZ6vOzxxmQnZmKaKoooZqEqXwW7/FhYeVdiwBV1wcg
	 X3UvjtfnjUtZ1cC3KFTuVO6laMAzTENlCzL9XJXfaV7d7pQG6fXrvFuypCu76HnpjE
	 ZBwJZURHFR6ml2mbHeW4tKY+UiNZm6jdjg2jGJepVAqdU8xbGYjeDma8Gv0baamz2T
	 BEHm80uPvonOdqC3sN4LKJuQm97RnoYqOiF5jYjL1JDmvmiF9qR4mGy6//2BcnrQop
	 3EcmrS0WgO+M/UsWZd85UizxcPAnHevgAr/m9S3m3p0bJt0R2Rc1O00CWY5/aRv/Zx
	 LD3M8IQBXtjWw==
Date: Tue, 9 Dec 2025 14:41:30 -0600
From: Rob Herring <robh@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, taoren@meta.com
Subject: Re: [PATCH net-next v5 1/4] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600
Message-ID: <20251209204130.GA1056291-robh@kernel.org>
References: <20251205-rgmii_delay_2600-v5-0-bd2820ad3da7@aspeedtech.com>
 <20251205-rgmii_delay_2600-v5-1-bd2820ad3da7@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205-rgmii_delay_2600-v5-1-bd2820ad3da7@aspeedtech.com>

On Fri, Dec 05, 2025 at 05:53:15PM +0800, Jacky Chou wrote:
> The AST2600 contains two dies, each with its own MAC, and these MACs
> require different delay configurations.
> Previously, these delay values were configured during the bootloader
> stage rather than in the driver. This change introduces the use of the
> standard properties defined in ethernet-controller.yaml to configure
> the delay values directly in the driver.
> 
> Each Aspeed platform has its own delay step value. And for Aspeed platform,
> the total steps of RGMII delay configuraion is 32 steps, so the total delay
> is delay-step-ps * 32.
> Default delay values are declared so that tx-internal-delay-ps and
> rx-internal-delay-ps become optional. If these properties are not present,
> the driver will use the default values instead.
> Add conditional schema constraints for Aspeed AST2600 MAC controllers:
> - For MAC0/1, per delay step for rgmii is 45 ps
> - For MAC2/3, per delay step for rgmii is 250 ps
> - Both require the "aspeed,scu" and "aspeed,rgmii-delay-ps" properties.
> Other compatible values remain unrestricted.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../devicetree/bindings/net/faraday,ftgmac100.yaml | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> index d14410018bcf..00f7a0e56106 100644
> --- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> @@ -69,6 +69,30 @@ properties:
>    mdio:
>      $ref: /schemas/net/mdio.yaml#
>  
> +  aspeed,scu:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the SCU (System Control Unit) syscon node for Aspeed platform.
> +      This reference is used by the MAC controller to configure the RGMII delays.
> +
> +  rx-internal-delay-ps:
> +    description:
> +      RGMII Receive Clock Delay defined in pico seconds. There are 32
> +      steps of RGMII delay for Aspeed platform. Each Aspeed platform has its
> +      own delay step value, it is fixed by hardware design. Total delay is
> +      calculated by delay-step * 32. A value of 0 ps will disable any
> +      delay. The Default is no delay.
> +    default: 0
> +
> +  tx-internal-delay-ps:
> +    description:
> +      RGMII Transmit Clock Delay defined in pico seconds. There are 32
> +      steps of RGMII delay for Aspeed platform. Each Aspeed platform has its
> +      own delay step value, it is fixed by hardware design. Total delay is
> +      calculated by delay-step * 32. A value of 0 ps will disable any
> +      delay. The Default is no delay.
> +    default: 0
> +
>  required:
>    - compatible
>    - reg
> @@ -85,6 +109,9 @@ allOf:
>      then:
>        properties:
>          resets: true
> +        aspeed,scu: true
> +        rx-internal-delay-ps: true
> +        tx-internal-delay-ps: true

There is no need for these (including the 'resets'). Really, the 'if' 
should be negated with a 'not' and this part dropped.

>      else:
>        properties:
>          resets: false

But you need false entries here since these 3 properties are just for 
ast2600.

Rob

