Return-Path: <netdev+bounces-102825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAD5904F40
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 11:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9D0282007
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 09:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FCF16DEC8;
	Wed, 12 Jun 2024 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="LGUBHCRf"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C0216D9DA;
	Wed, 12 Jun 2024 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184467; cv=none; b=Hhc4Qhvzf7CZ2sOJViRhWt51k4oZmzTowT6ZJi7cvRUcaywOeF9BgiV2cV7gGyr0ahe8xjb2FpG+FE9QwJB+lahCn900uCn+MjHWbs9A3hMUBBV47ei8Xc7JXbczeYrwU/Mb4KswUatso4SzJSeRfT22V9M1ffTWfMxvWhAavuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184467; c=relaxed/simple;
	bh=jNl9krKqdv3h3FBhaJeSLkU+2tKNmbM6HO56+msSGUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uigW8zPPR4R2AiUx2Z/pJ/0Cw9W0Nk95AWdC4PYIRmeOafyYJnsncvKBIZULyIIPSXrgERazGAiwD3yG72mxZ8H4QB1srA3CCmd2iDzi9Uz5bPUwBJoeVxQf2eN96ZuPsADeEZlR1Zav5uNKOrHwJF25+ILtPbDZlkOB/xXHRwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=LGUBHCRf; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id A6F72887BF;
	Wed, 12 Jun 2024 11:27:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718184463;
	bh=mtONI3bvKfCZrp6Zei50iwnX9L5tGQyt3Bsl2/4/U/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LGUBHCRfITJs+jq8AZV85hrLdtml2rxOZbPwMSQ4PGGS3PZiRI0km5KaT5Ml+jTpz
	 aMir1DGK1B9hO+iDEz2lRsBUbqPdTuboZk80XA0rR8vYI3ivtjPVZ8ch8vHqqSZ6uE
	 NREzCFZwukfhixSPVvJVP04yHqlCLC4GrmSns+rbJdn5GhKo1/NV77YYV9HliDGFFC
	 LfTdk7QeAIgb5AkHrbVrW/Vqh/pHyjK3eEbfWGlDbqYHTTGTl12M91Jl0ls7c7uZ2X
	 kf3+oCUeRRE6LquMcpaQO3+ViJrjQB9yqzHaQxzZwzfqQLgW01GSbMzYRm/Yws5ynE
	 bXvw6zzFx/STw==
Message-ID: <50bd0dae-f489-4c7a-a250-7e999aab4a07@denx.de>
Date: Wed, 12 Jun 2024 11:09:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v7 8/8] net: stmmac: dwmac-stm32: add management
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
References: <20240611083606.733453-1-christophe.roullier@foss.st.com>
 <20240611083606.733453-9-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240611083606.733453-9-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/11/24 10:36 AM, Christophe Roullier wrote:
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

