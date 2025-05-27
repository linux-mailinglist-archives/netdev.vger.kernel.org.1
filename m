Return-Path: <netdev+bounces-193700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB5EAC523B
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 17:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508D1178517
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 15:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A6F2561A2;
	Tue, 27 May 2025 15:37:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858A326FDB7
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748360277; cv=none; b=FxWc4+9d9xdeSlEdPFi6HMLylI8WeA/k7tWMwWV7hwALi/2A6wHFIMN7gvXK6zSw8fCIy+W/R8deykA1UugYPufwlbN8yCj5T6JJQGctDeAFhqflGVvNwZbatkuqinkS2MlcrkI/mFGpUAOY6tSsvdrfCFmct/mQgWQMCdCf0qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748360277; c=relaxed/simple;
	bh=mAvquAOfk+wB85mTjLF09lyv3g/WkJaXUEICjR7uSK4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZS700kOG3FFSald20RtHtXZYTZmLXLMp+LLLzzathufdRP191t0hKO3KQOECAXUM5Vc2D1k4tltaGSl2hFCNrcM1OJz/IrgayvG7bpUpAeX3K1DjGkxSKPP1F4HMClGZBWgfoLHfguiqHXaUuv2XPU/NrDjygss4UaZKdQ9Mq6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz4t1748360172t812acd39
