Return-Path: <netdev+bounces-26609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3196F778584
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 04:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9015E281E40
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 02:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E99A3D;
	Fri, 11 Aug 2023 02:36:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88C536F
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 02:36:07 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE8F2D62
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 19:36:05 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1a1fa977667so1333542fac.1
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 19:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691721364; x=1692326164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMwz3lieIrdAaFAF5vnTmJpy6ZcX/W7OfrkF3NkDHkE=;
        b=nYMJncOJVKeHjL+DOcE0+JqG6evYmhcoGs0gWnmV/V6pOOvv6ll8ddW9O4Czme8U4Q
         iHfsun38erRm9u+UZM0QNcFMXVNGr2k1GPcAVxdz1/3qlEQxphNsMsfoe2wY0kcyPCG6
         IB3u1ilYy+0KuV98dw1K09BLc00OstMKTyvCKGBM1znElG/rsGnlPMI4+HSNT9XhqNVN
         KeovDvjYPOaqT3LfZOocOQuZXwehuSbOHYKhn54ucEoVp7i/ZFS98dCEctLUg8FtExos
         M8kuuhYxuIrNTIhh0C6fgDTJGKgxBOr6HXKmlUNthP5EFwYpbgP5fb9cSNbdyG1tjeWx
         1dSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691721364; x=1692326164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMwz3lieIrdAaFAF5vnTmJpy6ZcX/W7OfrkF3NkDHkE=;
        b=DRSnbkMPuFlvBrOsteXaoHdDt+dSrmdq6mnBN7LjQjOgWLhIjuY4nBnAeSIIvNz8Zc
         FHC3eyFgRwenBuJqdQbXf43i3jVO08sOQEtyy9Q8Y0cHQGlhZ+2pfV+/d4JE/mzwb7va
         9gOFZi7U+yehn6quITi67I2Rf5i/+Gh+G9G/jekPLtUJKYva95Vo31dsbHqUPOOcosTs
         h7Cz+Uexl+jBmPSHsjlENVsersoEldX6YdIEKQcrdr6mhd2MWdiSTCdGkc1+PIeH1voy
         7IrJ4bT22rvvtw0/D5qAefqXIPXkX9f6GmJ6tVq+afOC/gvsnoCrIRnmvwSlkd3FvSLQ
         4DWw==
X-Gm-Message-State: AOJu0YwJ9gNQG9BqWPGCgEYYhiZp3+9/iDnrPnslmpsRLywHvQ8WdKmn
	YSgFKbcg/rVTDhxNncGYUZazvjPf3BFAwrkGUyM=
X-Google-Smtp-Source: AGHT+IHu3DS/viDaXttPmnDwVg1DV/vhXRpB9PIB1jbBbPm+nk46XNraOrwehXHlRbHx14CCt8jKu7zkcaoSj4Yh34U=
X-Received: by 2002:a05:6870:2428:b0:1bf:16f7:c901 with SMTP id
 n40-20020a056870242800b001bf16f7c901mr774695oap.49.1691721363961; Thu, 10 Aug
 2023 19:36:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810112148.2032-1-kerneljasonxing@gmail.com> <ZNVJZKBA698aRXmR@vergenet.net>
In-Reply-To: <ZNVJZKBA698aRXmR@vergenet.net>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 11 Aug 2023 10:35:27 +0800
Message-ID: <CAL+tcoBi=0OzxmoGk56V4OSzJ+u3BD+Nfx8p3MTXGUwU69Kiaw@mail.gmail.com>
Subject: Re: [PATCH net] net: fix the RTO timer retransmitting skb every 1ms
 if linear option is enabled
To: Simon Horman <horms@kernel.org>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, apetlund@simula.no, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 4:32=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Thu, Aug 10, 2023 at 07:21:48PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > In the real workload, I encountered an issue which could cause the RTO
> > timer to retransmit the skb per 1ms with linear option enabled. The amo=
unt
> > of lost-retransmitted skbs can go up to 1000+ instantly.
> >
> > The root cause is that if the icsk_rto happens to be zero in the 6th ro=
und
> > (which is the TCP_THIN_LINEAR_RETRIES value), then it will alway be zer=
o
>
> nit: alway -> always
>
>      checkpatch.pl --codespell is your friend

Thanks for your reminder.

>
> > due to the changed calculation method in tcp_retransmit_timer() as foll=
ows:
> >
> > icsk->icsk_rto =3D min(icsk->icsk_rto << 1, TCP_RTO_MAX);
> >
> > Above line could be converted to
> > icsk->icsk_rto =3D min(0 << 1, TCP_RTO_MAX) =3D 0
> >
> > Therefore, the timer expires so quickly without any doubt.
> >
> > I read through the RFC 6298 and found that the RTO value can be rounded
> > up to a certain value, in Linux, say TCP_RTO_MIN as default, which is
> > regarded as the lower bound in this patch as suggested by Eric.
> >
> > Fixes: 36e31b0af587 ("net: TCP thin linear timeouts")
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/ipv4/tcp_timer.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> > index d45c96c7f5a4..b2b25861355c 100644
> > --- a/net/ipv4/tcp_timer.c
> > +++ b/net/ipv4/tcp_timer.c
> > @@ -599,7 +599,9 @@ void tcp_retransmit_timer(struct sock *sk)
> >           tcp_stream_is_thin(tp) &&
> >           icsk->icsk_retransmits <=3D TCP_THIN_LINEAR_RETRIES) {
> >               icsk->icsk_backoff =3D 0;
> > -             icsk->icsk_rto =3D min(__tcp_set_rto(tp), TCP_RTO_MAX);
> > +             icsk->icsk_rto =3D clamp(__tcp_set_rto(tp),
> > +                                         tcp_rto_min(sk),
> > +                                         TCP_RTO_MAX);
>
> nit: this indentation looks a bit odd.

Yeah, I'm always stuck with this kind of indentation issue. I'll fix
it in v2 patch.

Thanks,
Jason

>
>                 icsk->icsk_rto =3D clamp(__tcp_set_rto(tp),
>                                        tcp_rto_min(sk),
>                                        TCP_RTO_MAX);
>
> >       } else if (sk->sk_state !=3D TCP_SYN_SENT ||
> >                  icsk->icsk_backoff >
> >                  READ_ONCE(net->ipv4.sysctl_tcp_syn_linear_timeouts)) {
> > --
> > 2.37.3
> >
> >

