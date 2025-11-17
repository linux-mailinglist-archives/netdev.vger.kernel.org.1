Return-Path: <netdev+bounces-239205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F536C657BC
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 18:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DF834F34FF
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 17:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A39290D81;
	Mon, 17 Nov 2025 17:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WxHV3RI3"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A730308F39;
	Mon, 17 Nov 2025 17:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399865; cv=none; b=VQa2BQkrdbGj3HpJIwTgl2Hgz06M9d7vO6jLndaYEVCxWJa8jygIgZwPiNO2N9/f585lua06crO+HCziA903tnfz8KCpPK95GIrtEYOWp5YGAhzr6CHftiEJZwvfmf8i+Vx54G4BY6q2QmX7hFQBSDnRw0a4JmZobar6Jm5eDOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399865; c=relaxed/simple;
	bh=Rjs2OOyF6SYECcdH0ADxnHYKMjotvNyhStyzl9wulrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KiIIbL0H1haI1qTRgCxEcfPAsTInAlJDZsx4ANfPPpiP5Ssg/XFST84q5YiYxaXLaj0bgmGLOkkwV33OsWSHhPZuUvbaylnQ9trSMOx1peFPT2b027gcWM98U2JHuRKKRkGuWPRBFdDvFU49vN/j1ts6R4KDkD1djlhIyg0zP1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WxHV3RI3; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1763399863; x=1794935863;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Rjs2OOyF6SYECcdH0ADxnHYKMjotvNyhStyzl9wulrw=;
  b=WxHV3RI3QgShRTEgH1DzPImfGGb9dTwy7FC3F/Hmq9zK8QqgB7xyfyEL
   iwo44nA5WcM9li+uhsHobiAOLk4teNxpUHFMnkV/YgWE75mKm2w7P+A+/
   fa5YAwdeRfxU7TRQUuVNZ3Q2UMat+5jEukFAxTvewr0rKu5pSMfsQIu+7
   kM/a6kUbPD0rCZx2brLJcVedlJGf7JTPk0HKCD7I3lPuzp0KjXFgSnGwi
   SsdnbsA1SBFLw0+UiDkPUqYzj7Re76eACpl9qOQP0HJTKFjvSe9S+oB/P
   4mQJz032deFPQxUjk9ynkafCtmHZfmCXuwENM3XS18cNDOD7H1W2rIwmC
   A==;
X-CSE-ConnectionGUID: COIhNW6VSiuOuR1c6xAlwQ==
X-CSE-MsgGUID: 31W8C5cmQZqT6akm8Ar6YA==
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="48617166"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Nov 2025 10:17:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 17 Nov 2025 10:17:02 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 17 Nov 2025 10:16:59 -0700
Message-ID: <c352ba06-05b8-47d1-ba0b-6972a06e9d29@microchip.com>
Date: Mon, 17 Nov 2025 18:16:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next] dt-bindings: net: cdns,macb: Add pic64gx compatibility
To: Conor Dooley <conor@kernel.org>, <linux-kernel@vger.kernel.org>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20251117-easter-machine-37851f20aaf3@spud>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20251117-easter-machine-37851f20aaf3@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 17/11/2025 at 17:24, Conor Dooley wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
> 
> The pic64gx uses an identical integration of the macb IP to mpfs.
> 
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Thanks, regards,
   Nicolas

> ---
> CC: Andrew Lunn <andrew+netdev@lunn.ch>
> CC: David S. Miller <davem@davemloft.net>
> CC: Eric Dumazet <edumazet@google.com>
> CC: Jakub Kicinski <kuba@kernel.org>
> CC: Paolo Abeni <pabeni@redhat.com>
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: Nicolas Ferre <nicolas.ferre@microchip.com>
> CC: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> CC: netdev@vger.kernel.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
>   Documentation/devicetree/bindings/net/cdns,macb.yaml | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> index 1029786a855c..07ede706a8c6 100644
> --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> @@ -38,7 +38,10 @@ properties:
>                 - cdns,sam9x60-macb     # Microchip sam9x60 SoC
>                 - microchip,mpfs-macb   # Microchip PolarFire SoC
>             - const: cdns,macb          # Generic
> -
> +      - items:
> +          - const: microchip,pic64gx-macb # Microchip PIC64GX SoC
> +          - const: microchip,mpfs-macb    # Microchip PolarFire SoC
> +          - const: cdns,macb              # Generic
>         - items:
>             - enum:
>                 - atmel,sama5d3-macb    # 10/100Mbit IP on Atmel sama5d3 SoCs
> --
> 2.51.0
> 


