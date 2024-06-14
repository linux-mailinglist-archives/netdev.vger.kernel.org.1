Return-Path: <netdev+bounces-103622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4EA908CE1
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76AFC1F22091
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3251079E1;
	Fri, 14 Jun 2024 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="a3kZRRhg"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D5119D8A7;
	Fri, 14 Jun 2024 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718373643; cv=none; b=q7dZUfhD/16jhNuszdQDJZK51lJQTzx4cyCwEbAJLEU458OBl1ivNwLOoKdsjE1r+JIphqCM7jod66P0dqSffDxEom2d+gI0LxclVc2N96g1Snto7KNJr4Dob7CL4/6Ws7T49XBmEmPM7b+zGaWpyVoZZhSbMARp0fwr2LmdTKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718373643; c=relaxed/simple;
	bh=N3ena08kJ6d6XrNJnJXjlULm5ttbXBgY0ikmHO0V7LI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bkx8YCaQpKEtC86aFHFMxYs365kwyXnt8OO44fXj5Cjpu8LuHR8IJm0fr94m5D2yKZXADmcQPey7JLA7I+TLxgozMgmvjCGb385KaVxSG0tZmnyCWLEMEz//nnejLcD791/kt2LoLKctiAt3gMnKvCBOcFtXuQQpkjN0zag8vVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=a3kZRRhg; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 5DB35889EC;
	Fri, 14 Jun 2024 16:00:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718373639;
	bh=4+DN2i7csqmQcAXLvxkcKDrBrfSZbHHe/kZgUCJhXOI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a3kZRRhgOmNtheXARqqNagHPCshPBM7Gz0hWk44rNgmGJlEMoFnH7r83Jhr+nfyHa
	 +RfsmHIroQ9Y9DcPkjHBv76qG5f5IFQGAPoKMVHvhZPsiDhfryxIZt7pvPuB3GTLMO
	 +kve1Jlc30+9GuSIjpVPs8P8jaY44ux3jDEd28AtpiJosO+USCOBJq+KVwsBsaU5mP
	 tkgTYMenPeVEkEoQy+jaXecH80U3DZF0ZoI3ALacht9er/PL9lzHYnyRRrx0jAv9LG
	 moYl3iGrflhI4xX9uy8GuZBrnbhLQ3E25o8eMDY9wXh8HIIdQIJ7SyNC/GHiDuQI+P
	 Zr0kEUDFKa9XQ==
Message-ID: <d7006e54-c0e8-445c-a589-9674235913a6@denx.de>
Date: Fri, 14 Jun 2024 15:53:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH 1/2] dt-bindings: net: add STM32MP25 compatible
 in documentation for stm32
To: Christophe Roullier <christophe.roullier@foss.st.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>, Jose Abreu
 <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240614130812.72425-1-christophe.roullier@foss.st.com>
 <20240614130812.72425-2-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240614130812.72425-2-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/14/24 3:08 PM, Christophe Roullier wrote:
> New STM32 SOC have 2 GMACs instances.
> GMAC IP version is SNPS 5.30
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>   Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> index f6e5e0626a3f..d087d8eaea12 100644
> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> @@ -23,12 +23,17 @@ select:
>             - st,stm32-dwmac
>             - st,stm32mp1-dwmac
>             - st,stm32mp13-dwmac
> +          - st,stm32mp25-dwmac
>     required:
>       - compatible
>   
>   properties:
>     compatible:
>       oneOf:
> +      - items:
> +          - enum:
> +              - st,stm32mp25-dwmac
> +          - const: snps,dwmac-5.20
>         - items:
>             - enum:
>                 - st,stm32mp1-dwmac
> @@ -121,6 +126,7 @@ allOf:
>           compatible:
>             contains:
>               enum:
> +              - st,stm32mp25-dwmac
>                 - st,stm32mp1-dwmac
>                 - st,stm32-dwmac

Keep the list sorted please.

