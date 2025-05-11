Return-Path: <netdev+bounces-189545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA0BAB2927
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 16:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8254C3B608B
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 14:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045C41D8A10;
	Sun, 11 May 2025 14:36:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7629D2580FF
	for <netdev@vger.kernel.org>; Sun, 11 May 2025 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746974203; cv=none; b=A2etjAioG/jezX7alZXUSMFwnukjELcOfj4PO4KT+o07GVHRwIL5q+xiKdX8z41mNYjR5G1rufK/a6Xt/QnVVKZ7go3Q5Yji89C97cLM+fgPeACyUfIeclAI+oGLgybkwLBMoa2C37VD4RKjLS5HMDFx5oiRv/iB9I/MYRSHd20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746974203; c=relaxed/simple;
	bh=PE9DCVgSqMMp9h0a16kPcB7epKdEhBzYnglzspDXIF0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CjW4h+lktw6LP6zHx/w6ZzxR3bvFoCGOdtEf+GA80idPAqycf9S2bG2vgkF0snK0irj5yIECoqJu4/C7R/I6v/McStOzGecurFrYO2KEvvBHPanTF/39NE0dQnP3kRVzZAnwGUO6qjWQgMqy7G4HQHiWzSt+IPZ5Xs9NcAG22o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz9t1746974064t8e3333de
X-QQ-Originating-IP: qAiaizxjPEMRwCgOSreS1pFAmsgko/sX+nbMvjvpSGA=
Received: from smtpclient.apple ( [111.201.145.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 11 May 2025 22:34:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6622796578644939508
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
In-Reply-To: <1133780.1746882081@vermin>
Date: Sun, 11 May 2025 22:34:17 +0800
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Content-Transfer-Encoding: quoted-printable
Message-Id: <82317367-CCF4-4E21-84B1-911F8388E3E7@bamaicloud.com>
References: <20250510044504.52618-1-tonghao@bamaicloud.com>
 <20250510044504.52618-4-tonghao@bamaicloud.com> <1133780.1746882081@vermin>
To: Jay Vosburgh <jv@jvosburgh.net>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NGzHPHPeapzDfRSZakUkq/uyLvhkrINAEcDCncPYdAGLA54Hnz5bye4K
	dHvDVtrSozn0fO6oDaJcTM2duRJv6JKy0vZUBS+CxPMwvqUxE7TUb9M/U/vyVf263RgNE5I
	QRBYRIc2enYO+Z5EEzpHt2kPRd55mbkJXLkFdYba1WBLLb2xjbpsMQsSVyg1/ZY4azqAZ9s
	SiBi/K7L9EIhyX/3FAQiiZnasRs1UuJlWzk5Scq1fXUG7KJRbyyy4Pv64TciKjcVWENk/yA
	p59AST7GN+FVnT1UAWp4+Inp/2sc2fLGseNxDDuahcXgBPlEpdqpZmg6w5SPv9ORxNeZkTa
	Mlt/rLLgffLCT5eR+cTDQUPXgFBcEHaYOkuQZXCEFq1sxdTa/N5rbQrTeBd9wEKbXEpBTyU
	VYlhPlA5xRf15aByqZm8JWhOeDzN0BjoPsBKFoR4xjKcrziYYVfyH77vmw5gOQ695h6N/vv
	e75Q1xoACS3G6pGA68gej51KDil0OvH3lS/hPXbaGklz+urORcLxuc6Y6YhsjlVCjCJecW5
	duogY/vvW0rYk5qslfbgscXeLWaDuGtPHM5UNC0y9OAa9V8yz2KAgI5dFVFzTTCweDzFTfC
	TLnkpIAOYbD6vwyxj6J6UfUAJC8AEbeuGzZeJd81Fze05t0nD7U4E04j1cNh1LyXCS42drv
	87LQjM+N6jlZtuF2TGAEhiUKF1qNxc6RTl7rwCNzz68o8HV5/0snw9/mHkZkWjp19xr68v5
	lOdzwhgeHaq2U/+aALV/4NcWPcAeZymb3qU40+9gpbVHTohec7WK4ERtyZU5bf/9SWex0O2
	/LdPculJgk+lfWy5iJuHRhqiQN0KpCMWzP2ehk61GxfW2LvULwaiCv/jlFpmM+kv16IhlBJ
	BkuBH8WhjjLKIXNAoWl47oax5HMsMPOYcvUC06/1pEfSl2pMGkHiiNx8p+3RDJkPqIH0W7Z
	4nHAE+gLvGyCB/9c61xeT2g2/I8UuOdqpI+o=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B45=E6=9C=8810=E6=97=A5 =E4=B8=8B=E5=8D=889:01=EF=BC=8CJay =
Vosburgh <jv@jvosburgh.net> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> tonghao@bamaicloud.com wrote:
>=20
>> From: Tonghao Zhang <tonghao@bamaicloud.com>
>>=20
>> While hardware failures in NICs, optical transceivers, or switches
>> are unavoidable, rapid system recovery can be achieved =
post-restoration.
>> For example, triggering immediate ARP/ND packet transmission upon
>> LACP failure recovery enables the system to swiftly resume normal
>> operations, thereby minimizing service downtime.
>=20
> 	I think this comment needs to be prefaced with something that
> explains that this logic is for the "no stack" architecture.  It don't
> need the entire blurb about what that is, though.
Ok, Update the commit message in v2.
>=20
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
>=20
> 	I'm not a fan of the function name, as this doesn't actually
> send any notifications.  Perhaps "ad_cond_set_peer_notif"?  I.e.,
> conditionally set peer notifications on?
>=20
>> /**
>> * ad_mux_machine - handle a port's mux state machine
>> * @port: the port we're looking at
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
> 	This is in the AD_MUX_COLLECTING_DISTRIBUTING case, I think you
> need another one of these in the AD_MUX_DISTRIBUTING case a few lines
> further down to handle the situation when coupled_control is disabled.
pretty good, moving the ad_cond_set_peer_notif to =
ad_enable_collecting_distributing makes more sense.

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
+       struct bonding *bond =3D port->slave->bond;
+
+       if (bond->params.broadcast_neighbor && rtnl_trylock()) {
+               bond->send_peer_notif =3D bond->params.num_peer_notif *
+                       max(1, bond->params.peer_notif_delay);
+               rtnl_unlock();
+       }
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
+               /* Should notify peers if possible */
+               ad_cond_set_peer_notif(port);
        }
 }


