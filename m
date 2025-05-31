Return-Path: <netdev+bounces-194459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7357BAC98EA
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 04:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472DD1BA2D41
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 02:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC21E1465A1;
	Sat, 31 May 2025 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shE8mD3N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD5E140E5F;
	Sat, 31 May 2025 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748658605; cv=none; b=IeGt7Eg79IA/fgnwDx5Me7N6f047rDm4+MLIVHbMtMp1/5K1YUHqj+FAM8NysNPqWdFwnTDXkmc0AeKk8v9M1WbyE0YSg43FHy4hMsRUGmIpHU/0tXnKejRx8r4lbsrDCyWJUulGnmDbk5iLXvp94WfIkZUNuikTmCNWKDJ/sj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748658605; c=relaxed/simple;
	bh=+inTlfS0BI2YolhwgzILBPt7b64ri4FLY188PpHU6EU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E+gYBL4aRG8svuRkXUU6S0zJUxNdHCwYpXtfN1Z62p61nxK7dHBwKzXW6/eejqb91edVPQq2jktjUEKrREJre9GeO1PFS4/yxjGY7w221yELBiQ8sfdWwvT/+5ocg5hRBvZiaeXUNsc+xPJJWpWbWcWL/qkfoE3xHNRshtBdUXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shE8mD3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E95C4CEED;
	Sat, 31 May 2025 02:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748658605;
	bh=+inTlfS0BI2YolhwgzILBPt7b64ri4FLY188PpHU6EU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=shE8mD3Nf6nYeSP1ssWKHRvEn75G1GZG3osK6f2UHSvfTpN7+4aGBxFf+ZIbT1I7g
	 oiLP51TpPaFjlJyRM+LjKPteUNmvvOq6U6X+zZzmMjW8D8eSh9b+rfa7DjrkkOZOnJ
	 bp/eBfSjZ5ciVTo7ajrwfXSC+yJp9rxZ/DGBan0WBmbmxyqpRtJhYMCqcQMB9/4c4H
	 CAIpBZGmkE7lO7Ay1Hn0/FYYPzq5xswcazyHSNyL8NnKO038Q4HUmiAgNDmfR3/ytR
	 hVLMcx3sL7nTCq3IkJscMLL4oz45tcHPLTQenhXemIE1to4IiafbLBhx6KvQqTOOch
	 YqSDsi+ig3zQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE65E39F1DF3;
	Sat, 31 May 2025 02:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-05-30
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174865863824.8596.5206672805263018749.git-patchwork-notify@kernel.org>
Date: Sat, 31 May 2025 02:30:38 +0000
References: <20250530174835.405726-1-luiz.dentz@gmail.com>
In-Reply-To: <20250530174835.405726-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 May 2025 13:48:35 -0400 you wrote:
> The following changes since commit d3faab9b5a6a0477d69c38bd11c43aa5e936f929:
> 
>   net: usb: aqc111: debug info before sanitation (2025-05-30 12:14:53 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-05-30
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-05-30
    https://git.kernel.org/netdev/net/c/d1a866d55306

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



