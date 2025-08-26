Return-Path: <netdev+bounces-216861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DFFB358C6
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A4AF7A6D60
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 09:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6663F2F83C9;
	Tue, 26 Aug 2025 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1YItvuir"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE00343ABC;
	Tue, 26 Aug 2025 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200331; cv=none; b=IxtWelvaXcZqRgqF59dIgEIeuNh/rz8HgIo3A3CB1ZokUalycyxZk3MzFvsdTnFMni9CPSkrS/ovgWOP/oKb1fiN4ilmS9k+Dkdwo6iqdAzkVZYWzNdS3EPN4tv//cXq9nlvhEs4bFpaMVhknd+WUShfo7p8na6sQu7vQC1M4eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200331; c=relaxed/simple;
	bh=eTQSxVUZfLnGrs829cA+G65lyTgq6NtmbhWpgOfLX9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i+oUByDcJO/TGDsjB6rgyt6tMDAOgC4k8QwG9AR8V3QV4JqBdmclUrG63fR8E4qW/PU5o22VWVcpHgM1c6UCcjmh8UG45PdaqsWdqfD446KrDGkm7QhwU42dq+T4POaGZp/4b/EjP/Ni38gWEXJeFSgQMPYQ+6rgn0dkmQtPp8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1YItvuir; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756200329; x=1787736329;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eTQSxVUZfLnGrs829cA+G65lyTgq6NtmbhWpgOfLX9M=;
  b=1YItvuiroz5uX50jDm33LTnhgZyfv354yHjmVtMkbQeQZsiRly8DZqmW
   lUsuaWOlHQwZs/tQmKygwfsuBDQTdOwsqsBELvpg5bvyKvM7Q2z1nOu36
   wXrwYYJMlpKNLm/at4IZn3UzgipeE6w+nUOhlTqErnTlLoBbKrzwBmvs9
   xkIim/H/7cXs+XUh2xmtTlD0+RixBe5Be5lNsBAYjBvPPJ63ooobyEnrM
   hhBbd9eCGFZ+nr4dx07ckOTYGWUZTXyYt2XEwUVow9AIjixdP23f9VnWx
   tEvuTWskUAB8tqUXG/MnMxy/mqmIeFycQ/Y+sY/dy+W6jVigjspaZma9D
   w==;
X-CSE-ConnectionGUID: 6F7sYklcQWOyW3hhhwVltA==
X-CSE-MsgGUID: JTtTiAjcT+C2qy17lJCVZg==
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="51280142"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Aug 2025 02:25:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 26 Aug 2025 02:25:20 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 26 Aug 2025 02:25:16 -0700
Message-ID: <cd732d1e-a5e3-4fcd-bfaa-7420803d83e6@microchip.com>
Date: Tue, 26 Aug 2025 11:25:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/5] dt-bindings: net: cdns,macb: allow tsu_clk
 without tx_clk
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Geert Uytterhoeven <geert@linux-m68k.org>, Harini
 Katakam <harini.katakam@xilinx.com>, Richard Cochran
	<richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250820-macb-fixes-v4-0-23c399429164@bootlin.com>
 <20250820-macb-fixes-v4-1-23c399429164@bootlin.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20250820-macb-fixes-v4-1-23c399429164@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 20/08/2025 at 16:55, Théo Lebrun wrote:
> Allow providing tsu_clk without a tx_clk as both are optional.
> 
> This is about relaxing unneeded constraints. It so happened that in the
> past HW that needed a tsu_clk always needed a tx_clk.
> 
> Fixes: 4e5b6de1f46d ("dt-bindings: net: cdns,macb: Convert to json-schema")
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   Documentation/devicetree/bindings/net/cdns,macb.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> index 559d0f733e7e7ac2909b87ab759be51d59be51c2..6e20d67e7628cd9dcef6e430b2a49eeedd0991a7 100644
> --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> @@ -85,7 +85,7 @@ properties:
>       items:
>         - enum: [ ether_clk, hclk, pclk ]
>         - enum: [ hclk, pclk ]
> -      - const: tx_clk
> +      - enum: [ tx_clk, tsu_clk ]
>         - enum: [ rx_clk, tsu_clk ]
>         - const: tsu_clk
> 
> 
> --
> 2.50.1
> 


