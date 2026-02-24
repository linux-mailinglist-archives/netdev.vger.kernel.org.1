Return-Path: <netdev+bounces-260345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zs0kKmlAnWnhNwQAu9opvQ
	(envelope-from <netdev+bounces-260345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:08:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A963D1824D7
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AA373041793
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 06:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4BA2C234A;
	Tue, 24 Feb 2026 06:08:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CE12BEC30
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 06:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771913318; cv=none; b=UMucxLQWUjDlGhEWL1pbTsdVsCARoUHXvxbjGNULi7LMeJcXsAfezf6o1Yr30B4sicRVqZPE4mGIIQqL/fMtC6Eh97QcTBH4w7fMGQjUPUUmutPJYoJx1rf6s8gk5X1tjLXLXVv8No1OS5qpDAsX5ps2AKsEDcMgl2kRxKASvaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771913318; c=relaxed/simple;
	bh=VAj9kbPETBNsWrMK5gCYixM1Apuugs325iZbCAxVz+M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qYZA+CQN81647gBZyOuZ8tN3iaaXcPCnAqCv9AsoOO4kEs8M6sRfKHm3AQMInBV9vhA2eqYJTZwKdwA3DMNNOP4doT66+Bbb6tkuzjvKMEJAhq953HHS1xo/lUvofvfaQh1imuICJ040LYRtW4bPZz/oxMhdtJk+aEEF7YdTDQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz11t1771913302tb3960078
X-QQ-Originating-IP: mJ0LBz5GV4jTWzWuGrfZ7dYYUO9F8ZnaBA26DDCsnWc=
Received: from smtpclient.apple ( [120.244.235.1])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Feb 2026 14:08:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5911316792364236988
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
In-Reply-To: <CAL+tcoDzik63K1aqpDTn7K6Jkta5ZtjedTQ58TB455+pwkq8Pw@mail.gmail.com>
Date: Tue, 24 Feb 2026 14:08:09 +0800
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Samiullah Khawaja <skhawaja@google.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3AB6E925-3A2E-439D-8432-B00F4DEFE7F1@bamaicloud.com>
References: <e8355c0d7fd48981ba505e455387971f91210fa8.1771734206.git.tonghao@bamaicloud.com>
 <CAL+tcoDR2-WTmhBakWcvEuLCwAU7RGRA8syfor-+RJJq7_ZOKw@mail.gmail.com>
 <65307E32-7AFF-44EF-B2BB-89AA15F3D0D1@bamaicloud.com>
 <CAL+tcoB0uV0E9cDCfw58kAuzNcanstx_OT3h=dkQVOW1b-nN+A@mail.gmail.com>
 <C914CAC5-AEF2-4814-84FC-30EA4B70F832@bamaicloud.com>
 <CAL+tcoDzik63K1aqpDTn7K6Jkta5ZtjedTQ58TB455+pwkq8Pw@mail.gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NLH1RjbartcJcji+fOcoQMYQ0Q4jKIDQPMccooIlk0/lmqieOG31r1G/
	eGTmQeI8q2QXlmFIHheeH3aL91ai6weWCTenMBUNPcY0Yadn0uIQ39H5HXGHaJv1YkLIbqE
	otduRstq52LlhfsnutfwtcqJYtxVW3Yqy9qNKuPjeXcyKbDjvqCyLFul5/Prp6vx/QVN8gY
	ShpHJYSgWNTMsq75B/3D4kxL2SjXYbzZW27tSLPCtIgMp7UN2pw4kR9f1mPy97YdP3+bp3A
	hPfxWeq13urFbJwQ/aoT2QC/2Ift04U3uC0NNZPQzmrcs6esMvKHion9Qj4Jw3bbajBlMEA
	Q8VbIb4Gp1DYlMxTY7Sr5W/9YZ+62l83Ahyhhq8v3RrmFLapKfByYmg3IXTflBrhFV5hQJu
	Lp5UUL6+h8Z3VNJGm/GNR1U9ni8xcCFdTt9fMUF+EKohQeEvGHkG12qFyDfif8q8nRmMwtO
	8b1MrfBE+7RIzEvRpnXv69Kee0p+bSwYcrluEOGfw1d1W2g2sCAzJQJiPXaGyB1Ut2UQrN9
	GTRwpHjV7wGQr6D5TyqT9jlNYFNiS0tOnzD1ZFUhHrDnuWV7l57i+bxFIvYnJMNqcfXLjVz
	i4LOktIWzy1anc/0sp9tnc8dqVyvpF3QWPrSE0WWfxaYyIZsPmbpgYp6Ii3ILqK5//ldJ34
	ppiSrYUNlyiI20u1b+ut/2GvxGV2HIEV2Wl33cuCL6RNXcLDakki1RuEaE4mPrR84pEn22L
	P0PD92zaFwE+FM2ErgsBuvPH5oRp8T1RXwNBOdAcXO+xB5nKbNCRzRqez0SqiM6W/qQ7AYE
	wXlHP12qmSvkGIuZfgY4X6jwEo4rF9JD4FeGq8T5crodzOr9s7k7/VJc7S4rKT5qGeZ1iaQ
	Ydqq1F57XZxL46HVGs9kpnfEkzMnO1kRxBiwWdQiSOoO6aPCYNsQ/8rqEopeLZ6ew2Lxe9n
	JssnypB6M1yJARUVJheduQl87awuXbpgge66m+wSK2mNOsiYl/1sbjNdNYb/04qmE9thhyy
	yF/z3CC4HOxBpR7vlrO/oL7oJSyXhonBvDSKcoLU8cvXNc48k/kZYTRuUFBHw1naadlWVxa
	vA0lyjSGQRs
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[bamaicloud.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260345-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tonghao@bamaicloud.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,bamaicloud.com:mid,bamaicloud.com:email,fomichev.me:email]
X-Rspamd-Queue-Id: A963D1824D7
X-Rspamd-Action: no action



> On Feb 24, 2026, at 13:28, Jason Xing <kerneljasonxing@gmail.com> =
wrote:
>=20
> On Tue, Feb 24, 2026 at 12:07=E2=80=AFPM Tonghao Zhang =
<tonghao@bamaicloud.com> wrote:
>>=20
>>=20
>>=20
>>> On Feb 24, 2026, at 11:52, Jason Xing <kerneljasonxing@gmail.com> =
wrote:
>>>=20
>>> On Tue, Feb 24, 2026 at 11:22=E2=80=AFAM Tonghao Zhang =
<tonghao@bamaicloud.com> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On Feb 23, 2026, at 08:20, Jason Xing <kerneljasonxing@gmail.com> =
wrote:
>>>>>=20
>>>>> On Sun, Feb 22, 2026 at 12:38=E2=80=AFPM Tonghao Zhang =
<tonghao@bamaicloud.com> wrote:
>>>>>>=20
>>>>>> Network device statistics retrieved via procfs, sysfs, and =
netlink
>>>>>> represent the combined total of core_stats + driver, hardware =
statistics.
>>>>>>=20
>>>>>> However, in some scenarios, when monitoring netdev metrics, it is =
valuable
>>>>>> to clearly distinguish whether the values originate from the =
networking
>>>>>> stack's core statistics or from the driver, hardware layer. This =
helps
>>>>>> improve debugging and addressing issues.
>>>>>>=20
>>>>>> Approaches were considered:
>>>>>> - commit 5247dbf16cee ("net/core: Introduce =
netdev_core_stats_inc()").
>>>>>> This allows tracking increments to core_stats and helps identify =
specific
>>>>>> causes of changes, but not provide the total counters.
>>>>>> - extending rtnl_link_stats64 with new core_xxx fields.
>>>>>> This would likely confuse or break existing userspace =
applications relying
>>>>>> on this struct.
>>>>>> - adding a tracepoint inside dev_get_stats().
>>>>>> This implementation is not simple or straightforward enough.
>>>>>>=20
>>>>>> The solution in this patch is therefore to introduce a new =
dedicated function
>>>>>> for collecting core statistics and mark it noinline. This =
approach is simple,
>>>>>> clean, and maintainable to obtain driver, hardware statistics =
separately when needed.
>>>>>>=20
>>>>>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>>>>>> Cc: "David S. Miller" <davem@davemloft.net>
>>>>>> Cc: Eric Dumazet <edumazet@google.com>
>>>>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>>>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>>>>> Cc: Simon Horman <horms@kernel.org>
>>>>>> Cc: Stanislav Fomichev <sdf@fomichev.me>
>>>>>> Cc: Kuniyuki Iwashima <kuniyu@google.com>
>>>>>> Cc: Samiullah Khawaja <skhawaja@google.com>
>>>>>> Cc: Ahmed Zaki <ahmed.zaki@intel.com>
>>>>>> Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
>>>>>=20
>>>>> It's a simple refactor patch that only moves that logic to a new
>>>>> helper. I don't see any new possible callers right now so could =
you
>>>>> provide more straightward/clear use cases and intentions behind =
this
>>>>> patch? For example, give us what kind of dumping stats you want to
>>>>> tweak and your next movements.
>>>> Thanks, Jason
>>>> This patch tries to add one helper function which marked as =
noinline for bpf tracing (this commit 5247dbf16cee also use the noinline =
for tracing). This helper is not used other place in kernel.
>>>>=20
>>>> For example,
>>>> sudo bpftrace -e '
>>>> kprobe:netdev_core_stats_fetch {printf("%d\n", ((struct =
rtnl_link_stats64 *)arg1)->rx_dropped);}
>>>> kretprobe:netdev_core_stats_fetch {printf("%d\n", ((struct =
rtnl_link_stats64 *)retval)->rx_dropped);}
>>>> '
>>>=20
>>> Can't we use the global symbol dev_get_stats() instead? It should be =
the same.
>>=20
>> - if kprobe the dev_get_stats(), the rtnl_link_stats64 *storage is =
not used by drivers (ndo_get_stats64, ndo_get_stats..,), the rx_dropped, =
for example, is 0.
>=20
> How about computing the delta of @storage->xxx between two consecutive
> kretprobes hitting this function? And you can also identify the source
> of @storage as you hope.
>=20
>> But kprobe the new helper netdev_core_stats_fetch(), the data is from =
drivers.
>> - if kretkprobe the dev_get_stats(), the rtnl_link_stats64 * retval =
is sum of counter from driver and core_stats. This data is same as =
kretprobe the netdev_core_stats_fetch().
>=20
> Sorry, I see no difference before/after your patch. The @storage is
> always initialized within dev_get_stats(), so how would it be
> different with your patch applied?
If tracing the dev_get_stats() with kprobe and kretprobe,
sudo bpftrace -e '
  kprobe:dev_get_stats {printf("%d\n", ((struct rtnl_link_stats64 =
*)arg1)->rx_dropped);} // the @arg1 is not initialized by =
dev_get_stats() now
  kretprobe:dev_get_stats {printf("%d\n", ((struct rtnl_link_stats64 =
*)retval)->rx_dropped);} // the @retval is rtnl_link_stats64 *, which =
rx_dropped =3D rx_dropped of drivers + rx_dropped of core_stats
=E2=80=98
The delta makes no sense.

With this patch
sudo bpftrace -e '
  kprobe:netdev_core_stats_fetch {printf("%d\n", ((struct =
rtnl_link_stats64 *)arg1)->rx_dropped);} // @arg1 is initialized by =
drivers, e.g. ndo_get_stats64, ndo_get_stats.=20
  kretprobe:netdev_core_stats_fetch {printf("%d\n", ((struct =
rtnl_link_stats64 *)retval)->rx_dropped);} // the @retval is =
rtnl_link_stats64 *, which rx_dropped =3D rx_dropped of drivers + =
rx_dropped of core_stats=20
=E2=80=98
So when kprobe:netdev_core_stats_fetch, the @storage is from driver, =
e.g. ndo_get_stats64, ndo_get_stats.  The delta (core_stats) is @retval =
- @arg1


>=20
> Thanks,
> Jason



