Return-Path: <netdev+bounces-242813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0C1C950A9
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 16:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 096B7342CEE
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 15:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564682222A1;
	Sun, 30 Nov 2025 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tcpivgYv"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13F120102B;
	Sun, 30 Nov 2025 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764515207; cv=none; b=QNVixuZXSGZyHjhS6QaPKuLaKcx4pL7IS5cpY4KjGn+1yMOfXMDHH1nLuyuwBOJeC4JodUMFj7ORMavFf3GQQsQhS1NQGPim9xYxMTupPtcGsJYhbTxFIrEKbFtc7BCSJfMbyBEw5HzLW0kyNkvDUGTNsFGcZ96B11dqMiJz4HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764515207; c=relaxed/simple;
	bh=8NkleLSJyu3K6P2pyhAUZfOAhBzqzPgbJxzHtjzFIi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ai+26uiGfRUNH2851PW7KIRVSH6tbnxn/McK5Z9qgzbAhasaGsNEh3VtV3NSIQqhjbLZK85+pibBHsZCM/0HIl+RruCsORD6ub8SCCSODqcl6sdTjLeYZxRbkui/E+zCnE1jSMcLrXHu8qIzFrU4sjCojl/3ALkBmb1MMatBdR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=tcpivgYv; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dK9NX4NW1z9skw;
	Sun, 30 Nov 2025 16:06:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1764515196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0R7sIdDzMoYc9IlPupimaflVi4E9vAHoqacC89Z98uw=;
	b=tcpivgYv7ZVGrTb8235/AcurwAZ5HRfprTh8o6nj/PfB9qPyPYONLEeY6NEqf1n0z0sX/j
	WsHQey9gm4FM0gHCvDq2yLrckTtuhDeEhg6g5pGbrzIa0ufKfGba9s8cmXETvfMP8fGtcu
	sLN0sfV+nac3T1I6bIBWKJ57RvFgo2ncHbFIZCghPz+7b3m6RfnOeL/8ORSoFCPoi+iXpA
	TSGOmeeLcIvhf2CUlKw2rPS7hu/z15Jt/3vtnUim8XGjfMue5EedtVAd+yt9n6d2arU7w7
	J9QSuey1AQsRwmWEi/0DOREFcp5K7bv4RQGuZ/rnZgyq8IHzrlDhmfmgNUXvwQ==
Message-ID: <67f96fd7-d2f7-444a-b448-55883f8e7fc2@mailbox.org>
Date: Sun, 30 Nov 2025 14:43:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next,PATCH 2/3] dt-bindings: net: realtek,rtl82xx: Document
 realtek,ssc-enable property
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, Conor Dooley <conor+dt@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Klein <michael@fossekall.de>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, devicetree@vger.kernel.org
References: <20251130005843.234656-1-marek.vasut@mailbox.org>
 <20251130005843.234656-2-marek.vasut@mailbox.org>
 <a7f83059-76aa-44df-aeb5-41b5072dd0d1@lunn.ch>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <a7f83059-76aa-44df-aeb5-41b5072dd0d1@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b96559a7e2a9fed2306
X-MBO-RS-META: 9p54kwky9h81iqehjhniun8d7tksef5s

On 11/30/25 2:43 AM, Andrew Lunn wrote:

Hello Andrew,

>> diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
>> index eafcc2f3e3d66..f1bd0095026be 100644
>> --- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
>> +++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
>> @@ -50,6 +50,11 @@ properties:
>>       description:
>>         Disable CLKOUT clock, CLKOUT clock default is enabled after hardware reset.
>>   
>> +  realtek,ssc-enable:
>> +    type: boolean
>> +    description:
>> +      Enable SSC mode, SSC mode default is disabled after hardware reset.
> 
> Spread Spectrum Clocking is a generic concept, applicable to more than
> Ethernet PHYs. Do we really need a vendor property for this? Or is
> there a generic property already?
Let's see what Krzysztof has to say about this, I am fine with generic 
property ... unless it would be desirable to control the RXC and SYSCLK 
spread spectrum separately ?

