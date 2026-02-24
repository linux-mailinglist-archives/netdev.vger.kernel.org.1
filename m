Return-Path: <netdev+bounces-260373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKBKJo5SnWk2OgQAu9opvQ
	(envelope-from <netdev+bounces-260373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:26:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6952183024
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D4B230A414C
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 07:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B7636404B;
	Tue, 24 Feb 2026 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoaXEMy2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A393644BA
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771917849; cv=pass; b=p5JnmFCRtFmHcI+QgZ0zi+sPTA+uaJ8aYbY7o7Rxy4rkI9ws3khWEZgltx0VQzLoxe5RsDKRrkSRto4SO6+/ABbYurXoYqeOy93f2m4GwzA0x2U3O+WPrq8XltDq1ul7tddhk72MXx9R+DhwO+SIQH9BaxRvFJwNAYjYfA3+3JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771917849; c=relaxed/simple;
	bh=ULd+oRTA8UiwXl4Lb5nizVLXiKCKx7ppXxndo2HO3Aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLALH53hr9zgzOVUKTVtt664XTg77CMnUP2FH4qP+PELGMf/aFA6DUON4f61CL+5VKPmVi5z+h8/F40VAN3Vwan6j3BMN4mgXmg+brK0XIUGo8Jl4GOyaxY7lVHcKyVfukn2uRikcsy7pcfMJEXTMYuyvbefbtXULtImvCGwgiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoaXEMy2; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59e5f52b13eso6255835e87.2
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 23:24:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771917846; cv=none;
        d=google.com; s=arc-20240605;
        b=SEapLtgLqr0FfbDV/YHc5Ds4cr/NCx2QCAyrM4qn44QJtICcjD38CsBTZc5zLAFplh
         YjiGl9r3E4DG2nYR/aGIqHzkUnYW8Gi19FR2Fe0j2ptpAguKDvCN7uA4z4WtT9dZ0by2
         KlU2+zMkp9RLBdi0P7Bx1MHVKGvu7egqmQMtWaVRwSfY6sznjoYBEob4lcVUjd6Z60gl
         kFOPlOPtweCb4roerGWN+Uw2f62aqZpOARDS3z9P7UXeatohnIVYICbSVoOP1a8Cfm4m
         jo6S6EAgKIo62wI/HfOHAVWZ3fVvlnmMdG7vvr6Wu0pRy7tuSDxDg5CJiDQimjmoY2pi
         gzqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ULd+oRTA8UiwXl4Lb5nizVLXiKCKx7ppXxndo2HO3Aw=;
        fh=iimxS/toxw1tqakfW7lgDLfbqHnkLGiu5BceWk1v/ZM=;
        b=dNnXqj7oHvF69gcL0gEWovqItsrKKhod+jtU1VZfXFeqZ+JxejjwI1jvwhBYlY7/U3
         Idu6yZF6j765TcIBVN3xP/KU0VwtlpeW8N1yBPak3NV1WaQPgBZZA5/kmvBS7Kaa2V88
         uBbFBaQb4sk1dTv4OsnFKczCMPsNY1SbUyNmA/GAV6i9VUwrrp4bynwj1xbb1H9Wkbsz
         SXfPnOdtgOkcFi9ZBiBN4IvIyq+gjHTnXqVSD73TfQpaXgbyHncIbgirovkSUrc1HfUA
         zG/80QYhzPGLrcpTppvPiAoqT163Z79hfd3VONJGaXnvUbo/5xVEvQUiWCP+y0BmEma5
         axXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771917846; x=1772522646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULd+oRTA8UiwXl4Lb5nizVLXiKCKx7ppXxndo2HO3Aw=;
        b=BoaXEMy2F7OAjJamk9KWf04b+60eygj6RgaNQuCjZy2fXgsavxwv3loBIEUSMfsysB
         RAu+BDeBuDGiLJQXFsBvSzMUxWZU3X1idXl9ZJX9AiJOpTnE3XZ3TFezZACwhh4LXgk+
         zILc2R8Tp7Hq6Lzc1RJkEfaOdAUhuPqjlm2rTXcX49azdnu+j+JYzzSw2kbOWrhybdBB
         IhTbfWTkmS4VjnE/rdSWyHORVeDlTEmmZZt0ytx88fGf1Rlsuak1nfNGn1DVYvXX8SHf
         Blrpbq9vl/t5wCY6kjhEp3Kq6sEgiaezd/61j/EsCc+hhmYK/i2GQugpG8M5UvyMXCJS
         bArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771917846; x=1772522646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ULd+oRTA8UiwXl4Lb5nizVLXiKCKx7ppXxndo2HO3Aw=;
        b=lHJT5RJrOyW7GaSc/x3Ci9lohg0/NaRIxbUipiWHeoCRoaAymQu8Q9I8NzuVoNdRYL
         BohXwkv5MQuTyMGCFUGwbKYoAWYiTFv8KI1Lvbd5AVzeBkQHboTMZWEOympr12y+noBg
         YgY/YEc/bbjvSUH+npHerVfAVLhHMDd4rd8neQkWREm/TkBo+2Z7dF0JLlB4WTQ6hOWN
         aeYYgA0eqLcvgXt+hHbuWmE+21ZVtzebQy8MRDMzrlTXAXx7/dmVdmkGIUzMbtX7AaWZ
         WQMbVv81uB1El3KDDvpAMJPedbQS7U8u2YQXVUE14qrWOa5OY2+3QzIEywxKs3Tri1ZG
         WKxw==
X-Gm-Message-State: AOJu0YwMbFogwsv14agCXaEsqUYlNdfUxlvU6DBug08+KU0F96F+e9Vg
	kHmkIiVGHPIrzBEXAwgXzU7CCSjAPGW5Llni9al7oSHvyJLCs/fsQgkj2a0Pre9IGFLvHzSFS1F
	vkapgUShuBZ6sJ3QfBxQs9sSlxwvKo10=
X-Gm-Gg: ATEYQzzAz57CALGGrKaLHlS/r10TSHcOu/1PGEAYMZ158bWtPQIcz6FLHQsQVEX+5SF
	xFhFY62WKEe/v3aGDEyyB/gUs1Bg8/H3Ly9oIie7Wq5U6mbuljMbe4tBYkyETq18l+74VDREQc6
	49loct131qyXZ86vAK1f2w/cE3OQGuKvfalnSPJRACHGdMQBHL1uG7ohSJySOU7a6IESu24B8o7
	nfZs4YKfu0sIVrawY8hwE7cYTkz/+KmcKXDSLhvWuHK0xEu/thc8uuTzl5NHwr2Y+C2t4BgnRXa
	rKEDTSCs
X-Received: by 2002:a05:6512:250f:b0:59f:6db3:152c with SMTP id
 2adb3069b0e04-5a0ed87a67amr4003240e87.7.1771917845447; Mon, 23 Feb 2026
 23:24:05 -0800 (PST)
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
 <4E09E708-FA5A-4523-8E75-359C3D8B43E6@bamaicloud.com>
In-Reply-To: <4E09E708-FA5A-4523-8E75-359C3D8B43E6@bamaicloud.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 24 Feb 2026 15:23:27 +0800
X-Gm-Features: AaiRm53SWjolA5DC8EeO5QdP3fbiUdoyMmv93KkJ64Nta57w4RY5mb1Beu3QGEA
Message-ID: <CAL+tcoAo++zNTneOD+YM5gbAqSOyZtGT=FgRUpSZuzrE7WffHw@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-260373-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bamaicloud.com:email,mail.gmail.com:mid,davemloft.net:email,fomichev.me:email]
X-Rspamd-Queue-Id: D6952183024
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 2:54=E2=80=AFPM Tonghao Zhang <tonghao@bamaicloud.c=
om> wrote:
>
>
>
> > On Feb 24, 2026, at 14:24, Jason Xing <kerneljasonxing@gmail.com> wrote=
:
> >
> > On Tue, Feb 24, 2026 at 2:08=E2=80=AFPM Tonghao Zhang <tonghao@bamaiclo=
ud.com> wrote:
> >>
> >>
> >>
> >>> On Feb 24, 2026, at 13:28, Jason Xing <kerneljasonxing@gmail.com> wro=
te:
> >>>
> >>> On Tue, Feb 24, 2026 at 12:07=E2=80=AFPM Tonghao Zhang <tonghao@bamai=
cloud.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>>> On Feb 24, 2026, at 11:52, Jason Xing <kerneljasonxing@gmail.com> w=
rote:
> >>>>>
> >>>>> On Tue, Feb 24, 2026 at 11:22=E2=80=AFAM Tonghao Zhang <tonghao@bam=
aicloud.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>> On Feb 23, 2026, at 08:20, Jason Xing <kerneljasonxing@gmail.com>=
 wrote:
