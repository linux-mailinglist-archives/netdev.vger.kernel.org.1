Return-Path: <netdev+bounces-35365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED3A7A90D3
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 04:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF19FB20AC3
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 02:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E6C15AE;
	Thu, 21 Sep 2023 02:16:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A2215A4
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 02:16:36 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ADFC2
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 19:16:35 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-414ba610766so234171cf.0
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 19:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695262594; x=1695867394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIvqJu/z9QqIXcRG4JhWVP2LEaxrkdlGMc+E5SooqGU=;
        b=3H4BZHBk/M0He+u7RbTdS8Y7X9ZyScOaSf4ogwkKXOf1P1e/a2qMv/ohSVqXfr9i4P
         7dh4UiEe0SDF0ApRjW2AiPZVUVlZ7FgGvOs3ChQk9F6ExzdhJdj4zT0nnyQCRvT0Nr9s
         Fx5uawbIwQWubVdjdI/k4M2oMATZeMmkok7W/fBGNFgDvaUJ4O/aVHVAQsMUtsw23lmo
         d1DfCAnM70LycbSZzGhZzzZYqNHmFYjE/wlKsIpUTxzmM8VfBZLseP97+iNURyPALfBk
         ZPLPeTZnam2WfD7anOQD1hmddz3EXpqaObcc761ruUXFS+n8f18qJpY0Hadn3UJRzzen
         42jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695262594; x=1695867394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIvqJu/z9QqIXcRG4JhWVP2LEaxrkdlGMc+E5SooqGU=;
        b=Pfxk1gBywWL+zySwJ/PS+qfcqMSSfx+gK+2+knE/bRQU3z3VDjQJIZ0unN9UmBrc25
         mBYALFKJBFD/JclLDvXgwJ0IQMwld8o9IsnHJllVAo/vv0Ab792mwo2c4A4Mk/CYAxnx
         Gd1jK5ccUvm5OrvZKu0GW5wQMZZvEavxNfnRm8Qd6ybV6kTzvVmHhmACpqlFI38FwJE3
         ZY838Cx3Bt9QedYzsxKrylPkpHz1AFh89lL/44qnQbNabdz1zBx1yrayMdDQoE35II2l
         yD5t7rQT/+Tr0LC3wsttZ0ugSWKpzavg1RfzaC+ie4ccBZO+urs947Y4GTBJFW5eBigu
         6lKA==
X-Gm-Message-State: AOJu0YxjTG2owrqFpwIMsQWjx0yf9PUM2IfwfB1Hdo/lE39zRp3mGzpj
	h9VphKVRqUGEcfKLvTjr/KfT/aeoW8UP1ESJr7IBIg==
X-Google-Smtp-Source: AGHT+IFr+sWmt4JaeZ616ByTbK/1euO2DJqqgoVj+RiGLetgt3nR0hPgHRBzLAGaP2bOfALhSeqLK5r5LNilHNp44Rc=
X-Received: by 2002:ac8:7f48:0:b0:412:16f:c44f with SMTP id
 g8-20020ac87f48000000b00412016fc44fmr137091qtk.6.1695262593991; Wed, 20 Sep
 2023 19:16:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920172943.4135513-1-edumazet@google.com> <20230920172943.4135513-4-edumazet@google.com>
 <89a3cbd7-fd82-d925-b916-e323033ffdbe@kernel.org>
In-Reply-To: <89a3cbd7-fd82-d925-b916-e323033ffdbe@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Sep 2023 04:16:22 +0200
Message-ID: <CANn89i+-3saYRN9YUuujYnW8PvmkyUTHmRDX3bUXdbYoGfo=iA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] tcp: derive delack_max from rto_min
To: David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, netdev@vger.kernel.org, 
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

On Wed, Sep 20, 2023 at 11:57=E2=80=AFPM David Ahern <dsahern@kernel.org> w=
rote:
>
> On 9/20/23 11:29 AM, Eric Dumazet wrote:
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index 1fc1f879cfd6c28cd655bb8f02eff6624eec2ffc..2d1e4b5ac1ca41ff3db8dc5=
8458d4e922a2c4999 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -3977,6 +3977,20 @@ int tcp_connect(struct sock *sk)
> >  }
> >  EXPORT_SYMBOL(tcp_connect);
> >
> > +u32 tcp_delack_max(const struct sock *sk)
> > +{
> > +     const struct dst_entry *dst =3D __sk_dst_get(sk);
> > +     u32 delack_max =3D inet_csk(sk)->icsk_delack_max;
> > +
> > +     if (dst && dst_metric_locked(dst, RTAX_RTO_MIN)) {
> > +             u32 rto_min =3D dst_metric_rtt(dst, RTAX_RTO_MIN);
> > +             u32 delack_from_rto_min =3D max_t(int, 1, rto_min - 1);
>
> `u32` type with max_t type set as `int`

That is because we allow "rto_min 0" in ip route ...

rto_min - 1 is then 0xFFFFFFFF

We could argue that "rto_min 0" would be illegal, but this is orthogonal.


>
> > +
> > +             delack_max =3D min_t(u32, delack_max, delack_from_rto_min=
);
> > +     }
> > +     return delack_max;
> > +}
> > +
> >  /* Send out a delayed ack, the caller does the policy checking
> >   * to see if we should even be here.  See tcp_input.c:tcp_ack_snd_chec=
k()
> >   * for details.
> > @@ -4012,7 +4026,7 @@ void tcp_send_delayed_ack(struct sock *sk)
> >               ato =3D min(ato, max_ato);
> >       }
> >
> > -     ato =3D min_t(u32, ato, inet_csk(sk)->icsk_delack_max);
> > +     ato =3D min_t(u32, ato, tcp_delack_max(sk));
>
> and then here ato is an `int`.


> >
> >       /* Stay within the limit we were given */
> >       timeout =3D jiffies + ato;
>

