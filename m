Return-Path: <netdev+bounces-260795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNw1OBy2nmnwWwQAu9opvQ
	(envelope-from <netdev+bounces-260795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:43:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BDE19458F
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 674BC3036769
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F872FCBF0;
	Wed, 25 Feb 2026 08:43:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21C82DFA4A
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772008984; cv=none; b=Ods917PtJ7HTwu6ZQPpLXyVYqLBCR8jYp5H+NZh1DbnI4vcYPV8/dg66urKjNQeZt50EzaYklxwMZXGlBQBOoatvSYkVN1tkEu+mIFCcNJs6T2HfyGFDd2Ki/qaWmn0JHgz3efpRV4HiBweJHgMj29nv+v2zIm8xkouJlFLNmag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772008984; c=relaxed/simple;
	bh=6dHOvw1wMk/rjZWv9mfLdyiFZL7L8fjrQp+TaWmxSBs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pj3llat5//0Zf37r6K7CXsjGNaGuA0AMYREh0EkildtKXElNjXS7QHzlMlbKgiBFR7y7M28JyvmSqLjj4/JCRig6m1RT5yZTn2sdFQnxyNaTDBW9UYK5DAZH33fPmC+yUDbZe8mCiwegBP3OxX7LUl5RR6jRZpeanx1HjICBAkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz10t1772008968t1df7f4e2
X-QQ-Originating-IP: O5knO1jDE+i7uEkww2UoiN4kES1DpMBKd6eFi3HQ93U=
Received: from smtpclient.apple ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Feb 2026 16:42:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2390673473491989969
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
In-Reply-To: <CAL+tcoA-i-aKgjBwt0MPzhFjgMQ3qELJyB+Fd+cpYzMita8v+Q@mail.gmail.com>
Date: Wed, 25 Feb 2026 16:42:35 +0800
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
Message-Id: <A62D779D-CCED-4C30-9113-8FC803EBA191@bamaicloud.com>
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
 <8BEBBF67-92EE-4E6B-9D92-863A80883429@bamaicloud.com>
 <CAL+tcoA-i-aKgjBwt0MPzhFjgMQ3qELJyB+Fd+cpYzMita8v+Q@mail.gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NeXtCpGBO9nHJNEQ5/kzv0UEc4eZbtG+0joEDxG+KFFmE2fYLl+iJPSs
	A7/9nmMyXl924+1ilyDAkgrGMHw9m7FGmDxoTqA4ozr+3X+Elb1wZ4q/K9sIF9JCgGanTlc
	5t1Eu9PoK3ak+qOLXCIMwT2J0B4GM9MxGnHmGUkB/ckte28MWfQbI6POGuO8W5LE934QvbF
	+imMpyCAkBuN5DVqTRbJymCA/F/9gchkVM6TElwqjOKgP5XUBzKQDCpCjQZaZ8l1YUJMV0y
	oI05wBRxJbMowbSDighJlGWnMVzakSmsNndTYPZou1cn8jF1LVKA09427pDzCYlgkTUoLY/
	biCpWE+8ePlet+zikLnAcoGqlsV0ToFYweN4XswkmPZ6i7GOx+0j85Mo2nx8obZ2QVCSfp9
	zhcOgJzKKgiqlCpsAXgqHfW/CJi509WXlFJB/xSjT7HdXyWB5jchTqsQIFa4NYMIZw+I3w8
	gU/h25/+LHqnG/sYnsQrzKsHqiCm36qkK4A4kW18pg1W+cg+EMtpuo+TLNNuNGJg9ydBsqc
	XPjTETewIRttsgbZCAEVcpfidPgCIFRjo65iTMJyvhzqdKujkAAx7vgVi+ggdIMH6yWltF8
	Zq5yMh8uvb0WLVPkoW7AyivQiZBnmr1SVPNVhSHWafnTFzhURbKqUAvrlNnyAkfTvlVdNM+
	sCUjenZB3dZ0/pa9RfzaMWR22PfJFqd/ygzyJ/MrgU0jER+I0opqHkqxy9BVWfZ87dERyEE
	pNeLRo1o/OS2BqFqQTp6vXWWZuWiSc1budobgklygwv5orYWuVvlDvjmOOsiFJN7ZFkZlHQ
	I1vkC4slKojPI74aSaTzIktKMyNih8l6DHxI82dduwjG5ID28fu7LV4ZEvdpUom/qslAl+W
	T7atNlx9q+lR91MDxnAyWObUt3HO6lcT/Hqg8+P11fq2KmwE+5YexvcnEBwkhWqetoP/rFU
	e7xmSZi47Ym6NhPigZ06QVh95/XQGFyvIJAovbp7GeOtACvHqHIWmMeuXJArej3S3cuo=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[bamaicloud.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260795-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,google.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tonghao@bamaicloud.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,davemloft.net:email]
X-Rspamd-Queue-Id: D9BDE19458F
X-Rspamd-Action: no action



> On Feb 24, 2026, at 19:48, Jason Xing <kerneljasonxing@gmail.com> =
wrote:
>=20
> On Tue, Feb 24, 2026 at 6:29=E2=80=AFPM Tonghao Zhang =
<tonghao@bamaicloud.com> wrote:
>>=20
>>=20
>>=20
>>> On Feb 24, 2026, at 15:23, Jason Xing <kerneljasonxing@gmail.com> =
wrote:
>>>=20
>>> On Tue, Feb 24, 2026 at 2:54=E2=80=AFPM Tonghao Zhang =
<tonghao@bamaicloud.com> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On Feb 24, 2026, at 14:24, Jason Xing <kerneljasonxing@gmail.com> =
wrote:
>>>>>=20
>>>>> On Tue, Feb 24, 2026 at 2:08=E2=80=AFPM Tonghao Zhang =
<tonghao@bamaicloud.com> wrote:
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>>> On Feb 24, 2026, at 13:28, Jason Xing =
<kerneljasonxing@gmail.com> wrote:
>>>>>>>=20
>>>>>>> On Tue, Feb 24, 2026 at 12:07=E2=80=AFPM Tonghao Zhang =
<tonghao@bamaicloud.com> wrote:
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>>> On Feb 24, 2026, at 11:52, Jason Xing =
<kerneljasonxing@gmail.com> wrote:
>>>>>>>>>=20
>>>>>>>>> On Tue, Feb 24, 2026 at 11:22=E2=80=AFAM Tonghao Zhang =
<tonghao@bamaicloud.com> wrote:
>>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>>> On Feb 23, 2026, at 08:20, Jason Xing =
<kerneljasonxing@gmail.com> wrote:
>>>>>>>>>>>=20
>>>>>>>>>>> On Sun, Feb 22, 2026 at 12:38=E2=80=AFPM Tonghao Zhang =
<tonghao@bamaicloud.com> wrote:
>>>>>>>>>>>>=20
>>>>>>>>>>>> Network device statistics retrieved via procfs, sysfs, and =
netlink
>>>>>>>>>>>> represent the combined total of core_stats + driver, =
hardware statistics.
>>>>>>>>>>>>=20
>>>>>>>>>>>> However, in some scenarios, when monitoring netdev metrics, =
it is valuable
>>>>>>>>>>>> to clearly distinguish whether the values originate from =
the networking
>>>>>>>>>>>> stack's core statistics or from the driver, hardware layer. =
This helps
>>>>>>>>>>>> improve debugging and addressing issues.
>>>>>>>>>>>>=20
>>>>>>>>>>>> Approaches were considered:
>>>>>>>>>>>> - commit 5247dbf16cee ("net/core: Introduce =
netdev_core_stats_inc()").
>>>>>>>>>>>> This allows tracking increments to core_stats and helps =
identify specific
>>>>>>>>>>>> causes of changes, but not provide the total counters.
>>>>>>>>>>>> - extending rtnl_link_stats64 with new core_xxx fields.
>>>>>>>>>>>> This would likely confuse or break existing userspace =
applications relying
>>>>>>>>>>>> on this struct.
>>>>>>>>>>>> - adding a tracepoint inside dev_get_stats().
>>>>>>>>>>>> This implementation is not simple or straightforward =
enough.
>>>>>>>>>>>>=20
>>>>>>>>>>>> The solution in this patch is therefore to introduce a new =
dedicated function
>>>>>>>>>>>> for collecting core statistics and mark it noinline. This =
approach is simple,
>>>>>>>>>>>> clean, and maintainable to obtain driver, hardware =
statistics separately when needed.
>>>>>>>>>>>>=20
>>>>>>>>>>>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>>>>>>>>>>>> Cc: "David S. Miller" <davem@davemloft.net>
>>>>>>>>>>>> Cc: Eric Dumazet <edumazet@google.com>
>>>>>>>>>>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>>>>>>>>>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>>>>>>>>>>> Cc: Simon Horman <horms@kernel.org>
>>>>>>>>>>>> Cc: Stanislav Fomichev <sdf@fomichev.me>
>>>>>>>>>>>> Cc: Kuniyuki Iwashima <kuniyu@google.com>
>>>>>>>>>>>> Cc: Samiullah Khawaja <skhawaja@google.com>
>>>>>>>>>>>> Cc: Ahmed Zaki <ahmed.zaki@intel.com>
>>>>>>>>>>>> Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
>>>>>>>>>>>=20
>>>>>>>>>>> It's a simple refactor patch that only moves that logic to a =
new
>>>>>>>>>>> helper. I don't see any new possible callers right now so =
could you
>>>>>>>>>>> provide more straightward/clear use cases and intentions =
behind this
>>>>>>>>>>> patch? For example, give us what kind of dumping stats you =
want to
>>>>>>>>>>> tweak and your next movements.
>>>>>>>>>> Thanks, Jason
>>>>>>>>>> This patch tries to add one helper function which marked as =
noinline for bpf tracing (this commit 5247dbf16cee also use the noinline =
for tracing). This helper is not used other place in kernel.
>>>>>>>>>>=20
>>>>>>>>>> For example,
>>>>>>>>>> sudo bpftrace -e '
>>>>>>>>>> kprobe:netdev_core_stats_fetch {printf("%d\n", ((struct =
rtnl_link_stats64 *)arg1)->rx_dropped);}
>>>>>>>>>> kretprobe:netdev_core_stats_fetch {printf("%d\n", ((struct =
rtnl_link_stats64 *)retval)->rx_dropped);}
>>>>>>>>>> '
>>>>>>>>>=20
>>>>>>>>> Can't we use the global symbol dev_get_stats() instead? It =
should be the same.
>>>>>>>>=20
>>>>>>>> - if kprobe the dev_get_stats(), the rtnl_link_stats64 *storage =
is not used by drivers (ndo_get_stats64, ndo_get_stats..,), the =
rx_dropped, for example, is 0.
>>>>>>>=20
>>>>>>> How about computing the delta of @storage->xxx between two =
consecutive
>>>>>>> kretprobes hitting this function? And you can also identify the =
source
>>>>>=20
>>>>> two consecutive __kretprobes__=E2=80=A6
>>>> I got it. In fact, it is not solving the problem. For example, =
@storage->rx_dropped is increasing, but it's impossible to determine =
whether the increase comes from core_stats.rx_dropped, from the =
driver=E2=80=99s rx_dropped, or from both.
>>>=20
>>> To be more specific, in dev_get_stats() @storage is only one memory
>>> area that records the information from @core_stats. So it is
>>> @core_stats that takes effect and is widely used/scattered over the
>>> place (please see how one example like =
dev_core_stats_rx_dropped_inc()
>>> gets called, it can be used by drivers like ipvlan or stack). We
>>> cannot tell which one causes the increment by looking at =
@core_stats.
>> I don=E2=80=99t take care of the virtual net device. In our =
production environment,
>> there are many network cards from various manufacturers (mlx, intel, =
broadcom).
>>=20
>> By the way, can we use the driver private stats instead of the =
core_stats counters for macvlan, ipvlan, tun, bonding, and bnxt.
>>=20
>> # git grep -rin dev_core_stats_ drivers/
>> drivers/net/bonding/bond_main.c:5291:   =
dev_core_stats_tx_dropped_inc(bond_dev);
>> drivers/net/ethernet/broadcom/bnge/bnge_txrx.c:1616:    =
dev_core_stats_tx_dropped_inc(dev);
>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:490:          =
dev_core_stats_tx_dropped_inc(dev);
>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:504:                  =
dev_core_stats_tx_dropped_inc(dev);
>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:804:  =
dev_core_stats_tx_dropped_inc(dev);
>> drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c:220:             =
  dev_core_stats_rx_nohandler_inc(skb->dev);
>> drivers/net/ipvlan/ipvlan_core.c:598:           =
dev_core_stats_rx_dropped_inc(skb->dev);
>> drivers/net/macvlan.c:383:      =
dev_core_stats_rx_dropped_inc(skb->dev);
>> drivers/net/net_failover.c:92:  dev_core_stats_tx_dropped_inc(dev);
>> drivers/net/netkit.c:124:               =
dev_core_stats_tx_dropped_inc(dev);
>> drivers/net/tun.c:1081: dev_core_stats_tx_dropped_inc(dev);
>> drivers/net/tun.c:1237:                 =
dev_core_stats_tx_dropped_inc(dev);
>> drivers/net/tun.c:1567:                 =
dev_core_stats_rx_dropped_inc(tun->dev);
>> drivers/net/tun.c:1575:                 =
dev_core_stats_rx_dropped_inc(tun->dev);
>> drivers/net/tun.c:1589:         =
dev_core_stats_rx_dropped_inc(tun->dev);
>> drivers/net/tun.c:1913:                 =
dev_core_stats_rx_dropped_inc(tun->dev);
>> drivers/net/tun.c:1970:         =
dev_core_stats_rx_dropped_inc(tun->dev);
>>=20
>>>=20
>>> Besides, another trivial thing is that, even with your patch =
applied,
>>> it doesn't change anything since core_stats->rx_dropped can get
>>> increased in between kprobe and kretprobe of the new helper you =
added.
>> The new helper only gives a proper hook point.
>=20
> The patch makes no difference. Please see below.
>=20
>>>=20
>>> With that said, how can you accurately know where the increment =
comes
>>> from? Is it from the stack or driver? I dunno :S
>> If considering the virtual net device, it is not easy to know where =
the increment comes from. It is only useful for hardware NIC.
>=20
> My whole points are 1) @storage as the first parameter of
> dev_get_stats() doesn't mean anything because it's a temp memory area.
> Previously you wanted to use this to know the source of counters,
> which is apparently wrong; 2) reading @core_stats is the only way to
No, I don=E2=80=99t use the dev_get_stats(). I introduce the new helper =
and use the netdev_core_stats_fetch() to get counters of drivers =
(especially, hardware NIC).
> help us understand where the increment comes from, but it can't. This
> member includes many different counters that can be used in either
> stack or drivers. The usage should be general, IMHO.
I agree that this is not general, but this helper is useful for hardware =
nic.
>=20
>=20
> So again how can you be sure where the increment of one counter
> happens? I mean how? Could you provide us more details about _how_ to
> know where the increment comes from? IIUC, by only hooking either
> dev_get_stats() or the new helper it doesn't work.
For tracing **hardware NIC**, for example, ixgbe which does=E2=80=99t =
use the core_stats =20

