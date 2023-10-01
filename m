Return-Path: <netdev+bounces-37310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C487B4A21
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 00:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 262F128178F
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 22:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A58F199A0;
	Sun,  1 Oct 2023 22:15:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698AFD299
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 22:15:55 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBA8CE
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 15:15:52 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-502f29ed596so4213e87.0
        for <netdev@vger.kernel.org>; Sun, 01 Oct 2023 15:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696198550; x=1696803350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y//VAAlajDNYaWp5sQBX67688mnshXzUVHZCyy2Sc94=;
        b=yjA1VKI7WnT++hL+EoGYkK25I/CaPv4hvV73bAsDLTw6mi+bwxtQb2w1kwB0alk9Ky
         al7AjYzrg3feR3MVnFISf69L33iyDm+e3bz9sTTLSvm5pmwG/2ietkDGb092G+RajvKr
         shKIkTjniS2w8b77nAsHXjYPOLV2pitueqKbe6OVVDxyfzsOtwYiJztZIkG198G5DPqk
         eFVj3xEGRbxaa6dLqxyT9LSq6G5LAGjocpJQQyjr1jSjl9q1ql3OesGSHIQuKVSWERLT
         FlbtouG46vDmryZmoigL1E8y4D41Rp/5dAc/OCqdw2XuJtkBgdD9TklWPcWZZHqY+pIm
         LD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696198550; x=1696803350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y//VAAlajDNYaWp5sQBX67688mnshXzUVHZCyy2Sc94=;
        b=GchU3VGt7AEKeGSXAj5uFx+gRqeOEWaCYjpAGI4aX47JpAbm+H3D1FCol1CqB6JlQN
         EQXQ6gm5cHVvNYGOJhLFpNLiqEamgJEWfIoyjEG5nQj384HaAhfPE9o/IH4VQPm8VRkv
         qXBwqqMEo46VKPxzFCp4tAzYPgpiIhUGziD631+q5u936fnCuhy+fp0K61N12XI0r7cs
         zlipCWZ2UPpKo7uiWPAd8V50Yiwq2cwD7ZL5gKNgJY9giKmKyrFQKrM2DnnjO96juOOH
         MvQ8sDGKiBtxpPB0+JSrOBaqRT6CSrreqrKu2NBC5ewp2dECzr2NUspF9lzezg1G1D1O
         ak0g==
X-Gm-Message-State: AOJu0YxRooZIIw/RjiaS4bUbTIyc5Ix1H0kSaZaKaJjmFYh+WQnw7piT
	hLGaIjC7F6FMZIYShy/D1wsz2yrXJThaVA/eUHTxMQ==
X-Google-Smtp-Source: AGHT+IHImjF0Fp8799NwrJIh2sovmv6mD4FbmbmGrVACdEFVZW350EfnenPAEYs7ycTqrKi4MtSPLIN0NvB7VOFFO5I=
X-Received: by 2002:a19:f50b:0:b0:502:a55e:fec0 with SMTP id
 j11-20020a19f50b000000b00502a55efec0mr45132lfb.6.1696198550249; Sun, 01 Oct
 2023 15:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231001145102.733450-1-edumazet@google.com> <20231001145102.733450-4-edumazet@google.com>
In-Reply-To: <20231001145102.733450-4-edumazet@google.com>
From: Soheil Hassas Yeganeh <soheil@google.com>
Date: Sun, 1 Oct 2023 18:15:13 -0400
Message-ID: <CACSApvbO75xEE1UozJq1EHoc3_itQc+EjQ5u7tVd449La7iJLw@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] net_sched: sch_fq: add 3 bands and WRR scheduling
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 1, 2023 at 10:51=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Before Google adopted FQ for its production servers,
> we had to ensure AF4 packets would get a higher share
> than BE1 ones.
>
> As discussed this week in Netconf 2023 in Paris, it is time
> to upstream this for public use.
>
> After this patch FQ can replace pfifo_fast, with the following
> differences :
>
> - FQ uses WRR instead of strict prio, to avoid starvation of
>   low priority packets.
>
> - We make sure each band/prio tracks its own usage against sch->limit.
>   This was done to make sure flood of low priority packets would not
>   prevent AF4 packets to be queued. Contributed by Willem.
>
> - priomap can be changed, if needed (default value are the ones
>   coming from pfifo_fast).
>
> In this patch, we set default band weights so that :
>
> - high prio (band=3D0) packets get 90% of the bandwidth
>   if they compete with low prio (band=3D2) packets.
>
> - high prio packets get 75% of the bandwidth
>   if they compete with medium prio (band=3D1) packets.
>
> Following patch in this series adds the possibility to tune
> the per-band weights.
>
> As we added many fields in 'struct fq_sched_data', we had
> to make sure to have the first cache line read-mostly, and
> avoid wasting precious cache lines.
>
> More optimizations are possible but will be sent separately.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Thank you for upstreaming this feature!

