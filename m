Return-Path: <netdev+bounces-260449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCcoNZB9nWk1QQQAu9opvQ
	(envelope-from <netdev+bounces-260449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:29:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83152185568
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 799CC3046523
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EE93783C1;
	Tue, 24 Feb 2026 10:29:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B96266565
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771928972; cv=none; b=VI3+KuYPQtr1ZQETpzJKUlVmuQfwm8U3j+7aMUKooKyUH5QlDYzUz50ns/TXKhtm8jTLCc4A0AmvufjmxeBJvtUOdG8OpvTtBquVBsv/V5P4SD6W++FHYrWgVoGFaRu8bGFpnOSYXjOW8DSOR+C1PISjW7kKq+Db9YEhEDDMQHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771928972; c=relaxed/simple;
	bh=7xNjJrYrGYZG6wRawhrOiVdBjYnrOPyKb5opxsQHj9c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sP5Q5flz2sHM+4I4ukn2xRi4rQofuUp2g4jmvJBro390yB7jucmFxZ3KHDM0v/l4p1caUkznlbaqO1m2pE3wn3XfzZCcDekFL1Spry82EOuFqtJSpCvWnb272y1bLX9OJ+BEjfWLyJUpoigNxw5OjHtW/vLVyV9ND5YmpXLuxa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz8t1771928960tc8a75939
X-QQ-Originating-IP: OKn+FAZ5MtLPrnMpQxi1F0lfGpKzTusLC5rWBxexsWY=
Received: from smtpclient.apple ( [120.244.235.1])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Feb 2026 18:29:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1211336453854388841
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH net-next] net: core: introduce the
 netdev_fetch_core_stats()
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <CAL+tcoAo++zNTneOD+YM5gbAqSOyZtGT=FgRUpSZuzrE7WffHw@mail.gmail.com>
Date: Tue, 24 Feb 2026 18:29:07 +0800
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Samiullah Khawaja <skhawaja@google.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8BEBBF67-92EE-4E6B-9D92-863A80883429@bamaicloud.com>
References: <e8355c0d7fd48981ba505e455387971f91210fa8.1771734206.git.tonghao@bamaicloud.com>
 <CAL+tcoDR2-WTmhBakWcvEuLCwAU7RGRA8syfor-+RJJq7_ZOKw@mail.gmail.com>
 <65307E32-7AFF-44EF-B2BB-89AA15F3D0D1@bamaicloud.com>
 <CAL+tcoB0uV0E9cDCfw58kAuzNcanstx_OT3h=dkQVOW1b-nN+A@mail.gmail.com>
 <C914CAC5-AEF2-4814-84FC-30EA4B70F832@bamaicloud.com>
 <CAL+tcoDzik63K1aqpDTn7K6Jkta5ZtjedTQ58TB455+pwkq8Pw@mail.gmail.com>
 <3AB6E925-3A2E-439D-8432-B00F4DEFE7F1@bamaicloud.com>
 <CAL+tcoD+TL6xbTodAKp=w0NVeLOubxoJpk=-b_8Z0bPvFrzXCQ@mail.gmail.com>
 <4E09E708-FA5A-4523-8E75-359C3D8B43E6@bamaicloud.com>
 <CAL+tcoAo++zNTneOD+YM5gbAqSOyZtGT=FgRUpSZuzrE7WffHw@mail.gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MJWNsjxQgzaErQ34w1aEZILXjfGnLKpsntM3gLvY8apWlbDPeBzd9FHu
	ePOvP0b8FClIKPJE7DY0DjGVsaQzYvN1LuQPFTjwnk6gxphgr5IfE56J2jOnaaYYuDpkF1Y
	jUC6QsSNP88Xcj7jxFs8mabBS32ZYuwTij3ELFilDOx2kudeFXWz4vSjv6ZxYlfUc/PAda8
	+Ehr56jnkZe5nQO3xADXxwK6sco+YAcOq9hkyaCfsnMOVTUT5q/G8JVmcgS3MKulNfiuNqW
	eSZC1Hs/bY5Yj1HdkCosAnWdg3GY5CRe0AigfKgTb9UybSO0fosXuchQJsBLdVLe5qOpLob
	f9pPh69Sal5jwRgnZPyUGpzVPUuy2wczYvPLxBPmJEscyGSVkNHi8fffrDg4c3PpLVzUmjS
	6XzvELczDpIpDJIHNdWJCrwjhOPGQuMwujIR7rKmhr/2Tb/p4CXkOX2y/mpN9//GnYFxMbv
	oSBpakWpxHuPR24HZ7rl4OOM/RcFgr/f9jNMAytm66X5VEgPADlOUZCSdcS4twW0zZpFpH/
	OkRHikT/aYLbsbRYBkr2NEWVmW/4kSq3rUa2Vx8UdN+ShQoLd6gmO9lHxz2zhOKS3c/64un
	N7M2VIM3CvrX81HJS3qKYmPH8kw+hjbZ2kL2ETQAssS7cEzmtUn+nj7rVcD4/+EIkAeLEIs
	kFu5xUbqZF8NkJD8H8eEDq5oi+g9Jvtxoy9Sf56pKAWjvpLYym7LolRnxBCY2qMwOTSGCJs
	W5IkCwIZ8+y/L6hh/sWuGP/zvXwgH6xeE1uwYIUPineBI/0jk3Kes/1SzdkW+rm3T90m4jI
	bfWVKb+CLLkE34JQ6Y/9uMrlSaW5kptZvk5TmsOf5p3MdTThId37zhhMl48SpxPupe/dWI2
	/hREVyuhL4xJ/z/THhXNFdgpObsrIzl1TrVH2CPXEkkcMDP8iO8YhQ/B4LiqOvsqI00eogl
	PqN7d2yF15zIZIkKURAvHe4nNmTINdKq/uJbskWOfqDMyjZ34YaJcjUcl6AyMba5DAPOs7H
	aH0ZdhFJTJFA6V8Gw/ALUztSqYdSw=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260449-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[bamaicloud.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tonghao@bamaicloud.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,fomichev.me:email]
X-Rspamd-Queue-Id: 83152185568
X-Rspamd-Action: no action



> On Feb 24, 2026, at 15:23, Jason Xing <kerneljasonxing@gmail.com> =
wrote:
>=20
> On Tue, Feb 24, 2026 at 2:54=E2=80=AFPM Tonghao Zhang =
<tonghao@bamaicloud.com> wrote:
>>=20
>>=20
>>=20
>>> On Feb 24, 2026, at 14:24, Jason Xing <kerneljasonxing@gmail.com> =
wrote:
>>>=20
>>> On Tue, Feb 24, 2026 at 2:08=E2=80=AFPM Tonghao Zhang =
<tonghao@bamaicloud.com> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On Feb 24, 2026, at 13:28, Jason Xing <kerneljasonxing@gmail.com> =
wrote:
>>>>>=20
>>>>> On Tue, Feb 24, 2026 at 12:07=E2=80=AFPM Tonghao Zhang =
<tonghao@bamaicloud.com> wrote:
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>>> On Feb 24, 2026, at 11:52, Jason Xing =
<kerneljasonxing@gmail.com> wrote:
>>>>>>>=20
>>>>>>> On Tue, Feb 24, 2026 at 11:22=E2=80=AFAM Tonghao Zhang =
<tonghao@bamaicloud.com> wrote:
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>>> On Feb 23, 2026, at 08:20, Jason Xing =
<kerneljasonxing@gmail.com> wrote:
>>>>>>>>>=20
>>>>>>>>> On Sun, Feb 22, 2026 at 12:38=E2=80=AFPM Tonghao Zhang =
<tonghao@bamaicloud.com> wrote:
>>>>>>>>>>=20
>>>>>>>>>> Network device statistics retrieved via procfs, sysfs, and =
netlink
>>>>>>>>>> represent the combined total of core_stats + driver, hardware =
statistics.
>>>>>>>>>>=20
>>>>>>>>>> However, in some scenarios, when monitoring netdev metrics, =
it is valuable
>>>>>>>>>> to clearly distinguish whether the values originate from the =
networking
>>>>>>>>>> stack's core statistics or from the driver, hardware layer. =
This helps
>>>>>>>>>> improve debugging and addressing issues.
>>>>>>>>>>=20
>>>>>>>>>> Approaches were considered:
>>>>>>>>>> - commit 5247dbf16cee ("net/core: Introduce =
netdev_core_stats_inc()").
>>>>>>>>>> This allows tracking increments to core_stats and helps =
identify specific
>>>>>>>>>> causes of changes, but not provide the total counters.
>>>>>>>>>> - extending rtnl_link_stats64 with new core_xxx fields.
>>>>>>>>>> This would likely confuse or break existing userspace =
applications relying
>>>>>>>>>> on this struct.
>>>>>>>>>> - adding a tracepoint inside dev_get_stats().
>>>>>>>>>> This implementation is not simple or straightforward enough.
>>>>>>>>>>=20
>>>>>>>>>> The solution in this patch is therefore to introduce a new =
dedicated function
>>>>>>>>>> for collecting core statistics and mark it noinline. This =
approach is simple,
>>>>>>>>>> clean, and maintainable to obtain driver, hardware statistics =
separately when needed.
>>>>>>>>>>=20
>>>>>>>>>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>>>>>>>>>> Cc: "David S. Miller" <davem@davemloft.net>
>>>>>>>>>> Cc: Eric Dumazet <edumazet@google.com>
>>>>>>>>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>>>>>>>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>>>>>>>>> Cc: Simon Horman <horms@kernel.org>
>>>>>>>>>> Cc: Stanislav Fomichev <sdf@fomichev.me>
>>>>>>>>>> Cc: Kuniyuki Iwashima <kuniyu@google.com>
>>>>>>>>>> Cc: Samiullah Khawaja <skhawaja@google.com>
>>>>>>>>>> Cc: Ahmed Zaki <ahmed.zaki@intel.com>
>>>>>>>>>> Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
>>>>>>>>>=20
>>>>>>>>> It's a simple refactor patch that only moves that logic to a =
new
>>>>>>>>> helper. I don't see any new possible callers right now so =
could you
>>>>>>>>> provide more straightward/clear use cases and intentions =
behind this
>>>>>>>>> patch? For example, give us what kind of dumping stats you =
want to
>>>>>>>>> tweak and your next movements.
>>>>>>>> Thanks, Jason
>>>>>>>> This patch tries to add one helper function which marked as =
noinline for bpf tracing (this commit 5247dbf16cee also use the noinline =
for tracing). This helper is not used other place in kernel.
>>>>>>>>=20
>>>>>>>> For example,
>>>>>>>> sudo bpftrace -e '
>>>>>>>> kprobe:netdev_core_stats_fetch {printf("%d\n", ((struct =
rtnl_link_stats64 *)arg1)->rx_dropped);}
>>>>>>>> kretprobe:netdev_core_stats_fetch {printf("%d\n", ((struct =
rtnl_link_stats64 *)retval)->rx_dropped);}
>>>>>>>> '
>>>>>>>=20
>>>>>>> Can't we use the global symbol dev_get_stats() instead? It =
should be the same.
>>>>>>=20
>>>>>> - if kprobe the dev_get_stats(), the rtnl_link_stats64 *storage =
is not used by drivers (ndo_get_stats64, ndo_get_stats..,), the =
rx_dropped, for example, is 0.
>>>>>=20
>>>>> How about computing the delta of @storage->xxx between two =
consecutive
>>>>> kretprobes hitting this function? And you can also identify the =
source
>>>=20
>>> two consecutive __kretprobes__=E2=80=A6
>> I got it. In fact, it is not solving the problem. For example, =
@storage->rx_dropped is increasing, but it's impossible to determine =
whether the increase comes from core_stats.rx_dropped, from the =
driver=E2=80=99s rx_dropped, or from both.
>=20
> To be more specific, in dev_get_stats() @storage is only one memory
> area that records the information from @core_stats. So it is
> @core_stats that takes effect and is widely used/scattered over the
> place (please see how one example like dev_core_stats_rx_dropped_inc()
> gets called, it can be used by drivers like ipvlan or stack). We
> cannot tell which one causes the increment by looking at @core_stats.
I don=E2=80=99t take care of the virtual net device. In our production =
environment,
there are many network cards from various manufacturers (mlx, intel, =
broadcom).

By the way, can we use the driver private stats instead of the =
core_stats counters for macvlan, ipvlan, tun, bonding, and bnxt.

# git grep -rin dev_core_stats_ drivers/
drivers/net/bonding/bond_main.c:5291:   =
dev_core_stats_tx_dropped_inc(bond_dev);
drivers/net/ethernet/broadcom/bnge/bnge_txrx.c:1616:    =
dev_core_stats_tx_dropped_inc(dev);
drivers/net/ethernet/broadcom/bnxt/bnxt.c:490:          =
dev_core_stats_tx_dropped_inc(dev);
drivers/net/ethernet/broadcom/bnxt/bnxt.c:504:                  =
dev_core_stats_tx_dropped_inc(dev);
drivers/net/ethernet/broadcom/bnxt/bnxt.c:804:  =
dev_core_stats_tx_dropped_inc(dev);
drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c:220:               =
dev_core_stats_rx_nohandler_inc(skb->dev);
drivers/net/ipvlan/ipvlan_core.c:598:           =
dev_core_stats_rx_dropped_inc(skb->dev);
drivers/net/macvlan.c:383:      dev_core_stats_rx_dropped_inc(skb->dev);
drivers/net/net_failover.c:92:  dev_core_stats_tx_dropped_inc(dev);
drivers/net/netkit.c:124:               =
dev_core_stats_tx_dropped_inc(dev);
drivers/net/tun.c:1081: dev_core_stats_tx_dropped_inc(dev);
drivers/net/tun.c:1237:                 =
dev_core_stats_tx_dropped_inc(dev);
drivers/net/tun.c:1567:                 =
dev_core_stats_rx_dropped_inc(tun->dev);
drivers/net/tun.c:1575:                 =
dev_core_stats_rx_dropped_inc(tun->dev);
drivers/net/tun.c:1589:         dev_core_stats_rx_dropped_inc(tun->dev);
drivers/net/tun.c:1913:                 =
dev_core_stats_rx_dropped_inc(tun->dev);
drivers/net/tun.c:1970:         dev_core_stats_rx_dropped_inc(tun->dev);

>=20
> Besides, another trivial thing is that, even with your patch applied,
> it doesn't change anything since core_stats->rx_dropped can get
> increased in between kprobe and kretprobe of the new helper you added.
The new helper only gives a proper hook point.
>=20
> With that said, how can you accurately know where the increment comes
> from? Is it from the stack or driver? I dunno :S
If considering the virtual net device, it is not easy to know where the =
increment comes from. It is only useful for hardware NIC.
>=20
>=20
> Thanks,
> Jason



