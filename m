Return-Path: <netdev+bounces-128468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C666979A82
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 06:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048BD1F21186
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 04:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABD7482FF;
	Mon, 16 Sep 2024 04:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvP6ytxS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D5139CE2;
	Mon, 16 Sep 2024 04:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726462521; cv=none; b=SMLoOmq+sBRWZ2/UJRagQcdUoo95SVvx1FTexRgJemb5BciWdrUvyjYr97PkOEK5tBH+B0fMBRROmqQaTF5f2RTcuHAme0AjPVXowx3uTUji4fcAbio6pRHdUFxrhlH0+8hgb6cR22b4ETmhof+iPsK5ws6vHP5uY0K9FjvNyCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726462521; c=relaxed/simple;
	bh=b1qVr8d2s32L8Sv65HKfnvuHztBHEh/jZIlav4kU+B0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=h4Mz+IVCAmVlO4qbZYz2ye71wiGa+wnIsDqpfltDaTyiwE0Pp6M4/ORcgomkDyLQG0gXV95I1UR1HYEVsMTKzkPsY1Mrl3H2fWyiABIkF96hl8dwgtfe2BOzDnzcTQgaU/xQO664JVDkBKdkhLRcOQ9smxTIYeCk5cHp7UIDrqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvP6ytxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1F1C4CEC4;
	Mon, 16 Sep 2024 04:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726462521;
	bh=b1qVr8d2s32L8Sv65HKfnvuHztBHEh/jZIlav4kU+B0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SvP6ytxSvdzVlX4FLUu/LAkrPBLaAGtFY9oq5w/DUap8K23jb60S0EeOBMFEho5tI
	 Okn1c4mHqYyu32aN2ZZnEyv/2xwRprs8R3PLoqUGW0T+aNRT8U/vhW0mK/QJfrsFi4
	 /sYylBbWZ9WDHabVLfg/eHFfubXJiF9kkU6YkWtAnEAXZ9c/A4HI+AEJ4HwrpeUbfv
	 9c7SJczWyUSWHuWW46LPf1DuhjovjENBkW2dsH+lYrckmAV1zxoaPF6vZL3VnwJnG7
	 MjkXnyqiG9z+EeND7/rtr1ClP6HjxMNfWdbnokM8JOZx6hzjBQl47WuQRIjrTCluxZ
	 kS/P8BA4ozLeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF3E3809A80;
	Mon, 16 Sep 2024 04:55:23 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240915172730.2697972-1-kuba@kernel.org>
References: <20240915172730.2697972-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240915172730.2697972-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.12
X-PR-Tracked-Commit-Id: 3561373114c8b3359114e2da27259317dc51145a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9410645520e9b820069761f3450ef6661418e279
Message-Id: <172646252248.3235832.6161202011008318742.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 04:55:22 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 15 Sep 2024 10:27:30 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9410645520e9b820069761f3450ef6661418e279

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

