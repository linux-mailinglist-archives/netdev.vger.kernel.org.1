Return-Path: <netdev+bounces-189787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC50AB3B6F
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CA037AC55D
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC321E3772;
	Mon, 12 May 2025 14:56:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F08E134D4
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747061816; cv=none; b=Av+KW/6u/NXNvdStWik2JGA4O43CJfYmjyxZ9Mmp0qBUV+BNXHyXlnoIjW1BtfzykmFcXuyuAuhXtyYtfeQ44vZvZS+ifRnmQXV4+0vUaq/4+I+7AfzsHN5ptkJD7qdbU7p/6Ew2FsgrB2PdS/PdbPAUUqfi7S6zQPzjyKCa7Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747061816; c=relaxed/simple;
	bh=sodwCNvtCo01UEK6fU16HPSfsFG1qjvU3Yr64oOPusw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DaPA7CG5t7MU7ypLaX4rahmCthxYudfYxc9BegydOnc0IYi+t66+5cuEtWapotRZ3iNHNH0evA+ugaxvVmz9RUE34tv5I9SAMpN5x3wQ95tTEB84XoOPSC6PMKxbnhaHGW7nLbZaUD+H16vBINav6s2tixULBz4blIAeOarAOj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz8t1747061715t84fd07df
X-QQ-Originating-IP: mrWTICkw65KWThcxP1q7xDZ/EOK3ta2sZHK5yAk5cMM=
Received: from smtpclient.apple ( [111.201.145.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 12 May 2025 22:55:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8976486208275308326
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH net-next 1/4] net: bonding: add broadcast_neighbor option
 for 802.3ad
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <1278464.1747041594@vermin>
Date: Mon, 12 May 2025 22:55:02 +0800
Cc: Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Content-Transfer-Encoding: quoted-printable
Message-Id: <638B6CB1-BCC6-4887-96F2-013196DA5138@bamaicloud.com>
References: <20250510044504.52618-1-tonghao@bamaicloud.com>
 <20250510044504.52618-2-tonghao@bamaicloud.com> <1133230.1746881077@vermin>
 <CE4DB782-91EB-4DBD-9C26-CA4C4612D58C@bamaicloud.com>
 <ea87b2d2-9b17-4f16-9e40-fe7212f2788d@lunn.ch>
 <B43CC0DC-286B-44FF-8FA8-1B1BC0C990BF@bamaicloud.com>
 <1278464.1747041594@vermin>
To: Jay Vosburgh <jv@jvosburgh.net>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MC+kTSDGUQEXWELdWHsFOi5F5K3hWtyXGcIYHnk/zDKj/YB77PmipsCP
	1NB3YdX8YT4hDFI/rn8PHbeJCa5NOO8OxJn5DVLNUMnMcnLekLotma5T6ZeS1ZOv6cJUmHg
	4416mWGgOPaSfn0TrqlbJPP1mT3xMzfyKxaN8/bUqoR0mwXGTtgacpCFpSg9+EjTbdzOP0L
	CmawdnyFWIxHUdK0ctN6hfp44i3BUgbpiEHCVMzAZZTAkVGT9nrei7XJdIAIyvy0A/xIIC5
	8BwSXhbyWEuYGRZBqAs/z9R7eUIb7bMbL1VKY86rPHiljmi5c7BdXsSczHK1+oCCpk3uos7
	Ua1YFDqmoIsx9wfzp4uKdJcCpAtdjtvCI0Iy/UYgQ0KWFYXq9Hcm+/vLO/+WmzRqFBYqqpW
	lLw8Xm0vQZ41EdXFPGuB2TaVf91gJJhk+zTEa1bzINLbtjrWwzBnOesWuaDrVxtMGufCLXs
	IpUfN/ECzp1lbTNK/ZR9cWAxlb//L2tP1ELVRvsVMjggemOOljau9QvBigPQcAE/YDo8CpJ
	brCyZsr5SqDYr06x8brdRJ9Mswzdt1pTjDtJrpGTvNfew5cM+2hr5rNEIExhlVPNM1dbNwj
	w0z+l6ZfmuW1NMKDEl9nhDNUcmwcP5bEPDsiSrkCahXkwmUEhrm/MPOM7bQag+YQvByXsYR
	A5N0txgvFjcpXQ2n5yWr2MYsVlfg7VSddYxuLCkxkXE7p91Ix/Cn3o2jVkuI9GkWBH35IWr
	P3No4AlWnJ4rRuvOr3pbPLE5vTqDtTKAXjyBPFjYI1UZZfM589nqKowDVT6w3y963e2o61j
	fEx7ph1uVgDoGjiWNbWh8p9nA9/5PD6DaawAwdRY1TvfAKLOq+MFtpplEI+X3cgGcUfkHkg
	zpsw6Pr8VXLNBjsc0Qk4Tg4Y/z/36FT3mWakpBvkk0kjV+GkDnGoUUew3knqn24Ahw+WwmJ
	AW3/NSU1zncyKX00yYeM5zb03YtoQLljN6k4=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B45=E6=9C=8812=E6=97=A5 17:19=EF=BC=8CJay Vosburgh =
<jv@jvosburgh.net> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Tonghao Zhang <tonghao@bamaicloud.com> wrote:
>=20
>>> 2025=E5=B9=B45=E6=9C=8811=E6=97=A5 =E4=B8=8B=E5=8D=8811:53=EF=BC=8CAnd=
rew Lunn <andrew@lunn.ch> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>>> static inline bool bond_should_broadcast_neighbor(struct bonding =
*bond,
>>>>                                                 struct sk_buff =
*skb)
>>>> {
>>>>       if (!bond->params.broadcast_neighbor ||
>>>>           BOND_MODE(bond) !=3D BOND_MODE_8023AD)
>>>>               return false;
>>>=20
>>> I think you missed the point. You have added these two tests to =
every
>>> packet on the fast path. And it is very likely to return false. Is
>>> bond.params.broadcast_neighbor likely to be in the cache? A cache =
miss
>>> is expensive. Is bond.params.mode also likely to be in cache? You
>>> placed broadcast_neighbor at the end of params, so it is unlikely to
>>> be in the same cache line as bond.params.mode. So two cache misses.
>>>=20
>>> What Jay would like is that the cost on the fast path is ~0 for when
>>> this feature is not in use. Jump labels can achieve this. It inserts
>>> either a NOP or a jump instruction, which costs nearly nothing, and
>>> then uses self modifying code to swap between a NOP or a jump. You =
can
>>> keep a global view of is any bond is using this new mode? If no, =
this
>> No, no mode uses jump labels instead of bond.params checking.
>=20
> The suggestion here is to use a jump label (static branch) to
> essentially eliminate the overhead of the options test for the common =
case
> for most users, which is with broadcast_neighbor disabled.
>=20
> As described below, the static branch would be tracked
> separately from the per-bond option.
>=20
>>> test is eliminated. If yes, you do the test.
>> I test the lacp mode with broadcast_neighbor enabled, there is no =
performance drop. This patch has been running in our production =
environment for a long time. We only use this option in lacp mode, for =
performance, the code can be modified as follows:
>=20
> How did you test this?  The performance under discussion here is
> that branches in the packet transmit path can affect overall packet
> transmission rates at very high rates (think in terms of small packet
> rates at 40 Gb/sec and higher).  Bonding already has a significant
> number of TX path branches, and we should be working to reduce that
> number, not increase it.
>=20
>> diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
>> index ce31445e85b6..8743bf007b7e 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -5330,11 +5330,12 @@ static struct slave =
*bond_xdp_xmit_3ad_xor_slave_get(struct bonding *bond,
>>       return slaves->arr[hash % count];
>> }
>>=20
>> -static inline bool bond_should_broadcast_neighbor(struct bonding =
*bond,
>> -                                                 struct sk_buff =
*skb)
>> +static inline bool bond_should_broadcast_neighbor(struct sk_buff =
*skb,
>> +                                                 struct net_device =
*dev)
>> {
>> -       if (!bond->params.broadcast_neighbor ||
>> -           BOND_MODE(bond) !=3D BOND_MODE_8023AD)
>> +       struct bonding *bond =3D netdev_priv(dev);
>> +
>> +       if (!bond->params.broadcast_neighbor)
>>               return false;
>=20
> Using a static branch, the above would be preceded by something
> like:
>=20
> if (!static_branch_unlikely(&bond_bcast_neigh_enabled))
> return false;
>=20
> With additional logic in the options code that enables and
> disables broadcast_neighbor that will increment or decrement (via
> static_branch_inc / _dec) bond_bcast_neigh_enabled as the
> broadcast_neighbor option is enabled or disabled.  The static branch
> becomes a fast way to ask "is any bond in the system using
> broadcast_neighbor" at very low cost.
>=20
> As Andrew helpfully pointed out, netfilter makes extensive use
> of these; I'd suggest looking at the usage of something like
> nft_trace_enabled as an example of what we're referring to.
I got it, thanks Jay, and Andrew.
>=20
> -J
>=20
>>       if (skb->protocol =3D=3D htons(ETH_P_ARP))
>> @@ -5408,9 +5409,6 @@ static netdev_tx_t bond_3ad_xor_xmit(struct =
sk_buff *skb,
>>       struct bond_up_slave *slaves;
>>       struct slave *slave;
>>=20
>> -       if (bond_should_broadcast_neighbor(bond, skb))
>> -               return bond_xmit_broadcast(skb, dev);
>> -
>>       slaves =3D rcu_dereference(bond->usable_slaves);
>>       slave =3D bond_xmit_3ad_xor_slave_get(bond, skb, slaves);
>>       if (likely(slave))
>> @@ -5625,6 +5623,9 @@ static netdev_tx_t __bond_start_xmit(struct =
sk_buff *skb, struct net_device *dev
>>       case BOND_MODE_ACTIVEBACKUP:
>>               return bond_xmit_activebackup(skb, dev);
>>       case BOND_MODE_8023AD:
>> +               if (bond_should_broadcast_neighbor(skb, dev))
>> +                       return bond_xmit_broadcast(skb, dev);
>> +               fallthrough;
>>       case BOND_MODE_XOR:
>>               return bond_3ad_xor_xmit(skb, dev);
>>       case BOND_MODE_BROADCAST:
>>>=20
>>> Andrew
>=20
> ---
> -Jay Vosburgh, jv@jvosburgh.net



