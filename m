Return-Path: <netdev+bounces-141378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDB59BA9A2
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 00:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CDE71C20D03
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 23:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B1B18B478;
	Sun,  3 Nov 2024 23:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrD8w5sv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346D915B13C
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 23:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730677821; cv=none; b=jHjNJiKdlkCL9UCrVfPZvppXeSznDTcqtP8dDTZXwUzhsz8k6ng5mUrnE6/HoUzwPNk1ZDMTJSPvgqKPB7OV8zGq7ZXuY75psCVE+OEgbuo0vzhTSd1NrOj/i9notqmwnnlt5C7P58tSYSTppnqjVteIhr65jmuFz6YJmZHguyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730677821; c=relaxed/simple;
	bh=QwHnpGltVGX+bTghlBXukZDkQ1dmJYIVG020KAG8ct0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j62o1w5p1e/jiYSIob6PibPCdcdMexBHcIRTeOBqy69JB+NGsoF9hxE7EienGyk+nLmmwrCMuU9mrJMlVCU+pcPaXAJFAPBknUiKyrrHnDa8XP3cKIZF92DTZFTX3jYGYq8aw7m5jgffjJDHE6ftkU+6rtLAP4TLzaFpNJcYgt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrD8w5sv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C93C4CECD;
	Sun,  3 Nov 2024 23:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730677820;
	bh=QwHnpGltVGX+bTghlBXukZDkQ1dmJYIVG020KAG8ct0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WrD8w5svVuoVNmhjb+WUFSpB+7J5TefR9MgvPyVQ99jBOJy08cbiMKsRaPs50JfSW
	 rFt9LhK0vnG2eGtP+3Zu2Lrpb59Ix9+6QlluhsxiKgUkInyRJykVDMCnyl8gjfyBFi
	 oNvwe8nA49zwnnTtf7dIMl+ghT/dOdYgMfZF6Qzy8SSn2xAm5eQ5R0Vg6J4XWhRciH
	 8gYKDlUXwnsNrWisioFaj7en+NNZUXHobe6ZGl0cbMAxn0/RK/hbPQf25StNCp400V
	 fn2pZtWESLv3kwpW+U2VLR4+MuO4QBiT1wn1nDGpuZz7BEveA4FZDIJsT6i3GVUMWi
	 LGUf2KW9JvI1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DC638363C3;
	Sun,  3 Nov 2024 23:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] mlx5 misc patches 2024-10-31
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173067782929.3280226.15548029200725027758.git-patchwork-notify@kernel.org>
Date: Sun, 03 Nov 2024 23:50:29 +0000
References: <20241031125856.530927-1-tariqt@nvidia.com>
In-Reply-To: <20241031125856.530927-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 31 Oct 2024 14:58:51 +0200 you wrote:
> Hi,
> 
> This patchset for the mlx5 driver contains small misc patches.
> 
> First patch by Cosmin fixes an issue in a recent commit.
> 
> Followed by 2 patches by Yevgeny that organize and rename the files
> under the steering directory.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net/mlx5: Rework esw qos domain init and cleanup
    https://git.kernel.org/netdev/net-next/c/cac7356c653d
  - [net-next,2/5] net/mlx5: DR, moved all the SWS code into a separate directory
    https://git.kernel.org/netdev/net-next/c/e03cf321882b
  - [net-next,3/5] net/mlx5: HWS, renamed the files in accordance with naming convention
    https://git.kernel.org/netdev/net-next/c/a2740138ec65
  - [net-next,4/5] net/mlx5e: move XDP_REDIRECT sq to dynamic allocation
    https://git.kernel.org/netdev/net-next/c/bb135e40129d
  - [net-next,5/5] net/mlx5e: do not create xdp_redirect for non-uplink rep
    https://git.kernel.org/netdev/net-next/c/355cf2749769

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



