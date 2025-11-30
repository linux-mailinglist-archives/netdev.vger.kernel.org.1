Return-Path: <netdev+bounces-242812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A00C950A3
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 16:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 700404E023F
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 15:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D988221FAC;
	Sun, 30 Nov 2025 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SOQC3lbi"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A037936D51D;
	Sun, 30 Nov 2025 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764515199; cv=none; b=Cpz+s2bAwQOpOBGwWDLRz3C9VhWqABDqs72EIlE5nf4kbfgWmlC6vMIVwnBCmSgxAekxQfh7O5yWwRNh3/91LNejdjohfrY4FQi8X2Wr83E9grOTiDxT5xBI6R2+9t9joTnCXexdxdT9oVnhGm40pmFTJ0cC9XMzfEHQvZG+uVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764515199; c=relaxed/simple;
	bh=kxzlO8QnX9kMXsyJ8mRRd9RYkVk15ZtIoOfMniqz8YU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LF0S2Dtp/Lz1VLDw8ZlERtkn0FpdOqa3oosQ4lBsIsCsNGDN5Bp+rk2TfBPenxQNyBVUDc3lkwfQrzZVQmMKW04JE6oMVHF2MYP4zd/1D1E+SqiuFFNFmySqMjg0n4piyx8hxgMkJbS8QZ2T+Ni13aG5WhEzG+VgJq1qBK3LHUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SOQC3lbi; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dK9NT6RXXz9t0f;
	Sun, 30 Nov 2025 16:06:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1764515193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EyJhDAbMx6xwxzSdUmwUcgyIzZx8XzLfe0/ngP8XM3k=;
	b=SOQC3lbibkVKt2Da2RTZHQWeEEA0wSrst2Cg/Qr92V237NdFX8b6CMrvAHuzsDy3/Mj2Qu
	i2oCDLi/aGI3GDep5tIOEaocoY4JAvbJKRDCK+cWNiy8/hkJUtpBB7F8t9DabXDVrNyOvC
	rjkmRLkcV6FY5x7D0UX2g4WXvb93oB2cpi0wdTbxp2npc1JdTjDdUHANRB/T2bHchDvjR1
	AoAyG2K+c17/g+UKRYNYHRDp38bP9Mb23/3HXG4rFtK3kX8ptMX/EwcJxlXU49Fjzp3Bfr
	Hv+RZqnr3jG0fC+P2QJdSXf9/pIWS8xvYwi217kow2xSZdux3PIMKR9HERNDhA==
Message-ID: <a861aa24-e350-4955-be5a-f6d2f4bc058f@mailbox.org>
Date: Sun, 30 Nov 2025 14:41:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next,PATCH 2/3] dt-bindings: net: realtek,rtl82xx: Document
 realtek,ssc-enable property
To: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, Andrew Lunn <andrew@lunn.ch>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Klein <michael@fossekall.de>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, devicetree@vger.kernel.org
References: <20251130005843.234656-1-marek.vasut@mailbox.org>
 <20251130005843.234656-2-marek.vasut@mailbox.org>
 <f3046826-a44c-4aa9-8a94-351e7fe83f06@kernel.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <f3046826-a44c-4aa9-8a94-351e7fe83f06@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c5ac8564a35001ead55
X-MBO-RS-META: mqc4gudz7d3qrkyuq1jhoygz8frtgxko

On 11/30/25 9:20 AM, Krzysztof Kozlowski wrote:

Hello Krzysztof,

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
> I don't want more SSC properties. We already had a big discussions about
> it - one person pushing vendor property and only shortly after we learnt
> that more vendors want it and they are actually working on this.
What kind of a property would you propose I use for this ?

