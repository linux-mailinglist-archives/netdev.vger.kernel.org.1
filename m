Return-Path: <netdev+bounces-30850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357A8789346
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 04:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704111C210A2
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 02:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B33393;
	Sat, 26 Aug 2023 02:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2185A394
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 02:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C49CC433CB;
	Sat, 26 Aug 2023 02:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693015825;
	bh=QMZbJji/e1fpxw1gZxdh2oLY8/oVBgJ4/K7tpiPZ+Z8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kiMRXmwPjzcoI3t4LeVjBtfpqfWqLyLkiZ/tGtWiTRrnxZi9Z4nO9oH4oX07oByrL
	 ow3hn0SCQj0H5cQwKGWQBgW1Q4PxSwAeoTpsF8mblwoGX/fHmVOV3MSeYU0BD1Y6X4
	 aHYkx26jSI+tuZXiAEPbN43ws8CkLeYjYzvDZtTCsPMrzaOLB63FpM+KXsea3X0dXh
	 wkgJHs+cfZtFHqYdHCncsvQB0klhahIl2Hh1HvcQrBb8kOjN7euUHVNJgizlJdjo8G
	 dHwSAyMH73BcJ1CsGhVvOEk+Iiuhyoe3ZYfoYL4VOrqiQDUH12JWRP4vDzmcjhHKgb
	 tBI8FPInmrv+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70D3AE33083;
	Sat, 26 Aug 2023 02:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sfc: Check firmware supports Ethernet PTP filter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169301582544.16053.2413651378313017401.git-patchwork-notify@kernel.org>
Date: Sat, 26 Aug 2023 02:10:25 +0000
References: <20230824164657.42379-1-alex.austin@amd.com>
In-Reply-To: <20230824164657.42379-1-alex.austin@amd.com>
To:  <alex.austin@amd.com>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 ihuguet@redhat.com, ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Aug 2023 17:46:57 +0100 you wrote:
> From: Alex Austin <alex.austin@amd.com>
> 
> Not all firmware variants support RSS filters. Do not fail all PTP
> functionality when raw ethernet PTP filters fail to insert.
> 
> Fixes: e4616f64726b ("sfc: support PTP over Ethernet")
> Signed-off-by: Alex Austin <alex.austin@amd.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> 
> [...]

Here is the summary with links:
  - [net] sfc: Check firmware supports Ethernet PTP filter
    https://git.kernel.org/netdev/net/c/c4413a20fa6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



