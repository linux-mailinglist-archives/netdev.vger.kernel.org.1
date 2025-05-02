Return-Path: <netdev+bounces-187352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D59C4AA6813
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 03:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928991BC0F64
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 01:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1245273FD;
	Fri,  2 May 2025 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJV1+yP4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF711D554
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746147611; cv=none; b=evQvTJgbWxjgnaM/G/2HYwtsT/C+xYjbULwJJgeYpFVRDp84tYgBsqPPjD7n6HNlL5dxVqPFEC+jIZQhPKjV1a7kaNmSOeZR9J3UfroOxMRmWpBSligqNr7Xdpmx2QvnerpJJpBuSz4Ne9GvKP4aAGPvBtJ+qzDuFs0ITBC2kZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746147611; c=relaxed/simple;
	bh=oETiaGMw3peCTlYjqcrh/u3VNVOp4CruXRpVbAqgExQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u2kOwDK5nYrY6zzNOddp39qh8ScWlyZGQm/upXVQFZ6PTVATbYTlAiF5Dhq7ckysSCEAnXnBbl37MQjj+/M3lFcn83xQEFx/O1mvYCEGazgokXLgOrHXBdA2wsn0aSfRO/XgY2cQxqZSIuJCx7mPs5qmZKzbofDg7/tNs5tgC4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJV1+yP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E79C4CEE3;
	Fri,  2 May 2025 01:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746147609;
	bh=oETiaGMw3peCTlYjqcrh/u3VNVOp4CruXRpVbAqgExQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WJV1+yP4wd2FR945SdRnMwaifQy0EcboDIgcPBXayfa4IjDhIvWIwP2rZs7a8KGvD
	 8AMnxxUzACURlCh/mCozl5akRHqVlq9W6FsZL77rR8jb1+ol7EPdKu7xVhrpBttnKE
	 580b0tV/aOEc03bVmzH59NOON7xD3gU2WqQ6ES9PHxtjLV0n3oSZ7WJ9urYWMFc3ny
	 OBGDohnrSQhZ7/pBvj3frHPLg9Web1jpoQMz3W4+4NKJmCUcMUB/2lCqrX5xt5EJfo
	 Blxasx64IRyO0/Z0UQ/9aryyUywQglKiUDp8d/24Up4GIMdcyz+0LFcAEIzpGHviC7
	 vvuPbBPOCsYXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D123822D59;
	Fri,  2 May 2025 01:00:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/13][pull request] Intel Wired LAN Driver Updates
 2025-04-29 (igb, igc, ixgbe, idpf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174614764900.3121766.588855584070943085.git-patchwork-notify@kernel.org>
Date: Fri, 02 May 2025 01:00:49 +0000
References: <20250429234651.3982025-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250429234651.3982025-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 29 Apr 2025 16:46:35 -0700 you wrote:
> For igb:
> Kurt Kanzenbach adds linking of IRQs and queues to NAPI instances and
> adds persistent NAPI config. Lastly, he removes undesired IRQs that
> occur while busy polling.
> 
> For igc:
> Kurt Kanzenbach switches the Tx mode for MQPRIO offload to harmonize the
> current implementation with TAPRIO.
> 
> [...]

Here is the summary with links:
  - [net-next,01/13] igb: Link IRQs to NAPI instances
    https://git.kernel.org/netdev/net-next/c/6fc54c408dc9
  - [net-next,02/13] igb: Link queues to NAPI instances
    https://git.kernel.org/netdev/net-next/c/b75a1dea500f
  - [net-next,03/13] igb: Add support for persistent NAPI config
    https://git.kernel.org/netdev/net-next/c/fc0fb1f116e9
  - [net-next,04/13] igb: Get rid of spurious interrupts
    https://git.kernel.org/netdev/net-next/c/a22ed15c99a0
  - [net-next,05/13] igc: Limit netdev_tc calls to MQPRIO
    https://git.kernel.org/netdev/net-next/c/68f37f26b0ff
  - [net-next,06/13] igc: Change Tx mode for MQPRIO offloading
    https://git.kernel.org/netdev/net-next/c/876863c3fc75
  - [net-next,07/13] ixgbe: create E610 specific ethtool_ops structure
    https://git.kernel.org/netdev/net-next/c/462cc09ac37d
  - [net-next,08/13] ixgbe: add support for ACPI WOL for E610
    https://git.kernel.org/netdev/net-next/c/451c6bc923e2
  - [net-next,09/13] ixgbe: apply different rules for setting FC on E610
    https://git.kernel.org/netdev/net-next/c/7f58648dbc53
  - [net-next,10/13] ixgbe: add E610 .set_phys_id() callback implementation
    https://git.kernel.org/netdev/net-next/c/4bf2d11902ef
  - [net-next,11/13] ixgbe: devlink: add devlink region support for E610
    https://git.kernel.org/netdev/net-next/c/fe259a1bb26e
  - [net-next,12/13] idpf: assign extracted ptype to struct libeth_rqe_info field
    https://git.kernel.org/netdev/net-next/c/508d374b8dc0
  - [net-next,13/13] idpf: remove unreachable code from setting mailbox
    https://git.kernel.org/netdev/net-next/c/c058c5f8b6e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



