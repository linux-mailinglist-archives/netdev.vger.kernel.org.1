Return-Path: <netdev+bounces-200110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E26AE3386
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 04:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13003A3B5F
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 02:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0732E1991B6;
	Mon, 23 Jun 2025 02:11:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993D1F507
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 02:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750644712; cv=none; b=GHDyCtYmcn5VAtZXfCyh1sSmC/NGqrlKKIO99dV0Ma1C+znUt6qPhJb/dGQkxS4ienecFmlpWjPLI+p5c2J+lpHQRcUDr1nmitagzzQRWVnNirl1zNIDUic6STsRYbBuPH/8QZkmLE6FYpNVSyHqFNjj+rww2+qQB3WfedXUzeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750644712; c=relaxed/simple;
	bh=7BVjPYv/KJW45kBMlKRIHLHjq1ydKKALP1VZdRH6rXA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XkiZ9ZXVBo5SAurQy3CA9qeeOW5Xh4sHRpKyBfRdAzP+fizdaAu8nFv5uMLoVK0VOx5e8kYwl67VBafpnSOtpYFgxq3Iw1L+nBRqFrK+l4/nhJt76AIjJmvz1BDCr9u4xBPXb30cUa8PEotac0S7wq/9XieG3fen0INHn7cl5WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz9t1750644677t466d7493
X-QQ-Originating-IP: 7S3lmTJhJtCHMt3IIJY1yw2ajOHhpdLSrgLs/R5PbWo=
Received: from smtpclient.apple ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 23 Jun 2025 10:11:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4864732961362281397
EX-QQ-RecipientCnt: 15
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
In-Reply-To: <C75C5F1F-544F-4613-91D9-4F876EF286B3@bamaicloud.com>
Date: Mon, 23 Jun 2025 10:11:04 +0800
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
 Zengbing Tu <tuzengbing@didiglobal.com>,
 tonghao@bamaicloud.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8DB4F573-128C-4A2D-A4D0-3909586AFF8C@bamaicloud.com>
References: <cover.1749525581.git.tonghao@bamaicloud.com>
 <10b8f570bd59104a1c7d5ecdc9a82c6ec61d2d1c.1749525581.git.tonghao@bamaicloud.com>
 <1931181.1750120130@famine>
 <C75C5F1F-544F-4613-91D9-4F876EF286B3@bamaicloud.com>
To: jv@jvosburgh.net
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MIGBBOK2RQC4T9ERI9Ajjblmq5KFJxUkKZppFu6xBjnobmb2tYpbMsM/
	FdcWXmCbetu/lCI8rwU64Luz+K1bdiWDPReRxoIA5HRAWdPRWwZBrxdWvuwt0rGyLVfug/r
	QrH4RIpvj8Z6RhHocR6jddY9dT/QoCUAyYlwNxa1ih45OESCDoD2V1N2bBCkETq5XV0PRb7
	EjoQpMAACxyKog4nV7BRZWM6Yiu1BdNdvk9fGqV2tGgNvKRY0Zd1Y9kO0PL33usNwoS+BxB
	SDi4t40L/KgLWuQKxAKdHeM1wkjV7wVn1aT3kh4jTdpR2UoYWNKzr/5qImpixFvEL1ViTPV
	5ZzPyd1yu1VqZktAvFYqwQbH1cXIzeI1IXvdj5aQbkx1dnypCIo8GDLtUq+ZNofDB941RUm
	daXye0prsmJMY5tu0VEVCU5LFKAHCZyWyvqVYYUIxSrEx5+S1y/PnfRMu1399uZ8W/fHvzL
	NbV2MssrK882RcIViBsr2oQcmappc2IcVeqSwbujMTGDzD14AJ8DfwEPevkhKPtLVphqaGZ
	pwRQS/01P9YlJlskwn6sfvOETweT8BfqugV+77mjzSo1lZJzUgeYk4zH6sQ+a53nRBd44o0
	Fub3KjvsVd+31yr0d0d+ZSN22hMUoootup9r/h6wEsyk4xDaGBByeMw7iis5wRT8aIpTGV2
	RpIaeavg3sl8tmP5oCnKCJKSc90YXA+kaOYrqVdgxOIw5NWX1nAAyNEMLZbkw3cFIfsOlWK
	sGMKc4ziN4Ns7S4J4NBFx4iZmToISAUdf+AwgGgt/LjB50oeR6JfQpRBgiltKZY3YuvO5ED
	UHwAene8p0QFVZ0SBTIXLhjsVid+CsE/muH0mhSAFW+H1YKuimnUYd5IU6E5ryXcnkMcbhS
	krGQ5wE/0X6cc01O0zbdmW6CgRLebALA5O4NT4pMW08JTtnmKPUFTBDLwOxpJ/2KejrZ1ou
	fkyWYbIaGVMWE2weFw+wg4iPAlw/kmaHbOlI=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B46=E6=9C=8817=E6=97=A5 18:37=EF=BC=8CTonghao Zhang =
