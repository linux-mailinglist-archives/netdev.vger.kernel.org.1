Return-Path: <netdev+bounces-198870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95497ADE154
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 04:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29BBB3A6C42
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 02:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B39F19ABD8;
	Wed, 18 Jun 2025 02:51:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9571362
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 02:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750215114; cv=none; b=DI22LwDV6m5ORR5887nUSjrDWavOFq5j30hCYZh+4ZeVk76HKuK8Z1hkRo63uwYZeDmlm/1HNCdXp8AmEjHzJa2+h6YVTo6TlMZUd37JaXaPr6/Z172yv0VbdpSlGleZ2oaAts/NSFwbA9Jo+2ATVRyjlhWEF6XiYaviL3FAhJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750215114; c=relaxed/simple;
	bh=MTVoepGA2bU5+9DVGVybnu74QmSYhMqMOC33sonpZuU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qqzYQc+LV9WhQ+j5715movy5+l0G6p/mdqooLWTfluK1XTz01e3jADhd5MUHITQmJxjPGMxd8kZv49ETLFeEkdNuZkw2TVe5HKctvGEfRxp8A84XzdKyBRFF/C9XOcAXVnjMaPTgZyw8mloWU2JiG8BTcjbnxsJhwJQlRp8zNec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz19t1750215079t7e8ccb33
X-QQ-Originating-IP: AwZffk67UxyUF3Gg1ck1wLfvY4prhgJ4Z3yMeGAk4Wo=
Received: from smtpclient.apple ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 18 Jun 2025 10:51:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5899331096075746589
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [net-next v6 3/4] net: bonding: send peer notify when failure
 recovery
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <5FC20461-E971-4469-B4D5-CEFB3B61CB44@bamaicloud.com>
Date: Wed, 18 Jun 2025 10:51:07 +0800
Cc: netdev@vger.kernel.org,
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
Message-Id: <C46140E5-35E2-49A2-8E58-FB3AC49AA53E@bamaicloud.com>
References: <cover.1749525581.git.tonghao@bamaicloud.com>
 <81185ef7f9227cff906903fe8e74258727529491.1749525581.git.tonghao@bamaicloud.com>
 <1931522.1750120618@famine>
 <EB500915-0C30-4491-8709-80894B771EC4@bamaicloud.com>
 <5FC20461-E971-4469-B4D5-CEFB3B61CB44@bamaicloud.com>
To: jv@jvosburgh.net
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NlEsy1tNGypZpSZTIDUkfahE1N8fnFH28Fb87ebqxVyVefoqUyMJ7noC
	trKFDIWwyd7SXjA9f+JUgH/m/HsRwiIt10SduMqUZKff1S1QPMZ7oHhUiqxkCNfVSEX41om
	pgL2wv3g22UGZPGvSELlLTFSAA8iWrg/6XYzldMbdN0+M8NsmcPn+g1Xqqlp1pT7dMI2jri
	+an52s4ZD4wCQi6B0jGpE+1QaHC0znC+Aki/cp+JDvL7yXCj8sd/JrLf7HGsb7EQHRTM0A3
	40P+8PGmhOfwZ1udV4zv+FBUHkKWARGaLKci9+fPS5AVzF9eYz5eQuXbv6XNZyrjKMfrUBL
	SufNvWd5oYY574V8r286eF1zvfESznUKAZaJrEwBaVvS8TSL9gOIPQ8pSm4KY7+tlXygPz7
	gfk9zg2Mo2ngs1Q4yvvH42TDdissSKhgXRBdj5r9hAnfzBZkYo/3ZxOftETMTPFMHNQ0rYQ
	mIJsiyl7rlolghY21tC821jq92P6tNHPPzCbCx0V9T7ao81bOOK6t9ojR3WIx4JWHhZiY07
	SFnVmzTU1HB+k8hEq3keBib2WPMGESiDWLX8ccdAi/AswDA43Kfg67ONSWIvkGRzYkZiPGD
	PdIfAkwVhNMmTqRlE2QfDh8wRR2H/JbcvJtbH1f+mOlutiSBY5ELqD684ubuGce/ntLg9xY
	h8oFBD572UPnsJJov+/F08HUWaYhmtk/BhYWpVC1Jte0PkGbFDoX4wUbd1GmUdXL8/2B8Me
	8D0zCU20kShPwOgZe87pehSmOUN8rSSm5qRUKqXx/9TtQsbGw9eK/V97BvVQBFx6vRUs2xq
	0GBZo4OWnR32b5lnT63m678yJrLZMivuKaxXa0zv2H6WzLF7BlTvyKFBqpM5A0JD/EHF8MC
	A3uCU0WUuHuDyKDYix/etpBsbKy7fS5KOBojR6zCEXRpV3LTl7VTxbVrNU7e8OFbkZ367J3
	c6lWg4UtMwy+WNCMWVgFT5boDmoWMXizuBbg=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B46=E6=9C=8817=E6=97=A5 19:39=EF=BC=8CTonghao Zhang =
