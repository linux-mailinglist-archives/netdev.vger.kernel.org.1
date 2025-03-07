Return-Path: <netdev+bounces-173066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D0CA570CF
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01DDC189B1C5
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FA52459DC;
	Fri,  7 Mar 2025 18:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="SMcKTf3I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155712459D6
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741373433; cv=none; b=X1v1DmQO3vL3anTV/EcFJ81xfzawKKsNv1BK1SWfumK3oLDtURLlWaJoxhmSQYrcgRszq3f5Y6MYzj2ZKWqQp51U7i/ec7POeivTq2WBZoqXvKXz//iSO24drkuEWn/Gmzt6nCXa+T2s0Xtuyvx9KNZ3hxuz+kk1tFf+BwZIaVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741373433; c=relaxed/simple;
	bh=YqR8YrWh4j0XPBC3GF1gbJlAYRdPP86NGadqz0RY0rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LslrpedQ5uKtXSpyU7wae8ea1cSAO5C8+GO0Btdc93bjh7H75Q4b+JbiDodheZKAeYI5YhUk3S4Q8d4AV4ievZ6zXiyST00+ZCdY8FX2xbYdds796lK27/sR7Lu0AdAqQCk2u/T3erJTe3zWEY5jdOZYP9L6VXGfNNWVRJDPG74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=SMcKTf3I; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741373431;
 bh=qmRiDQKZXzZ5w+8TJZygVsnLCM0DBXbnOysWCxlvMp4=;
 b=SMcKTf3ICAbIL7dLmrAqlcO5rARvPw1TYdhUt6IbwE483hcHdSaQfgL3RCxF4Q64JGmjhnwMG
 PTqsCu2yEhY+iUCvDfEkByPAd+qJbzIo2XJHndRjW9oofdICTgc+e5oLenEzwf6Xd8FGFz3RYxB
 nvKPtifsACUFuS9Kk5not5AvLoYqkeX28AK/j6udU1U0sTKd5okJeApHuTKKnso+Iz9BmQzohA3
 iERhfFqbu5mHO4M6FBds249hai+cr08tRX4Ll+XnBTRR9ndGDlG97fROorbDGeCn0yeVR5wz5oi
 6hE8z4uwPWWbtrlV2+xi9ysppPSVmAHwyYwimVWA3zCA==
X-Forward-Email-ID: 67cb3fe8789af4fdcbb0b28f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <67294dfc-a816-4828-9e45-6a897c5710d5@kwiboo.se>
Date: Fri, 7 Mar 2025 19:50:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: stmmac: dwmac-rk: Validate rockchip,grf and
 php-grf during probe
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiko Stuebner <heiko@sntech.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20250306210950.1686713-1-jonas@kwiboo.se>
 <20250306210950.1686713-3-jonas@kwiboo.se>
 <bab793bb-1cbe-4df6-ba6b-7ac8bfef989d@lunn.ch>
 <1dd9e663-561e-4d6c-b9d9-6ded22b9f81b@kwiboo.se>
 <20250307085558.5f8fcb90@kernel.org> <Z8s5ZZyTCpS9xHlA@shell.armlinux.org.uk>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <Z8s5ZZyTCpS9xHlA@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-03-07 19:22, Russell King (Oracle) wrote:
> On Fri, Mar 07, 2025 at 08:55:58AM -0800, Jakub Kicinski wrote:
>> On Fri, 7 Mar 2025 00:49:38 +0100 Jonas Karlman wrote:
>>> Subject: Re: [PATCH 2/2] net: stmmac: dwmac-rk: Validate rockchip,grf and php-grf during probe
>>>
>>> [encrypted.asc  application/octet-stream (3384 bytes)] 
>>
>> Is it just me or does anyone else get blobs from Jonas?
>> The list gets text, according to lore.
> 
> Looking at the emails I've received, some which were via the list, some
> which were direct, I don't see anything out of the ordinary - seems to
> just be text/plain here.
> 

I just learned that my outgoing email provider will automatically
attempt to PGP encrypt messages on a per-recipient basis using Web Key
Directory ("WKD"), and Jakub Kicinski seem to have an openpgpkey
published at [1].

Should I reach out to my outgoing email provider and ask if they can
disable the automatic encryption feature?

[1] https://kernel.org/.well-known/openpgpkey/hu/k5mqwn6xdasq745xgzbqu7eq3p5ysxjz?l=kuba

Regards,
Jonas

