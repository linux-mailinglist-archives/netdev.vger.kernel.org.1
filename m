Return-Path: <netdev+bounces-142602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D35619BFC35
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9852828533E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4874E4EB51;
	Thu,  7 Nov 2024 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMqGIAJv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA7F22EE5;
	Thu,  7 Nov 2024 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944828; cv=none; b=r0Ys08sQ8NKp3fzBmnC2qu0qDrhYCdSo1Ivs+aTTs0yiSB80erJn9nUDtNJ3eNtfSZafvMDJFR9on6pwzkt3osTuePapQ/ii5rQBfoLLMZ0fIuYlkq7sG4elJgF9eWi4Tju5u+mo5zh4MoDeTgbvL9uhuAPuv0krIl7GVkg4blM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944828; c=relaxed/simple;
	bh=QvXHtef4fKAFfC5vp1HTxFq8Keq7ExsSQgIf685Ieus=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gdunCHq+RQPhls9YZZkDxFxLRjd4O+3yW4nlRwUnS0dyrOy2ctablDwPJY4IgYN+gfzx9dLEZWnRaGNV/iFQsG4t6AjgfBNaYdBdvlbV7guyALgCFJzdxlNDpGZknKJhDTZcovZMaNyWI3mT7dA38a9KTwbsG+7j+f4l5Dld0xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMqGIAJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1ACC4CEC6;
	Thu,  7 Nov 2024 02:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730944826;
	bh=QvXHtef4fKAFfC5vp1HTxFq8Keq7ExsSQgIf685Ieus=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lMqGIAJvWz51Z/9E+zGCFhZc50mhpk2g55fTQn20/1dPrE6xDVEHPJ7bI5a/ZmAjH
	 hxz5I59A4ybne/kw2JjKTGqJ8vQ9fno1mCrC3LtzRk+P0EKg9WMLDiVLJs7gSTQ5Jt
	 cZzS7XP6TIHfbStt8vEX6AR+F3Mg+7ybda3r+Ll3f80RWe2BJEvRSEA6WgXPdy318a
	 SbncZpPUFZx3Xrkhfrskp2deaNNj32ZQ5dcVD2Nakq1rQp3EuziMwXmX1o3ywDlOTd
	 92IZwbp+rrkJrJ23pISgmsgAAJBGCJXo2oOshFAs0zipLfQhDqgUw7BA9DFqqiXhzE
	 7X1F4qC39ASSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB7D33809A80;
	Thu,  7 Nov 2024 02:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net-next] net: hisilicon: hns3: use ethtool string helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173094483574.1489169.3706485521381583047.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 02:00:35 +0000
References: <20241104204823.297277-1-rosenp@gmail.com>
In-Reply-To: <20241104204823.297277-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, shenjian15@huawei.com, salil.mehta@huawei.com,
 shaojijie@huawei.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 Nov 2024 12:48:23 -0800 you wrote:
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the pointer. Cleans up the code quite well.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Reviewed-by: Jijie Shao <shaojijie@huawei.com>
> Tested-by: Jijie Shao <shaojijie@huawei.com>
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net-next] net: hisilicon: hns3: use ethtool string helpers
    https://git.kernel.org/netdev/net-next/c/4ea3e221907a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



