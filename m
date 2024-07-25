Return-Path: <netdev+bounces-113026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6573C93C55C
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 16:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250D6280F0D
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 14:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE1219AD91;
	Thu, 25 Jul 2024 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbgQsMCw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACD78468
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721919034; cv=none; b=k4VRhe0s7bcKn7jw01oNs9hsyEteY5EWLduTvKL1XMR3JvEeCDMlnL1Vpryb2QIEonDa62fwiGqQa5kHwFsw/6COGVJIbXrPbyHVtMLy8X7A+WZzON5rALJYItbRMkbA0ffVHs718ICyJUNUX9tFsOYacXtj+I53dngZKqFr/N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721919034; c=relaxed/simple;
	bh=JVm43ljPpKFsU/CaChcVfHId7f2g8Qi/NIn0kPoJb3s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oDmbH7Podzk0ZdtynINcGPLzV61rENmDkzcwCJppFhTP229Nejen8JWt/HbCrA7aAm0dmHFv2s7p+69Jg2XXhSXsvve0PePUsyfkwcmsaZypjVf7gfwmoh429t2dKY7eslj6vekKC28F1wl+/sqM9vkKLgCuuc/OL9+pvg5q7Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbgQsMCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43AE7C4AF07;
	Thu, 25 Jul 2024 14:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721919034;
	bh=JVm43ljPpKFsU/CaChcVfHId7f2g8Qi/NIn0kPoJb3s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hbgQsMCwv1bvYkADvpe3VXCKv7GYu9aHaAjsEoFZTdZTifALP3WE66qnmuFQ29n0l
	 2GP994LsXywqgzlbrUfL1XM8SJ2Rj8Vz+uyHHLvQFIDljGCgstVY4yIx7IjJ7hRToM
	 yBgy1S5/T9MSVq1f7gr3FfFRz2r+yrCOBS6aR1Ggh2wMXLjzzQkuc20Ok02U8dEEOs
	 Xun5ly41R5iclPzx2q5hsoI7qnSTkaLzWXXxDvwxCQaRt6qGaBPIk/Z2W/VLHOe9mB
	 MxucspC9p9SCqO4N5ZYSpmh5pMoS8boLdyM9huXTnX2ywy1j6NLaWpius1y+FHXBe4
	 P6SiGc3l7W0Eg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33B04C4332F;
	Thu, 25 Jul 2024 14:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bnxt_en: update xdp_rxq_info in queue restart logic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172191903420.31720.11517062632371090454.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jul 2024 14:50:34 +0000
References: <20240721053554.1233549-1-ap420073@gmail.com>
In-Reply-To: <20240721053554.1233549-1-ap420073@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, michael.chan@broadcom.com, netdev@vger.kernel.org,
 somnath.kotur@broadcom.com, dw@davidwei.uk, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 21 Jul 2024 05:35:54 +0000 you wrote:
> When the netdev_rx_queue_restart() restarts queues, the bnxt_en driver
> updates(creates and deletes) a page_pool.
> But it doesn't update xdp_rxq_info, so the xdp_rxq_info is still
> connected to an old page_pool.
> So, bnxt_rx_ring_info->page_pool indicates a new page_pool, but
> bnxt_rx_ring_info->xdp_rxq is still connected to an old page_pool.
> 
> [...]

Here is the summary with links:
  - [net,v2] bnxt_en: update xdp_rxq_info in queue restart logic
    https://git.kernel.org/netdev/net/c/b537633ce57b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



