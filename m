Return-Path: <netdev+bounces-193560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26456AC4723
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 06:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B483B6F62
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 04:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8903F6F06A;
	Tue, 27 May 2025 04:05:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D9B4A04
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 04:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748318711; cv=none; b=jG8aXIka0cSY+7HAeaANOF6m++WP2MGTCq7qXQr6aqe+pkz+w+NKCX5WQsSQl5KoMKdjTDOK43dze5LcwzBjrIQDFPvPKBJzSKsesuXbip8yormRsevEOz6JVVLA05UnlYD+O0GFAsy25kYljv4FDdJ4/FHo14f3Z1P2AHrrX3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748318711; c=relaxed/simple;
	bh=KFOk+AiT16UNDuJnEpHcd/U7YwEvjYDQ6IGTFj1oYxo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=naTY5XhF39kFLpHZ9/eSHTZF53rLu6Oh4C5YTxjq1ApzMwZ5uoO6gJT2wVhfRddeMU74AvMsCHBHN0Vood5mxlRN+WAF57J4oflv4KiR6oqFIu+uQPUHXZqMmrgrqmrntkKdwZGpI515nOhMfkh0KE3MHJoydb502gUKvQDYjzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz14t1748318678tab70cab2
X-QQ-Originating-IP: 3Y9Y2eKvJrVCxUQg7w53VX4s4bhCMn7fSqY1GCWoePE=
Received: from smtpclient.apple ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 27 May 2025 12:04:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12860695663393365115
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH RESEND net-next v5 1/4] net: bonding: add
 broadcast_neighbor option for 802.3ad
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <20250522085516.16355-2-tonghao@bamaicloud.com>
Date: Tue, 27 May 2025 12:04:25 +0800
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7D55DAA9-5EF5-4B35-9AF9-73A6662C1592@bamaicloud.com>
References: <20250522085516.16355-1-tonghao@bamaicloud.com>
 <20250522085516.16355-2-tonghao@bamaicloud.com>
To: jv@jvosburgh.net,
 razor@blackwall.org
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MShfLn39PbN2WZzgTdjTL8kwG9/SKfRiHZTRsCX8utLKch6GEkWj/ktq
	oeJy0bmPeq9WIdlnXHp4ln3479swHA9MZ5AAG77rQF7q+qTawny2lodzHws1XXYnjWf3njq
	BHUocUcAm1j0sQapted+PPB1+5UncCrRm6dIng+cYM4lpVvWFGgwAcu6UJpeorsm+7L9aSh
	lSsZ6yI2PxLATvMKyE1vPqofShAJ4WMwt02OnaIvYYcDsY/GaUKooBuLpSD2xMhOZz/hNM6
	XrK77qPSQN57vKU0ltGYSwW9WmKPKJkwdsBnl+GzkZp0YxRti5mO16O3jif4US65LSYnMXq
	cL6LxMlD5AXTx8RPOHyUDVuveQNnBJK1Mk9JnBb92qmbi4aVX2hjmf7sDhFHxx1REZKonrw
	PEFIyd8Zx/XxJIyjppR+E7YJN6qEsfzd22qlQ/i5+b7VF/wcyJPQCYkPkuPUkO4wOy5t/zl
	O7tYLw/PTGqRgeJoJDu7Z8wLWq76ajDFs+TfXUJf3fZ8o7KLg3ma9h7+CgyQlrkb9n53Vsa
	qsKXPwn2LSk19uvF63k9IIfoKZiMrGYgMjrwqlj+pHgkVlVJ7HcPEmiO/SOoYhWCUgIPfJ2
	m//7WoO3ardAulahlJX9ylwXH+DTxISQLDR94PkY7H766O5M9nHgGpFNUqMBM3qMSSfjjVt
	V6q4kOn3CT6NxXcyHwHZPpLTfnX5+BCYCdKT++IrS1e/aM9ah6iUqzrzLTPRJnJ4NRmnyQh
	V6VbmQGJ2ik1t7TxfT+HaZnolDKz5Z5wV3kb1dQngrtewwIF3oWM2UHG1JWGZ0lrUczu73e
	MpNKKp8cYefQPqxT8zXPpuvnFx3qfrgu52AFM3wZhnZajrdviVVllno0mar0gvU32JCay+Z
	3yk95SKmI8K/3a11HoFOhlrgrtsX2a0+JCOmGInu0qIySJY8Yomcr2wfbrYqlZO4PMvbmQQ
	zLZ2FUJaROcit3vEXb5AKQNPbi43h5oCP7S4CtC2WmupbBQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Hi Jay, Nikolay
