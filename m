Return-Path: <netdev+bounces-284024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BpgNu3z+Gke3gIAu9opvQ
	(envelope-from <netdev+bounces-284024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:30:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F32D4C341A
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1872B306796A
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 19:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102713FADF9;
	Mon,  4 May 2026 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="zD3OTJeQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500F33F54BA
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777922449; cv=pass; b=SJSxXwqyolauMbTvM+63O70ff8A7oT5veMnTNL4xbLS9vhG4mQnsQk7bP4CitKm66jfx6mPU1IMzHQfiQwpjInod41cbgPF9Cuvgoc8DuRaJ74bv/PXSwKjCo538MVn8EM1OKsnmBBqFYyLe2z8zw+0E/dXTBISDbsSS0LTcy9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777922449; c=relaxed/simple;
	bh=4XYhsiKMFMCJrKWdILsevoCnDzBNHBjHpzrTjpBkeLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F8Dsl9CJ3kS26i0116XTt2KknD9QgtIOuvPwxp6CUvsjhgpTi0+jxebj0j8Fqt0th2RRklgi7a2Cqx0TXVrzBuk8sKBf0hp6jgSb2Q81f/QJxxwqjF2oyEsgk8Hjf0j32o9f+NW7qwQv21o+g4uH0I24IBHbXane7tfY26gQm2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=zD3OTJeQ; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82d0b68837aso2315172b3a.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 12:20:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777922446; cv=none;
        d=google.com; s=arc-20240605;
        b=XTyvmaONGqEVave36n7x+27hfseXp5wT5GyQS2bN0hZNxFKWgWNF4LbPcXcHfTMfUz
         ARD49wjEtLJW/B68SPl6qWqSk1R03Im5CP+1KmeA3avf3G9UM8kFhDq3nM2BHRxiiwFW
         ylbGtFq14sCQAc/TfO/52vhfMH4yEC4PY+SgjY1TMOEPYmdrgQmSEr+FPc5zuplQFTVK
         dBOJljdIhY0CeNp7J9IswAse460BxLo3QafctoD1AQBJcSd08t7U0DjH19xU2ELKClsk
         rsboHUw8RO7GEn3vmnDQaveWBCIRdql/lCbiArSIqXp6OfW8bRS+n9WG0CgXXSAOakC1
         7+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uXcPAFVNZHSUg0SQZLPd+d1ffbri65Pno+fddvc4Ouw=;
        fh=c00vQVPrRPknT3N+x5PhFtNYlL5qkudz/Yf1roL848c=;
        b=eSJuT0gsA7oGGKfKtwQD3b4upQ7C91fAH9nl5SSWDvSa6WPDV4a4R3Q3uDcd3gWbN4
         vT6m+Xd2q10pPOJ0HMPZYxIXchtMMd5QvwwKjB6Fe1JTNYCMfMEt5qcgPTERVEJU2w0X
         R1DmFoHVFsDXkmOdP46SdciW0VW8vkIZUI7CEF0XDhmQgkWhV5TIWYcaQVBsd5XO8bPh
         s8HeNgLsjWV3xFg8HIl4BlmvoFlU57FIz17cK661YsJOU1jALENsTnbwWcfNSBZyUXMh
         xA9cmn1c9h8JN/nuFeStkACCGQU0xs+n2kU/4s5DJh0juyLb13ODOUQTMi+TeKG0cVgf
         /vmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777922446; x=1778527246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXcPAFVNZHSUg0SQZLPd+d1ffbri65Pno+fddvc4Ouw=;
        b=zD3OTJeQATMd4Z7r78RfmLRoW+lHh2EvKhO9DmaZepRt4V6a1KEOV3cYgHl+PU7gRZ
         PWFKsyveZPJ0hOlSWWmd2R8hFKdBsL2Vgozjr2TA2TDlv2XFYYeDMwDsZkNCAIVXpK64
         +oDYsktUK5frTtclNY9FSJ1GzVtnErgbCczUgkfZj2ezbEYpC9SSCbryG8V0U6Z+RMCT
         V/Sh4QwYaPWUmitqraXcObil2luRGzP59dWWVRAXE9KaEM+8h13s+ABRax2sv0gJPmWr
         5It+4yTxvcfVbp5wWx+nuTZJF2992MoAjzKtfUKYYDonaQqT8ptXUggCGacGj9Ms05g/
         SSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777922446; x=1778527246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uXcPAFVNZHSUg0SQZLPd+d1ffbri65Pno+fddvc4Ouw=;
        b=ABwiR74t802GJDsBXZ4bfxEP+XBiLxGvTx+tbeFDcojBZ9MSgTRreXZfyGUqrcVBZN
         yicl74bZB++p1f+KzclTsEzjU3L7fQnt7t7pjGcZZsw5ea+fZhhLfpr2G44/reGxAv5x
         EuiFhWPPWvrKe1NTxvd6nzXOvGbEDgEk6KTVeQU7c7cTLtIJhw6Q1pyHqDfz1RsEeJ7T
         q57cjB1JdwTT01unCjdyoaU0lSuJtLCIdtK3MvECxt2SK7UkkbnwUk6t7qo3BYfm0JVT
         TMeIgjtV06JfelXJfEuI0D7GHyXkrym6pe+rACdHx5k9PIzUeboG6DLdJs5dz6waCP+M
         NlDw==
X-Forwarded-Encrypted: i=1; AFNElJ8K7i3MKkU7cZdznKU6KHlDYaEGTJvlssYdQisCPnpa0bidjl2AQIXrqTc3pvGsUyyCIbWl4f0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2fxDKAIDn1w9lc8R0nYbELZB/AiQ00D56UfJdI7Oat9i2i1Nm
	SLQvhXvY9soV1bbo3J589lPnmOEbrZHgFll0gIlMtwcCREL8Wmg8Mhcaoq7a3EaoAWDN+jS8eIF
	CUZ7jicrAyo2kOGuVTBZbQLGdIQR+QGAfZvH8eiiS
X-Gm-Gg: AeBDievEk+4iLXbhQk/JNq3WrKggzBbZEODWxEaGenH7dU0y1wnsGuzJsBBKOKFJHSX
	nvpHnRwY5TQ0nzaSbI7P1VIpSLBPYKa7aEwE96hAseU8g0Yvt6zd0siLhD7ox5IDQCcO/AXDBzY
	P2C7nZZWuQowaX9uu67k4b0VSW0tUUGTwjl48sEb2++XB3ChCWwPViTKL0qBpGvuplWwv1X0K3v
	FztYd/jc1KKIzGRfGN6Az/Ij0HDf+TPXWu06G0TdZ74X8QeyWlp1kXxasuwb0dRGkijl1lNSbN7
	6hriz8MmuJHJXlrVv4JHa0x7kIXMpQ==
X-Received: by 2002:a05:6a00:3003:b0:82f:2b0:2809 with SMTP id
 d2e1a72fcca58-83921df9f9fmr210497b3a.1.1777922445898; Mon, 04 May 2026
 12:20:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504163842.1162001-1-edumazet@google.com>
In-Reply-To: <20260504163842.1162001-1-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 4 May 2026 15:20:34 -0400
X-Gm-Features: AVHnY4LLQjAxqHmtealu1jd5RjAv3XD0xRiohiCp4Tp_vnhEQORaSUPktfM8F8M
Message-ID: <CAM0EoMnp3tWgBCLw+98QpJg3j-MLniNJRH6hEW-XGrZAiV=_bg@mail.gmail.com>
Subject: Re: [PATCH v2 net] net/sched: sch_fq_codel: annotate data-races from fq_codel_dump_class_stats()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2F32D4C341A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284024-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,resnulli.us,vger.kernel.org,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu-com.20251104.gappssmtp.com:dkim,mojatatu.com:email]

