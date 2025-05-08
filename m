Return-Path: <netdev+bounces-188933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CEAAAF723
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 11:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D703817CE0E
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 09:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C67021A434;
	Thu,  8 May 2025 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaD4TaOf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576DE2165E2
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746697800; cv=none; b=dhGbqSa7jsDOve79n20OzygrGQmi0KeTlr+34awh8WVEQpHonFHLUCcarf1F9lYFXcA9wt8rZB2S0YpULxwEv2HkjwKB1lBSkCehej8FXfaGkmArHCOfJ9Cr+sm2942RXyp9I7tq9xQG/wSloBCUSQLRlMfaXEg+Ljoa12DIei4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746697800; c=relaxed/simple;
	bh=vOtBj2Vnw5BDXga/uzONvGjiNLhJD/6z6u/T5IBQcG0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CvPiJ42Up2y7aL3caPPOicv2nPzL2tJg/iMmH5XmMO2RsEZQwXHc8gPbMQ5xYpy/T2TukpY4+x/Aw9ijrJ7CmwJnizhjswqJxLC5qevfIwmCbX8cjVpGutQQ0R7sH1E4uCSX1JcYg/egZ542dDm/jdrUc++Yzqp3JHoOO3rUVBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaD4TaOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDA8C4CEE7;
	Thu,  8 May 2025 09:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746697799;
	bh=vOtBj2Vnw5BDXga/uzONvGjiNLhJD/6z6u/T5IBQcG0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PaD4TaOfZx5dp9OZQYQaZ7psH6sZs+HVyIqiNbgsCg4XVnwliIm2DSsvNmSYdm4CL
	 xpEgdLErDjfoekvWydH3RcMlFEtH4KXKqAwL0NZHcM0pJY9hEu60IOlc3NyIxrOPxs
	 dFkmeJiACdLmUQyw/KhHPNwb0G4sRr9b8yJp90iz4H+g0RNNYCeiAK0Sc/Ddg5l4md
	 3d5UTvr+W2MSTqZV2vw8Fw8/yCr1EzoQ4zJOGCvwgGI6pqqfrKAjmW8PyU726AQLh5
	 NMzty9ZIBD/HcCdlYgm12hY2frShMmMbaL2Dzi5Aq9/wNWCOpKfLNiRgTjlyuNG06+
	 ZXCHiy5TTja7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC5A380AA70;
	Thu,  8 May 2025 09:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v2 0/8] fbnic: FW IPC Mailbox fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174669783849.2854047.4602231655832293886.git-patchwork-notify@kernel.org>
Date: Thu, 08 May 2025 09:50:38 +0000
References: <174654659243.499179.11194817277075480209.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: <174654659243.499179.11194817277075480209.stgit@ahduyck-xeon-server.home.arpa>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 06 May 2025 08:59:33 -0700 you wrote:
> This series is meant to address a number of issues that have been found in
> the FW IPC mailbox over the past several months.
> 
> The main issues addressed are:
> 1. Resolve a potential race between host and FW during initialization that
> can cause the FW to only have the lower 32b of an address.
> 2. Block the FW from issuing DMA requests after we have closed the mailbox
> and before we have started issuing requests on it.
> 3. Fix races in the IRQ handlers that can cause the IRQ to unmask itself if
> it is being processed while we are trying to disable it.
> 4. Cleanup the Tx flush logic so that we actually lock down the Tx path
> before we start flushing it instead of letting it free run while we are
> shutting it down.
> 5. Fix several memory leaks that could occur if we failed initialization.
> 6. Cleanup the mailbox completion if we are flushing Tx since we are no
> longer processing Rx.
> 7. Move several allocations out of a potential IRQ/atomic context.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/8] fbnic: Fix initialization of mailbox descriptor rings
    https://git.kernel.org/netdev/net/c/f34343cc11af
  - [net,v2,2/8] fbnic: Gate AXI read/write enabling on FW mailbox
    https://git.kernel.org/netdev/net/c/3b12f00ddd08
  - [net,v2,3/8] fbnic: Add additional handling of IRQs
    https://git.kernel.org/netdev/net/c/682a61281d10
  - [net,v2,4/8] fbnic: Actually flush_tx instead of stalling out
    https://git.kernel.org/netdev/net/c/0f9a959a0add
  - [net,v2,5/8] fbnic: Cleanup handling of completions
    https://git.kernel.org/netdev/net/c/cdbb2dc3996a
  - [net,v2,6/8] fbnic: Improve responsiveness of fbnic_mbx_poll_tx_ready
    https://git.kernel.org/netdev/net/c/ab064f600597
  - [net,v2,7/8] fbnic: Pull fbnic_fw_xmit_cap_msg use out of interrupt context
    https://git.kernel.org/netdev/net/c/1b34d1c1dc83
  - [net,v2,8/8] fbnic: Do not allow mailbox to toggle to ready outside fbnic_mbx_poll_tx_ready
    https://git.kernel.org/netdev/net/c/ce2fa1dba204

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



