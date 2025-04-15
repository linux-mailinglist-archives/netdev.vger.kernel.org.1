Return-Path: <netdev+bounces-182864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB346A8A31B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 17:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC901902692
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F8529E061;
	Tue, 15 Apr 2025 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZ2dJAHZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05DB29E057;
	Tue, 15 Apr 2025 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744731609; cv=none; b=N5OsRde4Bk6uf5kUMB+sqpvMuHx7R5Xc/Hrch6tjsP5ZZZV2dsYEji/NIkVwGLNBiJLxvjkliUQwFoLPrih4ZNKyKH6m1M3PkGFaEWL7jMAcIPSU/CbqojorACg8GFeaYAq+KiiWzQNh1dtsVGE+u566AtfhRF+bWXKXhtbm8/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744731609; c=relaxed/simple;
	bh=5mg9Z64bCpKpIIpcC0BqYxuIjrycrX/0DIFqvmluXnU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tZpBp8L1fcfPzvDRKTu38oFlgDf5Cj0AoqfrHATm2+vgjtNxCbBVSuWYkYS6Uf1HbhMGF1ZpJdUhFjZAF7uc8fCZKtIwZvCVcdKbdpOkBObH5VBuq43OEd9b2S+8B5biq5fS+I0tTlQyyVQNDI3ipYqg7Jf5AWaIQFhvuCXvCZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZ2dJAHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F97C4CEEF;
	Tue, 15 Apr 2025 15:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744731608;
	bh=5mg9Z64bCpKpIIpcC0BqYxuIjrycrX/0DIFqvmluXnU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kZ2dJAHZEFCx8JMm7l4tFUV+YKv7SYsmpEgLVianYG7XCfZGSVybMljiUMtKq/qP9
	 UzWeofPEE+wF52cQuDDd4wMw+O6QKc9DIDC3kaI1sGcfzcgn7NkwFGNfX4EAmFvHa5
	 DPrAbNobWzyzjbkwGWk+jmof6TWvWuMDqZcRhUOl5mlfXfK+aoPuFxa+r3hgpaJSu0
	 /P0bb+7iGulQLKM7lpOSyNmEoU2/3AGTefuXv4sG/F1OuPXVBZv544pHVUWnvMTVN/
	 VBXbQyd9aEn6RYhKH3i2db8HsFOPK5DlmFpJOrbGQTZro4pYZUmGDjRymABol96mHp
	 98tSV78UUzMyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CD33822D55;
	Tue, 15 Apr 2025 15:40:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] qed deadcoding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174473164624.2680773.10700489026700314444.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 15:40:46 +0000
References: <20250414005247.341243-1-linux@treblig.org>
In-Reply-To: <20250414005247.341243-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: manishc@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Apr 2025 01:52:42 +0100 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Hi,
>   This is a set of deadcode removals for the qed ethernet
> device.  I've tried to avoid removing anything that
> are trivial firmware wrappers.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] qed: Remove unused qed_memset_*ctx functions
    https://git.kernel.org/netdev/net-next/c/e056d3d70388
  - [net-next,2/5] qed: Remove unused qed_calc_*_ctx_validation functions
    https://git.kernel.org/netdev/net-next/c/fa381e21a907
  - [net-next,3/5] qed: Remove unused qed_ptt_invalidate
    https://git.kernel.org/netdev/net-next/c/3c18acefaf9f
  - [net-next,4/5] qed: Remove unused qed_print_mcp_trace_*
    https://git.kernel.org/netdev/net-next/c/058fa8736570
  - [net-next,5/5] qed: Remove unused qed_db_recovery_dp
    https://git.kernel.org/netdev/net-next/c/915359abc68c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



