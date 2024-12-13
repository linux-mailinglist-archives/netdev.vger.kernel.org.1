Return-Path: <netdev+bounces-151673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AA89F0859
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A57B168D90
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899A41B393A;
	Fri, 13 Dec 2024 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iV3VGXZY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDC91AE01B;
	Fri, 13 Dec 2024 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734083241; cv=none; b=UydrFrOVMFxkkM+ppZx8mcJslRvRS91Zd22MaI4LyBCY8Ps6lNGVos/Mo9Vca21wVsz/XaM9boYSDhn/V2runUY4DB4fW8I/s7DDWKnurBC62znXm8A3AOnmmx6207d83GYyDgwvN8xyUNREyhgysWbzSScAbcyBwFmONLOS/FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734083241; c=relaxed/simple;
	bh=CsUSpJzbuGKFaVUKenfHD5hOCr81hHhImJcfyZvjwVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLjOwYJ+G6zI3lr5rIY9nv/p2/iNbwARyqBjdJSahHcUSlHoQYeSn0OnQCn9yF4KyY2RFhGISDtVtSaMfF5WAIt++XZRrUh+6x/bmRsDiUQTU1I+czsS7RQBvfKAzDMYr/o3FIMSPLr0BU2g+ZLxDeD7aYXyEMsovWcK9LfGhMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iV3VGXZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CDEC4CED1;
	Fri, 13 Dec 2024 09:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734083239;
	bh=CsUSpJzbuGKFaVUKenfHD5hOCr81hHhImJcfyZvjwVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iV3VGXZYJ5EPnlYVp6EltRKys5jYp0pk0J8VwESvsYYiz5S4i7VDdyTj2VuZEyuPd
	 dXawjAYiJM71+UZG8OxlP4KZ9/D1DIEaaZcTEsnuM4hgAlCQNtP1/S4b7pdKnGnU8F
	 uJGiMOZjzyoWP0sjI+Wvok2fThJ9n6tq+rxQRy6U0E1xonHTt0LAUYsLkQ5oTq8Tzp
	 DKHGhUSTIHF9otTSmb6MX7qxZ+aYkmNczYzanGi9Q+JHpoaWv2es4OdTrVUFLav3hz
	 dOTLAK/+tCoeO8cCZaBw1SMf2PIOP10D1g0Pv9th4Dm6ZLv7f5pvAR43mxMUwgPJi5
	 MRjTeygDlVjjg==
Date: Fri, 13 Dec 2024 10:47:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jesse Van Gavere <jesseevg@gmail.com>
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org, 
	Marek Vasut <marex@denx.de>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Vladimir Oltean <olteanv@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, UNGLinuxDriver@microchip.com, 
	Woojung Huh <woojung.huh@microchip.com>, Jesse Van Gavere <jesse.vangavere@scioteq.com>
Subject: Re: [PATCH net-next] dt-bindings: net: dsa: microchip,ksz: Improve
 example to a working one
Message-ID: <jpou4vundlwdmnq5iyjf3hyqclrxktxye6znxkulps3f3rbszu@pzvgwoge2a7a>
References: <20241210120443.1813-1-jesse.vangavere@scioteq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210120443.1813-1-jesse.vangavere@scioteq.com>

On Tue, Dec 10, 2024 at 01:04:43PM +0100, Jesse Van Gavere wrote:
> Currently the example will not work when implemented as-is as there are
> some properties and nodes missing.
> - Define two eth ports, one for each switch for clarity.

For clarity of what? That's just example, not complete code. Aren't you
adding unrelated pieces - ones not being part of this binding?

> - Add mandatory dsa,member properties as it's a dual switch setup example.
> - Add the mdio node for each switch and define the PHYs under it.
> - Add a phy-mode and phy-handle to each port otherwise they won't come up.
> - Add a mac-address property, without this the port does not come up, in
> the example all 0 is used so the port replicates MAC from the CPU port
> 
> Signed-off-by: Jesse Van Gavere <jesse.vangavere@scioteq.com>

Mismatched SoB.

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run 'scripts/checkpatch.pl --strict' and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.