struct rtnl_link_stats64 *dev_get_stats(struct net_device *dev,
                                        struct rtnl_link_stats64 =
*storage)
{
        const struct net_device_ops *ops =3D dev->netdev_ops;
	...
        if (ops->ndo_get_stats64) {
                memset(storage, 0, sizeof(*storage));
                ops->ndo_get_stats64(dev, storage); // 1. @storage is =
initialized by ixgbe driver
        } else if (ops->ndo_get_stats) {
              ...
        }

        return netdev_core_stats_fetch(dev, storage); // 2. kprobe this =
function to fetch the @storage returned by ixgbe driver, counters are =
from drivers 3. kretprobe this function to fetch the @storage which add =
the core_stats. So counters =3D=3D @storage of kretprobe - @storage of =
kprobes, are from core_stats.
}

>=20
> Take a look at this counter, so many callers:
> $ grep -nr dev_core_stats_tx_dropped_inc ./net/ drivers/net/ethernet/
> ./net/hsr/hsr_device.c:239:             =
dev_core_stats_tx_dropped_inc(dev);
> ./net/core/filter.c:2292:               =
dev_core_stats_tx_dropped_inc(dev);
> ./net/core/filter.c:2297:       dev_core_stats_tx_dropped_inc(dev);
> ./net/core/filter.c:2399:               =
dev_core_stats_tx_dropped_inc(dev);
> ./net/core/filter.c:2404:       dev_core_stats_tx_dropped_inc(dev);
> ./net/core/dev.c:4057:  dev_core_stats_tx_dropped_inc(dev);
> ./net/core/dev.c:4859:  dev_core_stats_tx_dropped_inc(dev);
> ./net/core/dev.c:4899:  dev_core_stats_tx_dropped_inc(dev);
> ./net/core/dev.c:5596:          dev_core_stats_tx_dropped_inc(dev);
> ./net/sched/sch_generic.c:641:  =
dev_core_stats_tx_dropped_inc(skb->dev);
The above is the core code of the net stack.=20
> ./net/xfrm/xfrm_device.c:144:           =
dev_core_stats_tx_dropped_inc(dev);
> ./net/xfrm/xfrm_device.c:168:
> dev_core_stats_tx_dropped_inc(dev);
> drivers/net/ethernet/broadcom/bnge/bnge_txrx.c:1616:
> dev_core_stats_tx_dropped_inc(dev);
> drivers/net/ethernet/broadcom/bnxt/bnxt.c:490:
> dev_core_stats_tx_dropped_inc(dev);
> drivers/net/ethernet/broadcom/bnxt/bnxt.c:504:
> dev_core_stats_tx_dropped_inc(dev);
> drivers/net/ethernet/broadcom/bnxt/bnxt.c:804:
> dev_core_stats_tx_dropped_inc(dev);

