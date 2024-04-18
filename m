Return-Path: <netdev+bounces-89263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 457748A9DFC
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 17:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D662823E3
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8765616ABE3;
	Thu, 18 Apr 2024 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gu0v5VOO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B04168AE9
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452901; cv=none; b=HCQUbc+Oz+VolU5AWYJaz21rHy3OwagviInj+jbKQ7VRQhHyk9VkH2CV68mR1t2MRoXULu8Bq/wVAQW96YFVPvurQKW3PtRWGLOU00XUjfXR+5IhMdCFsgFFfDWTl5FHLDmg+cRHq2gu3rTD5TAC0Or2qqncMQCEQ9HF0aRlRvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452901; c=relaxed/simple;
	bh=3zp5nF4mFiKD7iYUWh54a7D851ETf7idll5TYKeEkXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kG4MCE/+flXrOmSkPuZc9deNCwyY6Cy72HemuUO8F+WFlSpUgT595HC8uZV4RuV5SYliZDIo3HVZ1U3IXfV6/kQQDFubPBdu2EZ3STFmrj4jWTaSXF6kGag86jBCkLNbevms2F6LcfsgfYULRzqq3jJSdfRL4LpGMR/FezV7Ers=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gu0v5VOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF1DC113CE;
	Thu, 18 Apr 2024 15:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713452900;
	bh=3zp5nF4mFiKD7iYUWh54a7D851ETf7idll5TYKeEkXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gu0v5VOOoX639Y7MLLMti/brQ9LGEY2E6Ky9XE62QfZ6ZX4Z8H0H6M6A2BefsjdZR
	 sPxhM7e06hfQue1yad5kd+uBc3hADQAOfUKUNtUP3qJnC7YLS4uDcjH20eouVIdfzE
	 TevZBgMq7+xnYsJqsQ4yAXcVTAaebdZPOMvy1F5YRfCVjVHQlzWfP3fHrHSgu+xoFJ
	 AiGtRDybSEw1XEwYp/73aEysOpWe5xmPyeXREeBR87gvnAY8mSJLte2P9zhgWmj5+R
	 lUd3IfHUOEGSkj0ojx1akucvb5uxCtRQXYNfoUiSmssWQPY1qs29b5BYnKQzvLvdPT
	 NKKbyJGaoeyDg==
Date: Thu, 18 Apr 2024 16:08:16 +0100
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
Message-ID: <20240418150816.GG3975545@kernel.org>
References: <20240418073248.2952954-1-edumazet@google.com>
 <CAM0EoMmi0KE6+Nr6E=HqsnMee=8uia57mv0Go8Uu_uNrsVw9Dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMmi0KE6+Nr6E=HqsnMee=8uia57mv0Go8Uu_uNrsVw9Dw@mail.gmail.com>

On Thu, Apr 18, 2024 at 06:23:27AM -0400, Jamal Hadi Salim wrote:
> On Thu, Apr 18, 2024 at 3:32 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > Medium term goal is to implement "tc qdisc show" without needing
> > to acquire RTNL.
> >
> > This first series makes the requested changes in 14 qdisc.
> >
> > Notes :
> >
> >  - RTNL is still held in "tc qdisc show", more changes are needed.
> >
> >  - Qdisc returning many attributes might want/need to provide
> >    a consistent set of attributes. If that is the case, their
> >    dump() method could acquire the qdisc spinlock, to pair the
> >    spinlock acquision in their change() method.
> >
> 
> For the series:
> Reviewed-by: Jamal Hadi Salim<jhs@mojatatu.com>
> 
> Not a show-stopper, we'll run the tdc tests after (and use this as an
> opportunity to add more tests if needed).
> For your next series we'll try to do that after you post.

Hi Jamal,

On the topic of tdc, I noticed the following both
with and without this series applied. Is this something
you are aware of?

not ok 990 ce7d - Add mq Qdisc to multi-queue device (4 queues)

I'm not sure if it is valid, but I tried running tdc like this:

$ ng --build --config tools/testing/selftests/tc-testing/config
$ vng -v --run . --user root --cpus 4 -- \
	"cd ./tools/testing/selftests/tc-testing; ./tdc.py;"

