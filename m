Return-Path: <netdev+bounces-229462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15264BDC9A7
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB46C3C82B9
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 05:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F5F303A0D;
	Wed, 15 Oct 2025 05:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/AWC1H2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBC530276F
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 05:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760506286; cv=none; b=ozClGzleziy4Ba472XIUd84Yw3yNydQAewCk+7JO6fQQVqJsCKmGyMCeCCU0+pJnR0Wmg7w1wxCtn5Sk6npNew+cSQ+TDW8C7Sbkf6I2K4b6S4xRsYQLm6zoRZRWzSRHCyE8KjrPnoYnxNk3voR+mXBwjdoCtnWFE9qQzYp8eEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760506286; c=relaxed/simple;
	bh=DQGGdRT5iDHmpTPuJCTlPwRQ/bmRn+sn8IcmyUf/ppY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGn/agDBOzgUF0k1lDg633sUdtHmY+Mz8TymN8iqcoTDVgrv2bgM+YAr7nh0JVDVz31tBh0csyUw7AMcfmlDyDqSV2TfHWfS5bmPOaEUaLP8mNJc5LX+pQj0j4o3SCTC3zasqLhAiAlmtZa5zbnkJeWQ3fyoErvPUFhLXV7QBu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/AWC1H2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1F5C4CEF8;
	Wed, 15 Oct 2025 05:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760506286;
	bh=DQGGdRT5iDHmpTPuJCTlPwRQ/bmRn+sn8IcmyUf/ppY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s/AWC1H2czEuZP7v23/KQskZHJInWC/lB5uFkgYdcgrV+umL9j+vy0HgCP4Od2kBx
	 LQcuTo5CMh7GDNPFRrJnJ5ZTbOTydcj0g0tvOopd+hXZ3mPAHouP4GPbDZBnC7Y5Wj
	 mW4GylPrO4nZcG2dJzRSK1+iY08sfZU07bvAkjwj3q6/V+IHwOc3qkg2l78im5p0Aj
	 6geuNEAtIV8Tn7dpIB/Mob+GJN4+SoPbhO3EH2Xpi67tteYhmGb9bJ1SifdwzM6y/e
	 f/mxeBp6HoWdFTDJZqatmd6yAVgxHiKDjYLuzFwqgtUqPB6JnwjPD0rCIwxURuX2ex
	 0gGGiJl2zAw3g==
Message-ID: <8f272ce1-3e13-4f93-9676-33b5435197f0@kernel.org>
Date: Wed, 15 Oct 2025 07:31:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v8 1/3] net: bonding: add broadcast_neighbor option for
 802.3ad
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Zengbing Tu <tuzengbing@didiglobal.com>
References: <cover.1751031306.git.tonghao@bamaicloud.com>
 <84d0a044514157bb856a10b6d03a1028c4883561.1751031306.git.tonghao@bamaicloud.com>
 <a97e6e1e-81bc-4a79-8352-9e4794b0d2ca@kernel.org>
 <1E373854-9996-49E6-8609-194CEAFA29ED@bamaicloud.com>
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
In-Reply-To: <1E373854-9996-49E6-8609-194CEAFA29ED@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14. 10. 25, 14:52, Tonghao Zhang wrote:
>> On Oct 14, 2025, at 17:12, Jiri Slaby <jirislaby@kernel.org> wrote:
>> On 27. 06. 25, 15:49, Tonghao Zhang wrote:
>> this breaks broadcast bonding in 6.17. Reverting these three (the two depend on this one) makes 6.17 work again:
>> 2f9afffc399d net: bonding: send peer notify when failure recovery
>> 3d98ee52659c net: bonding: add broadcast_neighbor netlink option
>> ce7a381697cb net: bonding: add broadcast_neighbor option for 802.3ad
>>
>> This was reported downstream as an error in our openQA:
>> https://bugzilla.suse.com/show_bug.cgi?id=1250894
>>
>> I bisected using this in qemu:
>> systemctl stop network
>> ip link del bond0 || true
>> ip link set dev eth0 down
>> ip addr flush eth0
>> ip link add bond0 type bond mode broadcast
>> ip link set dev eth0 master bond0
>> ip addr add 10.0.2.15/24 dev bond0
>> ip link set bond0 up
>> sleep 1
>> exec nmap -sS 10.0.2.2/32
>>
>> Any ideas?
>> ...
>>> --- a/drivers/net/bonding/bond_main.c
>>> +++ b/drivers/net/bonding/bond_main.c
>> ...
>>> @@ -5329,17 +5369,27 @@ static netdev_tx_t bond_3ad_xor_xmit(struct sk_buff *skb,
>>>    return bond_tx_drop(dev, skb);
>>>   }
>>>   -/* in broadcast mode, we send everything to all usable interfaces. */
>>> +/* in broadcast mode, we send everything to all or usable slave interfaces.
>>> + * under rcu_read_lock when this function is called.
>>> + */
>>>   static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
>>> -       struct net_device *bond_dev)
>>> +       struct net_device *bond_dev,
>>> +       bool all_slaves)
>>>   {
>>>    struct bonding *bond = netdev_priv(bond_dev);
>>> - struct slave *slave = NULL;
>>> - struct list_head *iter;
>>> + struct bond_up_slave *slaves;
>>>    bool xmit_suc = false;
>>>    bool skb_used = false;
>>> + int slaves_count, i;
>>>   - bond_for_each_slave_rcu(bond, slave, iter) {
>>> + if (all_slaves)
>>> + slaves = rcu_dereference(bond->all_slaves);
>>> + else
>>> + slaves = rcu_dereference(bond->usable_slaves);
>>> +
>>> + slaves_count = slaves ? READ_ONCE(slaves->count) : 0;
>>
>> OK, slaves_count is now 0 (slaves and bond->all_slaves are NULL), but bond_for_each_slave_rcu() used to yield 1 iface.
>>
>> Well, bond_update_slave_arr() is not called for broadcast AFAICS.
> Thank you for pointing out this issue. We don't need to revert the patch. can you test if the following patch is useful to you. I will add test cases later.
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index a8034a561011..c950e1e7f284 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2384,7 +2384,8 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>                  unblock_netpoll_tx();
>          }
> 
> -       if (bond_mode_can_use_xmit_hash(bond))
> +       if (bond_mode_can_use_xmit_hash(bond) ||
> +           BOND_MODE(bond) == BOND_MODE_BROADCAST)
>                  bond_update_slave_arr(bond, NULL);
> 
>          if (!slave_dev->netdev_ops->ndo_bpf ||
> @@ -2560,7 +2561,8 @@ static int __bond_release_one(struct net_device *bond_dev,
> 
>          bond_upper_dev_unlink(bond, slave);
> 
> -       if (bond_mode_can_use_xmit_hash(bond))
> +       if (bond_mode_can_use_xmit_hash(bond) ||
> +           BOND_MODE(bond) == BOND_MODE_BROADCAST)
>                  bond_update_slave_arr(bond, slave);

This indeed works. What about the other two call locations of 
bond_update_slave_arr()?

thanks,
-- 
js
suse labs

