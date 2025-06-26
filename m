Return-Path: <netdev+bounces-201397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48243AE9476
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 04:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA0C1C27D82
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 02:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A15EEDE;
	Thu, 26 Jun 2025 02:58:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C43573451
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 02:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750906729; cv=none; b=Oa+ezPkS5Li8f8n63FMXuMFbZ68LgLxneXD8qaTcYxq3jUuiQgNSX5tS15JCxYTA5r7QBwvaaGsVh/Xyq9NU9Y3c1xCXwWmRIgChlZa/6mNEI/4/wjRYWpWIeBo3YeBNZALYEhHMD3B6vj/q0vnJ4VWdjY75AHM1DcxWbuzoJNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750906729; c=relaxed/simple;
	bh=OBqjJZhZeRPnDgb/EP+AF5bAMmAxKia3QJtNrLKoIb0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qRkTnaGb9q8h11y3iE6gbQzObLPR8jA+OuSc40W6AjpGQF+JT6yYNmDlUR63wqJoJxaaMomUb51WlPG3tvjWEZmsMX6+lpjjg2/5lh64NTx0GelMoSVbr2CUvet6gp3uuN4cfo4iOcHSloTpXbziU0OE1mg8sF0vrx7r+mRAhDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz9t1750906688tab4862a9
X-QQ-Originating-IP: +biMiPwQNTyweX21nkkMDRenvdfo7rG/lVm1Gh+WX1Y=
Received: from smtpclient.apple ( [111.202.70.102])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Jun 2025 10:58:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8340976094346290771
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [net-next v6 4/4] net: bonding: add tracepoint for 802.3ad
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <2482590.1750794203@famine>
Date: Thu, 26 Jun 2025 10:57:56 +0800
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
Message-Id: <3EBEA7DD-A040-420D-9420-8211BACC0388@bamaicloud.com>
References: <cover.1749525581.git.tonghao@bamaicloud.com>
 <10b8f570bd59104a1c7d5ecdc9a82c6ec61d2d1c.1749525581.git.tonghao@bamaicloud.com>
 <1931181.1750120130@famine>
 <C75C5F1F-544F-4613-91D9-4F876EF286B3@bamaicloud.com>
 <8DB4F573-128C-4A2D-A4D0-3909586AFF8C@bamaicloud.com>
 <2482590.1750794203@famine>
To: Jay Vosburgh <jv@jvosburgh.net>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N2v4nqiyABSwTPlEa1K1on9sVFXDSzGaiw86RWaJzGpzXDoM6dUyV7AJ
	RWIdyubISJ0C1edNiEL/cfEBcXlHNvDr5GglIsCFw2yhwKK1n6H4TMQ4suQ3u6rzql2123C
	dvPiisuyhkTDMJiBujoAWS3+95aHpFIw+jgqp58n0QQ/10NIirEZ9NVijh0Efm/Mz2Xyt2B
	lRYuC4x9wJDh0uApUZDjBKx1B9W82cnl9yuhqQcipv02/kJdYQ5DmnKPTzXMaop00yRJDVC
	hcnpQbEBvhyjlDL/RvXu+j3F5/Gi5yJWErhR22O8un/GB0Gu9tNVSLklnLriTFzWFXC0e5D
	SDD1iwgNQ/WkHXwxDJ+COAXFIzCBGyBCGanQjLxSaSod017WoGhtN9qceamqkRiXQnuuh8m
	tL1k9oB6ab8BCci4qozlhx5Y8B7Zym32x/BW58g9rTIpnAUnvkp6Xl1yIRmL5TaVxSOiZNI
	+dsEAdenD628y//fdGGUu6sg4mUM1K+CartaquUDXJJJ3YJyQXQDW7Z9HTtxOHOjbJH/iac
	bgWUR1RaJ0cmK0zIiryGW9Oiebe90apw6vOQxxy6zN1b7LdDxHejgQelEt5RuH+kCPqOcGM
	a99soeW5uK6ncpwWT91EV1X8uP3yIklFjjHBuri40q2pHlRyF3zALQ9Xy0aYv86tCOMNOe1
	hAcbuLHsqCpwtNBNvPOV27C9ndm2IrxS4ubGi3UE9M3CwI4GTK9lCVdbF8ms+SYOiKAT1bJ
	/xRz8XY+V9iK6EHPaR3yZn7cQnPLVItOEWIaVKORT7dUkiYtDkwIdhjk3LQ6VluhBeb5RTa
	H6nZO/C/Et1aJXKT2MyI7iyKrz8iRHS6wlwRJ0iuLv8JOOnddLk3pXWIiGJS8lf9Qt6m65s
	XkGZqdW3/4qR5VxbfGlsd2NKXfAF0ZO8drCfnoQUkUUXm88AT27qeyjdDGGrnGS2514Xfu5
	mEu95OnwiHaE19Ggk1bQSPFjeeVgWUdm+Uos=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B46=E6=9C=8825=E6=97=A5 03:43=EF=BC=8CJay Vosburgh =
