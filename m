Return-Path: <netdev+bounces-194007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF36BAC6C7F
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 17:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13DBC3B4A4B
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 15:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA4228B4FC;
	Wed, 28 May 2025 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nERBPYYP"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BAC48CFC;
	Wed, 28 May 2025 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748444824; cv=none; b=C06ZX9bZ2VTAcVUafKNhu2iWxP3RpIwZNJSZ6MYgJZfkS1CxdmsQCIhluokJ0kbm+wY96HuwK46K54/XIVbGiXIOETEeIGmM6/nh5nbvP02ZqntAFERO3DfYG8LqWQqTQB3vYYKolcY8f9zR9537RzmfbUcTqZUrhNPnqlVYrkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748444824; c=relaxed/simple;
	bh=k1im566Qpef5VpTDVUdvexe6dorgAc3SJ9JHyLgkwNk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LIC8lzHDji/mnNjQNsZMeZEUZnAPM/duIbDRrO3dcU96sBxdgwVxaz3GGpS9gxF9NoIrnupiIH/wWIAr8mukI/HOAKyNm687YwMoUdb3FwJk+779cZ4bhbCDhtShVBf71JGoLrqQanrL01xrEHFSJo9nyz7jQQ3wj9D+NWcxZPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nERBPYYP; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D96643A4B;
	Wed, 28 May 2025 15:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748444813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WcxtT7KNbRU3NvVN+yFjoYSOMBXLQMS77hXQg71Uzng=;
	b=nERBPYYP31J3HoRYRjXos7yvQoSa4/kx+6DMb8xFvhRzgcqEXuK+AjThQhtRwOO5kPsxOJ
	hhmEGkS2f1ngQARYeTEgTEzHe34rKOu3Q+Q7F5LxAPnt/VqGQUbmFQk+gJH6MQqbsE7mpq
	wL45HJaJoeTPLSOF9BcEsnD3Ane7LYL8aCjmBoOQqs/g4TEurYJaQfyjsr83X0jdtIulve
	ELH8c0uIbt+4xehZzkuhh7C6qHkg03OiJSK3CpMCPgtGui3Tq10cB0U21g9PncXPssoq3a
	cPlrsSN0/ipf0NBKK4A6FVfAVIi1bBteIX7Jbl2af1EFZAvqopaaV0q+jxqnJw==
Date: Wed, 28 May 2025 17:06:50 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Matthew Gerlach <matthew.gerlach@altera.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mun Yew Tham
 <mun.yew.tham@altera.com>
Subject: Re: [PATCH v2] dt-bindings: net: Convert socfpga-dwmac bindings to
 yaml
Message-ID: <20250528170650.2357ea07@fedora.home>
In-Reply-To: <20250528144650.48343-1-matthew.gerlach@altera.com>
References: <20250528144650.48343-1-matthew.gerlach@altera.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvfeehkeculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedtkeelgeeigeehheetudehtefgiefhleevveekfeelgfekfeefudfgfeeilefhueenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgpdihrghmlhdrshgvlhgvtghtnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtohepmhgrthhthhgvfidrghgvrhhlrggthhesrghlthgvrhgrrdgtohhmpdhrt
 ghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Matthew,

On Wed, 28 May 2025 07:46:50 -0700
Matthew Gerlach <matthew.gerlach@altera.com> wrote:

> From: Mun Yew Tham <mun.yew.tham@altera.com>
> 
> Convert the bindings for socfpga-dwmac to yaml.

Oh nice ! Thanks for doing that ! I had some very distant plans to do
that at some point, but it was way down my priority list :( I'll try to
help the best I can !

> Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
> v2:
>  - Add compatible to required.
>  - Add descriptions for clocks.
>  - Add clock-names.
>  - Clean up items: in altr,sysmgr-syscon.
>  - Change "additionalProperties: true" to "unevaluatedProperties: false".
>  - Add properties needed for "unevaluatedProperties: false".
>  - Fix indentation in examples.
>  - Drop gmac0: label in examples.
>  - Exclude support for Arria10 that is not validating.
> ---
>  .../bindings/net/socfpga,dwmac.yaml           | 148 ++++++++++++++++++
>  .../devicetree/bindings/net/socfpga-dwmac.txt |  57 -------
>  2 files changed, 148 insertions(+), 57 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/socfpga-dwmac.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml b/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
> new file mode 100644
> index 000000000000..a02175838fba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/socfpga,dwmac.yaml
> @@ -0,0 +1,148 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/socfpga,dwmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Altera SOCFPGA SoC DWMAC controller
> +
> +maintainers:
> +  - Matthew Gerlach <matthew.gerlach@altera.com>
> +
> +description:
> +  This binding describes the Altera SOCFPGA SoC implementation of the
> +  Synopsys DWMAC for the Cyclone5, Arria5, Stratix10, and Agilex7 families
> +  of chips.
> +  # TODO: Determine how to handle the Arria10 reset-name, stmmaceth-ocp, that
> +  # does not validate against net/snps,dwmac.yaml.
> +
> +select:
> +  properties:
> +    compatible:
> +      oneOf:
> +        - items:
> +            - const: altr,socfpga-stmmac
> +            - const: snps,dwmac-3.70a
> +            - const: snps,dwmac
> +        - items:
> +            - const: altr,socfpga-stmmac-a10-s10
> +            - const: snps,dwmac-3.74a
> +            - const: snps,dwmac
> +
> +  required:
> +    - compatible
> +    - altr,sysmgr-syscon
> +
> +properties:
> +  clocks:
> +    minItems: 1
> +    items:
> +      - description: GMAC main clock
> +      - description:
> +          PTP reference clock. This clock is used for programming the
> +          Timestamp Addend Register. If not passed then the system
> +          clock will be used and this is fine on some platforms.
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 2
> +    contains:
> +      enum:
> +        - stmmaceth
> +        - ptp_ref
> +
> +  iommus:
> +    maxItems: 1
> +
> +  phy-mode:
> +    enum:
> +      - rgmii

You're missing rgmii-id, rgmii-rxid and rgmii-txid

> +      - sgmii

SGMII is only supported when we have the optional
altr,gmii-to-sgmii-converter phandle, but I am pretty bad at writing
binding, I don't really know how to express this kind of constraint :/

1000base-x is also supported if the gmii-to-sgmii adapter supports it
as well, by having a TSE PCS (Lynx) included.

> +      - gmii

rmii and mii are also supported, it would make sense to add it
here.

Maxime