Acked-by: Soheil Hassas Yeganeh <soheil@google.com>

> ---
>  include/uapi/linux/pkt_sched.h |  11 +-
>  net/sched/sch_fq.c             | 203 ++++++++++++++++++++++++++-------
>  2 files changed, 170 insertions(+), 44 deletions(-)
>
> diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sche=
d.h
> index 579f641846b87da05e5d4b09c1072c90220ca601..ec5ab44d41a2493130670870d=
c9e68c71187740f 100644
> --- a/include/uapi/linux/pkt_sched.h
> +++ b/include/uapi/linux/pkt_sched.h
> @@ -941,15 +941,19 @@ enum {
>
>         TCA_FQ_HORIZON_DROP,    /* drop packets beyond horizon, or cap th=
eir EDT */
>
> +       TCA_FQ_PRIOMAP,         /* prio2band */
> +
>         __TCA_FQ_MAX
>  };
>
>  #define TCA_FQ_MAX     (__TCA_FQ_MAX - 1)
>
> +#define FQ_BANDS 3
> +
>  struct tc_fq_qd_stats {
>         __u64   gc_flows;
> -       __u64   highprio_packets;
> -       __u64   tcp_retrans;
> +       __u64   highprio_packets;       /* obsolete */
> +       __u64   tcp_retrans;            /* obsolete */
>         __u64   throttled;
>         __u64   flows_plimit;
>         __u64   pkts_too_long;
> @@ -963,6 +967,9 @@ struct tc_fq_qd_stats {
>         __u64   horizon_drops;
>         __u64   horizon_caps;
>         __u64   fastpath_packets;
> +       __u64   band_drops[FQ_BANDS];
> +       __u32   band_pkt_count[FQ_BANDS];
> +       __u32   pad;
>  };
>
>  /* Heavy-Hitter Filter */
> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index 91d71a538b71f9208f2507fd11443f784dffa966..1bae145750a66f769bd30f1db=
09203f725801249 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c
> @@ -51,7 +51,8 @@
>  #include <net/tcp.h>
>
>  struct fq_skb_cb {
> -       u64             time_to_send;
> +       u64     time_to_send;
> +       u8      band;
>  };
>
>  static inline struct fq_skb_cb *fq_skb_cb(struct sk_buff *skb)
> @@ -84,32 +85,28 @@ struct fq_flow {
>         u32             socket_hash;    /* sk_hash */
>         int             qlen;           /* number of packets in flow queu=
e */
>
> -/* Second cache line, used in fq_dequeue() */
> +/* Second cache line */
>         int             credit;
> -       /* 32bit hole on 64bit arches */
> -
> +       int             band;
>         struct fq_flow *next;           /* next pointer in RR lists */
>
>         struct rb_node  rate_node;      /* anchor in q->delayed tree */
>         u64             time_next_packet;
> -} ____cacheline_aligned_in_smp;
> +};
>
>  struct fq_flow_head {
>         struct fq_flow *first;
>         struct fq_flow *last;
>  };
>
> -struct fq_sched_data {
> +struct fq_perband_flows {
>         struct fq_flow_head new_flows;
> -
>         struct fq_flow_head old_flows;
> +       int                 credit;
> +       int                 quantum; /* based on band nr : 576KB, 192KB, =
64KB */
> +};
>
> -       struct rb_root  delayed;        /* for rate limited flows */
> -       u64             time_next_delayed_flow;
> -       unsigned long   unthrottle_latency_ns;
> -
> -       struct fq_flow  internal;       /* for non classified or high pri=
o packets */
> -
> +struct fq_sched_data {
>  /* Read mostly cache line */
>
>         u32             quantum;
> @@ -125,10 +122,21 @@ struct fq_sched_data {
>         u8              rate_enable;
>         u8              fq_trees_log;
>         u8              horizon_drop;
> +       u8              prio2band[(TC_PRIO_MAX + 1) >> 2];
>         u32             timer_slack; /* hrtimer slack in ns */
>
>  /* Read/Write fields. */
>
> +       unsigned int band_nr; /* band being serviced in fq_dequeue() */
> +
> +       struct fq_perband_flows band_flows[FQ_BANDS];
> +
> +       struct fq_flow  internal;       /* fastpath queue. */
> +       struct rb_root  delayed;        /* for rate limited flows */
> +       u64             time_next_delayed_flow;
> +       unsigned long   unthrottle_latency_ns;
> +
> +       u32             band_pkt_count[FQ_BANDS];
>         u32             flows;
>         u32             inactive_flows; /* Flows with no packet to send. =
*/
>         u32             throttled_flows;
> @@ -139,7 +147,7 @@ struct fq_sched_data {
>
>  /* Seldom used fields. */
>
> -       u64             stat_internal_packets; /* aka highprio */
> +       u64             stat_band_drops[FQ_BANDS];
>         u64             stat_ce_mark;
>         u64             stat_horizon_drops;
>         u64             stat_horizon_caps;
> @@ -148,6 +156,12 @@ struct fq_sched_data {
>         u64             stat_allocation_errors;
>  };
>
> +/* return the i-th 2-bit value ("crumb") */
> +static u8 fq_prio2band(const u8 *prio2band, unsigned int prio)
> +{
> +       return (prio2band[prio / 4] >> (2 * (prio & 0x3))) & 0x3;
> +}
> +
>  /*
>   * f->tail and f->age share the same location.
>   * We can use the low order bit to differentiate if this location points
> @@ -172,8 +186,19 @@ static bool fq_flow_is_throttled(const struct fq_flo=
w *f)
>         return f->next =3D=3D &throttled;
>  }
>
> -static void fq_flow_add_tail(struct fq_flow_head *head, struct fq_flow *=
flow)
> +enum new_flow {
> +       NEW_FLOW,
> +       OLD_FLOW
> +};
> +
> +static void fq_flow_add_tail(struct fq_sched_data *q, struct fq_flow *fl=
ow,
> +                            enum new_flow list_sel)
>  {
> +       struct fq_perband_flows *pband =3D &q->band_flows[flow->band];
> +       struct fq_flow_head *head =3D (list_sel =3D=3D NEW_FLOW) ?
> +                                       &pband->new_flows :
> +                                       &pband->old_flows;
> +
>         if (head->first)
>                 head->last->next =3D flow;
>         else
> @@ -186,7 +211,7 @@ static void fq_flow_unset_throttled(struct fq_sched_d=
ata *q, struct fq_flow *f)
>  {
>         rb_erase(&f->rate_node, &q->delayed);
>         q->throttled_flows--;
> -       fq_flow_add_tail(&q->old_flows, f);
> +       fq_flow_add_tail(q, f, OLD_FLOW);
>  }
>
>  static void fq_flow_set_throttled(struct fq_sched_data *q, struct fq_flo=
w *f)
> @@ -326,11 +351,6 @@ static struct fq_flow *fq_classify(struct Qdisc *sch=
, struct sk_buff *skb,
>         struct rb_root *root;
>         struct fq_flow *f;
>
> -       /* warning: no starvation prevention... */
> -       if (unlikely((skb->priority & TC_PRIO_MAX) =3D=3D TC_PRIO_CONTROL=
)) {
> -               q->stat_internal_packets++; /* highprio packet */
> -               return &q->internal;
> -       }
>         /* SYNACK messages are attached to a TCP_NEW_SYN_RECV request soc=
ket
>          * or a listener (SYNCOOKIE mode)
>          * 1) request sockets are not full blown,
> @@ -509,9 +529,13 @@ static int fq_enqueue(struct sk_buff *skb, struct Qd=
isc *sch,
>         struct fq_sched_data *q =3D qdisc_priv(sch);
>         struct fq_flow *f;
>         u64 now;
> +       u8 band;
>
> -       if (unlikely(sch->q.qlen >=3D sch->limit))
> +       band =3D fq_prio2band(q->prio2band, skb->priority & TC_PRIO_MAX);
> +       if (unlikely(q->band_pkt_count[band] >=3D sch->limit)) {
> +               q->stat_band_drops[band]++;
>                 return qdisc_drop(skb, sch, to_free);
> +       }
>
>         now =3D ktime_get_ns();
>         if (!skb->tstamp) {
> @@ -538,11 +562,14 @@ static int fq_enqueue(struct sk_buff *skb, struct Q=
disc *sch,
>                 }
>
>                 if (fq_flow_is_detached(f)) {
> -                       fq_flow_add_tail(&q->new_flows, f);
> +                       fq_flow_add_tail(q, f, NEW_FLOW);
>                         if (time_after(jiffies, f->age + q->flow_refill_d=
elay))
>                                 f->credit =3D max_t(u32, f->credit, q->qu=
antum);
>                 }
>
> +               f->band =3D band;
> +               q->band_pkt_count[band]++;
> +               fq_skb_cb(skb)->band =3D band;
>                 if (f->qlen =3D=3D 0)
>                         q->inactive_flows--;
>         }
> @@ -584,13 +611,26 @@ static void fq_check_throttled(struct fq_sched_data=
 *q, u64 now)
>         }
>  }
>
> +static struct fq_flow_head *fq_pband_head_select(struct fq_perband_flows=
 *pband)
> +{
> +       if (pband->credit <=3D 0)
> +               return NULL;
> +
> +       if (pband->new_flows.first)
> +               return &pband->new_flows;
> +
> +       return pband->old_flows.first ? &pband->old_flows : NULL;
> +}
> +
>  static struct sk_buff *fq_dequeue(struct Qdisc *sch)
>  {
>         struct fq_sched_data *q =3D qdisc_priv(sch);
> +       struct fq_perband_flows *pband;
>         struct fq_flow_head *head;
>         struct sk_buff *skb;
>         struct fq_flow *f;
>         unsigned long rate;
> +       int retry;
>         u32 plen;
>         u64 now;
>
> @@ -606,24 +646,31 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch=
)
>
>         now =3D ktime_get_ns();
>         fq_check_throttled(q, now);
> +       retry =3D 0;
> +       pband =3D &q->band_flows[q->band_nr];
>  begin:
> -       head =3D &q->new_flows;
> -       if (!head->first) {
> -               head =3D &q->old_flows;
> -               if (!head->first) {
> -                       if (q->time_next_delayed_flow !=3D ~0ULL)
> -                               qdisc_watchdog_schedule_range_ns(&q->watc=
hdog,
> +       head =3D fq_pband_head_select(pband);
> +       if (!head) {
> +               while (++retry < FQ_BANDS) {
> +                       if (++q->band_nr =3D=3D FQ_BANDS)
> +                               q->band_nr =3D 0;
> +                       pband =3D &q->band_flows[q->band_nr];
> +                       pband->credit =3D min(pband->credit + pband->quan=
tum,
> +                                           pband->quantum);
> +                       goto begin;
> +               }
> +               if (q->time_next_delayed_flow !=3D ~0ULL)
> +                       qdisc_watchdog_schedule_range_ns(&q->watchdog,
>                                                         q->time_next_dela=
yed_flow,
>                                                         q->timer_slack);
> -                       return NULL;
> -               }
> +               return NULL;
>         }
>         f =3D head->first;
> -
> +       retry =3D 0;
>         if (f->credit <=3D 0) {
>                 f->credit +=3D q->quantum;
>                 head->first =3D f->next;
> -               fq_flow_add_tail(&q->old_flows, f);
> +               fq_flow_add_tail(q, f, OLD_FLOW);
>                 goto begin;
>         }
>
> @@ -645,12 +692,13 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch=
)
>                 }
>                 if (--f->qlen =3D=3D 0)
>                         q->inactive_flows++;
> +               q->band_pkt_count[fq_skb_cb(skb)->band]--;
>                 fq_dequeue_skb(sch, f, skb);
>         } else {
>                 head->first =3D f->next;
>                 /* force a pass through old_flows to prevent starvation *=
/
> -               if ((head =3D=3D &q->new_flows) && q->old_flows.first) {
> -                       fq_flow_add_tail(&q->old_flows, f);
> +               if (head =3D=3D &pband->new_flows) {
> +                       fq_flow_add_tail(q, f, OLD_FLOW);
>                 } else {
>                         fq_flow_set_detached(f);
>                 }
> @@ -658,6 +706,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
>         }
>         plen =3D qdisc_pkt_len(skb);
>         f->credit -=3D plen;
> +       pband->credit -=3D plen;
>
>         if (!q->rate_enable)
>                 goto out;
> @@ -749,8 +798,10 @@ static void fq_reset(struct Qdisc *sch)
>                         kmem_cache_free(fq_flow_cachep, f);
>                 }
>         }
> -       q->new_flows.first      =3D NULL;
> -       q->old_flows.first      =3D NULL;
> +       for (idx =3D 0; idx < FQ_BANDS; idx++) {
> +               q->band_flows[idx].new_flows.first =3D NULL;
> +               q->band_flows[idx].old_flows.first =3D NULL;
> +       }
>         q->delayed              =3D RB_ROOT;
>         q->flows                =3D 0;
>         q->inactive_flows       =3D 0;
> @@ -864,8 +915,53 @@ static const struct nla_policy fq_policy[TCA_FQ_MAX =
+ 1] =3D {
>         [TCA_FQ_TIMER_SLACK]            =3D { .type =3D NLA_U32 },
>         [TCA_FQ_HORIZON]                =3D { .type =3D NLA_U32 },
>         [TCA_FQ_HORIZON_DROP]           =3D { .type =3D NLA_U8 },
> +       [TCA_FQ_PRIOMAP]                =3D {
> +                       .type =3D NLA_BINARY,
> +                       .len =3D sizeof(struct tc_prio_qopt),
> +               },
>  };
>
> +/* compress a u8 array with all elems <=3D 3 to an array of 2-bit fields=
 */
> +static void fq_prio2band_compress_crumb(const u8 *in, u8 *out)
> +{
> +       const int num_elems =3D TC_PRIO_MAX + 1;
> +       int i;
> +
> +       memset(out, 0, num_elems / 4);
> +       for (i =3D 0; i < num_elems; i++)
> +               out[i / 4] |=3D in[i] << (2 * (i & 0x3));
> +}
> +
> +static void fq_prio2band_decompress_crumb(const u8 *in, u8 *out)
> +{
> +       const int num_elems =3D TC_PRIO_MAX + 1;
> +       int i;
> +
> +       for (i =3D 0; i < num_elems; i++)
> +               out[i] =3D fq_prio2band(in, i);
> +}
> +
> +static int fq_load_priomap(struct fq_sched_data *q,
> +                          const struct nlattr *attr,
> +                          struct netlink_ext_ack *extack)
> +{
> +       const struct tc_prio_qopt *map =3D nla_data(attr);
> +       int i;
> +
> +       if (map->bands !=3D FQ_BANDS) {
> +               NL_SET_ERR_MSG_MOD(extack, "FQ only supports 3 bands");
> +               return -EINVAL;
> +       }
> +       for (i =3D 0; i < TC_PRIO_MAX + 1; i++) {
> +               if (map->priomap[i] >=3D FQ_BANDS) {
> +                       NL_SET_ERR_MSG_MOD(extack, "Incorrect field in FQ=
 priomap");
> +                       return -EINVAL;
> +               }
> +       }
> +       fq_prio2band_compress_crumb(map->priomap, q->prio2band);
> +       return 0;
> +}
> +
>  static int fq_change(struct Qdisc *sch, struct nlattr *opt,
>                      struct netlink_ext_ack *extack)
>  {
> @@ -940,6 +1036,9 @@ static int fq_change(struct Qdisc *sch, struct nlatt=
r *opt,
>                 q->flow_refill_delay =3D usecs_to_jiffies(usecs_delay);
>         }
>
> +       if (!err && tb[TCA_FQ_PRIOMAP])
> +               err =3D fq_load_priomap(q, tb[TCA_FQ_PRIOMAP], extack);
> +
>         if (tb[TCA_FQ_ORPHAN_MASK])
>                 q->orphan_mask =3D nla_get_u32(tb[TCA_FQ_ORPHAN_MASK]);
>
> @@ -991,7 +1090,7 @@ static int fq_init(struct Qdisc *sch, struct nlattr =
*opt,
>                    struct netlink_ext_ack *extack)
>  {
>         struct fq_sched_data *q =3D qdisc_priv(sch);
> -       int err;
> +       int i, err;
>
>         sch->limit              =3D 10000;
>         q->flow_plimit          =3D 100;
> @@ -1001,8 +1100,13 @@ static int fq_init(struct Qdisc *sch, struct nlatt=
r *opt,
>         q->flow_max_rate        =3D ~0UL;
>         q->time_next_delayed_flow =3D ~0ULL;
>         q->rate_enable          =3D 1;
> -       q->new_flows.first      =3D NULL;
> -       q->old_flows.first      =3D NULL;
> +       for (i =3D 0; i < FQ_BANDS; i++) {
> +               q->band_flows[i].new_flows.first =3D NULL;
> +               q->band_flows[i].old_flows.first =3D NULL;
> +       }
> +       q->band_flows[0].quantum =3D 9 << 16;
> +       q->band_flows[1].quantum =3D 3 << 16;
> +       q->band_flows[2].quantum =3D 1 << 16;
>         q->delayed              =3D RB_ROOT;
>         q->fq_root              =3D NULL;
>         q->fq_trees_log         =3D ilog2(1024);
> @@ -1017,6 +1121,7 @@ static int fq_init(struct Qdisc *sch, struct nlattr=
 *opt,
>         /* Default ce_threshold of 4294 seconds */
>         q->ce_threshold         =3D (u64)NSEC_PER_USEC * ~0U;
>
> +       fq_prio2band_compress_crumb(sch_default_prio2band, q->prio2band);
>         qdisc_watchdog_init_clockid(&q->watchdog, sch, CLOCK_MONOTONIC);
>
>         if (opt)
> @@ -1031,6 +1136,9 @@ static int fq_dump(struct Qdisc *sch, struct sk_buf=
f *skb)
>  {
>         struct fq_sched_data *q =3D qdisc_priv(sch);
>         u64 ce_threshold =3D q->ce_threshold;
> +       struct tc_prio_qopt prio =3D {
> +               .bands =3D FQ_BANDS,
> +       };
>         u64 horizon =3D q->horizon;
>         struct nlattr *opts;
>
> @@ -1062,6 +1170,10 @@ static int fq_dump(struct Qdisc *sch, struct sk_bu=
ff *skb)
>             nla_put_u8(skb, TCA_FQ_HORIZON_DROP, q->horizon_drop))
>                 goto nla_put_failure;
>
> +       fq_prio2band_decompress_crumb(q->prio2band, prio.priomap);
> +       if (nla_put(skb, TCA_FQ_PRIOMAP, sizeof(prio), &prio))
> +               goto nla_put_failure;
> +
>         return nla_nest_end(skb, opts);
>
>  nla_put_failure:
> @@ -1072,11 +1184,14 @@ static int fq_dump_stats(struct Qdisc *sch, struc=
t gnet_dump *d)
>  {
>         struct fq_sched_data *q =3D qdisc_priv(sch);
>         struct tc_fq_qd_stats st;
> +       int i;
> +
> +       st.pad =3D 0;
>
>         sch_tree_lock(sch);
>
>         st.gc_flows               =3D q->stat_gc_flows;
> -       st.highprio_packets       =3D q->stat_internal_packets;
> +       st.highprio_packets       =3D 0;
>         st.fastpath_packets       =3D q->internal.stat_fastpath_packets;
>         st.tcp_retrans            =3D 0;
>         st.throttled              =3D q->stat_throttled;
> @@ -1093,6 +1208,10 @@ static int fq_dump_stats(struct Qdisc *sch, struct=
 gnet_dump *d)
>         st.ce_mark                =3D q->stat_ce_mark;
>         st.horizon_drops          =3D q->stat_horizon_drops;
>         st.horizon_caps           =3D q->stat_horizon_caps;
> +       for (i =3D 0; i < FQ_BANDS; i++) {
> +               st.band_drops[i]  =3D q->stat_band_drops[i];
> +               st.band_pkt_count[i] =3D q->band_pkt_count[i];
> +       }
>         sch_tree_unlock(sch);
>
>         return gnet_stats_copy_app(d, &st, sizeof(st));
> @@ -1120,7 +1239,7 @@ static int __init fq_module_init(void)
>
>         fq_flow_cachep =3D kmem_cache_create("fq_flow_cache",
>                                            sizeof(struct fq_flow),
> -                                          0, 0, NULL);
> +                                          0, SLAB_HWCACHE_ALIGN, NULL);
>         if (!fq_flow_cachep)
>                 return -ENOMEM;
>
> --
> 2.42.0.582.g8ccd20d70d-goog
>

