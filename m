Return-Path: <netdev+bounces-174336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5702DA5E554
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 21:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F83178665
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8104C1EDA17;
	Wed, 12 Mar 2025 20:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsFxTw2H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C021BD9DD;
	Wed, 12 Mar 2025 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741811396; cv=none; b=cMph+wmqdAgViAca3mj9+/i7S/7MJG+7ynw/ZROYhJB2Ln8mIr9jwYfK8W8dSJ+t0YR3+Fh0sN/ToTEI7Gn8n1TMzyYSyasLcaM2MLkxHJgVd7USm7JmfAyOjfnp2yZSkjGPX0+xISMbgha0VbkOp0dKUbJ9nSVwd8xAjRzuD70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741811396; c=relaxed/simple;
	bh=BsDfTZ4J/ZD/x4CEynmxWK5PUtvjFEyamJLg8PXwsTo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j2xa9q/UWM3S6ttbYUkMx2d68wwRwK3oSf7lnP3nQxAN4+Fmsu8ST1eRmRuQkQsYnLC6tPDX2ABySZrpPlCOrp7+Ed7UvuZn7X5qzt8iQFnTZH1PQxtRcVhCzJjwqecKuh3HGIPeg0CUjxw2stUZkzmZyEwchQPRXTNf0KBRofY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsFxTw2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E0CC4CEDD;
	Wed, 12 Mar 2025 20:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741811394;
	bh=BsDfTZ4J/ZD/x4CEynmxWK5PUtvjFEyamJLg8PXwsTo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rsFxTw2HX3gC2BsO6Wah0fc8SRPF4XCrhcyksYCisNi66O/lqF5BF2Pwe3+36jacb
	 NCit5W19Z5brosZoCF134vljEbVAe6J7Azahxvhu7eu21r+xOdV47v35FP+je7Y0jk
	 poG9gaXRHgZW9mh++TUCmGPvR6P3yyGqSg+pKOssf2Tkz8GUjvAU6wo0tIBXkhm0nh
	 6MWuKyJqxoevxkejq1dMjVGU+5zLCSz15NCxlD0xsXMpiDnlK5qbhjyNTKfuuISPTL
	 ZnaEezwg9IRWk8n5dPRVQdHXQ+3NIS+Cx5+ETrZbW/0vj2MCqOm1w9JpI0DOWRGh8y
	 ayJub90Zj/Amw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B8D380DBDF;
	Wed, 12 Mar 2025 20:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/3] eth: bnxt: switch to netif_close
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174181142926.921984.9414050988776137119.git-patchwork-notify@kernel.org>
Date: Wed, 12 Mar 2025 20:30:29 +0000
References: <20250309215851.2003708-1-sdf@fomichev.me>
In-Reply-To: <20250309215851.2003708-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch,
 horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  9 Mar 2025 14:58:49 -0700 you wrote:
> All (error) paths that call dev_close are already holding instance lock,
> so switch to netif_close to avoid the deadlock.
> 
> v2:
> - add missing EXPORT_MODULE for netif_close
> 
> Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] eth: bnxt: switch to netif_close
    (no matching commit)
  - [net-next,v2,2/3] eth: bnxt: request unconditional ops lock
    https://git.kernel.org/netdev/net-next/c/eaca6e5dc6ba
  - [net-next,v2,3/3] eth: bnxt: add missing netdev lock management to bnxt_dl_reload_up
    https://git.kernel.org/netdev/net-next/c/adbf627f1703

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



