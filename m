Return-Path: <netdev+bounces-108077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4441991DCD2
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 12:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2FCE282B3D
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F5C46542;
	Mon,  1 Jul 2024 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1LZVcdC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FD73B2BB
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829837; cv=none; b=Avk3Vyc+tN7J0D4ZEuBfYK5NB2ZVQEF0uXfHTQdrnaHorf8IpX1jRXh+2/K7Ay+7qJQaWl3M3jrgkNwb3LzoXAEF+yljAkmyPfBXV/O/C5d6WXSrBEx7PX0e4NPMG9kjnvI3K4XVEkBTw3JU3/yNRyIh2A4fWeQbITuuTTbKHzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829837; c=relaxed/simple;
	bh=g4hrXWHsYggdqVLLKbJW9Azs1oivvLW/glQ60xb09Ts=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CZZbT+K7aZhKyfTzt+SfjZtXAOXHRKzNBMJz6SqCB9A2KNbCoB3P+g1JkFGyORjGPaUk0BOtz7lfEtquTVksbZseb/62dt0a5+aMkQ2sv2i9lPehgqn1vDfR/IPknDBaaEsaaEdbkFJ0QefRiuULplCAUrQ0R7VnDPDx9ZI9nQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1LZVcdC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DE5AC32786;
	Mon,  1 Jul 2024 10:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719829837;
	bh=g4hrXWHsYggdqVLLKbJW9Azs1oivvLW/glQ60xb09Ts=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u1LZVcdCA1uAQakpAoNB4dZI4QPfkqEPS9oyyDUnAl2yu88Ne+dRz1shfhSdnyH0D
	 OP7AKYNIj8PKg4K+MajnyVg2cjSAS4GkzebRpz+AMCF4kTSJ5agzdzXMzXcSpfMMLq
	 77TVkALaFy5DLbwsGXGPyDP5nRzzSCjEjDxA+OAYYuoOpbRi5y4qmKD/JLVyfAAnW5
	 jtz4B5aSS/BBib07XSrZHaidOK8nIQ20JltvZZOKl8d9k0Vy0GHpNRQ4VHGYHcTUT6
	 h7gXp3mOlYy+tVxJO1e+sjsfirx/hCjpA3gtxxpQU8WRnQ9x1JfJyad8qKPgM6o3tk
	 kQ/B/tb9xMaLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18489DE8E0D;
	Mon,  1 Jul 2024 10:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/10] bnxt_en: PTP updates for net-next
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171982983709.14870.6930247684372535647.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jul 2024 10:30:37 +0000
References: <20240628193006.225906-1-michael.chan@broadcom.com>
In-Reply-To: <20240628193006.225906-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, richardcochran@gmail.com, horms@kernel.org,
 przemyslaw.kitszel@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 28 Jun 2024 12:29:55 -0700 you wrote:
> The first 5 patches implement the PTP feature on the new BCM5760X
> chips.  The main new hardware feature is the new TX timestamp
> completion which enables the driver to retrieve the TX timestamp
> in NAPI without deferring to the PTP worker.
> 
> The last 5 patches increase the number of TX PTP packets in-flight
> from 1 to 4 on the older BCM5750X chips.  On these older chips, we
> need to call firmware in the PTP worker to retrieve the timestamp.
> We use an arry to keep track of the in-flight TX PTP packets.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/10] bnxt_en: Add new TX timestamp completion definitions
    https://git.kernel.org/netdev/net-next/c/be6b7ca3c2ae
  - [net-next,v2,02/10] bnxt_en: Add is_ts_pkt field to struct bnxt_sw_tx_bd
    https://git.kernel.org/netdev/net-next/c/449da97512f3
  - [net-next,v2,03/10] bnxt_en: Allow some TX packets to be unprocessed in NAPI
    https://git.kernel.org/netdev/net-next/c/ba0155f1e9fc
  - [net-next,v2,04/10] bnxt_en: Add TX timestamp completion logic
    https://git.kernel.org/netdev/net-next/c/1d294b4f903f
  - [net-next,v2,05/10] bnxt_en: Add BCM5760X specific PHC registers mapping
    https://git.kernel.org/netdev/net-next/c/4d588d32b032
  - [net-next,v2,06/10] bnxt_en: Refactor all PTP TX timestamp fields into a struct
    https://git.kernel.org/netdev/net-next/c/92595a0c0223
  - [net-next,v2,07/10] bnxt_en: Remove an impossible condition check for PTP TX pending SKB
    https://git.kernel.org/netdev/net-next/c/573f2a4bfcd4
  - [net-next,v2,08/10] bnxt_en: Let bnxt_stamp_tx_skb() return error code
    https://git.kernel.org/netdev/net-next/c/9bf688d40d66
  - [net-next,v2,09/10] bnxt_en: Increase the max total outstanding PTP TX packets to 4
    https://git.kernel.org/netdev/net-next/c/8aa2a79e9b95
  - [net-next,v2,10/10] bnxt_en: Remove atomic operations on ptp->tx_avail
    https://git.kernel.org/netdev/net-next/c/060338390787

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



