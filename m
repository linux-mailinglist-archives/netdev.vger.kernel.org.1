Return-Path: <netdev+bounces-189683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04D6AB32EC
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238D617B631
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 09:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F58725B1F5;
	Mon, 12 May 2025 09:18:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB8025B1F0
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041518; cv=none; b=O+GqjG6sakPZRkYfldyIsna82Zhy7UA/GbCXKG+ZKvKKRb4VrCsyJqYqGXQPO2mIZ8x+DVbBbBMKe4kuwcGCiRrBVoSbeMkSovZCnzfEcYstupyM006HGpwgldVFc6TL4B2Cn8q4uuHRBeiaJ90HawG3qDh7Ox328XmevFGS8B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041518; c=relaxed/simple;
	bh=z2r/JSkMTJ/RpJOx2YTwl4/qPx1LtAmF5zJO4hmLOR0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MesgzhcZQtpTfIm/z0nQecXcVLVjSWI2QC7d63OQ7HD7UKDyG0jQdYd/mQ95UHhw9NR8EIkNFeAQN+tLgJTIfM3nE4CezmSvMUeJ3Nwo1mILUiN7jE4nIoce4nCWsdY+MIxZfqK89pMtZfNBXgnH1pOuHfENSgJo6qcn0/wTScU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz17t1747041416t9423537d
X-QQ-Originating-IP: VrRdmXoGwaUeSybyqInbGnuDrkBEmTA+vYpE9nYQc5E=
Received: from smtpclient.apple ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 12 May 2025 17:16:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10680834972335136140
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH net-next 3/4] net: bonding: send peer notify when failure
 recovery
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <aCGr1hLEUng-b-UD@fedora>
Date: Mon, 12 May 2025 17:16:53 +0800
Cc: netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8B7BCD9B-7400-4D6A-A582-0A9A9E2A2A1C@bamaicloud.com>
References: <20250510044504.52618-1-tonghao@bamaicloud.com>
 <20250510044504.52618-4-tonghao@bamaicloud.com> <aCGr1hLEUng-b-UD@fedora>
