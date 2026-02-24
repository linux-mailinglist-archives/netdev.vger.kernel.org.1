Return-Path: <netdev+bounces-260350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPrlCmNEnWkMOAQAu9opvQ
	(envelope-from <netdev+bounces-260350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:25:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 954E4182672
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C101F30A009F
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 06:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4972F2EC086;
	Tue, 24 Feb 2026 06:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYv+6rOx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF2B1E3DF2
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 06:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771914285; cv=pass; b=qlndMAmavqd+9MMgxgclBXPOIuV3cdOaRNSLXme9IepnRJx7FnDPFGv+hF+vPMxWGNXqhhd2uMukTsMp4ECOhVXGlFxZIMoQbtfN6OKk77DBrNbkN14gbJJMt3Rck5FTBgFiV4070iTUr6HTQfO6uBAkdCSb3QWhbTrub+EaQ8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771914285; c=relaxed/simple;
	bh=IaAhbhRoCvkWl0UyC5c8VQLdocDUvPdXplhtBtmtAzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6vcT50SqCoKf+uTZUytG7kLM5nM24RywpkjT2RN+C7J6QHGJachIeHjwVaWNWvO367zIS7oWFTZf2kEi9gzdclypJuVwOnOZa+sFYvHFRxTSyVFMCrerRgX+ONZnvD9ddJbgt5CV9KJIBtcqTW/D/NmjgII3oFaM7M4U0tfKyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYv+6rOx; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59e60b3ccdfso6722096e87.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 22:24:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771914282; cv=none;
        d=google.com; s=arc-20240605;
        b=BL+/XqUx4ivJpEm3EcTVEq1yIhvVKKnKIi2kiEWjK7JBepZkibmCBhgum1Uz+FkVzN
         xjDrSz2QeD4cK4UWIUvXI0qSmu7Gd/5WdA+QlpnKszUapmqXZdy7IU7f6f0t1J/Rxz6P
         pKGZDfQaTuiYxQ/VNMpCUGEaDulXqBjeQo+3lKNQtTqejG+Ts+b1U2Pp3BZWvCIOx7+q
         XW7uIXmfixV17c4Z5J11c1rXr+HWa/sJv1fMF8sxqKkN1jYbQ1aFSSaNsHxafD7zCtqA
         6mnvWnSMvQgaxHQ6XVYgdU4E2pi/VaA0BesGGLSDBBMWsQsh+4r8ZDFKju7jrApIl8O4
         9UTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7oJ5GOxJ9TP46UdtyKVnxV3J3bF2609kJGJegH4bMEk=;
        fh=iimxS/toxw1tqakfW7lgDLfbqHnkLGiu5BceWk1v/ZM=;
        b=DXrnRcBB7/feqHh2BPe39IDvBy4PnNDb7HU+KZFGgaHmB014t66eJFzWkPnRdlB1uE
         jdD/020FQ9k+iEONAZ7QXMqm3XCXPW/uNbZglwtJtWii/zIYHPyFV4sPdVRyJzuiIsV3
         Mu4njLdL6Qp2ss5nWezREVdlsG2FN62coEa2dLoWS2vWK62RCswYNgRGx1ZwXHrIzAhX
         fyXLIpgeG9VViGmiLnXBO+/kqkGqQDXRXdxdD2KhrlPEvJN3JAFmXMiK8l7qSdvdkBZV
         4lj44mvcn+xSHoUw6ohtgGvHf/lCxowmzjyE+2NssHRL1n58yIsgfwL+oJ5qdLIedt/p
         Jqmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771914282; x=1772519082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oJ5GOxJ9TP46UdtyKVnxV3J3bF2609kJGJegH4bMEk=;
        b=MYv+6rOx3I5Y/oiGomWKOU8dLC0a1q787xFq9Bo2A4IP4Sgcdlpwi/OAMLDxiJu/XL
         J+PyLC2miaybkrmYvnaUcAWaIu04ZMhVQvUWT+wb+8ry6JBECXVi5L5La6LuLcyskOVi
         1tZdVcuFGDVPF8u05e+Q0pHAhaWDKSdBCcSm38l8rUSXiqR1v+0ojw1aTIiqIxtm3J5E
         YrtIvFVWX7qUff3rFHgppL0vJFToQC0zML43UFskWVvM34GAaUAQzpMQ5awe6Lin2kwk
         fvlguAOHxS3hVPaFlR7rn+TfC8TlabEBi7ngFnJrnumHEGCpdbrCBB0yMsgT7fHh+veR
         de3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771914282; x=1772519082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7oJ5GOxJ9TP46UdtyKVnxV3J3bF2609kJGJegH4bMEk=;
        b=ftVXlCONpqNyLVG8WL9sc7ljOh45/gSw5pbZJjWZgcuZbx7keYnWutZaCVWdHJ5jLK
         Dwzm/vvw35KirzDUXd9U1Q3Ay5m+7TS39izJRLxAAWNlIX9tv+BawnYeXZbl4OuEM1Ec
         8iviPChxPstKQ3Y02/t2PMOtVt4aW4bfmUZd3bvq0WU7DBHD3CsBm515wefyZHfdlHp8
         19bSQPEc/JmEPpcaYf8SzH3Fmi125EaRshRn6/72frXRGNrjZjLx8ejVh9245NLXIa/i
         H7jtxOnbYqPbwS4fhKuAOK85pC0afuSLjdZZ6JYpdeavoicIfQE6tKmxg2pZ4eTkh29n
         osag==
X-Gm-Message-State: AOJu0YyTYcKHA2tSdT153k6F/b6qUgsHLWpLfrdMl0ldIY1umtommb9v
	ldyAQiwG1jU0JNzQ9J2VQ7cwEF2BrKqiIGF32m2/9C4Wl5WIvUZwtePbuQ7KTgQmBNVPg7m1fG8
	4R6z8lTQJSUz6RL13X4U5gSNkwZ2513rAOBJJFqI=
X-Gm-Gg: ATEYQzyH6gKoiiQCkxdD7YMwTBFGdKW/F+vpsUm3kX5t0nwwbrZOlXPsCe5e86p/vth
	NjdkW+hvk0bfrSLk4k4LfDceWxp3Pv0qc4aRu4S8ufZbm64HA3z6xIoqQaRJSOkHYXqbGnq61ow
	6NAIWMxAKVkRKHQPFgS6owEW04dpXBcFu/wk/NDqT/hA4TuVGIDf7EaPVfdnJdD+60AX9f1JPxR
	A01CYX6MV2AGNFgmB5CQ1x1BeKrZja1kyXgd668ToadjI2TwzW7NV1V2YyKArWVNV/4D8e8hN5M
	jasGnrX3
X-Received: by 2002:a05:6512:1306:b0:59f:6c48:8d9b with SMTP id
 2adb3069b0e04-5a0ed9a1abamr3876884e87.34.1771914281170; Mon, 23 Feb 2026
 22:24:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e8355c0d7fd48981ba505e455387971f91210fa8.1771734206.git.tonghao@bamaicloud.com>
 <CAL+tcoDR2-WTmhBakWcvEuLCwAU7RGRA8syfor-+RJJq7_ZOKw@mail.gmail.com>
 <65307E32-7AFF-44EF-B2BB-89AA15F3D0D1@bamaicloud.com> <CAL+tcoB0uV0E9cDCfw58kAuzNcanstx_OT3h=dkQVOW1b-nN+A@mail.gmail.com>
 <C914CAC5-AEF2-4814-84FC-30EA4B70F832@bamaicloud.com> <CAL+tcoDzik63K1aqpDTn7K6Jkta5ZtjedTQ58TB455+pwkq8Pw@mail.gmail.com>
 <3AB6E925-3A2E-439D-8432-B00F4DEFE7F1@bamaicloud.com>
In-Reply-To: <3AB6E925-3A2E-439D-8432-B00F4DEFE7F1@bamaicloud.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 24 Feb 2026 14:24:03 +0800
X-Gm-Features: AaiRm53UuLFCmbRGEGOa_dBHEdx0vwsyZo3XAPoq2nQTssw-b4uMSjOTaphDY2A
Message-ID: <CAL+tcoD+TL6xbTodAKp=w0NVeLOubxoJpk=-b_8Z0bPvFrzXCQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: core: introduce the netdev_fetch_core_stats()
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260350-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,fomichev.me:email,mail.gmail.com:mid,bamaicloud.com:email]
X-Rspamd-Queue-Id: 954E4182672
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 2:08=E2=80=AFPM Tonghao Zhang <tonghao@bamaicloud.c=
om> wrote:
>
>
>
> > On Feb 24, 2026, at 13:28, Jason Xing <kerneljasonxing@gmail.com> wrote=
:
> >
> > On Tue, Feb 24, 2026 at 12:07=E2=80=AFPM Tonghao Zhang <tonghao@bamaicl=
oud.com> wrote:
> >>
> >>
> >>
> >>> On Feb 24, 2026, at 11:52, Jason Xing <kerneljasonxing@gmail.com> wro=
te:
> >>>
> >>> On Tue, Feb 24, 2026 at 11:22=E2=80=AFAM Tonghao Zhang <tonghao@bamai=
cloud.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>>> On Feb 23, 2026, at 08:20, Jason Xing <kerneljasonxing@gmail.com> w=
rote:
> >>>>>
> >>>>> On Sun, Feb 22, 2026 at 12:38=E2=80=AFPM Tonghao Zhang <tonghao@bam=
aicloud.com> wrote:
> >>>>>>
> >>>>>> Network device statistics retrieved via procfs, sysfs, and netlink
> >>>>>> represent the combined total of core_stats + driver, hardware stat=
istics.
> >>>>>>
> >>>>>> However, in some scenarios, when monitoring netdev metrics, it is =
valuable
> >>>>>> to clearly distinguish whether the values originate from the netwo=
rking
> >>>>>> stack's core statistics or from the driver, hardware layer. This h=
elps
> >>>>>> improve debugging and addressing issues.
> >>>>>>
> >>>>>> Approaches were considered:
> >>>>>> - commit 5247dbf16cee ("net/core: Introduce netdev_core_stats_inc(=
)").
> >>>>>> This allows tracking increments to core_stats and helps identify s=
pecific
> >>>>>> causes of changes, but not provide the total counters.
> >>>>>> - extending rtnl_link_stats64 with new core_xxx fields.
> >>>>>> This would likely confuse or break existing userspace applications=
 relying
