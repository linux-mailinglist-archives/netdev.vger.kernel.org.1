Return-Path: <netdev+bounces-299417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PsKZDOPsL2qSJAUAu9opvQ
	(envelope-from <netdev+bounces-299417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:15:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49705686128
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:15:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=hcj819xR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299417-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299417-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02C893091579
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36743E5A10;
	Mon, 15 Jun 2026 12:09:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3053E5A27
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 12:09:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525387; cv=pass; b=aY1OJHU3tkPQZX0mKmBK3bSDw/6JAyCYqSOkSLa/m7tKjG20xPSiBBuFzfRI0y9K4Byru6RTrvKyXkMId4DrvNGSeFiNjGh/Hh2LZBQivSVU/ABuAeg9DyEE6HIg7r7mSRNv2uBjXwGf3brjznO05nyW3tYzUfnYF+qQ5aRu/fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525387; c=relaxed/simple;
	bh=HvacIs2nInIxMSEmztn+LSIjL5I+Te0kY8ejBPJVe7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mPoo7wydLOGJbxzt1MNmkaXopAZTpWlhCha89eXNr/Th31ESRwOAjPFFGAUgMU1LO9Ll9gtkzRoMAUCyCZYln/8DU1R6fKTHZkTkLBaocR7CXD1xXLnBcHEJ+koB8KttF568l9JfLi7ekgYXT8BprCbbSaJ4EUrdVDN2xLe1Jdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=hcj819xR; arc=pass smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-842307473b5so2285639b3a.2
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 05:09:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781525385; cv=none;
        d=google.com; s=arc-20240605;
        b=hI6+YgGtdyXLqLdnxUbL8OObcDRXMkgXqZyAUUhMF5e9DXMtlFce+2PU/PLGXm3k75
         EnM1SeWdMefOoaUNnL++cO7xlZSnXQdxNTKn+PkHcICX4Tcd3kEPiXR2Nwm2woDra5h1
         PxovMV0XL60niDOWElF+dk536SgAlJ59gMydxxBZtghEMY5FMak/hOENhOKBk0Ro6myy
         p3x9ARPsfK8KrLu/ij6h/b7mEXdHjct88RbA36LelJyGzb1vxzjvnwAgV3tekTjFITb/
         3nSRg0kIHKneLvwG2I2k+VD+9DTdc4ujVzGiOqjx4iFfAOqkKj3wPC4MHqXH+k7+bnpP
         Jjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ThvrfqoNFs5/K7e9pV8lMKNCJzlUDh9xTXNgwYmjJ84=;
        fh=HH+R3vT7S2GYxuKHUFlD/9lHt0VJtU0mtuxocaftLnY=;
        b=cAlOocypQ8nyfqUiZq633Eowo2G4ZJMNQX1c9aL4OPic8LfBvL8nBveU9ILyKJrLuN
         tNO939MAl2umhuUeI9dwMNbSgv7r1FPGTyKKcKIPuFaap1fqM7gycJ7ltg2JlmUI/ymM
         kyCWf9pCsj0xvtySaWapZqUqohg51VTvn6k67ixRtyt5IPNERJ7nhli1CVcopzSiDU5s
         SqeFTmSSc1Drfcps+WkyCbgy8jLXBkBRyVxLzGfSP9e6ewWDCjG4yZ+uuybWQnCAUHp2
         AVzds4Ef01kuHGaU7Rl73qAt5Z8va5+KzVfWpm4pIxyS5kdCjeDn3D05ES61qRV7n63i
         8gVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781525385; x=1782130185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThvrfqoNFs5/K7e9pV8lMKNCJzlUDh9xTXNgwYmjJ84=;
        b=hcj819xRMxyBX41J9CD4w5D2klCDKFj5sw/YDTJwjI3cihSiIOQJDZ0NaYfyTFuPMc
         cofb9p9LgWnghbqEW91xTCv/NYqaUF55V8GIhEmI3LnCUx6qFyEkUOTRMXV9ebuqh83P
         uyu3yIV6kItRz0sjICbkNOKmEFGj+odwPkkn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781525385; x=1782130185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ThvrfqoNFs5/K7e9pV8lMKNCJzlUDh9xTXNgwYmjJ84=;
        b=I1HhWWoxsKE6sj8M/A1WmkdG4s9oKCvwPkmOxDPoqu4EpdwdWB8G01pR3+R17WekKn
         74W1s9Jw2QVe3/NghZZ+U+aJBUcJa4NOaeH8hb5dmnXKL33npl72Lk1Hl2ccmC96O7hg
         083xOqH6O0wMzDMmgMbrVgq72eP6QW/A2riHioJgxTDHCU5vfklqcQuK5EPcf4xGRn09
         bB+E7Tb0uBqaXnDhCP7I4VGHwO04xHet8AxdokgnqAJJ2pUbAQ8UNUrzRN/LD1TWBQX7
         1rX4qx4NOui4M/a5mGYvsOrDZBf293oiDbmipeFjVZAlyZpOqmIOIKKs2LB0huGmANKh
         fVNQ==
X-Gm-Message-State: AOJu0Yww62pDsh1B8Vr9+P1JOKnb5tPkHEouof2zUxfOcwNb00L+KAgX
	INiwrlb8/ATJWBA6u4KXo0aScMPSEI4oMr55DFQetAFe5iSKl4MR9+K3LBiDyzEvoWRNjXa/unv
	ysoqh7w4On99wStWOvhSZvYorTKhp80BT5lHImuRl
X-Gm-Gg: Acq92OHG5Y5lsBpTbHq5J9pNAG2wbxGwe8bwm3GKBhyxZ7D2MpIK0EcFpAQPWu5pHqB
	KgcaUZ4OIQFblCyj8XiDb4+6mA3M0cPiXhz97OsnKsDlod0y2or2ZRFE9PemHkHKJsN3kfeL3oJ
	Z3ysziw9X89+5P8XpE4+QQxxzHZIQWEaRVghiMwAVU+JgMPK8Ix0W3q+bldb9E5FsYL4aBekBGU
	SHCfjr215TCq1ei06xVo1vs6Fxxui3vVYmeNR3nLXlDA23Gbpat4cT748sP4BcgNoVkKSxw5hrB
	ViBtMMlN
X-Received: by 2002:a05:6a00:2356:b0:837:db4e:a35d with SMTP id
 d2e1a72fcca58-8434ce465c3mr14613357b3a.23.1781525385472; Mon, 15 Jun 2026
 05:09:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615103759.2404228-1-n05ec@lzu.edu.cn> <20260615103759.2404228-2-n05ec@lzu.edu.cn>
In-Reply-To: <20260615103759.2404228-2-n05ec@lzu.edu.cn>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 15 Jun 2026 08:09:33 -0400
X-Gm-Features: AVVi8CdDXgliVtwdoFs0UoGj-v6fR9P0GXS4PLQ8amOWdbcDriedovASOWD9CYk
Message-ID: <CAM0EoM=t6DYomidQW7RVSZsKvKW4tM3HHrg_fWK=tpqcQHD_Mw@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: sched: ets: avoid deficit wrap and
 empty-round livelock
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, petrm@mellanox.com, 
	davem@davemloft.net, yuantan098@gmail.com, yifanwucs@gmail.com, 
	tomapufckgml@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn, 
	bronzed_45_vested@icloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:petrm@mellanox.com,m:davem@davemloft.net,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299417-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,resnulli.us,mellanox.com,davemloft.net,gmail.com,lzu.edu.cn,icloud.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid,lzu.edu.cn:email,icloud.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49705686128

On Mon, Jun 15, 2026 at 6:38=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Wyatt Feng <bronzed_45_vested@icloud.com>
>
> ETS keeps each DRR-style deficit in a u32 and replenishes it with
> the configured quantum whenever the head packet is too large. Both
> the quantum and qdisc_pkt_len() are user-controlled inputs: a large
> quantum can wrap the deficit counter, while a tiny quantum combined
> with an inflated qdisc_pkt_len() can force billions of iterations in
> softirq context before any packet becomes eligible.
>
> Store deficits in u64 so replenishment remains monotonic, and after
> one complete pass over the active list compute how many additional
> full rounds cannot dequeue from any class. Add that budget in bulk
> instead of advancing one quantum at a time. This preserves ETS ordering
> while removing the non-productive loop.
>
> Fixes: dcc68b4d8084 ("net: sch_ets: Add a new Qdisc")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/sched/sch_ets.c | 63 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 44 insertions(+), 19 deletions(-)
>
> diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> index a4b07b661b77..ed3b191781ee 100644
> --- a/net/sched/sch_ets.c
> +++ b/net/sched/sch_ets.c
> @@ -40,7 +40,7 @@ struct ets_class {
>         struct list_head alist; /* In struct ets_sched.active. */
>         struct Qdisc *qdisc;
>         u32 quantum;
> -       u32 deficit;
> +       u64 deficit;
>         struct gnet_stats_basic_sync bstats;
>         struct gnet_stats_queue qstats;
>  };
> @@ -465,8 +465,10 @@ ets_qdisc_dequeue_skb(struct Qdisc *sch, struct sk_b=
uff *skb)
>  static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
>  {
>         struct ets_sched *q =3D qdisc_priv(sch);
> -       struct ets_class *cl;
> +       struct ets_class *cl, *first;
>         struct sk_buff *skb;
> +       u64 extra_rounds;
> +       u64 rounds;
>         unsigned int band;
>         unsigned int len;
>
> @@ -481,26 +483,49 @@ static struct sk_buff *ets_qdisc_dequeue(struct Qdi=
sc *sch)
>                 if (list_empty(&q->active))
>                         goto out;
>
> -               cl =3D list_first_entry(&q->active, struct ets_class, ali=
st);
> -               skb =3D cl->qdisc->ops->peek(cl->qdisc);
> -               if (!skb) {
> -                       qdisc_warn_nonwc(__func__, cl->qdisc);
> -                       goto out;
> -               }
> +               first =3D list_first_entry(&q->active, struct ets_class, =
alist);
> +               extra_rounds =3D U64_MAX;
>
> -               len =3D qdisc_pkt_len(skb);
> -               if (len <=3D cl->deficit) {
> -                       cl->deficit -=3D len;
> -                       skb =3D qdisc_dequeue_peeked(cl->qdisc);
> -                       if (unlikely(!skb))
> +               do {
> +                       cl =3D list_first_entry(&q->active, struct ets_cl=
ass, alist);
> +                       skb =3D cl->qdisc->ops->peek(cl->qdisc);
> +                       if (!skb) {
> +                               qdisc_warn_nonwc(__func__, cl->qdisc);
>                                 goto out;
> -                       if (cl->qdisc->q.qlen =3D=3D 0)
> -                               list_del_init(&cl->alist);
> -                       return ets_qdisc_dequeue_skb(sch, skb);
> -               }
> +                       }
> +
> +                       len =3D qdisc_pkt_len(skb);
> +                       if (len <=3D cl->deficit) {
> +                               cl->deficit -=3D len;
> +                               skb =3D qdisc_dequeue_peeked(cl->qdisc);
> +                               if (unlikely(!skb))
> +                                       goto out;
> +                               if (cl->qdisc->q.qlen =3D=3D 0)
> +                                       list_del_init(&cl->alist);
> +                               return ets_qdisc_dequeue_skb(sch, skb);
> +                       }
> +
> +                       cl->deficit +=3D cl->quantum;
> +                       list_move_tail(&cl->alist, &q->active);
> +
> +                       if (len <=3D cl->deficit) {
> +                               extra_rounds =3D 0;
> +                               continue;
> +                       }
> +
> +                       rounds =3D div64_u64((u64)len - cl->deficit + cl-=
>quantum - 1,
> +                                          cl->quantum);
> +                       if (rounds < extra_rounds)
> +                               extra_rounds =3D rounds;
> +               } while (list_first_entry(&q->active, struct ets_class,
> +                                         alist) !=3D first);
> +
> +               if (!extra_rounds)
> +                       continue;
>
> -               cl->deficit +=3D cl->quantum;
> -               list_move_tail(&cl->alist, &q->active);
> +               /* Skip full rounds where no active class can dequeue. */
> +               list_for_each_entry(cl, &q->active, alist)
> +                       cl->deficit +=3D extra_rounds * cl->quantum;
>         }
>  out:
>         return NULL;

Hrm. This appears like overkill. Doing a div() in the fast path is question=
able.
How about we bound the loop per dequeue to have an upper bound based on nba=
nds?

cheers,
jamal
> --
> 2.43.7
>

