Return-Path: <netdev+bounces-300192-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MK3NGgmuMmox3gUAu9opvQ
	(envelope-from <netdev+bounces-300192-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 16:24:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E323C69A813
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 16:24:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=whOxRqH1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300192-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300192-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BE1F3095FA4
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312EF425CEE;
	Wed, 17 Jun 2026 14:23:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F944071D9
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 14:23:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706237; cv=pass; b=HNddePGtsoryPXu4/xdxU42oOYi5/8KhaYBa9PrvK4KPt2QraKJBhktfafmCjEm3dADZT/6JaqIxSUCVDKlxgUHENqPWtm51YJ0pK8NJ2xsmJf7FRASNRli2u1NskmNEOpEcqCVWq9fy0i3PC3eDrCqMW4K6aznsfUJMLSZeQtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706237; c=relaxed/simple;
	bh=d2KpV3nRxborC2VGa1wXFo1AV+iEyH9ShCvH3k2md1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uL8+m3VeEKmynxRjMJg7+MmEjpr2o80O+VuxBgEohF88proZ82CHSef3mbjTOIwg8ug+2ddvtVtytJQhVP0nsDyM5Zx6/LzGpgCmp9mtSugx68dy0Sc/YJf717vUNnxGUBiY+0ht1JxZlYyFyQoQZ89Zz5Co43i4udDR56k0s7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=whOxRqH1; arc=pass smtp.client-ip=209.85.210.171
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84531988438so233028b3a.0
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 07:23:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781706235; cv=none;
        d=google.com; s=arc-20240605;
        b=eKIeHarIQhHkUY7ZbBORU1FaCd+lXEr5DGzOnrTQL6y4s+L2GAsrA2Dh0tCpkfi7kU
         kxlRxA+aD4tS9FLx5fRjgsAzgCOmkrCTJ4S5gnR+Ea3IVh2JUaB+wYuY9oY/cAaqFEGO
         iznY1VT6A3Xy45PsQvLpadKI2cLBxOEsX4B8CSKL+5rSCu4uDlpAzxC9Aty0pnvcyKbd
         5z1yDEwcRr+4BojipVmFp+oBVSIBAeW3rUfM+oCVfOltDXVd2WcFZT9YGWgzrZzZcFEW
         /cm4QaBDCRlGDqSF+uiNZZbbKRGUI+hQ37BGm5lD6EvHR1pRPRsip3qaSU23H+mmyqnE
         znwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BsASFJTY9+IbIGlounf67kcAErjxSmbfmJjiw+y7eG4=;
        fh=rK9cgqV1BrCz3thbqOuUPM7G0xzghUport36JKT6PgM=;
        b=gl2aI0waTXilDWfqLDoc4MnJEDx/bNgEmf1aP9VqK9F6rBslBbQ+WcOzW+hAEjr/wO
         M243CgN3/Pa0TRdrShfiFje4UskcNLL2mh2ytFJLkRR+xUeax9HR/uUymVtqyF599TYg
         JKgSrDfI3SbbgrTDfGxrzHVqXbL6pJ3NjnnrXx4NKynDsNpDYgct+BefXsavZT3EUIwM
         uPH+a2QNIfHz2AWktWlrv7UqEyPjUeS7fD6oEvm1BbMW4ULiQPH6CuJWDvmGCON1bKPU
         mc0hKn25Tp4uMvMmqmxoX39bUwa4vilHziuqa7N+KR00hIEN1j0jfgeaENvY45QB6aEM
         F7tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781706235; x=1782311035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsASFJTY9+IbIGlounf67kcAErjxSmbfmJjiw+y7eG4=;
        b=whOxRqH1VXNs3mFhxdajn6H/aN4KYj7InpGr17zbWIIJ7N/kpY8ynNxVXbzB3XBNgm
         c8wO5klG0hSxouPH9JzcahipbCRwtilg3WIBNcqDwXdPVH8dW32NxIzoMppG37VNTtqt
         3uwcYnf28RYaLUw7wIozfGcrAmGkoJU8aVM5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781706235; x=1782311035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BsASFJTY9+IbIGlounf67kcAErjxSmbfmJjiw+y7eG4=;
        b=Lsv1sFWiZKqtDBNgrEk71isnTgk5QNNIszyq+wy/iE81J7y7klY6RQKd/Y8qnzUcxw
         bl29d3NysQkvGW3nVAYzvk1WSpHsuyVrd5G+xqU3hnifXUPP2OPHojjWtVKq6gl2zz70
         oWZLwQy2iiFJ+vqv4FG51TtLYSjz/zaloBMm9nuqYdBvwBuZGq6/h7+ouLFbEsFCpVCq
         +FExZxOC4qK0AalOWDmX3RQWxfyT9coqsX7/rZH/v9GvVKHtpfJq64bpweJWKp7mNVJv
         J/pD9oIPR9lwvm5RxzNokXRaFVPwn1iG+IepLnwSFeLwyy1fm3MgMTCWw9LNP3XI8yyX
         Wzaw==
X-Gm-Message-State: AOJu0YwQ32DFJdgWamju+8WucdkiP/tbnVtQuAl1ICjJHgc5nNolsit1
	ZO95optvUA6ritbdqodyjZXa5X7+6otdTHaX+vq9drFBAjfnh0KxbIYDqbEsiKVAoTyIH71Ehlk
	xSqcEdL7/OkmiYwBV3awNTXFcbQfewO0vdsADImh+rB2sc83yo77Tsw==
X-Gm-Gg: AfdE7cmruLGYoGohAdEKr+S1K8s2lQ6hr+PmH3NFzIBYqP6pDCFUAEuzCwPBro7HczJ
	sEXkJpwRhUKGH90kV/QaR2WMOBaBRcxQ8rC6aMNFQT98zTmJ9RQVwvKEZyE3edw2KIm5D8d1q3x
	a4gFs2niiy4g/PbvCERhGZIv9+56Tpk1Qh7A7pMWvhrxQvSbTbAEDhSgdyvDT29NzS/+oho4PxH
	uMSILtQUpev4bNG01iFtzlIscPpaIRl8F6L78Gq4pTEbwBD9SAmrYwYPPhfjQL+6d+W2qsktA==
X-Received: by 2002:a05:6a00:80e9:b0:845:2737:717f with SMTP id
 d2e1a72fcca58-84527377605mr2217986b3a.12.1781706235061; Wed, 17 Jun 2026
 07:23:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616220303.31552-1-b1n@b1n.io> <CAM0EoM=o+kBQNND8ViMe8bZQmFAtATav+CFMmtp1udzu+tpTzA@mail.gmail.com>
In-Reply-To: <CAM0EoM=o+kBQNND8ViMe8bZQmFAtATav+CFMmtp1udzu+tpTzA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 17 Jun 2026 10:23:42 -0400
X-Gm-Features: AVVi8CeQXDxrWnfMhd1LM_yWZOqeqMQ-64bu2UnFzcS5c8W8jDqmjX6QegYuXNk
Message-ID: <CAM0EoMmXrZ5pUAkuVScgQjPFm3-dSC03mygDm3sAaFO=TQgvDw@mail.gmail.com>
Subject: Re: [PATCH] net/sched: dualpi2: fix GSO backlog accounting
To: Xingquan Liu <b1n@b1n.io>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, stable@vger.kernel.org, 
	"Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:b1n@b1n.io,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:victor@mojatatu.com,m:stable@vger.kernel.org,m:chia-yu.chang@nokia-bell-labs.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300192-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,b1n.io:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E323C69A813

On Wed, Jun 17, 2026 at 6:23=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, Jun 16, 2026 at 6:03=E2=80=AFPM Xingquan Liu <b1n@b1n.io> wrote:
> >
> > When DualPI2 splits a GSO skb into N segments, it propagates N
> > additional packets to its parent before returning NET_XMIT_SUCCESS.
> > The parent then accounts for the original skb once more, leaving its
> > qlen one larger than the number of packets actually queued.
> >
> > With QFQ as the parent, after all real packets are dequeued, QFQ still
> > has a non-zero qlen while its in-service aggregate has no active
> > classes. qfq_choose_next_agg() returns NULL and qfq_dequeue() passes
> > the result to qfq_peek_skb(), causing a NULL pointer dereference.
> >
> > Count only successfully queued segments and propagate the difference
> > between the original skb and those segments. Return success whenever
> > at least one segment was queued.
> >
> > Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Xingquan Liu <b1n@b1n.io>
> > ---
> >  net/sched/sch_dualpi2.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
> > index dfec3c99eb45..37d6a8960310 100644
> > --- a/net/sched/sch_dualpi2.c
> > +++ b/net/sched/sch_dualpi2.c
> > @@ -461,7 +461,7 @@ static int dualpi2_qdisc_enqueue(struct sk_buff *sk=
b, struct Qdisc *sch,
> >                 if (IS_ERR_OR_NULL(nskb))
> >                         return qdisc_drop(skb, sch, to_free);
> >
> > -               cnt =3D 1;
> > +               cnt =3D 0;
> >                 byte_len =3D 0;
> >                 orig_len =3D qdisc_pkt_len(skb);
> >                 skb_list_walk_safe(nskb, nskb, next) {
> > @@ -488,16 +488,15 @@ static int dualpi2_qdisc_enqueue(struct sk_buff *=
skb, struct Qdisc *sch,
> >                                 byte_len +=3D nskb->len;
> >                         }
> >                 }
> > -               if (cnt > 1) {
> > +               if (cnt > 0) {
> >                         /* The caller will add the original skb stats t=
o its
> >                          * backlog, compensate this if any nskb is enqu=
eued.
> >                          */
> > -                       --cnt;
> > -                       byte_len -=3D orig_len;
> > +                       qdisc_tree_reduce_backlog(sch, 1 - cnt,
> > +                                                 orig_len - byte_len);
> >                 }
> > -               qdisc_tree_reduce_backlog(sch, -cnt, -byte_len);
> >                 consume_skb(skb);
> > -               return err;
> > +               return cnt > 0 ? NET_XMIT_SUCCESS : err;
> >         }
>
> This looks like a behavior change?
> Ex: If the last segment failed you will return XMIT_SUCCESS whereas
> before it could be with __NET_XMIT_BYPASS, NET_XMIT_CN,  etc.
> I am not sure what the best answer is and maybe it doesnt matter. Did
> you look at what other qdiscs do? I dont have time right now but will
> later - or you can before i get to it.
> Also, you didnt add the owner of this qdisc on your to:  - maybe he
> has some thoughts..
>

After looking at what other qdiscs do, your patch is fine. But please
fixup the commit to something like:

---
When DualPI2 splits a GSO skb into N segments, it propagates N
additional packets to its parent before returning NET_XMIT_SUCCESS.
The parent then accounts for the original skb once more, leaving its
qlen one larger than the number of packets actually queued.

With QFQ as the parent, after all real packets are dequeued, QFQ still
has a non-zero qlen while its in-service aggregate has no active
classes. qfq_choose_next_agg() returns NULL and qfq_dequeue() passes
the result to qfq_peek_skb(), causing a NULL pointer dereference.

Follow the same pattern used by tbf_segment() and taprio: count only
successfully queued segments, propagate the difference between the
original skb and those segments, and return NET_XMIT_SUCCESS whenever
at least one segment was queued.

Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
Cc: stable@vger.kernel.org
Signed-off-by: Xingquan Liu <b1n@b1n.io>
-----

Do you know how to create a tdc test that will recreate this? If not
either Victor or myself can help you create one.

cheers,
jamal

> cheers,
> jamal
>
>
> >         return dualpi2_enqueue_skb(skb, sch, to_free);
> >  }
> >
> > base-commit: fbc6a80cb5d3fd4ac4b56e8c9d791dd17be890c4
> > --
> > Xingquan Liu
> >

