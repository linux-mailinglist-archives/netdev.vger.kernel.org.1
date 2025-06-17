Return-Path: <netdev+bounces-198515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C08EADC89B
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 12:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48CAC18982C9
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 10:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485A228FFC7;
	Tue, 17 Jun 2025 10:47:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D81249F9
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750157266; cv=none; b=asNGkqCvrkU8ARxOQhdXcA5XkhjLkDQF33HrO+g9NgBjVoffAb/FzJUZFLl4SLODR0iUfi69gug+efev5193QPFu5iCzS2EhsLVcEHlWy6p5Y2r1XtEBlsd4gZXcITXex9oGsZmGO4O8m88au1lgFv55K2NjaiPkzJGUEZcPyvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750157266; c=relaxed/simple;
	bh=lI2EoODAv2obh/y8LDwqYLrt7yBfGYKBfC/2GlUSKw8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NOpXsqcHNzQ/k+DlPqJw+BU95MWwQqoDNq2FxG4Ic0o5AHR9nBBa7f52+ApwFx5HQ+xDjdQkfyEN1TyV3uFWKGWk8EEH4+CB++CElRm/oY40OUA4YYq/T6xc/XfDZGQN43ODwcInN5NnSyv+y8kZKZH00crQIFXaG57+c2Tggo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz20t1750157242t7f86ec17
X-QQ-Originating-IP: qIdkuJiAibx+te+KbbQs+IbX+82DxQDYcBo5W0hXMoU=
Received: from smtpclient.apple ( [111.202.70.102])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 17 Jun 2025 18:47:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7081300918054140560
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
In-Reply-To: <1931522.1750120618@famine>
Date: Tue, 17 Jun 2025 18:47:09 +0800
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
Message-Id: <EB500915-0C30-4491-8709-80894B771EC4@bamaicloud.com>
References: <cover.1749525581.git.tonghao@bamaicloud.com>
 <81185ef7f9227cff906903fe8e74258727529491.1749525581.git.tonghao@bamaicloud.com>
 <1931522.1750120618@famine>
To: Jay Vosburgh <jv@jvosburgh.net>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MO2H+njgaK7zWLbUjCKpE4sjPgqFrmnMzkfEydlzD57aH0eUsdNoOBNV
	rLzMKamMiCu1suUi9AqMj4ZAg/5aW6lVkLaVI3QXplHQ62xvCOaf2yk3Q0bmz/whXm/RIxP
	nlqy3Mfp0DVjKerlXPrnT3djR1znTJ6j145oNXlTDGWR7P1r6S4itlufUTZbW9D8ZFEZ9wQ
	VzDwzlm+J+PEnp854/ZUH4WHP004JLv2VfJgljxsNSl21W2LyKGevGFd0QNm7xZUizyY/tx
	M8s5k/MMu4ZGhNUn9hPST19UvPj35V3dCok2F9U9IC3L0L8jjjO65898W1RuJdhGPDf/8k3
	y4PNAdD0Hq+Nc8mJB0UR2OWnJonhUzgs3zTUzysBuIMC27iN58WNYrSecSIQTkd0za47wK5
	/HtkAT5PBzG1uwrWMtKLJ1VT+FPqkDhYsZNXYsuau5lWQQStMYgWrz44SAgrW2BMnT/aftj
	COh0/Hz3TtD0cVS4WgE4wLAuNx8z2U4WM2Sxy39tQn8kfcS42a7GFLp86g4dvi0fS/Z3qH7
	8tcASb3xWwVJLRC8mDBu6n8R6xicwqvL4GheidSxRQXLPxUi4bNfw1b3V4QgGdzHyf192Ks
	1lpQlhSEA0JCE6QWm1fNQhlvbIh8PUZ8Ro3wiuRkAK4nYDEBz+dYeb1AohPEqn9MQxV4tf0
	wymTqbefGEo91ji9u4uab+ctdLbzcTR7hhxNbrwAaEPOjUaYfxJDE41ap8VVXrESXO81Qxe
	pyMj/x4S9zwj7Y3AFk5GRbEp5Os17oQ/WGhWVmtir8Mw4brV5iEvNxIOSmbgCmLZUHSWHGh
	ou0YZz56lTHcp2/wetR0j4CsJ+7An023AQr8i9H+RwaUjc1F09HOjuBzy+DDfv7+xmYXV6D
	xOS17ldfhgfewATV/3w85Bi19wqGhxh52D4+cy2+YSCXQe2tri41vlqqSanvmwa9wlQHPnq
	HA5axBqW7/Z9S508hsseZapVF1jA35dfdNWDqNuxZxts0rMFd6GlUoaXovNUVLuy+f14=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B46=E6=9C=8817=E6=97=A5 08:36=EF=BC=8CJay Vosburgh =
