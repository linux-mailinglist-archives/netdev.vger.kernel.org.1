Return-Path: <netdev+bounces-190353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4116AAB66B6
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 11:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C953716D5FE
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087DF13A86C;
	Wed, 14 May 2025 09:01:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64D74B5AE
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747213306; cv=none; b=egIoaJHF/7tutv+NFjfnoYHBYMgge+zgZARfGS7hkQvCof8z8MW1Is15Px2xyQVTTu1PiVodzw5v+41+MtBoJCpTJTX/zTo0BltSghlPPkQYr9bqvlohyYIHc0U+jlM5/xoJRO7PKwowI+QNyjDOKsjimmlU/1/xJA3u1NC5qwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747213306; c=relaxed/simple;
	bh=PbQTPrGHic+XnYHkh2+A+y9XvFFaZVFpiEA2wtX+/f8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nw/rYGu5wLkXgsZEjORM651bGcDDWC677SjykRqrlKz9IsuZVmxhd01qtMLwEDgK8vl3oMq3zkXS+AvVRXKRLgf6qNqB6ykeGGMsNqa71yJK99o4XHLD7rBVUHUei+MxxIbVwOyeGMcudU/czvDLY4YOYz4XooFrElvoBsmUU/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz18t1747213222t5b62ab22
X-QQ-Originating-IP: 04jhGxnxtxhhlxmtU4kzSTPN+OgM1B2yAudxJujDrh4=
Received: from smtpclient.apple ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 14 May 2025 17:00:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4466767369333236199
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH net-next v3 1/4] net: bonding: add broadcast_neighbor
 option for 802.3ad
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <e1bfca22-0489-48a3-8927-c57c23d8f15c@blackwall.org>
Date: Wed, 14 May 2025 17:00:09 +0800
Cc: netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Zengbing Tu <tuzengbing@didiglobal.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A3B54E67-319C-430F-A209-BC8E0C8981D2@bamaicloud.com>
References: <20250514071339.40803-1-tonghao@bamaicloud.com>
 <157A289E7BA00D9A+20250514071339.40803-2-tonghao@bamaicloud.com>
 <e1bfca22-0489-48a3-8927-c57c23d8f15c@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MWLCkAjnYYm5NNoCrg3m0mssNwaJSs/JHu28dpE5DxKTPz5DaIiGxeXt
	LW00+FscB9XrLbdSM1mPTUJkdrAPKHS1Y2p9BRcVXc4eycuOo4HXQgM6QFgh/7Xr33FxeqO
	BGFdy2UG7Ounaxfo0bEGmF3LcBX7bVkx/uc7jZlZzMQA1mB/dIZw/RQMc+ACHQQrcjinqnS
	Om4n+PCWyHXDPZ8ASuPURZEFMb03/yvXYBNY51TUdJepbr491t8b307x10KfKlayjt5BUnE
	3Ol9zMFR5YTjEOr4xa2dFrycWty7Q/8rKKbaITJSTSDPUgHKMKAUgFGONxbBIqwwaPSyX1e
	2UeWGV8maRZrwFdil0/10tfLGCPDkchY000cUYsvxxBHBgFuHWQO/jBFFuucIl+BKGeXAa5
	lEeGGey1KOOOUrIDJ8mitTzgFb6V94lwBLf/YMc5NhYTXKqOmHCXW4n1Z8o51+5dfjLRAFb
	b3bKKABUxuwh7iOEpOBWIWEQUX8ww79C2anuuZczlE+ygNqzCcASxSRHEigwkcpU/AaaZoV
	6yAP9f3HoGp2G7tADcFqn48XWp6AmubpPYbiv9G9u56uAMYYRPvWRniWhH6OMQ6D9Wqh14g
	YL75odudbxn034ircwcCm/VANE3hwfJ68SUEDZ8XGyhr2M49au+jXpFTCgxHOIYeoasaWX+
	lji/D/s01Jt8mvFviqRQbdteY0ZTt7UlWHwt7F0zO02QmHHXC7E75ls/Sp01ibD4vD9zk+c
	nsfxkH+botGZESNkyRLL5/wGHIwEC/OoTRqtA+DaqGGyHcWstThMDkexrdigKDFrW0Kc7fr
	D9x2RKPpqsEVVINlSWf0dDhlOscmsrqVYrwSWycNAMglxi+IDCi905q/HmDFm6U2+goOzQP
	TElDsjKM3X82dNGNDiY8fh+hgzMMiHpmJFAstBSXf0wqBD/Oc8OwVqgwXx0dk8Tcce13V45
	YidQBsAmZoY5O21qOSqLh8hnqSgWCppHAQt7PudfDJw9z1A9crBWARMJQsU0dXV29QFYgo9
	objRzbIlWnXOLkTaQW
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B45=E6=9C=8814=E6=97=A5 15:44=EF=BC=8CNikolay Aleksandrov =
<razor@blackwall.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 5/14/25 10:13, Tonghao Zhang wrote:
>> Stacking technology is a type of technology used to expand ports on
>> Ethernet switches. It is widely used as a common access method in
>> large-scale Internet data center architectures. Years of practice
>> have proved that stacking technology has advantages and disadvantages
>> in high-reliability network architecture scenarios. For instance,
>> in stacking networking arch, conventional switch system upgrades
>> require multiple stacked devices to restart at the same time.
>> Therefore, it is inevitable that the business will be interrupted
>> for a while. It is for this reason that "no-stacking" in data centers
>> has become a trend. Additionally, when the stacking link connecting
>> the switches fails or is abnormal, the stack will split. Although it =
is
>> not common, it still happens in actual operation. The problem is that
>> after the split, it is equivalent to two switches with the same =
configuration
>> appearing in the network, causing network configuration conflicts and
>> ultimately interrupting the services carried by the stacking system.
>>=20
>> To improve network stability, "non-stacking" solutions have been =
increasingly
>> adopted, particularly by public cloud providers and tech companies
>> like Alibaba, Tencent, and Didi. "non-stacking" is a method of =
mimicing switch
>> stacking that convinces a LACP peer, bonding in this case, connected =
to a set of
>> "non-stacked" switches that all of its ports are connected to a =
single
>> switch (i.e., LACP aggregator), as if those switches were stacked. =
This
>> enables the LACP peer's ports to aggregate together, and requires (a)
>> special switch configuration, described in the linked article, and =
(b)
>> modifications to the bonding 802.3ad (LACP) mode to send all ARP / ND
>> packets across all ports of the active aggregator.
>>=20
>>  -----------     -----------
>> |  switch1  |   |  switch2  |
>>  -----------     -----------
>>         ^           ^
>>         |           |
>>       -----------------
>>      |   bond4 lacp    |
>>       -----------------
>>         |           |
>>         | NIC1      | NIC2
>>       -----------------
>>      |     server      |
>>       -----------------
>>=20
>> - =
https://www.ruijie.com/fr-fr/support/tech-gallery/de-stack-data-center-net=
work-architecture/
>>=20
>> Cc: Jay Vosburgh <jv@jvosburgh.net>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Simon Horman <horms@kernel.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
>> ---
>> Documentation/networking/bonding.rst |  6 ++++
>> drivers/net/bonding/bond_main.c      | 41 =
++++++++++++++++++++++++++++
>> drivers/net/bonding/bond_options.c   | 35 ++++++++++++++++++++++++
>> include/net/bond_options.h           |  1 +
>> include/net/bonding.h                |  3 ++
>> 5 files changed, 86 insertions(+)
>>=20
>> diff --git a/Documentation/networking/bonding.rst =
b/Documentation/networking/bonding.rst> index a4c1291d2561..14f7593d888d =
100644
>> --- a/Documentation/networking/bonding.rst
>> +++ b/Documentation/networking/bonding.rst
>> @@ -562,6 +562,12 @@ lacp_rate
>>=20
>> The default is slow.
>>=20
>> +broadcast_neighbor
>> +
>> + Option specifying whether to broadcast ARP/ND packets to all
>> + active slaves.  This option has no effect in modes other than
>> + 802.3ad mode.  The default is off (0).
>> +
>> max_bonds
>>=20
>> Specifies the number of bonding devices to create for this
>> diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
>> index d05226484c64..db6a9c8db47c 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -212,6 +212,8 @@ atomic_t netpoll_block_tx =3D ATOMIC_INIT(0);
>>=20
>> unsigned int bond_net_id __read_mostly;
>>=20
>> +DEFINE_STATIC_KEY_FALSE(bond_bcast_neigh_enabled);
>> +
>> static const struct flow_dissector_key flow_keys_bonding_keys[] =3D {
>> {
>> .key_id =3D FLOW_DISSECTOR_KEY_CONTROL,
>> @@ -4461,6 +4463,9 @@ static int bond_open(struct net_device =
*bond_dev)
>>=20
>> bond_for_each_slave(bond, slave, iter)
>> dev_mc_add(slave->dev, lacpdu_mcast_addr);
>> +
>> + if (bond->params.broadcast_neighbor)
>> + static_branch_inc(&bond_bcast_neigh_enabled);
>=20
> So this gets increased only when the mode is 802.3ad, good, but...
>=20
>> }
>>=20
>> if (bond_mode_can_use_xmit_hash(bond))
>> @@ -4480,6 +4485,9 @@ static int bond_close(struct net_device =
*bond_dev)
>> bond_alb_deinitialize(bond);
>> bond->recv_probe =3D NULL;
>>=20
>> + if (bond->params.broadcast_neighbor)
>> + static_branch_dec(&bond_bcast_neigh_enabled);
>> +
>=20
> ... this gets decreased for every mode. That can result in an =
imbalance because you
> can set broadcast_neighbor in 3ad and later change the mode, then =
cycling the bond
> up/down would cause only the _dec to be called.
=E2=80=A6 change the mode, was not taken into consideration. Fix this =
next version.
>=20
>> if (bond_uses_primary(bond)) {
>> rcu_read_lock();
>> slave =3D rcu_dereference(bond->curr_active_slave);
>> @@ -5316,6 +5324,35 @@ static struct slave =
*bond_xdp_xmit_3ad_xor_slave_get(struct bonding *bond,
>> return slaves->arr[hash % count];
>> }
>>=20
>> +static bool bond_should_broadcast_neighbor(struct sk_buff *skb,
>> +    struct net_device *dev)
>> +{
>> + struct bonding *bond =3D netdev_priv(dev);
>> +
>> + if (!static_branch_unlikely(&bond_bcast_neigh_enabled))
>> + return false;
>> +
>> + if (!bond->params.broadcast_neighbor)
>> + return false;
>> +
>> + if (skb->protocol =3D=3D htons(ETH_P_ARP))
>> + return true;
>> +
>> + if (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
>> +     pskb_may_pull(skb,
>> +   sizeof(struct ipv6hdr) + sizeof(struct icmp6hdr))) {
>> + if (ipv6_hdr(skb)->nexthdr =3D=3D IPPROTO_ICMPV6) {
>> + struct icmp6hdr *icmph =3D icmp6_hdr(skb);
>> +
>> + if ((icmph->icmp6_type =3D=3D NDISC_NEIGHBOUR_SOLICITATION) ||
>> +     (icmph->icmp6_type =3D=3D NDISC_NEIGHBOUR_ADVERTISEMENT))
>> + return true;
>> + }
>> + }
>> +
>> + return false;
>> +}
>> +
>> /* Use this Xmit function for 3AD as well as XOR modes. The current
>>  * usable slave array is formed in the control path. The xmit =
function
>>  * just calculates hash and sends the packet out.
>> @@ -5583,6 +5620,9 @@ static netdev_tx_t __bond_start_xmit(struct =
sk_buff *skb, struct net_device *dev
>> case BOND_MODE_ACTIVEBACKUP:
>> return bond_xmit_activebackup(skb, dev);
>> case BOND_MODE_8023AD:
>> + if (bond_should_broadcast_neighbor(skb, dev))
>> + return bond_xmit_broadcast(skb, dev);
>> + fallthrough;
>> case BOND_MODE_XOR:
>> return bond_3ad_xor_xmit(skb, dev);
>> case BOND_MODE_BROADCAST:
>> @@ -6462,6 +6502,7 @@ static int __init bond_check_params(struct =
bond_params *params)
>> eth_zero_addr(params->ad_actor_system);
>> params->ad_user_port_key =3D ad_user_port_key;
>> params->coupled_control =3D 1;
>> + params->broadcast_neighbor =3D 0;
>> if (packets_per_slave > 0) {
>> params->reciprocal_packets_per_slave =3D
>> reciprocal_value(packets_per_slave);
>> diff --git a/drivers/net/bonding/bond_options.c =
b/drivers/net/bonding/bond_options.c
>> index 91893c29b899..7f0939337231 100644
>> --- a/drivers/net/bonding/bond_options.c
>> +++ b/drivers/net/bonding/bond_options.c
>> @@ -87,6 +87,8 @@ static int bond_option_missed_max_set(struct =
bonding *bond,
>>       const struct bond_opt_value *newval);
>> static int bond_option_coupled_control_set(struct bonding *bond,
>>    const struct bond_opt_value *newval);
>> +static int bond_option_broadcast_neigh_set(struct bonding *bond,
>> +    const struct bond_opt_value *newval);
>>=20
>> static const struct bond_opt_value bond_mode_tbl[] =3D {
>> { "balance-rr",    BOND_MODE_ROUNDROBIN,   BOND_VALFLAG_DEFAULT},
>> @@ -240,6 +242,12 @@ static const struct bond_opt_value =
bond_coupled_control_tbl[] =3D {
>> { NULL,  -1, 0},
>> };
>>=20
>> +static const struct bond_opt_value bond_broadcast_neigh_tbl[] =3D {
>> + { "off", 0, BOND_VALFLAG_DEFAULT},
>> + { "on",  1, 0},
>> + { NULL,  -1, 0}
>> +};
>> +
>> static const struct bond_option bond_opts[BOND_OPT_LAST] =3D {
>> [BOND_OPT_MODE] =3D {
>> .id =3D BOND_OPT_MODE,
>> @@ -513,6 +521,14 @@ static const struct bond_option =
bond_opts[BOND_OPT_LAST] =3D {
>> .flags =3D BOND_OPTFLAG_IFDOWN,
>> .values =3D bond_coupled_control_tbl,
>> .set =3D bond_option_coupled_control_set,
>> + },
>> + [BOND_OPT_BROADCAST_NEIGH] =3D {
>> + .id =3D BOND_OPT_BROADCAST_NEIGH,
>> + .name =3D "broadcast_neighbor",
>> + .desc =3D "Broadcast neighbor packets to all slaves",
>> + .unsuppmodes =3D BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
>> + .values =3D bond_broadcast_neigh_tbl,
>> + .set =3D bond_option_broadcast_neigh_set,
>> }
>> };
>>=20
>> @@ -1840,3 +1856,22 @@ static int =
bond_option_coupled_control_set(struct bonding *bond,
>> bond->params.coupled_control =3D newval->value;
>> return 0;
>> }
>> +
>> +static int bond_option_broadcast_neigh_set(struct bonding *bond,
>> +    const struct bond_opt_value *newval)
>> +{
>> + if (bond->params.broadcast_neighbor =3D=3D newval->value)
>> + return 0;
>> +
>> + bond->params.broadcast_neighbor =3D newval->value;
>> + if (bond->dev->flags & IFF_UP) {
>> + if (bond->params.broadcast_neighbor)
>> + static_branch_inc(&bond_bcast_neigh_enabled);
>> + else
>> + static_branch_dec(&bond_bcast_neigh_enabled);
>> + }
>> +
>> + netdev_dbg(bond->dev, "Setting broadcast_neighbor to %s (%llu)\n",
>> +    newval->string, newval->value);
>> + return 0;
>> +}
>> diff --git a/include/net/bond_options.h b/include/net/bond_options.h
>> index 18687ccf0638..022b122a9fb6 100644
>> --- a/include/net/bond_options.h
>> +++ b/include/net/bond_options.h
>> @@ -77,6 +77,7 @@ enum {
>> BOND_OPT_NS_TARGETS,
>> BOND_OPT_PRIO,
>> BOND_OPT_COUPLED_CONTROL,
>> + BOND_OPT_BROADCAST_NEIGH,
>> BOND_OPT_LAST
>> };
>>=20
>> diff --git a/include/net/bonding.h b/include/net/bonding.h
>> index 95f67b308c19..e06f0d63b2c1 100644
>> --- a/include/net/bonding.h
>> +++ b/include/net/bonding.h
>> @@ -115,6 +115,8 @@ static inline int is_netpoll_tx_blocked(struct =
net_device *dev)
>> #define is_netpoll_tx_blocked(dev) (0)
>> #endif
>>=20
>> +DECLARE_STATIC_KEY_FALSE(bond_bcast_neigh_enabled);
>> +
>> struct bond_params {
>> int mode;
>> int xmit_policy;
>> @@ -149,6 +151,7 @@ struct bond_params {
>> struct in6_addr ns_targets[BOND_MAX_NS_TARGETS];
>> #endif
>> int coupled_control;
>> + int broadcast_neighbor;
>>=20
>> /* 2 bytes of padding : see ether_addr_equal_64bits() */
>> u8 ad_actor_system[ETH_ALEN + 2];



