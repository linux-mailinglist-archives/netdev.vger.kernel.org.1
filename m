Return-Path: <netdev+bounces-168247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5672A3E3EE
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 19:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A79C19C2D02
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C903F2135B9;
	Thu, 20 Feb 2025 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mE70Hejy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AA41B4259;
	Thu, 20 Feb 2025 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740076368; cv=none; b=kcDy0wTbYdxNMnDGsK7anJF2GF9FEfOPx8rgGjQJ4alKd65d2/wySaARvaBYk9pQ4frN4JzuPmlopqFSbl2UayRQlWlUUBvGhAqnYuFqrRXuXEFh2Mz/nKqaTOVK9u79coyB/R4Qzxh11n9Jrg5c8z3LCHkRvnmqIIq8XSQPmLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740076368; c=relaxed/simple;
	bh=B4S/+9lzX6SHv9NS31A8A0/WdqnWoKEIeWmgKoBnjrg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Y0qK3Z2Fn0GlXeisMHMGQdtzgA9o81dZUqJv4WEA8aXmUgYvXhwvSKmXuchcFNGz1oDVFtruj19TSB8N54e+Ifo5Q+2KAIhzuJxDPPAIKFStbb7ZRa9K0FvYfN0E4miHWDKsRmlfvwmzXaabXY9zeW4ijfL3GelTDV6MC70lTKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mE70Hejy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C18EC4CED1;
	Thu, 20 Feb 2025 18:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740076368;
	bh=B4S/+9lzX6SHv9NS31A8A0/WdqnWoKEIeWmgKoBnjrg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mE70HejyHbrump5mRCSFHjFxrGKD3WR+4Ddt0ZdhGYBI7lvoSyueDqu1fcT0tW968
	 mm4R4UfodeYetUABu3I5DIrlEY6ujtl1THtnWdNZnF0S1hdRPOppsp56X3sMyigc6R
	 JBM9y7hnMO2syNMAXw+nDBKgd8AzSvJb+oC/BIA70LgOxwRdcHiXIVX+yYUjAu9aI/
	 zCOEE/RHHDnroN74g+JS/wDjN7f5h3BFRoV7sZ5PULYjCEtI/AR++1eYfm5hLNl4n/
	 vaTn6XXF/sd29unL7BeyN9x6e3/TpNoUu7zQX29jlPRD4EeEzwSuqkqGzrW26FFueB
	 44C1US33eAnRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71098380CEE2;
	Thu, 20 Feb 2025 18:33:20 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.14-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250220112033.26001-1-pabeni@redhat.com>
References: <20250220112033.26001-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250220112033.26001-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.14-rc4
X-PR-Tracked-Commit-Id: dd3188ddc4c49cb234b82439693121d2c1c69c38
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27eddbf3449026a73d6ed52d55b192bfcf526a03
Message-Id: <174007639913.1419987.8628797914755252836.pr-tracker-bot@kernel.org>
Date: Thu, 20 Feb 2025 18:33:19 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 20 Feb 2025 12:20:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.14-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27eddbf3449026a73d6ed52d55b192bfcf526a03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

