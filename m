Return-Path: <netdev+bounces-46157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166217E1BCE
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 09:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454851C20918
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 08:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C53FC03;
	Mon,  6 Nov 2023 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SQwVIBHC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B2CFBFC
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 08:19:10 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9E2B0
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 00:19:09 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so12145a12.0
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 00:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699258748; x=1699863548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/i/NbnNcOp2PQfn3YFUM6ZJmzO+qOkgPk5i2DQ8FBI=;
        b=SQwVIBHCQZyeOg2iF02Blgu0XupDB7mSuhDZf2lLDCch1uB4jkRx6w3RLUpELmVx6o
         Yb2tK1yc8DjhdayeASdGHdP5BHd+3CKALCIy66kOpMgxIiEvdEV9GbiKaj5fWhlx9YRo
         +jQ2mpRfZEuQZC79VlGHbtUC6hTOY0LYcyBYvlgzBYFIdDjpSnuE4L3XAZ8Y/mwQTjjt
         kgPJPjy4V39kQueaCkZgb1gxyhp/LEfUyQnxlZMiOkRVwKGIAezoXjz0yA7lK2hR2s3n
         ZlX9L89/QdqBpRwOrFYMSrLWM6O60mrTOz4wMTsEomXQlMGbpJXI8LyDzCSG7/x09nwB
         dQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699258748; x=1699863548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/i/NbnNcOp2PQfn3YFUM6ZJmzO+qOkgPk5i2DQ8FBI=;
        b=b8OnZ8ga8lVAsc3CGsZqiFOjLOmEUdH4L3pdlLAfa9119hDZHTs4517k80We2CYWcE
         J2eu4Tz/z/SytfFY1hxf+vNkGBKkwrsv4VAxzLXbeRbVpFArg7LjYJ18iY1HU0ly0cNI
         maLh7d0io/+vXM+k9qPTLPME1/lI4P7AApEyTuBaWfK1BJ4vVhh2vmU7xCIqyQD0Mw45
         BIrQ2hRbjUxpXU7G0PnjAQC0+gdzMNWb1Ll+1x7ICmFus9759oiJlVdg664MJPpDNfBZ
         McNiS2J7RwJTYhwynlGhMBe4VDL8YZERpRzhjF2UITLfpeZa9LyyrPv+R6vFh8I9kOyZ
         Rp6Q==
X-Gm-Message-State: AOJu0YyP6btAOGPuwrweDAotcser82jymWLVOTnhsKATljlAk0R0OjiJ
	ESV66ZMXjCz4Ep+cVgG6E65WAUeodqyzU1lN2j2zZg==
X-Google-Smtp-Source: AGHT+IGkyW04CpK4IDAOlc5Y0p8Zck32aKz9RbNbK1LqNDmTh5FITG274bDLPYFvC7Q84CRzdKp3MwnQ02D4rzCnsGU=
X-Received: by 2002:a05:6402:388e:b0:544:4636:db0b with SMTP id
 fd14-20020a056402388e00b005444636db0bmr101681edb.1.1699258747532; Mon, 06 Nov
 2023 00:19:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org>
 <20231023-send-net-next-20231023-2-v1-9-9dc60939d371@kernel.org>
 <CANn89iLZUA6S2a=K8GObnS62KK6Jt4B7PsAs7meMFooM8xaTgw@mail.gmail.com> <1831224a48dfbf54fb45fa56fce826d1d312700f.camel@redhat.com>
In-Reply-To: <1831224a48dfbf54fb45fa56fce826d1d312700f.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 6 Nov 2023 09:18:54 +0100
Message-ID: <CANn89iJ=38aXWA9K18bsMDO22SLi+XyjARTPSdvOMzycOLGPeQ@mail.gmail.com>
Subject: Re: [PATCH net-next 9/9] mptcp: refactor sndbuf auto-tuning
To: Paolo Abeni <pabeni@redhat.com>
Cc: Mat Martineau <martineau@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 8:22=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> Hi,
>
> On Thu, 2023-11-02 at 18:19 +0100, Eric Dumazet wrote:
> > On Mon, Oct 23, 2023 at 10:45=E2=80=AFPM Mat Martineau <martineau@kerne=
l.org> wrote:
> > >
> > > From: Paolo Abeni <pabeni@redhat.com>
> > >
> > > The MPTCP protocol account for the data enqueued on all the subflows
> > > to the main socket send buffer, while the send buffer auto-tuning
> > > algorithm set the main socket send buffer size as the max size among
> > > the subflows.
> > >
> > > That causes bad performances when at least one subflow is sndbuf
> > > limited, e.g. due to very high latency, as the MPTCP scheduler can't
> > > even fill such buffer.
> > >
> > > Change the send-buffer auto-tuning algorithm to compute the main sock=
et
> > > send buffer size as the sum of all the subflows buffer size.
> > >
> > > Reviewed-by: Mat Martineau <martineau@kernel.org>
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > Signed-off-by: Mat Martineau <martineau@kernel.org
> >
> > ...
> >
> > > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > > index df208666fd19..2b43577f952e 100644
> > > --- a/net/mptcp/subflow.c
> > > +++ b/net/mptcp/subflow.c
> > > @@ -421,6 +421,7 @@ static bool subflow_use_different_dport(struct mp=
tcp_sock *msk, const struct soc
> > >
> > >  void __mptcp_set_connected(struct sock *sk)
> > >  {
> > > +       __mptcp_propagate_sndbuf(sk, mptcp_sk(sk)->first);
> >
> > ->first can be NULL here, according to syzbot.
>
> I'm sorry for the latency on my side, I had a different kind of crash
> to handle here.
>
> Do you have a syzkaller report available? Or the call trace landing
> here?

Sure, let me release the report.