<tonghao@bamaicloud.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
>> 2025=E5=B9=B46=E6=9C=8817=E6=97=A5 08:28=EF=BC=8CJay Vosburgh =
<jv@jvosburgh.net> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>> Tonghao Zhang <tonghao@bamaicloud.com> wrote:
>>=20
>>> Users can monitor NIC link status changes through netlink. However, =
LACP
>>> protocol failures may occur despite operational physical links. =
There is
>>> no way to detect LACP state changes. This patch adds tracepoint at
>>> LACP state transition.
>>=20
>> This patch really has nothing to do with the rest of the series
>> (it's unrelated to the broadcast_neighbor functionality), and should
>> really be sent separately.
> =E2=80=A6 monitoring the lacp state is part of =E2=80=9Cno-stacking=E2=80=
=9D arch solution. So I sent it as series.
> if unnecessary, I will set it separately.
>=20
>> That said, I recall asking about work that was proposed some
> Sorry I may miss your commits about this patch.
>> time ago to create netlink events (visible to ip monitor, et al) when
>> the LACP state changes.  That would be a cleaner method to watch the
>> LACP state machine (as it would integrate with all of the other event
> Why not consider a BPF+tracepoint solution? It provides more flexible =
LACP data collection with simpler implementation.
We developed a component. It collects kernel events via kprobe, ftrace, =
and tracepoint. Events include:
- Scheduling latency
- Direct memory reclaim
- Network packets drop
- LACP state events

BPF + tracepoint is our optimal approach. I think we should support this =
method.

>> infrastructure).  Maybe I missed the response, but what became of =
that
>> work?
>>=20
>> -J
>>=20
>>> Cc: Jay Vosburgh <jv@jvosburgh.net>
>>> Cc: "David S. Miller" <davem@davemloft.net>
>>> Cc: Eric Dumazet <edumazet@google.com>
>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>> Cc: Simon Horman <horms@kernel.org>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>> Cc: Nikolay Aleksandrov <razor@blackwall.org>
>>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>>> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
>>> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
>>> ---
>>> drivers/net/bonding/bond_3ad.c |  6 ++++++
>>> include/trace/events/bonding.h | 37 =
++++++++++++++++++++++++++++++++++
>>> 2 files changed, 43 insertions(+)
>>> create mode 100644 include/trace/events/bonding.h
>>>=20
>>> diff --git a/drivers/net/bonding/bond_3ad.c =
b/drivers/net/bonding/bond_3ad.c
>>> index d1c2d416ac87..55703230ab29 100644
>>> --- a/drivers/net/bonding/bond_3ad.c
>>> +++ b/drivers/net/bonding/bond_3ad.c
>>> @@ -16,6 +16,9 @@
>>> #include <net/bond_3ad.h>
>>> #include <net/netlink.h>
>>>=20
>>> +#define CREATE_TRACE_POINTS
>>> +#include <trace/events/bonding.h>
>>> +
>>> /* General definitions */
>>> #define AD_SHORT_TIMEOUT           1
>>> #define AD_LONG_TIMEOUT            0
>>> @@ -1146,6 +1149,9 @@ static void ad_mux_machine(struct port *port, =
bool *update_slave_arr)
>>>  port->actor_port_number,
>>>  last_state,
>>>  port->sm_mux_state);
>>> +
>>> + trace_3ad_mux_state(port->slave->dev, last_state, =
port->sm_mux_state);
>>> +
>>> switch (port->sm_mux_state) {
>>> case AD_MUX_DETACHED:
>>> port->actor_oper_port_state &=3D ~LACP_STATE_SYNCHRONIZATION;
>>> diff --git a/include/trace/events/bonding.h =
b/include/trace/events/bonding.h
>>> new file mode 100644
>>> index 000000000000..1ee4b07d912a
>>> --- /dev/null
>>> +++ b/include/trace/events/bonding.h
>>> @@ -0,0 +1,37 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +
>>> +#if !defined(_TRACE_BONDING_H) || defined(TRACE_HEADER_MULTI_READ)
>>> +#define _TRACE_BONDING_H
>>> +
>>> +#include <linux/netdevice.h>
>>> +#include <linux/tracepoint.h>
>>> +
>>> +#undef TRACE_SYSTEM
>>> +#define TRACE_SYSTEM bonding
>>> +
>>> +TRACE_EVENT(3ad_mux_state,
>>> + TP_PROTO(struct net_device *dev, u32 last_state, u32 curr_state),
>>> + TP_ARGS(dev, last_state, curr_state),
>>> +
>>> + TP_STRUCT__entry(
>>> + __field(int, ifindex)
>>> + __string(dev_name, dev->name)
>>> + __field(u32, last_state)
>>> + __field(u32, curr_state)
>>> + ),
>>> +
>>> + TP_fast_assign(
>>> + __entry->ifindex =3D dev->ifindex;
>>> + __assign_str(dev_name);
>>> + __entry->last_state =3D last_state;
>>> + __entry->curr_state =3D curr_state;
>>> + ),
>>> +
>>> + TP_printk("ifindex %d dev %s last_state 0x%x curr_state 0x%x",
>>> +   __entry->ifindex, __get_str(dev_name),
>>> +   __entry->last_state, __entry->curr_state)
>>> +);
>>> +
>>> +#endif /* _TRACE_BONDING_H */
>>> +
>>> +#include <trace/define_trace.h>
>>> --=20
>>> 2.34.1
>>>=20
>>=20
>> ---
>> -Jay Vosburgh, jv@jvosburgh.net



