Return-Path: <netdev+bounces-120698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F2E95A442
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 19:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B751C22325
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 17:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772AB1B3B0A;
	Wed, 21 Aug 2024 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nilsfuhler.de header.i=@nilsfuhler.de header.b="ljuD3SAV"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D1813E40F;
	Wed, 21 Aug 2024 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263093; cv=none; b=MJ/YZ6BJ3D6da8WPix5l3ffWS6a4gYcU1IuVE3JlMjiE1yAWEhOyoxyh8saUHZkRctyhLabHjS4AEAen8OyAEaJxwAVOPBpqjBoj3wuA0doU+uDVW1s5dAxnx9JBvRf9QXHEAQfwLBgPMFnVVQ5r532imargVGXOpXbPuuabcpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263093; c=relaxed/simple;
	bh=Z9H1ZOw1PDu4npyWo4XjX8LokfU06nz18XJk55zwSi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kg/ByBxxnPmuFyQe3kCy1gG582haThDkV3fT+xn4nKhaZuWXchP6ZWqtto2jJUnHSdW5mLoTBVrx2qlM0mJG0myY0BUVuazX7A1fau7ZWj2nlX/jwh+YwJvGDFEQzsJ2eOPuJpfJjCVORO8Tj9Q2sBPSMvXS0003c1Kyb5pxhT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nilsfuhler.de; spf=pass smtp.mailfrom=nilsfuhler.de; dkim=pass (2048-bit key) header.d=nilsfuhler.de header.i=@nilsfuhler.de header.b=ljuD3SAV; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nilsfuhler.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nilsfuhler.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WpvFN3s4Jz9tSc;
	Wed, 21 Aug 2024 19:58:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nilsfuhler.de;
	s=202311; t=1724263078;
	bh=Z9H1ZOw1PDu4npyWo4XjX8LokfU06nz18XJk55zwSi4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ljuD3SAVAYG2RjIyRV+eCL+93gzML3HIP/VITlS7qgOvxHxmewQWnkwREamdif4h+
	 HdUOUrpDUOeSdjft94OXTG7nITRr7u0rjgQCwZohqf4BWl6TqyLd3eGqTTmR8BNWp7
	 vyiuCHwaC/gknjX784nJihkpUst19RsuG91qR4HzDtJ205Cnf3F43v2VK55rhLnhmx
	 Zopi9ZEF4xroeR1lDrvG6LUDiY5lvet3gJFaGAg+FLDPxWgOFSFmYokUY3MLCb2564
	 yr8VF/SB5SChqbmE1ucPxOonSWvznPTYq0Va2m9pUDoJQCG7X2l/Edxz4CTDAK/RJ5
	 QvAjoIS9VwlRw==
Message-ID: <fcb4b7d9-08e1-4a8b-8218-a7301e6930f5@nilsfuhler.de>
Date: Wed, 21 Aug 2024 19:57:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] net: ip6: ndisc: fix incorrect forwarding of proxied
 ns packets
To: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, nils@nilsfuhler.de
References: <20240815151809.16820-2-nils@nilsfuhler.de>
 <a95f1211-0f1b-4957-8e31-1b53af888cb5@redhat.com>
Content-Language: en-US
From: Nils Fuhler <nils@nilsfuhler.de>
In-Reply-To: <a95f1211-0f1b-4957-8e31-1b53af888cb5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4WpvFN3s4Jz9tSc



On 20/08/2024 15:13, Paolo Abeni wrote:
> 
> 
> On 8/15/24 17:18, Nils Fuhler wrote:
>> When enabling proxy_ndp per interface instead of globally, neighbor
>> solicitation packets sent to proxied global unicast addresses are
>> forwarded instead of generating a neighbor advertisement. When
>> proxy_ndp is enabled globally, these packets generate na responses as
>> expected.
>>
>> This patch fixes this behaviour. When an ns packet is sent to a
>> proxied unicast address, it generates an na response regardless
>> whether proxy_ndp is enabled per interface or globally.
>>
>> Signed-off-by: Nils Fuhler <nils@nilsfuhler.de>
> 
> I have mixed feeling WRT this patch. It looks like a fix, but it's changing an established behaviour that is there since a lot of time.
> 
> I think it could go via the net-next tree, without fixes
> tag to avoid stable backports. As such I guess it deserves a self-test script validating the new behavior.
> 
That is probably the best option.
Although I'm not sure whether it would really break something. The
forwarded packets have a hoplimit of 254 and are therefore not valid
ndisc packets anymore.


>> ---
>> v1 -> v2: ensure that idev is not NULL
>>
>>   net/ipv6/ip6_output.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
>> index ab504d31f0cd..0356c8189e21 100644
>> --- a/net/ipv6/ip6_output.c
>> +++ b/net/ipv6/ip6_output.c
>> @@ -551,8 +551,8 @@ int ip6_forward(struct sk_buff *skb)
>>           return -ETIMEDOUT;
>>       }
>>   -    /* XXX: idev->cnf.proxy_ndp? */
>> -    if (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
>> +    if ((READ_ONCE(net->ipv6.devconf_all->proxy_ndp) ||
>> +         (idev && READ_ONCE(idev->cnf.proxy_ndp))) &&
>>           pneigh_lookup(&nd_tbl, net, &hdr->daddr, skb->dev, 0)) {
>>           int proxied = ip6_forward_proxy_check(skb);
>>           if (proxied > 0) {
> 
> Note that there is similar chunk in ndisc_recv_na() that also ignores idev->cnf.proxy_ndp, why don't you need to such function, too?

I have noticed the chunk in ndisc_recv_na() and did some quick testing
but I was not able to get an obviously wrong behavior out of it.
I have to admit, though, that I am not sure if I understand the
condition correctly. At the start, it checks that the lladdr of the
received na packet is equal to the lladdr of the reciving interface.
That can only happen, when the interface receives its own packet, right?
Is there a valid case where that can happen? Or am I missing something?

Greetings,
Nils


