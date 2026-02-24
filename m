Return-Path: <netdev+bounces-260340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI6sFEM3nWlINQQAu9opvQ
	(envelope-from <netdev+bounces-260340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 06:29:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B53C181E58
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 06:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF3013075F81
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 05:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46241286889;
	Tue, 24 Feb 2026 05:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYiFuPNV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD50E2356BE
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 05:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771910976; cv=pass; b=cXbstsXpJHPpY27HDq55Cwvb5mSgp5LkQ5i9Em382RNLyGW5WVlTk3xNajXsdCzOuejoU2q2bIOdAPoriSGGT+0V3IhSdBGvvzGTX8p2ChSwLoeTL+OrWaw5w7HfqoyCkHUqDVks2QxVwzViB+ytTH8IlNbX2DKF6Z7vPGXy+kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771910976; c=relaxed/simple;
	bh=vkK3UUMfHkTefzp80CVCSVG+4yqTQJyxuccLmqWw1Go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLKO0l6nKkSb0mD3lwE/9vKjFUjeQoamvJwf8Tib3h16Ipwewbeu9gXXN6nxRrqL0XRnS/ndjrgnCMKzJJL/Cc1IzfgFyMVscWB+q2dcTpARuuLqOog0mUDiD8O34NLb6ddBniRT6IX1oJG5aGmPSZvtZIzLtS3CBAv3y8pnA4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYiFuPNV; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59e5bfa4f33so4828106e87.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 21:29:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771910973; cv=none;
        d=google.com; s=arc-20240605;
        b=XzDr2xSZaEl2yPTCnzm1FEBrYX08l48eknWG5Mo7qD1vIGepEKOa2rciZNPZaoKu6k
         MmdNK/cm/xxybEppi1+4TkoPKK8KL+GSF233gbcGXoJ5A/ms21x2WTaqmfBFCAVew8A0
         qE4YJjU2i/kdIcWSoM3hCmAHjlHgRJOoRGVtTlcqElCgtZBFnhksue765tcHv2MFeY5u
         Vuulp5GoWKxiixTyaCPJSk/VVW776FFObA+X4VuTSLsKvATk2h1WArvb/4dZXEkmqrlc
         k+C+rfHU2XF+BPsE5sgWqY9xA9yU9grTNm4b2PvtaKuSFHi7qiD5o6X8A6JbMvnQG9YI
         IGiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1h+lZ0n0ehHRVBAxVMEwlVJTl5LDmlpfxk6Paq8HaIg=;
        fh=JMB8IKbAFaonXyxNJj4R1l6G9j8SsDOe4nbhhObNHGk=;
        b=AtfVO1fmF2NAt2ZR7WqbGZwGXgr0nRA6X7BuLOBc4umlAQlCYuu9VYXawQDeGwtrEW
         DxHa/rr1tEDVBeQlei0cSqZB7kFQQ8uG9FUgYbzVi8ykQY6zN2PP0NR8CKIwmWotj9JK
         OZng71tFIkxdvOFA+LIegHRunzTIgiS3b1ioNiuFAjoSXG3aHpc27RICIg5vZVVc3QTt
         wgyyVy03/BeHgvV5A9ZtApWd+n2lpPRI2JcGKSzWPkf4h6B85VANhY1gF5uhOXqkptKC
         5hA5zpoZYbl+Tqi0tdl6sJ0Cj5J+WKx0As+YPiX054sjRFcbZXmENIWh3Wl2Ulx2i0OX
         ETiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771910973; x=1772515773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1h+lZ0n0ehHRVBAxVMEwlVJTl5LDmlpfxk6Paq8HaIg=;
        b=gYiFuPNVUr3xaIGJPyfVxYUp8EXH24k30w16XN2z2HTcYy77RPB6RESor+MC3MOvIe
         3DCDiWCDK8eitSG5CebqOAVGWud560fTWHt0z4lk6c9UBMfGpQeuK5XM4lySwcTV8xbc
         iUjs/WmpppxM3WcwH9zJu/cFJNq1EOtPSt/rfnr4HsFOIO8atiY4BIWF6aF52TY0NqhE
         G8pHHmFAF7Wn9DS+uDDEOAPUls2L26MVMo4B4fEF9a9pjEPVVaGiOw/SXf7uwqjYr1Dh
         rqum2eXc4FqsXXbxgpMkY5ItGZhbIJLi8NfB1BdodUU5p0ybEOH5j5a5y/vDB3d8VEHV
         vMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771910973; x=1772515773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1h+lZ0n0ehHRVBAxVMEwlVJTl5LDmlpfxk6Paq8HaIg=;
        b=BKuxVHz538C479o8K3WfalQjNJLWpGY5GseyahnQmFjVcb6YMjFxobgAeet7pyOrob
         N4VdjP53WjnANa2AmADDyvuoOIXOSNpsqE/y5slzoFSxeAPNVCg4Fd59NZolAGC8IB+j
         /WVmUoq2TfMM2CZ7s4rL3bhVuRv2ipUzx69th2Z3paoc4eQHKdfSJW8aeEK0X/+zAE6z
         QbIbSeOEtlIKwAS+6AP+DQhi0f0+yL3vUbE1PF1yzvVCXqjosmwQ+rczvDiVZXwQ+TIp
         h4ri86HYBGwQr0a6SRUh6zDm2/vrlj+M4ZMBHUQw56WvJzQ8l/VQpmB7fhi7XY+KcEX3
         KNKw==
X-Gm-Message-State: AOJu0Yz2EyaEJ6TfXVm7SmF9z2CKiy58pjzM4UDaZI5e3fosWLAyaghU
	4So6qn9IVQyv0FPubDjJOUydnLxZAe0ItDa+04oprtUx0UVA9RMmt+bk4QC2HSrygmAUQcMiOL/
	9wfbi4+viRLyU2kp0LvdAVh10i9cZfFU=
X-Gm-Gg: ATEYQzzXspfbtgm5u+PQibsfbF4OPX3sUhqa+buXZgxBZs89dq491l7sKxQFBeq/6EI
	O/unNn0X6R98ePgpipAsqKTmVHbTnXutkoXR+wPQ7XRN9bNmDFGv3XIbXn5Or5C3VsShNejFxXQ
	50y5GlVeH/uLllahlEBLjQ4o8VE0NACTLYHQeD2ZFp3+VXMnAUdyR/wJq3KlbBww1ou/tumg9Jr
	3REfjbzkxGnaahK8U9WuJaLV0yaRxCsuATz31mmMSjJY+2EToSd2v2uHGtoXj4OxRNebNHMLKwc
	OwAV9zFt
X-Received: by 2002:a05:6512:3b20:b0:59d:dca7:b4eb with SMTP id
 2adb3069b0e04-5a0ed881ba8mr3799622e87.16.1771910972587; Mon, 23 Feb 2026
 21:29:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e8355c0d7fd48981ba505e455387971f91210fa8.1771734206.git.tonghao@bamaicloud.com>
 <CAL+tcoDR2-WTmhBakWcvEuLCwAU7RGRA8syfor-+RJJq7_ZOKw@mail.gmail.com>
 <65307E32-7AFF-44EF-B2BB-89AA15F3D0D1@bamaicloud.com> <CAL+tcoB0uV0E9cDCfw58kAuzNcanstx_OT3h=dkQVOW1b-nN+A@mail.gmail.com>
 <C914CAC5-AEF2-4814-84FC-30EA4B70F832@bamaicloud.com>
In-Reply-To: <C914CAC5-AEF2-4814-84FC-30EA4B70F832@bamaicloud.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 24 Feb 2026 13:28:55 +0800
X-Gm-Features: AaiRm50pXEAY0LY_UAyhM-1G2NXtOJr_UEA4oYxVt4xdep-b3MKofmpG9oNtwww
Message-ID: <CAL+tcoDzik63K1aqpDTn7K6Jkta5ZtjedTQ58TB455+pwkq8Pw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: core: introduce the netdev_fetch_core_stats()
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Ahmed Zaki <ahmed.zaki@intel.com>, Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260340-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid,fomichev.me:email,davemloft.net:email]
X-Rspamd-Queue-Id: 6B53C181E58
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 12:07=E2=80=AFPM Tonghao Zhang <tonghao@bamaicloud.=
com> wrote:
>
>
>
> > On Feb 24, 2026, at 11:52, Jason Xing <kerneljasonxing@gmail.com> wrote=
:
> >
> > On Tue, Feb 24, 2026 at 11:22=E2=80=AFAM Tonghao Zhang <tonghao@bamaicl=
oud.com> wrote:
> >>
> >>
> >>
> >>> On Feb 23, 2026, at 08:20, Jason Xing <kerneljasonxing@gmail.com> wro=
te:
> >>>
> >>> On Sun, Feb 22, 2026 at 12:38=E2=80=AFPM Tonghao Zhang <tonghao@bamai=
cloud.com> wrote:
> >>>>
> >>>> Network device statistics retrieved via procfs, sysfs, and netlink
> >>>> represent the combined total of core_stats + driver, hardware statis=
tics.
> >>>>
> >>>> However, in some scenarios, when monitoring netdev metrics, it is va=
luable
> >>>> to clearly distinguish whether the values originate from the network=
ing
> >>>> stack's core statistics or from the driver, hardware layer. This hel=
ps
> >>>> improve debugging and addressing issues.
> >>>>
> >>>> Approaches were considered:
> >>>> - commit 5247dbf16cee ("net/core: Introduce netdev_core_stats_inc()"=
).
> >>>> This allows tracking increments to core_stats and helps identify spe=
cific
> >>>> causes of changes, but not provide the total counters.
> >>>> - extending rtnl_link_stats64 with new core_xxx fields.
> >>>> This would likely confuse or break existing userspace applications r=
elying
> >>>> on this struct.
> >>>> - adding a tracepoint inside dev_get_stats().
> >>>> This implementation is not simple or straightforward enough.
> >>>>
> >>>> The solution in this patch is therefore to introduce a new dedicated=
 function
