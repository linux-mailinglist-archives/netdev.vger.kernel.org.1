Return-Path: <netdev+bounces-238622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 534CDC5C220
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 10:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D081A3526A4
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 09:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E972F5A1C;
	Fri, 14 Nov 2025 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q0ki1xu8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TRLV+IzM"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669C72C326F
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763110875; cv=none; b=nYEfUDnYthEitHTjMTs21QcU8m3A5jPfPvXEsY6fX9jbO/3CsnNnxkMJEt14p7utFRJh4/ZcqGz3DZxPFNBLA5Ki2sjxw7mxzTBhtha2EtVvtuartkFnHgQr3Efbl+86e6TbdjEgd7wpaKan5fTh79B9DxPiWuWw4oRRI7UmOHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763110875; c=relaxed/simple;
	bh=DoDXFlScMECiS04We8iUPbkVNZYch+bMQaUcihizUFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z6YIRP4fV4MTOgBzU3zLFs2jq0wIsQbISOfQvGEVLWvmUcY5LqZWWtsuPVpYN/SIyWAncA+rQHvCjnfWzvUaDFWgi4KGOT8MYPC+Nrdm7Uc1kwXibtvKBUs4PlRdpk6Ye2Yeduq2VWg0GKKAXj1hnAakkXIQGw/2wYgY21h7VAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q0ki1xu8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TRLV+IzM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763110867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b6BFu9iGbc3F1Rs9o+4VZeJk+hymSJJUpPT9WBy4yNk=;
	b=Q0ki1xu8ZKMdjHH1mFDVyg1p743usdI53LC54c69vslC4DNgFjpk8aioLqFX0z5USApqJU
	cgFmWWxGPjeq3rMTBolwjhSOlXEB1S+XcQBmEOT0h+9lemY2dzlHH4nUwpOPSduQWVzxmC
	BS/ujnPeVWcjHDR4jrhtqtExc4GqHm3iAw4JyLvfTLKGG7W8bniOPlq1nqDeYOhS0tBbKS
	kHR59i8DC27BGDrSrfePLTwAKwtGghcc1kHxW68hqj6dwFuXjygy9/n0hmyPoIBmgjURiY
	9le8JecTCMXlJ2iB0i2nOErcG17qQXyIiLXd41IgZSLI4g0jGP/6Gsii2BDxZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763110867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b6BFu9iGbc3F1Rs9o+4VZeJk+hymSJJUpPT9WBy4yNk=;
	b=TRLV+IzMfi5V+ejNFKmj1Ca1ICX2VAnz/oZAjQAWPNVekJbvSnLxleCo0drb9cMrNUKGxy
	c/pgacw5k5dkmQCw==
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next] igc: Restore default Qbv schedule when
 changing channels
In-Reply-To: <871pm126fv.fsf@intel.com>
References: <20251107-igc_mqprio_channels-v1-1-42415562d0f8@linutronix.de>
 <87ldkblyhd.fsf@intel.com> <87bjl6l3j5.fsf@jax.kurt.home>
 <871pm126fv.fsf@intel.com>
