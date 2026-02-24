Return-Path: <netdev+bounces-260359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFFqOQ5LnWmhOQQAu9opvQ
	(envelope-from <netdev+bounces-260359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:54:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF04182909
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB29B3009B0F
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 06:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402122F12AF;
	Tue, 24 Feb 2026 06:54:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00B5303A0F
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 06:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771916044; cv=none; b=S9KGmMDczB7srqPoI1grfBO7c2sVjKl5rB64ZkojivkzhxPut3UOUen+zozuN0l0ibZxH6J29aTM0FdJLD6EER/6A/0imCfVF68xpAPnvVp7cUdr3fkfs6o+pbwmRqIEoMAhMIuF6zbQvVl8yr2F0Z1nmCmexYkzzx534olNu3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771916044; c=relaxed/simple;
	bh=FqjsljKGOUcbQBtIqAgJTiWQnFKpJWuneeaTHtnorHg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=o3rBW8KliBEse5sDgTvn7wJRlyAwRCLaAPLptDpj5QmQc6z/BVybfsfyBLQ7WsqlXtfYr/EHZLlWPJWX7gh9MRq9nnuHedWtW6CER55Xcwm3ObfNmFaCoWwhNqu1VQEPyNrCYVVtCElArthytYwlECXp/oK27IT7/lBuX1vGdnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz11t1771916032t2a9e32d1
X-QQ-Originating-IP: anMp73GG1eABcT0WMsAEs9VjvqAbzwg+uGaE3XgCqqQ=
Received: from smtpclient.apple ( [120.244.235.1])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Feb 2026 14:53:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4163282832266608715
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
In-Reply-To: <CAL+tcoD+TL6xbTodAKp=w0NVeLOubxoJpk=-b_8Z0bPvFrzXCQ@mail.gmail.com>
Date: Tue, 24 Feb 2026 14:53:38 +0800
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
Message-Id: <4E09E708-FA5A-4523-8E75-359C3D8B43E6@bamaicloud.com>
References: <e8355c0d7fd48981ba505e455387971f91210fa8.1771734206.git.tonghao@bamaicloud.com>
 <CAL+tcoDR2-WTmhBakWcvEuLCwAU7RGRA8syfor-+RJJq7_ZOKw@mail.gmail.com>
 <65307E32-7AFF-44EF-B2BB-89AA15F3D0D1@bamaicloud.com>
 <CAL+tcoB0uV0E9cDCfw58kAuzNcanstx_OT3h=dkQVOW1b-nN+A@mail.gmail.com>
 <C914CAC5-AEF2-4814-84FC-30EA4B70F832@bamaicloud.com>
 <CAL+tcoDzik63K1aqpDTn7K6Jkta5ZtjedTQ58TB455+pwkq8Pw@mail.gmail.com>
 <3AB6E925-3A2E-439D-8432-B00F4DEFE7F1@bamaicloud.com>
 <CAL+tcoD+TL6xbTodAKp=w0NVeLOubxoJpk=-b_8Z0bPvFrzXCQ@mail.gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MZ9fszcLiRfaQEDYE2+IDTbkfUriVVjWeaZHex4zLcwRSi4P4iGojUAj
	KAjLfQouPydajB/uW+gttz6ppyNoXOuPh44rayejBd4qqrp2HoS+8S7pi8fBSNKBAUULl42
	LiYoRE9JiLSuKLz+LqXCj27pI7gv0SaBwgVi/W4WqwF5db97oHUTJlWRz0jpwA/7faKnark
	JuLM7eGmcmnoAsC5Q1U1iZFcbrhAj95z3jD/d8yi6vNwfGQYOsbZ9FKZs/0+odtAqDOScVV
	/fj60LUGtWcwTXhPwqWdR85Z+pPV8vwT1by3BB/h4Vh8l/QlYl1Ht/c65n4nQeu48svSLBr
	XKDSvcPFjF4jtBRqfFE94HyXs6mDWkC0Klwj+TnbYATRis/G686H2tBMOGucxxotNLg2/FW
	DX2lBP5WP4D2wPe3E6wNEk+oVlIMh5oK5bxEkoUCuFcjpJR/zUjeG9HKBpdbRgVJXODGjqy
	tNCEFVCeiC0wMJFT+aX3F47oQOGTOGf7WQQrf6LIrVCRe25FPo7PNPOmUFwWkypCEPFhTip
	g3l/jkqa+UYp/ZqJAHhpoPC8WsTgiJI9UKm84qyXKGdPXMlJa3+gg6clzS8cLnqTTRUcru/
	9VtiEe8jyMqw8SlU708gLLSliptOuLMdxPp7vsBezJM7KkMHu04vGLvCmF6ATgx7AdFrS5s
	o0J/WqWBaYC4rm2s0nwqU/+J2o6O9w4cxTMWKXsxCY+M2Tm5QYoPzG4S8WJ83A3JOCXwjJA
	DUY7t6kdUUXtFm1N8lG/jvAbD1cvEcqQYRKdDw/rixSjKHwHQyCwg2vjWbCl+ZfwVLOq/ph
	EWhLMtXjH2Q5/8Nn9ZlDvXOi/7mWsp1DKau3R/+PfEDrGwcg4sOadbSGHWYmmV5N4BhCYtx
	YV8nTXdS6GWwInZdMQYljHyynZ9Z/f6P1mBpUIQTITl8GhUBq1PsEK6TB4NgIL+zMBPGQmG
	qcdOcMyxby280KLyuPurBu3xngPpoQelCIf/d259Hh7u01tdfITUjh3n0FR+FqaaO+8R80h
	pKmAP3Jbu2zRd2mUIKomk+mqSGR1PqFDQGRHJJkUYPCfk0ZLp5kFyoc0U1m4QsCKrYsGCGA
	hdytokgDUYQ
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260359-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[bamaicloud.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tonghao@bamaicloud.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.994];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2CF04182909
X-Rspamd-Action: no action



> On Feb 24, 2026, at 14:24, Jason Xing <kerneljasonxing@gmail.com> =
wrote:
>=20
> On Tue, Feb 24, 2026 at 2:08=E2=80=AFPM Tonghao Zhang =
<tonghao@bamaicloud.com> wrote:
>>=20
>>=20
>>=20
>>> On Feb 24, 2026, at 13:28, Jason Xing <kerneljasonxing@gmail.com> =
wrote:
>>>=20
>>> On Tue, Feb 24, 2026 at 12:07=E2=80=AFPM Tonghao Zhang =
<tonghao@bamaicloud.com> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On Feb 24, 2026, at 11:52, Jason Xing <kerneljasonxing@gmail.com> =
wrote:
>>>>>=20
>>>>> On Tue, Feb 24, 2026 at 11:22=E2=80=AFAM Tonghao Zhang =
<tonghao@bamaicloud.com> wrote:
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>>> On Feb 23, 2026, at 08:20, Jason Xing =
<kerneljasonxing@gmail.com> wrote:
>>>>>>>=20
>>>>>>> On Sun, Feb 22, 2026 at 12:38=E2=80=AFPM Tonghao Zhang =
<tonghao@bamaicloud.com> wrote:
>>>>>>>>=20
>>>>>>>> Network device statistics retrieved via procfs, sysfs, and =
netlink
>>>>>>>> represent the combined total of core_stats + driver, hardware =
statistics.
>>>>>>>>=20
>>>>>>>> However, in some scenarios, when monitoring netdev metrics, it =
is valuable
>>>>>>>> to clearly distinguish whether the values originate from the =
networking
>>>>>>>> stack's core statistics or from the driver, hardware layer. =
This helps
>>>>>>>> improve debugging and addressing issues.
>>>>>>>>=20
>>>>>>>> Approaches were considered:
>>>>>>>> - commit 5247dbf16cee ("net/core: Introduce =
netdev_core_stats_inc()").
>>>>>>>> This allows tracking increments to core_stats and helps =
identify specific
>>>>>>>> causes of changes, but not provide the total counters.
>>>>>>>> - extending rtnl_link_stats64 with new core_xxx fields.
>>>>>>>> This would likely confuse or break existing userspace =
applications relying
>>>>>>>> on this struct.
>>>>>>>> - adding a tracepoint inside dev_get_stats().
>>>>>>>> This implementation is not simple or straightforward enough.
>>>>>>>>=20
>>>>>>>> The solution in this patch is therefore to introduce a new =
dedicated function
>>>>>>>> for collecting core statistics and mark it noinline. This =
approach is simple,
>>>>>>>> clean, and maintainable to obtain driver, hardware statistics =
separately when needed.
>>>>>>>>=20
>>>>>>>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>>>>>>>> Cc: "David S. Miller" <davem@davemloft.net>
>>>>>>>> Cc: Eric Dumazet <edumazet@google.com>
>>>>>>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>>>>>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>>>>>>> Cc: Simon Horman <horms@kernel.org>
>>>>>>>> Cc: Stanislav Fomichev <sdf@fomichev.me>
>>>>>>>> Cc: Kuniyuki Iwashima <kuniyu@google.com>
>>>>>>>> Cc: Samiullah Khawaja <skhawaja@google.com>
>>>>>>>> Cc: Ahmed Zaki <ahmed.zaki@intel.com>
>>>>>>>> Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
>>>>>>>=20
>>>>>>> It's a simple refactor patch that only moves that logic to a new
>>>>>>> helper. I don't see any new possible callers right now so could =
you
>>>>>>> provide more straightward/clear use cases and intentions behind =
this
>>>>>>> patch? For example, give us what kind of dumping stats you want =
to
>>>>>>> tweak and your next movements.
>>>>>> Thanks, Jason
>>>>>> This patch tries to add one helper function which marked as =
noinline for bpf tracing (this commit 5247dbf16cee also use the noinline =
for tracing). This helper is not used other place in kernel.
>>>>>>=20
>>>>>> For example,
>>>>>> sudo bpftrace -e '
>>>>>> kprobe:netdev_core_stats_fetch {printf("%d\n", ((struct =
rtnl_link_stats64 *)arg1)->rx_dropped);}
>>>>>> kretprobe:netdev_core_stats_fetch {printf("%d\n", ((struct =
rtnl_link_stats64 *)retval)->rx_dropped);}
>>>>>> '
>>>>>=20
>>>>> Can't we use the global symbol dev_get_stats() instead? It should =
be the same.
>>>>=20
>>>> - if kprobe the dev_get_stats(), the rtnl_link_stats64 *storage is =
not used by drivers (ndo_get_stats64, ndo_get_stats..,), the rx_dropped, =
for example, is 0.
>>>=20
>>> How about computing the delta of @storage->xxx between two =
consecutive
>>> kretprobes hitting this function? And you can also identify the =
source
>=20
> two consecutive __kretprobes__=E2=80=A6
I got it. In fact, it is not solving the problem. For example, =
@storage->rx_dropped is increasing, but it's impossible to determine =
whether the increase comes from core_stats.rx_dropped, from the =
driver=E2=80=99s rx_dropped, or from both.
>=20
>>> of @storage as you hope.
>>>=20
>>>> But kprobe the new helper netdev_core_stats_fetch(), the data is =
from drivers.
>>>> - if kretkprobe the dev_get_stats(), the rtnl_link_stats64 * retval =
is sum of counter from driver and core_stats. This data is same as =
kretprobe the netdev_core_stats_fetch().
>>>=20
>>> Sorry, I see no difference before/after your patch. The @storage is
>>> always initialized within dev_get_stats(), so how would it be
>>> different with your patch applied?
>> If tracing the dev_get_stats() with kprobe and kretprobe,
>> sudo bpftrace -e '
>>  kprobe:dev_get_stats {printf("%d\n", ((struct rtnl_link_stats64 =
*)arg1)->rx_dropped);} // the @arg1 is not initialized by =
dev_get_stats() now
>>  kretprobe:dev_get_stats {printf("%d\n", ((struct rtnl_link_stats64 =
*)retval)->rx_dropped);} // the @retval is rtnl_link_stats64 *, which =
rx_dropped =3D rx_dropped of drivers + rx_dropped of core_stats
>> =E2=80=98
>> The delta makes no sense.
>=20
> Please look at the last reply, especially the highlighted part. I
> meant every time the function gets called, you can always use
> kretprobe to read any information and then do the math you want.
>=20
> Thanks,
> Jason
>=20
>>=20
>> With this patch
>> sudo bpftrace -e '
>>  kprobe:netdev_core_stats_fetch {printf("%d\n", ((struct =
rtnl_link_stats64 *)arg1)->rx_dropped);} // @arg1 is initialized by =
drivers, e.g. ndo_get_stats64, ndo_get_stats.
>>  kretprobe:netdev_core_stats_fetch {printf("%d\n", ((struct =
rtnl_link_stats64 *)retval)->rx_dropped);} // the @retval is =
rtnl_link_stats64 *, which rx_dropped =3D rx_dropped of drivers + =
rx_dropped of core_stats
>> =E2=80=98
>> So when kprobe:netdev_core_stats_fetch, the @storage is from driver, =
e.g. ndo_get_stats64, ndo_get_stats.  The delta (core_stats) is @retval =
- @arg1