> >>>> for collecting core statistics and mark it noinline. This approach i=
s simple,
> >>>> clean, and maintainable to obtain driver, hardware statistics separa=
tely when needed.
> >>>>
> >>>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> >>>> Cc: "David S. Miller" <davem@davemloft.net>
> >>>> Cc: Eric Dumazet <edumazet@google.com>
> >>>> Cc: Jakub Kicinski <kuba@kernel.org>
> >>>> Cc: Paolo Abeni <pabeni@redhat.com>
> >>>> Cc: Simon Horman <horms@kernel.org>
> >>>> Cc: Stanislav Fomichev <sdf@fomichev.me>
> >>>> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> >>>> Cc: Samiullah Khawaja <skhawaja@google.com>
> >>>> Cc: Ahmed Zaki <ahmed.zaki@intel.com>
> >>>> Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
> >>>
> >>> It's a simple refactor patch that only moves that logic to a new
> >>> helper. I don't see any new possible callers right now so could you
> >>> provide more straightward/clear use cases and intentions behind this
> >>> patch? For example, give us what kind of dumping stats you want to
> >>> tweak and your next movements.
> >> Thanks, Jason
> >> This patch tries to add one helper function which marked as noinline f=
or bpf tracing (this commit 5247dbf16cee also use the noinline for tracing)=
. This helper is not used other place in kernel.
> >>
> >> For example,
> >> sudo bpftrace -e '
> >>  kprobe:netdev_core_stats_fetch {printf("%d\n", ((struct rtnl_link_sta=
ts64 *)arg1)->rx_dropped);}
> >>  kretprobe:netdev_core_stats_fetch {printf("%d\n", ((struct rtnl_link_=
stats64 *)retval)->rx_dropped);}
> >> '
> >
> > Can't we use the global symbol dev_get_stats() instead? It should be th=
e same.
>
> - if kprobe the dev_get_stats(), the rtnl_link_stats64 *storage is not us=
ed by drivers (ndo_get_stats64, ndo_get_stats..,), the rx_dropped, for exam=
ple, is 0.

How about computing the delta of @storage->xxx between two consecutive
kretprobes hitting this function? And you can also identify the source
of @storage as you hope.

> But kprobe the new helper netdev_core_stats_fetch(), the data is from dri=
vers.
> - if kretkprobe the dev_get_stats(), the rtnl_link_stats64 * retval is su=
m of counter from driver and core_stats. This data is same as kretprobe the=
 netdev_core_stats_fetch().

Sorry, I see no difference before/after your patch. The @storage is
always initialized within dev_get_stats(), so how would it be
different with your patch applied?

Thanks,
Jason

