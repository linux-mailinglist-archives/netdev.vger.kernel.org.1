Return-Path: <netdev+bounces-199579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029D8AE0C10
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 19:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99696172B2D
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9439213259;
	Thu, 19 Jun 2025 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDgn5xwG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A280319D8BE;
	Thu, 19 Jun 2025 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750355275; cv=none; b=gOObFOG0MCWuue2EPf1bf97uq0/l51ur092oB3iuRjYViJhrvOWMT5IaKmAJS76p7m6+9viq2z9goOIG+A3jEfewC9OqwRN4ezISBrkXlFbj5QDvP5qk9dNrIern7Fg0j7m6Ov5CyMp/yhur7YdxNSYir+DWKjdtR6oA7cYzzz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750355275; c=relaxed/simple;
	bh=+lz25+iX8GgbWx13IxOBA5EUd8Aus6CBfk5a3hnFj8w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=swxpk5b5ja2sn1uCOaFTiacmIBW/WXGt7DnF6TlfFlTFiXYk3ug/M59M0hj/PE2fSw8YyOJBLJ/XiOgVtyHh0FGi0kbuD+/tGUhtnoPCYypmy2nXyaacVxYjoiA44VmnqZY5QOf6E7c5kYpcOOObHMmmPK21Me8gIjmUKprlgbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDgn5xwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6892AC4CEEA;
	Thu, 19 Jun 2025 17:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750355275;
	bh=+lz25+iX8GgbWx13IxOBA5EUd8Aus6CBfk5a3hnFj8w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MDgn5xwGSsIIpn+CH7Yn+X9ToNQG7VwMl/tnQYlrkoaWy+fcoak3T0vDBlDhnTu90
	 9O8rS0nhwie1QS2pH3wBBT9OzkAN7eV5FKWWj8+4O/uzPSnbZE1fojt1au7SxZT1V5
	 8N9EMG+k0hHzOzd4P90YXIAn9d/6AaMzn4AdKPfC3KhN/8AxhjZ6ubp/qJ0mh4+u75
	 Esrk6XO4a73Gx3wJQNnDjUJskiE4KoeT8cphwgqsEtUeIh9W9g2ohh8FBoooVl+jac
	 uKJHcu1LoBZiHPZ4J29pRV2RYkGSFs84/tshcvEvrv+g/h5OKnbETqyHRUjXl32FKF
	 T4SF1hRbEFkSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0D238111DD;
	Thu, 19 Jun 2025 17:48:24 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.16-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250619164054.1217396-1-kuba@kernel.org>
References: <20250619164054.1217396-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250619164054.1217396-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.16-rc3
X-PR-Tracked-Commit-Id: 16ef63acb784bd0951a08c6feb108d19d9488800
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c8013ae2e86ec36b07500ba4cacb14ab4d6f728
Message-Id: <175035530330.939772.7180274029359635736.pr-tracker-bot@kernel.org>
Date: Thu, 19 Jun 2025 17:48:23 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 19 Jun 2025 09:40:54 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.16-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c8013ae2e86ec36b07500ba4cacb14ab4d6f728

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

