Return-Path: <netdev+bounces-243492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC65ECA23BB
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 04:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89BEE307844B
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 03:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A207D32C945;
	Thu,  4 Dec 2025 02:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiN0pxyR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7978032C93F;
	Thu,  4 Dec 2025 02:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764816788; cv=none; b=mzb64t2wp2ZABtMqrjUXSPzz3H0gSPhpzB7hXOX4KZo489/fS0HocMV7z8RtZsPGwZWujadczJsZNBEVSRFz5deldaVrHpHFgsc2TBvIuciTO9i/b4qoEIWnpAh2c7TAoqyXLOqCHwNyXsmsdi+1A2iRsIDrHdC2i41pqYYG4Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764816788; c=relaxed/simple;
	bh=DbjcnF0XNFF5Io2y/eB/9WX52+xarb2/033zGekeLfI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=s+32RwQVB+NSrw1x6//Vo8sJ0uFMZtYXbYNuP+DJUFzjeOQO6v6zsmc8x8U8L8q63FZEU/Hbp9M19K8xbrAZZfFSb+WVy/RnnKDE56w1Lxz+60Cus713dxstiCKdTVqJz39CZwcxAKk8xUMUleeXJZtmrhUGGLAItNV8iZ6CmrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiN0pxyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B9EC113D0;
	Thu,  4 Dec 2025 02:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764816788;
	bh=DbjcnF0XNFF5Io2y/eB/9WX52+xarb2/033zGekeLfI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oiN0pxyRCV+r0Er5keHQxbakcMU9gVHbXaa77r9lbtlMTp0zHIKc0/MI03dXUJyCz
	 fs6CTJxS2QWZAGmoUjPKcK8bAq2A0q/BFW3Xh9km81YyIoL52pVmTUL0TMKs6IbBvA
	 Mmc+Vu5sFsfEntflXkBGIX12GhB8LunC5DsVk/RS/ujUKrNTD7mm8ixkKshijD6n7b
	 iZOJjmiYY6PKgrxHz5g+tXbsqEMt3bCcI+QvJoN6b9fIy3kvscoP6RBqiTRtMWGdNG
	 TJcYgEQqyKJ8jTjVeCCIJcuJK6Fzd4g+AvLOD5zdWqR69hiTCUgsxfLnR6+LGRpty1
	 nKimIKvo1gOKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 210F93AA9A84;
	Thu,  4 Dec 2025 02:50:08 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for Linux 6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251202234943.2312938-1-kuba@kernel.org>
References: <20251202234943.2312938-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251202234943.2312938-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.19
X-PR-Tracked-Commit-Id: 4de44542991ed4cb8c9fb2ccd766d6e6015101b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f7aa3d3c7323f4ca2768a9e74ebbe359c4f8f88
Message-Id: <176481660684.180085.8778785727918104321.pr-tracker-bot@kernel.org>
Date: Thu, 04 Dec 2025 02:50:06 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  2 Dec 2025 15:49:43 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f7aa3d3c7323f4ca2768a9e74ebbe359c4f8f88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

