Return-Path: <netdev+bounces-106635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 462BC9170DA
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 21:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF93B1F2228E
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 19:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42E517C234;
	Tue, 25 Jun 2024 19:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="CJsacGD7"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FDB1DDF8;
	Tue, 25 Jun 2024 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342389; cv=none; b=VJz6WjwQU8T1cMUPHFz2voE8YBmTaOjOOqh9LdaeEze+DI4Ny47Bdrc0LcR8s5GLhGq8NxiJObhBLzOhtMj9Nnda9d1oOZKUq3OVxdWhJvv92bAA2PrZvn6FQEnjKRIC4ce42CMiM7vZZ4jRubiPR26muDFzH8IC7/QzCGjpD1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342389; c=relaxed/simple;
	bh=3419DJzdZjN7cGJzNeVl5//+1l7h8MfcMUN586NHXPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8gzHn7Z0TyRtjrwqtPRJwCQsHLs6CDvXQkyG0Th8r3Pktpu+U55uHAonCaoHOXFUre9dHLM+5BxPbiKfMTeMtR/mqmKT0KlBDsS6FSzYELAOPrJDBw4YYTk11GjlpAKpOy2J3U+g01aF/yoPASNAgFdIbCLauiG9wi9CoXJ4A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=CJsacGD7; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 0AB1F87C83;
	Tue, 25 Jun 2024 21:06:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719342385;
	bh=/naqhY3LcDG7y5oYJVUmeYxTSnE3WTaYZEi9XGbY0U0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CJsacGD7O8fwjBKfZfx48Ui1i2eL7tKaT7TV+uScDee1vNvHuRNDRm0uxSb/Vxbyp
	 ZG98lbn7dPeGGhjduBS01ndP77EIQBTAeosZ2GXoFdc90H2ZTYDV+GUaagmxtYA24Y
	 d7Zo5hIW/0q++dk8WvtB/S2HbRyjq8vQ2f9BkhV8tOpdWCuwgyNhF5rgYTPxwUt1N5
	 ZTbSPfviaMoR59XWN6HttOpouObdZn7ODAprvpS5N+qacUciQZQdJ2X0VBPYt8IXYI
	 l05ktv+Ou1pbRWMP2MrvEj7RQYa7Y8bXQN+WLuFxDn8tkcw5PT/o/xC8KSKLUkEguw
	 35uu5tAR+T/ag==
Message-ID: <f492d4e3-5762-405d-bb35-49918b0bed07@denx.de>
Date: Tue, 25 Jun 2024 20:44:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH] dt-bindings: net: realtek,rtl82xx: Document
 known PHY IDs as compatible strings
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Joakim Zhang <qiangqing.zhang@nxp.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 kernel@dh-electronics.com
References: <20240623194225.76667-1-marex@denx.de>
 <cc539292-0b76-46b8-99b3-508b7bc7d94d@lunn.ch>
 <085b1167-ed94-4527-af0f-dc7df2f2c354@denx.de>
 <bad5be97-d2fa-4bd4-9d89-ddf8d9c72ec0@lunn.ch>
 <246afe9f-3021-4d59-904c-ae657c3be9b9@denx.de>
 <de304f76-d697-4c35-858d-fdd747b1bea3@lunn.ch>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <de304f76-d697-4c35-858d-fdd747b1bea3@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/25/24 3:17 PM, Andrew Lunn wrote:
>> git grep ethernet-phy-id0000.8201 on current next-20240624 says no.
>>
>>> We could add it, if it is
>>> needed to keep the DT validation tools are happy. But we should also
>>> be deprecating this compatible, replacing it with one allocated from
>>> realteks range.
>>
>> I think we should drop from the bindings after all, I will prepare a V2 like
>> that, OK ?
> 
> Yes, please drop it.

Done in V2, thanks.

