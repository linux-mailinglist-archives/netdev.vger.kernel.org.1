Return-Path: <netdev+bounces-121420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00C095D0E8
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 17:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8AD28115F
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 15:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428FD189BAE;
	Fri, 23 Aug 2024 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deumfkfy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE8F189B93
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724425375; cv=none; b=eatIzql7tf8yOYUmqbPT4YRa7V/EZwqBC4Jb4aQWb+DFVeiwXPlzDltQ5zeKSmA4jRw7oHwoZB50cS/pbf0KZhJK+yAMJ2n8kh9GFZ1zJfUtNUQM/HdMff2FXJLIXadHUiPVWFmbfsnEILAExkpNE2VIzevsgWDQA36vQUWzScc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724425375; c=relaxed/simple;
	bh=XGdtu95oiuNeihtGxatFEZYsDpcjTktVcAg+bd3nxzA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spj70vxsueFKjarQ7XFbz/cMxU36CvtfkF0RdyX+Y1A4xUAIDxyPl2wCM8syZrDNUMmw7CRSUEssGW74nLWlto8VeUJFgkAAGswB7r+3jIWClvLnqJ0EW/2sFDRLWLMiQksInddS4K+JWpStBp+aWmpcrpSZAw9hFumzbcNJ75Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deumfkfy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78230C32786;
	Fri, 23 Aug 2024 15:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724425374;
	bh=XGdtu95oiuNeihtGxatFEZYsDpcjTktVcAg+bd3nxzA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=deumfkfy25yulsOoSjiJ+TYkL5LWzj14HLGBc7rWXoFNOGrq9lcqIJ7DyO9Q6/dTU
	 J2+fJZRUI6WTRADpoT7eP7S0pVK1ovJZqny/gtVal5JO3+5AhmgoiHONILEl8GdJek
	 ZVHongOHSViuI6De04RK6qEQfLPEuylnAN/aDAW1quwqUFlqGiHy+JB2A2BmSEVae+
	 ECSPSdRrTOW8ybcJx7zCsjpOAqhmdieDBOVwRr5UXAYk4n/KQXQc8hvrWtvgKEN8fU
	 krB6OOahmYXgr0DSXear3EJrQZmpURUM94nxjRp3Vv1pH2d+0G6P9vgPFeY8UCWXVJ
	 bS2izoYOwsrKg==
Date: Fri, 23 Aug 2024 08:02:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Hangbin Liu
 <liuhangbin@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [TEST] forwarding/router_bridge_lag.sh started to flake on
 Monday
Message-ID: <20240823080253.1c11c028@kernel.org>
In-Reply-To: <87a5h3l9q1.fsf@nvidia.com>
References: <20240822083718.140e9e65@kernel.org>
	<87a5h3l9q1.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 13:28:11 +0200 Petr Machata wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> 
> > Looks like forwarding/router_bridge_lag.sh has gotten a lot more flaky
> > this week. It flaked very occasionally (and in a different way) before:
> >
> > https://netdev.bots.linux.dev/contest.html?executor=vmksft-forwarding&test=router-bridge-lag-sh&ld_cnt=250
> >
> > There doesn't seem to be any obvious commit that could have caused this.  
> 
> Hmm:
>     # 3.37 [+0.11] Error: Device is up. Set it down before adding it as a team port.
> 
> How are the tests isolated, are they each run in their own vng, or are
> instances shared? Could it be that the test that runs befor this one
> neglects to take a port down?

Yes, each one has its own VM, but the VM is reused for multiple tests
serially. The "info" file shows which VM was use (thr-id identifies
the worker, vm-id identifies VM within the worker, worker will restart
the VM if it detects a crash).

> In one failure case (I don't see further back or my browser would
> apparently catch fire) the predecessor was no_forwarding.sh, and indeed
> it looks like it raises the ports, but I don't see where it sets them
> back down.
> 
> Then router-bridge-lag's cleanup downs the ports, and on rerun it
> succeeds. The issue would be probabilistic, because no_forwarding does
> not always run before this test, and some tests do not care that the
> ports are up. If that's the root cause, this should fix it:
> 
> From 0baf91dc24b95ae0cadfdf5db05b74888e6a228a Mon Sep 17 00:00:00 2001
> Message-ID: <0baf91dc24b95ae0cadfdf5db05b74888e6a228a.1724413545.git.petrm@nvidia.com>
> From: Petr Machata <petrm@nvidia.com>
> Date: Fri, 23 Aug 2024 14:42:48 +0300
> Subject: [PATCH net-next mlxsw] selftests: forwarding: no_forwarding: Down
>  ports on cleanup
> To: <nbu-linux-internal@nvidia.com>
> 
> This test neglects to put ports down on cleanup. Fix it.
> 
> Fixes: 476a4f05d9b8 ("selftests: forwarding: add a no_forwarding.sh test")
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/no_forwarding.sh | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/forwarding/no_forwarding.sh b/tools/testing/selftests/net/forwarding/no_forwarding.sh
> index af3b398d13f0..9e677aa64a06 100755
> --- a/tools/testing/selftests/net/forwarding/no_forwarding.sh
> +++ b/tools/testing/selftests/net/forwarding/no_forwarding.sh
> @@ -233,6 +233,9 @@ cleanup()
>  {
>  	pre_cleanup
>  
> +	ip link set dev $swp2 down
> +	ip link set dev $swp1 down
> +
>  	h2_destroy
>  	h1_destroy
>  

no_forwarding always runs in thread 0 because it's the slowest tests
and we try to run from the slowest as a basic bin packing heuristic.
Clicking thru the failures I don't see them on thread 0.

But putting the ports down seems like a good cleanup regardless.

