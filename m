Return-Path: <netdev+bounces-165735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F06A33442
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 290BA7A2342
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 00:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279E378C9C;
	Thu, 13 Feb 2025 00:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYyblUqz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0398970810
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739407806; cv=none; b=AEhQbWcBywlTinZKVK4pxKQRuV+km1z3lPXkbFB6zAAjFVDmUIB14OCMCZ2YiJFm4UmCKte2lYeQ8br0KbTcUHoxa3nlllJu9R+8+2vEbzHHfLpdumUsnxToyqwG9RzIA556QNbhSLq9wEiKsx8zHXBg7nCinek113kYattXbvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739407806; c=relaxed/simple;
	bh=r7i1kG7ras9jFXp3FVZCfhBxw5wOC4TPO5jb00HQ63k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I/p0CRmXuSwDYojmBw+Ijk9IUoLl74jVYoZ+UanW+UX46hSaHIFNKGuBwTvpQcdBokLE3uJLjg/8wYoRiXB1duf7HaX4gYIYHv62yaxkLGz6sGWJr4SisQnsuYXmoPmlawsEZH7O2Pw6R2r3V9BYYG51MjtY1iqYOBTi1cP9s7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYyblUqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1FBC4CEDF;
	Thu, 13 Feb 2025 00:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739407805;
	bh=r7i1kG7ras9jFXp3FVZCfhBxw5wOC4TPO5jb00HQ63k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fYyblUqzMlTU2Zg6W+de0Ame/aLI4G4n6eP49Y6GSOCS975poTe79LuCtx2bz7Pvc
	 kavABaEUJZRDJcRFvg1CDPZJGczTRipX0+XpN+brN9kxqTcyJYJHjD/d2mydYulkIH
	 9ZDuctta9B7e8QJQU9+zO2BSvC40tnJk4RIz1QYDuEdZ+i/ku8T7G1v2p+S3OJZ5oc
	 kQgQrfCa9BioHFWZyXGsB2+fYsbnp9OAsoxezX4yWmSbAzVC4e6ah0oy9fu20zkoXh
	 G55GxUGX17F52n3XA4/IGS7Hl9Il60cv8yWdbxl0DIhClBITPv3K13r2EKYpsO0oc+
	 rDD+F+7RDCbYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFC8380CEDA;
	Thu, 13 Feb 2025 00:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] eth: fbnic: report software queue stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173940783453.713677.12924447032289552556.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 00:50:34 +0000
References: <20250211181356.580800-1-kuba@kernel.org>
In-Reply-To: <20250211181356.580800-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, alexanderduyck@fb.com, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Feb 2025 10:13:51 -0800 you wrote:
> Fill in typical software queue stats.
> 
>   # ./pyynl/cli.py --spec netlink/specs/netdev.yaml --dump qstats-get
>   [{'ifindex': 2,
>     'rx-alloc-fail': 0,
>     'rx-bytes': 398064076,
>     'rx-csum-complete': 271,
>     'rx-csum-none': 0,
>     'rx-packets': 276044,
>     'tx-bytes': 7223770,
>     'tx-needs-csum': 28148,
>     'tx-packets': 28449,
>     'tx-stop': 0,
>     'tx-wake': 0}]
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net: report csum_complete via qstats
    https://git.kernel.org/netdev/net-next/c/34eea78a1112
  - [net-next,2/5] eth: fbnic: wrap tx queue stats in a struct
    (no matching commit)
  - [net-next,3/5] eth: fbnic: report software Rx queue stats
    (no matching commit)
  - [net-next,4/5] eth: fbnic: report software Tx queue stats
    (no matching commit)
  - [net-next,5/5] eth: fbnic: re-sort the objects in the Makefile
    https://git.kernel.org/netdev/net-next/c/0ec023282a9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



