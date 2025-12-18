Return-Path: <netdev+bounces-245406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB281CCCFA8
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 18:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24BCA303371A
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 17:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C42301489;
	Thu, 18 Dec 2025 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SUzvQy0+"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FED630C37A;
	Thu, 18 Dec 2025 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766079218; cv=none; b=BtDKmiAXuvwfHT+5GG4Sp5XFMTKeuqTyXdVgscw+0Y5/UmbO6wMoDpwLnXUIaie9xuYPKz4qRHMuidoepOACtLMss4gR6rIzaMWKVrLS4imfgoT9lv4gckKvGLvO4Kf8wJzRRehq7hwfKCuAgZlyjxc66AKT9JfFrW5UpanKe/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766079218; c=relaxed/simple;
	bh=hCSA+MCaGiFCYYThAQeyfEigR9q1Fc+9Xa/K+7dUnxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nrKfxiE250qBgrM5mAzbaq+7CsQI/f7B2UQMB5h97rJ2YaXQmBXCExku7Td0OwMI5gtLkl4On+fVsx9iB8r0t5AaI2k6JIJcBWNW1Jcyx62qzN7yMvUsTAZSDIA5eISED+9MjJiUpJOinDxM12QcjMV/IiaqDB/T2RtAAeqzZ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SUzvQy0+; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dXHnd3KsZz9tYT;
	Thu, 18 Dec 2025 18:33:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1766079205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CE82oUMMTjqiE2Iu+PZldpVHwoYxKmXoIAp7gZTIxrw=;
	b=SUzvQy0+UTUyq1LxAMgBKuvF/70RcWAVU6wTSFOAWvXbJA9E8veUxKN7IOMeGLzSlKjSgz
	/fQMDsQpMASW/1vgfJV0RfcOu/PErQeXDgE344SDQvx2SJ+shplYFtYQrPNYFAboRSiVdX
	owfyKPO6UNAKds+IN0ARYoqRpofPuDcB7iVOshVURz26Cgy0I6kc3W5m2/fIQl1xyABj+0
	7jedrVFr/Y2flIEFiYzgO9Zs9Ga5REFQ6+0S7//XMzvTptQfmPu8YcLHSWYNepL/Egks/G
	JlLyeFusZ2DmHcHAxq0ewyMv5UuTMekDeNZQJGnF5fk8OL5YVfisV/8Nqwuocw==
Message-ID: <c74284b3-9e99-481a-ba25-861c03fb69a7@mailbox.org>
Date: Thu, 18 Dec 2025 18:20:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next,PATCH v2 2/3] dt-bindings: net: realtek,rtl82xx:
 Document realtek,ssc-enable property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, Andrew Lunn <andrew@lunn.ch>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Ivan Galkin <ivan.galkin@axis.com>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Klein <michael@fossekall.de>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, devicetree@vger.kernel.org
References: <20251203210857.113328-1-marek.vasut@mailbox.org>
 <20251203210857.113328-2-marek.vasut@mailbox.org>
 <20251205-sly-nano-barnacle-ca25fe@quoll>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251205-sly-nano-barnacle-ca25fe@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d10b42507d9251369ac
X-MBO-RS-META: j6nikm1fimrys49589i4ewh4ew7dzuee

On 12/5/25 10:04 AM, Krzysztof Kozlowski wrote:
> On Wed, Dec 03, 2025 at 10:08:05PM +0100, Marek Vasut wrote:
>> Document support for spread spectrum clocking (SSC) on RTL8211F(D)(I)-CG,
>> RTL8211FS(I)(-VS)-CG, RTL8211FG(I)(-VS)-CG PHYs. Introduce DT properties
>> 'realtek,clkout-ssc-enable', 'realtek,rxc-ssc-enable' and
>> 'realtek,sysclk-ssc-enable' which control CLKOUT, RXC and SYSCLK
>> SSC spread spectrum clocking enablement on these signals. These
>> clock are not exposed via the clock API, therefore assigned-clock-sscs
>> property does not apply.
>>
>> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
I'll pick the RB , but will update the subject as follows to reflect the 
adjustment to this commit, I hope that's OK ?

-dt-bindings: net: realtek,rtl82xx: Document realtek,ssc-enable property
+dt-bindings: net: realtek,rtl82xx: Document realtek,*-ssc-enable property

