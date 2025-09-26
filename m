Return-Path: <netdev+bounces-226729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DD4BA482E
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 17:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9F0A384C67
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F842309BE;
	Fri, 26 Sep 2025 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Yt/mIccI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A51A223DF6;
	Fri, 26 Sep 2025 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902108; cv=none; b=nN6jgL9ycHuoUtm18Gwnwh/y8cYF+L5+PRKosLXx+9zEy3j9a6i1ji6XXihbsxpjAs0jBC3hwkQasMAuwsUZ97NaV8FLpEKhXKueQcDSICXt8yKXsE5SMIK+ZFZsUPX/hKZug16stj0JWdTpz/UoztxmRGDrLSq348t7g2ZJgQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902108; c=relaxed/simple;
	bh=kvGHudag2hQMvaCMbZ6u9R41aw6YO+LBGx/OObLVKuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BP/l1kPQhKCxP4kBhps/jla1cxkb3c1Zu6G1f47aLngC+cbnoTTok/dFww6taGz0DYmDDO4Y6d6KXInZ1e607mB8BoSZKxNx/fEwScwXu9R84BicVbwXByV/v/lp1KvhoRuw0HvtCoVAb1nyvMiB/EGWK3X9oQvyRkeUgENlbtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Yt/mIccI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LDqdoJk9lubv55rDAuOytv8/K4Mn4cbUmQU9E/sNBGg=; b=Yt/mIccIH8D+vqtslbMH4u7aif
	Lh9lE2zaAFQ4JJvskOU91hQF3wzOQsRIZ5xafcxXCaUlKqUvTBuqg/aEfiEP5bBykK3Ytnq2ETOH7
	26tZlKzlxGkY96gLhDoQQ0AeNakHSegmpTVeOFmtTV3jXOYLiUgudWdAyib1ZH+icivk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v2Amf-009a1U-Q7; Fri, 26 Sep 2025 17:54:57 +0200
Date: Fri, 26 Sep 2025 17:54:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 2/2] net: airoha: npu: Add 7583 SoC support
Message-ID: <82a08bb5-cbc3-4bba-abad-393092d66557@lunn.ch>
References: <20250926-airoha-npu-7583-v1-0-447e5e2df08d@kernel.org>
 <20250926-airoha-npu-7583-v1-2-447e5e2df08d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926-airoha-npu-7583-v1-2-447e5e2df08d@kernel.org>

> -	ret = request_firmware(&fw, NPU_EN7581_FIRMWARE_DATA, dev);
> +	if (of_device_is_compatible(dev->of_node, "airoha,an7583-npu"))
> +		fw_name = NPU_AN7583_FIRMWARE_DATA;
> +	else
> +		fw_name = NPU_EN7581_FIRMWARE_DATA;
> +	ret = request_firmware(&fw, fw_name, dev);
>  	if (ret)
>  		return ret == -ENOENT ? -EPROBE_DEFER : ret;
>  
> @@ -612,6 +623,7 @@ EXPORT_SYMBOL_GPL(airoha_npu_put);
>  
>  static const struct of_device_id of_airoha_npu_match[] = {
>  	{ .compatible = "airoha,en7581-npu" },
> +	{ .compatible = "airoha,an7583-npu" },

It would be more normal to make use of the void * in of_device_id to
have per compatible data, such are firmware name.

	Andrew

