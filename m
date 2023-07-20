Return-Path: <netdev+bounces-19564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9425475B371
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 17:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F77B281E7B
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 15:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B6918C22;
	Thu, 20 Jul 2023 15:50:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A55218B15
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 15:50:30 +0000 (UTC)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939ED10EA
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:50:16 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40371070eb7so300381cf.1
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689868215; x=1690473015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pwV4S6N0mx0yaTufebtDnGMcBoFVlVlU06rSHGf1gw=;
        b=nKPwphxHKOsSvD790LIW+hAiKjxc5d41JVMutEpNI8XWbmvqnmbYP9vHxOLtjHBxzf
         qZ98z6xFq03jjFyqLPt9idv5xsCSgsAlQZ23hL2GLRddujvpavWG0Vj7OTymlnuEWDTR
         9qbNedEwt9vB/8DOgIcctHzbp1+XD5IEA01aqJdaeTiEDMwajCBV7VhCeD77NBwwwb0f
         0SSLan3AUSTl/F9DARE4mYjeojXcxLPTLtkSBjt5osNRs1nlbQ7xd/rgAxiBLK3Jotxz
         WZzjhDJ4+KS6pnFZBfcmZkuF0KKpmYJmMl7NOB4KKQf56QnBv0adebYtCy+Irp196McR
         OKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689868215; x=1690473015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pwV4S6N0mx0yaTufebtDnGMcBoFVlVlU06rSHGf1gw=;
        b=OWpjBqAMCr/B0pznmGjcUhJQtEC8VL4gULH0z3hyq1ZouomwzU7g3R2DEAmEGnJoCS
         WrwmyLib2qoI2krFcXVao66i467GHQQwKgCIndVdTiV8uEOXfokoBnmA3fPfCOWmWpc6
         HbzbqrfG2QvnR+4ibrD0R88PXnsej1+m4Ws92pj0zIKj7qZT4j9P2rbWMZtu3Jj1fdrZ
         4M55B+f08WarFFU1vwreLaUwRfso6Raj2l6TizOKjXZA59evEz9WgFPqYTJRjHdqtWFa
         SUE9A3XmlgClm5D1xUCp6nfZFOLee0Lr6yh3f5YpCEb6UlWL5z7EzTrDI9hBBF6mOA05
         Elfg==
X-Gm-Message-State: ABy/qLZjNVU6p31IanLboK0dZW067ArNkmlzGCYFO6rQ/lJmOy3PXxe7
	rz43v7R0LPrz54nbxSxiJeZbg06fm0WIG1w4yAtdiw==
X-Google-Smtp-Source: APBJJlHRnOyudbZmOyBhxGcX/Ia8WkBBwSYzBBxH24bgAEvGZZbD9k4TzLaD2IUZzInLuEUQjFtZ17+yXD3es76ZUpc=
X-Received: by 2002:a05:622a:1752:b0:403:affb:3c03 with SMTP id
 l18-20020a05622a175200b00403affb3c03mr297582qtk.10.1689868215566; Thu, 20 Jul
 2023 08:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230717152917.751987-1-edumazet@google.com> <d2e9982b50ad94915454d7587663496e49a25746.camel@redhat.com>
In-Reply-To: <d2e9982b50ad94915454d7587663496e49a25746.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Jul 2023 17:50:04 +0200
Message-ID: <CANn89iJ3o5491wMnJ0Bb8PzHSBoEOV9+K5EZJA6Qk5uTOfwFrA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: get rid of sysctl_tcp_adv_win_scale
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 5:43=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Hi,
>
> On Mon, 2023-07-17 at 15:29 +0000, Eric Dumazet wrote:
> > +static inline void tcp_scaling_ratio_init(struct sock *sk)
> > +{
> > +     /* Assume a conservative default of 1200 bytes of payload per 4K =
page.
> > +      * This may be adjusted later in tcp_measure_rcv_mss().
> > +      */
> > +     tcp_sk(sk)->scaling_ratio =3D (1200 << TCP_RMEM_TO_WIN_SCALE) /
> > +                                 SKB_TRUESIZE(4096);
>
> I'm giving this patch a closer look because mptcp_rcv_space_adjust
> needs to be updated on top of it. Should SKB_TRUESIZE(4096) be replaced
> with:
>
> 4096 + SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
>
> to be more accurate? The page should already include the shared info,
> right?
>
> Likely not very relevant as the ratio is updated to a more accurate
> value with the first packet, mostly to try to understand the code
> correctly.

Hi Paolo.

As discussed with Soheil, I do not think the initial value for
tp->scaling_ratio is very important,
as long as it is not too small of course (otherwise we would have to
increase tcp_rmem[1] to avoid regressions for the first RTT)

Rationale for not adding sizeof(struct skb_shared_info) is because
with GRO, this extra cost tends to disappear.
(Same idea used in truesize_adjust())