> >>>>>>>
> >>>>>>> On Sun, Feb 22, 2026 at 12:38=E2=80=AFPM Tonghao Zhang <tonghao@b=
amaicloud.com> wrote:
> >>>>>>>>
> >>>>>>>> Network device statistics retrieved via procfs, sysfs, and netli=
nk
> >>>>>>>> represent the combined total of core_stats + driver, hardware st=
atistics.
> >>>>>>>>
> >>>>>>>> However, in some scenarios, when monitoring netdev metrics, it i=
s valuable
> >>>>>>>> to clearly distinguish whether the values originate from the net=
working
> >>>>>>>> stack's core statistics or from the driver, hardware layer. This=
 helps
> >>>>>>>> improve debugging and addressing issues.
> >>>>>>>>
> >>>>>>>> Approaches were considered:
> >>>>>>>> - commit 5247dbf16cee ("net/core: Introduce netdev_core_stats_in=
c()").
> >>>>>>>> This allows tracking increments to core_stats and helps identify=
 specific
> >>>>>>>> causes of changes, but not provide the total counters.
> >>>>>>>> - extending rtnl_link_stats64 with new core_xxx fields.
> >>>>>>>> This would likely confuse or break existing userspace applicatio=
ns relying
> >>>>>>>> on this struct.
> >>>>>>>> - adding a tracepoint inside dev_get_stats().
> >>>>>>>> This implementation is not simple or straightforward enough.
> >>>>>>>>
> >>>>>>>> The solution in this patch is therefore to introduce a new dedic=
ated function
> >>>>>>>> for collecting core statistics and mark it noinline. This approa=
ch is simple,
> >>>>>>>> clean, and maintainable to obtain driver, hardware statistics se=
parately when needed.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> >>>>>>>> Cc: "David S. Miller" <davem@davemloft.net>
> >>>>>>>> Cc: Eric Dumazet <edumazet@google.com>
> >>>>>>>> Cc: Jakub Kicinski <kuba@kernel.org>
> >>>>>>>> Cc: Paolo Abeni <pabeni@redhat.com>
> >>>>>>>> Cc: Simon Horman <horms@kernel.org>
> >>>>>>>> Cc: Stanislav Fomichev <sdf@fomichev.me>
> >>>>>>>> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> >>>>>>>> Cc: Samiullah Khawaja <skhawaja@google.com>
> >>>>>>>> Cc: Ahmed Zaki <ahmed.zaki@intel.com>
> >>>>>>>> Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
> >>>>>>>
> >>>>>>> It's a simple refactor patch that only moves that logic to a new
> >>>>>>> helper. I don't see any new possible callers right now so could y=
ou
> >>>>>>> provide more straightward/clear use cases and intentions behind t=
his
> >>>>>>> patch? For example, give us what kind of dumping stats you want t=
o
> >>>>>>> tweak and your next movements.
> >>>>>> Thanks, Jason
> >>>>>> This patch tries to add one helper function which marked as noinli=
ne for bpf tracing (this commit 5247dbf16cee also use the noinline for trac=
ing). This helper is not used other place in kernel.
> >>>>>>
> >>>>>> For example,
> >>>>>> sudo bpftrace -e '
> >>>>>> kprobe:netdev_core_stats_fetch {printf("%d\n", ((struct rtnl_link_=
stats64 *)arg1)->rx_dropped);}
> >>>>>> kretprobe:netdev_core_stats_fetch {printf("%d\n", ((struct rtnl_li=
nk_stats64 *)retval)->rx_dropped);}
> >>>>>> '
> >>>>>
> >>>>> Can't we use the global symbol dev_get_stats() instead? It should b=
e the same.
> >>>>
> >>>> - if kprobe the dev_get_stats(), the rtnl_link_stats64 *storage is n=
ot used by drivers (ndo_get_stats64, ndo_get_stats..,), the rx_dropped, for=
 example, is 0.
> >>>
> >>> How about computing the delta of @storage->xxx between two consecutiv=
e
> >>> kretprobes hitting this function? And you can also identify the sourc=
e
> >
> > two consecutive __kretprobes__=E2=80=A6
> I got it. In fact, it is not solving the problem. For example, @storage->=
rx_dropped is increasing, but it's impossible to determine whether the incr=
ease comes from core_stats.rx_dropped, from the driver=E2=80=99s rx_dropped=
, or from both.

To be more specific, in dev_get_stats() @storage is only one memory
area that records the information from @core_stats. So it is
@core_stats that takes effect and is widely used/scattered over the
place (please see how one example like dev_core_stats_rx_dropped_inc()
gets called, it can be used by drivers like ipvlan or stack). We
cannot tell which one causes the increment by looking at @core_stats.

Besides, another trivial thing is that, even with your patch applied,
it doesn't change anything since core_stats->rx_dropped can get
increased in between kprobe and kretprobe of the new helper you added.

With that said, how can you accurately know where the increment comes
from? Is it from the stack or driver? I dunno :S

Thanks,
Jason

