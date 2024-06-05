Return-Path: <netdev+bounces-100960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DA78FCA84
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2167B2343F
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86BC14D2A7;
	Wed,  5 Jun 2024 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="aXouZoru"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA64145341;
	Wed,  5 Jun 2024 11:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587301; cv=none; b=tONRfkQdJIg3gp8/wdnkpytcBovsxG4aoXtSVdAx2K6/X3omNX9H/CliqsHvQYHj8cejBaIEf/02HiNPKusBZI1WHhLLDlpA9myvXnLUHg1N/inJeq/CfUa40YjT9mVrHBCgJ7cJWXDnM3cV7GN/ypVIH9el7IOfMqJINk7T8GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587301; c=relaxed/simple;
	bh=9dqFoVtdsIlZ5J0eqCwOmVV/MKTtyxOkDKlI17dPrCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQj7pHwc+EWOHU2CFW/n0rrzKC7v3TtgkSjNJ7rZEkdHWNUfXBzmJ8P5BQSLpqO1A0XaljhiuJTnC6TU6mhxgQRpG84ShuyteHaJvPP3ncAGGjEuCNwJRneh75v3Yj25iXf6xkGdd3/FJNQCj5lKSexS0Yx+Zj3lu6VB40Jii8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=aXouZoru; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id AD8E2881A2;
	Wed,  5 Jun 2024 13:34:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717587292;
	bh=iqglW2Mm+Bj8XtbT2EuhNDhxfDBq1NKS+bPZOCk1k/M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aXouZorunfwKW3IpK7uZ6XI0TIPRnMaB9HbgvMmZi84dx2a77+9IXllJHblzvKQNR
	 9befSOqfsGLjfuCSEe5I4zmW3bl5y0uvj4NBCQf0enrv5GVAs+Hgy5BQ+d7KgiUOnY
	 Z61YPhvRUWU+3XAlzYfE3bJWBE/dX8byyiygIaj7+SWe1Zx0O/2j11AXVUv3KVrnYs
	 43vEx4F5ud9Fu2LZoaCY4EcuQM+Nzrb1zlvghvXfG7tvedW19ZByxD9mGRDu6qojFD
	 e2Q79XD+CdoXEZoegNBshFE3cZtSQRJWyvDqjuoS5V9Vtp/Fi9Rdi8Tp0ufytD6Zte
	 yGkwah2Ni3WPQ==
Message-ID: <e9dc0291-f765-4796-b0ff-7c60b35adb4b@denx.de>
Date: Wed, 5 Jun 2024 12:57:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/11] ARM: dts: stm32: add ethernet1 for
 STM32MP135F-DK board
To: Christophe ROULLIER <christophe.roullier@foss.st.com>,
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
References: <20240604143502.154463-1-christophe.roullier@foss.st.com>
 <20240604143502.154463-11-christophe.roullier@foss.st.com>
 <c2242ba3-3692-4c5f-a979-0d0e80f23629@denx.de>
 <3a59b4cc-0c7b-47d6-8322-4ae12ddb3a4c@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <3a59b4cc-0c7b-47d6-8322-4ae12ddb3a4c@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/5/24 8:00 AM, Christophe ROULLIER wrote:
> 
> On 6/4/24 18:52, Marek Vasut wrote:
>> On 6/4/24 4:35 PM, Christophe Roullier wrote:
>>> Ethernet1: RMII with crystal
>>> PHY used is SMSC (LAN8742A)
>>
>> Doesn't the STM32MP135F-DK come with two ethernet ports ?
>> Why not enable both ?
> 
> Hi Marek,
> 
> As already discussed in V2, second ethernet have no cristal and need 
> "phy-supply" property to work, today this property is managed by 
> Ethernet glue, but
> 
> should be present and managed in PHY node (as explained by Rob). So I 
> will push second Ethernet in next step ;-)

Please add that ^ information into the commit message.