<jv@jvosburgh.net> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Tonghao Zhang <tonghao@bamaicloud.com> wrote:
>=20
>>> 2025=E5=B9=B46=E6=9C=8817=E6=97=A5 18:37=EF=BC=8CTonghao Zhang =
<tonghao@bamaicloud.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>>> 2025=E5=B9=B46=E6=9C=8817=E6=97=A5 08:28=EF=BC=8CJay Vosburgh =
<jv@jvosburgh.net> =E5=86=99=E9=81=93=EF=BC=9A
>>>>=20
>>>> Tonghao Zhang <tonghao@bamaicloud.com> wrote:
>>>>=20
>>>>> Users can monitor NIC link status changes through netlink. =
However, LACP
>>>>> protocol failures may occur despite operational physical links. =
There is
>>>>> no way to detect LACP state changes. This patch adds tracepoint at
>>>>> LACP state transition.
>>>>=20
>>>> This patch really has nothing to do with the rest of the series
>>>> (it's unrelated to the broadcast_neighbor functionality), and =
should
>>>> really be sent separately.
>>> =E2=80=A6 monitoring the lacp state is part of =E2=80=9Cno-stacking=E2=
=80=9D arch solution. So I sent it as series.
>>> if unnecessary, I will set it separately.
>>>=20
>>>> That said, I recall asking about work that was proposed some
>>> Sorry I may miss your commits about this patch.
>>>> time ago to create netlink events (visible to ip monitor, et al) =
when
>>>> the LACP state changes.  That would be a cleaner method to watch =
the
>>>> LACP state machine (as it would integrate with all of the other =
event
>>> Why not consider a BPF+tracepoint solution? It provides more =
flexible LACP data collection with simpler implementation.
>> We developed a component. It collects kernel events via kprobe, =
ftrace, and tracepoint. Events include:
>> - Scheduling latency
>> - Direct memory reclaim
>> - Network packets drop
>> - LACP state events
>>=20
>> BPF + tracepoint is our optimal approach. I think we should support =
this method.
>=20
> At present, as far as I know, networking state change events are
> exported to user space through netlink.  Absent a compelling reason =
why
> the LACP state change cannot be exported via netlink, my view is that =
it
> should be consistent with all other network events.
>=20
> Also, to be clear, I'm asking for justification because this is
> a request to do something in a special bonding-unique way.  There are
> already a lot of special cases in bonding, in which things are done
> differently than the usual practice.  Adding an API element, such as a
> tracepoint, is forever, and as such adding one that also differs from
> the usual practice deserves scrutiny.
I will research the netlink notification method and post a patch when =
it's ready.
>=20
> -J
>=20
>=20
>>>> infrastructure).  Maybe I missed the response, but what became of =
that
>>>> work?
>>>>=20
>>>> -J
>>>>=20
>>>>> Cc: Jay Vosburgh <jv@jvosburgh.net>
>>>>> Cc: "David S. Miller" <davem@davemloft.net>
>>>>> Cc: Eric Dumazet <edumazet@google.com>
>>>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>>>> Cc: Simon Horman <horms@kernel.org>
>>>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>>>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>>>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>>>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>>>>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>>> Cc: Nikolay Aleksandrov <razor@blackwall.org>
>>>>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>>>>> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
>>>>> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
>>>>> ---
>>>>> drivers/net/bonding/bond_3ad.c |  6 ++++++
>>>>> include/trace/events/bonding.h | 37 =
++++++++++++++++++++++++++++++++++
>>>>> 2 files changed, 43 insertions(+)
>>>>> create mode 100644 include/trace/events/bonding.h
>>>>>=20
>>>>> diff --git a/drivers/net/bonding/bond_3ad.c =
b/drivers/net/bonding/bond_3ad.c
>>>>> index d1c2d416ac87..55703230ab29 100644
>>>>> --- a/drivers/net/bonding/bond_3ad.c
>>>>> +++ b/drivers/net/bonding/bond_3ad.c
>>>>> @@ -16,6 +16,9 @@
>>>>> #include <net/bond_3ad.h>
>>>>> #include <net/netlink.h>
>>>>>=20
>>>>> +#define CREATE_TRACE_POINTS
>>>>> +#include <trace/events/bonding.h>
>>>>> +
>>>>> /* General definitions */
>>>>> #define AD_SHORT_TIMEOUT           1
>>>>> #define AD_LONG_TIMEOUT            0
>>>>> @@ -1146,6 +1149,9 @@ static void ad_mux_machine(struct port =
*port, bool *update_slave_arr)
>>>>> port->actor_port_number,
>>>>> last_state,
>>>>> port->sm_mux_state);
>>>>> +
>>>>> + trace_3ad_mux_state(port->slave->dev, last_state, =
port->sm_mux_state);
>>>>> +
>>>>> switch (port->sm_mux_state) {
>>>>> case AD_MUX_DETACHED:
>>>>> port->actor_oper_port_state &=3D ~LACP_STATE_SYNCHRONIZATION;
>>>>> diff --git a/include/trace/events/bonding.h =
b/include/trace/events/bonding.h
>>>>> new file mode 100644
>>>>> index 000000000000..1ee4b07d912a
>>>>> --- /dev/null
>>>>> +++ b/include/trace/events/bonding.h
>>>>> @@ -0,0 +1,37 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>> +
>>>>> +#if !defined(_TRACE_BONDING_H) || =
defined(TRACE_HEADER_MULTI_READ)
>>>>> +#define _TRACE_BONDING_H
>>>>> +
>>>>> +#include <linux/netdevice.h>
>>>>> +#include <linux/tracepoint.h>
>>>>> +
>>>>> +#undef TRACE_SYSTEM
>>>>> +#define TRACE_SYSTEM bonding
>>>>> +
>>>>> +TRACE_EVENT(3ad_mux_state,
>>>>> + TP_PROTO(struct net_device *dev, u32 last_state, u32 =
curr_state),
>>>>> + TP_ARGS(dev, last_state, curr_state),
>>>>> +
>>>>> + TP_STRUCT__entry(
>>>>> + __field(int, ifindex)
>>>>> + __string(dev_name, dev->name)
>>>>> + __field(u32, last_state)
>>>>> + __field(u32, curr_state)
>>>>> + ),
>>>>> +
>>>>> + TP_fast_assign(
>>>>> + __entry->ifindex =3D dev->ifindex;
>>>>> + __assign_str(dev_name);
>>>>> + __entry->last_state =3D last_state;
>>>>> + __entry->curr_state =3D curr_state;
>>>>> + ),
>>>>> +
>>>>> + TP_printk("ifindex %d dev %s last_state 0x%x curr_state 0x%x",
>>>>> +   __entry->ifindex, __get_str(dev_name),
>>>>> +   __entry->last_state, __entry->curr_state)
>>>>> +);
>>>>> +
>>>>> +#endif /* _TRACE_BONDING_H */
>>>>> +
>>>>> +#include <trace/define_trace.h>
>>>>> --=20
>>>>> 2.34.1
>>>>>=20
>>>>=20
>>>> ---
>>>> -Jay Vosburgh, jv@jvosburgh.net
>>=20
>>=20
>>=20
> ---
> -Jay Vosburgh, jv@jvosburgh.net



