Return-Path: <netdev+bounces-104637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7706190DAF0
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 19:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224291F2158E
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 17:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FD013F44E;
	Tue, 18 Jun 2024 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egkHpZFI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1F11CAB3;
	Tue, 18 Jun 2024 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718732851; cv=none; b=b+bxa2uBJhuaUDzYFP64NA3OBzqQXzRwa2Ad8MQUSEbPvi4hVFHY40IlLOQjCsJjjnDvM3Bcu2QjI2hwpR3Yg7EuEwCOXbPODW1vFVR3rDfju0mO8Il45Eg0l2JaAD2ZzS+lEPh+4zukT/OhK8Ec8Gqax+Sw8xbbg7rFVYsqYfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718732851; c=relaxed/simple;
	bh=633yAjs2IhmwGmjCfOcQoKRzSIRzpZwvXp2QkVvWMwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYk4TlFRW+t7UDIFnCAnl2zXmQD7ZOq7tmzxH+PS7hAmnKTjaUuSCvRaCEvZqe2LI7fysliwOc+pQqa5WX7LUKuk7/ytMM+j4oNynsq8ixjc/kQASF7QMsPqwzLVwRqD7iPUK+9RCL2+ghhgfFQEdOk9U5KJSlJUvKujvateBms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egkHpZFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22623C3277B;
	Tue, 18 Jun 2024 17:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718732851;
	bh=633yAjs2IhmwGmjCfOcQoKRzSIRzpZwvXp2QkVvWMwo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=egkHpZFIxVo1rsb7dPnDVe1BZ/JyNlW5vIKjPcG404Vxrt/lYHMBXXo55UJSzPwbl
	 GzHnXcncys8n2hIytsdBgRJJG4BUQNRoCcrRabke5enVoIPVWmNwg9pORkI96+Bfnd
	 LJWMGYhLCr/JCl+/bHhEEg0+yfS6ayNsNtelq9xWeDTDD7AbkmSY5LwRDUSErqepEF
	 xGwfVoEFTsih1f6CbGtkmPCShJ6yx3afTR/hHJk0uXCuIt3K227YCdSkS0zxVGRTYN
	 /s9QaSl279RdH0gxjyLGKiZJHS0v4ElOevokVDLR4idSzToT4ydLyau9dUV8unaA64
	 siQ3fvwGdKCDA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CC2B4CE05B6; Tue, 18 Jun 2024 10:47:30 -0700 (PDT)
Date: Tue, 18 Jun 2024 10:47:30 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Dmitry Safonov <0x7f454c46@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	rcu@vger.kernel.org
Subject: Re: [TEST] TCP MD5 vs kmemleak
Message-ID: <53632733-ef55-496b-8980-27213da1ac05@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240617072451.1403e1d2@kernel.org>
 <CAJwJo6ZjhLLSiBUntdGT8a6-d5pjdXyVv9AAQ3Yx1W01Nq=dwg@mail.gmail.com>
 <20240618074037.66789717@kernel.org>
 <fae8f7191d50797a435936d41f08df9c83a9d092.camel@redhat.com>
 <ee5a9d15-deaf-40c9-a559-bbc0f11fbe76@paulmck-laptop>
 <20240618100210.16c028e1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618100210.16c028e1@kernel.org>

On Tue, Jun 18, 2024 at 10:02:10AM -0700, Jakub Kicinski wrote:
> On Tue, 18 Jun 2024 09:42:35 -0700 Paul E. McKenney wrote:
> > > FTR, with mptcp self-tests we hit a few kmemleak false positive on RCU
> > > freed pointers, that where addressed by to this patch:
> > > 
> > > commit 5f98fd034ca6fd1ab8c91a3488968a0e9caaabf6
> > > Author: Catalin Marinas <catalin.marinas@arm.com>
> > > Date:   Sat Sep 30 17:46:56 2023 +0000
> > > 
> > >     rcu: kmemleak: Ignore kmemleak false positives when RCU-freeing objects
> > > 
> > > I'm wondering if this is hitting something similar? Possibly due to
> > > lazy RCU callbacks invoked after MSECS_MIN_AGE???  
> 
> Dmitry mentioned this commit, too, but we use the same config for MPTCP
> tests, and while we repro TCP AO failures quite frequently, mptcp
> doesn't seem to have failed once.
> 
> > Fun!  ;-)
> > 
> > This commit handles memory passed to kfree_rcu() and friends, but
> > not memory passed to call_rcu() and friends.  Of course, call_rcu()
> > does not necessarily know the full extent of the memory passed to it,
> > for example, if passed a linked list, call_rcu() will know only about
> > the head of that list.
> > 
> > There are similar challenges with synchronize_rcu() and friends.
> 
> To be clear I think Dmitry was suspecting kfree_rcu(), he mentioned
> call_rcu() as something he was expecting to have a similar issue but 
> it in fact appeared immune.

Whew!!!  ;-)

							Thanx, Paul