On Mon, May 4, 2026 at 12:38=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> fq_codel_dump_class_stats() acquires qdisc spinlock only when requested
> to follow flow->head chain.
>
> As we did in sch_cake recently, add the missing READ_ONCE()/WRITE_ONCE()
> annotations.
>
> Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/=
class stats dump")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>


cheers,
jamal

> ---
> v2: added WRITE_ONCE(flow->cvars.count, flow->cvars.count + i);
>
>  net/sched/sch_fq_codel.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
>
> diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> index 0664b2f2d6f28041e5250a44fc92311116ae0cf1..24db54684e8a5997b075e0f40=
72f49779ae45abb 100644
> --- a/net/sched/sch_fq_codel.c
> +++ b/net/sched/sch_fq_codel.c
> @@ -117,7 +117,7 @@ static inline struct sk_buff *dequeue_head(struct fq_=
codel_flow *flow)
>  {
>         struct sk_buff *skb =3D flow->head;
>
> -       flow->head =3D skb->next;
> +       WRITE_ONCE(flow->head, skb->next);
>         skb_mark_not_on_list(skb);
>         return skb;
>  }
> @@ -127,7 +127,7 @@ static inline void flow_queue_add(struct fq_codel_flo=
w *flow,
>                                   struct sk_buff *skb)
>  {
>         if (flow->head =3D=3D NULL)
> -               flow->head =3D skb;
> +               WRITE_ONCE(flow->head, skb);
>         else
>                 flow->tail->next =3D skb;
>         flow->tail =3D skb;
> @@ -173,8 +173,8 @@ static unsigned int fq_codel_drop(struct Qdisc *sch, =
unsigned int max_packets,
>         } while (++i < max_packets && len < threshold);
>
>         /* Tell codel to increase its signal strength also */
> -       flow->cvars.count +=3D i;
> -       q->backlogs[idx] -=3D len;
> +       WRITE_ONCE(flow->cvars.count, flow->cvars.count + i);
> +       WRITE_ONCE(q->backlogs[idx], q->backlogs[idx] - len);
>         q->memory_usage -=3D mem;
>         sch->qstats.drops +=3D i;
>         sch->qstats.backlog -=3D len;
> @@ -204,13 +204,13 @@ static int fq_codel_enqueue(struct sk_buff *skb, st=
ruct Qdisc *sch,
>         codel_set_enqueue_time(skb);
>         flow =3D &q->flows[idx];
>         flow_queue_add(flow, skb);
> -       q->backlogs[idx] +=3D qdisc_pkt_len(skb);
> +       WRITE_ONCE(q->backlogs[idx], q->backlogs[idx] + qdisc_pkt_len(skb=
));
>         qdisc_qstats_backlog_inc(sch, skb);
>
>         if (list_empty(&flow->flowchain)) {
>                 list_add_tail(&flow->flowchain, &q->new_flows);
>                 q->new_flow_count++;
> -               flow->deficit =3D q->quantum;
> +               WRITE_ONCE(flow->deficit, q->quantum);
>         }
>         get_codel_cb(skb)->mem_usage =3D skb->truesize;
>         q->memory_usage +=3D get_codel_cb(skb)->mem_usage;
> @@ -263,7 +263,8 @@ static struct sk_buff *dequeue_func(struct codel_vars=
 *vars, void *ctx)
>         flow =3D container_of(vars, struct fq_codel_flow, cvars);
>         if (flow->head) {
>                 skb =3D dequeue_head(flow);
> -               q->backlogs[flow - q->flows] -=3D qdisc_pkt_len(skb);
> +               WRITE_ONCE(q->backlogs[flow - q->flows],
> +                          q->backlogs[flow - q->flows] - qdisc_pkt_len(s=
kb));
>                 q->memory_usage -=3D get_codel_cb(skb)->mem_usage;
>                 sch->q.qlen--;
>                 sch->qstats.backlog -=3D qdisc_pkt_len(skb);
> @@ -296,7 +297,7 @@ static struct sk_buff *fq_codel_dequeue(struct Qdisc =
*sch)
>         flow =3D list_first_entry(head, struct fq_codel_flow, flowchain);
>
>         if (flow->deficit <=3D 0) {
> -               flow->deficit +=3D q->quantum;
> +               WRITE_ONCE(flow->deficit, flow->deficit + q->quantum);
>                 list_move_tail(&flow->flowchain, &q->old_flows);
>                 goto begin;
>         }
> @@ -314,7 +315,7 @@ static struct sk_buff *fq_codel_dequeue(struct Qdisc =
*sch)
>                 goto begin;
>         }
>         qdisc_bstats_update(sch, skb);
> -       flow->deficit -=3D qdisc_pkt_len(skb);
> +       WRITE_ONCE(flow->deficit, flow->deficit - qdisc_pkt_len(skb));
>
>         if (q->cstats.drop_count) {
>                 qdisc_tree_reduce_backlog(sch, q->cstats.drop_count,
> @@ -328,7 +329,7 @@ static struct sk_buff *fq_codel_dequeue(struct Qdisc =
*sch)
>  static void fq_codel_flow_purge(struct fq_codel_flow *flow)
>  {
>         rtnl_kfree_skbs(flow->head, flow->tail);
> -       flow->head =3D NULL;
> +       WRITE_ONCE(flow->head, NULL);
>  }
>
>  static void fq_codel_reset(struct Qdisc *sch)
> @@ -656,21 +657,21 @@ static int fq_codel_dump_class_stats(struct Qdisc *=
sch, unsigned long cl,
>
>                 memset(&xstats, 0, sizeof(xstats));
>                 xstats.type =3D TCA_FQ_CODEL_XSTATS_CLASS;
> -               xstats.class_stats.deficit =3D flow->deficit;
> +               xstats.class_stats.deficit =3D READ_ONCE(flow->deficit);
>                 xstats.class_stats.ldelay =3D
> -                       codel_time_to_us(flow->cvars.ldelay);
> -               xstats.class_stats.count =3D flow->cvars.count;
> -               xstats.class_stats.lastcount =3D flow->cvars.lastcount;
> -               xstats.class_stats.dropping =3D flow->cvars.dropping;
> -               if (flow->cvars.dropping) {
> -                       codel_tdiff_t delta =3D flow->cvars.drop_next -
> +                       codel_time_to_us(READ_ONCE(flow->cvars.ldelay));
> +               xstats.class_stats.count =3D READ_ONCE(flow->cvars.count)=
;
> +               xstats.class_stats.lastcount =3D READ_ONCE(flow->cvars.la=
stcount);
> +               xstats.class_stats.dropping =3D READ_ONCE(flow->cvars.dro=
pping);
> +               if (xstats.class_stats.dropping) {
> +                       codel_tdiff_t delta =3D READ_ONCE(flow->cvars.dro=
p_next) -
>                                               codel_get_time();
>
>                         xstats.class_stats.drop_next =3D (delta >=3D 0) ?
>                                 codel_time_to_us(delta) :
>                                 -codel_time_to_us(-delta);
>                 }
> -               if (flow->head) {
> +               if (READ_ONCE(flow->head)) {
>                         sch_tree_lock(sch);
>                         skb =3D flow->head;
>                         while (skb) {
> @@ -679,7 +680,7 @@ static int fq_codel_dump_class_stats(struct Qdisc *sc=
h, unsigned long cl,
>                         }
>                         sch_tree_unlock(sch);
>                 }
> -               qs.backlog =3D q->backlogs[idx];
> +               qs.backlog =3D READ_ONCE(q->backlogs[idx]);
>                 qs.drops =3D 0;
>         }
>         if (gnet_stats_copy_queue(d, NULL, &qs, qs.qlen) < 0)
> --
> 2.54.0.545.g6539524ca2-goog
>

