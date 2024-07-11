Return-Path: <netdev+bounces-110929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A80BE92EF97
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 21:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629C0281FF5
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 19:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A7C16E88B;
	Thu, 11 Jul 2024 19:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9FSbHxY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93D51EA85;
	Thu, 11 Jul 2024 19:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720725872; cv=none; b=N2POsGkPsnosfqh8KXEPQ3W2ZPpNIxSjq2zc9U30DwZ4ABnJAm1Cwv5QCsqUecG2F5CUeWC8APcKjfiM8eASTQdTR4TiuJuENZUrWWa9TRjbcfEtZIHXaC12yJXpWx12csE08hRjJss9OK93Sm/NDigpyazWmlZMWg+Mbf0xyws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720725872; c=relaxed/simple;
	bh=xy99/kDWGgxvByUfnPwWGMstPjslgJNjta3z5Vf531Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mqRuSRgK9m94hcj1L/DCG67tr4Zm0QtrharISb1NsMr83ScruOD/EOnB3XCnFK1hyZM3JITjRHpRx/LBWon4U/RX4b1gr2yGEiguE6TskXatf9G3yaQyyi1PkREpY99ADprm/070CW0nMN2hTsE42Gpzn/ndHSbPq1cNPZGdOBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9FSbHxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81DECC116B1;
	Thu, 11 Jul 2024 19:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720725872;
	bh=xy99/kDWGgxvByUfnPwWGMstPjslgJNjta3z5Vf531Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=W9FSbHxYBcqvTMNl8HP35HGE87RXvZeDRclx9hM9SPNGgOY0qcuG+a2mwfbaGsU6t
	 OeDoBg4DcAmbXvYb7Q0BjC4laH+f6bHjnG7AeHJVgyzk/+sT6i/H/adGbN08R+b0Fz
	 oEviajrBttMDlIeIOgXnevl5yUzllh6ytW/Uj7DQQXL21g1DLFcykL5QJmasVHIdqO
	 zpbtZ0akTFdo/gUXfKaqXyjDVPnKy6twjH6Ye5GvcfyV+ihbH3uUrt2TAHhlR3rNau
	 KA7USARLS3MbC4LTsBsk1REVkiFWGkdS0zO71ZnFPLjdUl1XHt7pNXiihLPaXBocf+
	 rYWBcC6V9OOMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75E01C43468;
	Thu, 11 Jul 2024 19:24:32 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.10-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240711134137.108857-1-pabeni@redhat.com>
References: <20240711134137.108857-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240711134137.108857-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc8
X-PR-Tracked-Commit-Id: d7c199e77ef2fe259ad5b1beca5ddd6c951fcba2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51df8e0cbaefd432f7029dde94e6c7e4e5b19465
Message-Id: <172072587246.27993.6082265630190170856.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jul 2024 19:24:32 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Jul 2024 15:41:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51df8e0cbaefd432f7029dde94e6c7e4e5b19465

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

