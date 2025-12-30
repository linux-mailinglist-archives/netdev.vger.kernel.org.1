Return-Path: <netdev+bounces-246375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E688CCEA3E5
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 18:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06168300C35E
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 17:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FBB2C21F0;
	Tue, 30 Dec 2025 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIcZO/Ky"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F030C288520;
	Tue, 30 Dec 2025 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767114128; cv=none; b=KGMx9DyvnR0wWyAoDfBjH3ZNoqsBbEx5MhaeUtDjiOs6Kau1mHWakCYC2D9+d6vTCdxP3XA1DgS7LZJ8ilSoBbiu+xJSPm6oxdPsYSxlP3Ueiyrp7N8li6foEnUBcWYyvraRiphVnJOTuO+tS8264eqIR+3iLNhONpX62SWbvJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767114128; c=relaxed/simple;
	bh=wqm4C7+q0zBXNqzcRvnNiOD3NuzpyG+9SnmtDwSe85s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XSA59HZlfAwFKJKZHVzw3xxaEpqhNvorvVzOmO8XIroBCZjEEzZVCs3OI7mE1f63LgvRpBBTREdjW6iJAk8QhAVaPDklkZyP5N26S7U+thueB76ozqN1NJFRciYix88RDV1IvN/PNPJhYvsO5BuaVmHVeL47fDwsmBq062kxx5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIcZO/Ky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB5DC4CEFB;
	Tue, 30 Dec 2025 17:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767114127;
	bh=wqm4C7+q0zBXNqzcRvnNiOD3NuzpyG+9SnmtDwSe85s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BIcZO/KyuA1DTMrZLftTC58/ddtc8IsuZQ4Sfol0/kcPzLSttV0QKMxMgwgNdrto6
	 YLc+6G/OHknzvriIONotYDIrzrOVaoW8O/d+N1oEb3d/ARqd7rDUiDRFmFrdwsU6ge
	 TskAEEBFJDzyhjq2BP5IZDbPr9Y+8oPy1Bm3pKIjaSR+q6PiIeWIoTzv71aFE8gWe1
	 raLMExBKKVY64SeG+porGDFBFIpAUmCwkIu/JrvQX6SXPb9HiI5PQGlXLFdlH0vU+S
	 gKeDEZKP8l8PTjMkeaWOdv7dtSFGaNRvxEmtBHR/C+K/G6sR27GTtUB7vAOM6B9OGn
	 l/0Q/OACaHvQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2E083809A09;
	Tue, 30 Dec 2025 16:58:50 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.19-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251230143959.325961-1-pabeni@redhat.com>
References: <20251230143959.325961-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251230143959.325961-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.19-rc4
X-PR-Tracked-Commit-Id: 1adaea51c61b52e24e7ab38f7d3eba023b2d050d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dbf8fe85a16a33d6b6bd01f2bc606fc017771465
Message-Id: <176711392958.3304484.14877107117010280464.pr-tracker-bot@kernel.org>
Date: Tue, 30 Dec 2025 16:58:49 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 30 Dec 2025 15:39:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.19-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dbf8fe85a16a33d6b6bd01f2bc606fc017771465

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

