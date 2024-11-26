Return-Path: <netdev+bounces-147453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F7B9D99CB
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 15:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989262823B1
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 14:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CD71D5CC5;
	Tue, 26 Nov 2024 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLF99ZKL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820C01D5171
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732632021; cv=none; b=oLzlY8qRQHKYp3zoEdK+4UwijXyFpb0bKrYNtZx9XoVx/O8L85UUuEW7ZPhZyOhwMO6e/mSWmBej6EpG1K8zF0wcYXD/C3191DcQHJtlLhosV7PJMPr3F8g8j2LpjFpfPfWNbDUs4M1qdLDU8Sq2Lnp0ZnygFzMlgJFwgh4J4V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732632021; c=relaxed/simple;
	bh=z2z0kAq5TYDJl7YTR/0hm9MQbIPCgRrNz9aRFJaLuFA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bS+QJ05hizii/hjKWYpSquFgqTT59lFv8hdoAEanlNVsdgrgqSRgTf5hTT+HEtS2gyHIo5OeZHU0gp1OZJaQ23p+UcIYQMzpd7esMQRG6b1OrmEITcCP6X+U7/mV8bLuM5q42oX2m5Q5kSThD0ijcIuyoWKCmAL9jeIf3NnPITI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLF99ZKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28A1C4CECF;
	Tue, 26 Nov 2024 14:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732632021;
	bh=z2z0kAq5TYDJl7YTR/0hm9MQbIPCgRrNz9aRFJaLuFA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PLF99ZKLFF7gjXR/Ww6Wuu2IGEFvIVokYKuYLU30ZYk+4ZQnNdI5XgkVEOSaW0GHA
	 5DB+t4EvFHGb4k8AGFgVmFnGOB/e2vmGPd6LDuTEm7KPGor17UlxLzwf0rHd+b4qjF
	 0ShTE+XsfaiJ1kUcevOUoJYCJiwTUseWVE5zWHNOOr62RHzaOPpJ21BYqpEAC2pwHX
	 vbvUIjBV23phOrXmjlX/H33MpiUj90Hv1b/kKi+XkycA4EPrGlPigVomXcW5kjfUA4
	 y5Y0z2BH171KjKJH35AQmtM0pyFvk1L5iZ9WXjc2rIRWBt2CiozDuhYCMrb6jHvdG0
	 Cm3QOP3GKpvgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB81F3809A00;
	Tue, 26 Nov 2024 14:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6] bnxt_en: Bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173263203374.429941.10105888625174596505.git-patchwork-notify@kernel.org>
Date: Tue, 26 Nov 2024 14:40:33 +0000
References: <20241122224547.984808-1-michael.chan@broadcom.com>
In-Reply-To: <20241122224547.984808-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 22 Nov 2024 14:45:40 -0800 you wrote:
> This patchset fixes several things:
> 
> 1. AER recovery for RoCE when NIC interface is down.
> 2. Set ethtool backplane link modes correctly.
> 3. Update RSS ring ID during RX queue restart.
> 4. Crash with XDP and MTU change.
> 5. PCIe completion timeout when reading PHC after shutdown.
> 
> [...]

Here is the summary with links:
  - [net,1/6] bnxt_en: Reserve rings after PCIe AER recovery if NIC interface is down
    https://git.kernel.org/netdev/net/c/5311598f7f32
  - [net,2/6] bnxt_en: Set backplane link modes correctly for ethtool
    https://git.kernel.org/netdev/net/c/500799167094
  - [net,3/6] bnxt_en: Fix queue start to update vnic RSS table
    https://git.kernel.org/netdev/net/c/5ac066b7b062
  - [net,4/6] bnxt_en: Fix receive ring space parameters when XDP is active
    https://git.kernel.org/netdev/net/c/3051a77a09df
  - [net,5/6] bnxt_en: Refactor bnxt_ptp_init()
    https://git.kernel.org/netdev/net/c/1e9614cd9562
  - [net,6/6] bnxt_en: Unregister PTP during PCI shutdown and suspend
    https://git.kernel.org/netdev/net/c/3661c05c54e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