> >>>>>> on this struct.
> >>>>>> - adding a tracepoint inside dev_get_stats().
> >>>>>> This implementation is not simple or straightforward enough.
> >>>>>>
> >>>>>> The solution in this patch is therefore to introduce a new dedicat=
ed function
> >>>>>> for collecting core statistics and mark it noinline. This approach=
 is simple,
> >>>>>> clean, and maintainable to obtain driver, hardware statistics sepa=
rately when needed.
> >>>>>>
> >>>>>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> >>>>>> Cc: "David S. Miller" <davem@davemloft.net>
> >>>>>> Cc: Eric Dumazet <edumazet@google.com>
> >>>>>> Cc: Jakub Kicinski <kuba@kernel.org>
> >>>>>> Cc: Paolo Abeni <pabeni@redhat.com>
> >>>>>> Cc: Simon Horman <horms@kernel.org>
> >>>>>> Cc: Stanislav Fomichev <sdf@fomichev.me>
> >>>>>> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> >>>>>> Cc: Samiullah Khawaja <skhawaja@google.com>
> >>>>>> Cc: Ahmed Zaki <ahmed.zaki@intel.com>
> >>>>>> Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
> >>>>>
> >>>>> It's a simple refactor patch that only moves that logic to a new
> >>>>> helper. I don't see any new possible callers right now so could you
> >>>>> provide more straightward/clear use cases and intentions behind thi=
s
> >>>>> patch? For example, give us what kind of dumping stats you want to
> >>>>> tweak and your next movements.
> >>>> Thanks, Jason
> >>>> This patch tries to add one helper function which marked as noinline=
 for bpf tracing (this commit 5247dbf16cee also use the noinline for tracin=
g). This helper is not used other place in kernel.
> >>>>
> >>>> For example,
> >>>> sudo bpftrace -e '
> >>>> kprobe:netdev_core_stats_fetch {printf("%d\n", ((struct rtnl_link_st=
ats64 *)arg1)->rx_dropped);}
> >>>> kretprobe:netdev_core_stats_fetch {printf("%d\n", ((struct rtnl_link=
_stats64 *)retval)->rx_dropped);}
> >>>> '
> >>>
> >>> Can't we use the global symbol dev_get_stats() instead? It should be =
the same.
> >>
> >> - if kprobe the dev_get_stats(), the rtnl_link_stats64 *storage is not=
 used by drivers (ndo_get_stats64, ndo_get_stats..,), the rx_dropped, for e=
