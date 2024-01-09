Return-Path: <netdev+bounces-62559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 116FC827D5C
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 04:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955061F2462A
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 03:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0836D6F4;
	Tue,  9 Jan 2024 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1jCCeXC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F666104
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 03:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05DE2C433C7;
	Tue,  9 Jan 2024 03:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704771025;
	bh=pgy9KDIfKV7+4CciCtar48l9M4cvqUgM0x6L7fxTgH4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d1jCCeXCcA+UMGt5YbbUftAnPqzYf+CHKfPY3LPsGk5pPL7AkdlGsWUBMPJZPOlZU
	 Ac5jkhUgBiiRHJaynPNc/kXfQI4JCgA1mLMVrkB4VZQcMP7n2Y6lBv/AWNmR1lHu+I
	 1v5pqbz40ytUZDXzLXNTgI47rLOmKA5XtPXfakF+gw/LNccJOWUuCBSlS+DEsX680O
	 li+h/0wMA276/hLNIpqISquixnEOYkY/EZV22hmXvYriszFMoSYrVLbKPyV7VYBxSi
	 e8YE8kWUbcTKD+e1bQ4Gt1qgjNbwwwWr5rwMuxcdJBxOb62dncdjul41vNq5S6++3T
	 D2x8opSCldayw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DCC17DFC686;
	Tue,  9 Jan 2024 03:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] bnxt_en: ntuple filter fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170477102490.11770.10821453700953467980.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jan 2024 03:30:24 +0000
References: <20240105235439.28282-1-michael.chan@broadcom.com>
In-Reply-To: <20240105235439.28282-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Jan 2024 15:54:36 -0800 you wrote:
> The first patch is to remove an unneeded variable.  The next 2 patches
> are to release RCU lock correctly after accesing the RCU protected
> filter structure.  Patch 2 also re-arranges the code to look cleaner.
> 
> Michael Chan (3):
>   bnxt_en: Remove unneeded variable in bnxt_hwrm_clear_vnic_filter()
>   bnxt_en: Fix RCU locking for ntuple filters in bnxt_srxclsrldel()
>   bnxt_en: Fix RCU locking for ntuple filters in bnxt_rx_flow_steer()
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] bnxt_en: Remove unneeded variable in bnxt_hwrm_clear_vnic_filter()
    https://git.kernel.org/netdev/net-next/c/1ef4cacaae2f
  - [net-next,2/3] bnxt_en: Fix RCU locking for ntuple filters in bnxt_srxclsrldel()
    https://git.kernel.org/netdev/net-next/c/fd7769798de8
  - [net-next,3/3] bnxt_en: Fix RCU locking for ntuple filters in bnxt_rx_flow_steer()
    https://git.kernel.org/netdev/net-next/c/d8214d0f0135

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



