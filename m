Return-Path: <netdev+bounces-224588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB07B86681
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 20:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70390587176
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2E928C03B;
	Thu, 18 Sep 2025 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkUaf0vI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AB7145B16;
	Thu, 18 Sep 2025 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758219794; cv=none; b=O83d20eB39Cy3Z/zpBWsvqQyvVqtB2HX58fW8xqgylTb9xZqUP/C4j7PQC46RHiei4PIPnDO60kSiAddmj98eg1CmXXdRRMmdOpyrIm7V/qZVJOZWt2GANNkf0x6+nmyFAQbONVYme6N1XVUXr33svf9VVy8gePPykmhoCrE9iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758219794; c=relaxed/simple;
	bh=CJdLFLoYwtICAPEYTDkI6w8fMoAoBg+xEeLWAL4/m9w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YGS/zaGi+en2g0qiFbUUw4RjzauAR3io5lY9WTsTdGpjQEhtA/0jhPPQrDdh9zj39afq1MxcysgHoovC7kAewKcB7WbEdOO0mzcXdZ7v/MlgXjVO0LhN9GaHtbgYE4Dn0UqsdMCNlN+jficTSG9gUExWhGMwrwNAbJ7ORjR5RAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkUaf0vI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708E8C4CEE7;
	Thu, 18 Sep 2025 18:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758219794;
	bh=CJdLFLoYwtICAPEYTDkI6w8fMoAoBg+xEeLWAL4/m9w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mkUaf0vIvuWdk5tBcY4rDJDdfe95sa33X+IHGiwCnE6znQOUe1XiQ7qvyhQpfJqac
	 V3GRS4q3uLNBPUKwF5qocpufSIN9sil5r5JFI1hwCfiGo2Y3fokbzaKHO19XEvlbw2
	 lWAyxJhiZ3/icyHUTK8vUn04Co0VgevhGm83efvF1c2mjkdhxzVmlVfrCibTrXawXW
	 MMwSMEkrAHh4RuW1mmhHzXB3Kv0c/9AXBDeOdsaKRL76ALQr84ZJEWETgF9DxdICzg
	 RB02OMQ5zSAaI7Fi7F8IleB3ABxQT/e7w/xhIq+BidYvGWwctjTd3Et0dj3fiiZ2Je
	 uhDJozKfX9LcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE23839D0C20;
	Thu, 18 Sep 2025 18:23:15 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.17-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250918153538.192731-1-kuba@kernel.org>
References: <20250918153538.192731-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250918153538.192731-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc7
X-PR-Tracked-Commit-Id: f8b4687151021db61841af983f1cb7be6915d4ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cbf658dd09419f1ef9de11b9604e950bdd5c170b
Message-Id: <175821979423.2895822.9377376181467206062.pr-tracker-bot@kernel.org>
Date: Thu, 18 Sep 2025 18:23:14 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Sep 2025 08:35:38 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cbf658dd09419f1ef9de11b9604e950bdd5c170b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

