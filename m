Return-Path: <netdev+bounces-226456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3857BA0A51
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 18:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1EE35635F4
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 16:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA873074A2;
	Thu, 25 Sep 2025 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNlq7oDQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABE9307486;
	Thu, 25 Sep 2025 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818254; cv=none; b=J3MkC2Svvn62ith7asR7AtyK1/66fnO+RlwXnGnIFfte7VkOPG/G+FhNal93qzs7C+ttxL7nqny+yJEI3MSlwOnFWczipJ6f4MyuxnM3YJsdoHVgkRsglzwqCrT3YqlcpTFMAL9yrzZe76cgHBDCRzkJH3Qr/dWH+l06Cx1uShQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818254; c=relaxed/simple;
	bh=1gSQv4QmxAoKsbHbwYEIx/ZxaOLQYeGxPYQ662Gucck=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Sfa1jxZGsF5Q2G4bGV2fAuFeLVjTSU3oTLQokzGQUD3PbxBiSXYYoYR4pOz3A/k8BQAjvkNGfVeYmLfvoL6AscLs2vqfdq9RSbe2qzPoivDfv6dLEShZa/bYhgP86JJCc+OuIAROJCoZ27gqd7G/hIXxHRz7YE0hlM204UFPpjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNlq7oDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7931C4CEF0;
	Thu, 25 Sep 2025 16:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758818253;
	bh=1gSQv4QmxAoKsbHbwYEIx/ZxaOLQYeGxPYQ662Gucck=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iNlq7oDQn2ozbHkHgzG+XavUGWR4Z5mONsonQjzSx0SI9sATvO1P9EMEbRp4jtaCV
	 yUtAOv1m7zHBqWkDkRZx7XcgF81B/Hf/KkkX9t0160/A14DEtgEOk6EiUtMlEXJTJy
	 dM06lWRoxhuMVfZ9hv0kxoCW0zodZt/DFbxzlK7G9yFMDrar1OMu2x1Dy0D4CJRLIQ
	 YiQGSn2E4LGE5dEX+ege53R0TyxxWDne9BrGagf7zB/UqBfxN1qdQGHT2h2YbsNKSZ
	 9kqnDGYP0DmN7PIuWv8LbpY03ZE1DRAX/59bC2ld+LkkhUu0qtuGMFHoxF1TaaStLy
	 nqAOS/ZJG+GAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4A039D0C9F;
	Thu, 25 Sep 2025 16:37:30 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.17-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250925132502.65191-1-pabeni@redhat.com>
References: <20250925132502.65191-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250925132502.65191-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc8
X-PR-Tracked-Commit-Id: d9c70e93ec5988ab07ad2a92d9f9d12867f02c56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ff71af020ae59ae2d83b174646fc2ad9fcd4dc4
Message-Id: <175881824940.3435360.18051066556185859893.pr-tracker-bot@kernel.org>
Date: Thu, 25 Sep 2025 16:37:29 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Sep 2025 15:25:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ff71af020ae59ae2d83b174646fc2ad9fcd4dc4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

