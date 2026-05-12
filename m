Return-Path: <netdev+bounces-287258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMYABp1qA2rF5gEAu9opvQ
	(envelope-from <netdev+bounces-287258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:59:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FF1526757
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00D3B30FC566
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB1F3BB105;
	Tue, 12 May 2026 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="grveT7Xu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803093955DC
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608216; cv=pass; b=CfAcGpjeXyA4ekiIk4tx/3Cl39qvWAJDlHm7TpWflQr7GG1ohYolqtsD9BgsuACNCYSPQgFalfxo/Jkqp8NnvlWiJdgVWzUgWUKGuOo7E0RS5iSBD6VuGL2ExzhCAmTWJlV3gCtcnkJCLxt3mYg/QrIAAGXs3hC18TAUm9ph9HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608216; c=relaxed/simple;
	bh=Sk3beDXiLiGZJd4+K0GWDvrP4LTrOCS7ZsevehdjJho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NEXU1R1qmYp1KkzoGpT1d01o/N4xXDpXc3OlKumJ39KeHQNxKEMrhRZwnLutq0qhw0HeIZ2HouXA/Z9ukCS++bIGZE0iDG1tpkfyQ4NlhjTa0enkpbcSxefGgqGsbrdCgVM9FxA5QcUrLasKlKbPtwwwi8oJIV+Aa+1gRW4rks0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=grveT7Xu; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51306c9f2a8so60255511cf.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 10:50:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778608214; cv=none;
        d=google.com; s=arc-20240605;
        b=Z0wlxS6gPB1GQJkRUIx4PyPt8WQofRUmyHoJYyLb3B76nXJXuQHV8GkkCpRGLAzVQi
         Z5jcVtep9/m/GgHZ3o6cVoeolnKfykDrw3F44PFTeA+Y43pA6EfBiMCYTbvs3qQlqxZR
         EWEU1IQVMm1KVhMOiZPWOiN8qUy4r7D77E29Zm8WZawYsvJUTYxjqkoiETTFZs2LwTvf
         27hTAyMgXHKOP+T0J9nAOZ2tyKXlG/w+XzZ3AgcQ7cnQqFFihf/L1vNDCHXHsfEVYsPg
         jsOKUCMYYY/aJ4ld0Y8jWfIigjKW5VnvMQ4EFXvL3r4EGWYENEcZGHVaFMEa+VtzqqNV
         sUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pz5vjdufFc/XRDM8Y5tcp6V/nGTFT6ytM8wW6kRTrtw=;
        fh=WOSoNv0hz6iqmHJLecc2x6kKrOgFm0n2ot8ULsgBFqI=;
        b=bJ1rmAP/PvzHP+XHyqzZ4FvNzJ+CTZ1NPw8J80FwlAZ7YTryKVXWLlkeWl4q5d5IAn
         N/OoSOYODGi/45BGDP6v/gWIlVJeAWIwr3WIj+SXQa4i9ma/Q85QzFtyMW+i4SXxu/zc
         OXSUPaV8oYRhNhA3re3Ba26yXaTaUJH6icCleOFU7U0DM/G+8SndBzCxBWx6SmKoozAd
         sR1K5KGSDz6QDrB5I1mpJjRMcvyDhXcPxqrn7cHhKI258ACBnfrpedhp8YvEf4oFpkIV
         JcxKTHk5mqz+gkkA97ckLenJMWJWo617fBFRx/AkWZ0mzJWAgBV8OMekhikMkcr4Kevb
         vqQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778608214; x=1779213014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pz5vjdufFc/XRDM8Y5tcp6V/nGTFT6ytM8wW6kRTrtw=;
        b=grveT7Xuro8Un+ZgCyjOjwlDtT4xemHBlkJfgfxl2BQceKdWW9KVHojR8tVxjqRUZp
         caXt/ZxHZ9tmTvMMnYjQPIjc38HAL4tKZORiPreSCTNSBuHdzI9ATs71MzHINKQsonws
         scEYMt8kwJLY1c2bhdgzc2oFCjRpW3+Nb/ousWk5CaSP3dSAMvfhL9S35FNxo+OLy0NY
         DIVSeVZf1rGHKccfjNbnEpw4T8d+AAsF9tyBcm/za/l9KM2D9Ywz2/cN4jHM1TAEKVRu
         4Tc2QSdA8bdTZqbUMGVr47def6SzATwlw1McHxl2WtqU/58ZTSV9SQzox0qmGI4tD5jl
         FICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608214; x=1779213014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pz5vjdufFc/XRDM8Y5tcp6V/nGTFT6ytM8wW6kRTrtw=;
        b=DpS2PqDXArdQl0D40rzOfaVqm+//sM4xqPj6a/DMW9AibctUGzqcvmZakORfH88SMl
         V6s7aXOCo4fQudcy5G3NE/NpFrdNJjDC/Ud0atx81BEXYUZAshe3Q5qWrgPvy63x14AY
         w/ORBoKlg8LFrAKPIaA43wI3HrXVWDElbth+mRel8nJyUysVUuxjO5DtFWPQm3DpvAno
         4LZs3cY3yovn9fyaFIJwT4hBcALThKldi5njnHTUsov4xJqpEfS+MNJBoL5uZq26ijmy
         JVWKLPBh+DQoKihrg7U19H9NCvayNkQ+1yWreZeIHixDB/QF2xTPf3V/EsE3thTmhRth
         Y/Gw==
X-Forwarded-Encrypted: i=1; AFNElJ+gAvbbnQIsYZZghYj7duT6dYqOBNmbX2de0sR1tIHdQkIn36xaJnFARm/vIjdTjqedCKQyVkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVw7BYbxIty4L8ojwo7X66FFXt40vIRdlQ9q027WPR7CZSOplQ
	VD07xRYUt3CTWbn6Mwyk9iT8Sqg2abwqeMQfVgz44C5hQUGKFhbZB9B/KRjbJOtMZsmbgg2YXgM
	e3ze9RR30VDFz3NN88m9mL6J9ZyP/bR6kPRr7PJYl
X-Gm-Gg: Acq92OGB2BXQEgmZdKdpKd29hNFWuH3uX4TLu+HDOnPmecPC8C6ztwmREN9q4DswZ0t
	dDZO7YZGoRZV8lgk9qmRgNamLBLk/p9BGveiLVylwSfSl4z3r2LzX1DPrGFwegSO49MRQwNGDkj
	CyJsVhfzn9f9nTiUsb3b3iDdtQbdvqXJBQpeHu3sKkm4gEbXv2GPUWfi+AnBrmmcL4VTySMcPbd
	qvSaMCAEMg1I08L+c6w0La22x9DJnOYORMuxuYylMGcbA+G2203S8KeuGE/3Qwn0v0U8PuPsKPb
	swtSgvSFj6DXqg4V5Tatzw5glPcYjbL8RWFv1g5d+GVlAyfMSyw0K//CmtZHbLaG1rlTI/9C4Hm
	3T8Wy9O3sjbwzzKPKueaTKsPKkGxaag==
X-Received: by 2002:ac8:700e:0:b0:510:1b61:d103 with SMTP id
 d75a77b69052e-5148e95028bmr202041501cf.36.1778608213418; Tue, 12 May 2026
 10:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512094859.3673997-1-edumazet@google.com> <20260512094859.3673997-3-edumazet@google.com>
 <87o6ikygiz.fsf@toke.dk>
In-Reply-To: <87o6ikygiz.fsf@toke.dk>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 12 May 2026 10:50:02 -0700
X-Gm-Features: AVHnY4J6uhDXn9hPakOPL6hm4JpRaMlBMtDL3QvTm5QWa7GB9bvJfcNCRdOYa3Y
Message-ID: <CANn89i+0mw1MRXaWiDfMr1j4dYgot54roxFs8gTMCQYRQVUz9g@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net/sched: fq_codel: local packets no longer
 count against memory limit
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 82FF1526757
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-287258-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,toke.dk:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 5:11=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@toke.dk> wrote:
>
> Eric Dumazet <edumazet@google.com> writes:
>
> > Commit 95b58430abe7 ("fq_codel: add memory limitation per queue")
> > claimed that the 32Mb default was "reasonable even for heavy duty usage=
s."
> >
> > In practice, this is not the case.
>
> Well, the assumption lasted a decade, so that's pretty good? :)
>
> > Packets that are associated with local sockets sk_wmem_alloc
> > do not really need additional memory control.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/sched/sch_fq_codel.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> > index 1b1de693d4c64a1f5f4e9e788371829dea91740e..71107dc52be799a14f370f2=
ad74d2eadd93992c1 100644
> > --- a/net/sched/sch_fq_codel.c
> > +++ b/net/sched/sch_fq_codel.c
> > @@ -212,7 +212,7 @@ static int fq_codel_enqueue(struct sk_buff *skb, st=
ruct Qdisc *sch,
> >               q->new_flow_count++;
> >               WRITE_ONCE(flow->deficit, q->quantum);
> >       }
> > -     get_codel_cb(skb)->mem_usage =3D skb->truesize;
> > +     get_codel_cb(skb)->mem_usage =3D is_skb_wmem(skb) ? 0 : skb->true=
size;
> >       q->memory_usage +=3D get_codel_cb(skb)->mem_usage;
>
> Only one concern here: q->memory_usage is exposed to userspace in the
> stats, so this will look like the packets queued are zero-length to
> anyone watching, which may end up confusing folks? Also, there will be
> no way to see how many bytes are actually in the qdisc.

Standard qdisc stats show the amount of bytes and packets.

None of the other qdiscs seem to care (except cake which copy/pasted fq_cod=
el)

>
> Should we keep a separate counter so we can still accurately report the
> memory usage to userspace?

Only purpose of mem usage counter was to have an idea of how close of
the 32Mb limit we were,
this is still reported for forwarded packets (router workload)

All these counters take precious resources, I would rather not add another =
one.