> ---
>  .../bindings/net/dsa/microchip,ksz.yaml       | 89 +++++++++++++++++--
>  1 file changed, 83 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> index 62ca63e8a26f..a08ec0fd01fa 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> @@ -145,13 +145,19 @@ examples:
>    - |
>      #include <dt-bindings/gpio/gpio.h>
>  
> -    // Ethernet switch connected via SPI to the host, CPU port wired to eth0:
> +    // Ethernet switches connected via SPI to the host, CPU ports wired to eth0 and eth1:
>      eth0 {
>          fixed-link {
>              speed = <1000>;
>              full-duplex;
>          };
>      };
> +    eth1 {
> +        fixed-link {
> +            speed = <1000>;
> +            full-duplex;
> +        };
> +    };
>  
>      spi {
>          #address-cells = <1>;
> @@ -167,28 +173,46 @@ examples:
>  
>              spi-max-frequency = <44000000>;
>  
> +            dsa,member = <0 0>;
> +
>              ethernet-ports {
>                  #address-cells = <1>;
>                  #size-cells = <0>;
>                  port@0 {
>                      reg = <0>;
>                      label = "lan1";
> +                    phy-mode = "internal";
> +                    phy-handle = <&switch0_phy0>;
> +                    // The MAC is duplicated from the CPU port when all 0
> +                    mac-address = [00 00 00 00 00 00];
>                  };
>                  port@1 {
>                      reg = <1>;
>                      label = "lan2";
> +                    phy-mode = "internal";
> +                    phy-handle = <&switch0_phy1>;
> +                    mac-address = [00 00 00 00 00 00];
>                  };
>                  port@2 {
>                      reg = <2>;
>                      label = "lan3";
> +                    phy-mode = "internal";
> +                    phy-handle = <&switch0_phy2>;
> +                    mac-address = [00 00 00 00 00 00];
>                  };
>                  port@3 {
>                      reg = <3>;
>                      label = "lan4";
> +                    phy-mode = "internal";
> +                    phy-handle = <&switch0_phy3>;
> +                    mac-address = [00 00 00 00 00 00];
>                  };
>                  port@4 {
>                      reg = <4>;
>                      label = "lan5";
> +                    phy-mode = "internal";
> +                    phy-handle = <&switch0_phy4>;
> +                    mac-address = [00 00 00 00 00 00];
>                  };
>                  port@5 {
>                      reg = <5>;
> @@ -201,6 +225,27 @@ examples:
>                      };
>                  };
>              };
> +
> +            mdio {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                switch0_phy0: ethernet-phy@0 {
> +                    reg = <0>;
> +                };
> +                switch0_phy1: ethernet-phy@1 {
> +                  reg = <1>;
> +                };
> +                switch0_phy2: ethernet-phy@2 {
> +                  reg = <2>;
> +                };
> +                switch0_phy3: ethernet-phy@3 {
> +                  reg = <3>;
> +                };
> +                switch0_phy4: ethernet-phy@4 {
> +                  reg = <4>;
> +                };
> +            };
>          };
>  
>          ksz8565: switch@1 {
> @@ -209,28 +254,42 @@ examples:
>  
>              spi-max-frequency = <44000000>;
>  
> +            dsa,member = <1 0>;
> +
>              ethernet-ports {
>                  #address-cells = <1>;
>                  #size-cells = <0>;
>                  port@0 {
>                      reg = <0>;
> -                    label = "lan1";
> +                    label = "lan6";

What's wrong with lan1? Just drop the second switch node, why do you
need it in the first place? We expect only one example, unless they
differ which is not the case - they are the same (difference in
compatible does not count, lacking gpios is rather negative indication
of needingi the example). More examples, more code to maintain, more
bugs, more issues - see further comment.

> +                    phy-mode = "internal";
> +                    phy-handle = <&switch1_phy0>;
> +                    mac-address = [00 00 00 00 00 00];


>                  };
>                  port@1 {
>                      reg = <1>;
> -                    label = "lan2";
> +                    label = "lan7";
> +                    phy-mode = "internal";
> +                    phy-handle = <&switch1_phy1>;
> +                    mac-address = [00 00 00 00 00 00];
>                  };
>                  port@2 {
>                      reg = <2>;
> -                    label = "lan3";
> +                    label = "lan8";
> +                    phy-mode = "internal";
> +                    phy-handle = <&switch1_phy2>;
> +                    mac-address = [00 00 00 00 00 00];
>                  };
>                  port@3 {
>                      reg = <3>;
> -                    label = "lan4";
> +                    label = "lan9";
> +                    phy-mode = "internal";
> +                    phy-handle = <&switch1_phy3>;
> +                    mac-address = [00 00 00 00 00 00];
>                  };
>                  port@6 {
>                      reg = <6>;
> -                    ethernet = <&eth0>;
> +                    ethernet = <&eth1>;
>                      phy-mode = "rgmii";
>  
>                      fixed-link {
> @@ -239,6 +298,24 @@ examples:
>                      };
>                  };
>              };
> +
> +            mdio {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                switch1_phy0: ethernet-phy@0 {
> +                    reg = <0>;
> +                };
> +                switch1_phy1: ethernet-phy@1 {
> +                  reg = <1>;

Messed alignment.


Best regards,
Krzysztof


