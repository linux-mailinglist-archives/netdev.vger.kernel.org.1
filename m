Return-Path: <netdev+bounces-97406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C248CB567
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 23:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4B9282AEA
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 21:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F69A14885C;
	Tue, 21 May 2024 21:34:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E563015EA2;
	Tue, 21 May 2024 21:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716327286; cv=none; b=DuU5iEWI4jgZ6Py4tFPBHnnIxr0Azn2N2mmQmWd2XL0msOaDLvVYT0t9dLGZnHGtUINu/rYIJUFSixBQczSfq5mQwLDzjsnVVzvcB4dZTXFYLSMxY9J6vbaiTR3Wg6Q0S5qPVapkH97qK7mniwAszm85XvjwF3PubweU0OV+olk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716327286; c=relaxed/simple;
	bh=iSUpPrB2FOTjPzDM+vTHnnOraGdUpTk1F1vWtL46uyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+RzQoE8lCL6QOWaXpxOjm5yUzTNnmHG6hU6wnW+DbxcskjCnR82fyvkV3tgJGXQMuQ9cmYLoRCgrFJwGFbRQ9D0x3JAIUUp7zTc4X1BGT+sWLQAMmBm5feRowzEMtBomAAniv/rxVBQ9bZjlflMdfPMw8E6AhraHbo/RJfi+wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875abf.versanet.de ([83.135.90.191] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s9X7d-0004Ld-Cj; Tue, 21 May 2024 23:34:13 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>, Tobias Schramm <t.schramm@manjaro.org>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jonas Karlman <jonas@kwiboo.se>, netdev@vger.kernel.org
Subject:
 Re: [PATCH 01/13] dt-bindings: net: rockchip-dwmac: Fix rockchip,rk3308-gmac
 compatible
Date: Tue, 21 May 2024 23:34:12 +0200
Message-ID: <2389630.NG923GbCHz@diego>
In-Reply-To: <20240521211029.1236094-2-jonas@kwiboo.se>
References:
 <20240521211029.1236094-1-jonas@kwiboo.se>
 <20240521211029.1236094-2-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 21. Mai 2024, 23:10:04 CEST schrieb Jonas Karlman:
> Schema validation using rockchip,rk3308-gmac compatible fails with:
> 
>   ethernet@ff4e0000: compatible: ['rockchip,rk3308-gmac'] does not contain items matching the given schema
>         from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
>   ethernet@ff4e0000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode',
>                      'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us',
>                      'snps,reset-gpio' were unexpected)
>         from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
> 
> Add rockchip,rk3308-gmac to snps,dwmac.yaml to fix DT schema validation.
> 
> Fixes: 2cc8c910f515 ("dt-bindings: net: rockchip-dwmac: add rk3308 gmac compatible")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

I'm not sure how the network tree works these days, but this patch is the
only one that should go through the network tree.


> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 21cc27e75f50..3bab4e1f3fbf 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -76,6 +76,7 @@ properties:
>          - rockchip,rk3128-gmac
>          - rockchip,rk3228-gmac
>          - rockchip,rk3288-gmac
> +        - rockchip,rk3308-gmac
>          - rockchip,rk3328-gmac
>          - rockchip,rk3366-gmac
>          - rockchip,rk3368-gmac
> 





