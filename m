Return-Path: <netdev+bounces-136697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C046C9A2B0E
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73D48B27357
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CDF1DED72;
	Thu, 17 Oct 2024 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRzwpLuZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE2C1DE2C8;
	Thu, 17 Oct 2024 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186449; cv=none; b=VmI3PuO44CGFM19DQGUSm1Qwh2Y0F0n172hZWaZlihDy6Vv22JHYJOuIbktAQLYtLuHGON2qShdl5hmpTZYoGrdFc92zXRdEraSM7q0g5NUDZs6PoMqSRQgjTblOtfswqkeuVTMmWH462OrX13oWel9zxHBKOgJgXv4itUdabeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186449; c=relaxed/simple;
	bh=MqrkkQQGRqAfpy7/nFzbsS6TGXXxkiPBzZtNmQpj0aI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=D9kKCZeHSk+lM3lYnAStWElhKWIElS8bdMT/8HCnsKTvYo4Sl2fjKf6k0OW8d73OibXtY37lJj+dY1WLQYNpbJ5xj4Qv2b1Q9zNm5RD6I6bqf1+K5JWZCSV53q3XxQHDkuuEP3s+hTxh6B7EN1Py6ZqfF2cGzBY9UqFKXLmtQzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRzwpLuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00EEC4CECD;
	Thu, 17 Oct 2024 17:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729186449;
	bh=MqrkkQQGRqAfpy7/nFzbsS6TGXXxkiPBzZtNmQpj0aI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VRzwpLuZEUZBkJcVNV2PLoXrKU7tO+g8hnwdtoyPWdvt+ZM9iGQyiRwbVAKO85ZKE
	 +LLfxQUTD1bJt3umKeSZmJYi8mhczQDV6YLz0HmXztb4Z18PcVZwEyma7xZ7v+K1lQ
	 +t1Ast3SRWmFbc/J/6QZ+60pQyFCFpPq23h88av8TCRuaHQFSiepRTe+B3T1FDzeiy
	 nxuIZojYWjHSZ/CGwR1GnZt2IHdlaJGYALyBUXYhgxWanhrFt8EZzpt5m7Vt4UM8Gn
	 CiYsXYgswxOPVHuEsyDzrCwdA/gZ1hw1LCa1noyXXh3jbBKOgoVKRz624fUwg3fhCw
	 i9hJNpuKktNRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD253809A8A;
	Thu, 17 Oct 2024 17:34:15 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.12-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241017132022.37781-1-pabeni@redhat.com>
References: <20241017132022.37781-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241017132022.37781-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.12-rc4
X-PR-Tracked-Commit-Id: cb560795c8c2ceca1d36a95f0d1b2eafc4074e37
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 07d6bf634bc8f93caf8920c9d61df761645336e2
Message-Id: <172918645421.2551340.6159081738405022867.pr-tracker-bot@kernel.org>
Date: Thu, 17 Oct 2024 17:34:14 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 17 Oct 2024 15:20:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.12-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/07d6bf634bc8f93caf8920c9d61df761645336e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