<tonghao@bamaicloud.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>>=20
>> 2025=E5=B9=B46=E6=9C=8817=E6=97=A5 18:47=EF=BC=8CTonghao Zhang =
<tonghao@bamaicloud.com> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>>=20
>>=20
>>> 2025=E5=B9=B46=E6=9C=8817=E6=97=A5 08:36=EF=BC=8CJay Vosburgh =
<jv@jvosburgh.net> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> Tonghao Zhang <tonghao@bamaicloud.com> wrote:
>>>=20
>>>> After LACP protocol recovery, the port can transmit packets.
>>>> However, if the bond port doesn't send gratuitous ARP/ND
>>>> packets to the switch, the switch won't return packets through
>>>> the current interface. This causes traffic imbalance. To resolve
>>>> this issue, when LACP protocol recovers, send ARP/ND packets.
>>>=20
>>> I think the description above needs to mention that the
>>> gratuitous ARP/ND only happens if broadcast_neighbor is enabled.
>> Ok, thanks
>>>=20
>>> I'll note that the documentation update does include this
>>> caveat.
>>>=20
>>>> Cc: Jay Vosburgh <jv@jvosburgh.net>
>>>> Cc: "David S. Miller" <davem@davemloft.net>
>>>> Cc: Eric Dumazet <edumazet@google.com>
>>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>>> Cc: Simon Horman <horms@kernel.org>
>>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>>>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>> Cc: Nikolay Aleksandrov <razor@blackwall.org>
>>>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>>>> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
>>>> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
>>>> ---
>>>> Documentation/networking/bonding.rst |  5 +++--
>>>> drivers/net/bonding/bond_3ad.c       | 13 +++++++++++++
>>>> drivers/net/bonding/bond_main.c      | 21 ++++++++++++++++-----
>>>> 3 files changed, 32 insertions(+), 7 deletions(-)
>>>>=20
>>>> diff --git a/Documentation/networking/bonding.rst =
b/Documentation/networking/bonding.rst
>>>> index 14f7593d888d..f8f5766703d4 100644
>>>> --- a/Documentation/networking/bonding.rst
>>>> +++ b/Documentation/networking/bonding.rst
>>>> @@ -773,8 +773,9 @@ num_unsol_na
>>>> greater than 1.
>>>>=20
>>>> The valid range is 0 - 255; the default value is 1.  These options
>>>> - affect only the active-backup mode.  These options were added for
>>>> - bonding versions 3.3.0 and 3.4.0 respectively.
>>>> + affect the active-backup or 802.3ad (broadcast_neighbor enabled) =
mode.
>>>> + These options were added for bonding versions 3.3.0 and 3.4.0
>>>> + respectively.
>>>>=20
>>>> =46rom Linux 3.0 and bonding version 3.7.1, these notifications
>>>> are generated by the ipv4 and ipv6 code and the numbers of
>>>> diff --git a/drivers/net/bonding/bond_3ad.c =
b/drivers/net/bonding/bond_3ad.c
>>>> index c6807e473ab7..d1c2d416ac87 100644
>>>> --- a/drivers/net/bonding/bond_3ad.c
>>>> +++ b/drivers/net/bonding/bond_3ad.c
>>>> @@ -982,6 +982,17 @@ static int ad_marker_send(struct port *port, =
struct bond_marker *marker)
>>>> return 0;
>>>> }
>>>>=20
>>>> +static void ad_cond_set_peer_notif(struct port *port)
>>>> +{
>>>> + struct bonding *bond =3D port->slave->bond;
>>>> +
>>>> + if (bond->params.broadcast_neighbor && rtnl_trylock()) {
>>>> + bond->send_peer_notif =3D bond->params.num_peer_notif *
>>>> + max(1, bond->params.peer_notif_delay);
>>>> + rtnl_unlock();
>>>> + }
>>>> +}
>>>> +
>>>> /**
>>>> * ad_mux_machine - handle a port's mux state machine
>>>> * @port: the port we're looking at
>>>> @@ -2061,6 +2072,8 @@ static void =
ad_enable_collecting_distributing(struct port *port,
>>>> __enable_port(port);
>>>> /* Slave array needs update */
>>>> *update_slave_arr =3D true;
>>>> + /* Should notify peers if possible */
>>>> + ad_cond_set_peer_notif(port);
>>>> }
>>>> }
>>>>=20
>>>> diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
>>>> index 12046ef51569..0acece55d9cb 100644
>>>> --- a/drivers/net/bonding/bond_main.c
>>>> +++ b/drivers/net/bonding/bond_main.c
>>>> @@ -1237,17 +1237,28 @@ static struct slave =
*bond_find_best_slave(struct bonding *bond)
>>>> /* must be called in RCU critical section or with RTNL held */
>>>> static bool bond_should_notify_peers(struct bonding *bond)
>>>> {
>>>> - struct slave *slave =3D =
rcu_dereference_rtnl(bond->curr_active_slave);
>>>> + struct bond_up_slave *usable;
>>>> + struct slave *slave =3D NULL;
>>>>=20
>>>> - if (!slave || !bond->send_peer_notif ||
>>>> + if (!bond->send_peer_notif ||
>>>>   bond->send_peer_notif %
>>>>   max(1, bond->params.peer_notif_delay) !=3D 0 ||
>>>> -     !netif_carrier_ok(bond->dev) ||
>>>> -     test_bit(__LINK_STATE_LINKWATCH_PENDING, &slave->dev->state))
>>>> +     !netif_carrier_ok(bond->dev))
>>>> return false;
>>>>=20
>>>> + if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD) {
>>>> + usable =3D rcu_dereference_rtnl(bond->usable_slaves);
>>>> + if (!usable || !READ_ONCE(usable->count))
>>>> + return false;
>>>> + } else {
>>>> + slave =3D rcu_dereference_rtnl(bond->curr_active_slave);
>>>> + if (!slave || test_bit(__LINK_STATE_LINKWATCH_PENDING,
>>>> +        &slave->dev->state))
>>>> + return false;
>>>> + }
>>>> +
>>>> netdev_dbg(bond->dev, "bond_should_notify_peers: slave %s\n",
>>>> -    slave ? slave->dev->name : "NULL");
>>>> +    slave ? slave->dev->name : "all");
>>>=20
>>> Is it actually correct that if slave =3D=3D NULL, the notify peers
>>> logic will send to all ports?  I'm not sure why this changed.
>> when bond is lacp mode, and send_peer_notif > 0, usable_slaves > 0, =
then slave =3D=3D NULL, the debug log will print info =
"bond_should_notify_peers: slave all=E2=80=9D.
> In lacp mode, when broadcast_neighbor enabled, send_peer_notif will be =
set in ad_cond_set_peer_notif.
Hi Jay
This patch is ok? Or delete the debug info if you're confused. I think =
this is correct and useful to debug notify peers function.
>>=20
>> In active-backup mode, slave is not NULL, that means =
"bond_should_notify_peers: slave xx".
>>>=20
>>> -J
>>>=20
>>>>=20
>>>> return true;
>>>> }
>>>> --=20
>>>> 2.34.1
>>>=20
>>> ---
>>> -Jay Vosburgh, jv@jvosburgh.net



