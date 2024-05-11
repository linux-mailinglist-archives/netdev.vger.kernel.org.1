Return-Path: <netdev+bounces-95695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F14528C31A3
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 15:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C994281BA8
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 13:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6464151C44;
	Sat, 11 May 2024 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0qrGo69"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9A83D57A
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715434050; cv=none; b=MvbZZ8aQUe2RH+yaam3bTEiK933Xt1UuW1+xkmiek97YnT3C10dDDhq+xyWiTO9mGMHNKU5MRB2YgaHbBL28Yx6QVL+NIl3V0Bijpq+6alXoA0M9aDeN/RWwqsFkizyfs7nlbBVuDblFVF1gDNPOsHBmF5a04LpYL/zgmsKl3Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715434050; c=relaxed/simple;
	bh=QTUJ2PXEvdYLkosG9JX9zxwtR+afpy37xRP35AP4jKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwUYGCMvYNINaacLBQSZw+TFoJsGGm2/KCI12iBQ52B7Ems7t/AzY6rPXsbvdnflgo41EW71CaGZbo/j2LgSy3Vcny8fX71jOUYWc0kxszwfpy5RYjf2f+lv9cYBzakg7LvCh+pIKJIutQ8VV0FvHFOyikKt+0emnxzVwrnxUM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0qrGo69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518FFC2BBFC;
	Sat, 11 May 2024 13:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715434049;
	bh=QTUJ2PXEvdYLkosG9JX9zxwtR+afpy37xRP35AP4jKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l0qrGo69WJalDWOSDlKAlEx1KukQu3J+IAtqbqjV0fXyOk6E2ljUoLKZLkiRnVRXv
	 Ru78uUFLfkc8g+IP3GnljUXE1BCLZqJRPAjfxYZm8ItBIzPHXIlorEcHclHvUhQM6l
	 zxm6f+lYKrRZmF+y42Rg7jUnpGHL+ybOI/rr8UPgOQKRhy1uOdZUYqMV3jeZXlGXlF
	 kKeb9xeca/pv9bQhUM+8shyqAwhu5XZ8jFovFx5hinS/Fll+PXSlNxUTm2VXhCIysV
	 nHw56ewaAQvjIrQGJj0SuNsBUyLcF1653qjk7u1O04ZpMyNI052Hbnc7UAQ5bEBE5v
	 Uc4T4ZgpkJaCw==
Date: Sat, 11 May 2024 14:27:24 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Westphal <fw@strlen.de>, Hangbin Liu <liuhangbin@gmail.com>,
	Jaehee Park <jhpark1013@gmail.com>, Petr Machata <petrm@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>, netdev@vger.kernel.org,
	Aaron Conole <aconole@redhat.com>
Subject: Re: [TEST] Flake report
Message-ID: <20240511132724.GF2347895@kernel.org>
References: <20240509160958.2987ef50@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509160958.2987ef50@kernel.org>

+ Aaron

On Thu, May 09, 2024 at 04:09:58PM -0700, Jakub Kicinski wrote:
> Hi!
> 
> Feels like the efforts to get rid of flaky tests have slowed down a bit,
> so I thought I'd poke people..
> 
> Here's the full list:
> https://netdev.bots.linux.dev/flakes.html?min-flip=0&pw-y=0
> click on test name to get the list of runs and links to outputs.
> 
> As a reminder please see these instructions for repro:
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style
> 
> I'll try to tag folks who touched the tests most recently, but please
> don't hesitate to chime in.
> 
> 
> net
> ---
> 
> arp-ndisc-untracked-subnets-sh
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> To: Jaehee Park <jhpark1013@gmail.com>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> 
> Times out on debug kernels, passes on non-debug.
> This is a real timeout, eats full 7200 seconds.
> 
> xfrm-policy-sh
> ~~~~~~~~~~~~~~
> To: Hangbin Liu <liuhangbin@gmail.com>
> 
> Times out on debug kernels, passed on non-debug,
> This is a "inactivity" timeout, test doesn't print anything
> for 900 seconds so the runner kills it. We can bump the timeout
> but not printing for 15min is bad..
> 
> cmsg-time-sh
> ~~~~~~~~~~~~
> To: Jakub Kicinski <kuba@kernel.org> (forgot I wrote this :D)
> 
> Fails randomly.
> 
> pmtu-sh
> ~~~~~~~
> To: Simon Horman <horms@kernel.org>
> 
> Skipped because it wants full OVS tooling.

My understanding is that Aaron (CCed) is working on addressing
this problem by allowing the test to run without full OVS tooling.

> forwarding
> ----------
> 
> sch-tbf-ets-sh, sch-tbf-prio-sh
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> To: Petr Machata <petrm@nvidia.com>
> 
> These fail way too often on non-debug kernels :(
> Perhaps we can extend the lower bound?
> 
> bridge-igmp-sh, bridge-mld-sh
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> To: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Ido Schimmel <idosch@nvidia.com>
> 
> On debug kernels it always fails with:
> 
> # TEST: IGMPv3 group 239.10.10.10 exclude timeout                     [FAIL]
> # Entry 192.0.2.21 has blocked flag failed
> 
> For MLD:
> 
> # TEST: MLDv2 group ff02::cc exclude timeout                          [FAIL]
> # Entry 2001:db8:1::21 has blocked flag failed
> 
> vxlan-bridge-1d-sh
> ~~~~~~~~~~~~~~~~~~
> To: Ido Schimmel <idosch@nvidia.com>
> Cc: Petr Machata <petrm@nvidia.com>
> 
> Flake fails almost always, with some form of "Expected to capture 0
> packets, got $X"
> 
> mirror-gre-lag-lacp-sh
> ~~~~~~~~~~~~~~~~~~~~~~
> To: Petr Machata <petrm@nvidia.com>
> 
> Often fails on debug with:
> 
> # TEST: mirror to gretap: LAG first slave (skip_hw)                   [FAIL]
> # Expected to capture 10 packets, got 13.
> 
> mirror-gre-vlan-bridge-1q-sh, mirror-gre-bridge-1d-vlan-sh
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> To: Petr Machata <petrm@nvidia.com>
> 
> Same kind of failure as above but less often and both on debug and non-debug.
> 
> tc-actions-sh
> ~~~~~~~~~~~~~
> To: Davide Caratti <dcaratti@redhat.com>
> 
> It triggers a random unhandled interrupt, somehow (look at stderr).
> It's the only test that does that.
> 
> 
> mptcp
> -----
> To: Matthieu Baerts <matttbe@kernel.org>
> 
> simult-flows-sh is still quite flaky :(
> 
> 
> nf
> --
> To: Florian Westphal <fw@strlen.de>
> 
> These are skipped because of some compatibility issues:
> 
>  nft-flowtable-sh, bridge-brouter-sh, nft-audit-sh
> 
> Please LMK if I need to update the CLI tooling. 
> Or is this missing kernel config?
> 