For macvlan, ipvlan, tun, and bonding, I think I will change them to use =
the private the stats of these drivers in v2.

caf586e5f23c ("net: add a core netdev->rx_dropped counter=E2=80=9D)
=E2=80=9C=E2=80=9D=E2=80=9D
    net: add a core netdev->rx_dropped counter

    In various situations, a device provides a packet to our stack and =
we
    drop it before it enters protocol stack :
    - softnet backlog full (accounted in /proc/net/softnet_stat)
    - bad vlan tag (not accounted)
    - unknown/unregistered protocol (not accounted)

    We can handle a per-device counter of such dropped frames at core =
level,
    and automatically adds it to the device provided stats (rx_dropped), =
so
    that standard tools can be used (ifconfig, ip link, cat =
/proc/net/dev)

    This is a generalization of commit 8990f468a (net: rx_dropped
    accounting), thus reverting it.
=E2=80=9C=E2=80=9D=E2=80=9C

For macvlan, the commit 412ca1550cbe ("macvlan: Move broadcasts into a =
work queue=E2=80=9D) added the dev->rx_dropped. The macvlan supported =
the  @pcpu_stats.
For ipvlan, the commit  ba35f8588f47 ("ipvlan: Defer multicast / =
broadcast processing to a work-queue=E2=80=9D) added the =
dev->rx_dropped. The ipvlan supported the  @ ipvl_pcpu_stats.
For bonding, the commit 31aa860e0aaf ("bonding: add bond_tx_drop() =
helper=E2=80=9D) added the dev->rx_dropped.

None of the patches strongly indicate that @core_stats must be used.

Any thoughts @Eric, @Jakub ?

>=20
> Thanks,
> Jason



