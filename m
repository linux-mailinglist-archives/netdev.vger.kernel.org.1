Return-Path: <netdev+bounces-105440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E94911288
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 21:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6FC51F21CF6
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 19:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA134778C;
	Thu, 20 Jun 2024 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWZEdCAm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89B913AF9;
	Thu, 20 Jun 2024 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718913008; cv=none; b=bBUonLmP4i7drlQoXnS0JbVhww3sGOn4KkheLoy0cZFI/gVM3ulJ79Ch5rCtiqzdPWxbSxs1oiLQDJzPB5Ll/EXMaryhSmhAoNuZT/jc6GVsIpJ9I5hN1FcWvlC+M3BIcVKjimJ7rHUHGCtUJIKZhE+GJR+GrR15FklP5nUJdP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718913008; c=relaxed/simple;
	bh=IfKe6M83dVlXGFE8T26z06hPcpRgJS7FAPFSMkJ1fqg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aqZmd7fP0StQTJLH8yz83Dm0uLYhkrSPwefvDIKYn/CTeME1QFfvInfMhqgzyhxDvUvGt+lXb0Rqg+N2+qiRN8I6k8eGJhyWfMBgksDEDNvNljWjz3XLOhTIYZLH2dHIFdtETUh92yBOswv0ApwmlQ/SoBPlowAmDcEUYj8d0Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWZEdCAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDCC6C2BD10;
	Thu, 20 Jun 2024 19:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718913007;
	bh=IfKe6M83dVlXGFE8T26z06hPcpRgJS7FAPFSMkJ1fqg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZWZEdCAm5dcJ4o+OoQp04OgVGXLF7IK7n+kC8Vwq8mW5PGMajdrR9PqilxninpCrG
	 RpRDBZoA5X9TVR1MWnObT3BnEd85LwdwWDLd67IRYdXgEvMfUWNb4okwRV8D95pQA4
	 X34FqIkom8tNf3KXzKJujN2edPDNPbvbW7vWBFzg+/tPkCvmMDbqQG9oHKNxGHwPQM
	 uzwvUC5STlO42xU+XFlbpP5L/Lmc5YMXQPECaqbktF2CZHR7L1ybHNulhMB1VBc0cd
	 7TDYSIWaveJ5mTtWXDIZUIG8RUlQWp0wN47tmpmflJYKzlaJucLER2vjNeFl6dKYTe
	 qzO77RH0emjsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8A66CF3B99;
	Thu, 20 Jun 2024 19:50:07 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.10-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240620162333.2386649-1-kuba@kernel.org>
References: <20240620162333.2386649-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240620162333.2386649-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc5
X-PR-Tracked-Commit-Id: fba383985354e83474f95f36d7c65feb75dba19d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5a7fc58da039903b332041e8c67daae36f08b50
Message-Id: <171891300761.2247.12648595029216409391.pr-tracker-bot@kernel.org>
Date: Thu, 20 Jun 2024 19:50:07 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 20 Jun 2024 09:23:33 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5a7fc58da039903b332041e8c67daae36f08b50

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

