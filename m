Return-Path: <netdev+bounces-102824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC2F904F3E
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 11:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7474282084
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 09:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B4116DEA3;
	Wed, 12 Jun 2024 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="CyKgblTM"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3C816D4F6;
	Wed, 12 Jun 2024 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184465; cv=none; b=dojyeEUMI+nkvhVeY9kjVIYqBa2t3LyABrX56ULg0sous52rkrqCj4Lr91dtgUVl87HhGVYTINUD1MED3icm9ayl7qXBpnBRuxms2Ss7S+iN0TYrAsenS4KfW4WnhjsM12cHxte9j2S7kpcBxSqePxfvMxfCksB4wMRKX5RX9VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184465; c=relaxed/simple;
	bh=PkIMFFGFnqCXMXZabI41CKNE5v4LOTpwwZ/p3AGipW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7wmv0iLUzlGCgi6ecgi9v1G0YO8ed2C7wzW0fW8EYtIEz6KJC8FMJvt744ZsbVIeOX7kPQ/hRPyu2F+uTDIXV5Gfoaz+NwWeVgKQqp1i1gUTmFJ7VeWe2NHcRUuWcoYF+kgTNEdFKUFatMgZy+QuJLXTMGK+2tp7+BWDt+U3J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=CyKgblTM; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id A05A688791;
	Wed, 12 Jun 2024 11:27:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718184462;
	bh=9mQdHVFY5Rr7BuQrcz+YQZAsk9ceYLt7tNd9Bzavdng=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CyKgblTMOAs4wyaAg1GySyfcS/LQCfb9xWXE9Y8AyEsc4HI+RjPprye0Q9KFn1jP3
	 kemXl9m7oPj8bPNnJ5DECwWs/00wBDq01eemEaz9aar2nS8Ft6qN0I6hI8EPVDvkmK
	 qmxg6omxFPKh4jSt1vxIgTtNw7x+qMcO+Vl1lj2TUCzbIkHESgI8+lSN4DVg2ZpCuK
	 EIIaDt6mhv1JPYcOkmjCBk0SP7ZrC3TcRarBva2zyUKvHjh9bPas4VILRrrztATZg1
	 gpIvdutPGbqt+2jSvp5ex66EqaCrHUoq5DSTpSBrNeXG61Mf74RP1GwpPEFzWrRTK1
	 pX+sZiXKs5IRg==
Message-ID: <30e6d798-8dd2-42ec-b02e-ddd3f7736862@denx.de>
Date: Wed, 12 Jun 2024 11:08:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v7 7/8] net: stmmac: dwmac-stm32: Mask support
 for PMCR configuration
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
 <20240611083606.733453-8-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240611083606.733453-8-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/11/24 10:36 AM, Christophe Roullier wrote:
> Add possibility to have second argument in syscon property to manage
> mask. This mask will be used to address right BITFIELDS of PMCR register.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>

Reviewed-by: Marek Vasut <marex@denx.de>

