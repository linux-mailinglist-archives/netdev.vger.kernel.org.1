Return-Path: <netdev+bounces-114043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D3E940C96
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F214286A8F
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 08:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079A41946BE;
	Tue, 30 Jul 2024 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="fCxrDxVU"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD731922C1;
	Tue, 30 Jul 2024 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329865; cv=none; b=SwNP8PCaao9QFZNIz4TBg91hdxDSu3GXad4uZHlM7+lthk846kyrCp7eJR85DlG/r0GVxf8kSe1aIsbHRyHrEarz5356hjDhWE33ckdcjh7dpKpXn3w1qzsi6LYgXoS8S4INJ13GQV2x941+u9K88YIKA5WyLffJ+0g7wlfgd8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329865; c=relaxed/simple;
	bh=oQkSleHePHiheYmG9bMUCk4eSdLq74yNcf+ztD4EkZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dyr2O7KKZjTT8OcpnSj4jUeDz8/7HM4eL5nN/AEhviO6fqOFUImeTCbFv8lDZuwSzmE0X65bNHMWYZGhrKW5F+5HnAR5YS38vQNGmrQrW/oyOrmTpGO/TDhgRLxXC3bgkeP+aRWMG2PBYcgqRpwZzRFnP468r2YBhKdLCWPBqBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=fCxrDxVU; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3BA8E40005;
	Tue, 30 Jul 2024 08:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1722329861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n2VJWHRifEiKGRApncgX7oEiPpK9ubdZKSTgq0xJ+2o=;
	b=fCxrDxVUm1f+Zwa3unaOLYjwweb9sg9AwmaoF6WdWlhzV13ieQUJElK0NCDx7Os2TYO/Oz
	DUEP0VH2IYYw4Q6jNwSrfcyFRfFyc2ir2NvmDFyzNrtQMRFmVXJGTj61pxw0RclYcsLgED
	XHmrds4xWupsH3ThdGAB2fB6fDB9uD0ozEpojfc9HpRNPXsJzf6nwG6brZzOwnvEgnApJ9
	1rwbRYkCIA2GUrAKtI30zPDRduL1sqQ0cA1gVDvhHB0YwiEPXKkd3URPfhs+xkWa28p9Bm
	JDmURk/6rlul3wRL9dsfF0w6PnXFc4/HwaxJo66XOK3eZU4atQgUGQTOsRHjuw==
Message-ID: <3d0e39a3-02e9-42b4-ad49-7c1778bfa874@arinc9.com>
Date: Tue, 30 Jul 2024 11:57:36 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: dsa: mediatek,mt7530: Add
 airoha,en7581-switch
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: daniel@makrotopia.org, dqfext@gmail.com, sean.wang@mediatek.com,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 lorenzo.bianconi83@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, upstream@airoha.com
References: <cover.1722325265.git.lorenzo@kernel.org>
 <63f5d56a0d8c81d70f720c9ad2ca3861c7ce85e8.1722325265.git.lorenzo@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <63f5d56a0d8c81d70f720c9ad2ca3861c7ce85e8.1722325265.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 30/07/2024 10:46, Lorenzo Bianconi wrote:
> Add documentation for the built-in switch which can be found in the
> Airoha EN7581 SoC.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml     | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> index 7e405ad96eb2..aa89bc89eb45 100644
> --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> @@ -92,6 +92,10 @@ properties:
>             Built-in switch of the MT7988 SoC
>           const: mediatek,mt7988-switch
>   
> +      - description:
> +          Built-in switch of the Airoha EN7581 SoC
> +        const: airoha,en7581-switch
> +
>     reg:
>       maxItems: 1
>   
> @@ -284,7 +288,10 @@ allOf:
>     - if:
>         properties:
>           compatible:
> -          const: mediatek,mt7988-switch
> +          contains:
> +            enum:
> +              - mediatek,mt7988-switch
> +              - airoha,en7581-switch

The compatible string won't be more than one item. So this would be a
better description:

compatible:
   oneOf:
     - const: mediatek,mt7988-switch
     - const: airoha,en7581-switch

Arınç

