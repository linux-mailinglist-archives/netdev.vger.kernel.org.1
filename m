Return-Path: <netdev+bounces-267928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA4JLAjZtmmkJgEAu9opvQ
	(envelope-from <netdev+bounces-267928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:06:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1533529157D
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 17:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7F6E3028ED7
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 16:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34831370D61;
	Sun, 15 Mar 2026 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ndoctVTI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867F236C584
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773590788; cv=none; b=enu5ipIJH1vqJW8dRYvmCtzbVxOaW0uQ+miGejAt+TeFePxKIqIQPPXvdIEToUsg1dzJ1EibKfX9/iA9mVUzW9R2lbNl/ojekAmzcXqzoOfNSNBq9xosiCI8Cgo2+6ykpotUoWVzNeidnZO6Tf/cJMspEzwkrvPLZ6SH17Me5WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773590788; c=relaxed/simple;
	bh=A7BBMyaNlHjkuSwtW3AHVo4AvDjTAS1SpJCd2fQJshY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HG/aaLbwIUnXXmy0jXSXbkgQTKBD5p5xT3szCxvt7L+zOPAKkPfM3iwCab0k1WZDEEYgAfZQ0FT8ETcQgvXfb4YbfFSGo27GHPJLKGdWOrG8nLdFJ0MPlLgA6TDHvpSkC0chYaApYAZG3Gf/o1fJ+kFcpqpi4TQDldFVeI54Z/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=ndoctVTI; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12732165d1eso4708643c88.1
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 09:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773590785; x=1774195585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLy7K36SCDNZjs+7kWXoLXCj2s7+No3O6Cv8E2hX2vU=;
        b=ndoctVTIJl0RcROP04iN4KPYezQifz1b/kxDcDFgjx741Yl9UCIamak6hPsaXCa3Mm
         EPh2VH8o35/8snwJTb8jE8Di8n5TMVXaF8ht4O2k5K09Rf+go197pP4oKl28KswTiH1V
         D7aPBZSkHSxPEDOwucSbHxajm9Lc4nQwj//a4tDaHbZ7rfW110bVX0Qtu5tAWgK59zQ6
         qN5Ffa0OFMM2ggnGfJSvM+2z4HAyFr+jIVv6SrOh/74Mg0ZxaeLAGdaNs6MTrWXgIduG
         utB5TTCsNaq0NI0cuZX3GVeKIPSL083aY03VXc/Nd3YTqkPEMHFsmHWpHTOEYtCiQkp1
         jWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773590785; x=1774195585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bLy7K36SCDNZjs+7kWXoLXCj2s7+No3O6Cv8E2hX2vU=;
        b=sGxDsxK6o7ADhce7K3Y73DHF8gdSIouBQtnrf1oeKf2WSObaqPOXURb3ug4mEzn4YC
         TLvrd/HzkmJovIQIRrA8iZhP1uSfAW96ev05G+p5YWBMUuI9coHovCiY1lKMcvUKYAet
         627SABbeVuIqX9poRJtG+aZuFXlOVSPvnEwSdaFhW2tpHPjj7mk0gfoDH+7ps0iCCk/L
         /5zLYpR0BShEtA7c+SlhRx5S0gp1HF3kBJJtaAm77eJtHN6460MnpMBe3qefJijZR6/9
         KRorbZ7iRjHJSB1XdnDXVWvkKQ9oCdC9kJLzF/4H04x88OMQmqUBuh1ABlH1cx12b9BK
         Wjjw==
X-Gm-Message-State: AOJu0YzjrdCw+jeGtf+C1j5jIupKQVI/8MJSQ9wG3bDoXFC8n5Yx/4qq
	IoxQrd9UCOV/QR7EoGXhQETza9J0L/7PEwJUUe5h2L6AkBnDpCgyyjX9oiHbn21qvGA=
X-Gm-Gg: ATEYQzzUC2DrXgpLre6YA9f+UvX8cpZ8U9LaMPnlkVogYO86ZBowh/3KF40N4wFKIQt
	aiBOFa+ZM+xaCy2h3dlrqmLUzFDSVvnSIi69ypyk7harh1vz21V+74/Bd+/yY1gpxHCqG9gmVM+
	nOPz2Poa+j1Zs0L70hegP4O2HKc9oRELo+YX8uHWvTXzrl6PnegrNqf13SPA+eNaCrvynVK/tew
	Lz8QJTI78/wudL/icxP9WLFfMMhmdTtk1uP2XrBEOQLb7QPQ32s7tUY5orTUIeWKkQBycxMApIu
	RwOQWGOqKXglObK3Ox54aV1OvHVAS1GRCRJsj1OUbRZulvhqNj20Gfr+JjsKjHRLWbsJ325AkkV
	KH9LcK1JXH/JiIJAOlxs2Ku7D+Nr72iEVYw+clo6IbN6P9Vg1FtSfsYGaiJQqcic88FcHPyTC7J
	BpfbiUuHDRmUbirVseDWxWa/LRfxbPhz0vLKE=
X-Received: by 2002:a05:7022:2388:b0:128:c1be:152b with SMTP id a92af1059eb24-128f3d17a47mr3979973c88.4.1773590785354;
        Sun, 15 Mar 2026 09:06:25 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f62af8desm8122292c88.6.2026.03.15.09.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 09:06:25 -0700 (PDT)
Date: Sun, 15 Mar 2026 09:06:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, Savino Dicanosa
 <savy@syst3mfailure.io>, Jamal Hadi Salim <jhs@mojatatu.com>, Victor
 Nogueira <victor@mojatatu.com>
Subject: Re: [PATCH 03/12] net/sched: netem: add per-CPU recursion guard for
 duplication
Message-ID: <20260315090622.5fbdf074@phoenix.local>
In-Reply-To: <ydqKfVXU_4_kSsU89EbfSyd66aGeaCaVHFr6kXhrF-qG7G2WCAAOS51LTAM2y_thGnB0pp-pbGLDWqM4XooMX-jelz30W0KbpE3KzCKiWqo=@willsroot.io>
References: <20260313211646.12549-1-stephen@networkplumber.org>
	<20260313211646.12549-4-stephen@networkplumber.org>
	<ydqKfVXU_4_kSsU89EbfSyd66aGeaCaVHFr6kXhrF-qG7G2WCAAOS51LTAM2y_thGnB0pp-pbGLDWqM4XooMX-jelz30W0KbpE3KzCKiWqo=@willsroot.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267928-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syst3mfailure.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:email]
