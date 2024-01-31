Return-Path: <netdev+bounces-67386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835D08432DA
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 02:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60391C25997
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 01:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC38A29;
	Wed, 31 Jan 2024 01:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCHRXQDh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E645223;
	Wed, 31 Jan 2024 01:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706665048; cv=none; b=Gfb0FkaU/6H6D4D0kxG+7tXJ7fS3etq3iT1xCl/nAXZHdW0p6zp8QQo+wUysdeBPfL1J9NBjGgEmfLLqfRADNqJgoCm7tbr3Gt4wDen9PL+duCAMEEgPfL2uDDSc46s7xQ9XCO2SdBSVLO8Sw7iv+zP3RETlK1nIPeXFaffdp0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706665048; c=relaxed/simple;
	bh=4fpIco0fwL2uBKcNiamswrqV+X1z1kDO3RlBBUyKY7E=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDg5pZeO/uT4By5iCkWCxU13fJ6a+glmSo/aMhnTmTJ1YiUYRAWy9k6Weh9kJTEwHKW2SkxK8iX6Bu0IcVZQEInFtQjjCEiXSe9D372sTWjRY2uf3+4gojuCNasnht4TwJlJN0p9VQVMIAHBacDZNO8momSWEKC0cya631d5IL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCHRXQDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58143C433F1;
	Wed, 31 Jan 2024 01:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706665048;
	bh=4fpIco0fwL2uBKcNiamswrqV+X1z1kDO3RlBBUyKY7E=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=YCHRXQDhOedHfBjKfRC/chClmRroF3aQjsSWQB/f6ja87X0DvMk7qKUsGTnJ2NaCv
	 g5j4tauRvY9HgTSYHkLl/VpXmZhJdoUspBqMtUFhvrPfb6jkQdD7a9qNQJicHfjomD
	 79cIJEHEDbsTQ12iEXBszX6MOAKPvuedart9Jxh1acoU368fqUC+UR5y0CoiEQDsgy
	 hVcEhZF0TAyKa9JvDow4E7oTsxXeUrzfPNFIrVIwEtmMDNK5D9BOFEXNZys2K0bxHt
	 VlqBxQ3aHC+nM7iCbhAqj0t63ALvxX2qkNDuasaS4b8Mjoqc8VsAH9HREGimiMWp4m
	 u/KDmuKrBYTrw==
Date: Tue, 30 Jan 2024 17:37:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - Jan 30th
Message-ID: <20240130173724.4dd15077@kernel.org>
In-Reply-To: <20240129112057.26f5fc19@kernel.org>
References: <20240129112057.26f5fc19@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jan 2024 11:20:57 -0800 Jakub Kicinski wrote:
> Hi,
>=20
> The bi-weekly netdev call at https://bbb.lwn.net/b/jak-wkr-seg-hjn
> is scheduled tomorrow at 8:30 am (PT) / 5:30 pm (~EU).
>=20
> We'll certainly go over CI updates, but please feel free to suggest
> other topics!
>=20
> In terms of the review rotation - this week's reviewer is nVidia.

Meeting notes:

 * Tour of the test runner UIs:
   * System status and test summary:
     https://netdev.bots.linux.dev/status.html
   * Example of patchwork reporting (see the netdev/contest check):
     https://patchwork.kernel.org/project/netdevbpf/patch/20240127175033.96=
40-1-linus.luessing@c0d3.blue/
   * Clicking takes us to the list of tests run as part of the branch
     report:
     https://netdev.bots.linux.dev/contest.html?pw-n=3D0&branch=3Dnet-next-=
2024-01-29--21-00
   * Last but not least the UI for flaky tests:
     https://netdev.bots.linux.dev/flakes.html

 * Mojatatu is running TCD on their end, so the remote executor thing
   is working fine. Reminder that the data formats here:
   https://docs.google.com/document/d/1TPlOOvv0GaopC3fzW-wiq8TYpl7rh8Vl_mma=
l0uFeJc/
    * Pedro: TCD executor code is at https://github.com/p4tc-dev/tc-executor

 * What to do about slow tests? Split into a new group? Skip? Export a
   variable to let tests know that the perf is low?
    * Going with the export for now - KSFT_MACHINE_SLOW=3Dyes Tests can
      either adjust their =E2=80=9Cacceptance criteria=E2=80=9D down, or re=
port XFAIL
    * Jesse: some of the perf tests can be tuned down with things like netem
    * Petr: we want them to run on HW as well, so they are kept simple
    * Matthieu: MPTCP selftests auto-detect kernel slow downs
      (kmemleak, lockdep, kasan, prove_locking, etc. by looking at
      kallsyms). We hesitated to add a check for Qemu without KVM but
      we recently modified the selftests to require less resources
    * Willem: how do we deal with latency / timing sensitive tests?
    * Jakub: same approach as perf tests for now, look for the env var

 * HW dependent tests get skipped for veth (ethtool, l3 stats)
    * Petr: goal was to skip cleanly on veth and fail when the env
      misses any tooling etc.
    * Jakub: makes sense but we do have drivers/net/ and could separate
      the tests since they have no chance of running=20
    * Petr: with recent lib.sh changes it should be doable=20

 * The NIPA repo has moved, Netronome has transferred the ownership to
   linux-netdev so we=E2=80=99ll use https://github.com/linux-netdev/nipa g=
oing
   forward.

