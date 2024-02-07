Return-Path: <netdev+bounces-69869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A891F84CDE0
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2980CB26816
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF287F7D0;
	Wed,  7 Feb 2024 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqMY2OyT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51597F7C6;
	Wed,  7 Feb 2024 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707319320; cv=none; b=Q8G97GDu/MCkcwTbQOGz7C19vN8liqKJwQgedUeD+tFRZsLPU96uadZMK3LRMl6Xfl3uxwGtg/MzEJuYJBlo/gGaso7BSM+7PPH4KSjZbRSLCOoibW9VVuC8fNuXLD/Ztr4RfuEwb7vQD8jUNmi4eJ5eChcyTc1mL0fE1bAo7R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707319320; c=relaxed/simple;
	bh=z7IPsluCXxCfmlSGeCS3/GTC8URofvjWC7nXvlEt9js=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GmMJw1EXAf5JhjO1ItuCT8eN//a4bG4QMSYkWdhTD0vglFbclDSLy+0XCcN7UEaP0+FdvGMP/OSwbCjEOcphTXbDq+bf6Y6fBFV65Blzldz+deqrcyhHAMHRf4PjJtSx5ZAcdfASE22nlNu3rzzheGX74pDgG2ZO25gPtVJOiVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqMY2OyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FDFC433C7;
	Wed,  7 Feb 2024 15:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707319320;
	bh=z7IPsluCXxCfmlSGeCS3/GTC8URofvjWC7nXvlEt9js=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MqMY2OyTcYKFAH2ZRHDmCtBVMUH0BXGZutzCkeNI/5D1UN97LI+9MB39ImPVp1cpm
	 8IEgWVh/wgDMBV8wXp5G9R3jbhdVqUoGWInmVqNgJmdUzNU5AqQDUJbrcHGmN68BOP
	 b3ehU0Fke0ZvkhPREnRHPXNRmimAuXjtiJaUktzHfrfyRqcF1rYGtwhhL3Bjn6UT4T
	 3fWgLTIJ09N8EXO1d7fGyPY1kniyVYkU3ophJUIuFGdleE6R6S2LLLJMsgd/T1ZooJ
	 1H5jomiWbMZTw5DytR05t2FdAcr0Ri8I/ZPCLdq4m/wkn1QPipoOo3cCJhAVl3Bjgx
	 5spn/+c5F+9LA==
Date: Wed, 7 Feb 2024 07:21:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [TEST] Wiki / instructions
Message-ID: <20240207072159.33198b36@kernel.org>
In-Reply-To: <bd1462f0-83e9-4c0d-8591-e76eb002fb08@kernel.org>
References: <20240202093148.33bd2b14@kernel.org>
	<90c6d9b6-0bc4-468a-95fe-ebc2a23fffc1@kernel.org>
	<20240206173705.544f4cb2@kernel.org>
	<bd1462f0-83e9-4c0d-8591-e76eb002fb08@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Feb 2024 09:50:48 +0100 Matthieu Baerts wrote:
> On 07/02/2024 02:37, Jakub Kicinski wrote:
> > On Mon, 5 Feb 2024 18:21:56 +0100 Matthieu Baerts wrote:  
> >> Thank you for this wiki page, and all the work with the CI infrastructure!
> >>
> >> For the debug options, I see that you are using:
> >>
> >>   kernel/configs/x86_debug.config
> >>
> >> It looks like this is specific for the 'tip' tree:
> >>
> >>   Debugging options for tip tree testing
> >>
> >> I don't know if it is still maintained, e.g. it includes DEBUG_SLAB
> >> option. But also, it enables options that are maybe not needed: GCOV?
> >> X86_DEBUG_FPU?
> >> Maybe it is better not to use this .config file, no?  
> > 
> > I haven't looked to closely. I noticed that the basic debug config
> > doesn't enable LOCKDEP ?! so I put the x86 one on top.  
> 
> I was surprised not to see LOCKDEP there, but in fact, it is: it enables
> PROVE_LOCKING, which selects LOCKDEP and a few other DEBUG_xxx ones.
> 
> So maybe it is not needed to include the x86 one?

I'm confused. Now doing:

  make O=built_test defconfig
  make O=built_test debug.config

I don't get KASAN but I get LOCKDEP :S Bleh, maybe because of the
options vng throws in?

> > I added a local patch to cut out all the obviously pointless stuff from
> > x86_debug.config  
> 
> Thank you!
> 
> > we should probably start our own config for networking
> > at some stage.  
> 
> Good idea!
> 
> On our side, we always enable DEBUG_NET, and the "debug" environment
> also has NET_NS_REFCNT_TRACKER. We should probably enable
> NET_DEV_REFCNT_TRACKER too.
> 
> Do you want me to add a new file in "kernel/configs" for net including
> these 3 options?

Just the three? What about KASAN, OBJECT debug, DEBUG_VM etc?
As much as we can without going over the 3h limit in the tests :)

> Not directly related to "Net", we also enable DEBUG_INFO (+ compressed)
> everywhere

We have debug_info, maybe vng adds it..

> + KFENCE in the "non-debug" env only,

We could do KFENCE I guess. I'm a bit surprised it's not on by default
for x86. My first choice would be to try to change that..

> disable RETPOLINE (+
> mitigations=off) not to slow down the tests in already slow envs, and
> disable a few components we don't need to accelerate the build and boot:

RETPOLINE we could kill, agreed

> DRM, SOUND, etc.
> 
> https://github.com/multipath-tcp/mptcp-upstream-virtme-docker/blob/latest/entrypoint.sh#L284

Yes, vng also adds some stuff we don't need in this area :(

> It is also possible to add some kconfig in the selftests if preferred,
> e.g. in
> 
>   ./tools/testing/selftests/net/debug.config

Would be great if everyone didn't have to go thru this exercise.
How about we start sending patches to kernel/configs/debug.config
and see if anyone screams at us?

> >> For our CI validating MPTCP tests in a "debug" mode, we use
> >> "debug.config" without "x86_debug.config". On top of that, we also
> >> disable "SLUB_DEBUG_ON", because the impact on the perf is too
> >> important, especially with slow environments. We think it is not worth
> >> it for our case. You don't have the same hardware, but if you have perf
> >> issues, don't hesitate to do the same ;)  
> > 
> > The mptcp tests take <60min to run with debug enabled, and just 
> > a single thread / VM. I think that's fine for now. But thanks for 
> > the heads up that SLUB_DEBUG_ON is problematic, for it may matter for
> > forwarding or net tests.  
> 
> The longest MPTCP selftest is currently stopped after 30 minutes due to
> the selftest timeout. I will see what we can do. That's not just because
> of SLUB_DEBUG_ON, that's normal to be very slow in such particular env.

I'll 2x the timeouts before reporting debug to patchwork, so don't
worry about it, yet. 

