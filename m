Return-Path: <netdev+bounces-281260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGFoOUIf72ml6wAAu9opvQ
	(envelope-from <netdev+bounces-281260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:33:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A33A46F1F1
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93022303DD46
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEE139B4AE;
	Mon, 27 Apr 2026 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xd/AzEmN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8817439A802
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777278481; cv=pass; b=APe3BuDLs/n63jKHNJI9j0cYbKLwdZr5VBd0uUsA750IRbvoTj+QtYIuZPMNZy8+zfs8/CWaenDGgpyFTJ4VOhvmzhZX+CzpWnjhVYK1dAMZj3uGGaAgVGMRQge5SwT3aIplAvDqqQiKpu7fnAJbV+NrsS4ydlOWGzWdiRMTmjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777278481; c=relaxed/simple;
	bh=ahM50bLxnOlcK1kxnDiGZ/Y2ZVMXfVPx1UagUo2UR6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3Vm/4bd2wDGhoCeYUSI8M37tIK6RKUk6j1cQ80BHFzvzLfiUE/GNfTCVleqR2qTcbiamujZsXU4VIts0q0qb+B+7ZzZ5YUrVXAy98+WWGhb7u4JZg18Wjw3MOrO0oa49JimteZPE12xvErcSWJFITwPsfIYFirFiD1ddTerZ8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xd/AzEmN; arc=pass smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8f0a87e23daso530908285a.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 01:27:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777278477; cv=none;
        d=google.com; s=arc-20240605;
        b=V7xI1XFfVovYKmuOR7r4pfemUrHvq3Y2s4CXBaoXWDltvax41btR7F/A4FVzRZ1mWG
         /KtQxoqocah9Xp1tvPqUcda7tLTiT8vqensCg2SMh0/+WU7f2cc1rgTztBjpAQ0eHmjD
         TrBu9wdjyczYAZk9YKBqte+WooU17kQsaRE6Oaw+lKebjHyibFtgmvpsiIBiUpude/wz
         ewrj+iqYwbMk/Hg2fAVQpf/nPKcmgydCsITT7LBCQFPJqzJBcXg1+lmr8H0v2PMhWj1l
         5FsCTnFXl+c1+m/OUC6q/ZqNcjRyKR4gGQox30jn8wr5K2h4ROpYsqx+ITovbhVgXABv
         M9rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NzRQtmQyDeow3tG+1q88VQVRuFU30b48U9CahT/A4Lo=;
        fh=YvZauPfoyCDAtZStUsOnkRoR2cdiXyRJIb8Ge3EmNyI=;
        b=lCvtLveVMLqdbNqsVzpQCrddKyeBT0ahdp31sTXxKPUQGMIU1YIkv6YQmfjJl3Lyyj
         XjIKSAHNVz/ft3S/yIlNuoLpN7qR+CG5e7MoEBFJvN88pQMzTHkul1ktFLJf9KVGti1E
         pHSZMDuknKL8kiFyD6IpwVrUbpWZnsuNKEWAefOLAdOMG6i6wzTXnBKyH5Pzz1L/I/d8
         2I/sfzzry0khPggYEnEHCprrRPyH5f12RK3LY9htGH3IHUVCJBV3zNfYk6QNPJNnzHcE
         h6N2EIEwUQliJUcobcP0hfqSZOfrKnlna7wLowCFHeW3ZS7xZCXL4IrEsVr7XKrho2EN
         gGgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777278477; x=1777883277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzRQtmQyDeow3tG+1q88VQVRuFU30b48U9CahT/A4Lo=;
        b=Xd/AzEmN+jdACJRym6KfllWBRcjGlVdkTT8M7FzXRNasKBmxurpw32rFT3C2g/SJHV
         Gz8KlTgEJo2923JzJIFXHohEVD+MDgZuJLrlVEFQ5lU63OasF9tjRRL8twPu78MIn9RU
         VgSNYNriYJb5OkjReYIzLTvtlnr/W1YC6ofroKVeLC9vgCz0aXRVUCSjF6R/JeSazHlG
         r3feQLdWq+ttKW3wm8o1M+2tdvFB5x70SOrhtsC+97JFF49mlxOTqahd0zK6snQRwdJm
         HGTHdNAOomES1L1YGAo/s4YYc7VOmd40+QGPYYLxe1NY+tLNwLcUD6tPjgJXnk1U4GNW
         KpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777278477; x=1777883277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NzRQtmQyDeow3tG+1q88VQVRuFU30b48U9CahT/A4Lo=;
        b=IcDb2Wp6yKV+tdZd0YMhTmimzTXq6qq3C/CG8g86aCZGzQ0jSR709IBJNmONeIOtGh
         3nAOm8qDVFIa4/p/+E4hiYaNFNNObTgFXUy2TbyMN59xx0+JAs2IbePurNRTgs+21fG1
         bzq1YL5mdkF7dQ0XepkNzilSGW+V83af9TZQ/DPeBb8+G63ZhZTz1tcrcM+frAzCG453
         QJOKdkx0UXw0czDOrS2L+rlIJNo2I7vVFkcX7k5dgtENj5p8+1UOivlsB5YzRhVmeWLS
         bYJDHpjOLUwGwTzw79qjR7U/we+5C7O9CEGv1laW4y6+eBkPqL/6l9Vn/pd7xNVvFORN
         Y6NA==
X-Forwarded-Encrypted: i=1; AFNElJ8jpehfXr7y18J3prQy7DT38p/ZHxdfrIG2p+dkP7tcinEQjWFlVtx8X4UBtUfzjMlEnJfCmcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCF5ed0EWyJagr2Jj9xeX7DNhG5hfdD1Gy3UEhDnRBPskjA1q2
	Jt3sO7Do0fLML/MDKbELzx1yN4DGAXqA4RaUShHRKxNZFj0jq88PCCTcJB1BmD6SeXvTg6n37Br
	vxFEHmw58HvtlyE/ZdtdYtjIfQW87GDPksXD6V5Na
X-Gm-Gg: AeBDievWiD2/YXOj+LKmtckkxgf65G5PH1ta7sLSCVVtRKEcfX9FxZHTo9a9s2Lt2Gj
	crHjjXmT2BU8CIgcNPXbG5W7GhnGqG5uMSP03v/YinuHZQAiQiwEcIEOACR68hBOXObPS6NYxJD
	1ALCU0uQLODm3jVsDRYO/DnHqMg77xOmIDo0Ggn2ARTfgHhfx0xNXbbbKWNwdHVARdQMHZSnheK
	fYrmJEWt3onSvhS51kE4EqGZPDPuhQQm+pK77UZlZkB5/fPffgPW0MBWXT0XSAK3ITeNYqnPHmz
	/MSfjVJgOm+eEVScmo2ByPxycauXOozaEvpSBOtHBzoBzyj/3cV97KZDq4asaPGrIethFs+AB1G
	1HStKVAMG
X-Received: by 2002:a05:620a:4005:b0:8ee:eb50:4f64 with SMTP id
 af79cd13be357-8eeeb5056c7mr3465727285a.57.1777278476436; Mon, 27 Apr 2026
 01:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423102324.3172448-1-edumazet@google.com> <20260423102324.3172448-5-edumazet@google.com>
 <871pg5yixa.fsf@toke.dk>
In-Reply-To: <871pg5yixa.fsf@toke.dk>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 Apr 2026 01:27:44 -0700
X-Gm-Features: AVHnY4KZ-VVTXqLrRZlT-bh_6Ltopx1ges6xwPbfP4_FbTFkoWRHEOA-ULS3Keo
Message-ID: <CANn89iK_kijfHuoHcDnxPKzGUe0tC_poGTdLmZSVtD2sJOg7uA@mail.gmail.com>
Subject: Re: [PATCH net 4/5] net/sched: sch_cake: annotate data-races in
 cake_dump_stats() (IV)
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4A33A46F1F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-281260-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, Apr 23, 2026 at 5:12=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@toke.dk> wrote:
>
> Eric Dumazet <edumazet@google.com> writes:
>
> > cake_dump_stats() runs without qdisc spinlock being held.
> >
> > In this fourth patch, I add READ_ONCE()/WRITE_ONCE() annotations
> > for the following fields:
> >
> > - avg_peak_bandwidth
> > - buffer_limit
> > - buffer_max_used
> > - avg_netoff
> > - max_netlen
> > - max_adjlen
> > - min_netlen
> > - min_adjlen
> > - active_queues
> > - tin_rate_bps
> > - bytes
> > - tin_backlog
> >
> > Other annotations are added in following patch, to ease code review.
> >
> > Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cak=
e) qdisc")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: "Toke H=C3=B8iland-J=C3=B8rgensen" <toke@toke.dk>
> > ---
> >  net/sched/sch_cake.c | 90 ++++++++++++++++++++++----------------------
> >  1 file changed, 46 insertions(+), 44 deletions(-)
> >
> > diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> > index c5aae31565e984e40937b55201b498174a37180e..c3b09f67f0fdbc51d23b3d2=
2df9ab89a716c7e2b 100644
> > --- a/net/sched/sch_cake.c
> > +++ b/net/sched/sch_cake.c
> > @@ -1379,9 +1379,9 @@ static u32 cake_calc_overhead(struct cake_sched_d=
ata *qd, u32 len, u32 off)
> >               len -=3D off;
> >
> >       if (qd->max_netlen < len)
> > -             qd->max_netlen =3D len;
> > +             WRITE_ONCE(qd->max_netlen, len);
> >       if (qd->min_netlen > len)
> > -             qd->min_netlen =3D len;
> > +             WRITE_ONCE(qd->min_netlen, len);
> >
> >       len +=3D q->rate_overhead;
> >
> > @@ -1401,9 +1401,9 @@ static u32 cake_calc_overhead(struct cake_sched_d=
ata *qd, u32 len, u32 off)
> >       }
> >
> >       if (qd->max_adjlen < len)
> > -             qd->max_adjlen =3D len;
> > +             WRITE_ONCE(qd->max_adjlen, len);
> >       if (qd->min_adjlen > len)
> > -             qd->min_adjlen =3D len;
> > +             WRITE_ONCE(qd->min_adjlen, len);
> >
> >       return len;
> >  }
> > @@ -1416,7 +1416,7 @@ static u32 cake_overhead(struct cake_sched_data *=
q, const struct sk_buff *skb)
> >       u16 segs =3D qdisc_pkt_segs(skb);
> >       u32 len =3D qdisc_pkt_len(skb);
> >
> > -     q->avg_netoff =3D cake_ewma(q->avg_netoff, off << 16, 8);
> > +     WRITE_ONCE(q->avg_netoff, cake_ewma(q->avg_netoff, off << 16, 8))=
;
> >
> >       if (segs =3D=3D 1)
> >               return cake_calc_overhead(q, len, off);
> > @@ -1596,7 +1596,7 @@ static unsigned int cake_drop(struct Qdisc *sch, =
struct sk_buff **to_free)
> >       len =3D qdisc_pkt_len(skb);
> >       q->buffer_used      -=3D skb->truesize;
> >       b->backlogs[idx]    -=3D len;
> > -     b->tin_backlog      -=3D len;
> > +     WRITE_ONCE(b->tin_backlog, b->tin_backlog - len);
> >       sch->qstats.backlog -=3D len;
> >
> >       flow->dropped++;
> > @@ -1824,9 +1824,9 @@ static s32 cake_enqueue(struct sk_buff *skb, stru=
ct Qdisc *sch,
> >               }
> >
> >               /* stats */
> > -             b->bytes            +=3D slen;
> > +             WRITE_ONCE(b->bytes, b->bytes + slen);
> >               b->backlogs[idx]    +=3D slen;
> > -             b->tin_backlog      +=3D slen;
> > +             WRITE_ONCE(b->tin_backlog, b->tin_backlog + slen);
> >               sch->qstats.backlog +=3D slen;
> >               q->avg_window_bytes +=3D slen;
>
> nit: these break up the aligned block, which hurts readability, IMO. Can
> we keep the WRITE_ONCE() lines at the top or the bottom of the block?

Ah, okay.

