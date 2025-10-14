Return-Path: <netdev+bounces-229222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B40BD974E
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3845E19A0034
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22112313E04;
	Tue, 14 Oct 2025 12:53:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2939219F135
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 12:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446411; cv=none; b=ZZwpl/tEyUln6vsTrf4n129VGNfB+9LTrqD06TOKowfY+76llowisMLkmaJ4Jwgt03ewVn4+PGfyNNIpQE07e70oOzBnghWVOmZvr2aSxCmSdVj0rUPb05z60PvdLTlbrgqwHOCEt/qgnBZZ6JHn55aFjCe38vDUmD6OYScHwi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446411; c=relaxed/simple;
	bh=X6xiax+Z+BrQsqqvgXap6uYKg7PmxseOFPG0k0mXCkg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NenjKmzurLGtM8CH4rCM069CCfIvY4U1TPsfuZcUbc/DJD4uqtvTUCJOuRm4WMD29FnxY5OOTsjEMeNuXTdjIwUKUwiUYS+e4dm8GGw0LsP9piFXFNlfAxJzuSC0B3ICKrb0CkhDg9BWnLdUgqbkU+aHpX+mArYrW1H7OXJCvDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz10t1760446353t42d2268e
X-QQ-Originating-IP: ZFF6THx4JOEyJcZzlltXCzcb5zF8ly9MsCicLa5wF3E=
Received: from smtpclient.apple ( [120.244.234.242])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 14 Oct 2025 20:52:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 730710162482388302
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [net-next v8 1/3] net: bonding: add broadcast_neighbor option for
 802.3ad
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <a97e6e1e-81bc-4a79-8352-9e4794b0d2ca@kernel.org>
Date: Tue, 14 Oct 2025 20:52:19 +0800
Cc: netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Zengbing Tu <tuzengbing@didiglobal.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1E373854-9996-49E6-8609-194CEAFA29ED@bamaicloud.com>
References: <cover.1751031306.git.tonghao@bamaicloud.com>
 <84d0a044514157bb856a10b6d03a1028c4883561.1751031306.git.tonghao@bamaicloud.com>
 <a97e6e1e-81bc-4a79-8352-9e4794b0d2ca@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MjqaYNLY8QZGtaQ8KqUMg+ejdhCghzJbn3z18iCQci/aHs3NSL8zqU8Z
	V2h2ib0tPTqH+lTdoFKvObz1lEaWYy2c7gqPG+J+cldYqYBUZRp4DJ7eWczFMqMFmXwob2Q
	HNarMgFTeBHyiepJsZa5G6REvYSQLFxAVExreg7UJxEK7TQgkhIwxifvTKq5/iPBMAH2WBy
	MB99VMq7ELeufe6cFuUi/BNnXeJ5zCc40jsLSGeRCFPtjsAEy7a+w8D1D67VB4HC+uMAJdB
	I5qKnj9dJ1f1dhPui3aNgowJlXqSLuF2x4RoNanpmd1CYxGwbadYo27ec2271y7OEPRz4F5
	/bFq0f1lYG1YZXRWf2ZVVcVngKGiS9zRftDw0Sg3WdK5qMYV3lAOjKuFhFU+WP3NN6vEIWh
	cpszqtKcTeBXX9B75vkkwsayG2S/h7ZE+PicB6THit/PCZNuAr4pjRr9kiiduSjF1UEnuqM
	EELTyBjyhBkCGCT29DAJ/84egCyAXwaIVxB29kYqZbl/MMmYHkYqdJHZ35ryg34qrr4iLGw
	aooskt1zPvoS1oNjrvsQLSm6NNkxptK8JY4auhV/C1SoDRZ2gA0GlF+x6apfXWWYkwUlX19
	B4FYeZ3KGyUP315DXjLXwX70S52RSxhbguwnREJBbJ74ow3QZeEnyTAbcik02AFzLV9VFat
	o4lZX3ZZRNvS5w5HKt/7efyC/UQDK3x+VEITKn/01D3MyPLqx5hj9ELmgDXIG5U7jlxM5Ik
	SRm3p4IyOU7fak0oE/P2P4ByMCP35VToH/qU/fjaBc5zNkkGMS8OX0NIJpwr9J0aKXrERuR
	GBITiJ+pAXTpScZ/lrCS4iCD4Cj2LuphrKVlasCzyzu2Su0ubmgDUWpcoxn6F0ZfI6G5hso
	kkojaC6761yUBaM8w7Cz3kep0pWEuO1rYfRNp04WIigi9K9dUGz2TSjRn7/6m5uYTQ47134
	ts/XGe+n+BR07ausOsjjFKzaPEtm9rOt7e6qnYXQbzmLCeIcFbCi/SV80niiyiK3Bez+44m
	8gHaeknQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0



