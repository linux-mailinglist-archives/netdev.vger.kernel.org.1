Return-Path: <netdev+bounces-158234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61340A1129E
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 22:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0F0162D5B
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 21:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDDC20E331;
	Tue, 14 Jan 2025 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgMCfKCx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0A620AF7B
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 21:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736888418; cv=none; b=M9tr7HuPVnoIoUVcM7x4au9kL1vJNn5ZWP8CszV83Ga7lfBJdZawLGaHdB/Aht8NCJTGUEbl54y6z9vRRabr7SQO6Lf8BeHxIcn+oBX5508jsA0kH1tn3NzjHLqP0d0LXyzFTIfp5HGZH3SO0DT48C9fxoPf0CYShb0sIfHKvow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736888418; c=relaxed/simple;
	bh=EL8cp+stu+PPBJ6/i4YyZw3STLPnjNYq9K0BYGulxIg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZbWVSQZwQ2TEOYLVnmHMRqqhsjVq9tBWH0PJCCYQs44GPcnPv7n+d4ALzPLXKhqbSnOb78iUtVZDWw4c5M/ngyMOS8xg9VIEj5tr3AHVHQJLqWcq2GXgmIXW3JJd/X5GQf0WxaHc8vIsto4NjKDjF1nbgpHpS8koXgPaOJLCrH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgMCfKCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17D1C4CEDD;
	Tue, 14 Jan 2025 21:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736888416;
	bh=EL8cp+stu+PPBJ6/i4YyZw3STLPnjNYq9K0BYGulxIg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pgMCfKCxJ9fESDKOGgg3SN4He4E7pYTsbGfTmKnvCQ0R1aOKeCRipfE4fBjL13TDH
	 XlI9WpLLAOvsq7lAdqrWmRAoHzco2aMRFtfMWSkLcET5MO/xFmPqGI5B85RTCNQFE0
	 B0kdMyRioQebFjCEiQ5c74Th7Hl1p5vB7C34Qqr+qLtkjoyO+5xBs35HNC5ysIzquc
	 xEFIqjK1bruxr2bsJkQsSSs/JJxlMn7pzQEGRioguzstJgBR8Qym9ddIVc7vx326gk
	 HOj96VHYoTglNYg/CPGd488ADfXzGQpRpcrNR+/91HFjy5qJMmfFRF1RCYKl4zxLbi
	 Y0Ht+DPBqFwBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC16E380AA5F;
	Tue, 14 Jan 2025 21:00:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [pull-request] mlx5-next updates 2025-01-14
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173688843878.137964.973980079107435453.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 21:00:38 +0000
References: <20250114055700.1928736-1-tariqt@nvidia.com>
In-Reply-To: <20250114055700.1928736-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, mbloch@nvidia.com,
 moshe@nvidia.com

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Jan 2025 07:57:00 +0200 you wrote:
> Hi,
> 
> The following pull-request contains mlx5 IFC updates for your *net-next* tree.
> Please pull and let me know of any problem.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [pull-request] mlx5-next updates 2025-01-14
    https://git.kernel.org/netdev/net-next/c/d90e36f8364d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