By the way, bond_should_notify_peers should check =
params.broadcast_neighbor, because curr_active_slave may be NULL. In my =
test environment, ip li set slave-ethx down and when up again, =
bond_change_active_slave will set bond->curr_active_slave in lacp mode.

static bool bond_should_notify_peers(struct bonding *bond)
{
        struct bond_up_slave *slaves;
        struct slave *slave =3D NULL;

        if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD) {
                if (!bond->params.broadcast_neighbor)
                        return false;

                slaves =3D rtnl_dereference(bond->usable_slaves);
                if (!slaves || !READ_ONCE(slaves->count))
                        return false;
        } else {
                slave =3D rcu_dereference_rtnl(bond->curr_active_slave);
                if (!save || test_bit(__LINK_STATE_LINKWATCH_PENDING,
                                      &slave->dev->state))
                        return false;
        }

        if (!bond->send_peer_notif ||
            bond->send_peer_notif %
            max(1, bond->params.peer_notif_delay) !=3D 0 ||
            !netif_carrier_ok(bond->dev))
                return false;

        netdev_dbg(bond->dev, "bond_should_notify_peers: slave %s\n",
                   slave ? slave->dev->name : "all");

        return true;
}

>=20
> 	-J
>=20
>> --=20
>> 2.34.1
>>=20
>=20
> ---
> 	-Jay Vosburgh, jv@jvosburgh.net