X-QQ-Originating-IP: izluW6f7glrI9BsC5SgLpxOoFmWD8FhP5oeAHpkCCa4=
Received: from smtpclient.apple ( [111.201.145.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 27 May 2025 23:36:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2585345084099222406
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
In-Reply-To: <e999e9a0-19d3-4519-8094-268a67f5da63@redhat.com>
Date: Tue, 27 May 2025 23:35:59 +0800
Cc: netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Zengbing Tu <tuzengbing@didiglobal.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0D2BAA86-E641-4582-A4EE-8E30CA71C660@bamaicloud.com>
References: <20250522085516.16355-1-tonghao@bamaicloud.com>
 <20250522085516.16355-2-tonghao@bamaicloud.com>
 <e999e9a0-19d3-4519-8094-268a67f5da63@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MYha8DeKTomk8l0yIgKHv6wqOg66mCwUr8uaEmAI1JP+aT5Z3ybeLSHj
	WnWJ5VJSyWp/UmG91WoeIKdkB1iJQvNa7XYs3hMrwWp8jtzjIbB3tYg/IQ80ltl9mBOyvdG
	8rLDXPp+hwDOQ/EWKeB4f/464gzZWhSNurP7qQJVc3aqrsp5Gh30Aq5lbEFFg0+cP+QqB+h
	f+Apq9PQLjcAjfUJ2n1vE36Gk4idLxOFFsUXBVYzp1ccGEXVM0Hmi3JZk0EVHNtUCHoqK41
	/ZIFSVXjSZ+dJYb/iAnBhu/MhLs/HpC+BXo5ddxdKGQgYxcDYeJdVgVtvzexGeFclLGHu1S
	is66qWgqsol/xuc4Y1Bbd8lOqes7rIMlZkqVQX+SZl4k4HygpfbGvafIR4HAdNqj7ODEgNw
	pkhF+ABqHPrgdkxNMdar9RImRRXUJGj+QBuXCXh/rkcfOcQsLnrMWprCNompMilAaYuWLB8
	wvIw2AXuc8TfMJbl5LchOetnKzWtVVnrQZgjIkqpakr2kU0keKNhKnJ9roFHLbiGXBtrItg
	wpGctO+2WicUOrMkEWeyECgZRyGidsNlE6Aj9CKImereutASCiWhxY3VocC+UKCeygD5lGd
	dVt0Y1Mj0O31Fz9djAYqL1kEm/MRDJNf/WtB1kzZUeZXUvlbUhURmD3qwMeJqwrHVoLbEVh
	vkRnGgKplZeu6NUMznOGJjeoao0B4rg88xKIeE9YJcGmgMpFostb8jPMeok7gTgyhGMX6z0
	RpI4BtkThDkRlCMNA+Z4rt18sN8mFfn2KEjgMyfYRCac/XhTAFugNdsuc15IuSIdCKX08At
	35+OS+NHMolDb1Z04MtoC/wig+syaaOND5X5tlmKaVqdz/I3sBbjoim6Qyt8+LoYj6htDvE
	3SK8lj9kJJKciSidpfqsDFvJWnjMHgv2F2t2xdtAJhWr9rDdfOIikKgJ+k2dqF7PgqJf+l1
	qRyxExWbIPOh0Gb9PxlXsv1VFcx4zQEk9YBbqUdFSoNJmobdaIv3VaEzGfxwSTkIeU6GJle
	epDoftRA==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B45=E6=9C=8827=E6=97=A5 22:00=EF=BC=8CPaolo Abeni =
<pabeni@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 5/22/25 10:55 AM, Tonghao Zhang wrote:
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
>> after the split, it is equivalent to two switches with the same
>> configuration appearing in the network, causing network configuration
>> conflicts and ultimately interrupting the services carried by the
>> stacking system.
>>=20
>> To improve network stability, "non-stacking" solutions have been
>> increasingly adopted, particularly by public cloud providers and
>> tech companies like Alibaba, Tencent, and Didi. "non-stacking" is
>> a method of mimicing switch stacking that convinces a LACP peer,
>> bonding in this case, connected to a set of "non-stacked" switches
>> that all of its ports are connected to a single switch
>> (i.e., LACP aggregator), as if those switches were stacked. This
>> enables the LACP peer's ports to aggregate together, and requires
>> (a) special switch configuration, described in the linked article,
>> and (b) modifications to the bonding 802.3ad (LACP) mode to send
>> all ARP/ND packets across all ports of the active aggregator.
>>=20
>> Note that, with multiple aggregators, the current broadcast mode
>> logic will send only packets to the selected aggregator(s).
>>=20
>> +-----------+   +-----------+
>> |  switch1  |   |  switch2  |
>> +-----------+   +-----------+
>>         ^           ^
>>         |           |
>>      +-----------------+
>>      |   bond4 lacp    |
>>      +-----------------+
>>         |           |
>>         | NIC1      | NIC2
>>      +-----------------+
>>      |     server      |
>>      +-----------------+
>=20
>=20
> IHMO all the above wording should be placed in the cover letter. This
> commit message should instead be more related to the actual code.
I add more commit message in this patch. In the future, everyone will =
have a clearer understanding of why this feature is needed.
This is the first version of the discussion:
=
https://patchwork.kernel.org/project/netdevbpf/patch/20250510044504.52618-=
2-tonghao@bamaicloud.com/
>=20
>> diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
>> index d05226484c64..b5c34d7f126c 100644
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
>> @@ -4480,6 +4485,10 @@ static int bond_close(struct net_device =
*bond_dev)
>> bond_alb_deinitialize(bond);
>> bond->recv_probe =3D NULL;
>>=20
>> + if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD &&
>> +    bond->params.broadcast_neighbor)
>> + static_branch_dec(&bond_bcast_neigh_enabled);
>=20
> What if the user enables BOND_OPT_BROADCAST_NEIGH and later switch the
> bond mode? it looks like there will be bad accounting for static =
branch.
If you want to change the mode, then you must turn off the device first. =
So no bad accounting
This is v2 of the discussion:
=
https://patchwork.kernel.org/project/netdevbpf/patch/4270C010E5516F3B+2025=
0513094750.23387-2-tonghao@bamaicloud.com/
>=20
>> +
>> if (bond_uses_primary(bond)) {
>> rcu_read_lock();
>> slave =3D rcu_dereference(bond->curr_active_slave);
>> @@ -5316,6 +5325,37 @@ static struct slave =
*bond_xdp_xmit_3ad_xor_slave_get(struct bonding *bond,
>> return slaves->arr[hash % count];
>> }
>>=20
>> +static bool bond_should_broadcast_neighbor(struct sk_buff *skb,
>> +   struct net_device *dev)
>> +{
>> + struct bonding *bond =3D netdev_priv(dev);
>> + struct {
>> + struct ipv6hdr ip6;
>> + struct icmp6hdr icmp6;
>> + } *combined, _combined;
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
>> + if (skb->protocol =3D=3D htons(ETH_P_IPV6)) {
>> + combined =3D skb_header_pointer(skb, skb_mac_header_len(skb),
>> +      sizeof(_combined),
>> +      &_combined);
>> + if (combined && combined->ip6.nexthdr =3D=3D NEXTHDR_ICMP &&
>> +    (combined->icmp6.icmp6_type =3D=3D NDISC_NEIGHBOUR_SOLICITATION =
||
>> +     combined->icmp6.icmp6_type =3D=3D =
NDISC_NEIGHBOUR_ADVERTISEMENT))
>> + return true;
>> + }
>> +
>> + return false;
>> +}
>> +
>> /* Use this Xmit function for 3AD as well as XOR modes. The current
>>  * usable slave array is formed in the control path. The xmit =
function
>>  * just calculates hash and sends the packet out.
>> @@ -5337,15 +5377,25 @@ static netdev_tx_t bond_3ad_xor_xmit(struct =
sk_buff *skb,
>>=20
>> /* in broadcast mode, we send everything to all usable interfaces. */
>> static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
>> -       struct net_device *bond_dev)
>> +       struct net_device *bond_dev,
>> +       bool all_slaves)
>> {
>> struct bonding *bond =3D netdev_priv(bond_dev);
>> - struct slave *slave =3D NULL;
>> - struct list_head *iter;
>> + struct bond_up_slave *slaves;
>> bool xmit_suc =3D false;
>> bool skb_used =3D false;
>> + int slaves_count, i;
>>=20
>> - bond_for_each_slave_rcu(bond, slave, iter) {
>> + rcu_read_lock();
>=20
> Why this the RCU lock is now needed? AFAICS the caller scope does not
Using this to protect read side to access slave in all_slaves or =
usable_slaves.  bond_start_xmit use the rcu_read_lock, so I can remove =
the  rcu_read_lock in bond_xmit_broadcast.
> change. This is either not needed, or deserves a separate patch, with =
a
> suitable fixes tag.
>=20
> /P
>=20
>=20
>=20


