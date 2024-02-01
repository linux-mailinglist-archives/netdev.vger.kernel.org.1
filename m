Return-Path: <netdev+bounces-68066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08C8845B99
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134941C2AAA8
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB68D5F49D;
	Thu,  1 Feb 2024 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYETiatj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61555D491;
	Thu,  1 Feb 2024 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801426; cv=none; b=PUdEaKcn5YvyuzT4LyisQDN58Uo0pGmdGQ6FyP4alTMCIMsPP/+CtQ315BO/3SD9rL6MbJO606ka9h5cm0fvxjpOrhCPuv6uwSPZa+cYXru4MQsan9sPVyq7ADK5n69xrEfutlscAC8Xei3h6EALD+xI4KFY2bFvXSYai54Wvd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801426; c=relaxed/simple;
	bh=xceulkYfDAadfN1Y30L2KWVd+6M7JYDlbptJWHwd6qk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/Pf+zhSN3yECsYYuVv5kVOEC7/iaM10xjyrMF83/OtVmsfx+XMLcjZsChvcKscAOFCqYRDF/zjKt9UhvBsKYzvtYxD8jzQk+ue/kqdKPisqviScxubVhJxMrgLW7cYshkAJv9NAKy7E+aJMIqVgEJX+11/R2PVT7hvmK+Us+mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYETiatj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20ACEC433F1;
	Thu,  1 Feb 2024 15:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706801426;
	bh=xceulkYfDAadfN1Y30L2KWVd+6M7JYDlbptJWHwd6qk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FYETiatjbY9I/PQcLJAKO9PysbLp+inQWjecHGGpC1b1EleT3R0+alpM/Z+zIIdmu
	 ITnbEGZngHgREZ1Zrrc0KE3jD91C15TcJk1Y6Lz/WwpowS8ccBRztTKsU8ONF5dh2J
	 expaB3X2QbF20MTQnI74Ou3FpbM7KzZ7R8xTIfncyRe6FGiGluveHbE4a97iXLWUaR
	 RiDIkCWcdhENRUVtA7IQuoWa7dZegvcpXkOc/rr0w4HTQMFyuaSzn1+/VUpSOB9C2L
	 6W8aQiPxVDPWtBBX1IUN74eET7dUhkjMAJXw2jL5Q5InD2xYYkUwJgHSa8w5lekFUR
	 zR/yXToVzC+eQ==
Date: Thu, 1 Feb 2024 07:30:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@idosch.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [TEST] bridge tests (was: net-next is OPEN)
Message-ID: <20240201073025.04cc760f@kernel.org>
In-Reply-To: <Zbugr2V8cYdMlSrx@shredder>
References: <20240122091612.3f1a3e3d@kernel.org>
	<ZbedgjUqh8cGGcs3@shredder>
	<ZbeeKFke4bQ_NCFd@shredder>
	<20240129070057.62d3f18d@kernel.org>
	<ZbfZwZrqdBieYvPi@shredder>
	<20240129091810.0af6b81a@kernel.org>
	<ZbpJ5s6Lcl5SS3ck@shredder>
	<20240131080137.50870aa4@kernel.org>
	<Zbugr2V8cYdMlSrx@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Feb 2024 15:46:23 +0200 Ido Schimmel wrote:
> > selftests-net/test-bridge-neigh-suppress-sh
> >  - fails across all, so must be the OS rather than the "speed"  
> 
> Yes, it's something related to the OS. From the log below:
> 
> ```
>  COMMAND: ip netns exec h1-n8Aaip ndisc6 -q -r 1 -s 2001:db8:1::1 -w 5000 2001:db8:1::2 eth0.10
>  Raw IPv6 socket: Operation not permitted
>  TEST: ndisc6                                                        [FAIL]
>      rc=1, expected 0
> ```
> 
> The test is supposed to be run as root so I'm not sure what this error
> is about. Do you have something like AppArmor or SELinux running? The
> program creates an IPv6 raw socket and requires CAP_NET_RAW.

Ah, ugh, sorry for the misdirection, you're right.

Looks like the binaries have SUID set:

# find tools/fs/ -perm -4000
tools/fs/usr/bin/ndisc6
tools/fs/usr/bin/rdisc6
tools/fs/usr/bin/rltraceroute6

But I install them as a normal user:

# ll tools/fs/usr/bin/ndisc6
-rwsr-xr-x. 1 virtme virtme 53840 Jan 29 14:36 tools/fs/usr/bin/ndisc6

so I guess they intend to SUID themselves into privileges but end up
SUIDing out to a lowly user :(

I cleared the SUID bits out, let's see the next run.

