Return-Path: <netdev+bounces-31305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EC478CCA5
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 21:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113D31C20A4D
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 19:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1121802A;
	Tue, 29 Aug 2023 19:05:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92915174E6
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 19:05:45 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894BBCDA
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 12:05:30 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5925e580e87so51534477b3.1
        for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 12:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693335930; x=1693940730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OSj1qIC3XfnirMbqDECP+N2VkqM6ww4TSsdouOCAuM=;
        b=N03U0B0Pe23rbk5oXXZR4u6miBSpAznSREH/Y/JZgNaXbVwgHonLEXn4uBewsurzj3
         uURWCZjAc8s2wVeQMjLvPufBs3N4xia36fFCZZDz5Y/wfOFF8eW7HE8JZAOfQfZbYxTw
         Pu5tJdj6zBaGmWeMYLDdTfjm2ZxkRon/rmJqY4Y+lidkyYRZVfXXJzv5pzmHpz6gtsJ7
         RuMxUzXcEWxaJ5uzwfYcJNu59/dNxZqotr5rOQRTxZHcdvarz+chziNQwuIItOxCHMJr
         u24oL5ypdeOaM4JknoY+4BGWxY5S5ui4qHrx/1kda9kElZ6rLFmnkBQcPISodtrW6qpl
         6bSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693335930; x=1693940730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OSj1qIC3XfnirMbqDECP+N2VkqM6ww4TSsdouOCAuM=;
        b=DroPp0VDyNAvUqJA3ulFa+G90c+CNZBlAeuW+N9GKVybP7LBkClXQik2IjLEI7joBc
         o1BsB0qhmLu6Quq3AEDDxIMpRFS8UGywnxjuuXpnyrA+oY2kSYTxv5JnHoPHxdnNS0Z+
         1CBYf3D9jXd6o0bct6A3kYFCSqEOkuPhsOF7MB8mSk4EDgQtIa4L40w3hCrAoVGzHeZz
         lqXYOZqvZMUPbUNLrg73QrSYbQYJHmmtQRjC6JMdEe1twKwfQxPpOl3DUEe2dgWGo5/N
         2bI9w2ToDlmHIslMiLAY1UU+e9o6QW+hYcJGqBEECC9F8C/JGOj4lWQQQdiH5DgNtNp3
         wV+g==
X-Gm-Message-State: AOJu0YyFFigb9QumKcpNYHZT/x3a2VCVQqeSIiBM6v86pzw4fH/dQXfu
	ASp7Zkb+pbVSB6ZjOEaSeolQHRD1RkK4YJ0Tmw0=
X-Google-Smtp-Source: AGHT+IEZYDlGyOGZdDkP3OsWS9imA9ed+QLX/Z731LNmhYMPv7ChXZ+uA9XQZnZ3+qTGqAWIlQ9O+zy60pZsVvkH0i0=
X-Received: by 2002:a25:b188:0:b0:d4e:4103:7807 with SMTP id
 h8-20020a25b188000000b00d4e41037807mr29492ybj.60.1693335929505; Tue, 29 Aug
 2023 12:05:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230828124419.2915961-1-edumazet@google.com> <CADvbK_eRLiosLw9mFbRJ5mmoCmR8vrYchk+Lvt9WjO_f=SLUwg@mail.gmail.com>
 <CANn89iL_OU1w6TTdZe45PaDkR9o8BbdXoTuF1XS9Ed=5g_NdAA@mail.gmail.com>
In-Reply-To: <CANn89iL_OU1w6TTdZe45PaDkR9o8BbdXoTuF1XS9Ed=5g_NdAA@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 29 Aug 2023 15:05:09 -0400
Message-ID: <CADvbK_fTP1x0uqz3w9OPLpGPLMD5AcCfwT0-Lx2dkPXDGLVqxw@mail.gmail.com>
Subject: Re: [PATCH net] sctp: annotate data-races around sk->sk_wmem_queued
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 29, 2023 at 2:19=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Aug 29, 2023 at 8:14=E2=80=AFPM Xin Long <lucien.xin@gmail.com> w=
rote:
> >
> > On Mon, Aug 28, 2023 at 8:44=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > sk->sk_wmem_queued can be read locklessly from sctp_poll()
> > >
> > >                 sk->sk_rcvbuf);
> > Just wondering why sk->sk_sndbuf/sk_rcvbuf doesn't need READ_ONCE()
> > while adding READ_ONCE for sk->sk_wmem_queued in here?
> >
>
> Separate patches for sk_sndbuf, sk_rcvbuf, sk_err, sk_shutdown, and
> many other socket fields.
>
> I prefer having small patches to reduce merge conflicts in backports.
>
> Note that I used  READ_ONCE(sk->sk_sndbuf) in sctp_writeable(),
> (I assume this is why you asked)
Yes.

Not sure about tcp's seq_show, but as sctp_assocs_seq_show() is only
under rcu_read_lock() and with a hold of transport/association/socket,
does it mean all members of assoc should also use READ_ONCE()?
(Note I think we don't expect the seq show to be that accurate.)

Thanks.

