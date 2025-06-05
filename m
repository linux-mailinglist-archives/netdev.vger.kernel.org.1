Return-Path: <netdev+bounces-195223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1F7ACEDFE
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 12:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E243ACB66
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 10:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1D4211711;
	Thu,  5 Jun 2025 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFWp6xx1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FA3204098
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749120605; cv=none; b=F0igv5vsrCaguMqOy+oTKKwae/YK5QxNf+/FeMe40xDS1lmQ8hpWDit3lCJVbVnkYujy89lexp5ui+FKnug6QBQH0PAYtuCv1dk8VkI4FALZutSdv1qygXlI3qg5gq4UncH9/6NIyggZXxJBI6AyPsjfmUwqGUnpKijm+gyKFvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749120605; c=relaxed/simple;
	bh=5l3tyM19zG43xNPMB5ZpA6hgTyPQaRBvaIwixShEJoM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VvIvOvVW+PAabvFxw4IPjlcwc7bldxNzFkhVRq3v3Fk8Fm118dHeyJuEzWDxxXZJEDvhF5gXNBKG6VxrfyErBwB+Hg2pM3CEk3Lgn0DR8r2Q9N6H1MqUf/S6qZFRFjYphDtRwcSEm2s115FXuyDooTXR653vbq5uAvKxFLvBv7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFWp6xx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0C6C4CEF3;
	Thu,  5 Jun 2025 10:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749120604;
	bh=5l3tyM19zG43xNPMB5ZpA6hgTyPQaRBvaIwixShEJoM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HFWp6xx1ZNMRicKusR0jiXDorYhnOiiXUQN8IUqrCS3JGfAbjRBVoYLsTbCLrsZ0R
	 I37z1DTjSXr2Nmv2vGPe1vz+VQkrYnDrSnRIjE/+jsedHOZLb/ciek2RO6qiON1sLi
	 VBmpWj5NURBpyWLUzgI7VIruHBAIaTKxDW1SPI9FN4yP9lHTDs5yACy/TYxVbQi8A3
	 ZiX6iATdzH81jukaG+2IW+4TOnpe/5DE4fjDlaM/XuA6N5JmAwDagxD9bSDeFm3WQ2
	 lTfuFASuNm1we9D2A4bV2RsdYMDHMP8JpaVFaH4owswstzeIMUvt7wcvHoymVdJc5e
	 +5nSMli4ZbVzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E9E38111D8;
	Thu,  5 Jun 2025 10:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] pull request: fixes for ovpn 2025-06-03
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174912063625.3023822.342069446199465127.git-patchwork-notify@kernel.org>
Date: Thu, 05 Jun 2025 10:50:36 +0000
References: <20250603111110.4575-1-antonio@openvpn.net>
In-Reply-To: <20250603111110.4575-1-antonio@openvpn.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, michal.swiatkowski@linux.intel.com,
 sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Antonio Quartulli <antonio@openvpn.net>:

On Tue,  3 Jun 2025 13:11:05 +0200 you wrote:
> Hi netdev-team,
> [2025-06-03: added WRITE_ONCE() to 1/5]
> 
> In this batch you can find the following bug fixes:
> 
> Patch 1: when releasing a UDP socket we were wrongly invoking
> setup_udp_tunnel_sock() with an empty config. This was not
> properly shutting down the UDP encap state.
> With this patch we simply undo what was done during setup.
> 
> [...]

Here is the summary with links:
  - [net,1/5] ovpn: properly deconfigure UDP-tunnel
    https://git.kernel.org/netdev/net/c/930faf1eb8d7
  - [net,2/5] ovpn: ensure sk is still valid during cleanup
    https://git.kernel.org/netdev/net/c/ba499a07ce1d
  - [net,3/5] ovpn: avoid sleep in atomic context in TCP RX error path
    https://git.kernel.org/netdev/net/c/a6a5e87b3ee4
  - [net,4/5] selftest/net/ovpn: fix TCP socket creation
    https://git.kernel.org/netdev/net/c/fdf4064aaebe
  - [net,5/5] selftest/net/ovpn: fix missing file
    https://git.kernel.org/netdev/net/c/9c7e8b31da03

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



