Return-Path: <netdev+bounces-260913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGEEN2bpnmk/XwQAu9opvQ
	(envelope-from <netdev+bounces-260913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:21:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AFB197371
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACE55306F02C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447813AA1BC;
	Wed, 25 Feb 2026 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjyD3ZJt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA4C3AA1A2
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772021849; cv=pass; b=kGGYXOK70LTNuyhQBhEmPerMzJpi3WUVKh/sE6Et3BpJK0IU1H2sN122H4bDiDxiykdHju1mOKXOTCjSkhIBXclpCvVKNNGdtjfVj9BS/HQ4tTBCQDi7cODfa728/y4LVmuHX8jBRm49iDGMU+ypWhYosTMKFeJ3gKJ1hA0rX10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772021849; c=relaxed/simple;
	bh=DH9ttI//blyfk1vG4thBoKhoX7G4VS0EImQnyUGojFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvCN0j4qMJ2f7HYb/utyF9FCYcY2+M7fgf9Um6bkg0MQTPImPGchC7CkjOaHnEZBcnIUOXLLs4W9flq/Lhev0IAawfnK/fvJYQ9QmX9OHjJF1Y/VIEBmDkt+OMwxeNKe1a4erukYZ/zNGTQkMxW/zYFZP4/TAz8UZrfyYGlssBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjyD3ZJt; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59dd54b1073so6573259e87.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 04:17:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772021845; cv=none;
        d=google.com; s=arc-20240605;
        b=Qb3Pzy4YplPLoZ0275d12ikwU1B1BuCIP5wdyH5L28gagDKoV9dh7GVUcXyhulRVpr
         +X7+groUliyFknQ1qt4nqfWPRkk1drOxbjEayW1+SdTeVc4yhV7d5wuVtOv955gG7RfA
         YqueD7z6c2xhzxa6PiLhavlUbv4orX/kQWKDByWWdEiHdH01/7gF4m8hNuJUeH6mKKmI
         IQ4AI5p4E48sxREwHnCdl5Y2EZHkHvcoi1kMZieOotyaCy0HWdmDng1ZS2V7+oOdMas1
         Hz0ab4ZbyMlUn9rF29sat2daUtKBOYSNzE8PTHYn2EJRTH1ckCFFByOEAjchYOGwuRoK
         pzog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sb1V43h5K7ciIaEGP0XFfgYeS+3Xatmgk3r8YfgSmac=;
        fh=a/I5l7P5xlzW/aIML7vGqSzvIlPHOLwHcl+9A1KGfGY=;
        b=IwchWT2YVmaJGWj4GfWQkC9voE0JCaU9m3tTV9Nl/ghkZydSOm6t4RCaQZ5XBP1Qko
         pA9/mm5Y6QC4ps/Beq1J+oZdQr5z/CHSeTi9+/sAl7VouHDScLar5HObarO2lg7V+ahq
         PPr0NYSQjUPMKNNDaKL7qfDg1UxkCvDCWDCb9ncTSAE3YSmU6a7MroyFZ6UQFgI8f4Wn
         ol+I7bYwx136BPsg+0wXleyvCFQQFBr5jncVZC+bONFMsePfrZu4oaten3xOdI8K7GNT
         g7eCMTBpdplTFvlbrbAAbXtl6OpFZZOUXLdLs8Ye1dqw6wvZxRvWxON9DzDDnd8Br3nJ
         5DGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772021845; x=1772626645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sb1V43h5K7ciIaEGP0XFfgYeS+3Xatmgk3r8YfgSmac=;
        b=GjyD3ZJt+eaMx4R4xO/bH1Gidog67jNv14wJuR2lUFz19bgq+gFOMsDvVDSmNThZzt
         hhEqCl/4x5ES+UCAo213hdnnDT9lsc8OyCFgZLPUFHny7Gh7M+nv6RTyPgdNf1tRB3pg
         NtpDlj94kgZIcH/9tsFMZibUtJ3LU1mKnZMPA/46GqdYxa4eNgERsjpWRyQfHd59gY+L
         HxtEfqWCftfPNL3h9VpypIVfB5RRk5ELPURxiSwY3MDYm5YXbDDx+SdNvVEFjpIhY8ox
         CMTy/yqYprrBZ8O/etaHeRezGq8+wvhXgVpkhcJNW5BGtk1df56GV29/tf/KxqonTewa
         9SzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772021845; x=1772626645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sb1V43h5K7ciIaEGP0XFfgYeS+3Xatmgk3r8YfgSmac=;
        b=Xe2zHAck8mtFf57gvVBXnb3roIVGxTlMmw/Kly/xLQY1wt+icnkq7963K30ucfrMqo
         5aGdpAEn2QDzW1vlFw51wT/4vo+xZkoPNB4+OPs2ZGeuJJ1aC9NEuytj8ak+fSXy8exk
         ywlJlIWn/INK4jbi1iqxZiXilYyBKqZyv6++Cy3en2pjcvVtVztrpfrdOzO2XCWwir0W
         x4RAqBPX/IxqI+mbtfBHZPNnPlcHbbR98ANZSE1T7AnsxB88Rwn/wOlU1zEf407uiPyJ
         WRyqFd/DiyISs8ABCNDqd3Ni/qpRYNCkGQzWTcm0cgrCb+Jj4zFkS1XidsBVIrvdq2XV
         D7aw==
X-Forwarded-Encrypted: i=1; AJvYcCXA5C9eK8R+H1ZDLhimcgQ1QNnkA0MOg2wo8b2i+a8pLyyjUidNva6qOzXF/O6xEx0riM3qKB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWWH668xDzBrccGM5EGvCrBADnundz5kyt4KXm4yxDEBX5ibuo
	MqNTBZSyGXJAtJFfITxKlcq+TsW3tJRs3wwd8EUHmM6RN0D3rzNNvAg6fc3/oX8bjfBOPzWTF9a
	PwDdIMeZwtMRBOkHbA1zo+w9Ht3GMvvE=
X-Gm-Gg: ATEYQzxJdD57iKQym+YgyZr0k6PYX9GiMYPxfJwex4LOG/cQuFhcYd3W6TCHR8SGlTj
	qz5vfexxEoogI2d4pXIrFLU2JZtWYR52Byb5tV1dyEdERSV8HbykkceqpqekDNHIP9I+IxryiE2
	z2l8WpTyogVOBN7V7kpl3xbkgsT2EA0DEclPPUAKgb+e64Vuxzpx8Da6XmU4DerSnuGJBNMWPyB
	64M1JSAwoN135zNCRrlz7zOwcNadnW8XaYjKaqSIXqWl2hz3f2CvSkR9Yd73JoIv6k271rZ5YSB
	0A4Tc8T2
X-Received: by 2002:a05:6512:2307:b0:5a0:f5e3:39d2 with SMTP id
 2adb3069b0e04-5a105eaeb91mr22000e87.39.1772021844722; Wed, 25 Feb 2026
 04:17:24 -0800 (PST)
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
 <3AB6E925-3A2E-439D-8432-B00F4DEFE7F1@bamaicloud.com> <CAL+tcoD+TL6xbTodAKp=w0NVeLOubxoJpk=-b_8Z0bPvFrzXCQ@mail.gmail.com>
 <4E09E708-FA5A-4523-8E75-359C3D8B43E6@bamaicloud.com> <CAL+tcoAo++zNTneOD+YM5gbAqSOyZtGT=FgRUpSZuzrE7WffHw@mail.gmail.com>
 <8BEBBF67-92EE-4E6B-9D92-863A80883429@bamaicloud.com> <CAL+tcoA-i-aKgjBwt0MPzhFjgMQ3qELJyB+Fd+cpYzMita8v+Q@mail.gmail.com>
 <A62D779D-CCED-4C30-9113-8FC803EBA191@bamaicloud.com> <CAL+tcoCT4PWrUPJ6jeRbCSG8tHATsd2QmLbMhPWdOoBngjO7yA@mail.gmail.com>
 <BFC60D14-77B6-4437-A6D0-C8E87A8E9BA9@bamaicloud.com>
In-Reply-To: <BFC60D14-77B6-4437-A6D0-C8E87A8E9BA9@bamaicloud.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 25 Feb 2026 20:16:47 +0800
X-Gm-Features: AaiRm50avDG-OsehGjv3KF-jIaiEcJVgCF3zNhXTl7yjzqi-NxHCnPBqI6f5T7g
Message-ID: <CAL+tcoCXiO6oG5YJKQDbN3gZXygpo=dbOEn=-kM4hvsghFQoqw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: core: introduce the netdev_fetch_core_stats()
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260913-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,intel.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bamaicloud.com:email]
X-Rspamd-Queue-Id: 29AFB197371
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 6:37=E2=80=AFPM Tonghao Zhang <tonghao@bamaicloud.c=
om> wrote:
>
>
>
> > On Feb 25, 2026, at 17:22, Jason Xing <kerneljasonxing@gmail.com> wrote=
:
> >
> > On Wed, Feb 25, 2026 at 4:43=E2=80=AFPM Tonghao Zhang <tonghao@bamaiclo=
ud.com> wrote:
> >>
> >>
> >>
> >>> On Feb 24, 2026, at 19:48, Jason Xing <kerneljasonxing@gmail.com> wro=
te:
> >>>
> >>> On Tue, Feb 24, 2026 at 6:29=E2=80=AFPM Tonghao Zhang <tonghao@bamaic=
loud.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>>> On Feb 24, 2026, at 15:23, Jason Xing <kerneljasonxing@gmail.com> w=
rote:
> >>>>>
> >>>>> On Tue, Feb 24, 2026 at 2:54=E2=80=AFPM Tonghao Zhang <tonghao@bama=
icloud.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>> On Feb 24, 2026, at 14:24, Jason Xing <kerneljasonxing@gmail.com>=
 wrote:
> >>>>>>>
> >>>>>>> On Tue, Feb 24, 2026 at 2:08=E2=80=AFPM Tonghao Zhang <tonghao@ba=
maicloud.com> wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>> On Feb 24, 2026, at 13:28, Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
> >>>>>>>>>
> >>>>>>>>> On Tue, Feb 24, 2026 at 12:07=E2=80=AFPM Tonghao Zhang <tonghao=
@bamaicloud.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>> On Feb 24, 2026, at 11:52, Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> On Tue, Feb 24, 2026 at 11:22=E2=80=AFAM Tonghao Zhang <tongh=
ao@bamaicloud.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>>> On Feb 23, 2026, at 08:20, Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> On Sun, Feb 22, 2026 at 12:38=E2=80=AFPM Tonghao Zhang <ton=
ghao@bamaicloud.com> wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Network device statistics retrieved via procfs, sysfs, and=
 netlink
> >>>>>>>>>>>>>> represent the combined total of core_stats + driver, hardw=
are statistics.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> However, in some scenarios, when monitoring netdev metrics=
, it is valuable
> >>>>>>>>>>>>>> to clearly distinguish whether the values originate from t=
he networking
> >>>>>>>>>>>>>> stack's core statistics or from the driver, hardware layer=
. This helps
> >>>>>>>>>>>>>> improve debugging and addressing issues.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Approaches were considered:
> >>>>>>>>>>>>>> - commit 5247dbf16cee ("net/core: Introduce netdev_core_st=
ats_inc()").
> >>>>>>>>>>>>>> This allows tracking increments to core_stats and helps id=
entify specific
> >>>>>>>>>>>>>> causes of changes, but not provide the total counters.
> >>>>>>>>>>>>>> - extending rtnl_link_stats64 with new core_xxx fields.
> >>>>>>>>>>>>>> This would likely confuse or break existing userspace appl=
ications relying
> >>>>>>>>>>>>>> on this struct.
> >>>>>>>>>>>>>> - adding a tracepoint inside dev_get_stats().
> >>>>>>>>>>>>>> This implementation is not simple or straightforward enoug=
h.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> The solution in this patch is therefore to introduce a new=
 dedicated function
> >>>>>>>>>>>>>> for collecting core statistics and mark it noinline. This =
approach is simple,
> >>>>>>>>>>>>>> clean, and maintainable to obtain driver, hardware statist=
ics separately when needed.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> >>>>>>>>>>>>>> Cc: "David S. Miller" <davem@davemloft.net>
> >>>>>>>>>>>>>> Cc: Eric Dumazet <edumazet@google.com>
> >>>>>>>>>>>>>> Cc: Jakub Kicinski <kuba@kernel.org>
> >>>>>>>>>>>>>> Cc: Paolo Abeni <pabeni@redhat.com>
> >>>>>>>>>>>>>> Cc: Simon Horman <horms@kernel.org>
> >>>>>>>>>>>>>> Cc: Stanislav Fomichev <sdf@fomichev.me>
> >>>>>>>>>>>>>> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> >>>>>>>>>>>>>> Cc: Samiullah Khawaja <skhawaja@google.com>
> >>>>>>>>>>>>>> Cc: Ahmed Zaki <ahmed.zaki@intel.com>
> >>>>>>>>>>>>>> Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> It's a simple refactor patch that only moves that logic to =
a new
> >>>>>>>>>>>>> helper. I don't see any new possible callers right now so c=
ould you
> >>>>>>>>>>>>> provide more straightward/clear use cases and intentions be=
hind this
> >>>>>>>>>>>>> patch? For example, give us what kind of dumping stats you =
want to
> >>>>>>>>>>>>> tweak and your next movements.
> >>>>>>>>>>>> Thanks, Jason
> >>>>>>>>>>>> This patch tries to add one helper function which marked as =
noinline for bpf tracing (this commit 5247dbf16cee also use the noinline fo=
r tracing). This helper is not used other place in kernel.
> >>>>>>>>>>>>
> >>>>>>>>>>>> For example,
> >>>>>>>>>>>> sudo bpftrace -e '
> >>>>>>>>>>>> kprobe:netdev_core_stats_fetch {printf("%d\n", ((struct rtnl=
_link_stats64 *)arg1)->rx_dropped);}
> >>>>>>>>>>>> kretprobe:netdev_core_stats_fetch {printf("%d\n", ((struct r=
tnl_link_stats64 *)retval)->rx_dropped);}
> >>>>>>>>>>>> '
> >>>>>>>>>>>
> >>>>>>>>>>> Can't we use the global symbol dev_get_stats() instead? It sh=
ould be the same.
> >>>>>>>>>>
> >>>>>>>>>> - if kprobe the dev_get_stats(), the rtnl_link_stats64 *storag=
e is not used by drivers (ndo_get_stats64, ndo_get_stats..,), the rx_droppe=
d, for example, is 0.
> >>>>>>>>>
> >>>>>>>>> How about computing the delta of @storage->xxx between two cons=
ecutive
> >>>>>>>>> kretprobes hitting this function? And you can also identify the=
 source
> >>>>>>>
> >>>>>>> two consecutive __kretprobes__=E2=80=A6
> >>>>>> I got it. In fact, it is not solving the problem. For example, @st=
orage->rx_dropped is increasing, but it's impossible to determine whether t=
he increase comes from core_stats.rx_dropped, from the driver=E2=80=99s rx_=
dropped, or from both.
> >>>>>
> >>>>> To be more specific, in dev_get_stats() @storage is only one memory
> >>>>> area that records the information from @core_stats. So it is
> >>>>> @core_stats that takes effect and is widely used/scattered over the
> >>>>> place (please see how one example like dev_core_stats_rx_dropped_in=
c()
> >>>>> gets called, it can be used by drivers like ipvlan or stack). We
> >>>>> cannot tell which one causes the increment by looking at @core_stat=
s.
> >>>> I don=E2=80=99t take care of the virtual net device. In our producti=
on environment,
> >>>> there are many network cards from various manufacturers (mlx, intel,=
 broadcom).
> >>>>
> >>>> By the way, can we use the driver private stats instead of the core_=
stats counters for macvlan, ipvlan, tun, bonding, and bnxt.
> >>>>
> >>>> # git grep -rin dev_core_stats_ drivers/
> >>>> drivers/net/bonding/bond_main.c:5291:   dev_core_stats_tx_dropped_in=
c(bond_dev);
> >>>> drivers/net/ethernet/broadcom/bnge/bnge_txrx.c:1616:    dev_core_sta=
ts_tx_dropped_inc(dev);
> >>>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:490:          dev_core_sta=
ts_tx_dropped_inc(dev);
> >>>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:504:                  dev_=
core_stats_tx_dropped_inc(dev);
> >>>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:804:  dev_core_stats_tx_dr=
opped_inc(dev);
> >>>> drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c:220:           =
    dev_core_stats_rx_nohandler_inc(skb->dev);
> >>>> drivers/net/ipvlan/ipvlan_core.c:598:           dev_core_stats_rx_dr=
opped_inc(skb->dev);
> >>>> drivers/net/macvlan.c:383:      dev_core_stats_rx_dropped_inc(skb->d=
ev);
> >>>> drivers/net/net_failover.c:92:  dev_core_stats_tx_dropped_inc(dev);
> >>>> drivers/net/netkit.c:124:               dev_core_stats_tx_dropped_in=
c(dev);
> >>>> drivers/net/tun.c:1081: dev_core_stats_tx_dropped_inc(dev);
> >>>> drivers/net/tun.c:1237:                 dev_core_stats_tx_dropped_in=
c(dev);
> >>>> drivers/net/tun.c:1567:                 dev_core_stats_rx_dropped_in=
c(tun->dev);
> >>>> drivers/net/tun.c:1575:                 dev_core_stats_rx_dropped_in=
c(tun->dev);
> >>>> drivers/net/tun.c:1589:         dev_core_stats_rx_dropped_inc(tun->d=
ev);
> >>>> drivers/net/tun.c:1913:                 dev_core_stats_rx_dropped_in=
c(tun->dev);
> >>>> drivers/net/tun.c:1970:         dev_core_stats_rx_dropped_inc(tun->d=
ev);
> >>>>
> >>>>>
> >>>>> Besides, another trivial thing is that, even with your patch applie=
d,
> >>>>> it doesn't change anything since core_stats->rx_dropped can get
> >>>>> increased in between kprobe and kretprobe of the new helper you add=
ed.
> >>>> The new helper only gives a proper hook point.
> >>>
> >>> The patch makes no difference. Please see below.
> >>>
> >>>>>
> >>>>> With that said, how can you accurately know where the increment com=
es
> >>>>> from? Is it from the stack or driver? I dunno :S
> >>>> If considering the virtual net device, it is not easy to know where =
the increment comes from. It is only useful for hardware NIC.
> >>>
> >>> My whole points are 1) @storage as the first parameter of
> >>> dev_get_stats() doesn't mean anything because it's a temp memory area=
.
> >>> Previously you wanted to use this to know the source of counters,
> >>> which is apparently wrong; 2) reading @core_stats is the only way to
> >> No, I don=E2=80=99t use the dev_get_stats(). I introduce the new helpe=
r and use the netdev_core_stats_fetch() to get counters of drivers (especia=
lly, hardware NIC).
> >>> help us understand where the increment comes from, but it can't. This
> >>> member includes many different counters that can be used in either
> >>> stack or drivers. The usage should be general, IMHO.
> >> I agree that this is not general, but this helper is useful for hardwa=
re nic.
> >>>
> >>>
> >>> So again how can you be sure where the increment of one counter
> >>> happens? I mean how? Could you provide us more details about _how_ to
> >>> know where the increment comes from? IIUC, by only hooking either
> >>> dev_get_stats() or the new helper it doesn't work.
> >> For tracing **hardware NIC**, for example, ixgbe which does=E2=80=99t =
use the core_stats
> >>
> >> struct rtnl_link_stats64 *dev_get_stats(struct net_device *dev,
> >>                                        struct rtnl_link_stats64 *stora=
ge)
> >> {
> >>        const struct net_device_ops *ops =3D dev->netdev_ops;
> >>        ...
> >>        if (ops->ndo_get_stats64) {
> >>                memset(storage, 0, sizeof(*storage));
> >>                ops->ndo_get_stats64(dev, storage); // 1. @storage is i=
nitialized by ixgbe driver
> >>        } else if (ops->ndo_get_stats) {
> >>              ...
> >>        }
> >>
> >>        return netdev_core_stats_fetch(dev, storage); // 2. kprobe this=
 function to fetch the @storage returned by ixgbe driver, counters are from=
 drivers 3. kretprobe this function to fetch the @storage which add the cor=
e_stats. So counters =3D=3D @storage of kretprobe - @storage of kprobes, ar=
e from core_stats.
> >> }
> >>
> >>>
> >>> Take a look at this counter, so many callers:
> >>> $ grep -nr dev_core_stats_tx_dropped_inc ./net/ drivers/net/ethernet/
> >>> ./net/hsr/hsr_device.c:239:             dev_core_stats_tx_dropped_inc=
(dev);
> >>> ./net/core/filter.c:2292:               dev_core_stats_tx_dropped_inc=
(dev);
> >>> ./net/core/filter.c:2297:       dev_core_stats_tx_dropped_inc(dev);
> >>> ./net/core/filter.c:2399:               dev_core_stats_tx_dropped_inc=
(dev);
> >>> ./net/core/filter.c:2404:       dev_core_stats_tx_dropped_inc(dev);
> >>> ./net/core/dev.c:4057:  dev_core_stats_tx_dropped_inc(dev);
> >>> ./net/core/dev.c:4859:  dev_core_stats_tx_dropped_inc(dev);
> >>> ./net/core/dev.c:4899:  dev_core_stats_tx_dropped_inc(dev);
> >>> ./net/core/dev.c:5596:          dev_core_stats_tx_dropped_inc(dev);
> >>> ./net/sched/sch_generic.c:641:  dev_core_stats_tx_dropped_inc(skb->de=
v);
> >> The above is the core code of the net stack.
> >>> ./net/xfrm/xfrm_device.c:144:           dev_core_stats_tx_dropped_inc=
(dev);
> >>> ./net/xfrm/xfrm_device.c:168:
> >>> dev_core_stats_tx_dropped_inc(dev);
> >>> drivers/net/ethernet/broadcom/bnge/bnge_txrx.c:1616:
> >>> dev_core_stats_tx_dropped_inc(dev);
> >>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:490:
> >>> dev_core_stats_tx_dropped_inc(dev);
> >>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:504:
> >>> dev_core_stats_tx_dropped_inc(dev);
> >>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:804:
> >>> dev_core_stats_tx_dropped_inc(dev);
> >>
> >> For macvlan, ipvlan, tun, and bonding, I think I will change them to u=
se the private the stats of these drivers in v2.
> >>
> >> caf586e5f23c ("net: add a core netdev->rx_dropped counter=E2=80=9D)
> >> =E2=80=9C=E2=80=9D=E2=80=9D
> >>    net: add a core netdev->rx_dropped counter
> >>
> >>    In various situations, a device provides a packet to our stack and =
we
> >>    drop it before it enters protocol stack :
> >>    - softnet backlog full (accounted in /proc/net/softnet_stat)
> >>    - bad vlan tag (not accounted)
> >>    - unknown/unregistered protocol (not accounted)
> >>
> >>    We can handle a per-device counter of such dropped frames at core l=
evel,
> >>    and automatically adds it to the device provided stats (rx_dropped)=
, so
> >>    that standard tools can be used (ifconfig, ip link, cat /proc/net/d=
ev)
> >>
> >>    This is a generalization of commit 8990f468a (net: rx_dropped
> >>    accounting), thus reverting it.
> >> =E2=80=9C=E2=80=9D=E2=80=9C
> >>
> >> For macvlan, the commit 412ca1550cbe ("macvlan: Move broadcasts into a=
 work queue=E2=80=9D) added the dev->rx_dropped. The macvlan supported the =
 @pcpu_stats.
> >> For ipvlan, the commit  ba35f8588f47 ("ipvlan: Defer multicast / broad=
cast processing to a work-queue=E2=80=9D) added the dev->rx_dropped. The ip=
vlan supported the  @ ipvl_pcpu_stats.
> >> For bonding, the commit 31aa860e0aaf ("bonding: add bond_tx_drop() hel=
per=E2=80=9D) added the dev->rx_dropped.
> >>
> >> None of the patches strongly indicate that @core_stats must be used.
> >
> > As to the example you just provided, since ixgbe doesn't use
> > @core_stats, directly hooking the original dev_get_stats() with
> > kretprobe achieves the same goal as you want. Why do you need to add
> > this patch? Besides, if you want to know more about specific drivers,
> As the example above show, I don=E2=80=99t hook dev_get_stats(), I only h=
ook the **netdev_core_stats_fetch()** which is inside in dev_get_stats().
>
> I think my explanation was clear enough.
> Kprobe hooking directly the dev_get_stats() and netdev_core_stats_fetch()=
 is **different**.
> 1. Kprobe the **dev_get_stats()**, counters is not what I want, these cou=
nters is **not initialized**.
>     Only kprobe the **netdev_core_stats_fetch()** can fetch the counters =
from drivers. These counters are what I wanted.  These counters are @A.
> 2. The effects of kretprobe on **dev_get_stats()** and **netdev_core_stat=
s_fetch()** are the same. These counters are what I wanted too.  These coun=
ters are @B.
>
> core_stats counters =3D=3D @B - @A
>
> Without this patch, it is impossible to obtain these counters from the dr=
iver.
> Finally, @A and @core_stats are exactly what I need. Retrieving these dat=
a depends on this patch.

Now I'm confused. Last time you said you wanted to monitor the ixgbe
case, not focused on @core_stats, and I remarked that without this
patch, hooking dev_get_stats() has the same effect. So the patch
doesn't make sense _in this ixgbe case_. Now this time you say you
want @core_stats, but I earlier replied this counter is a mixture and
you cannot know the exact source of the counter (bnxt driver is an
example). I'm not convinced by either of them :(

My understanding based on this is there are only three cases:
1) storage does exist while core_stats doesn't, like ixgbe. Without
this patch, hooking dev_get_stats() with kretprobe is enough.
2) storage doesn't exist while core_stats does. Ditto.
3) storage does exist while core_stats does. bnxt and rmnet are the
only two cases[1]. For example, bnxt_get_stats64() only records
something like rx_crc_errors while dev_get_stats() only records
rx_dropped, etc... They are not duplicated at all. We can still use
kretprobe to cover it. As to the tx_dropped counter that is a special
one[1], it is used in both driver and stack so it's a mixture. Even if
you know the core_stats, you cannot distinguish the source of this
counter.
[1]: grep -nr dev_core_stats drivers/net/ethernet/
drivers/net/ethernet/broadcom/bnge/bnge_txrx.c:1616:
dev_core_stats_tx_dropped_inc(dev);
drivers/net/ethernet/broadcom/bnxt/bnxt.c:490:
dev_core_stats_tx_dropped_inc(dev);
drivers/net/ethernet/broadcom/bnxt/bnxt.c:504:
dev_core_stats_tx_dropped_inc(dev);
drivers/net/ethernet/broadcom/bnxt/bnxt.c:804:
dev_core_stats_tx_dropped_inc(dev);
drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c:220:
 dev_core_stats_rx_nohandler_inc(skb->dev);

Until now, my take is without this patch, we can do the same thing as you w=
ant.

To save time, I highly recommend you provide a _real and specific use
case_ that you're trying to cover and then we will find a more general
and better approach.

I will leave it to Jakub and Paolo.

Thanks,
Jason

