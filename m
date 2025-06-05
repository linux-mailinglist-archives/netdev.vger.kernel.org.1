Return-Path: <netdev+bounces-195320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45F6ACF86C
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 21:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26F816706A
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 19:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633CA27BF99;
	Thu,  5 Jun 2025 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/xgQIBu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A97C5FEE6;
	Thu,  5 Jun 2025 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749153204; cv=none; b=h32LfHErUTsyvnl31cGnEdHeXRWuB1ySJF8rlJ3C9/DbKv9iB7XGEiCW7FowgBM0TdspAxthz4N7wVe55z6lBbfuLXBYRJWPjGwswkMgD9J7M19uQA6vGitKTvW8rbVvvYw9FCbvgyoda5A7SVcjkjgmK46CtuAvCnBmjumDEhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749153204; c=relaxed/simple;
	bh=KXbZ8gbb+OS0OohMz1NDR/5kdgB1PIynTb2Z3and2o0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=n5v7TRicjXxBJrY8YHtLBRIeJzFsg+/TUU4Iq3R/sNKajAYxFO3rxX1SpcFgT21WwZEIINLeAKpM/JdnkrpVTprmuLOuwPGuggdi31FrO7v/X+7lymQLNPfMlR+W8eJduTUip8WHtI8FH5eQMXEK+W/d3N9jVVYK6cVJ1IgNTAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/xgQIBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A36C4CEE7;
	Thu,  5 Jun 2025 19:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749153204;
	bh=KXbZ8gbb+OS0OohMz1NDR/5kdgB1PIynTb2Z3and2o0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=k/xgQIBujXVGAPwy2WG9+PbJyPRMU1P5HyXCDfN6UheUuAnqufwDeNvxROealoauQ
	 gXR5hRJ96vm5hDlqNoKvQUOEjuro96LAJj0dyMa4f5MXGaTaZ6vkIX1z6qk5ZhX87s
	 APr9XMvrfI93iQN5zx5buLWjAf9nYD4SBNiMWIf5GLmeDCxIRfXzdMxzvLzHtcUcRu
	 551axHtRHv0EEsP6l65QvU+02+En4eJr3GCZO2E4CfZefMSpO1SdCgtu4X0SV9Fkqc
	 FczITEaH3HGqhoqLPmU85WWRp4xF2oHWhkTf0NcS6633C0Us++3LNGkCKF1eDdEtrF
	 O2y3lAGlRgWmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BD139D60B4;
	Thu,  5 Jun 2025 19:53:57 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250605161212.145569-1-kuba@kernel.org>
References: <20250605161212.145569-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250605161212.145569-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.16-rc1
X-PR-Tracked-Commit-Id: 3cae906e1a6184cdc9e4d260e4dbdf9a118d94ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c7e4a2663a1ab5a740c59c31991579b6b865a26
Message-Id: <174915323580.3217379.8620530471464920162.pr-tracker-bot@kernel.org>
Date: Thu, 05 Jun 2025 19:53:55 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  5 Jun 2025 09:12:12 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c7e4a2663a1ab5a740c59c31991579b6b865a26

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

