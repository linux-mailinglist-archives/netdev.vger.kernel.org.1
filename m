Return-Path: <netdev+bounces-104892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DE390EFD5
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A355285A9C
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CABF156F3B;
	Wed, 19 Jun 2024 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="K9SDPmSX"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C65156676;
	Wed, 19 Jun 2024 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806178; cv=none; b=OLMJrb4w55cAryxIWJZdCCqQhd/0vdKSfjjW9lN7bhBxpCepbFpHP75xLWIulA86xJv7uO8s6NRjDQtZosfbox+2xVXp7VpNFStMPseeJDv6BFfFl/wVPFKoTldP+7mIxausDJizoU+S0BW32jcpQ/XxCIdo1foVNsc3DvZvCfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806178; c=relaxed/simple;
	bh=4uw1xIBponaH99NlkauiqcNiMPh8WzSaHppZPKqSklY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=djQcsk39lijhsidC6t4iO2KReVcAaG4TQNTnDuSBhEADDxEeIl0OUHewPr2CX6zEMd9iRMr0FwoyGoXeA+ucV3o1zch6Zpmdz9XSJgO+L7aSs9KcU7VcdI2t2RYPeNiPL6pu9PiNyCHRtKqJ1eBBx/UDhHDz8amkkdTBp02cTVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=K9SDPmSX; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 70A4D8840C;
	Wed, 19 Jun 2024 16:09:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718806175;
	bh=FklmdbX8PxAWjM+hAVWkGY9xVy4t8YexQAod/4anuzY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K9SDPmSXR6lH3+uuJICz1jM8APdvo1J+hV1qbRZujPEmUU61+sxeBRxPDPQqaUVvR
	 jxbgiVJObEOqH9Q8xfdU/SZ8lbY14kkptIJn/DVRfI19H/8IB902WCd+d9Tg7B6aDd
	 6adLfPZ2qUkr4Mo8UF3RXL+ExPmNqobCWqrsPqSNxcG7CD/hsDEvbyLhqGUDF7f3YR
	 lgbjQqKMTaxotqjCJz2iI8F+k67OYuJwjQZ7SwbkZ09qOyLqq2iJhCGVUfANsx/8B/
	 j0fNDolddJC2e4Ddgz1SaS1VoUlmf1qB+YMyNM4n1CYPBewvBDdq890YgQswK8tEcN
	 kVY+0t34KGKlQ==
Message-ID: <c9581fd1-67da-4840-bd79-bf58f1c9fc34@denx.de>
Date: Wed, 19 Jun 2024 15:45:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: st: enable Ethernet2 on
 stm32mp257f-ev1 board
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
References: <20240619125815.358207-1-christophe.roullier@foss.st.com>
 <20240619125815.358207-4-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240619125815.358207-4-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/19/24 2:58 PM, Christophe Roullier wrote:
> ETHERNET2 instance is connected to Realtek PHY in RGMII mode
> Ethernet is SNSP IP with GMAC5 version.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>

Reviewed-by: Marek Vasut <marex@denx.de>