<jv@jvosburgh.net> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Tonghao Zhang <tonghao@bamaicloud.com> wrote:
>=20
>> After LACP protocol recovery, the port can transmit packets.
>> However, if the bond port doesn't send gratuitous ARP/ND
>> packets to the switch, the switch won't return packets through
>> the current interface. This causes traffic imbalance. To resolve
>> this issue, when LACP protocol recovers, send ARP/ND packets.
>=20
> I think the description above needs to mention that the
> gratuitous ARP/ND only happens if broadcast_neighbor is enabled.
Ok, thanks
>=20
> I'll note that the documentation update does include this
> caveat.
>=20
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
>> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
>> ---
>> Documentation/networking/bonding.rst |  5 +++--
>> drivers/net/bonding/bond_3ad.c       | 13 +++++++++++++
>> drivers/net/bonding/bond_main.c      | 21 ++++++++++++++++-----
>> 3 files changed, 32 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/Documentation/networking/bonding.rst =
b/Documentation/networking/bonding.rst
>> index 14f7593d888d..f8f5766703d4 100644
>> --- a/Documentation/networking/bonding.rst
>> +++ b/Documentation/networking/bonding.rst
>> @@ -773,8 +773,9 @@ num_unsol_na
>> greater than 1.
>>=20
>> The valid range is 0 - 255; the default value is 1.  These options
>> - affect only the active-backup mode.  These options were added for
>> - bonding versions 3.3.0 and 3.4.0 respectively.
>> + affect the active-backup or 802.3ad (broadcast_neighbor enabled) =
mode.
>> + These options were added for bonding versions 3.3.0 and 3.4.0
>> + respectively.
>>=20
>> =46rom Linux 3.0 and bonding version 3.7.1, these notifications
>> are generated by the ipv4 and ipv6 code and the numbers of
>> diff --git a/drivers/net/bonding/bond_3ad.c =
b/drivers/net/bonding/bond_3ad.c
>> index c6807e473ab7..d1c2d416ac87 100644
>> --- a/drivers/net/bonding/bond_3ad.c
>> +++ b/drivers/net/bonding/bond_3ad.c
>> @@ -982,6 +982,17 @@ static int ad_marker_send(struct port *port, =
struct bond_marker *marker)
>> return 0;
>> }
>>=20
>> +static void ad_cond_set_peer_notif(struct port *port)
>> +{
>> + struct bonding *bond =3D port->slave->bond;
>> +
>> + if (bond->params.broadcast_neighbor && rtnl_trylock()) {
>> + bond->send_peer_notif =3D bond->params.num_peer_notif *
>> + max(1, bond->params.peer_notif_delay);
>> + rtnl_unlock();
>> + }
>> +}
>> +
>> /**
>> * ad_mux_machine - handle a port's mux state machine
>> * @port: the port we're looking at
>> @@ -2061,6 +2072,8 @@ static void =
ad_enable_collecting_distributing(struct port *port,
>> __enable_port(port);
>> /* Slave array needs update */
>> *update_slave_arr =3D true;
>> + /* Should notify peers if possible */
>> + ad_cond_set_peer_notif(port);
>> }
>> }
>>=20
>> diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
>> index 12046ef51569..0acece55d9cb 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -1237,17 +1237,28 @@ static struct slave =
*bond_find_best_slave(struct bonding *bond)
>> /* must be called in RCU critical section or with RTNL held */
>> static bool bond_should_notify_peers(struct bonding *bond)
>> {
>> - struct slave *slave =3D =
rcu_dereference_rtnl(bond->curr_active_slave);
>> + struct bond_up_slave *usable;
>> + struct slave *slave =3D NULL;
>>=20
>> - if (!slave || !bond->send_peer_notif ||
>> + if (!bond->send_peer_notif ||
>>     bond->send_peer_notif %
>>     max(1, bond->params.peer_notif_delay) !=3D 0 ||
>> -     !netif_carrier_ok(bond->dev) ||
>> -     test_bit(__LINK_STATE_LINKWATCH_PENDING, &slave->dev->state))
>> +     !netif_carrier_ok(bond->dev))
>> return false;
>>=20
>> + if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD) {
>> + usable =3D rcu_dereference_rtnl(bond->usable_slaves);
>> + if (!usable || !READ_ONCE(usable->count))
>> + return false;
>> + } else {
>> + slave =3D rcu_dereference_rtnl(bond->curr_active_slave);
>> + if (!slave || test_bit(__LINK_STATE_LINKWATCH_PENDING,
>> +        &slave->dev->state))
>> + return false;
>> + }
>> +
>> netdev_dbg(bond->dev, "bond_should_notify_peers: slave %s\n",
>> -    slave ? slave->dev->name : "NULL");
>> +    slave ? slave->dev->name : "all");
>=20
> Is it actually correct that if slave =3D=3D NULL, the notify peers
> logic will send to all ports?  I'm not sure why this changed.
when bond is lacp mode, and send_peer_notif > 0, usable_slaves > 0, then =
slave =3D=3D NULL, the debug log will print info =
"bond_should_notify_peers: slave all".
In active-backup mode, slave is not NULL, that means =
"bond_should_notify_peers: slave xx".
>=20
> -J
>=20
>>=20
>> return true;
>> }
>> --=20
>> 2.34.1
>=20
> ---
> -Jay Vosburgh, jv@jvosburgh.net



