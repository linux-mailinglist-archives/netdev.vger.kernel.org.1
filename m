Return-Path: <netdev+bounces-37598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BA57B6482
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 10:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id EC7A61C20506
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 08:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CC9DDA6;
	Tue,  3 Oct 2023 08:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC211D281;
	Tue,  3 Oct 2023 08:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22CD9C433CA;
	Tue,  3 Oct 2023 08:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696322426;
	bh=JjdivDRIYaFuGeFEooLp1H8IKDzhUAEFxpPYlcWfWow=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jRL3FtY8Mak6fWquofBGr2BV49mFEJJsxHy+NTCUhK5nMvelMzm8CVxt0mjuql3C0
	 5QQvhFKJu1u89C7dKZmRzVg6bxME1YzYL+ZLLhCDUQAlFmjmF8SvzK7qV/qxHUe65K
	 xz9tjumbBazAJ/WZehtqO01/xFpNI7IHU13ym46QSexfPg8V29/qn+GrJ8JNj29fkG
	 X3MLH4MBayPZL6FihNtx2uZAe7CchFUviFUuvJURqkmpaJuL4yLmjjV+7v/g977ZMG
	 kFunjp526rtrGl8yI7WWJXX9Vn3PbT2KMpivFmNXuDtgxrZivbcuBS+PTceaG1/SAO
	 SPN8MGRv38uIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05276E632D8;
	Tue,  3 Oct 2023 08:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qed/red_ll2: Fix undefined behavior bug in struct
 qed_ll2_info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169632242601.9748.14967908798498404874.git-patchwork-notify@kernel.org>
Date: Tue, 03 Oct 2023 08:40:26 +0000
References: <ZQ+Nz8DfPg56pIzr@work>
In-Reply-To: <ZQ+Nz8DfPg56pIzr@work>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: aelior@marvell.com, manishc@marvell.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Michal.Kalderon@cavium.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 23 Sep 2023 19:15:59 -0600 you wrote:
> The flexible structure (a structure that contains a flexible-array member
> at the end) `qed_ll2_tx_packet` is nested within the second layer of
> `struct qed_ll2_info`:
> 
> struct qed_ll2_tx_packet {
> 	...
>         /* Flexible Array of bds_set determined by max_bds_per_packet */
>         struct {
>                 struct core_tx_bd *txq_bd;
>                 dma_addr_t tx_frag;
>                 u16 frag_len;
>         } bds_set[];
> };
> 
> [...]

Here is the summary with links:
  - qed/red_ll2: Fix undefined behavior bug in struct qed_ll2_info
    https://git.kernel.org/netdev/net/c/eea03d18af9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



