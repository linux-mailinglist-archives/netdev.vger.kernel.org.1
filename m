Return-Path: <netdev+bounces-97053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1AD8C8F4D
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 04:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75C69B21E3F
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 02:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500AD1A2C08;
	Sat, 18 May 2024 02:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsBUigJd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27474523A;
	Sat, 18 May 2024 02:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715997707; cv=none; b=bvndOWJ0FTWmrW6ppFjMc9FMWiBOUlCERqrVs9GLLi9ouVRj4H4o/mVh2fPBl4DtS2VSwdEoguES49riKcza9B+OkpJFylKPmS3EeFkQaRZlFJ2tj+PBnm36K1zXllLJSg+vOmxxmTvJx9D8Z1su+pZ8YFlJBipHNjSP1PXt07U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715997707; c=relaxed/simple;
	bh=xttDd2JHa+gLInCcVGcrYU15XhmhoFhMYmE9N2iZ5FA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=P4/uteKgtQwius5MRWt4MUZTL2232aW3NpTgQSRi6ov6sZ6XVRl4KWHQa5DhCwZnpvkgdC/C+f/tSZWXtB+2aV/p3M9wWuOEpGBbjlngpkqNci5NK0a2I1D6hft10BfR8BwH9LyqltpNttQv5FQPvSrHGhm/ndjAXDLLNPzJPis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsBUigJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6F5CC2BD10;
	Sat, 18 May 2024 02:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715997706;
	bh=xttDd2JHa+gLInCcVGcrYU15XhmhoFhMYmE9N2iZ5FA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dsBUigJdKCZJIzPa5aDqZLWabvk4OtISnJZ8z4Wwpbi9yXk/OAomYYbXWp03XNZ0q
	 i3P39kXIMtlRT/OSEaQ8JOxz+BjA7NWQ20eylc5rlJwy1CZqC4A/567pWAMpljl77S
	 omfHJZ4wOB/BVn2C8ygQ5sW9+/DP38azblMll4XrBfL3RV55p4Xj50cIwXhvEVIIcO
	 UFCzl4AyqR28enkfjHjJqE/xAR8lC874RB1c2+CHMyXTxWosnH5fCWppaNop1MZXzD
	 veh05nE6Z2EHS4u2Y/6z2gPcPatWsaxQM3cBSdJfF7YhjhnIiExaZJUaiaMwL/Z7gA
	 jLZCQ294dbuwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B19BC54BB2;
	Sat, 18 May 2024 02:01:46 +0000 (UTC)
Subject: Re: [GIT PULL] Networking merge window fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240517201425.3080823-1-kuba@kernel.org>
References: <20240517201425.3080823-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240517201425.3080823-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc0
X-PR-Tracked-Commit-Id: fe56d6e4a99a40f50e64d5a8043f1fa838b1f7a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f08a1e912d3e60bf3028ea1c5199a609d12cd37c
Message-Id: <171599770662.28211.5212894364330214442.pr-tracker-bot@kernel.org>
Date: Sat, 18 May 2024 02:01:46 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 May 2024 13:14:25 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f08a1e912d3e60bf3028ea1c5199a609d12cd37c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

