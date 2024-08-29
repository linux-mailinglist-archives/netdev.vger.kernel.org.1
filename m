Return-Path: <netdev+bounces-123479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF4B965069
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 22:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295961C22641
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824B71B86C2;
	Thu, 29 Aug 2024 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtvQOmsC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E68F14B061
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724961629; cv=none; b=m5uHLSlrU6bQilVHq7KR7VgabvQxgxlnMvA5j8yJ11VH+cjz/RJW13pUASTBCKa+4p95wnLH4iaIzr20fWG6iNakEtvbAs/0OizA+4WTX5WNBA0HZMcY58VF6g5Px/jvpg3Ak7MTh6do8NnNsS7Veo95UwlesrO9pA6q8362gno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724961629; c=relaxed/simple;
	bh=ynx6CMJyPHNUCjlfKvWfD5qQf2j9GBXNow21jz/GtE8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HVviu7SmJCt/sWc7swRc+nRnk5VgfVJvdfMoPEfABjrq1pYrBHu1cj3h5cZA3rYl1wAKMBnhVGDFdpUyoIRm+/qmUYE/+Bmc/HFOyXjHhnQgwFUm9RmmAsL1NCLbyqr9MEJnLQuy+9SKvPxfLyB7Lq589FAdLVTMGlSiGMV5WR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtvQOmsC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61D4C4CEC5;
	Thu, 29 Aug 2024 20:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724961628;
	bh=ynx6CMJyPHNUCjlfKvWfD5qQf2j9GBXNow21jz/GtE8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OtvQOmsC6MulJNS9QbQv65wqknpG6AN7CQElStUW/kWdFVI+pO8DiHppG+FdBo5+T
	 BMXnwMmqUPhRSTts0E96yrLuMIQDlOqN0+UyLqiE0xSI4Et34jVNmCrr+DxmE+0tmI
	 1en6ZU3tp0t26/23vtx3P5V54zqVv2qBn+CX9Sb0pCty71M2lryCsvtYiD2aw9xQT1
	 t5ozmhah6aeLseCvt4EgQexBpbXJXbeBZCpRqb4Dg7KkruyMSGf4bS35DON+9TJVh0
	 ugs7gDtKzmPlkc35d+1HUZICSAoWDvrX05FC3rRfNNJd10S1MW6XsQcjrlB10zRwfG
	 QcuaiCUffT7Zg==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 437C73822D6A;
	Thu, 29 Aug 2024 20:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: exclude bluetooth and wireless DT bindings
 from netdev ML
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172496163025.2072195.3730194540061943666.git-patchwork-notify@kernel.org>
Date: Thu, 29 Aug 2024 20:00:30 +0000
References: <20240828175821.2960423-1-kuba@kernel.org>
In-Reply-To: <20240828175821.2960423-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Aug 2024 10:58:21 -0700 you wrote:
> We exclude wireless drivers from the netdev@ traffic, to delegate
> it to linux-wireless@, and avoid overwhelming netdev@.
> Bluetooth drivers are implicitly excluded because they live under
> drivers/bluetooth, not drivers/net.
> 
> In both cases DT bindings sit under Documentation/devicetree/bindings/net/
> and aren't excluded. So if a patch series touches DT bindings
> netdev@ ends up getting CCed, and these are usually fairly boring
> series.
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: exclude bluetooth and wireless DT bindings from netdev ML
    https://git.kernel.org/netdev/net/c/b57d643a673c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



