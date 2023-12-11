Return-Path: <netdev+bounces-55821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA87480C60F
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 11:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B28B281727
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 10:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6895C25768;
	Mon, 11 Dec 2023 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTvz/BYD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B35824B29
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 10:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A75D4C433C9;
	Mon, 11 Dec 2023 10:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702289423;
	bh=25mXoOKe5YalTwcXvBl99nBaqvQHsxcaUzjVVE/yeuU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fTvz/BYDTgmZ9jp8/k3fD7Th9vc2p2jkWHouz6/UlWepwRNbpFWJqqZq81KiWkhzf
	 7mVlSHZlGeDH7m9sRZHBzSgaFSwS/syAEOWPvH5EB3EsnsOAjo/cs3n6KhT85yYeWo
	 GrU3h8//SmNHLfX1MLSafKdCkotjO6FrPWFMNoZfWhWBvPqx/1dwqfivWqpvUmgwSX
	 vBjDIxX3+qo35HX6R+0WRxGWcL1AaGhyrJ5V+Vha+cf4e7kJ11FV4IHk6QnbVxySOA
	 U+wDJe2GRM3rhoeZnYfUiHEaXWtkJlvLB61UGg2KhWYu/KCBAktJ6Ro1UroD6fOyns
	 nPb6Hh35wK9SQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D6F0DFC906;
	Mon, 11 Dec 2023 10:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] octeon_ep: explicitly test for firmware ready value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170228942357.26769.14270472436980157327.git-patchwork-notify@kernel.org>
Date: Mon, 11 Dec 2023 10:10:23 +0000
References: <20231208055646.2602363-1-srasheed@marvell.com>
In-Reply-To: <20231208055646.2602363-1-srasheed@marvell.com>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
 vimleshk@marvell.com, egallen@redhat.com, mschmidt@redhat.com,
 pabeni@redhat.com, horms@kernel.org, kuba@kernel.org, davem@davemloft.net,
 wizhao@redhat.com, konguyen@redhat.com, vburru@marvell.com,
 sedara@marvell.com, edumazet@google.com, aayarekar@marvell.com,
 sburla@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 7 Dec 2023 21:56:46 -0800 you wrote:
> The firmware ready value is 1, and get firmware ready status
> function should explicitly test for that value. The firmware
> ready value read will be 2 after driver load, and on unbind
> till firmware rewrites the firmware ready back to 0, the value
> seen by driver will be 2, which should be regarded as not ready.
> 
> Fixes: 10c073e40469 ("octeon_ep: defer probe if firmware not ready")
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] octeon_ep: explicitly test for firmware ready value
    https://git.kernel.org/netdev/net/c/284f71762241

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



