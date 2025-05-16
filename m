Return-Path: <netdev+bounces-190929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5165AAB9540
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 06:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F375818880E7
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 04:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF95821FF5C;
	Fri, 16 May 2025 04:21:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F143B21171C
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 04:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747369305; cv=none; b=rzCgBpQBjY8F8P2soSBE7fGMT7O4RWM2WGBbf4uChXQuS7ziDRT9IVmq4PyzDE/7JJyn3tQBlgvRUiPAbxm5RCMGV+CFwsjdvONL3SgjJhfbg2ZOjxMpqvjJ/fKhLVJpal3GZ25Fzx/bNBv1q/W9Ca5Utu421l+UfHj+ZZqpMss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747369305; c=relaxed/simple;
	bh=TYwBfj7g8Ok2wJm1E/RMi2NPPXTA9o77mI+N/VEhHto=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SumGKY3070ldrV94y5r3bRF9GRmGy9dKHGI3sA+n+/ib++Du+b76BiReFRN1kQVQ5V2NKn77ltk5Libxup4liVdS7PBVrjyLhhPUCMhW+Ad84D7WpyTsu08bjleDR85bbWFceaGN5cAxVtaYVnzU6p3f9E0aE1cNhMW6J2SLyc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz16t1747369204td4333bfe
X-QQ-Originating-IP: TE3+Ey5HnhbNWrpBQKa0W6Cai1blqprxm+wW9NVlN80=
Received: from smtpclient.apple ( [111.202.70.101])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 16 May 2025 12:20:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1398870192125984121
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
Date: Fri, 16 May 2025 12:19:52 +0800
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
Message-Id: <5A473EF9-677F-4DE5-AA92-E4EBA8C09946@bamaicloud.com>
References: <20250514071339.40803-1-tonghao@bamaicloud.com>
 <157A289E7BA00D9A+20250514071339.40803-2-tonghao@bamaicloud.com>
 <1338977.1747215491@vermin>
To: Jay Vosburgh <jv@jvosburgh.net>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Mom5ezI3X1cDg3nSrPJuL0xtDmsImItwapmbhxGd6w8s3rdsW0JgLq02
	WH3WfkNIJ82t+r+GiQ3xN7gqFURfjVC2IIpweGl4HYFF2NK1cNZzPm9sJCQ9iEzyVjZo7Fv
	lu3nWeYOWibzbfFRqoJYn7c3WyJyQY5wF2iY+pBnBmKBdSQPLegjcWEbvKIFbXJH7RS9J3p
	M4BxrdaeEn02h+Y1cKrKtOdMngVSGLzZdhAjqtsKCuFKf7lj7YjzCVHL0kmKxUFEsDtwigx
	VV2aPd1kMv74zFIMTXoR6XPHo0kRKXAsYcDcCCJxM+vmcEMqM6ZpS5wgzrBUQRIoIIzhB9u
	+irlGWl0XB0E6s2TtuRIARJtYhpJWMMogEZFFetcAaxj9V1DyiZWI4nyNy60R27KNVn9USk
	VcVYygHim6qbWUUnyue1d2EpmcoUJhHnknyZVNUIulnFJG+OJbMV5rsnNcxoXRw7xjfejN3
	mCqFJIfO2MU54oHKEvOaJmoG/Y/5Klnu9PSv5yKKWCJgVXDP48z2/dsCvT3UCNtNaHFu7GF
	sPwB2+KK9L60CNJSLO+D1U3fO8n/kFA/zPkRSEZAhctFhJsEkE1KVuQjtpEz15aDi2eK6lW
	2/zi+TQ69+BleonjeLC5hlQ1KhgK2LLhUzezYA1Rg9t9QTezY53uaKCfulDjo7puR8FIDAX
	KNq53VzA7E8AAXuAi42fDZ7tiHaBYZ6DxHupsh0R4fKMwBoLeBBa5WwcKt0TqmVIfqN0lnk
	9QxKBxmaZJXJUw3q4cZ6+YXow3y218L0Z/wEgpo4CazwyTYSx6ar933NGq9T7VU+xN9EkPn
	1LRI/KeMwpBv1o0qWXu1ahqglbB2coshQjsjtQHjkeNjVK1ZyoxdTPWcZ4xE3CJqSgK+AI6
	8Owj0g0CYjroeAcOO5HPsZy8qXaB0voBipBHL416O0uDM5msDcEewfeY00eHZXuQkPWaA8V
	HvI3yWGJl7qEDe7ePYovqMUvEDSY1yK5g4vfp16trwSwpruOgpKY5SrMx
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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
Ok, I will format every commit log of patch.
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
Ok
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
If sending the packets to inactive ports, the switch will drop the =
packets in our production environment, because lacp state of the port is =
down. I agree with you, the bond brodcast_neighbor enabled should only =
send packet to active ports.
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



