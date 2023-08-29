Return-Path: <netdev+bounces-31301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A499578CBE9
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 20:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9FD1C209ED
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 18:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A4018014;
	Tue, 29 Aug 2023 18:19:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A0217751
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 18:19:20 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E947F1AE
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 11:19:17 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-407db3e9669so40841cf.1
        for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 11:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693333157; x=1693937957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oy1QUGaqWOapu7eNp3YQRtuI9Yasi0/f5GsOYsSPQjY=;
        b=F+Wap03bJ8JosGPAerCejCP2nYqyNLs0jEZ8UjUt4XVqWtBjN0F0povsHVmpXm4bbI
         BIxGw5/xsPaROJs0WMlxOVw4WOHdbHkNxqQn1XdgzGhOJaqM7iVA60t+6Z4W8oGDMVFW
         fBY0f3At5F5bgFJKdxVZYC/WLgovY1q9Y1PiNXshOp5SVf5DXLGjXzGfRUpiWo62uxWH
         MckHTAbp+Un9LSNSmIWiDcNlQD5lPoybVQIoJwg4UsimFTO8C2wGwvEAA/7k+91eBbpb
         ngiquAkbGu2KCtkCQbV8ga6RnVvfOSUNZuPYz5S6MoHKQ54j9hg+QzxJCQgbQXSjEQoj
         NMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693333157; x=1693937957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oy1QUGaqWOapu7eNp3YQRtuI9Yasi0/f5GsOYsSPQjY=;
        b=bgF0QRLE6xS8WGO0r9vct9DU/fbG/anjyfsJEdn63m2t4YQb3tVmUmwnBZmm+u6Fvb
         dOTuknLHbfztcNpBwjxMFug8qDxzgvL466Ue3jvFfcTGGhLsnFB5VpV73WaI+wtzVDNP
         5RzN5t9z+ZVZdNNnlMrnvFHBfBeAUhErRYA6x7BYeRgmntVIvwjync6yfIwggY33FCAl
         5npjwZVdvm9RFOhp0JHF9YvBX/sdR4R2AAo442gwG1m1ZFekraAl/OzRRHJXnuY+ddF5
         z2WRCIPzssxET+MrMad4aB/YbTmiwvM9Kh03YCSI8dnLLbXQOWbtDw0744cZ5h/vcrPI
         6cYw==
X-Gm-Message-State: AOJu0YzjGfNvQWADMRIjxjdsFaIIZblrbKqAHN5K15TCpgiussylL+vu
	Lma1s+EO0pkm3bmAR41PXRLueB2i/l+YXAu6D8SG3Q==
X-Google-Smtp-Source: AGHT+IHRfQDESko9IyIMC0UNTn09i19fjEJlpBO1OWZatCYkgA1W82qxMZMhnOJE76UMImFFNYCHgjrgU1Tmexto1n0=
X-Received: by 2002:a05:622a:1802:b0:3f8:e0a:3e66 with SMTP id
 t2-20020a05622a180200b003f80e0a3e66mr204975qtc.3.1693333156923; Tue, 29 Aug
 2023 11:19:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230828124419.2915961-1-edumazet@google.com> <CADvbK_eRLiosLw9mFbRJ5mmoCmR8vrYchk+Lvt9WjO_f=SLUwg@mail.gmail.com>
In-Reply-To: <CADvbK_eRLiosLw9mFbRJ5mmoCmR8vrYchk+Lvt9WjO_f=SLUwg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 29 Aug 2023 20:19:05 +0200
Message-ID: <CANn89iL_OU1w6TTdZe45PaDkR9o8BbdXoTuF1XS9Ed=5g_NdAA@mail.gmail.com>
Subject: Re: [PATCH net] sctp: annotate data-races around sk->sk_wmem_queued
To: Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 29, 2023 at 8:14=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Mon, Aug 28, 2023 at 8:44=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > sk->sk_wmem_queued can be read locklessly from sctp_poll()
> >
> >                 sk->sk_rcvbuf);
> Just wondering why sk->sk_sndbuf/sk_rcvbuf doesn't need READ_ONCE()
> while adding READ_ONCE for sk->sk_wmem_queued in here?
>

Separate patches for sk_sndbuf, sk_rcvbuf, sk_err, sk_shutdown, and
many other socket fields.

I prefer having small patches to reduce merge conflicts in backports.

Note that I used  READ_ONCE(sk->sk_sndbuf) in sctp_writeable(),
(I assume this is why you asked)

