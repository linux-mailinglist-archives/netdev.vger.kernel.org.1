Return-Path: <netdev+bounces-277681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Nv1GZME2ml+xwgAu9opvQ
	(envelope-from <netdev+bounces-277681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 10:21:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7233DEF37
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 10:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64DA03004C42
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 08:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528EE3368AC;
	Sat, 11 Apr 2026 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moehl.eu header.i=maximilian@moehl.eu header.b="gko1z/gR"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A5333344A;
	Sat, 11 Apr 2026 08:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775895503; cv=none; b=HDUn7xarpzRd4/li2cBONpRe86T8UDZxbFNcmUKsNmV7kAeSHpSdbFC0aSLK25sUebpYizYKL7F3763C35Vh3IcpJwQnIe4sYdV4lzq1g1O6rItoEAA3VYGLKqrfOQQJz6FbXkFLVkiuN/jDY3K0D4C+WhucmvbijiQsNXdMY7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775895503; c=relaxed/simple;
	bh=FcszR3BL3B3xMGj9b9i1e/BHd9gXNOJDa1fMxhpnP80=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=C1Kv4gLUMkD+ElXKY7z8tdzNyibYx1ocEK7cQlIIhVPGFZb1aPw3RHu9kc83PucgHHkjjlxp4IEhZb8vXaa3Y7O79Xo96u9mZV2Gsdrexti7GkxrsJyNBohIJxyS6Z8HJH2py6vIpWEOu6gbDkVBnBmUlSeQSgrZC57mUNiniY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moehl.eu; spf=pass smtp.mailfrom=moehl.eu; dkim=pass (2048-bit key) header.d=moehl.eu header.i=maximilian@moehl.eu header.b=gko1z/gR; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moehl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moehl.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moehl.eu;
	s=s1-ionos; t=1775895489; x=1776500289; i=maximilian@moehl.eu;
	bh=MXd/K3xF2nv/iPhX8FUzPn8vlb1SxUZjLxkQjI8A6jo=;
	h=X-UI-Sender-Class:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=gko1z/gR0VeMV6voVl77uNdyiKM7u02+hp66xv4gwuFUpMSqIdhy63XGhcWucyvT
	 VKa0RUcpTvPFz+5E2pKHzy2QfGRVQzp0eXS8bZJENbNqJqxynfmhhIEqSWM0NPf5G
	 LMSPncniZQDyQV5W5fbs55NghGeCCU70R/xfE5esL/pE3xc7ESy27UjHQvR4v3K6d
	 EdcPap7f7kJx1NQ4BLwgilEzBdb0+WIlhRHcPqq6YbzxzJJBXEoJp/H0tszJmQWYh
	 hPrlnNKCck1r89u0dHDuhAzCrZPAggYx9DhNMI+c9Ht17S4ttNOFLjQDGqKcaCz6e
	 M1AZCuiM9bm8Burw9w==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue011
 [212.227.15.136]) with ESMTPSA (Nemesis) id 1MQusJ-1vqO9u2li3-00MATu; Sat, 11
 Apr 2026 10:18:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Apr 2026 10:18:07 +0200
Message-Id: <DHQ6ESFTW2YO.2HOPJZ5CY05U1@moehl.eu>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/ipv6: repeat route lookup with saddr set for ECMP
From: "Maximilian Moehl" <maximilian@moehl.eu>
To: "Maximilian Moehl" <maximilian@moehl.eu>, "Paolo Abeni"
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, "David Ahern"
 <dsahern@kernel.org>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Simon Horman" <horms@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260329091201.63646-1-maximilian@moehl.eu>
 <f73c3cf9-18e9-4109-b173-d6000cb0cf88@redhat.com>
 <DHGZBEMZ25SW.3LE7U694ND0L0@moehl.eu>
In-Reply-To: <DHGZBEMZ25SW.3LE7U694ND0L0@moehl.eu>
X-Provags-ID: V03:K1:y0Rh/KvpDXOhorrUh+A2p+0tDcG5CzyvA298rayd7gfo+mcDXD7
 MoYnVvnR6HhWDQK7BygrIqUEhiZBguJyCDovnfd84zUkvA6um14nrNx0zdbLJ3tHK9MEZTp
 jD0Q5lnrYGX89V1ORthYCbVHygdawjF7FdJJLMpK7Qxxx8VasXcEvAk/8XRIodKowUhKLaZ
 IlPu6g25WrZFSUYo09oQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0EdlwFg+UKA=;Ru/+DxRNyJEvZk86NUHNVpwTVrO
 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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[moehl.eu,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[moehl.eu:s=s1-ionos];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277681-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[moehl.eu:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maximilian@moehl.eu,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fib_tests.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB7233DEF37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Mar 31, 2026 at 2:50 PM CEST, Maximilian Moehl wrote:
> On Mon Mar 30, 2026 at 9:56 AM CEST, Paolo Abeni wrote:
>> On 3/29/26 11:12 AM, Maximilian Moehl wrote:
>>> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
>>> index 8e2a6b28cea7..465fce51d017 100644
>>> --- a/net/ipv6/ip6_output.c
>>> +++ b/net/ipv6/ip6_output.c
>>> @@ -1148,6 +1148,18 @@ static int ip6_dst_lookup_tail(struct net *net, =
const struct sock *sk,
>>>  			*dst =3D NULL;
>>>  		}
>>> =20
>>> +		/* If ECMP was involved the initial hash was calculted
>>> +		 * with saddr=3D:: which can result in instability
>>> +		 * when it is later re-calculated with the selected
>>> +		 * saddr. Lookup the route again with the chosen
>>> +		 * saddr to get a stable result.
>>> +		 */
>>> +		if (fl6->mp_hash) {
>>> +			fl6->mp_hash =3D 0;
>>> +			dst_release(*dst);
>>> +			*dst =3D NULL;
>>> +		}
>>> +
>>>  		if (fl6->flowi6_oif)
>>>  			flags |=3D RT6_LOOKUP_F_IFACE;
>>>  	}
>>
>> This apparently breaks ipv6 fib tests (fib_tests.sh):
>>
>> # IPv6 multipath load balance test
>> #      TEST: IPv6 multipath loadbalance                          [FAIL]
>>
>> see
>> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI=
-style
>> on how to reproduce the tests.
>>
>> Also this would deserve additional testcases.
>
> Thank you for the pointer, I will look into the tests.

I've investigated the test failure. The logic I introduced causes the
packet to leave interface 1 with the address of interface 3 and is
therefore not picked up by the TC counter causing the test failure.
IPv4 does not have this issue, neither does it have the issue I'm
trying to fix for IPv6.

>> Without diving much inside the code I have the feeling this change is
>> plugged into the wrong place: multipath selection logic should be
>> encapsulated by fib6_select_path().

I further looked into how IPv4 prevents this issue from occurring.
Initially I thought it was because it does more than one route lookup,
but if I got it right now, it's because of the scoring logic in
fib_select_multipath. It adds one point for a matching hash bucket and
two points for a matching source address. After initially selecting an
outgoing interface, and with that a source address, the flow stays
bound to the initially selected interface, no matter what the hash is
(unless there's a second interface with the same address where the
hash matches, but in that case switching interfaces is probably
fine?).

I will prepare a new patch that addresses this difference so that IPv6
also prefers the outgoing interface with a matching source address
over the hash bucket it would select otherwise.

--
Max

