Return-Path: <netdev+bounces-195210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4F9ACEDA4
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 12:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8553D3ABEBE
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 10:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386612147F9;
	Thu,  5 Jun 2025 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvigbRTG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143B81A2C25
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749119397; cv=none; b=iEfLeR+FsVC1VGkEMVK4WACT4jJ+ELz2RQL1YQI7ypcKuUnZGnJsT9QRFDdNSK0DTaUL2wqNTYBm5zk58jz/6Y1eNy7xGJTpnjFLpz9JuyGm6xfo2K1Z/jCn2Hc+BpT2Cd+vKan2mFKNLKkn/n7A/cMEc8iLkutioYaGMuafiR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749119397; c=relaxed/simple;
	bh=aM5w2z1CF6VYnIEaLCslGsr8eyisI4KSVMnTHLtYsBs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A/rBBN4bPNoeza2fRV6r73uLlkwY+k5S5gwCws28mCU9dCNMTuA625ZZqXdTCpVuovYorpH9+Atej7LniPh2OLC2ctEWt+9cApyAoZ66aRu/18VQtLRVprTuK8nmnhyqD7Ah1PyOBS9i63x7jSS6LaDuGQAea2W/Y4FRNMDr8mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvigbRTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9E5C4CEE7;
	Thu,  5 Jun 2025 10:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749119396;
	bh=aM5w2z1CF6VYnIEaLCslGsr8eyisI4KSVMnTHLtYsBs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YvigbRTG6MMw6k+3S+15QbWEy6KwEEd7UBA/msSndbbsjlslt7P/6nmJ2AVQFjlR3
	 oHTBAvB/SqhQhjJRgIYoQpaNVZQ3UjreCf7WfZ27WvtqZYqTaYIqxmE9dsCuMhIqPN
	 oxC4TjTJwCI+QcEe2mmLNVpU8RHGHlJrIBmp3aTEG3pP/tB7sNLtsOHT9x5Zjh4ZLA
	 tRdC4isseuhHXAxR/cQ5pYtX9vUKHo51QeXE3lYT9V4zdCdBsRbbVX8jv846atYeRM
	 QBnQsU2sNzbPgKypsBUZPovlzTSnTHb2ZNIxvLKi5SYy9XGDfdf6cLkeYtDx/idoXt
	 4JyE7exWxGLWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF0C38111D8;
	Thu,  5 Jun 2025 10:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/1] net: wwan: mhi_wwan_mbim: use correct mux_id
 for
 multiplexing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174911942850.3016846.13970926519962437747.git-patchwork-notify@kernel.org>
Date: Thu, 05 Jun 2025 10:30:28 +0000
References: <20250603091204.2802840-1-dnlplm@gmail.com>
In-Reply-To: <20250603091204.2802840-1-dnlplm@gmail.com>
To: Daniele Palmas <dnlplm@gmail.com>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, slark_xiao@163.com,
 manivannan.sadhasivam@linaro.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  3 Jun 2025 11:12:04 +0200 you wrote:
> Recent Qualcomm chipsets like SDX72/75 require MBIM sessionId mapping
> to muxId in the range (0x70-0x8F) for the PCIe tethered use.
> 
> This has been partially addressed by the referenced commit, mapping
> the default data call to muxId = 112, but the multiplexed data calls
> scenario was not properly considered, mapping sessionId = 1 to muxId
> 1, while it should have been 113.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] net: wwan: mhi_wwan_mbim: use correct mux_id for multiplexing
    https://git.kernel.org/netdev/net/c/501fe52aa908

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



