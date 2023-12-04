Return-Path: <netdev+bounces-53477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEFB8032BB
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 13:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ACA11C209E0
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 12:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1DE200BF;
	Mon,  4 Dec 2023 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JKPTq6Ii"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA58107
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 04:31:40 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso10931a12.1
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 04:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701693099; x=1702297899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9X3hHujRP5MoNC4rUpWIAj7EzI4FmYMsdvFeVn9PRM=;
        b=JKPTq6IijoqDHzy7wU/WCbUWhqYQyN/i0inCM/wUbGVFFryQhvKELXYQstPt0VPvrW
         LXlGRsvFB4ge13XTbLjZ54fWqV1/xLwTCn5AXljC2uluAQaqffpgNyRDrYiCVodNv6LR
         xpj3Z5iGcF+obQUWC3ww8rchlENseACLbIL9brbC2vsKvJ8MeeQZdpK+BBGI7g53aCJy
         o26ihstADbIsbr7OclvTrzGbkkilQXYpYbutCy+EqPY+jMENVWhaM+QYXnndccZDDjy1
         tc9kmJzqOhDy2OUcPbQmZpviWBh1Cu4DM1s4bXIy4TgbsttetcGvzzQkFP+fuEwyfmQx
         kBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701693099; x=1702297899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9X3hHujRP5MoNC4rUpWIAj7EzI4FmYMsdvFeVn9PRM=;
        b=rQM/py/Xp3shM9FAHu/Rorn2IrEY5VINufLbVsFdsPbPIi8HW0CfbAEwKHXX3yKYkj
         IVo1Fm7zXfNDVzgW0xLPVs9bEeNsNZbC99687DAbtmJltRPiHMciLrxyrGNW/GM85loE
         h4SfRlVin2YW3dWpsyvAoLeA8iqDI4zswvIPAbx+Zkz828WuLPbDrkvvxZwlziOnWpjl
         3gXx9umn3uf6WyrZvYhqfbBDzrhjZUBrsDNTv4dtjz5AixRp93IXM03Ld5472Nt2vMWd
         GzlglOfaLPf8xI5wBiMOLrK2E30pI1nrjtsLo2naiVCXPn4q8sBmQ4J7E2T/w9KOtLkf
         BqtQ==
X-Gm-Message-State: AOJu0Ywkw+HbZ5nflSeBU/WZF0vLqo/92E/xG4WDP3LkOttRf7KNRJxN
	EkcQAFmgAoazwv2wfmc1n/MLJW7rMEJDCOG7Nj/g7A==
X-Google-Smtp-Source: AGHT+IHAr36R6nYMogh1zEQbXjWbhOuBAmr33gTQPAzXH3rfAdgjaKL8ohbWoMxvG/TMKgi4krwzNACAt4RpYpvuAFw=
X-Received: by 2002:a05:6402:358e:b0:54c:79ed:a018 with SMTP id
 y14-20020a056402358e00b0054c79eda018mr144248edc.2.1701693098821; Mon, 04 Dec
 2023 04:31:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b3a84ae61e19c06806eea9c602b3b66e8f0cfc81.1701362867.git.gnault@redhat.com>
 <20231201203434.22931-1-kuniyu@amazon.com> <CANn89i+QvbYLFoMkr6NTj2+7eHsZ=s9wo3gpdF1BpH3ejXFEgw@mail.gmail.com>
 <ZW2w3YyNMoyN1t97@debian>
In-Reply-To: <ZW2w3YyNMoyN1t97@debian>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Dec 2023 13:31:27 +0100
Message-ID: <CANn89iLHxopRpEoUdypAS7hvth26JPg3P6u9rCnQthVeCnbC+w@mail.gmail.com>
Subject: Re: [PATCH net-next v4] tcp: Dump bound-only sockets in inet_diag.
To: Guillaume Nault <gnault@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, mkubecek@suse.cz, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 11:58=E2=80=AFAM Guillaume Nault <gnault@redhat.com>=
 wrote:
>
> On Fri, Dec 01, 2023 at 09:41:16PM +0100, Eric Dumazet wrote:
> > On Fri, Dec 1, 2023 at 9:34=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon=
.com> wrote:
> > >
> > > From: Guillaume Nault <gnault@redhat.com>
> >
> > > > +                                             goto next_bind;
> > > > +
> > > > +                                     if (sk->sk_state !=3D TCP_CLO=
SE ||
> > > > +                                         !inet->inet_num)
> > >
> > > Sorry for missing this in the previous version, but I think
> > > inet_num is always non-zero because 0 selects a port automatically
> > > and the min of ipv4_local_port_range is 1.
> > >
> >
> > This is not true, because it can be cleared by another thread, before
> > unhashing happens in __inet_put_port()
> >
> > Note the test should use READ_ONCE(inet->inet_num), but I did not
> > mention this, as many reads of inet_num are racy.
>
> Would you like me to send a v5, or do you prefer to let a future series
> fix all the racy reads and writes at once?
>
> Personally, I feel it'd look strange to have a READ_ONCE() only in
> inet_diag_dump_icsk(), while the rest of the stack accesses it
> directly. But just let me know if you feel otherwise and I'll post a
> v5.

I gave my Reviewed-by: tag for V4, because the READ_ONCE() issues are
orthogonal.

I do not think a V5 is needed.

