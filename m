Return-Path: <netdev+bounces-102222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE32901F8D
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8CFB1C215A9
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 10:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEFC7D41D;
	Mon, 10 Jun 2024 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="D6zXtnFk"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619E974C1B;
	Mon, 10 Jun 2024 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718016256; cv=none; b=g2shD+QPgeOxLrvOk4ZflASYDHn1GeEuoPtInUGRDKBw/WIMzqzxKc+4cxY23CyubcPXG1uc5Rp0YbKkcB0xqvFerM4vGdU3nYEGiopmp0ztdCR3aedmJlM6Qk6lcKCVAeBV67WHEGmpJYcTzIuGOLl0MpE3tQbVND27TCSlJBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718016256; c=relaxed/simple;
	bh=j25TneZAYI8yingaK5BN90U5TMlPflbt58PsnKLC48E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uW5s35wPwGvH6e0hRshymq6KGyOYYvRr9J09KuuiMDthlYRK6D9lswbIO3hA4EqZRo56sR4dHuD9LdyCfLyqNUHi6hXQNY5CpQNU1vhnkqYit1ca5Zhg8QIXiG9UumCnZd/Gacmc13SPCO12H8vvQ7lUrQx0CoN3lm1ALkNIC6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=D6zXtnFk; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 4A73288444;
	Mon, 10 Jun 2024 12:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718016248;
	bh=+YcFOLp95o1GBuDHuthGUIZWbX4vuCHnUlOjQYGO9DA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D6zXtnFkOVbBuyPMx38Fm8fSMbgk2MrJDCqtQju8GCITkGZyi4Su6ilGvY953x/5B
	 Ks9SbzCjVhzYyIAhtc6Puk3lSSLQ/7eT1DsqIE+0xpwn7EY6rSmId1PxDhEAIj9zjj
	 2Az0qgJn5GvNqpDFGXmjBHHjGOeVkoEN4IDsFlOdHb+EJst8Ui4Tvol0nZXeHCKRmL
	 VL/gRSbRLT13DufEImjhi+pzviQJliHWhvwz2KsoCg4I0lTZgvg608kICELMF57qhS
	 kpZSqLOtxU5QTJShnnR8fnGG0cG6B25wDntI3cDTkdslTrrV1At4vFtqJyYVNnyHyi
	 /VV3fbaGO1qCA==
Message-ID: <c4be5362-5fbf-48f1-81b1-00c7bcf1090d@denx.de>
Date: Mon, 10 Jun 2024 12:40:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v6 8/8] net: stmmac: dwmac-stm32: add management
 of stm32mp13 for stm32
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
References: <20240610071459.287500-1-christophe.roullier@foss.st.com>
 <20240610071459.287500-9-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240610071459.287500-9-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/10/24 9:14 AM, Christophe Roullier wrote:
> Add Ethernet support for STM32MP13.
> STM32MP13 is STM32 SOC with 2 GMACs instances.
> GMAC IP version is SNPS 4.20.
> GMAC IP configure with 1 RX and 1 TX queue.
> DMA HW capability register supported
> RX Checksum Offload Engine supported
> TX Checksum insertion supported
> Wake-Up On Lan supported
> TSO supported
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>

Reviewed-by: Marek Vasut <marex@denx.de>

