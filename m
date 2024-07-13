Return-Path: <netdev+bounces-111180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288E2930315
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 03:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A89B22800
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 01:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F030101D5;
	Sat, 13 Jul 2024 01:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgGMpIJ7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FB9DDA9;
	Sat, 13 Jul 2024 01:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720834898; cv=none; b=tRl6prK3R1ORv2M65BhVegiUECIl2XUaJngZvpBJlSlzVQHb+ZgzAOeNU5EnEnUXIwZKppuSByhxS67o9psEPBC9cr++5xonRwh5KxKBLjNtTDeI20inr2cKQM9f7Ssj8v7ubJ5cR551Bnoz94+zyR7d7KsE2u8PkvlJi0OYPd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720834898; c=relaxed/simple;
	bh=PvE+SFwHH1lDvhrQfoloz/zZcnNJ6717ne2V2bvaArs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZHQpidW4h3I2OKVdY28A7zsF6IrT8SiMkuR2j/pe7W5TI65JKjFD4KrFhlM+PyPi3XkGudNeVCPe1mw6e2LVS//NePV6wR/C/fXPqGYlsuzTMhv9nTYgETmk3vr1PHI92zdWSRcHiO+puRKosQ5qgEa+MxHEXHv5urUR/1kPqBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgGMpIJ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F017BC32782;
	Sat, 13 Jul 2024 01:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720834898;
	bh=PvE+SFwHH1lDvhrQfoloz/zZcnNJ6717ne2V2bvaArs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RgGMpIJ7nJkNstzT61UrRWmSI1yVVDvR+qUVL3epeCmfoNLLNASXfbhj7P10V8be1
	 1Hqd9BnUP+gp5JPMHngZPCLPkLb+aOYdp8Z2wBLu2iV8K4GniOlGpdfomIdMGhiZN6
	 lNiraJOhodhtpS7S6lZWs/vnaRi9ut7B+3x07nWvoeHGrysEUVRBG/17moWaDqte/G
	 dSspBcS8Z2d7mb6ECZ7Rqtsc8ArrTwFhyK7dIPKPCsUMmpsneqSAcNzD55UflpoYEJ
	 O3BiMH7c3lGppJuo/G9RDgetvaMoHdxIxBGPCDwMW9Bsn7btYz8/PNO6Ae6MVKtqdH
	 ORM4nt5FTCBAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E56BFC43153;
	Sat, 13 Jul 2024 01:41:37 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.10-rc8 (follow up)
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240713012205.4143828-1-kuba@kernel.org>
References: <20240713012205.4143828-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240713012205.4143828-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc8-2
X-PR-Tracked-Commit-Id: f7ce5eb2cb7993e4417642ac28713a063123461f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 528dd46d0fc35c0176257a13a27d41e44fcc6cb3
Message-Id: <172083489793.19838.14996739004174924773.pr-tracker-bot@kernel.org>
Date: Sat, 13 Jul 2024 01:41:37 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jul 2024 18:22:05 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/528dd46d0fc35c0176257a13a27d41e44fcc6cb3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

