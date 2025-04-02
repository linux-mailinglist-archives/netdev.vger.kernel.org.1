Return-Path: <netdev+bounces-178721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C17F7A786B6
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 05:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7CF1891A5B
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 03:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800D22CCC5;
	Wed,  2 Apr 2025 03:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPfBA/u7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5926C3FC7;
	Wed,  2 Apr 2025 03:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743563060; cv=none; b=D2umjyzgtZlzibYDJR6YY70HdsiYsyBq+4PbLUXvpKp6KwJ0WSaQPZK+kz69hSIqM50YuqjSaZWD281UJdGoudNRpLWb55IO+o9OCNjvvWXrApGHRfHOGNi7W56uMTPPNH5AHgisGe7IhmxqU7EfooGvYwiemnfksvqIt7UMkFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743563060; c=relaxed/simple;
	bh=fGHXr/TsofQin0xRoBxOFesC5oGaNoA9sMhF7DasFEM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AsN2ssxxtcm464BXHxtaZB7SpKmz8bHpd8w5o7h7D08zKDgKXpGvnA+9itlZOPM+lRir5eyErlifAwGGY/xmFAxZofJ/F3hxIDd5sIkK8QywZvY4opMko/ZpnazjGiI1leh3h/TThs3ASafZ5ce3hU6ppp4bxFVZFQCb6mXp6aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPfBA/u7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC57C4CEE4;
	Wed,  2 Apr 2025 03:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743563060;
	bh=fGHXr/TsofQin0xRoBxOFesC5oGaNoA9sMhF7DasFEM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RPfBA/u7y8nX1twpX96hPRJVUhf8PtSgExT40d+k+Acr/LAtIp/p+WYcnoSi3P0uB
	 SGoVPUBuHtEmB5oUDZrSjwBna0QJkf9tZA47S9yxyON6PLmy68500611eTOJxnyEA4
	 wMHh5ZRtKP6c1iPOYSPBsOxKaQMgX+NcVte/8odM73jTe/HQw9wWkFKG/KBJ5U8gdj
	 3SYSgvq43Ijpq9/0W2umIB5uCzqSgp/jE2D/QzHEoX5/hY0ekyGwU1GZTJhVnyGX2R
	 GYcehQuZEZ+qLanwXMzeIwhxZRQ5y+xzZ42jBis1EQ3JJCKMAWWJsEyU0lKHTqDmgP
	 AF3hvDrtfUuHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3457F380AAFD;
	Wed,  2 Apr 2025 03:04:58 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.15-rc0
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250401001043.787834-1-kuba@kernel.org>
References: <20250401001043.787834-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250401001043.787834-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.15-rc0
X-PR-Tracked-Commit-Id: f278b6d5bb465c7fd66f3d103812947e55b376ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: acc4d5ff0b61eb1715c498b6536c38c1feb7f3c1
Message-Id: <174356309678.1010990.16104165100560051680.pr-tracker-bot@kernel.org>
Date: Wed, 02 Apr 2025 03:04:56 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 31 Mar 2025 17:10:43 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.15-rc0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/acc4d5ff0b61eb1715c498b6536c38c1feb7f3c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