X-Rspamd-Queue-Id: 1533529157D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 14 Mar 2026 19:29:10 +0000
William Liu <will@willsroot.io> wrote:

> Looping in Jamal and Victor.
>=20
> On Friday, March 13th, 2026 at 9:17 PM, Stephen Hemminger <stephen@networ=
kplumber.org> wrote:
>=20
> > Add a per-CPU recursion depth counter to netem_enqueue(). When netem
> > duplicates a packet, the clone is re-enqueued at the root qdisc. If
> > the tree contains other netem instances, this can recurse without
> > bound, causing soft lockups and OOM.
> >=20
> > This approach was previously considered but rejected on the grounds
> > that netem_dequeue calling enqueue on a child netem could bypass the
> > depth check. That concern does not apply: the child netem's
> > netem_enqueue() increments the same per-CPU counter, so the total
> > nesting depth across all netem instances in the call chain is tracked
> > correctly. =20
>=20
> I'm assuming you are referring to [1] (and other relevant followup messag=
es), but has this setup been tested against the original repro? I think the=
re was a similar draft fix originally but it failed during testing because =
DOS still happened [2].
>=20
> If I remember correctly,  the issue is less so the recursive depth but mo=
re so being able to differentiate between packets that are previously invol=
ved in duplication or not.
>=20
> >=20
> > A depth limit of 4 is generous for any legitimate configuration.
> >=20
> > Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D220774
> > Cc: stable@vger.kernel.org
> > Reported-by: William Liu <will@willsroot.io>
> > Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
> >=20
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  net/sched/sch_netem.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >=20
> > diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> > index 0ccf74a9cb82..085fa3ad6f83 100644
> > --- a/net/sched/sch_netem.c
> > +++ b/net/sched/sch_netem.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/rtnetlink.h>
> >  #include <linux/reciprocal_div.h>
> >  #include <linux/rbtree.h>
> > +#include <linux/percpu.h>
> >=20
> >  #include <net/gso.h>
> >  #include <net/netlink.h>
> > @@ -29,6 +30,15 @@
> >=20
> >  #define VERSION "1.3"
> >=20
> > +/*
> > + * Limit for recursion from duplication.
> > + * Duplicated packets are re-enqueued at the root qdisc, which may
> > + * reach this or another netem instance, causing nested calls to
> > + * netem_enqueue(). This per-CPU counter limits the total depth.
> > + */
> > +static DEFINE_PER_CPU(unsigned int, netem_enqueue_depth);
> > +#define NETEM_RECURSION_LIMIT	4
> > +
> >  /*	Network Emulation Queuing algorithm.
> >  	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > @@ -460,6 +470,14 @@ static int netem_enqueue(struct sk_buff *skb, stru=
ct Qdisc *sch,
> >  	/* Do not fool qdisc_drop_all() */
> >  	skb->prev =3D NULL;
> >=20
> > +	/* Guard against recursion from duplication re-injection. */
> > +	if (unlikely(this_cpu_inc_return(netem_enqueue_depth) >
> > +		     NETEM_RECURSION_LIMIT)) {
> > +		this_cpu_dec(netem_enqueue_depth);
> > +		qdisc_drop(skb, sch, to_free);
> > +		return NET_XMIT_DROP;
> > +	}
> > +
> >  	/* Random duplication */
> >  	if (q->duplicate && q->duplicate >=3D get_crandom(&q->dup_cor, &q->pr=
ng))
> >  		++count;
> > @@ -474,6 +492,7 @@ static int netem_enqueue(struct sk_buff *skb, struc=
t Qdisc *sch,
> >  	if (count =3D=3D 0) {
> >  		qdisc_qstats_drop(sch);
> >  		__qdisc_drop(skb, to_free);
> > +		this_cpu_dec(netem_enqueue_depth);
> >  		return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> >  	}
> >=20
> > @@ -529,6 +548,7 @@ static int netem_enqueue(struct sk_buff *skb, struc=
t Qdisc *sch,
> >  		qdisc_drop_all(skb, sch, to_free);
> >  		if (skb2)
> >  			__qdisc_drop(skb2, to_free);
> > +		this_cpu_dec(netem_enqueue_depth);
> >  		return NET_XMIT_DROP;
> >  	}
> >=20
> > @@ -643,8 +663,10 @@ static int netem_enqueue(struct sk_buff *skb, stru=
ct Qdisc *sch,
> >  		/* Parent qdiscs accounted for 1 skb of size @prev_len */
> >  		qdisc_tree_reduce_backlog(sch, -(nb - 1), -(len - prev_len));
> >  	} else if (!skb) {
> > +		this_cpu_dec(netem_enqueue_depth);
> >  		return NET_XMIT_DROP;
> >  	}
> > +	this_cpu_dec(netem_enqueue_depth);
> >  	return NET_XMIT_SUCCESS;
> >  }
> >=20
> > --
> > 2.51.0
> >=20
> >  =20
>=20
> What about the last suggestion for a robust fix from [3]?
>=20
> Best,
> Will
>=20
> [1] https://lore.kernel.org/netdev/DISZZlS5CdbUKITzkIyT3jki3inTWSMecT6Fpl=
NmkpYs9bJizbs0iwRbTGMrnqEXrL3-__IjOQxdULPdZwGdKFSXJ1DZYIj6xmWPBZxerdk=3D@wi=
llsroot.io/
> [2] https://lore.kernel.org/netdev/q7G0Z7oMR2x9TWwNHOiPNsZ8lHzAuXuVgrZgGm=
AgkH8lkIYyTgeqXwcDrelE_fdS9OdJ4TlfS96px6O9SvnmKigNKFkiaFlStvAGPIJ3b84=3D@wi=
llsroot.io/
> [3] https://lore.kernel.org/netdev/20260111163947.811248-6-jhs@mojatatu.c=
om/

