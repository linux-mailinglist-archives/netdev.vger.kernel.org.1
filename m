Return-Path: <netdev+bounces-68250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB178464F6
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 01:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C651C23CC4
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 00:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94841187F;
	Fri,  2 Feb 2024 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxEsatS2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8771874;
	Fri,  2 Feb 2024 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706832983; cv=none; b=jnhl582bJjAQcgKU14i5Di0CqZPdvCupQ3boOthP6Z3dl/j4Dgar/Xru4vrdUexmWXVwy7OaWaIejS79va2KkdmT/oq1AQmzrEHDvnzC3oQ9EHmmVjE4Z4Wij9rduMRl0iRY4q3+5V0ta5pBbWymdR06dKxfB+s4jKFiyQ3B6hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706832983; c=relaxed/simple;
	bh=UBkXQh1+GXm5ayLTLSI5O5X3B6PicUiAC68r0gPBUjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTjBdWUh953b8l9qiaX22UcY4uh5CShceuZpsugxeitBqVeWWFsLRQf11Dwe6NqGpEl5IRPqGbnctoGRvEaevUrblfXxfzKBGQ0OjyAp5FQi9uh3yf2314kxTM8GtKnGEF1NRW1RvZ1qC4LaNIS2ZjdE5Yx+VoOSmxODF0lkQpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxEsatS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3155EC433C7;
	Fri,  2 Feb 2024 00:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706832983;
	bh=UBkXQh1+GXm5ayLTLSI5O5X3B6PicUiAC68r0gPBUjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oxEsatS2GKH5MiSBXnigpAFgyKvSqnrMt13a9MIyo0Q/NPR5US6l5FwvZbimwEQyR
	 wZi1oKSzTMVxsujac5wTcqd+P4pd7nYIfebKA9KLP9fS6h+A33zjGSCjQhC282wsvF
	 T3MSlItzbz2EAraTtD197Fmjrr3tcf1dXOwXleVvwTDIrVFWRm733YsmP4rRko+2Td
	 jWOxKg4wXa4n1NfoLi3kOxwMw0eleXY/wRRMKpi4EElOPFIDXxKm+i/NOaMAGsEjfv
	 FbmWIVw029eGXEGwsklRqFBNBoqSf3cYqEi3I4bwyklCXHE+0VPcPrgwG0/n7rc4dt
	 FBjmkf0qp+veA==
Date: Thu, 1 Feb 2024 16:16:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@idosch.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [TEST] bridge tests (was: net-next is OPEN)
Message-ID: <20240201161619.0d248e4e@kernel.org>
In-Reply-To: <20240201073025.04cc760f@kernel.org>
References: <20240122091612.3f1a3e3d@kernel.org>
	<ZbedgjUqh8cGGcs3@shredder>
	<ZbeeKFke4bQ_NCFd@shredder>
	<20240129070057.62d3f18d@kernel.org>
	<ZbfZwZrqdBieYvPi@shredder>
	<20240129091810.0af6b81a@kernel.org>
	<ZbpJ5s6Lcl5SS3ck@shredder>
	<20240131080137.50870aa4@kernel.org>
	<Zbugr2V8cYdMlSrx@shredder>
	<20240201073025.04cc760f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Feb 2024 07:30:25 -0800 Jakub Kicinski wrote:
> On Thu, 1 Feb 2024 15:46:23 +0200 Ido Schimmel wrote:
> > > selftests-net/test-bridge-neigh-suppress-sh
> > >  - fails across all, so must be the OS rather than the "speed"    
> > 
> > Yes, it's something related to the OS. From the log below:
> > 
> > ```
> >  COMMAND: ip netns exec h1-n8Aaip ndisc6 -q -r 1 -s 2001:db8:1::1 -w 5000 2001:db8:1::2 eth0.10
> >  Raw IPv6 socket: Operation not permitted
> >  TEST: ndisc6                                                        [FAIL]
> >      rc=1, expected 0
> > ```
> > 
> > The test is supposed to be run as root so I'm not sure what this error
> > is about. Do you have something like AppArmor or SELinux running? The
> > program creates an IPv6 raw socket and requires CAP_NET_RAW.  
> 
> Ah, ugh, sorry for the misdirection, you're right.

Confirmed, with the SUID cleared test-bridge-neigh-suppress-sh now
passes on everything with the exception of metal+debug kernel.

