Return-Path: <netdev+bounces-89521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F218AA902
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 09:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B42FB2140D
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 07:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08B23BBFE;
	Fri, 19 Apr 2024 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJVGnT56"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88602E3F2
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713511094; cv=none; b=GS5QwpFFDIajG3Sh2g5pFxaRZvveCjFVqOJ/f/z+CXm7CuT3lrne2XGxXdfUhCkj3bmJAsxgAmrjC63lOCQAx7QaIhfrEiM8Z6GFd1e+VTQcwfKT/3PWBvKe1rpX5JEtk8rRubdv7vwJR2nDlAdVWtyfm5kb/gZIOwsyHOTiL+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713511094; c=relaxed/simple;
	bh=Si+O37bF/L0cBw1a1veCN1ECNMe78o7gX6g0aKM1WCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTRQn8QTjLlHOLO5IGkxJQeEImGeu3rt65u3O5oIAEEodsSdqdlOpBOxx5EkVvZYEtV3GTZZOQukeFnHxUb7YKkQQoQCqVx6VOvDcq//cmFfE2wSS+jHN7NOw5FyvMVgQJnxXxOqpgeuTiRa14ygImhd3lgqVcsk7J6ksM2uyMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJVGnT56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1192AC072AA;
	Fri, 19 Apr 2024 07:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713511094;
	bh=Si+O37bF/L0cBw1a1veCN1ECNMe78o7gX6g0aKM1WCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJVGnT5664Vzt7lSS3zeGCBMhV26fWJsMmmdjLqMYZq6yE2PMhGaXN3fyzlmFXVQf
	 kAB5d4OsWJ8cMldlrkashvzEa/+P+KwsNvwjxYD96TfoSTsZxb8nCu3GXCmuONgkno
	 jcclItM7BNKTcIrmfD8aVSe1wWd5ooqG1ze4BbPLdIkSuYere6Qt9aeWirlOuk9weG
	 UNy5uuPz4tVc3C1g3gGsIWKIhocfPI+NiQEmd1R1F8wbrlZ9P5lUbuhkxtR3ZEVenS
	 v1EEO0f2INPdDE64iCvfgjU3UZSy6b4cEuzgduBy9tyKYW2U6/d0X5xmHbrq2LxjJn
	 hEUbR36xft7WQ==
Date: Fri, 19 Apr 2024 08:18:09 +0100
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: tdc [Was: Re: [PATCH v2 net-next 00/14] net_sched: first series
 for RTNL-less] qdisc dumps
Message-ID: <20240419071809.GT3975545@kernel.org>
References: <20240418073248.2952954-1-edumazet@google.com>
 <CAM0EoMmi0KE6+Nr6E=HqsnMee=8uia57mv0Go8Uu_uNrsVw9Dw@mail.gmail.com>
 <20240418150816.GG3975545@kernel.org>
 <CAM0EoM=Cen-0ctMkBvDL-jsuwPKGetz4yTG+RpmW7dXjjeVaQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoM=Cen-0ctMkBvDL-jsuwPKGetz4yTG+RpmW7dXjjeVaQg@mail.gmail.com>

On Thu, Apr 18, 2024 at 07:05:08PM -0400, Jamal Hadi Salim wrote:
> On Thu, Apr 18, 2024 at 11:08 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Thu, Apr 18, 2024 at 06:23:27AM -0400, Jamal Hadi Salim wrote:
> > > On Thu, Apr 18, 2024 at 3:32 AM Eric Dumazet <edumazet@google.com> wrote:
> > > >
> > > > Medium term goal is to implement "tc qdisc show" without needing
> > > > to acquire RTNL.
> > > >
> > > > This first series makes the requested changes in 14 qdisc.
> > > >
> > > > Notes :
> > > >
> > > >  - RTNL is still held in "tc qdisc show", more changes are needed.
> > > >
> > > >  - Qdisc returning many attributes might want/need to provide
> > > >    a consistent set of attributes. If that is the case, their
> > > >    dump() method could acquire the qdisc spinlock, to pair the
> > > >    spinlock acquision in their change() method.
> > > >
> > >
> > > For the series:
> > > Reviewed-by: Jamal Hadi Salim<jhs@mojatatu.com>
> > >
> > > Not a show-stopper, we'll run the tdc tests after (and use this as an
> > > opportunity to add more tests if needed).
> > > For your next series we'll try to do that after you post.
> >
> > Hi Jamal,
> >
> > On the topic of tdc, I noticed the following both
> > with and without this series applied. Is this something
> > you are aware of?
> >
> > not ok 990 ce7d - Add mq Qdisc to multi-queue device (4 queues)
> >
> 
> Since you said it also happens before Eric's patch, I took a look in
> the test and nothing seems to stand out. Which iproute2 version are
> you using?
> We are running tdc in tandem with net-next (and iproute2-next) via
> nipa for a while now and didn't see this problem pop up. So I am
> guessing something in your setup?

Thanks Jamal,

I appreciate you checking this.
I agree it seems likely that it relates to my environment.
And I'll try out iproute2-next.

For the record I'm using the Fedora 39 packaged iproute2,
iproute-6.4.0-2.fc39.x86_64.

For the kernel, I was using net-next from within the past few days.

> > I'm not sure if it is valid, but I tried running tdc like this:
> >
> > $ ng --build --config tools/testing/selftests/tc-testing/config
> > $ vng -v --run . --user root --cpus 4 -- \
> >         "cd ./tools/testing/selftests/tc-testing; ./tdc.py;"
> 
> This looks reasonable...

Thanks, that was my main question.

