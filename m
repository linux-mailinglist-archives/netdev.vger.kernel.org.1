Return-Path: <netdev+bounces-187093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B524AA4E64
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 16:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314943A3F52
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 14:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F8325A632;
	Wed, 30 Apr 2025 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1Q7eU9v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D619D2AE8B;
	Wed, 30 Apr 2025 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746022984; cv=none; b=R9k120v+g/EaeNb8S6Hy93eZFhqpskx02ehezG2+wGNUDlI2HyUeHUUtOgjmVEMwxClo8iQ2n27ypJ8J+4/aR8ZZoBOIxM7/Dlv2rWLXEUQtpPxdfKXr1QXDyWJ+wAW79o3JPHxQ/ccdgGLo2VSEou25nMbkBny2naRMNh6sifQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746022984; c=relaxed/simple;
	bh=EHmJoyT1t1HTWr93T5cTrjOvhbK6j7Z+nBdrivtN+KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4BOsLeFQabFOuuDUMEDTRijEed8hf4jgJtW5kTJbgvOPD+hXzJyaNp4tqK1TcSMGiRp9YKoxCFAXsQD7QnotWVgqALmoWk8DXtx6YlkYV3zqTM88UFViy0Bt7/bKyhRDe0PDnPjV3xNVSl7IYrxBVEYJM3T9V8YQ480Sb+WcDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1Q7eU9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBEAC4CEE7;
	Wed, 30 Apr 2025 14:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746022983;
	bh=EHmJoyT1t1HTWr93T5cTrjOvhbK6j7Z+nBdrivtN+KM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i1Q7eU9v9c9LhftrfG98JhwjvdtIX79CBeve9Lm9W0p/zaxBB/CR370V7cwfPUGci
	 25KfK/1vS7TQX5ECZxwu+KE077rM4bgeBY+Q/Vtv8oUdIKqvqUPWg+zIQoDpln+Tlb
	 /TmX2lawn/mb7tU5xdarnbQtwswtW2SXMG7yWVd7b11VeE5I/sEmxz3OBrWqOvf1hF
	 pPAbH8QqUv3ecrfsUEyv/l2zqHdiapP/8qWa2Scgq1L/bPXKK460WXhOCZTtnrkGG9
	 K0OYKkZNdYznUBJ/H2RS9SuWz723aSULxpMKAJ2v7Tqkm9OG9KQUJiCsJwpLHNFFI/
	 dK5uXZw+L4CHQ==
Message-ID: <06268dcb-4a49-468e-8ebd-d9366a2cf0c2@kernel.org>
Date: Wed, 30 Apr 2025 17:22:54 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] dt-bindings: net: ti: k3-am654-cpsw-nuss:
 update phy-mode in example
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andy Whitcroft <apw@canonical.com>,
 "mike .." <wingman205@gmx.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>,
 Jonathan Corbet <corbet@lwn.net>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tero Kristo <kristo@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <4216050f7b33ce4e5ce54f32023ec6ce093bd83c.1744710099.git.matthias.schiffer@ew.tq-group.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <4216050f7b33ce4e5ce54f32023ec6ce093bd83c.1744710099.git.matthias.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Matthias,

On 15/04/2025 13:18, Matthias Schiffer wrote:
> k3-am65-cpsw-nuss controllers have a fixed internal TX delay, so RXID
> mode is not actually possible and will result in a warning from the
> driver going forward.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  .../devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
> index b11894fbaec47..c8128b8ca74fb 100644
> --- a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
> @@ -282,7 +282,7 @@ examples:
>                      ti,syscon-efuse = <&mcu_conf 0x200>;
>                      phys = <&phy_gmii_sel 1>;
>  
> -                    phy-mode = "rgmii-rxid";
> +                    phy-mode = "rgmii-id";
>                      phy-handle = <&phy0>;
>                  };
>              };

FYI the following TI boards using this driver are using "rgmii-rxid".
Will you be sending fixes to the device trees files?

arch/arm64/boot/dts/ti
k3-am625-beagleplay.dts:	phy-mode = "rgmii-rxid";
k3-am625-sk.dts:	phy-mode = "rgmii-rxid";
k3-am625-sk.dts.orig:	phy-mode = "rgmii-rxid";
k3-am62a7-sk.dts:	phy-mode = "rgmii-rxid";
k3-am62a-phycore-som.dtsi:	phy-mode = "rgmii-rxid";
k3-am62p5-sk.dts:	phy-mode = "rgmii-rxid";
k3-am62p5-sk.dts:	phy-mode = "rgmii-rxid";
k3-am62-phycore-som.dtsi:	phy-mode = "rgmii-rxid";
k3-am62-verdin-dev.dtsi:	phy-mode = "rgmii-rxid";
k3-am62-verdin.dtsi:	phy-mode = "rgmii-rxid";
k3-am62-verdin-ivy.dtsi:	phy-mode = "rgmii-rxid";
k3-am62x-phyboard-lyra.dtsi:	phy-mode = "rgmii-rxid";
k3-am62x-sk-common.dtsi:	phy-mode = "rgmii-rxid";
k3-am642-evm.dts:	phy-mode = "rgmii-rxid";
k3-am642-evm.dts:	phy-mode = "rgmii-rxid";
k3-am642-sk.dts:	phy-mode = "rgmii-rxid";
k3-am642-sk.dts:	phy-mode = "rgmii-rxid";
k3-am642-tqma64xxl-mbax4xxl.dts:	phy-mode = "rgmii-rxid";
k3-am642-tqma64xxl-mbax4xxl.dts:	/* phy-mode is fixed up to rgmii-rxid by prueth driver to account for
k3-am64-phycore-som.dtsi:	phy-mode = "rgmii-rxid";
k3-am654-base-board.dts:	phy-mode = "rgmii-rxid";
k3-am67a-beagley-ai.dts:	phy-mode = "rgmii-rxid";
k3-am68-sk-base-board.dts:	phy-mode = "rgmii-rxid";
k3-am69-sk.dts:	phy-mode = "rgmii-rxid";
k3-j7200-common-proc-board.dts:	phy-mode = "rgmii-rxid";
k3-j721e-beagleboneai64.dts:	phy-mode = "rgmii-rxid";
k3-j721e-common-proc-board.dts:	phy-mode = "rgmii-rxid";
k3-j721e-evm-gesi-exp-board.dtso:	phy-mode = "rgmii-rxid";
k3-j721e-evm-gesi-exp-board.dtso:	phy-mode = "rgmii-rxid";
k3-j721e-evm-gesi-exp-board.dtso:	phy-mode = "rgmii-rxid";
k3-j721e-evm-gesi-exp-board.dtso:	phy-mode = "rgmii-rxid";
k3-j721e-sk.dts:	phy-mode = "rgmii-rxid";
k3-j721s2-common-proc-board.dts:	phy-mode = "rgmii-rxid";
k3-j721s2-evm-gesi-exp-board.dtso:	phy-mode = "rgmii-rxid";
k3-j722s-evm.dts:	phy-mode = "rgmii-rxid";
k3-j784s4-j742s2-evm-common.dtsi:	phy-mode = "rgmii-rxid";
k3-j784s4-j742s2-evm-common.dtsi:	phy-mode = "rgmii-rxid";

-- 
cheers,
-roger


