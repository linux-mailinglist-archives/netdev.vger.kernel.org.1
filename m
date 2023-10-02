Return-Path: <netdev+bounces-37387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F29D7B52F3
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 14:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 02C6A282FE6
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 12:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0695E171DD;
	Mon,  2 Oct 2023 12:24:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A025515499
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 12:24:36 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A68AA6
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 05:24:35 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-537f07dfe8eso11106a12.1
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 05:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696249473; x=1696854273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nunt2Z+jtBKDhpYUW+oVw5BbTZ5UdBpmYlarDRlJ6KY=;
        b=RtWVyhEg+Bbcr1PAFlHGCAdjFiHH2dkzJlB6nSoD0IuR9ABv7J3peQuD+TFAQWT1qo
         6+tnwotBR8B8TolMPAYzmhAm/jIGi4ZxxViWpQd3CYmbMA2N1JHm38NY7eDISvLMdmlr
         NyZ9zXE80E8AYOMyfSdWrseBs1EmA+Af3ulXcoAkWKILBiaVcIw2rmlHgAcLQc/oLPF3
         IQhJ3y3p6ExUi8/bBHTsJthIAdbR0ZS8O9vXUgPoLWTPhLHQP6kgw+qWnrgVQi2YhJnC
         vXfjLEuS3PJ2WIJ9ElB++0CA1rlNr3jCfaLnHVDucNcjlBnWmWKZG48Lmmmc+b0bARHA
         1T/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696249473; x=1696854273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nunt2Z+jtBKDhpYUW+oVw5BbTZ5UdBpmYlarDRlJ6KY=;
        b=T87CBYRQtlOA8YpzqurHl8r9Ru751QCW5/1dlnd/D+wKZvBuHH9OJ+EmDFs9t188N8
         5zxO7mHQ3yOVZqDBwr84ATQmkchGvEqei3pmZrK0mEM8RqFN4IScroUUPaTnspmT6/Bw
         Qp3I/kj14+H1i/tzGf9ZhR6dW5Y7aZ4QSI0CM676DpKOgy+mNQabUWjhzMkH5qpuveSn
         ZYKY8B0iwqTvjD+5S50eTxIi9Xlq8ha1lvOnkrlu901XzkRVmlOmIKtCoP1z4CpGB/Ix
         SmJV2wlzX1V2KHf+dsszydPp8AoOBtWrh+gOPyymLX/XuP//10Zu6C3PNRoKu4EOZlnG
         6VPA==
X-Gm-Message-State: AOJu0YxrpXvivv5fyUk0rtQAc+0XKj4NWhkIeqkUCIKpdbWri7rQcCGq
	VpfbXfbiIZXWjbJb0+2b2SpECYdKZ0wmHplDTRU5eQ==
X-Google-Smtp-Source: AGHT+IF98hthGfUbeVRcffQPzU2gqECn3Iw0sB8ZfzypOxRTdyhoz77apel3bscDPGeoAXNI/AzDyNHtZI2hXyDq5tI=
X-Received: by 2002:a50:ba81:0:b0:530:4a6e:25a9 with SMTP id
 x1-20020a50ba81000000b005304a6e25a9mr106345ede.6.1696249473275; Mon, 02 Oct
 2023 05:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231001145102.733450-1-edumazet@google.com> <20231001145102.733450-5-edumazet@google.com>
 <87bkdhgsa4.fsf@toke.dk>
In-Reply-To: <87bkdhgsa4.fsf@toke.dk>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 2 Oct 2023 14:24:22 +0200
Message-ID: <CANn89iKM+bhWufs-A1LcOu6LJnbJ3tG3Pkto3KivDq6+JwaxCQ@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] net_sched: sch_fq: add TCA_FQ_WEIGHTS attribute
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 1:47=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> Eric Dumazet <edumazet@google.com> writes:
>
> > This attribute can be used to tune the per band weight
> > and report them in "tc qdisc show" output:
> >
> > qdisc fq 802f: parent 1:9 limit 100000p flow_limit 500p buckets 1024 or=
phan_mask 1023
> >  quantum 8364b initial_quantum 41820b low_rate_threshold 550Kbit
> >  refill_delay 40ms timer_slack 10us horizon 10s horizon_drop
> >  bands 3 priomap 1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1 weights 589824 196608 =
65536
> >  Sent 236460814 bytes 792991 pkt (dropped 0, overlimits 0 requeues 0)
> >  rate 25816bit 10pps backlog 0b 0p requeues 0
> >   flows 4 (inactive 4 throttled 0)
> >   gc 0 throttled 19 latency 17.6us fastpath 773882
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  include/uapi/linux/pkt_sched.h |  3 +++
> >  net/sched/sch_fq.c             | 32 ++++++++++++++++++++++++++++++++
> >  2 files changed, 35 insertions(+)
> >
> > diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sc=
hed.h
> > index ec5ab44d41a2493130670870dc9e68c71187740f..f762a10bfb78ed896d8a5b9=
36045a956d97b3831 100644
> > --- a/include/uapi/linux/pkt_sched.h
> > +++ b/include/uapi/linux/pkt_sched.h
> > @@ -943,12 +943,15 @@ enum {
> >
> >       TCA_FQ_PRIOMAP,         /* prio2band */
> >
> > +     TCA_FQ_WEIGHTS,         /* Weights for each band */
> > +
> >       __TCA_FQ_MAX
> >  };
> >
> >  #define TCA_FQ_MAX   (__TCA_FQ_MAX - 1)
> >
> >  #define FQ_BANDS 3
> > +#define FQ_MIN_WEIGHT 16384
> >
> >  struct tc_fq_qd_stats {
> >       __u64   gc_flows;
> > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > index 1bae145750a66f769bd30f1db09203f725801249..1a411fe36c79a86635f319c=
230a045d653571700 100644
> > --- a/net/sched/sch_fq.c
> > +++ b/net/sched/sch_fq.c
> > @@ -919,6 +919,10 @@ static const struct nla_policy fq_policy[TCA_FQ_MA=
X + 1] =3D {
> >                       .type =3D NLA_BINARY,
> >                       .len =3D sizeof(struct tc_prio_qopt),
> >               },
> > +     [TCA_FQ_WEIGHTS]                =3D {
> > +                     .type =3D NLA_BINARY,
> > +                     .len =3D FQ_BANDS * sizeof(s32),
> > +             },
> >  };
> >
> >  /* compress a u8 array with all elems <=3D 3 to an array of 2-bit fiel=
ds */
> > @@ -941,6 +945,24 @@ static void fq_prio2band_decompress_crumb(const u8=
 *in, u8 *out)
> >               out[i] =3D fq_prio2band(in, i);
> >  }
> >
> > +static int fq_load_weights(struct fq_sched_data *q,
> > +                        const struct nlattr *attr,
> > +                        struct netlink_ext_ack *extack)
> > +{
> > +     s32 *weights =3D nla_data(attr);
> > +     int i;
> > +
> > +     for (i =3D 0; i < FQ_BANDS; i++) {
> > +             if (weights[i] < FQ_MIN_WEIGHT) {
> > +                     NL_SET_ERR_MSG_MOD(extack, "Incorrect weight");
>
> As in the previous patch, can we be a bit more specific here? "Weight %d
> less that minimum allowed %d"?

I guess I can do this. Again this is to prevent syzbot from doing bad thing=
s.

