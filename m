Return-Path: <netdev+bounces-90239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2818AD40D
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 20:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AFE81F2197E
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 18:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4423B13EFE1;
	Mon, 22 Apr 2024 18:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqSjeSi8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C77154422
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713810850; cv=none; b=O0YNYg7OzpjePx9gAQleD8bm7jVbgfc8385e5ZQUnYvu/+P7InT3dkBFiC63Fb54LgWcFRwItSmReH2dhXcvnC93QyyE2iXHCNFevbtMB6YfAowmB6B9t4itFZoUaEPvsNR/bP/ff5lPxoEcg5URwpufZD4IhTN9/0VBZ7ir6K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713810850; c=relaxed/simple;
	bh=QroLROb+9J7wSIEprVbwfLzUrvYKKxYTKioKMoX5Bek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WD1wgDL9zxY+EYOt0GP+FbSEVFnGeIBOc1CCLrzJrIL5OFMS1pCDA/UOdykr7Tt/WQFLQXr2THegSN2BBpMrft6mR7LqdJBcr7V+2+7ZTP2n92mC1qWV1sJbQOhxyqSoGUH10C4KMbvx5JmGklxPr2yeUwyDOecVfWrBh1rnteA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqSjeSi8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E70C113CC;
	Mon, 22 Apr 2024 18:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713810849;
	bh=QroLROb+9J7wSIEprVbwfLzUrvYKKxYTKioKMoX5Bek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cqSjeSi8TEvqI5wneEPi0zyEuZxbYm44qu+veD4nRwiVzjwwhgeP28II30ghV32/E
	 xoCB0JNvPxJLXWBaEyQbjNUthO1i3IpYMMWpnEQaAu0+TjBLHMX8pB08omY1KL8gRS
	 RSzVIJoh+YDGY69VXqe3aLMTuFD6sltTDShw3pfxLSjBMeGY5zWrQA2b1FTHZvQvKW
	 Y5jKxpDu/0BaAgeocipSFPKWkLFoP8b7q8CVxihC74cAknvjnKPvmY1WjKoSF0HtyM
	 MqjIh07f2BLM0/7cyhMAqaUzx8IXsl5uXR1/CmvR8qX/z4ZCyaIef05RkBfxzoaTJH
	 Zy389wsXuGSFw==
Date: Mon, 22 Apr 2024 19:34:05 +0100
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: tdc [Was: Re: [PATCH v2 net-next 00/14] net_sched: first series
 for RTNL-less] qdisc dumps
Message-ID: <20240422183405.GF42092@kernel.org>
References: <20240418073248.2952954-1-edumazet@google.com>
 <CAM0EoMmi0KE6+Nr6E=HqsnMee=8uia57mv0Go8Uu_uNrsVw9Dw@mail.gmail.com>
 <20240418150816.GG3975545@kernel.org>
 <CAM0EoM=Cen-0ctMkBvDL-jsuwPKGetz4yTG+RpmW7dXjjeVaQg@mail.gmail.com>
 <20240419071809.GT3975545@kernel.org>
 <CAM0EoMnLDrpoU21K85fun2ncN3r3ucF3p6ajw0H_-XoEsyDn5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMnLDrpoU21K85fun2ncN3r3ucF3p6ajw0H_-XoEsyDn5w@mail.gmail.com>

On Fri, Apr 19, 2024 at 10:24:52AM -0400, Jamal Hadi Salim wrote:
> On Fri, Apr 19, 2024 at 3:18 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Thu, Apr 18, 2024 at 07:05:08PM -0400, Jamal Hadi Salim wrote:
> > > On Thu, Apr 18, 2024 at 11:08 AM Simon Horman <horms@kernel.org> wrote:
> > > >
> > > > On Thu, Apr 18, 2024 at 06:23:27AM -0400, Jamal Hadi Salim wrote:
> > > > > On Thu, Apr 18, 2024 at 3:32 AM Eric Dumazet <edumazet@google.com> wrote:
> > > > > >
> > > > > > Medium term goal is to implement "tc qdisc show" without needing
> > > > > > to acquire RTNL.
> > > > > >
> > > > > > This first series makes the requested changes in 14 qdisc.
> > > > > >
> > > > > > Notes :
> > > > > >
> > > > > >  - RTNL is still held in "tc qdisc show", more changes are needed.
> > > > > >
> > > > > >  - Qdisc returning many attributes might want/need to provide
> > > > > >    a consistent set of attributes. If that is the case, their
> > > > > >    dump() method could acquire the qdisc spinlock, to pair the
> > > > > >    spinlock acquision in their change() method.
> > > > > >
> > > > >
> > > > > For the series:
> > > > > Reviewed-by: Jamal Hadi Salim<jhs@mojatatu.com>
> > > > >
> > > > > Not a show-stopper, we'll run the tdc tests after (and use this as an
> > > > > opportunity to add more tests if needed).
> > > > > For your next series we'll try to do that after you post.
> > > >
> > > > Hi Jamal,
> > > >
> > > > On the topic of tdc, I noticed the following both
> > > > with and without this series applied. Is this something
> > > > you are aware of?
> > > >
> > > > not ok 990 ce7d - Add mq Qdisc to multi-queue device (4 queues)
> > > >
> > >
> > > Since you said it also happens before Eric's patch, I took a look in
> > > the test and nothing seems to stand out. Which iproute2 version are
> > > you using?
> > > We are running tdc in tandem with net-next (and iproute2-next) via
> > > nipa for a while now and didn't see this problem pop up. So I am
> > > guessing something in your setup?
> >
> > Thanks Jamal,
> >
> > I appreciate you checking this.
> > I agree it seems likely that it relates to my environment.
> > And I'll try out iproute2-next.
> >
> 
> Yeah, that would work although i think what you showed earlier should
> have worked with just iproute2. Actually one thing comes to mind
> noticing you are using tdc.py - that test uses netdevsim. You may have
> to modprobe netdevsim. If you run it via tdc.sh it would probe and
> load it for you

Thanks, tdc.sh seems to work better,
as does invoking TDC via make (which calls tdc.sh).

...