> On Oct 14, 2025, at 17:12, Jiri Slaby <jirislaby@kernel.org> wrote:
>=20
> On 27. 06. 25, 15:49, Tonghao Zhang wrote:
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
>> Note that, with multiple aggregators, the current broadcast mode
>> logic will send only packets to the selected aggregator(s).
>>  +-----------+   +-----------+
>>  |  switch1  |   |  switch2  |
>>  +-----------+   +-----------+
>>          ^           ^
>>          |           |
>>       +-----------------+
>>       |   bond4 lacp    |
>>       +-----------------+
>>          |           |
>>          | NIC1      | NIC2
>>       +-----------------+
>>       |     server      |
>>       +-----------------+
>=20
> Hi,
>=20
> this breaks broadcast bonding in 6.17. Reverting these three (the two =
depend on this one) makes 6.17 work again:
> 2f9afffc399d net: bonding: send peer notify when failure recovery
> 3d98ee52659c net: bonding: add broadcast_neighbor netlink option
> ce7a381697cb net: bonding: add broadcast_neighbor option for 802.3ad
>=20
> This was reported downstream as an error in our openQA:
> https://bugzilla.suse.com/show_bug.cgi?id=3D1250894
>=20
> I bisected using this in qemu:
> systemctl stop network
> ip link del bond0 || true
> ip link set dev eth0 down
> ip addr flush eth0
> ip link add bond0 type bond mode broadcast
> ip link set dev eth0 master bond0
> ip addr add 10.0.2.15/24 dev bond0
> ip link set bond0 up
> sleep 1
> exec nmap -sS 10.0.2.2/32
>=20
> Any ideas?
>=20
>> - =
https://www.ruijie.com/fr-fr/support/tech-gallery/de-stack-data-center-net=
work-architecture/
>> Cc: Jay Vosburgh <jv@jvosburgh.net>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Simon Horman <horms@kernel.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Nikolay Aleksandrov <razor@blackwall.org>
>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
>> ---
>> v8: add comments info in bond_option_mode_set, explain why we only
>> clear broadcast_neighbor to 0.
>> Note that selftest will be post after I post the iproute2 patch about
>> this option.
>> ---
>>  Documentation/networking/bonding.rst |  6 +++
>>  drivers/net/bonding/bond_main.c      | 66 =
+++++++++++++++++++++++++---
>>  drivers/net/bonding/bond_options.c   | 42 ++++++++++++++++++
>>  include/net/bond_options.h           |  1 +
>>  include/net/bonding.h                |  3 ++
>>  5 files changed, 112 insertions(+), 6 deletions(-)
> ...
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
> ...
>> @@ -5329,17 +5369,27 @@ static netdev_tx_t bond_3ad_xor_xmit(struct =
sk_buff *skb,
>>   return bond_tx_drop(dev, skb);
>>  }
>>  -/* in broadcast mode, we send everything to all usable interfaces. =
*/
>> +/* in broadcast mode, we send everything to all or usable slave =
interfaces.
>> + * under rcu_read_lock when this function is called.
>> + */
>>  static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
>> -       struct net_device *bond_dev)
>> +       struct net_device *bond_dev,
>> +       bool all_slaves)
>>  {
>>   struct bonding *bond =3D netdev_priv(bond_dev);
>> - struct slave *slave =3D NULL;
>> - struct list_head *iter;
>> + struct bond_up_slave *slaves;
>>   bool xmit_suc =3D false;
>>   bool skb_used =3D false;
>> + int slaves_count, i;
>>  - bond_for_each_slave_rcu(bond, slave, iter) {
>> + if (all_slaves)
>> + slaves =3D rcu_dereference(bond->all_slaves);
>> + else
>> + slaves =3D rcu_dereference(bond->usable_slaves);
>> +
>> + slaves_count =3D slaves ? READ_ONCE(slaves->count) : 0;
>=20
> OK, slaves_count is now 0 (slaves and bond->all_slaves are NULL), but =
bond_for_each_slave_rcu() used to yield 1 iface.
>=20
> Well, bond_update_slave_arr() is not called for broadcast AFAICS.
Thank you for pointing out this issue. We don't need to revert the =
patch. can you test if the following patch is useful to you. I will add =
test cases later.

diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
index a8034a561011..c950e1e7f284 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2384,7 +2384,8 @@ int bond_enslave(struct net_device *bond_dev, =
struct net_device *slave_dev,
                unblock_netpoll_tx();
        }

-       if (bond_mode_can_use_xmit_hash(bond))
+       if (bond_mode_can_use_xmit_hash(bond) ||
+           BOND_MODE(bond) =3D=3D BOND_MODE_BROADCAST)
                bond_update_slave_arr(bond, NULL);

        if (!slave_dev->netdev_ops->ndo_bpf ||
@@ -2560,7 +2561,8 @@ static int __bond_release_one(struct net_device =
*bond_dev,

        bond_upper_dev_unlink(bond, slave);

-       if (bond_mode_can_use_xmit_hash(bond))
+       if (bond_mode_can_use_xmit_hash(bond) ||
+           BOND_MODE(bond) =3D=3D BOND_MODE_BROADCAST)
                bond_update_slave_arr(bond, slave);

        slave_info(bond_dev, slave_dev, "Releasing %s interface\n",
>=20
>> + for (i =3D 0; i < slaves_count; i++) {
>> + struct slave *slave =3D slaves->arr[i];
>>   struct sk_buff *skb2;
>>     if (!(bond_slave_is_up(slave) && slave->link =3D=3D =
BOND_LINK_UP))
>> @@ -5577,10 +5627,13 @@ static netdev_tx_t __bond_start_xmit(struct =
sk_buff *skb, struct net_device *dev
>>   case BOND_MODE_ACTIVEBACKUP:
>>   return bond_xmit_activebackup(skb, dev);
>>   case BOND_MODE_8023AD:
>> + if (bond_should_broadcast_neighbor(skb, dev))
>> + return bond_xmit_broadcast(skb, dev, false);
>> + fallthrough;
>>   case BOND_MODE_XOR:
>>   return bond_3ad_xor_xmit(skb, dev);
>>   case BOND_MODE_BROADCAST:
>> - return bond_xmit_broadcast(skb, dev);
>> + return bond_xmit_broadcast(skb, dev, true);
>>   case BOND_MODE_ALB:
>>   return bond_alb_xmit(skb, dev);
>>   case BOND_MODE_TLB:
>> @@ -6456,6 +6509,7 @@ static int __init bond_check_params(struct =
bond_params *params)
>>   eth_zero_addr(params->ad_actor_system);
>>   params->ad_user_port_key =3D ad_user_port_key;
>>   params->coupled_control =3D 1;
>> + params->broadcast_neighbor =3D 0;
>>   if (packets_per_slave > 0) {
>>   params->reciprocal_packets_per_slave =3D
>>   reciprocal_value(packets_per_slave);
>=20
> --=20
> js
> suse labs
>=20
>=20


