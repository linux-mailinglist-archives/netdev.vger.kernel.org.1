Return-Path: <netdev+bounces-190226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B15AB5C2A
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 20:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1244F1B47B6C
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 18:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB65A2BD006;
	Tue, 13 May 2025 18:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y3CqqPo5"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18E02AD0B
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 18:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747160325; cv=none; b=EXhqW9bkt3lH02mXundEfD0G7E3zv2pjZ7fIj+V0rwq2sxMpwkJgw7fyd34P+BX9H7SInLkDhCvpDsnkW06rnb9Z5N5ym7uRnFpx3fOmwAlrSCMi3D8x4bv+cV/4D98unB+Z1gB02AfdPG2FJPyRM2mbFmQkgCDLKx2afB1yy2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747160325; c=relaxed/simple;
	bh=SLG+lrvXt+n0hvTIeuY8ERzR/2Kxpmg3oDOwx6njyOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZsIFZQxOlyKcBMW0w/aOq1ALb1UU40zfYnZEZy3NUR/JHAOatldKeZI+NXi5ILMy3oBrGx/SyDgk/ZgachnPnVyLav1wIpx7BBtcqhbGWHy60DRQDWSxhrhXVRjB42XZ9MJBRyM1XWix/0qDTvrcqRcWLRETbEMB1NonDReIPvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y3CqqPo5; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <53d495b1-b593-4ca1-acf3-fe1907d9a56a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747160311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DB3tTFLWzUdI+/2k2/G0z9ItKcJmZ4ohDe0Yiw75l7E=;
	b=Y3CqqPo5fnt83dlvG+F+Fhl8lzPo7gTuJydCjuOS++XEXTrJTPeU03kJWkVPJI8GvEYBrC
	EcGSe2F8xowDLzCZg9r4twYSzTbnd91j5l6l7ik0AaCipJShu0+nngexHRBjIiJSvafxz4
	hpepMNP0S7bEtGDSqEf7R4/ze9Icvs4=
Date: Tue, 13 May 2025 14:18:24 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next PATCH v4 01/11] net: phy: introduce phy_interface_copy
 helper
To: Christian Marangi <ansuelsmth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 llvm@lists.linux.dev
References: <20250511201250.3789083-1-ansuelsmth@gmail.com>
 <20250511201250.3789083-2-ansuelsmth@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250511201250.3789083-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/11/25 16:12, Christian Marangi wrote:
> Introduce phy_interface_copy helper as a shorthand to copy the PHY
> interface bitmap to a different location.
> 
> This is useful if a PHY interface bitmap needs to be stored in a
> different variable and needs to be reset to an original value saved in a
> different bitmap.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  include/linux/phy.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index d62d292024bc..9f0e5fb30d63 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -173,6 +173,11 @@ static inline void phy_interface_or(unsigned long *dst, const unsigned long *a,
>  	bitmap_or(dst, a, b, PHY_INTERFACE_MODE_MAX);
>  }
>  
> +static inline void phy_interface_copy(unsigned long *dst, const unsigned long *src)
> +{
> +	bitmap_copy(dst, src, PHY_INTERFACE_MODE_MAX);
> +}
> +
>  static inline void phy_interface_set_rgmii(unsigned long *intf)
>  {
>  	__set_bit(PHY_INTERFACE_MODE_RGMII, intf);

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>

