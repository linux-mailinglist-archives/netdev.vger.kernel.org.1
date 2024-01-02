Return-Path: <netdev+bounces-60820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB75821964
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 11:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A693282F60
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 10:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA84CA68;
	Tue,  2 Jan 2024 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pt7XKvEb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E6BDF6A
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so93897a12.1
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 02:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704189846; x=1704794646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTedTnUHA0DAuezTqdO6Rrt7/UaINxtY0khkwER9tdg=;
        b=Pt7XKvEbwrP848tTWrNa788JMSahBbdoShfxQ5ANdnRFWevk6vFd7oYX5xD1Ryi8ER
         LbwZqrIRVPVbTNTJ2abdIsvzUBOYIyK892ET1/d7hL9YWXn6tZsKE02B6iOfhFQMoppQ
         tDBJqLX0JJK/Vm2JtiK5JMrDIGq/KgkCQ7cw3Ex5MNNqUP1+El4PQcCZJ0AGHk/RHYvP
         KCIt3j93yRBnAJUQVB0b9vFd386lyxgDXAfKnylWdQaTBhOiQTOesFI0caELRvxEQVnp
         QJV+/9UPXwTuYCzOLuszDvrCylw3VwJiNTtUfAQSOmsEX2CmAjKFoM445k0XyTfERf9k
         f5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704189846; x=1704794646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTedTnUHA0DAuezTqdO6Rrt7/UaINxtY0khkwER9tdg=;
        b=eWwNUtl30QaW1EFlpA1Tu3SqQIoQDz4RpbsniNQwCKE7h0hCRFTMUY7mAODU2UJlEv
         KZmJT8HZl2XBLhtJtza7Oda4/VAViY96OfsFLgWyj3aKYCsCQT04s9fFBlpSsyX6V92D
         j2GVKno6oODFN3fExrGAHAFtlo/6GQPv5iL4jeY226AOwB49o6oKPybiewkmar67kDBg
         x/46dzCclGCMLJl6qjkSAq0qVsnnKF/2P6FSWhYQE/xAqYxCSPNOb7oQKVdf9VoUxPMv
         4U+7Ju/Fu/8CstiKoqrAYzmEhQtpf7ggNLR3WTVb6d3IzNT51D569Kkm0MgmqVoIfrgl
         qyGg==
X-Gm-Message-State: AOJu0YztqpZ07GONHCUKSmOCYLlrsLtG4AcOF0i/oWx2hdamTKOC2cRN
	CzL4FmUUMi6ys46kj6h6rx8oLQzIVD6s3b7LPCqF9gjotSPr
X-Google-Smtp-Source: AGHT+IHf0xhhet7tcELa8H7Gvk9n6Rk/UBjzaf8mZtjVHiX+cVMqG8tW5eoVEovOBRI4QJo58TgbIoeXatPFYe6xmmk=
X-Received: by 2002:a50:9b51:0:b0:554:1b1c:72c4 with SMTP id
 a17-20020a509b51000000b005541b1c72c4mr643909edj.1.1704189846310; Tue, 02 Jan
 2024 02:04:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <14459261ea9f9c7d7dfb28eb004ce8734fa83ade.1704185904.git.leonro@nvidia.com>
 <CANn89iLVg3H-GuZ6=_-Rc5Jk14T59pZcx1DF-3HApvsPuSpNXg@mail.gmail.com> <20240102095835.GF6361@unreal>
In-Reply-To: <20240102095835.GF6361@unreal>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Jan 2024 11:03:55 +0100
Message-ID: <CANn89iLd6EeC3b8DTXBP=cDw8ri+k_uGiCrAS6BOoG3FMuAxmg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: Revert no longer abort SYN_SENT when
 receiving some ICMP
To: Leon Romanovsky <leon@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shachar Kagan <skagan@nvidia.com>, 
	netdev@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>, 
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 10:58=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Tue, Jan 02, 2024 at 10:46:13AM +0100, Eric Dumazet wrote:
> > On Tue, Jan 2, 2024 at 10:01=E2=80=AFAM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > From: Shachar Kagan <skagan@nvidia.com>
> > >
> > > This reverts commit 0a8de364ff7a14558e9676f424283148110384d6.
> > >
> > > Shachar reported that Vagrant (https://www.vagrantup.com/), which is
> > > very popular tool to manage fleet of VMs stopped to work after commit
> > > citied in Fixes line.
> > >
> > > The issue appears while using Vagrant to manage nested VMs.
> > > The steps are:
> > > * create vagrant file
> > > * vagrant up
> > > * vagrant halt (VM is created but shut down)
> > > * vagrant up - fail
> > >
> >
> > I would rather have an explanation, instead of reverting a valid patch.
> >
> > I have been on vacation for some time. I may have missed a detailed
> > explanation, please repost if needed.
>
> Our detailed explanation that revert worked. You provided the patch that
> broke, so please let's not require from users to debug it.
>
> If you need a help to reproduce and/or test some hypothesis, Shachar
> will be happy to help you, just ask.

I have asked already, and received files that showed no ICMP relevant
interactions.

Can someone from your team help Shachar to get  a packet capture of
both TCP _and_ ICMP packets ?

Otherwise there is little I can do. I can not blindly trust someone
that a valid patch broke something, just because 'something broke'

