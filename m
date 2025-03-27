Return-Path: <netdev+bounces-177889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9DCA729CF
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 06:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28F416DD9E
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 05:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FB4433B1;
	Thu, 27 Mar 2025 05:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zab0q4SG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079BA1FC8;
	Thu, 27 Mar 2025 05:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743052594; cv=none; b=SqdQT97dDgy8sCSwASYtpHXeao1nYKTckc6x1hFyMSMc7ZADkuZ1lVID4wzBwo7kfjORVnB3qL9iqDEkNXrwVIZOtYdP7eRMctHzQzidxZhOGAnLv20cAHSCQHCiHb+UBSM3ELWoJgnGFqQRzpQNqgp66U6dYvBhlz0vlCX9er4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743052594; c=relaxed/simple;
	bh=p4E3NIWKHCQ7Kh8PS4wy9jAsJGGPr7MV2B4owvu0tVU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VMHA/Ob7Ex47dvrLXu/xc6y89bCo/8eSs42Ksuk6C4HuLnn1hwic4ck7Q/U31tq1EpxGAYRIQzjiSLAwPd0vP+esZ9ztFGpfs5ABdx6giaqjaOHCt/6jNSKqyTfpKntIrxXKcPv8aXPQJqV5sz1e6gdg2zsoqJypHZK0u4rSfkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zab0q4SG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A58C4CEDD;
	Thu, 27 Mar 2025 05:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743052593;
	bh=p4E3NIWKHCQ7Kh8PS4wy9jAsJGGPr7MV2B4owvu0tVU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Zab0q4SGvrBMtgoXJ4fEsv82KssbMczUCWoAPxwGW5Pu+PvN4NGoIuNyb2qf/uaUB
	 ELscolavqsjliNC54ttcIKnHXiyDA+3X8S1sYahvwbL4aKm6uSvr4tU5SAjRMhDYSs
	 00fYmEM7ngcohE3ZVXJ1RV27jVQozC7RSznUxmCPgKNshh+ki5q5YYu8RoY0A6ttHF
	 /qLYctsD78P1349/vAQo4t+ohEGSV+FfKN+lRZ/VX7BzT4x6IWQKDYkcAHNmKOSMax
	 GZZU1RKuMRvL4mlpbwg+uyGhSPHU/qAnmmx4XSF7kffXkg5IGL4p8qHGipPrWJOk6K
	 Vqc13YsS72ZVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7156F380AAFD;
	Thu, 27 Mar 2025 05:17:11 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250326163652.2730264-1-kuba@kernel.org>
References: <20250326163652.2730264-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250326163652.2730264-1-kuba@kernel.org>
X-PR-Tracked-Remote: https://lore.kernel.org/all/20250228132953.78a2b788@canb.auug.org.au/ net/core/dev.c
X-PR-Tracked-Commit-Id: 023b1e9d265ca0662111a9df23d22b4632717a8a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a9239bb4253f9076b5b4b2a1a4e8d7defd77a95
Message-Id: <174305262992.1585001.7193079148343307430.pr-tracker-bot@kernel.org>
Date: Thu, 27 Mar 2025 05:17:09 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 26 Mar 2025 09:36:51 -0700:

> https://lore.kernel.org/all/20250228132953.78a2b788@canb.auug.org.au/ net/core/dev.c

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a9239bb4253f9076b5b4b2a1a4e8d7defd77a95

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