To: Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MyirvGjpKb1jMGgibuydo5alC21K06EK6Hw9oJNmTiK3+zfIVB58CZXA
	0k8alldt+zhZAuVeYaid56m9XURPoopP9BCkuUFoz3BemxcAJIVBR0BSLv/1Im2cuy7iyQ+
	71ttrXgzp8xTjU4mhJcEa2wcatsGlyDgaCH23xcsQKeHYnGz7ounPq7wnt0SlA65guBtM68
	2GByKt9S5NDXbqjQFuDWz2i9meQtmYqjfBwxUufmLEba1fjbExh+G2MlErYewRsLN2kNWpe
	2VLhhTvb7zaAxNIXA9IffwBgl+40XPPede/bVzrg+jN3q1QA1vJ/9cxwnWvXl9I95WOzp11
	Kt35jJNNxVUtmLW6vcJazwCUjl4b+8b+K4cLS9qkig8t40kliD7GpRXf7929mq0bMQ7T/2Q
	QhXfeXpPLSk5Vgx3LpCXJeUCg2X0A0yicMT61FoeCp05lb/Ti29rgda1vss9LhjBFxHZ2v8
	tqS9yeO+ZbP1MyKd+DBta7sT0EaA9BWMJog0xslL0xPkTp7bvsSuGZQjSwlUBIhE5Q+ILry
	+VqXulRGrj5ftjL7azlHfhsAMRdrP0Q/IOhz2Z7WBP5OKBY+/kOfsCoTdybk/sjU3UJZIqA
	jbS6aQpTOAZXqzFSTvqqyV7OjjFKrcz2W6l/3hyDfn9dj/t5i1f38KAIJbwrZEoKTe9tLwu
	qnzvjnI5oYGG/KUs6UgkF1VIKgWhfKsryX8w4oivoMfpS0XWrp422LJqZPFQIhYeDxNghh9
	MZWQNSJErjWpGGtT4NUhGqxdUmpKdKYiz0z2sgQxXiKl3LBP7Ysw48UeoF2bMerRJNgpgq3
	nTyAMyFVygNIWs3i5+wa+kOblA/WyJ14H5VKDlBpeyk+ObHj3ecFMqgGYjnOlrjl4tYdDSn
	iQKZwjand9xsQaCXzchOuXkZ31YpeU8/7IsweW85L6UY2Z1u/VB96vGnJyAoIg5nKhv4Rxg
	UzS56qm9QI0Ag82IZWIeb3NwFwBf+pxYxx+76oX4DmDH4Wn05zvJF2PSE
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B45=E6=9C=8812=E6=97=A5 =E4=B8=8B=E5=8D=884:05=EF=BC=8CHangbi=
n Liu <liuhangbin@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi Tonghao,
> On Sat, May 10, 2025 at 12:45:03PM +0800, tonghao@bamaicloud.com =
wrote:
>> From: Tonghao Zhang <tonghao@bamaicloud.com>
>>=20
>> While hardware failures in NICs, optical transceivers, or switches
>> are unavoidable, rapid system recovery can be achieved =
post-restoration.
>> For example, triggering immediate ARP/ND packet transmission upon
>> LACP failure recovery enables the system to swiftly resume normal
>> operations, thereby minimizing service downtime.
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
>> ---
>> drivers/net/bonding/bond_3ad.c | 14 ++++++++++++++
>> 1 file changed, 14 insertions(+)
>>=20
>> diff --git a/drivers/net/bonding/bond_3ad.c =
b/drivers/net/bonding/bond_3ad.c
>> index c6807e473ab7..6577ce54d115 100644
>> --- a/drivers/net/bonding/bond_3ad.c
>> +++ b/drivers/net/bonding/bond_3ad.c
>> @@ -982,6 +982,19 @@ static int ad_marker_send(struct port *port, =
struct bond_marker *marker)
>> 	return 0;
>> }
>>=20
>> +static void ad_peer_notif_send(struct port *port)
>> +{
>> +	if (!port->aggregator->is_active)
>> +		return;
>> +
>> +	struct bonding *bond =3D port->slave->bond;
>> +	if (bond->params.broadcast_neighbor && rtnl_trylock()) {
>> +		bond->send_peer_notif =3D bond->params.num_peer_notif *
>> +			max(1, bond->params.peer_notif_delay);
>> +		rtnl_unlock();
>> +	}
>> +}
>> +
>> /**
>>  * ad_mux_machine - handle a port's mux state machine
>>  * @port: the port we're looking at
>> @@ -1164,6 +1177,7 @@ static void ad_mux_machine(struct port *port, =
bool *update_slave_arr)
>> 			port->actor_oper_port_state |=3D =
LACP_STATE_COLLECTING;
>> 			port->actor_oper_port_state |=3D =
LACP_STATE_DISTRIBUTING;
>> 			port->actor_oper_port_state |=3D =
LACP_STATE_SYNCHRONIZATION;
>> +			ad_peer_notif_send(port);
>> 			ad_enable_collecting_distributing(port,
>> 							  =
update_slave_arr);
>> 			port->ntt =3D true;
>=20
> Maybe enable notify after collecting/distributing?
Yes, The same suggestion was provided by Jay. V2:

diff --git a/Documentation/networking/bonding.rst =
b/Documentation/networking/bonding.rst
index 14f7593d888d..f8f5766703d4 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -773,8 +773,9 @@ num_unsol_na
 	greater than 1.

 	The valid range is 0 - 255; the default value is 1.  These =
options
-	affect only the active-backup mode.  These options were added =
for
-	bonding versions 3.3.0 and 3.4.0 respectively.
+	affect the active-backup or 802.3ad (broadcast_neighbor enabled) =
mode.
+	These options were added for bonding versions 3.3.0 and 3.4.0
+	respectively.

 	=46rom Linux 3.0 and bonding version 3.7.1, these notifications
 	are generated by the ipv4 and ipv6 code and the numbers of
diff --git a/drivers/net/bonding/bond_3ad.c =
b/drivers/net/bonding/bond_3ad.c
index c6807e473ab7..d1c2d416ac87 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -982,6 +982,17 @@ static int ad_marker_send(struct port *port, struct =
bond_marker *marker)
 	return 0;
 }

+static void ad_cond_set_peer_notif(struct port *port)
+{
+	struct bonding *bond =3D port->slave->bond;
+
+	if (bond->params.broadcast_neighbor && rtnl_trylock()) {
+		bond->send_peer_notif =3D bond->params.num_peer_notif *
+			max(1, bond->params.peer_notif_delay);
+		rtnl_unlock();
+	}
+}
+
 /**
  * ad_mux_machine - handle a port's mux state machine
  * @port: the port we're looking at
@@ -2061,6 +2072,8 @@ static void =
ad_enable_collecting_distributing(struct port *port,
 		__enable_port(port);
 		/* Slave array needs update */
 		*update_slave_arr =3D true;
+		/* Should notify peers if possible */
+		ad_cond_set_peer_notif(port);
 	}
 }

diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
index 342f2dc64116..ce31445e85b6 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1240,17 +1240,31 @@ static struct slave *bond_find_best_slave(struct =
bonding *bond)
 /* must be called in RCU critical section or with RTNL held */
 static bool bond_should_notify_peers(struct bonding *bond)
 {
-	struct slave *slave =3D =
rcu_dereference_rtnl(bond->curr_active_slave);
+	struct bond_up_slave *slaves;
+	struct slave *slave =3D NULL;
+
+	if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD) {
+		if (!bond->params.broadcast_neighbor)
+			return false;
+
+		slaves =3D rtnl_dereference(bond->usable_slaves);
+		if (!slaves || !READ_ONCE(slaves->count))
+			return false;
+	} else {
+		slave =3D rcu_dereference_rtnl(bond->curr_active_slave);
+		if (!slave || test_bit(__LINK_STATE_LINKWATCH_PENDING,
+				       &slave->dev->state))
+			return false;
+	}

-	if (!slave || !bond->send_peer_notif ||
+	if (!bond->send_peer_notif ||
 	    bond->send_peer_notif %
 	    max(1, bond->params.peer_notif_delay) !=3D 0 ||
-	    !netif_carrier_ok(bond->dev) ||
-	    test_bit(__LINK_STATE_LINKWATCH_PENDING, =
&slave->dev->state))
+	    !netif_carrier_ok(bond->dev))
 		return false;

 	netdev_dbg(bond->dev, "bond_should_notify_peers: slave %s\n",
-		   slave ? slave->dev->name : "NULL");
+		   slave ? slave->dev->name : "all");

 	return true;
 }
--
2.34.1

>=20
> And also please rebase to latest net-next. There is another switch =
case
> AD_MUX_DISTRIBUTING that enables collecting/distributing, which should
> also send notify.
>=20
> Thanks
> Hangbin
>=20
>=20