Any comments about this version?=20


> 2025=E5=B9=B45=E6=9C=8822=E6=97=A5 16:55=EF=BC=8CTonghao Zhang =
<tonghao@bamaicloud.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
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
> the switches fails or is abnormal, the stack will split. Although it =
is
> not common, it still happens in actual operation. The problem is that
> after the split, it is equivalent to two switches with the same
> configuration appearing in the network, causing network configuration
> conflicts and ultimately interrupting the services carried by the
> stacking system.
>=20
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
>=20
> Note that, with multiple aggregators, the current broadcast mode
> logic will send only packets to the selected aggregator(s).
>=20
> +-----------+   +-----------+
> |  switch1  |   |  switch2  |
> +-----------+   +-----------+
>         ^           ^
>         |           |
>      +-----------------+
>      |   bond4 lacp    |
>      +-----------------+
>         |           |
>         | NIC1      | NIC2
>      +-----------------+
>      |     server      |
>      +-----------------+
>=20
> - =
https://www.ruijie.com/fr-fr/support/tech-gallery/de-stack-data-center-net=
work-architecture/
>=20
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
> Documentation/networking/bonding.rst |  6 +++
> drivers/net/bonding/bond_main.c      | 66 +++++++++++++++++++++++++---
> drivers/net/bonding/bond_options.c   | 35 +++++++++++++++
> include/net/bond_options.h           |  1 +
> include/net/bonding.h                |  3 ++
> 5 files changed, 106 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/networking/bonding.rst =
b/Documentation/networking/bonding.rst
> index a4c1291d2561..14f7593d888d 100644
> --- a/Documentation/networking/bonding.rst
> +++ b/Documentation/networking/bonding.rst
> @@ -562,6 +562,12 @@ lacp_rate
>=20
> The default is slow.
>=20
> +broadcast_neighbor
> +
> + Option specifying whether to broadcast ARP/ND packets to all
> + active slaves.  This option has no effect in modes other than
> + 802.3ad mode.  The default is off (0).
> +
> max_bonds
>=20
> Specifies the number of bonding devices to create for this
> diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
> index d05226484c64..b5c34d7f126c 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -212,6 +212,8 @@ atomic_t netpoll_block_tx =3D ATOMIC_INIT(0);
>=20
> unsigned int bond_net_id __read_mostly;
>=20
> +DEFINE_STATIC_KEY_FALSE(bond_bcast_neigh_enabled);
> +
> static const struct flow_dissector_key flow_keys_bonding_keys[] =3D {
> {
> .key_id =3D FLOW_DISSECTOR_KEY_CONTROL,
> @@ -4461,6 +4463,9 @@ static int bond_open(struct net_device =
*bond_dev)
>=20
> bond_for_each_slave(bond, slave, iter)
> dev_mc_add(slave->dev, lacpdu_mcast_addr);
> +
> + if (bond->params.broadcast_neighbor)
> + static_branch_inc(&bond_bcast_neigh_enabled);
> }
>=20
> if (bond_mode_can_use_xmit_hash(bond))
> @@ -4480,6 +4485,10 @@ static int bond_close(struct net_device =
*bond_dev)
> bond_alb_deinitialize(bond);
> bond->recv_probe =3D NULL;
>=20
> + if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD &&
> +    bond->params.broadcast_neighbor)
> + static_branch_dec(&bond_bcast_neigh_enabled);
> +
> if (bond_uses_primary(bond)) {
> rcu_read_lock();
> slave =3D rcu_dereference(bond->curr_active_slave);
> @@ -5316,6 +5325,37 @@ static struct slave =
*bond_xdp_xmit_3ad_xor_slave_get(struct bonding *bond,
> return slaves->arr[hash % count];
> }
>=20
> +static bool bond_should_broadcast_neighbor(struct sk_buff *skb,
> +   struct net_device *dev)
> +{
> + struct bonding *bond =3D netdev_priv(dev);
> + struct {
> + struct ipv6hdr ip6;
> + struct icmp6hdr icmp6;
> + } *combined, _combined;
> +
> + if (!static_branch_unlikely(&bond_bcast_neigh_enabled))
> + return false;
> +
> + if (!bond->params.broadcast_neighbor)
> + return false;
> +
> + if (skb->protocol =3D=3D htons(ETH_P_ARP))
> + return true;
> +
> + if (skb->protocol =3D=3D htons(ETH_P_IPV6)) {
> + combined =3D skb_header_pointer(skb, skb_mac_header_len(skb),
> +      sizeof(_combined),
> +      &_combined);
> + if (combined && combined->ip6.nexthdr =3D=3D NEXTHDR_ICMP &&
> +    (combined->icmp6.icmp6_type =3D=3D NDISC_NEIGHBOUR_SOLICITATION =
||
> +     combined->icmp6.icmp6_type =3D=3D =
NDISC_NEIGHBOUR_ADVERTISEMENT))
> + return true;
> + }
> +
> + return false;
> +}
> +
> /* Use this Xmit function for 3AD as well as XOR modes. The current
>  * usable slave array is formed in the control path. The xmit function
>  * just calculates hash and sends the packet out.
> @@ -5337,15 +5377,25 @@ static netdev_tx_t bond_3ad_xor_xmit(struct =
sk_buff *skb,
>=20
> /* in broadcast mode, we send everything to all usable interfaces. */
> static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
> -       struct net_device *bond_dev)
> +       struct net_device *bond_dev,
> +       bool all_slaves)
> {
> struct bonding *bond =3D netdev_priv(bond_dev);
> - struct slave *slave =3D NULL;
> - struct list_head *iter;
> + struct bond_up_slave *slaves;
> bool xmit_suc =3D false;
> bool skb_used =3D false;
> + int slaves_count, i;
>=20
> - bond_for_each_slave_rcu(bond, slave, iter) {
> + rcu_read_lock();
> +
> + if (all_slaves)
> + slaves =3D rcu_dereference(bond->all_slaves);
> + else
> + slaves =3D rcu_dereference(bond->usable_slaves);
> +
> + slaves_count =3D slaves ? READ_ONCE(slaves->count) : 0;
> + for (i =3D 0; i < slaves_count; i++) {
> + struct slave *slave =3D slaves->arr[i];
> struct sk_buff *skb2;
>=20
> if (!(bond_slave_is_up(slave) && slave->link =3D=3D BOND_LINK_UP))
> @@ -5367,6 +5417,8 @@ static netdev_tx_t bond_xmit_broadcast(struct =
sk_buff *skb,
> xmit_suc =3D true;
> }
>=20
> + rcu_read_unlock();
> +
> if (!skb_used)
> dev_kfree_skb_any(skb);
>=20
> @@ -5583,10 +5635,13 @@ static netdev_tx_t __bond_start_xmit(struct =
sk_buff *skb, struct net_device *dev
> case BOND_MODE_ACTIVEBACKUP:
> return bond_xmit_activebackup(skb, dev);
> case BOND_MODE_8023AD:
> + if (bond_should_broadcast_neighbor(skb, dev))
> + return bond_xmit_broadcast(skb, dev, false);
> + fallthrough;
> case BOND_MODE_XOR:
> return bond_3ad_xor_xmit(skb, dev);
> case BOND_MODE_BROADCAST:
> - return bond_xmit_broadcast(skb, dev);
> + return bond_xmit_broadcast(skb, dev, true);
> case BOND_MODE_ALB:
> return bond_alb_xmit(skb, dev);
> case BOND_MODE_TLB:
> @@ -6462,6 +6517,7 @@ static int __init bond_check_params(struct =
bond_params *params)
> eth_zero_addr(params->ad_actor_system);
> params->ad_user_port_key =3D ad_user_port_key;
> params->coupled_control =3D 1;
> + params->broadcast_neighbor =3D 0;
> if (packets_per_slave > 0) {
> params->reciprocal_packets_per_slave =3D
> reciprocal_value(packets_per_slave);
> diff --git a/drivers/net/bonding/bond_options.c =
b/drivers/net/bonding/bond_options.c
> index 91893c29b899..7f0939337231 100644
> --- a/drivers/net/bonding/bond_options.c
> +++ b/drivers/net/bonding/bond_options.c
> @@ -87,6 +87,8 @@ static int bond_option_missed_max_set(struct bonding =
*bond,
>      const struct bond_opt_value *newval);
> static int bond_option_coupled_control_set(struct bonding *bond,
>   const struct bond_opt_value *newval);
> +static int bond_option_broadcast_neigh_set(struct bonding *bond,
> +   const struct bond_opt_value *newval);
>=20
> static const struct bond_opt_value bond_mode_tbl[] =3D {
> { "balance-rr",    BOND_MODE_ROUNDROBIN,   BOND_VALFLAG_DEFAULT},
> @@ -240,6 +242,12 @@ static const struct bond_opt_value =
bond_coupled_control_tbl[] =3D {
> { NULL,  -1, 0},
> };
>=20
> +static const struct bond_opt_value bond_broadcast_neigh_tbl[] =3D {
> + { "off", 0, BOND_VALFLAG_DEFAULT},
> + { "on", 1, 0},
> + { NULL,  -1, 0}
> +};
> +
> static const struct bond_option bond_opts[BOND_OPT_LAST] =3D {
> [BOND_OPT_MODE] =3D {
> .id =3D BOND_OPT_MODE,
> @@ -513,6 +521,14 @@ static const struct bond_option =
bond_opts[BOND_OPT_LAST] =3D {
> .flags =3D BOND_OPTFLAG_IFDOWN,
> .values =3D bond_coupled_control_tbl,
> .set =3D bond_option_coupled_control_set,
> + },
> + [BOND_OPT_BROADCAST_NEIGH] =3D {
> + .id =3D BOND_OPT_BROADCAST_NEIGH,
> + .name =3D "broadcast_neighbor",
> + .desc =3D "Broadcast neighbor packets to all slaves",
> + .unsuppmodes =3D BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
> + .values =3D bond_broadcast_neigh_tbl,
> + .set =3D bond_option_broadcast_neigh_set,
> }
> };
>=20
> @@ -1840,3 +1856,22 @@ static int =
bond_option_coupled_control_set(struct bonding *bond,
> bond->params.coupled_control =3D newval->value;
> return 0;
> }
> +
> +static int bond_option_broadcast_neigh_set(struct bonding *bond,
> +   const struct bond_opt_value *newval)
> +{
> + if (bond->params.broadcast_neighbor =3D=3D newval->value)
> + return 0;
> +
> + bond->params.broadcast_neighbor =3D newval->value;
> + if (bond->dev->flags & IFF_UP) {
> + if (bond->params.broadcast_neighbor)
> + static_branch_inc(&bond_bcast_neigh_enabled);
> + else
> + static_branch_dec(&bond_bcast_neigh_enabled);
> + }
> +
> + netdev_dbg(bond->dev, "Setting broadcast_neighbor to %s (%llu)\n",
> +   newval->string, newval->value);
> + return 0;
> +}
> diff --git a/include/net/bond_options.h b/include/net/bond_options.h
> index 18687ccf0638..022b122a9fb6 100644
> --- a/include/net/bond_options.h
> +++ b/include/net/bond_options.h
> @@ -77,6 +77,7 @@ enum {
> BOND_OPT_NS_TARGETS,
> BOND_OPT_PRIO,
> BOND_OPT_COUPLED_CONTROL,
> + BOND_OPT_BROADCAST_NEIGH,
> BOND_OPT_LAST
> };
>=20
> diff --git a/include/net/bonding.h b/include/net/bonding.h
> index 95f67b308c19..e06f0d63b2c1 100644
> --- a/include/net/bonding.h
> +++ b/include/net/bonding.h
> @@ -115,6 +115,8 @@ static inline int is_netpoll_tx_blocked(struct =
net_device *dev)
> #define is_netpoll_tx_blocked(dev) (0)
> #endif
>=20
> +DECLARE_STATIC_KEY_FALSE(bond_bcast_neigh_enabled);
> +
> struct bond_params {
> int mode;
> int xmit_policy;
> @@ -149,6 +151,7 @@ struct bond_params {
> struct in6_addr ns_targets[BOND_MAX_NS_TARGETS];
> #endif
> int coupled_control;
> + int broadcast_neighbor;
>=20
> /* 2 bytes of padding : see ether_addr_equal_64bits() */
> u8 ad_actor_system[ETH_ALEN + 2];
> --=20
> 2.34.1
>=20
>=20
>=20