Thanks, this is a tight corner here, and not all solutions work out.

You're right that the per-CPU guard alone doesn't cover the
dequeue-to-child-enqueue path you described. That's exactly why
the series has two patches working together:

Patch 02 adds the per-CPU recursion guard, which handles the
direct enqueue recursion (rootq->enqueue duplicated packet hits
another netem_enqueue in the same call chain).

Patch 04 restructures netem_dequeue to eliminate the pump. The
old code had "goto tfifo_dequeue" which looped back after each
child enqueue, so packets the child duplicated back to root would
immediately get picked up by the same dequeue iteration. The new
code transfers all currently-ready packets from the tfifo to the
child in one batch, then does a single dequeue from the child and
returns. Packets that the child duplicates back to root land in
the tfifo but won't be processed until the next dequeue call from
the parent =E2=80=94 breaking the loop you diagrammed.

The original repro is:

  tc qdisc add dev lo root handle 1: netem delay 1ms duplicate 100%
  tc qdisc add dev lo parent 1:1 handle 2: netem delay 1ms duplicate 100%
  ping -f localhost

This is covered by tdc test f2a3 (nested netem config acceptance)
and test 7a07 (nested netem with duplication, traffic via scapy).
More tests are added in the new version.

Jamal's proposed change with skb ttl would also work but
it was rejected because it required adding ttl field to skb
and skb size is a performance critical. As Cong pointed out
adding a couple of bits for ttl makes it increase.
So considered the idea and decided against it.

Thanks.

