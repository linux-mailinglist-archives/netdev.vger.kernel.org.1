Return-Path: <netdev+bounces-70062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38BB84D7BA
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 03:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F9C1C21433
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 02:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A6214F7F;
	Thu,  8 Feb 2024 02:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uO3qHOSC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F29B33CCF;
	Thu,  8 Feb 2024 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707358313; cv=none; b=nuA0xF8mnsbwAHADRS/x7TQpdFbQNbJTbRUD7nGfwfcmH+c70j24YjN8xflFSIoxgl0YeEX/a2clUru0KLudcJHniwP40yWzOKN76QGW+FqaWtm8wRgraTeY3Rc++6I3COu4Awz11oQ8PVtlPu6Lldtycc1H+nlvPbmj0jWq7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707358313; c=relaxed/simple;
	bh=VfsUtXyakEd6FLXaDYB08yaEI5dMNgSGo1xLMKM7mGI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uHfMkaJB1oe358wdUgstWtVU57vYUKDqQAFRSXUM+oLOjIs+KIrCtmwBqxgdoy+GqbqN83sKXJqkFCToR8mwBBdTOUM2/kBgZoYNve4ewuzaPismZJ+FAr87+MPPvVU2on+S5c6hBWTbx2bCqTZgHZTZOqok/NW5ffbVJJPcVhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uO3qHOSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A70AC433F1;
	Thu,  8 Feb 2024 02:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707358312;
	bh=VfsUtXyakEd6FLXaDYB08yaEI5dMNgSGo1xLMKM7mGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uO3qHOSCMaaU5EnswkYL7JqQMuHx5C24a+IoSrntN7vvOCk2FFmT2TtrNDd8c9Ho6
	 qY+QlK+DwnsITJSWP3MweFF7NNPeEWa4MwNCAqP4Nwh9c+Xm72+v8MbkAk4J01srEe
	 OCkC88ltazPVvEas4t+kKS4oI54G+US3twoN5C/4eeUIPdBrR+i9xb5YWhFrbjMvFL
	 OWtCoACJcd2cd5iK/76LLCNIJs4mJnp5FRBwy+mev7FvmK1TUyWOFPhJrgVi9Yf49w
	 hZ+EmJonwmNDNsHrJOW+Mc3O0xn1o4hgsq+eZQBUETkeOcxYaGpTOaRsLWcddA5LGd
	 1WN0xs0FNWGew==
Date: Wed, 7 Feb 2024 18:11:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [TEST] Wiki / instructions
Message-ID: <20240207181151.6a5dd81a@kernel.org>
In-Reply-To: <f5233a6a-7b89-4b5c-a136-5284440f1951@kernel.org>
References: <20240202093148.33bd2b14@kernel.org>
	<90c6d9b6-0bc4-468a-95fe-ebc2a23fffc1@kernel.org>
	<20240206173705.544f4cb2@kernel.org>
	<bd1462f0-83e9-4c0d-8591-e76eb002fb08@kernel.org>
	<20240207072159.33198b36@kernel.org>
	<f5233a6a-7b89-4b5c-a136-5284440f1951@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Feb 2024 16:59:31 +0100 Matthieu Baerts wrote:
> On 07/02/2024 16:21, Jakub Kicinski wrote:
> > On Wed, 7 Feb 2024 09:50:48 +0100 Matthieu Baerts wrote:  
> >> I was surprised not to see LOCKDEP there, but in fact, it is: it enables
> >> PROVE_LOCKING, which selects LOCKDEP and a few other DEBUG_xxx ones.
> >>
> >> So maybe it is not needed to include the x86 one?  
> > 
> > I'm confused. Now doing:
> > 
> >   make O=built_test defconfig
> >   make O=built_test debug.config
> > 
> > I don't get KASAN but I get LOCKDEP :S Bleh, maybe because of the
> > options vng throws in?  
> 
> Strange, I get both of them on my side.
> 
> Same if I include the two targets:
> 
>   make O=built_test defconfig debug.config

:o Maybe somehow doing it in two separate commands makes a difference?

I tried now and all that's changing without the x86 config is:

-CONFIG_DEBUG_PAGEALLOC=y
-# CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
+# CONFIG_DEBUG_PAGEALLOC is not set

-CONFIG_LOCK_STAT=y
+# CONFIG_LOCK_STAT is not set


I don't know if PAGEALLOC is useful but let's assume it's not important
enough to add the extra config.

> > Just the three? What about KASAN, OBJECT debug, DEBUG_VM etc?
> > As much as we can without going over the 3h limit in the tests :)  
> 
> Sorry, I meant to say: we would use the existing "debug.config" + a new
> "net_debug.config" containing these 3 options (and maybe more that are
> specific to the net tree).

Turns out that if I try with vng DEBUG_VM and KASAN _are_ enabled :(

> >> disable RETPOLINE (+
> >> mitigations=off) not to slow down the tests in already slow envs, and
> >> disable a few components we don't need to accelerate the build and boot:  
> > 
> > RETPOLINE we could kill, agreed  
> 
> I still need to check vrg: is it easy to add kconfig you want to
> enable/disable? Do you need a new file? Should we maintain this file in
> the tree?

Sorry for going in circles. Seems like you were right that we don't
need the x86 debug, so on the debug side all we need is the two
networking options? Can we try to add those to debug.config ?

> >> DRM, SOUND, etc.
> >>
> >> https://github.com/multipath-tcp/mptcp-upstream-virtme-docker/blob/latest/entrypoint.sh#L284  
> > 
> > Yes, vng also adds some stuff we don't need in this area :(  
> 
> With the non-ng virtme, I disable those:
> 
>   -d PCCARD -d MACINTOSH_DRIVERS -d SOUND -d USB_SUPPORT -d NEW_LEDS
>   -d SURFACE_PLATFORMS -d DRM -d FB
> 
> I will check when I will switch to vng to see what else we can disable.
> But on your side, you probably have more CPU resources to compile the
> kernel, and that's fine to keep them :)

Yup!

> >> It is also possible to add some kconfig in the selftests if preferred,
> >> e.g. in
> >>
> >>   ./tools/testing/selftests/net/debug.config  
> > 
> > Would be great if everyone didn't have to go thru this exercise.
> > How about we start sending patches to kernel/configs/debug.config
> > and see if anyone screams at us?  
> 
> I guess the 3 net debug ones could go there indeed.
> 
> Do you want me to try?

Yes, please! (Unless you don't like being screamed at, then I can :))


