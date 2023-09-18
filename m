Return-Path: <netdev+bounces-34652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB8A7A514F
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA981C20AFE
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D29D266D2;
	Mon, 18 Sep 2023 17:56:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB7823779
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 17:56:20 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7930FA
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 10:56:19 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31fe3426a61so3922156f8f.1
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 10:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695059778; x=1695664578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvQSaiMg+W81fMhCt2RFcN17i1ddxTtaYiMvWNKHM7M=;
        b=fQ5a3P4o8Zl14kTkoZYkdO6uKzEKSn/zjZvORpxFEglF+X/D0KHPxtYNrawwNbaewZ
         buDQIo7oN61Js1DAtWUtGPwwHXCFHdMEoV9f+PUZBUWR9l60vMyqGvVmxOWw4T6vw0lD
         XNoQZhq2Q23aKH/nf2lOEZE3JoNexGzIBoj1nydaVsCSb5NhpPHdxPLVTmO1dxjIQF29
         CjLiB7NQPnhbUG9YjWBJm/8Y7Fci2ny0+svCZllJoaIGYxbiY9guuC/yLyrIJhoQwn0Q
         UikTv00OGcvzMhAbKyGhhQRnvJoAx4M2ENpKPQVLcgxM5mu13Os6D7KOTDnOwho3SVs1
         hJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695059778; x=1695664578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvQSaiMg+W81fMhCt2RFcN17i1ddxTtaYiMvWNKHM7M=;
        b=EQ8/QjTbj4kXb0OQgY91mmk5FxSZxWS+10ieSCgnLhtAbuh2X9cBcVcWpI9yc7Hm+E
         +r4s4HV8nu1dOK+NVqgTMEc6XQhTVikdYTOdk3LoefSBYM7TERHv5hpJEC5kZTUeQVrb
         5oOrFCbJQtH3IuoCtZ2v+sZqz9f5nO/kkAmBI+enkV6Q+SJGELDyjgfYzv6XTcaXp3FN
         KF4ZTg48asxYm2wuYedN3t/maP5wEhpQ3eo04KNH87pUkKFGEOG/uUrPKXz69/LU979T
         0huBZriuUcTNAUwIYhtKuu68CIUltCDXGO+4Lrbhe+ytsMNhXxE3/h9KDFctlwNplHiS
         aZaw==
X-Gm-Message-State: AOJu0YwXK5pIjMSDYN+f++fn4S/G6ITVI2mB2+ETi2wzYDMyHZWHszEa
	3kiW9lPvAnNlGLLpSzmzuc8iYQ+WXKztN9hQpckCjQ==
X-Google-Smtp-Source: AGHT+IFul0ZzySFVwFLPHbo0roimbyhLgUKK4YlPu5aguKfASFz9dZV2g53Py0WlCLgkUGy/Qjx8y1jSuL/Pcxc6ZTY=
X-Received: by 2002:a5d:4bc9:0:b0:319:55bc:4416 with SMTP id
 l9-20020a5d4bc9000000b0031955bc4416mr8013868wrt.5.1695059777946; Mon, 18 Sep
 2023 10:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918025021.4078252-1-jrife@google.com> <CAF=yD-KSuh0CrRn_zXdznLdg4G==qxgGeQuXetVHP2iOdQzpRA@mail.gmail.com>
In-Reply-To: <CAF=yD-KSuh0CrRn_zXdznLdg4G==qxgGeQuXetVHP2iOdQzpRA@mail.gmail.com>
From: Jordan Rife <jrife@google.com>
Date: Mon, 18 Sep 2023 10:56:06 -0700
Message-ID: <CADKFtnQs7WRT2ixRGdNnAq6j+MXOR_8PMYGhMN4efJu2+xZeYA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/3] net: replace calls to sock->ops->connect()
 with kernel_connect()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, dborkman@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Please include a Fixes tag in all patches targeting next.
Would this just be a reference to the commit that introduced this bug?
Should this patch series be targeting net or net-next considering this
is a long standing bug, not something that was introduced recently.

> For subsequent iteration, no need for a manual follow-up email to CC the =
subsystem reviews. Just add --cc to git send-email?
Ack.

-Jordan

On Mon, Sep 18, 2023 at 6:07=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Sun, Sep 17, 2023 at 10:50=E2=80=AFPM Jordan Rife <jrife@google.com> w=
rote:
> >
> > commit 0bdf399342c5 ("net: Avoid address overwrite in kernel_connect")
> > ensured that kernel_connect() will not overwrite the address parameter
> > in cases where BPF connect hooks perform an address rewrite. This chang=
e
> > replaces all direct calls to sock->ops->connect() with kernel_connect()
> > to make these call safe.
> >
> > This patch also introduces a sanity check to kernel_connect() to ensure
> > that the addr_length does not exceed the size of sockaddr_storage befor=
e
> > performing the address copy.
> >
> > Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@goo=
gle.com/
> >
> > Signed-off-by: Jordan Rife <jrife@google.com>
>
> This looks great to me. Thanks for revising and splitting up.
>
> Please include a Fixes tag in all patches targeting next.
>
> For subsequent iteration, no need for a manual follow-up email to CC
> the subsystem reviews. Just add --cc to git send-email?

