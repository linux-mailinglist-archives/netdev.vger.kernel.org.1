Return-Path: <netdev+bounces-204785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A511AFC0DE
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 04:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409333AF4C3
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 02:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DC01754B;
	Tue,  8 Jul 2025 02:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZeNYjb80"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05961E0083
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 02:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751942108; cv=none; b=HdM/TKasuqN5KaLqjFBRn8jCjKSRyNnOyhAadKX4AiWJ8VpR81kqI7Mo4KspDTzh6yIsdZuPEEFM6ZvuwiuIngP2fYpOVDSVBzG+JBB/kzAICR3+1T1yssW7bgNFJbyCxxJ823tH45Uux9bI+v6hOVTLI44UeKpkmrpHSw0TEb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751942108; c=relaxed/simple;
	bh=6ZSaziu808aXhHAvi5dB5ZioGbG/1cQ5MlIp2NIfDvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AtEwnehyK/AKim8ISVQPRKMXRgm4/aZIOtE3UVThyN/uyYKOjejLy316vbuGCcDAC2vnZ3xrVrYXjqnl7pWucuwJQaknJ6Iv1EMMtjs3ShUh6wyfuwffPlUaqg3jAmuNZLrDc27Mip6P7cENHONG6cbt4ILYjWz8BRhdEbJQvhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZeNYjb80; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <69687d11-e872-45da-a3d1-f91ea9dfe5f6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751942102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qsEV695+W3Ktwe+glBrUcXpNvSeB5zOvPCRfQ1bX6vU=;
	b=ZeNYjb805OB7xPo0hz92zFWbjjSnTpEbrCvz2m7vgKsZdhXi7IDBT6yQ0cgrXhK7b9kw2/
	jHxhWK3q7GVeBA1rvUq6mipqg7NRpGnm75oKnsErdootuFdw/9NaWGOvjrrp0Z1I8me5Pq
	qR9LUOsTa1rNNWcy3jjg+Q8/i9GxfmI=
Date: Tue, 8 Jul 2025 10:34:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] dt-bindings: net: altr,socfpga-stmmac.yaml: add minItems
 to iommus
To: Matthew Gerlach <matthew.gerlach@altera.com>, dinguyen@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20250707154409.15527-1-matthew.gerlach@altera.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250707154409.15527-1-matthew.gerlach@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 7/7/25 11:44 PM, Matthew Gerlach 写道:
> Add missing 'minItems: 1' to iommus property of the Altera SOCFPGA SoC
> implementation of the Synopsys DWMAC.
> 
> Fixes: 6d359cf464f4 ("dt-bindings: net: Convert socfpga-dwmac bindings to yaml")
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
Reviewed-by: Yanteng Si <siyanteng@cqsoftware.com.cn>

Thanks,
Yanteng
> ---
>   Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> index c5d8dfe5b801..ec34daff2aa0 100644
> --- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> +++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> @@ -59,6 +59,7 @@ properties:
>         - const: ptp_ref
>   
>     iommus:
> +    minItems: 1
>       maxItems: 2
>   
>     phy-mode:


