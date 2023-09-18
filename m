Return-Path: <netdev+bounces-34654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 428087A517E
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522F11C20C74
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 18:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8062C266D8;
	Mon, 18 Sep 2023 18:01:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C46B23774
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 18:01:41 +0000 (UTC)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158B3131
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 11:01:37 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-45270220069so517233137.3
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 11:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695060096; x=1695664896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fRaLhmBmn4+1+5tl7RN7c/ujVqPAMFREIBXi8ygv2M=;
        b=kQ1XOWRWW9dW5Kvnoqzs0ZBqtJ+gEmlWcbpnxxxOPV+BfLDYdzpLL3v26hho3QvXrW
         /X7pilACFJMkoRrGv+oefiqToyy3HEtkIfVaUe+a4Ody+PlwpZdsdoBc1ScV6Uvab0f7
         jWLuod3QKp18K5f4vDlESStjrRI1MIeu40RY1fsPQQ+3XuRF8IRAGshSUeyWQ3FniZUT
         OynmjFFgIxmhCjhDAu0M3DjrQ4eO9WSR/bWdTpARbdwhfTDUpQGqu0l88yOQc+pejgxO
         XjulPfIOx4aVkWGFV7iYQfR3OpjsuGt7Towa9fbWu4EG7J6siZcezjUQ6wwWlm6w3hz8
         wffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695060096; x=1695664896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fRaLhmBmn4+1+5tl7RN7c/ujVqPAMFREIBXi8ygv2M=;
        b=SRa4NZZVnJUfqrMi+T0DYBeruHCUR8dUndMnEWGtLpmkrYEvL3uBJivE7PXXe5ZcRO
         EaGx1CsCSRuIm87YNp3IVyUK+TutiiOkfy9fs/XjqZ+fIDU3z/biYnRqVxa+pu67loZT
         Fuyc28N50nWj24c/tPazzXPik4VWH7QaptTJ9u59iOHhKMUiwjxKJpnUIXvFcBZ189eS
         3qsXOnAiCTheH7xVzN5yRwj0iQFhNikggRYoD+SyDhYVo0TNE5dDNeEIQbjayAX/ThZ9
         tBsC0HL8liHnL35/qAM1NVVsbmHTadvgndnRim7R4nXDsB2r1fcq05Z2LL8bVMbbwmES
         VJ1w==
X-Gm-Message-State: AOJu0YykDxbRxkf70zT/WdicuK/UlLJz5uZtLsiQfpCwTmMkDuw3zdI9
	GslyVBONgA2z1w1V6KeQ3ngT7TXzZs0tkDYVq8U=
X-Google-Smtp-Source: AGHT+IHPK+xm6yp57Yat7XZ6lcIL5dPMcW4pzYWqe8GFOTGCXdX/xp93eZENQxozbp4iaS+PRqdwm0nv4xm3Dk1X2cQ=
X-Received: by 2002:a67:be17:0:b0:44d:5e09:e387 with SMTP id
 x23-20020a67be17000000b0044d5e09e387mr7113908vsq.20.1695060096075; Mon, 18
 Sep 2023 11:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918025021.4078252-1-jrife@google.com> <CAF=yD-KSuh0CrRn_zXdznLdg4G==qxgGeQuXetVHP2iOdQzpRA@mail.gmail.com>
 <CADKFtnQs7WRT2ixRGdNnAq6j+MXOR_8PMYGhMN4efJu2+xZeYA@mail.gmail.com>
In-Reply-To: <CADKFtnQs7WRT2ixRGdNnAq6j+MXOR_8PMYGhMN4efJu2+xZeYA@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 18 Sep 2023 14:00:59 -0400
Message-ID: <CAF=yD-+FUZujxSkd1wwdioSqazNptsHMBRpoms20OZJb0OGJ4w@mail.gmail.com>
Subject: Re: [PATCH net v2 1/3] net: replace calls to sock->ops->connect()
 with kernel_connect()
To: Jordan Rife <jrife@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, dborkman@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 1:56=E2=80=AFPM Jordan Rife <jrife@google.com> wrot=
e:
>
> > Please include a Fixes tag in all patches targeting next.
> Would this just be a reference to the commit that introduced this bug?

That's right. So that stable tree maintainers know whether to backport or n=
ot.

Please also cc: stable@vger.kernel.org to net patches:
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#stabl=
e-tree

> Should this patch series be targeting net or net-next considering this
> is a long standing bug, not something that was introduced recently.

It sounds like BPF hooks break existing users of kernel_connect. So I
think you directed it correctly to net.

> > For subsequent iteration, no need for a manual follow-up email to CC th=
e subsystem reviews. Just add --cc to git send-email?
> Ack.
>
> -Jordan
>
> On Mon, Sep 18, 2023 at 6:07=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Sun, Sep 17, 2023 at 10:50=E2=80=AFPM Jordan Rife <jrife@google.com>=
 wrote:
> > >
> > > commit 0bdf399342c5 ("net: Avoid address overwrite in kernel_connect"=
)
> > > ensured that kernel_connect() will not overwrite the address paramete=
r
> > > in cases where BPF connect hooks perform an address rewrite. This cha=
nge
> > > replaces all direct calls to sock->ops->connect() with kernel_connect=
()
> > > to make these call safe.
> > >
> > > This patch also introduces a sanity check to kernel_connect() to ensu=
re
> > > that the addr_length does not exceed the size of sockaddr_storage bef=
ore
> > > performing the address copy.
> > >
> > > Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@g=
oogle.com/
> > >
> > > Signed-off-by: Jordan Rife <jrife@google.com>
> >
> > This looks great to me. Thanks for revising and splitting up.
> >
> > Please include a Fixes tag in all patches targeting next.
> >
> > For subsequent iteration, no need for a manual follow-up email to CC
> > the subsystem reviews. Just add --cc to git send-email?

