Return-Path: <netdev+bounces-118939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7693195395C
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 19:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E9E1F26228
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0527619EECF;
	Thu, 15 Aug 2024 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlqC92sf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32AE1714AC;
	Thu, 15 Aug 2024 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743750; cv=none; b=LjPuiL87NkSkWkr0iFtl8QZL7ZNezYSrTR32l6/m0m4IB5JJNIXRqxrQX/IGxPDnxRQ7gTUocO2RL1kowGjCutrh6Bw5OGVol4vI8I35Y+TmGxb2COvsHKlYREikoI21XB4ogySfdx1wHL0hvp1cYvZhBDOXndq0GFdvSpUscFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743750; c=relaxed/simple;
	bh=rt1IkkLc8OQGWSDrT7AZqB2lC1te1JH6sLIGYiQSmyE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TpT/mKsU12LS2ju743QgT8F0rbQpRaiObR1do8uRVZwTz/Dk1qjyJu3vLf+q9CtMzwKQOWoZ7+7Q0HTNv6gmRc0dgjLuuHip08YyUpb4P4dr4v+9OlPUt9r6b0XpOS5B6E6GOf/OQempu4CdYUX25xTmAsxRLiuNfqwetl4w8DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlqC92sf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFE1C32786;
	Thu, 15 Aug 2024 17:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723743750;
	bh=rt1IkkLc8OQGWSDrT7AZqB2lC1te1JH6sLIGYiQSmyE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dlqC92sfK52J6Qdo/8pRzT87QhWiesPpPW/UnqDdBSGJTECF55xajPoUNFORa0Cwg
	 6PK3OBnkfrJnbJVZ6eF21Lx4p7EecYYtlxQnXWvEhwJxMBBwjcqcLDdONvVYxftNGy
	 pQiaaMRZmndTtT6x146tB8SiNRCdIMuOjQhqGSeOsy7+Ym+r8JwPNEc37iAzF6Z1X1
	 Bq6X4y6PHftaMaphIzdSH/R3+wgmJR4YJUAvt8QOoUOqkBjEebwlIOlEsg0jR0QV76
	 LVIE99UUWIHiPaP7TgS0PxFuHFlPNPd9oRXROICiG8QkHO7bMFW/WZgLGkbde/fVsr
	 H4SLV1QHZgVyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BC9382327A;
	Thu, 15 Aug 2024 17:42:31 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.11-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240815141149.33862-1-pabeni@redhat.com>
References: <20240815141149.33862-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240815141149.33862-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.11-rc4
X-PR-Tracked-Commit-Id: 9c5af2d7dfe18e3a36f85fad8204cd2442ecd82b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4a35f6cbebbf9466b6c412506ab89299d567f51
Message-Id: <172374374965.2961867.4621627917618565082.pr-tracker-bot@kernel.org>
Date: Thu, 15 Aug 2024 17:42:29 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 15 Aug 2024 16:11:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.11-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4a35f6cbebbf9466b6c412506ab89299d567f51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