xample, is 0.
> >
> > How about computing the delta of @storage->xxx between two consecutive
> > kretprobes hitting this function? And you can also identify the source

two consecutive __kretprobes__...

> > of @storage as you hope.
> >
> >> But kprobe the new helper netdev_core_stats_fetch(), the data is from =
drivers.
> >> - if kretkprobe the dev_get_stats(), the rtnl_link_stats64 * retval is=
 sum of counter from driver and core_stats. This data is same as kretprobe =
the netdev_core_stats_fetch().
> >
> > Sorry, I see no difference before/after your patch. The @storage is
> > always initialized within dev_get_stats(), so how would it be
> > different with your patch applied?
> If tracing the dev_get_stats() with kprobe and kretprobe,
> sudo bpftrace -e '
>   kprobe:dev_get_stats {printf("%d\n", ((struct rtnl_link_stats64 *)arg1)=
->rx_dropped);} // the @arg1 is not initialized by dev_get_stats() now
>   kretprobe:dev_get_stats {printf("%d\n", ((struct rtnl_link_stats64 *)re=
tval)->rx_dropped);} // the @retval is rtnl_link_stats64 *, which rx_droppe=
d =3D rx_dropped of drivers + rx_dropped of core_stats
> =E2=80=98
> The delta makes no sense.

Please look at the last reply, especially the highlighted part. I
meant every time the function gets called, you can always use
kretprobe to read any information and then do the math you want.

Thanks,
Jason

>
> With this patch
> sudo bpftrace -e '
>   kprobe:netdev_core_stats_fetch {printf("%d\n", ((struct rtnl_link_stats=
64 *)arg1)->rx_dropped);} // @arg1 is initialized by drivers, e.g. ndo_get_=
stats64, ndo_get_stats.
>   kretprobe:netdev_core_stats_fetch {printf("%d\n", ((struct rtnl_link_st=
ats64 *)retval)->rx_dropped);} // the @retval is rtnl_link_stats64 *, which=
 rx_dropped =3D rx_dropped of drivers + rx_dropped of core_stats
> =E2=80=98
> So when kprobe:netdev_core_stats_fetch, the @storage is from driver, e.g.=
 ndo_get_stats64, ndo_get_stats.  The delta (core_stats) is @retval - @arg1

