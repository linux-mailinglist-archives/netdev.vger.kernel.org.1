Return-Path: <netdev+bounces-184405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0952AA953FB
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 18:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69813B0B3C
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 16:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFDC1DF979;
	Mon, 21 Apr 2025 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="GjLXh95a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB36F1DC9A3
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745252723; cv=none; b=KwlaqlhL6VBSDWK5gWkne8enVjv8mOgLnV9/byNo+4f4zur5MYT0XQ6RZkIQ7yoBpiSrrFdqXlVaJTKASVI/vEmEcNBMj4sLIoLCdlV2q5wZh4s+JrS+1WvG7j40fj/ewdylBeXvwHoSjxu6pnzfjxyq8ZedlkJNYJOEuCx9Guk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745252723; c=relaxed/simple;
	bh=athkDzxW7iFCfzDVR6ahqyWmKXvvfjxgQ3Yu7ffSaU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9xMbSmOdCjXevTvA872rhAEl3epbu9FQ/BwT4zHlPUUnts5AsOVGEnRYV2rjlAN69K20Q98K/4Pr/W7Leg67GP9Ojbuf2qJdYHK38kjquZU9dIKzsWHRhjv4gJnFm8mu4UEUXDqEkUvui+IeQhhBlCz8PznV0DByenNS0rMsDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=GjLXh95a; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1745252714;
 bh=esv+rDKVix0ldoFrtD4D3MGlv5tCJf22iS0JUE37zVs=;
 b=GjLXh95aq8BWXosfr7bDOMZ2F62TVlpUQeBIUQLK6pvfDgZ5f24/eFjgg4I3/h6yuj7H9PiAJ
 16cZN7i2lXPC/jQ+mr7UBXJFH9BjiBoxShaab985yLxGlfpQ8S0UnPAOB+K6UB7+ZfZHlmwsZsp
 jCPjsA2vzyUastTTNnsEY85tj2T9yk2KKViFBp41oUD8N1BvYozuTCeAQ7rqsijaiHgYj6nP5tG
 9eUjorlY9VIIQ0rPrG8vecWF4IseeiBLGS5nZ5a+OTF1DBxYi0XCfIydtdfnIHkO4ackVpmAF91
 7rpLMvX1w8S2J5vIclSX9A0uIcn4t6c7W/LwuUQpyzkw==
X-Forward-Email-ID: 680671678a5cda485177d286
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <18705cc3-ef2c-49f4-b284-bca2308950f9@kwiboo.se>
Date: Mon, 21 Apr 2025 18:25:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: net: Add support for rk3562 dwmac
To: Kever Yang <kever.yang@rock-chips.com>, "heiko@sntech.de"
 <heiko@sntech.de>
Cc: "linux-rockchip@lists.infradead.org"
 <linux-rockchip@lists.infradead.org>,
 Conor Dooley <conor.dooley@microchip.com>, Jose Abreu
 <joabreu@synopsys.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, Rob Herring <robh@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, David Wu <david.wu@rock-chips.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Eric Dumazet
 <edumazet@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20250418095114.271562-1-kever.yang@rock-chips.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250418095114.271562-1-kever.yang@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kever,

On 2025-04-18 11:51, Kever Yang wrote:
> Add a rockchip,rk3562-gmac compatible for supporting the 2 gmac
> devices on the rk3562.
> rk3562 only has 4 clocks available for gmac module.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> 
> Changes in v3:
> - Collect ack tag
> - rebase to v6.15-rc1
> 
> Changes in v2:
> - Fix schema entry and add clocks minItem change
> 
>  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 3 +++
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml     | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> index 0ac7c4b47d6b..a0814e807bd5 100644
> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> @@ -25,6 +25,7 @@ select:
>            - rockchip,rk3368-gmac
>            - rockchip,rk3399-gmac
>            - rockchip,rk3528-gmac
> +          - rockchip,rk3562-gmac
>            - rockchip,rk3568-gmac
>            - rockchip,rk3576-gmac
>            - rockchip,rk3588-gmac
> @@ -51,6 +52,7 @@ properties:
>        - items:
>            - enum:
>                - rockchip,rk3528-gmac
> +              - rockchip,rk3562-gmac
>                - rockchip,rk3568-gmac
>                - rockchip,rk3576-gmac
>                - rockchip,rk3588-gmac
> @@ -149,6 +151,7 @@ allOf:
>              contains:
>                enum:
>                  - rockchip,rk3528-gmac
> +                - rockchip,rk3562-gmac
>      then:
>        properties:
>          clocks:
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 78b3030dc56d..7498bcad895a 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -83,6 +83,7 @@ properties:
>          - rockchip,rk3328-gmac
>          - rockchip,rk3366-gmac
>          - rockchip,rk3368-gmac
> +        - rockchip,rk3562-gmac

This compatible does not need to be added in snps,dwmac.yaml because
snps,dwmac-4.20a is already listed in this file.

Regards,
Jonas

>          - rockchip,rk3576-gmac
>          - rockchip,rk3588-gmac
>          - rockchip,rk3399-gmac


