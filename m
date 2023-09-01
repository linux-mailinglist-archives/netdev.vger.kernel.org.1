Return-Path: <netdev+bounces-31790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDE2790310
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 23:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560DB1C209B3
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 21:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D10F9E5;
	Fri,  1 Sep 2023 21:12:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D215EC136
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 21:12:00 +0000 (UTC)
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5B9198C
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 14:11:22 -0700 (PDT)
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 72F2A3F627
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 21:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1693602681;
	bh=XwIOmpIe/RrfEoBvhvmbdhClCHMkiyeb31e6bLO57k4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=RbRDFyHFknrfKtv/KobzhPOjs+v3Oj9QX/6zhij3WTbGo1Hui2RDCRRbaJF45Z1Hm
	 DFYAdxMdqDoXit+RtRcT7bP+/roeyQtxoyRNSJXIgC7YtiaEmuz/EWh8dpTbYu1gy6
	 eiKIXxhzLkrqppn7MjX3yntGkx+4/YMwlhn0U0bBuo7yRHrvWYsHNmpyHgPD5xQBeb
	 Tywfm4xWNmhz3iGetMwB2YEuCcBdfnscv9IEVx7dgBvidsaxX1Sx9Yrbwo1bIEF6yb
	 2dbkTg3EQFCVdVgrkRvj2911arsJpHN5yn2PwW9jBuYtcmayWhVKEmHPeWzx52iV4K
	 EvKSJga3BShEA==
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5712057db18so2544508eaf.0
        for <netdev@vger.kernel.org>; Fri, 01 Sep 2023 14:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693602680; x=1694207480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwIOmpIe/RrfEoBvhvmbdhClCHMkiyeb31e6bLO57k4=;
        b=iyzO1PTHlm2ez1ARs1dWJn1gmC11L6roc2njbzUOVq4OgqF+XDGuOhTZn8vB/+Cq6P
         DJtk+fUKA+JS/b9jOj6dp4wsxxputsxyNqW+ciNyXa+NjNcmLe5hBG6EaHJ3+P89A9Ou
         MOI+rWD2nuu0Td/3Z+3LjF3zpLjgwLBsDK+D4yCWwhLfGG+n57ROG0g/jtK6CTghsf93
         VzL5b+PtRs66lq4azW7iQzCTJfcRmOGGzJvcTMtSK4Rt91rPFquhV1eErL1mGn1w+5eJ
         /8TfN0pjaK/OsXCIfK11yBXzkEUURohAY+8sWDqvnlRb1m3G3bRMlRjViLKCnP+iR5C1
         TLxg==
X-Gm-Message-State: AOJu0YyHQQRkUAYJnmEIaBO6RqbERCmaV++9OHfKPB0N5vHiGkmf/14e
	9KvK1NWeOUtKbybJj1GCNIo69mQoItAzAx4LllPpFTS7xBiCgRIcg442UyDt8ZLRBFvjN3X2/RJ
	1QesyffnAb2k/Dl6J1nkWRNtyXDaF6wsrgUSM4h5aZ4VaP7NPZA==
X-Received: by 2002:a05:6358:5e1c:b0:129:d242:f782 with SMTP id q28-20020a0563585e1c00b00129d242f782mr2635955rwn.0.1693602680325;
        Fri, 01 Sep 2023 14:11:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl1MahQid8Pf8m4MydU5h0YzxnIX7NzFxvCQdVjKARyFXsvglURYjIg08zlkxTrL8/EbnM+/FQSo0UQik7w3c=
X-Received: by 2002:a05:6358:5e1c:b0:129:d242:f782 with SMTP id
 q28-20020a0563585e1c00b00129d242f782mr2635947rwn.0.1693602680104; Fri, 01 Sep
 2023 14:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230901205145.10640-A-hca@linux.ibm.com> <20230901205613.59455-1-kuniyu@amazon.com>
In-Reply-To: <20230901205613.59455-1-kuniyu@amazon.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Fri, 1 Sep 2023 23:11:09 +0200
Message-ID: <CAEivzxfhLC5zSxPUk8PE6jC9s0KbAzD2YzbomY2-skpF-dKMog@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/4] scm: add SO_PASSPIDFD and SCM_PIDFD
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: hca@linux.ibm.com, arnd@arndb.de, bluca@debian.org, brauner@kernel.org, 
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	keescook@chromium.org, kuba@kernel.org, ldv@strace.io, leon@kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mzxreary@0pointer.de, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 1, 2023 at 10:56=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Heiko Carstens <hca@linux.ibm.com>
> Date: Fri, 1 Sep 2023 22:51:45 +0200
> > On Fri, Sep 01, 2023 at 01:33:22PM -0700, Kuniyuki Iwashima wrote:
> > > From: Heiko Carstens <hca@linux.ibm.com>
> > > Date: Fri, 1 Sep 2023 22:05:17 +0200
> > > > On Thu, Jun 08, 2023 at 10:26:25PM +0200, Alexander Mikhalitsyn wro=
te:
> > > > > +       if ((msg->msg_controllen <=3D sizeof(struct cmsghdr)) ||
> > > > > +           (msg->msg_controllen - sizeof(struct cmsghdr)) < size=
of(int)) {
> > > > > +               msg->msg_flags |=3D MSG_CTRUNC;
> > > > > +               return;
> > > > > +       }
> > > >
> > > > This does not work for compat tasks since the size of struct cmsghd=
r (aka
> > > > struct compat_cmsghdr) is differently. If the check from put_cmsg()=
 is
> > > > open-coded here, then also a different check for compat tasks needs=
 to be
> > > > added.
> > > >
> > > > Discovered this because I was wondering why strace compat tests fai=
l; it
> > > > seems because of this.
> > > >
> > > > See https://github.com/strace/strace/blob/master/tests/scm_pidfd.c
> > > >
> > > > For compat tasks recvmsg() returns with msg_flags=3DMSG_CTRUNC sinc=
e the
> > > > above code expects a larger buffer than is necessary.
> > >
> > > Can you test this ?
> >
> > Works for me.
> >
> > Tested-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

Thanks for reporting this, Heiko!
My bad.

Kuniyuki,
Thanks for the quick fix.

Kind regards,
Alex

>
> Thanks!
> I'll post a formal patch.

