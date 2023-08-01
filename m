Return-Path: <netdev+bounces-23400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 709C576BCA4
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 20:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA67B1C20944
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 18:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5802D22EFD;
	Tue,  1 Aug 2023 18:40:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC494DC89
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 18:40:14 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0983598
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:39:42 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-767b6d6bb87so377178585a.2
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 11:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690915179; x=1691519979;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DB7AN7rNi4AtmuumP40iVCVGsm3BTtANUZUo61mWF8U=;
        b=GTLPBGIO3fpgErpn4CHvYlI7798D+wlKe3+s+49BhMbhUxBIch/Bul4u0csYxXRy6R
         xwn+ir/Q0QGko0eJDMI8eZ+A/FQIKQrvnAW0ksNgGtZxKpy3wZ3VKSXtTxGUfIiYLQ48
         kjz/5crOado+lyf4NkdRbAtfpuRbzxSus7TSfnEW5yauvFymFnbfOWVYx/rumLXDauKN
         Q5/th/PICL+6L/pu7rogy2Plm59RUyCZh8bnd6PNaS3vy3A/98xqSJs4x9vXHZvWuHjP
         JpOa8G+ZdBvDnNjQvFm4p3Xa0icoXfP06j2B+o+DBBiOYDp3L2j0to7TT0nkXwnR8eB8
         CUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915179; x=1691519979;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DB7AN7rNi4AtmuumP40iVCVGsm3BTtANUZUo61mWF8U=;
        b=bGOOXPSUbxs8khBhEhlax+g2Y19RHy+6kruZRys7fUuP8ZUZtioDj5atMvDFSg43j3
         Kni5rgiES+0hLq03qxuCOtINhkSS9R2TtQTIkTUOmSJKaP9xg9swNXGGa++WDJkYxscH
         f5V+GpacmaxtajNWbjHECCxRKY8ppSBIiLUfnPNxUwkfSp2eu7TL5Eb6akEiCxm73x98
         P/LxPHQFrhR3qdOaQcSfUEADHy4sf/7HMY67HnbdtBvoSr5t79aTAQoEL320kZXAdUBe
         mPnfxDIrzk9rRA10SRcG5uEqPFf4/IkYsmZWLJO+yjXruAHQpsz+AxKpcpQ9FBhCP6CY
         y+/Q==
X-Gm-Message-State: ABy/qLbA5kH//Af7V3Zsfsx6LMwR7Txx5V2s9I0lGbjZ8k7nTP6oMW1F
	DF/GT0N2r6XS/SpaNp4WTYOJxdJWGJg=
X-Google-Smtp-Source: APBJJlETfPa0PoxcIC/+KlA8YVdEgJKiVUfBZSQDoMeONDijbi48KQr2qnpa4QoM6l/QU+CTTJ+5rA==
X-Received: by 2002:a05:622a:3c8:b0:403:a0a4:97d5 with SMTP id k8-20020a05622a03c800b00403a0a497d5mr13729165qtx.36.1690915179397;
        Tue, 01 Aug 2023 11:39:39 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id ga11-20020a05622a590b00b0040c72cae9f9sm2873952qtb.93.2023.08.01.11.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 11:39:38 -0700 (PDT)
Date: Tue, 01 Aug 2023 14:39:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Tahsin Erdogan <trdgn@amazon.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com
Message-ID: <64c95169b8de2_1cc1c42947@willemb.c.googlers.com.notmuch>
In-Reply-To: <CANn89iJQfmc_KeUr3TeXvsLQwo3ZymyoCr7Y6AnHrkWSuz0yAg@mail.gmail.com>
References: <20230801135455.268935-1-edumazet@google.com>
 <20230801135455.268935-2-edumazet@google.com>
 <64c9285b927f8_1c2791294e4@willemb.c.googlers.com.notmuch>
 <CANn89iJwP_Ar57Te0EG2fAjM=JNL+N0mYwnEZDrJME4nhe4WTg@mail.gmail.com>
 <64c947578a8c7_1c9eb8294e6@willemb.c.googlers.com.notmuch>
 <CANn89iK80Oi6Hg90DXbXk=cyJxbzGD3zaFGGTSuWVvC5mNnR_Q@mail.gmail.com>
 <CANn89iJQfmc_KeUr3TeXvsLQwo3ZymyoCr7Y6AnHrkWSuz0yAg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] net: allow alloc_skb_with_frags() to
 allocate bigger packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Eric Dumazet wrote:
> On Tue, Aug 1, 2023 at 8:10=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Tue, Aug 1, 2023 at 7:56=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> >
> > > Thanks for the explanation. For @data_len =3D=3D 5000, you would wa=
nt to
> > > allocate an order-1?
> >
> > Presumably we could try a bit harder, I will send a V2.
> =

> I will squash the following part:
> =

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 0ac70a0144a7c1f4e7824ddc19980aee73e4c121..c6f98245582cd4dd01a7c4f=
5708163122500a4f0
> 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6233,7 +6233,7 @@ struct sk_buff *alloc_skb_with_frags(unsigned
> long header_len,
>         while (data_len) {
>                 if (nr_frags =3D=3D MAX_SKB_FRAGS - 1)
>                         goto failure;
> -               while (order && data_len < (PAGE_SIZE << order))
> +               while (order && PAGE_ALIGN(data_len) < (PAGE_SIZE << or=
der))
>                         order--;
> =

>                 if (order) {

Thanks. Clearly not a serious concern. v1 looks great to me too. Was
just trying to understand fully.


