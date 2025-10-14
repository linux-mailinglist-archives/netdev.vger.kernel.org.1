Return-Path: <netdev+bounces-229107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A812DBD83AD
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43056425D19
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3863030FC28;
	Tue, 14 Oct 2025 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efmvhSkD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1372C305E00
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431320; cv=none; b=ZjOBcLeAaZGrvtazHCkzcmCFW9jqdJqFx0/ts9cFNLRYWZ9RFWGLdPU2Vu1Fi5AN88GpQGvCU9w2lqGkcqvuNlTSw7grNtOdbHbW3pyFOPWLT9pb2G7XoULISM2mLwOIQHh2LJPA52yjcpk67iiEGQNloAqfCCXrVnqMDIZUQzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431320; c=relaxed/simple;
	bh=nlpGDMe6o7pi8ZnueCZPCmlCM43jnCjNlheYWarkCUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSyGplEw7qHhc8QuVR3epbvhFnd8ZeTf33Mm9bnWTsZ5SWyVtLNZ2MPwJjbKOGbJtyQnszgQuCbTM/Ilu3pKdC4WGxk41QW4nek6gsvEcykB8++NskP2QpFgEYoqAq9eovkbOkv+vxyYF8jNJcJ+xDyJDySLM5KsUGJvT3io7do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efmvhSkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B230EC4CEE7;
	Tue, 14 Oct 2025 08:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760431319;
	bh=nlpGDMe6o7pi8ZnueCZPCmlCM43jnCjNlheYWarkCUY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=efmvhSkDrII9E9e33qpaN0ACT0uQvw0dPbAAyxZzRO43s/GAwyfwh5qfsVyGYgL1E
	 ZsrR0QeMfCIvrQBReiHdQGjMGnB8+Oa4C/O0Fodti45pie0hgEU6VRnN6a4mWCV3Ga
	 kHweCpLz5FI+3Arm027VlPyp/9K+ydEzMgRaRJUr5DNiPLFZLhxj+KUF/S+sRsl7dA
	 iSTM72ORfdBQswxTiXOgds6EyaKwPJHkRmHNzNySUfN+ZOXkAahVxaHEpVCz48bAR6
	 Vp14CJDQe43fKJqcYf0kJG/3tqcjJi7AMD+K4EHdRYxc305rHwlwngYJ8HGNqfYxZL
	 1LaaMrDbRin3A==
Message-ID: <628aec1c-a989-4806-b3f4-d109d15b3dc4@kernel.org>
Date: Tue, 14 Oct 2025 10:41:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v8 1/3] net: bonding: add broadcast_neighbor option for
 802.3ad
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Zengbing Tu <tuzengbing@didiglobal.com>
References: <cover.1751031306.git.tonghao@bamaicloud.com>
 <84d0a044514157bb856a10b6d03a1028c4883561.1751031306.git.tonghao@bamaicloud.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <84d0a044514157bb856a10b6d03a1028c4883561.1751031306.git.tonghao@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27. 06. 25, 15:49, Tonghao Zhang wrote:
> Stacking technology is a type of technology used to expand ports on
> Ethernet switches. It is widely used as a common access method in
> large-scale Internet data center architectures. Years of practice
> have proved that stacking technology has advantages and disadvantages
> in high-reliability network architecture scenarios. For instance,
> in stacking networking arch, conventional switch system upgrades
> require multiple stacked devices to restart at the same time.
> Therefore, it is inevitable that the business will be interrupted
> for a while. It is for this reason that "no-stacking" in data centers
> has become a trend. Additionally, when the stacking link connecting
> the switches fails or is abnormal, the stack will split. Although it is
> not common, it still happens in actual operation. The problem is that
> after the split, it is equivalent to two switches with the same
> configuration appearing in the network, causing network configuration
> conflicts and ultimately interrupting the services carried by the
> stacking system.
> 
> To improve network stability, "non-stacking" solutions have been
> increasingly adopted, particularly by public cloud providers and
> tech companies like Alibaba, Tencent, and Didi. "non-stacking" is
> a method of mimicing switch stacking that convinces a LACP peer,
> bonding in this case, connected to a set of "non-stacked" switches
> that all of its ports are connected to a single switch
> (i.e., LACP aggregator), as if those switches were stacked. This
> enables the LACP peer's ports to aggregate together, and requires
> (a) special switch configuration, described in the linked article,
> and (b) modifications to the bonding 802.3ad (LACP) mode to send
> all ARP/ND packets across all ports of the active aggregator.
> 
> Note that, with multiple aggregators, the current broadcast mode
> logic will send only packets to the selected aggregator(s).
> 
>   +-----------+   +-----------+
>   |  switch1  |   |  switch2  |
>   +-----------+   +-----------+
>           ^           ^
>           |           |
>        +-----------------+
>        |   bond4 lacp    |
>        +-----------------+
>           |           |
>           | NIC1      | NIC2
>        +-----------------+
>        |     server      |
>        +-----------------+

Hi,

this breaks broadcast bonding in 6.17. Reverting these three (the two 
depend on this one) makes 6.17 work again:
2f9afffc399d net: bonding: send peer notify when failure recovery
3d98ee52659c net: bonding: add broadcast_neighbor netlink option
ce7a381697cb net: bonding: add broadcast_neighbor option for 802.3ad

This was reported downstream as an error in our openQA:
https://bugzilla.suse.com/show_bug.cgi?id=1250894

I bisected using this in qemu:
systemctl stop network
ip link del bond0 || true
ip link set dev eth0 down
ip addr flush eth0
ip link add bond0 type bond mode broadcast
ip link set dev eth0 master bond0
ip addr add 10.0.2.15/24 dev bond0
ip link set bond0 up
sleep 1
exec nmap -sS 10.0.2.2/32

Any ideas?

> - https://www.ruijie.com/fr-fr/support/tech-gallery/de-stack-data-center-network-architecture/
> 
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
> ---

-- 
js
suse labs


