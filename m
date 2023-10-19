Return-Path: <netdev+bounces-42473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17E87CED33
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 03:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6E01C20B36
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 01:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BDB394;
	Thu, 19 Oct 2023 01:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGAZ5CIx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DB0391
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 01:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65A7CC433C9;
	Thu, 19 Oct 2023 01:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697677822;
	bh=DuRZTW1jUGcKtWP2D9yELL1QF6dKAc3J3NvjrvptXIg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YGAZ5CIxxxirAzntx+kYQFhHqr5iChT7+uyX/EpHZV3Mtdu+4eYSkPa7eTr3d+Azq
	 dPGWsy2upJH6aDKRGtbUeerDaHTJCl7ju5gYPzd2VVMP6Uy0QzPgULOf/ukS4oy/5g
	 IKHBZt5IPS5zX47H8E87Jkd/BrZw8wTvwEwY/9sTud40hBMPf5ZBiEygq0t1YgNdNi
	 dQPTIe0mgdSyHL5faGbinpSLyapwMrTd5YS216IiC/vwKWpnNuk1G51AtYXoWhx0jC
	 SA2Eqgg8Joqn6fWJzYzhFnz8QAkGCvZrQMSOB+8r8oivISVMG6LPh40S9YHKTNDbXD
	 4lB/G4jHf/9zw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49C5BC04E24;
	Thu, 19 Oct 2023 01:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] octeon_ep: update BQL sent bytes before ringing
 doorbell
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169767782229.12246.9567863592297090528.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 01:10:22 +0000
References: <20231017105030.2310966-1-srasheed@marvell.com>
In-Reply-To: <20231017105030.2310966-1-srasheed@marvell.com>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: kuba@kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, egallen@redhat.com,
 hgani@marvell.com, mschmidt@redhat.com, netdev@vger.kernel.org,
 sedara@marvell.com, vburru@marvell.com, vimleshk@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Oct 2023 03:50:30 -0700 you wrote:
> Sometimes Tx is completed immediately after doorbell is updated, which
> causes Tx completion routing to update completion bytes before the
> same packet bytes are updated in sent bytes in transmit function, hence
> hitting BUG_ON() in dql_completed(). To avoid this, update BQL
> sent bytes before ringing doorbell.
> 
> Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] octeon_ep: update BQL sent bytes before ringing doorbell
    https://git.kernel.org/netdev/net/c/a0ca6b9dfef0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



