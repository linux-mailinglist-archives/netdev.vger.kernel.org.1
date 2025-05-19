Return-Path: <netdev+bounces-191442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA3CABB7D9
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52471645F4
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F339269808;
	Mon, 19 May 2025 08:50:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA0B1FC7CA
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 08:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747644647; cv=none; b=o9cLQbl3NVUKbCIDOS765+e3irjd4+YIdjxxGrPqopqNzFCMlfOTmNtRV2oRiweCXvCbrOWMXpq2N9o+osd79fU1WA2jhrFH7BAw74FozFmBBfWYuc1DwyD/7YsjkfKnIonBf4EFD+C81ftLl6YoNDHx1Zp7jRiv/e5W+fuuIGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747644647; c=relaxed/simple;
	bh=AlTkBIaq4OHEy07b5ijcvDoWx05L3RcoNyzVGJjIj5I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Uy0Mzt0qszLEbhTEALg6r47izF/7wGlS/bSmtktAosAR4tMBldA2GrJfuKHnDl6TGL1c+MueqtB6UJ16y/V9hS0MkfU/gkn6vcMIruiYS1ZT/eTnuEG7QVNG/ns7j+1KAn1Jtk0rJibauKTGrGGHtkbQDf5JH/A832s5Afe6Elw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz12t1747644577tc140bc82