Date: Fri, 14 Nov 2025 10:01:04 +0100
Message-ID: <874iqxng33.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Thu Nov 13 2025, Vinicius Costa Gomes wrote:
> Kurt Kanzenbach <kurt@linutronix.de> writes:
>
>> On Wed Nov 12 2025, Vinicius Costa Gomes wrote:
>>> Hi,
>>>
>>> Kurt Kanzenbach <kurt@linutronix.de> writes:
>>>
>>>> The MQPRIO (and ETF) offload utilizes the TSN Tx mode. This mode is always
>>>> coupled to Qbv. Therefore, the driver sets a default Qbv schedule of all gates
>>>> opened and a cycle time of 1s. This schedule is set during probe.
>>>>
>>>> However, the following sequence of events lead to Tx issues:
>>>>
>>>>  - Boot a dual core system
>>>>    probe():
>>>>      igc_tsn_clear_schedule():
>>>>        -> Default Schedule is set
>>>>        Note: At this point the driver has allocated two Tx/Rx queues, because
>>>>        there are only two CPU(s).
>>>>
>>>>  - ethtool -L enp3s0 combined 4
>>>>    igc_ethtool_set_channels():
>>>>      igc_reinit_queues()
>>>>        -> Default schedule is gone, per Tx ring start and end time are zero
>>>>
>>>>   - tc qdisc replace dev enp3s0 handle 100 parent root mqprio \
>>>>       num_tc 4 map 3 3 2 2 0 1 1 1 3 3 3 3 3 3 3 3 \
>>>>       queues 1@0 1@1 1@2 1@3 hw 1
>>>>     igc_tsn_offload_apply():
>>>>       igc_tsn_enable_offload():
>>>>         -> Writes zeros to IGC_STQT(i) and IGC_ENDQT(i) -> Boom
>>>>
>>>> Therefore, restore the default Qbv schedule after changing the amount of
>>>> channels.
>>>>
>>>
>>> Couple of questions:
>>>  - Would it make sense to mark this patch as a fix?
>>
>> This only happens if a user uses ETF or MQPRIO and a dual/single core
>> system. So I didn't see the need to mark it as a fix.
>>
>
> I still think this is fix material. People can always run stuff in VMs,
> and it makes it easier to have single/dual core systems.

Fair enough.

>
>>>
>>>  - What would happen if the user added a Qbv schedule (not the default
>>>    one) and then changed the number of queues? My concern is that 'tc
>>>    qdisc' would show the custom user schedule and the hardware would be
>>>    "running" the default schedule, this inconsistency is not ideal. In
>>>    any case, it would be a separate patch.
>>
>> Excellent point. Honestly I'm not sure what to expect when changing the
>> number of queues after a user Qbv schedule is added. For MQPRIO we added
>> a restriction [1] especially for that case. I'm leaning towards the same
>> solution here. What do you think?
>
> Sounds great. Avoiding getting into inconsistent states is better than
> trying to fix it later.

Jup. I'll wait a bit for further comments and then send a v2 with your
and Aleksandr's suggestions addressed.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmkW79ATHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzggciD/9ay/U71+nZu7e8ppiVKWfShE9SiLXZ
p8gYFYumDgZFus8HUBXdIo64Ai6dR12utE3X6EDgMZMh8AWfrieyHCipZKYw0Pqu
ZTq0vo0/shVGT1CUPxH8dv6KMAUcwpdkyI1/IvC+A4aP8TkcKHurwmGg2NRmX0TY
PHRU+stgF6UEw9vvTudxS3ITPctNGuk76EZk1HdnJFgk5SAzkQThlqoW0SjZnHkE
xIPiP2KNEy2cFUIlZpJkLUXfmfqT+Fm2vKl1pZo+lXe9FILFWTLeBgufG6vzMGsQ
ZUQTfoD3FyC0/WrtgohLZxqwkqWOmu9loWNaIHwby1yle+GFi0Z+76OgmnXgsSI+
sT6WKX82V9ytqSBzJzxEFKZYS6Nis0elxX6dY0mPFWq4PaiL/8T9mlG/SjDecNUx
dUlA6TQSLE7u4VpVfU25A1/7XcJlXp/UemUVjpRFCLQgfO3t6xHwyyd/T/4sQsyD
cO4+oyHf9C2ctUumx5W4FjRlgvr5Dd1WJKDaGq0hoHN6LXCLMgiIEKKapKl9ViW3
lhgKV+IXH5vmlFg8o5KyIp64Z+1ClB+ATDgBLTN9oiA+nQtQFVR0YzYUAyJBiGUs
aSRo3Ol2YRWiSnfmGff38fA5TOiYc955AwvKIsuGQsGh+qhMBLLim0/nLzCcngyX
eEC/CCpEuVgJQw==
=wmrl
-----END PGP SIGNATURE-----
--=-=-=--

