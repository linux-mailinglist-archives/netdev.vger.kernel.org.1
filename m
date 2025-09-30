Return-Path: <netdev+bounces-227242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2D8BAADC1
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0337188A5AA
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AEE1624C5;
	Tue, 30 Sep 2025 01:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5YFWi3b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0171C84AE;
	Tue, 30 Sep 2025 01:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759195253; cv=none; b=L97Xtryc7GvaomIYRlM16XCLWhKCJxsxIBR0opE/7+tvikZ+Pxfndj4tqRLY7iVfyCPO/Pe5rd4qmC+LQ7KRYGFtKxykfE8VWCyDsOyH7e8lGbNU1zheLYfG/GbbfHJ5RJtGqJb34b1VavQKpvRea9/Wk8Tj+8HrtunH1UrCQPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759195253; c=relaxed/simple;
	bh=+ltySJyYSsyHmsw0IqHySBLN5Z0s+9e+Uph0L3T5n70=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OPBP3cgnsBxviOXsLVyeEbYb3AG5likkKBrYrEI4UnXA9mECbTVsNkzHM+LCc1Sekq9OAviK8zyybMXCbwFyw0ld8WXQMerbGssbH+ZckgFl3UYpsbX9tgM7731yerkxE/12yTvjF2xE1WLN+/ySgPvYvj0SlGJZIYkh2kUKgdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5YFWi3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB2CC4CEF4;
	Tue, 30 Sep 2025 01:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759195253;
	bh=+ltySJyYSsyHmsw0IqHySBLN5Z0s+9e+Uph0L3T5n70=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s5YFWi3bTPIkeVhzzZXTwcSZ/imrXdwbK8Pp19lShHDntFQRV74jeIS0GgN14pjei
	 tZ31Fivh8zlJNyLQVFiNXDZ2AJAkgDytRKPBAJnfFzcM5sRxBA/L4D31ZFtyskJOQj
	 m7pMAAN6uR40axqRwBmX103pC9hS6qeF/PcNQTjHkmIPrQXt7L/8Gyw3rKKAcGE8Y7
	 u73nITuEOyJxlJGsCG33RI2BLJmnoQOxG1KTytsVUxeIYW15EqXUTYGh+mSUJ2PF6U
	 ityr6drP9Zskpp8xfLn4YDVbzGeI2+g3VLkONJhjMHjXelQcvxPUrRrDCOVRiN1Sk8
	 PtVvMgyVljEXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD5239D0C1A;
	Tue, 30 Sep 2025 01:20:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth-next 2025-09-27
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175919524649.1775912.14709644156836877355.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 01:20:46 +0000
References: <20250927154616.1032839-1-luiz.dentz@gmail.com>
In-Reply-To: <20250927154616.1032839-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 27 Sep 2025 11:46:16 -0400 you wrote:
> The following changes since commit 1493c18fe8696bfc758a97130a485fc4e08387f5:
> 
>   Merge branch 'selftests-mark-auto-deferring-functions-clearly' (2025-09-26 17:54:37 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2025-09-27
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth-next 2025-09-27
    https://git.kernel.org/netdev/net-next/c/d210ee58da1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