X-QQ-Originating-IP: iTIPFtjHTv9JJBwiAws2a8A9I0R0t0PU3k9fcA6Y4dE=
Received: from smtpclient.apple ( [111.202.70.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 19 May 2025 16:49:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6136929712572798074
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
In-Reply-To: <1338977.1747215491@vermin>
Date: Mon, 19 May 2025 16:49:24 +0800
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Zengbing Tu <tuzengbing@didiglobal.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4DF99687-2D24-4349-BBF3-1B5C76C6209C@bamaicloud.com>
References: <20250514071339.40803-1-tonghao@bamaicloud.com>
 <157A289E7BA00D9A+20250514071339.40803-2-tonghao@bamaicloud.com>
 <1338977.1747215491@vermin>
To: Jay Vosburgh <jv@jvosburgh.net>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Nkqq4bFvvULWP74GUNYdZtAU5ohhEPz8VhiBJVqMZqYkrStrU5ZdF1ek
	dMBQ62BVQZlRvrUk397RsbnBJSyXyxUwuveiWMpL56IoQAtaAAzPvOzSHkqFOJ2/7fu0hNx
	6UuMP3qKa3n5CfWLmJ1wVjluGjTrmvN58x5mQtt6cUNgzBRB0O5xcGwYsfcbU7PIJ+d6in9
	+t/rPuP2VVfj99IMh4bSoG1x8GpnbRMpt3Yp1xC0dH46yj4+cMiVj22354YA1yq8WMMSVfr
	id36mYB9XE20jYeaMo85jxPrvuOy9K9/LmxtQvwDyStkugKzckwUb/LCvIZXm7rVAplPlXm
	ftfv4kXU8ATMTV2Gr+pdlusw3CIxm7DL0zRs4ciIPIepe7uOTSDTvQ51P9lIMqtyikwjVSM
	DFjOS5xWql0h0M992uDZDUE4i/RtOOsdcA3buJ1u9KiZgpuP8NZp18lKzDMynLkwyYLoXzF
	bgmfU/0cGIYtyiV0HOTVo4NxuEGlkEqkgTM2XMqC+2w43nKHe2sWXA8e70olFwmWcbE897M
	emA2+S2FQylwS1jwY6xhZFVDrUmZR84QkuZ62+KoS8WM1jZew3dE+DIvHQSIrrSDGNCeQl5
	iBL7lLKS33veTTN3la8NIZTYvgu5JitQr6cqvHVyvxVI5YZqwrYtKZFfLAmb3jKvrivglfa
	fHihuyDvYMhZ8bu3P8VrE2dSRyDD2J7Jh76pKIdpC/J9hrPJ30pXM2n6/b95Zt9ylMdA8IK
	OakIOH9oAFRD2f0wd51qBikN3fyiKbFahWsJa4oJnWhZ0q0GM/zUjiC0KMEu4Aktz6/48sA
	qml2GXGeFQmyvC1cRAQLMxjN9jhxUIy4/zquKk7tfZPRY2nVOoAAmdo5YNYe5WgIko69ZoC
	vMhGqFoNA1gd3x9gTO4dVwgJxtt5QTt3ILQASt1gvwW1uxGT9/8b8tFVGM1uVqnCg4aNQ4Q
	6YO8Y5jdCmXynJrjSfTDzBjmtDNAF4j4WX/URx77mUdxDnHh5S+RsPu1ZLiXBZhdMAcPmRN
	X2p/b7waDOQQWJPm1K6kTyzDmtyFPv5TUmQFeycQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B45=E6=9C=8814=E6=97=A5 17:38=EF=BC=8CJay Vosburgh =
<jv@jvosburgh.net> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Tonghao Zhang <tonghao@bamaicloud.com> wrote:
>=20
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
>=20
> Please reformat the above to wrap at 75 columns, otherwise the
> text in "git log" will wrap 80 columns (because git log indents the =
log
> message).
>=20
>> -----------     -----------
>> |  switch1  |   |  switch2  |
>> -----------     -----------
>>        ^           ^
>>        |           |
>>      -----------------
>>     |   bond4 lacp    |
>>      -----------------
>>        |           |
>>        | NIC1      | NIC2
>>      -----------------
>>     |     server      |
>>      -----------------
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
b/Documentation/networking/bonding.rst
>> index a4c1291d2561..14f7593d888d 100644
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
>=20
> I'd recommend you look at bond_na_rcv() and mimic its logic for
> inspecting the ipv6 and icmp6 headers by using skb_header_pointer()
> instead of pskb_may_pull().  The skb_header_pointer() function does =
not
> alter the skb (it will not move data into the skb linear area), and
> would have lower cost for this use case.  With broadcast_neighbor
> enabled, every IPv6 packet will pass through this test, so minimizing
> its cost should be of benefit.
Hi, Jay. V5 is posted. I review the bonding module codes. Note that =
alb_determine_nd() and  bond_na_rcv() also check the ipv6 nd/na. So I =
will introduce a new one helper for checking ipv6 na/nd in a separate =
patch.
>=20
>> +
>> + return false;
>> +}
>> +
>> /* Use this Xmit function for 3AD as well as XOR modes. The current
>> * usable slave array is formed in the control path. The xmit function
>> * just calculates hash and sends the packet out.
>> @@ -5583,6 +5620,9 @@ static netdev_tx_t __bond_start_xmit(struct =
sk_buff *skb, struct net_device *dev
>> case BOND_MODE_ACTIVEBACKUP:
>> return bond_xmit_activebackup(skb, dev);
>> case BOND_MODE_8023AD:
>> + if (bond_should_broadcast_neighbor(skb, dev))
>> + return bond_xmit_broadcast(skb, dev);
>=20
> One question that just occured to me... is bond_xmit_broadcast()
> actually the correct logic?  It will send the skb to every interface
> that is a member of the bond, but for the "non stacked" case, I =
believe
> the correct logic is to send only to interfaces that are part of the
> active aggregator.
>=20
> Stated another way, with broadcast_neighbor enabled, if the bond
> has interfaces not part of the active aggregator (perhaps a switch =
port
> or entire switch not correctly configured for "non stacked" =
operation),
> the ARP / NS / NA packet has the potential to update neighbor tables
> incorrectly.
>=20
> Assuming that's correct (that it should exclude interfaces not
> in the active aggregator), that raises the question of what is the
> correct behavior if there is no active aggregator, but only ports in
> individual mode.  I would expect that in that case it should utilize =
the
> usual LACP transmit logic (sending on just the individual port that
> bonding has selected as active).
>=20
> -J
>=20
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
>> --=20
>> 2.34.1
>>=20
>=20
> ---
> -Jay Vosburgh, jv@jvosburgh.net



