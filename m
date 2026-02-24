Return-Path: <netdev+bounces-260326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMErBx4knWkkNAQAu9opvQ
	(envelope-from <netdev+bounces-260326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 05:07:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF1F181934
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 05:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D937D30197E1
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 04:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5D926B973;
	Tue, 24 Feb 2026 04:07:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCF5EAC7
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 04:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771906073; cv=none; b=lFl9p86ZEHxlT+IDJWTtJ+YJYSZbVoywJ6RpE+crL78274igOTLW98SuhRCIbAhp3Cyp/ZPydh7KS7JiaDeE2uQ28N8TFR8yBu0muT1q1XjMVc4zcWCzxJ871dWo2cdBouzGvC187FjK6DjmQXEk4MYcCJF2oQu+dcQb0YHeNDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771906073; c=relaxed/simple;
	bh=9kTMC/VmGEDtygaJAPjEwgc3v1W9CgQqQ2RCAD4Wnxw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=F0WwR74aTtgKCT/Yz6yXZVYqF9igBsDtN0Ajb1ujagTM6fV+nUtRtq27ZTznKIkL9G/lr+nqyPw4QAHE6bkRcQk78YKLIcjWnfwWDuCQORe/3yv1E3wieQIIzDdVDtMDsHDd5qn/wC8NfzB8IWKSU/2Eg/mgppj/qbMdb9ELQVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz8t1771906056tee728449
X-QQ-Originating-IP: TKwYudfFrw/MJpuIrUfNE7CWXqvJWOoR9zhdQsfQvYI=
Received: from smtpclient.apple ( [120.244.235.1])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Feb 2026 12:07:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1791210751675684703
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
In-Reply-To: <CAL+tcoB0uV0E9cDCfw58kAuzNcanstx_OT3h=dkQVOW1b-nN+A@mail.gmail.com>
Date: Tue, 24 Feb 2026 12:07:23 +0800
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
Message-Id: <C914CAC5-AEF2-4814-84FC-30EA4B70F832@bamaicloud.com>
References: <e8355c0d7fd48981ba505e455387971f91210fa8.1771734206.git.tonghao@bamaicloud.com>
 <CAL+tcoDR2-WTmhBakWcvEuLCwAU7RGRA8syfor-+RJJq7_ZOKw@mail.gmail.com>
 <65307E32-7AFF-44EF-B2BB-89AA15F3D0D1@bamaicloud.com>
 <CAL+tcoB0uV0E9cDCfw58kAuzNcanstx_OT3h=dkQVOW1b-nN+A@mail.gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OOH866owL+lwAcrOZlDtiT+e6sSJTokX8jG9SUnMklBRy1IYWJ7exVdY
	imHZy8eNansP4wJC9ngmiSw0euX4yyReGiLEH7ykX/aNaVTjQ57vuFJoM/b3SsG2+0zoZgx
	7iLAUOlcvd/T6HS/dEcphYNu0ez07D1i+/3p3aSZddk3RipOO+Gcal95jAaSye7WSg2HzVd
	/9UeNV/qTi/3LUQNkUoUqo92gxrGechwhHgGvCJDJ+e3wxQP9dCeLQq/FP9pF1jOWls9i6M
	t+Du6tytTQz09gariGeIf8ZPkpalk5CZ1kSdMUXI9Jc8jy2vCCvt1RD9SWXNkn5KyoxBSNR
	ax5lL/p/KMaTwnNVD4a7LmOJ4rmhOXn1Clc8WQxROxT6ISUO2U7QdsNMhuaCaOPhLzsC+qu
	MliEi40S8zg8d4GVLZQidYz6apl5kkEB41zE3e2N6X3YPTwgUfkscrD3+A65aGlauv7frVj
	EUWqvtVAn4+NQYmCvQ6R3GKRQK/29wxueL9jW4Q0ApiOd4louHxLe9SC9N4v98PteIrSrLB
	O+l24VOmmuan6Xzg12tz5yqophJoUaeeldKhpiBYikYV9Yx+/n3kim2Nqgqq4fBNCMebkDl
	jvA2U12GbShdv1ODypiUZeSz5HuHDkC5v4cLssHR4yZHxmwG/LHxxeHlBZSTcDx4/+qO2Uk
	uwv5dmX4xE+nXlz3KHl3zJWLckyE3/4Hmm80g1zbm8FIIiuMicpDSsVSgaxrWdqLKhSgNFP
	tsC2vSAxTuIuQy0y4TBDAOKbSy1e9b8Dwc5lhmQctldMCJrwgi6cF37xMZVjBT+Wfob1kQc
	4yfC54BwuUscif0ao+KMtmNp5tPhDhwAu469Slzr2n6UlwntkXsJ7DbU34bAEK5sIWDpfpP
	ii+6QyKFtij4rog7hikWEU6iAHZ/Je317XpUvcwdfYZgjW2p9jcUchHzpkqySbnmVH5FFFS
	feSyRf866BbO4MzGyhh754kEeH5s4PKHTfUFxa2qL4UxFKQVqauhJIEhpbpew4kMUhj7z1t
	8oF/LDbz/lucbzRkO5xmolqW5EKFMP46hRIm6dl66ziw49dFQYNn5K47dm73td5LIYP+oDs
	lkG2Gacd4lrKI8qLd+OC4A=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[bamaicloud.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260326-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tonghao@bamaicloud.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,davemloft.net:email]
X-Rspamd-Queue-Id: 2AF1F181934
X-Rspamd-Action: no action



> On Feb 24, 2026, at 11:52, Jason Xing <kerneljasonxing@gmail.com> =
wrote:
>=20
> On Tue, Feb 24, 2026 at 11:22=E2=80=AFAM Tonghao Zhang =
<tonghao@bamaicloud.com> wrote:
>>=20
>>=20
>>=20
>>> On Feb 23, 2026, at 08:20, Jason Xing <kerneljasonxing@gmail.com> =
wrote:
>>>=20
>>> On Sun, Feb 22, 2026 at 12:38=E2=80=AFPM Tonghao Zhang =
<tonghao@bamaicloud.com> wrote:
>>>>=20
>>>> Network device statistics retrieved via procfs, sysfs, and netlink
>>>> represent the combined total of core_stats + driver, hardware =
statistics.
>>>>=20
>>>> However, in some scenarios, when monitoring netdev metrics, it is =
valuable
>>>> to clearly distinguish whether the values originate from the =
networking
>>>> stack's core statistics or from the driver, hardware layer. This =
helps
>>>> improve debugging and addressing issues.
>>>>=20
>>>> Approaches were considered:
>>>> - commit 5247dbf16cee ("net/core: Introduce =
netdev_core_stats_inc()").
>>>> This allows tracking increments to core_stats and helps identify =
specific
>>>> causes of changes, but not provide the total counters.
>>>> - extending rtnl_link_stats64 with new core_xxx fields.
>>>> This would likely confuse or break existing userspace applications =
relying
>>>> on this struct.
>>>> - adding a tracepoint inside dev_get_stats().
>>>> This implementation is not simple or straightforward enough.
>>>>=20
>>>> The solution in this patch is therefore to introduce a new =
dedicated function
>>>> for collecting core statistics and mark it noinline. This approach =
is simple,
>>>> clean, and maintainable to obtain driver, hardware statistics =
separately when needed.
>>>>=20
>>>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>>>> Cc: "David S. Miller" <davem@davemloft.net>
>>>> Cc: Eric Dumazet <edumazet@google.com>
>>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>>> Cc: Simon Horman <horms@kernel.org>
>>>> Cc: Stanislav Fomichev <sdf@fomichev.me>
>>>> Cc: Kuniyuki Iwashima <kuniyu@google.com>
>>>> Cc: Samiullah Khawaja <skhawaja@google.com>
>>>> Cc: Ahmed Zaki <ahmed.zaki@intel.com>
>>>> Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
>>>=20
>>> It's a simple refactor patch that only moves that logic to a new
>>> helper. I don't see any new possible callers right now so could you
>>> provide more straightward/clear use cases and intentions behind this
>>> patch? For example, give us what kind of dumping stats you want to
>>> tweak and your next movements.
>> Thanks, Jason
>> This patch tries to add one helper function which marked as noinline =
for bpf tracing (this commit 5247dbf16cee also use the noinline for =
tracing). This helper is not used other place in kernel.
>>=20
>> For example,
>> sudo bpftrace -e '
>>  kprobe:netdev_core_stats_fetch {printf("%d\n", ((struct =
rtnl_link_stats64 *)arg1)->rx_dropped);}
>>  kretprobe:netdev_core_stats_fetch {printf("%d\n", ((struct =
rtnl_link_stats64 *)retval)->rx_dropped);}
>> '
>=20
> Can't we use the global symbol dev_get_stats() instead? It should be =
the same.

- if kprobe the dev_get_stats(), the rtnl_link_stats64 *storage is not =
used by drivers (ndo_get_stats64, ndo_get_stats..,), the rx_dropped, for =
example, is 0. But kprobe the new helper netdev_core_stats_fetch(), the =
data is from drivers.
- if kretkprobe the dev_get_stats(), the rtnl_link_stats64 * retval is =
sum of counter from driver and core_stats. This data is same as =
kretprobe the netdev_core_stats_fetch().

> Thanks,
> Jason
>=20
>=20


