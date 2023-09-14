Return-Path: <netdev+bounces-33840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5777A0713
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 16:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4258F1C20750
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 14:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C637D22EEF;
	Thu, 14 Sep 2023 14:17:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D1922EE4
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 14:17:08 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02179115
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 07:17:08 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41761e9181eso208661cf.1
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 07:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694701027; x=1695305827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mj3mFGPeB54UrkkuDU4lLdD2lBMtuBYleIZZfH31tmc=;
        b=sAEGcZZPi7uGOGRexfolF+qhmzTrIfU8p8CPxcoX4Roo3KsxNKKMWpyg3SYROAEpQ/
         5ZzJ+ljSN8plIn5OkvVxDVq1rgSFQrpxMka/pPdpiiyI6fDShdNfaxEvEPanQ3jEm6kS
         6WXtam9lRSvBOURbrjOkLzJQzIO5l7Qq+JeU+Z9m7Dy82DzB1fZ1MZgcOG0ydderD1f+
         Td+Yu3DHQfvCi4ecGEOj0QDpmXIRskn+0W4qv8f03wCgBRXFadGtVHgpPjmmW9GTWPn+
         fbApSCrvPsVNMupuBw3QK7smF/JwabVkTSCygn1A4Ro6r2iQQUfbXKes/lhiCO4WQwjw
         X2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694701027; x=1695305827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mj3mFGPeB54UrkkuDU4lLdD2lBMtuBYleIZZfH31tmc=;
        b=nLqEfqt8wxKauK6Z5Pr8oboS0nvVHp8Gkku8GlOhvS7HAnd+ikfxjROKCNNNd5vSLN
         JoIdrnWM7EhbD0DcGN6Q8ZS7kAFkTVm9IRETTVAzkUW9mNqdn2LanjeREm8/L46hGoNv
         ktsBgG5DEhd9eZgdgL22ozQ3ifYwT/6igLGgB1CPtvH9+64EWG28wenu9YYH/0DBmE3q
         vikFOdAqbA6SNfi/s0eqM2flJp/AMeYT+q2UskxQVBsGiYcFB9AOBYkTKVCSNX+ugRWd
         I+FafEjKVw8MP+p/bW8Zc91TBAON2740eV2+xNRzovwg8T4dW6Fpwg+F43fXoCCsp85e
         wFRQ==
X-Gm-Message-State: AOJu0Yx+KixrU0fa6kMHhqi9c3nGomrS2Fj3fmvO5H3hcY4ogqRGIjYH
	guo+nrcKXzh6e7UwowVAO8Q2r9QxTnjNvmwoA0o+JA==
X-Google-Smtp-Source: AGHT+IFJcsvLbF6k5A5TRjcboBxyxTQ+ZhsJy61P6tfovnGYhJ7dytoDiQQI8osm/y8iN3WoxHq3tQF2IH/u+3smcCQ=
X-Received: by 2002:a05:622a:60b:b0:3f2:1441:3c11 with SMTP id
 z11-20020a05622a060b00b003f214413c11mr650856qta.2.1694701026826; Thu, 14 Sep
 2023 07:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912023309.3013660-1-aananthv@google.com> <20230912023309.3013660-3-aananthv@google.com>
 <e3ed5c1e03d14dabb073bbb6d56f0fb825e770a4.camel@redhat.com> <CAK6E8=fbiVVEtbGavo2uVi7fVCB9dVDVypTWZBtzymc51EW0bg@mail.gmail.com>
In-Reply-To: <CAK6E8=fbiVVEtbGavo2uVi7fVCB9dVDVypTWZBtzymc51EW0bg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 14 Sep 2023 16:16:53 +0200
Message-ID: <CANn89i+AtUw1i7VC_POoC6Y+KGXDM7AnV6RitpRPjyUNrtE1Kg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: new TCP_INFO stats for RTO events
To: Yuchung Cheng <ycheng@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Aananth V <aananthv@google.com>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 3:37=E2=80=AFPM Yuchung Cheng <ycheng@google.com> w=
rote:
>
> On Thu, Sep 14, 2023 at 5:02=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > Hi,
> >
> > On Tue, 2023-09-12 at 02:33 +0000, Aananth V wrote:
> > > @@ -2825,6 +2829,14 @@ void tcp_enter_recovery(struct sock *sk, bool =
ece_ack)
> > >       tcp_set_ca_state(sk, TCP_CA_Recovery);
> > >  }
> > >
> > > +static inline void tcp_update_rto_time(struct tcp_sock *tp)
> > > +{
> > > +     if (tp->rto_stamp) {
> > > +             tp->total_rto_time +=3D tcp_time_stamp(tp) - tp->rto_st=
amp;
> > > +             tp->rto_stamp =3D 0;
> > > +     }
> > > +}
> >
> > The CI is complaining about 'inline' function in .c file. I guess that
> > is not by accident and the goal is to maximize fast-path performances?
> >
> > Perhaps worthy moving the function to an header file to make static
> > checkers happy?
>
> or simply remove the inline keyword since it's only used in that file.

Yes, these inline are not really needed, the compiler will generate
the same code.

