Return-Path: <netdev+bounces-241504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1DAC84B41
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 12:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1673B160D
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F57F2EAB83;
	Tue, 25 Nov 2025 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwrMBZi2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44959283FF5;
	Tue, 25 Nov 2025 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764069646; cv=none; b=c+KctsMEvT3LPyTw/J4ByMAPKqq4MrEuTWzejvtDvWqpBQJnSNYn2GquV3NjzmBcfzeqsRcoMxxsyvxq3LTDwsMDD0NxeUZwPX3ZvhlrpRLJ/ECuPbxgJfCs3r7l2zZUH9BqiozuGF24M1OamyLNBHhkWm8yYJ36L/lXppZ4M9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764069646; c=relaxed/simple;
	bh=GwCY/yHwX4kznSTwIO/t3CEnS0PT2vjBeJ6TMDw8OTU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YNOqozXfe2O7lusTPMCzMQ9SfjzC5MVCseGAW+YCHWuJedZy9KteiCXhJrmhOamoqFTW1wCcarRS/2PZ2CLT75tHFOG7SC2icjjiVhavgBZC7ztUQg1UHa9IZP89QUqCQ8fe6Kinx8NEFYlaGcHAmP3xxBTglwXzOVg5VsEmcLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwrMBZi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BCDC4CEF1;
	Tue, 25 Nov 2025 11:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764069645;
	bh=GwCY/yHwX4kznSTwIO/t3CEnS0PT2vjBeJ6TMDw8OTU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cwrMBZi2Uhd1E0T2zJKANLErOMoDX3ooS/M1G75RXv0Tq0M9mTg12iw2OGfEuaK+n
	 AizwcDGpeb/eBJhoARj/9Hqbehe53eZuK6IczmVZ0gKAkMlvoD8abRaiy3WOkcd+Qc
	 6Irde5Zl9JLauKy7V8CIGPdsMXZD7UgnEoJZBQeSl2QU2MjNJTtq++dMXyRaBubAwg
	 R6WQB1ALApO6bY1V9x4LQD+Gaz3/LKlsU/w8UACtsZz+FWppljPA0FKWmRbSaRpoEw
	 zsxFyKk9FQfxncqV5bD7UQ3KscCmkdKr3nMmK40aBUnmvR8yEjojCWET0dMKx5gix4
	 p+7UDSTaA+sfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ACC9E3A8D14D;
	Tue, 25 Nov 2025 11:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: aquantia: Add missing descriptor cache
 invalidation on ATL2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176406960851.690498.13577200917288068602.git-patchwork-notify@kernel.org>
Date: Tue, 25 Nov 2025 11:20:08 +0000
References: <20251120041537.62184-1-kaihengf@nvidia.com>
In-Reply-To: <20251120041537.62184-1-kaihengf@nvidia.com>
To: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, csoto@nvidia.com,
 irusskikh@marvell.com, dbogdanov@marvell.com, mstarovo@pm.me,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 20 Nov 2025 12:15:33 +0800 you wrote:
> ATL2 hardware was missing descriptor cache invalidation in hw_stop(),
> causing SMMU translation faults during device shutdown and module removal:
> [   70.355743] arm-smmu-v3 arm-smmu-v3.5.auto: event 0x10 received:
> [   70.361893] arm-smmu-v3 arm-smmu-v3.5.auto:  0x0002060000000010
> [   70.367948] arm-smmu-v3 arm-smmu-v3.5.auto:  0x0000020000000000
> [   70.374002] arm-smmu-v3 arm-smmu-v3.5.auto:  0x00000000ff9bc000
> [   70.380055] arm-smmu-v3 arm-smmu-v3.5.auto:  0x0000000000000000
> [   70.386109] arm-smmu-v3 arm-smmu-v3.5.auto: event: F_TRANSLATION client: 0001:06:00.0 sid: 0x20600 ssid: 0x0 iova: 0xff9bc000 ipa: 0x0
> [   70.398531] arm-smmu-v3 arm-smmu-v3.5.auto: unpriv data write s1 "Input address caused fault" stag: 0x0
> 
> [...]

Here is the summary with links:
  - [net,v2] net: aquantia: Add missing descriptor cache invalidation on ATL2
    https://git.kernel.org/netdev/net/c/7526183cfdbe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



