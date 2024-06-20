Return-Path: <netdev+bounces-105098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4146B90FA64
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 02:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E878C282BC6
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 00:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579DC3FC2;
	Thu, 20 Jun 2024 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTx3R+oO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC191879;
	Thu, 20 Jun 2024 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718844028; cv=none; b=XP09UqHvRytXJvf5odi1V3/hBo9CJu+lV0ANZ0b6KLJNu446nGaAE2ZxVEWj5qB5wxiyFmu1DW9+B4DQguc1OeQa1rRT6WRAx78QmA/2HQBSLUa97qhfQsJU0XBogRRqIIaMYeIsiisGUfaV4dCfkCW3+EPKe8BuqDT2BECxz4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718844028; c=relaxed/simple;
	bh=rvuOXytVc6G50Are3ibBW4kTJbx0ikOESipcZe7p9+s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RkktIQkgv3y6Gv5d84GBU7x5gWHrtKetq86kwPRDwWmvKj/BF3kGBeS209kW5cwo7BtXMsEjWq5wjG4ely/IP5OTmg165IAx8SpcRPwAEuE2MNXiCMD4hMFioshTxgkqx4hJYdrBK0cRJZk63obrdHx+FvTqvRs1LuVenYr3P9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTx3R+oO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03ED8C4AF09;
	Thu, 20 Jun 2024 00:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718844028;
	bh=rvuOXytVc6G50Are3ibBW4kTJbx0ikOESipcZe7p9+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KTx3R+oOTBOlFuJTdRJ3ZNG8cUlP6noUMOanePwmaP+4dG8XdSdfspL87MJPRM/Fb
	 pWcEUMHAZBwv9pyZpHQp989LPDx76OmI2FuIkR6lomXBcFUSiX1IJKGuWi4lWTFo6Z
	 lHK4JHKxho+khsxAlae2mQVfmGRQIqyUQHS8Qj02e2JGRFrcCfIxYH3I+8n8VqhPix
	 YR1JhthgT7nCnZEv57S8MsIAjiUrR+XvIEUQo2YBunM6LqSlRrTUUJOknfTcvYHEJV
	 tqVr8/3QWpA5ot39Sxvflxa6CdR4/LKlKQTHCJvkOE0SHG0RE7WopTTp/c+XchhPU8
	 sMo7ktFk0uiZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EEC75E7C4C6;
	Thu, 20 Jun 2024 00:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] virtio_net: add support for Byte Queue Limits
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171884402797.27924.17653832264207985916.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jun 2024 00:40:27 +0000
References: <20240618144456.1688998-1-jiri@resnulli.us>
In-Reply-To: <20240618144456.1688998-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 dave.taht@gmail.com, kerneljasonxing@gmail.com, hengqi@linux.alibaba.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Jun 2024 16:44:56 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Add support for Byte Queue Limits (BQL).
> 
> Tested on qemu emulated virtio_net device with 1, 2 and 4 queues.
> Tested with fq_codel and pfifo_fast. Super netperf with 50 threads is
> running in background. Netperf TCP_RR results:
> 
> [...]

Here is the summary with links:
  - [net-next,v3] virtio_net: add support for Byte Queue Limits
    https://git.kernel.org/netdev/net-next/c/c8bd1f7f3e61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



