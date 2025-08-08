Return-Path: <netdev+bounces-212263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D06C8B1EDFD
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 19:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D273A779A
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 17:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDA41E5B6D;
	Fri,  8 Aug 2025 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4YXEO43"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA697199385
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754675020; cv=none; b=SllYU1WSKMqINFkMwc/DVjM0hnt4dUauoCNY7M+BiCqG7ywKcdNG4LHKGbpBKC1g+1Lo7ToTIB3QCkJ9S7UNyv37ZYUZ+fFxFPtLyHfSOuUuwWHvZUSaTlGv0I5yy0+Lo2v/BraNrgAtdsBNS7WAchYjHhQvT3i5gju9gbFS1po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754675020; c=relaxed/simple;
	bh=5kv1IGXIbqBpf3Qi9bhmMq35g6UahFmF7scWWT+Am6o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=siY3m75SmafOUMPeg/MeL9q38rMykAfxrN8NiQoKE6KwtlfAVW36Zyy3Jf50FbVlxTkKb4Ti3COh1/S1/0VuOW3SkrA7kbDN3FdDd/FZeBq+9fC1VcYGms/t8gQO8zrAPxmMLrSSyxvNruv4LABL+Dt22IWExXsJhXcb6JasM0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4YXEO43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD36BC4CEED;
	Fri,  8 Aug 2025 17:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754675020;
	bh=5kv1IGXIbqBpf3Qi9bhmMq35g6UahFmF7scWWT+Am6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X4YXEO43Hr3qsix4/XNSWxiyHKHOsw8OwxqKcUfP9ii4fmXPHjWAmKKFY/Koa/5vO
	 eS/ih+rVtHcMXqtjsq3vwftWRYAHUGWjRgRiZOELOyeSkiqMzsI/pnmXHoNFTXniIu
	 weKxZP78Bw7kSFeMJlAnQOV+Cj4iRAvZGKgprsj5bCUEQUCH8tkM0xRfvQ+rnlg9oi
	 7KigMyQOPTGdfcgYP9Qp8AmNGafKsTKFSeZOgXevNZHk/SlgmnNEoDHNJcUYVSw+kU
	 FpyIpfbleMeRX4lZgAv2yqrUmcgoGlHGK5+CnAXNT4GkPBzDeEKitKD2cpEuxVnXgC
	 KsI3bBy+oUU3A==
Date: Fri, 8 Aug 2025 10:43:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wilder <wilder@us.ibm.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jv@jvosburgh.net"
 <jv@jvosburgh.net>, "pradeeps@linux.vnet.ibm.com"
 <pradeeps@linux.vnet.ibm.com>, Pradeep Satyanarayana <pradeep@us.ibm.com>,
 "i.maximets@ovn.org" <i.maximets@ovn.org>, Adrian Moreno Zapata
 <amorenoz@redhat.com>, Hangbin Liu <haliu@redhat.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "horms@kernel.org" <horms@kernel.org>
Subject: Re: [PATCH net-next v6 7/7] bonding: Selftest and documentation for
 the arp_ip_target parameter.
Message-ID: <20250808104338.1340070d@kernel.org>
In-Reply-To: <MW3PR15MB39137E1CD22773D13515DD5AFA2FA@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250718212430.1968853-1-wilder@us.ibm.com>
	<20250718212430.1968853-8-wilder@us.ibm.com>
	<20250718183313.227c00f4@kernel.org>
	<MW3PR15MB3913774256A62C63A607245EFA5DA@MW3PR15MB3913.namprd15.prod.outlook.com>
	<20250721130800.021609ee@kernel.org>
	<MW3PR15MB39137E1CD22773D13515DD5AFA2FA@MW3PR15MB3913.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Aug 2025 17:32:08 +0000 David Wilder wrote:
> > iproute2 is built from source a month ago, with some pending patches,
> > but not yours. Presumably building from source without your patches
> > should give similar effect (IIRC the patches I applied related
> > to MC routing)
> >  
> > > Can I access the logs from the CI run?  
> >
> > Yes
> >
> > https://netdev.bots.linux.dev/contest.html?pw-n=0&branch=net-next-2025-07-19--00-00 
> >  
> > > Is there a way I can debug in you CI environment?  
> >
> > Not at this point, unfortunately.
> >  
> > > Can I submit debug patches?  
> >
> > https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style   
> 
> I am able to run my tests in this environment, but sadly I still cant reproduce the failure.
> Can you tell me more about the environment you are using for CI?  What version of GCC is used?
> What distro and release is the environment build from?

Not sure the compiler and distro matters here:

the bond options tests prints a bunch of:

# RTNETLINK answers: Message too long
# Cannot send link get request: Message too long
# RTNETLINK answers: Message too long
# Cannot send link get request: Message too long
# Not enough information: "dev" argument is required.
# RTNETLINK answers: Message too long

> I have made some changes to the function that is failing In an attempt to fix the problem.
> If the problem continues with my next version would it be possible to save the build artifacts
> used in the test (vmlinux)?

Right, let's see if the problem persists. I updated iproute2 recently
too, so maybe that will help.

