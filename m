Return-Path: <netdev+bounces-40652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98287C8288
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3F4282C40
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 09:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5CD11C8D;
	Fri, 13 Oct 2023 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdEg1B7G"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD0B111AC
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 09:53:52 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB26CC
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 02:53:50 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a7b3d33663so25365477b3.3
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 02:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697190830; x=1697795630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6RPI+AmmVlFElnQI1nu0oiFO2r7L++pGeSIx43RgHE=;
        b=gdEg1B7GZjHFukGR5cYnrmdEUgSzqzV3GaBLOMgUbFJnETVfPD3xhUDFu7kO0fdarm
         ZXa0NrjIqZJywKHQ769XnB6nghqvOUB6/8wdDF9VHVisi5M71QMIdou/8Bst6577aHb6
         d4UqOFrxSLDTJoqdv0p6GLZqdsaA5jPtwcwlCPS8rQUdNeqCzsqEg45PdGUX9RC90tYF
         1YR090I23NMsekUD9y019U0BoFUV1Q1kpy+PRWnlVsxd+iI6dmt/3X071gK57KXEXV52
         YM4dquZqK0RY9+75SMHkMK4Jp3PDDY43jJLx1LCWlfONFNZHTGaa45eJ9ksBOXF7i+XH
         G/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697190830; x=1697795630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6RPI+AmmVlFElnQI1nu0oiFO2r7L++pGeSIx43RgHE=;
        b=g9rFKda1hLwBzYX/tmP/B0PhPTIr8JgYhhF937kNzo+jeWfFx6hwW9xTkrgyPpwoJL
         rchiFx9Na05ulv4LWVGXWTn0Q/IO4lzzuPCN4BfGmSxUlzbJKppOB2PaVlCqhhwVY1hu
         9Ds8ujbDon1kSKNQvszNDb1qYfOb0+/7uXlG1JsWJOavY3E1dMHW982JBYhAmFVqLnFo
         Jqr2ODIGVE9WH0H8hrhHhH9C8VZ03/+zTWEWiIwebcPGa/8YvEZ9xykVWrVk+GFIwRr/
         M6HPZKSLDVXDgSYpufA9olEASQSqtItQsURJcykyAP+A9IaBYJ5bjmrGGRwx9GmjFFdL
         4PkA==
X-Gm-Message-State: AOJu0YzARUa3ynafuMZP+++8Z3LGvUW7anhXou3Wtj78/2nc5BDzpuuI
	0arvEmbnLXN1b3zpYk5WrmrwOfkYNtmQgdoYmCUcR1Q63Q==
X-Google-Smtp-Source: AGHT+IEbWtAuAIudURq7Y6vh+aTNWk+yzFlwiqDGqNXdoZ6EbrF9qiOkM8LQfcz6pcssekCIZKjVz/40NL3gWcesPVo=
X-Received: by 2002:a25:d793:0:b0:d9b:405:a104 with SMTP id
 o141-20020a25d793000000b00d9b0405a104mr1713323ybg.18.1697190829898; Fri, 13
 Oct 2023 02:53:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f3b95e47e3dbed840960548aebaa8d954372db41.1697008693.git.pabeni@redhat.com>
 <CANn89iL_nbz9Cg1LP6c8amvvGbwBMFRxmtE_b6CF8WyLGt3MnA@mail.gmail.com>
 <CAMaK5_ii38_Ze2uBmcyX8rnntEi35kXJ47yhxZvCb-ks0bMbxw@mail.gmail.com> <8918fc5c5d112b6cbfd0ac28345a1c33afcb09b9.camel@redhat.com>
In-Reply-To: <8918fc5c5d112b6cbfd0ac28345a1c33afcb09b9.camel@redhat.com>
From: Xin Guo <guoxin0309@gmail.com>
Date: Fri, 13 Oct 2023 17:53:39 +0800
Message-ID: <CAMaK5_joufX_xyRfy=0L=2OnSu4ui-mnprqL_BUfC4_ftN=y=Q@mail.gmail.com>
Subject: Re: [PATCH v2 net] tcp: allow again tcp_disconnect() when threads are waiting
To: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	Ayush Sawal <ayush.sawal@chelsio.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, mptcp@lists.linux.dev, 
	Boris Pismenny <borisp@nvidia.com>, Tom Deseyn <tdeseyn@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi.
My apologizes, i will send my clarifying to you separately later.
and thanks for your suggestion and clarifying.

Regards
Guo Xin

On Fri, Oct 13, 2023 at 5:25=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Hi,
>
> On Fri, 2023-10-13 at 12:42 +0800, Xin Guo wrote:
> > In my view, this patch is NOT so good, and it seems that trying to fix
> > a problem temporarily without knowing its root cause,
>
> First thing first, please avoid top posting when replying to the ML.
>
> I don't follow the above statement. The root case of the problem
> addressed here is stated in the commit message: the blamed commit
> explicitly disables a functionality used by the user-space. We must
> avoid breaking the user-space.
>
> > because sk_wait_event function should know nothing about the other
> > functions were called or not,
> > but now this patch added a logic to let sk_wait_event know the
> > specific tcp_dissconnect function was called by other threads or NOT,
> > honestly speaking, it is NOT a good designation,
>
> Why?
>
> > so what is root cause about the problem which [0] commit want to fix?
>
> The mentioned commit changelog is quite descriptive about the problem,
> please read it.
>
> > can we have a way to fix it directly instead of denying
> > tcp_disconnect() when threads are waiting?
>
> Yes, this patch.
>
>
> Cheers,
>
> Paolo
>

