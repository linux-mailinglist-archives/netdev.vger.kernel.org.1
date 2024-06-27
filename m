Return-Path: <netdev+bounces-107389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E1A91AC3F
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C38C3B26551
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34C8199388;
	Thu, 27 Jun 2024 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="pb9raDmu"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2529F199252;
	Thu, 27 Jun 2024 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719504311; cv=none; b=XpC50B23lGurO4MlEu3WzA3BJLWsGpVxrQWjOsLsbX4rUT61TMdVkq9cjejJd4PJSAGRnyCzLHjrIVRLGl8Uq1lfJoMAEq39ob3po/MmZdnHb1M6NpFGjYV9cjcIIzoI9MbOvmn/atrqZnY1QQJMqks3KsldReMcn+g+cc0UGrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719504311; c=relaxed/simple;
	bh=vYbU5XrYzayikzg8ilGaFgo34fy1Fmk/7IIIIN/2TSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ttgEJuREzblJKSylMrAqIjIPKhmkow+K8paFtdR1ZxPnnr+/wcQrWzQRDq866HEEA6z+oU4cnZH0I0ywa+PNRD+QsqVuWrAhmVavRFD95i6IoU0UjsQeQJfBI0lvSznOci4PiavxnRpKIXvSrRPWkJRxtUAzef0wklHPjTY8m1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=pb9raDmu; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 7E65787C86;
	Thu, 27 Jun 2024 18:05:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719504304;
	bh=EI8n9VHKnUHOFo/BpWoTbJ/7R7Q434MwT6kt2i2MjWI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pb9raDmuwwmxlNJtSUAICUuf3fJbmAP0z+tQHDr3OKraPsedWq7XdDkEbzxx2n200
	 B/XrxBUkLP2NOp/YQU0+l5Gak5m62prAN2eF+fFy995NVSqxIIJu/uESS/mbZlKdPt
	 CXtRMz3+uEiB9jVwq1Q9gNN//nwyIpalrMrQEvGxjFEC+xFaR0Kucfhs9SijPCFVqF
	 i+k0FCIsT0e8wH7em8m/mMKOUK4td2FhL+oc40HdLaNSKizpRf4ClaRj3xViYhH9py
	 1X5rH8JdLTOwz0VrawR4xwcL3GiGdS/QYvN/UEfPXTqcr4cgJ41Am3/29t9mkMDavH
	 O/DRTTljjGbog==
Message-ID: <62322e58-785d-4936-bc80-9858c412621f@denx.de>
Date: Thu, 27 Jun 2024 17:06:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH 1/2] net: stmmac: dwmac-stm32: Add test to verify
 if ETHCK is used before checking clk rate
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
References: <20240627084917.327592-1-christophe.roullier@foss.st.com>
 <20240627084917.327592-2-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240627084917.327592-2-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/27/24 10:49 AM, Christophe Roullier wrote:
> When we want to use clock from RCC to clock Ethernet PHY (with ETHCK)
> we need to check if value of clock rate is authorized

I think it would be better to add fullstop (.) here , and then continue:

If ETHCK is unused, the ETHCK frequency is 0 Hz and validation fails. It 
makes no sense to validate unused ETHCK, so skip the validation.

> but we must add
> test before to check if ETHCK is used.

With the commit message updated a bit

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !

