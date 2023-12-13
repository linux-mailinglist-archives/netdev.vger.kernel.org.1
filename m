Return-Path: <netdev+bounces-56656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BC180FC07
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 01:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C151B20BC3
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 00:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD1E38A;
	Wed, 13 Dec 2023 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPo818Zb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8266410E2
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 00:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B18EC43391;
	Wed, 13 Dec 2023 00:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702426229;
	bh=tPjGEQP0O8rZwzsUkTC/JuY5zOGTheqtz2yolU+uKpA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gPo818ZbH5aly4eA08FVXIbPnd58l86jE16b0l5rxUZ4FZ87hbWAcULxOELfljJDf
	 3zR8MT8MM8mvdKOTs3eBRWz0cW3HZOSxFdbEcC1AMbCA3lRZTXfL8XdgNjfYvtnwio
	 fO6ogbYWZT/7vlwwY5Bm9lxYvqqw9g+AWfvfSQ/RI9YyXkSlvRM7Ubs03XFJLCjCjw
	 4B2TjvRKUE/U70+EM2dNlmWEnkA6L8DRa4a2TJCRh7JyhhTEphEvd4l63X2hYf0WhD
	 0UwWaxc9ZWxuHrxF68wDdRXIS0u7jol74CK02GaI5MshSpneLHsQfiJCHWtxw87xUK
	 NIKYecUyL3aHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07C58DFC906;
	Wed, 13 Dec 2023 00:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/13] bnxt_en: Update for net-next
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170242622902.31821.13197564455147153846.git-patchwork-notify@kernel.org>
Date: Wed, 13 Dec 2023 00:10:29 +0000
References: <20231212005122.2401-1-michael.chan@broadcom.com>
In-Reply-To: <20231212005122.2401-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Dec 2023 16:51:09 -0800 you wrote:
> The first 4 patches in the series fix issues in the net-next tree
> introduced in the last 4 weeks.  The first 3 patches fix ring accounting
> and indexing logic.  The 4th patch fix TX timeout when the TX ring is
> very small.
> 
> The next 7 patches add new features on the P7 chips, including TX
> coalesced completions, VXLAN GPE and UDP GSO stateless offload, a
> new rx_filter_miss counters, and more QP backing store memory for
> RoCE.
> 
> [...]

Here is the summary with links:
  - [net-next,01/13] bnxt_en: Fix trimming of P5 RX and TX rings
    https://git.kernel.org/netdev/net-next/c/f1e50b276d37
  - [net-next,02/13] bnxt_en: Fix AGG ring check logic in bnxt_check_rings()
    https://git.kernel.org/netdev/net-next/c/7fb17a0c18b6
  - [net-next,03/13] bnxt_en: Fix TX ring indexing logic
    https://git.kernel.org/netdev/net-next/c/18fe0a383cca
  - [net-next,04/13] bnxt_en: Prevent TX timeout with a very small TX ring
    https://git.kernel.org/netdev/net-next/c/f12f551b5b96
  - [net-next,05/13] bnxt_en: Support TX coalesced completion on 5760X chips
    https://git.kernel.org/netdev/net-next/c/6dea3ebe0d22
  - [net-next,06/13] bnxt_en: Allocate extra QP backing store memory when RoCE FW reports it
    https://git.kernel.org/netdev/net-next/c/297e625bf89e
  - [net-next,07/13] bnxt_en: Use proper TUNNEL_DST_PORT_ALLOC* commands
    https://git.kernel.org/netdev/net-next/c/e6f8a5a8ecc9
  - [net-next,08/13] bnxt_en: Add support for VXLAN GPE
    https://git.kernel.org/netdev/net-next/c/77b0fff55dcd
  - [net-next,09/13] bnxt_en: Configure UDP tunnel TPA
    https://git.kernel.org/netdev/net-next/c/960096334417
  - [net-next,10/13] bnxt_en: add rx_filter_miss extended stats
    https://git.kernel.org/netdev/net-next/c/6ce30622547d
  - [net-next,11/13] bnxt_en: Add support for UDP GSO on 5760X chips
    https://git.kernel.org/netdev/net-next/c/feeef68f6f3d
  - [net-next,12/13] bnxt_en: Skip nic close/open when configuring tstamp filters
    https://git.kernel.org/netdev/net-next/c/84793a499578
  - [net-next,13/13] bnxt_en: Make PTP TX timestamp HWRM query silent
    https://git.kernel.org/netdev/net-next/c/056bce63c469

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



