Return-Path: <netdev+bounces-29748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BEE7848F1
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33441C20AFA
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D941E509;
	Tue, 22 Aug 2023 18:00:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD1B1DA54
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 18:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F4FDC433CB;
	Tue, 22 Aug 2023 18:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692727224;
	bh=eASsO09yRi7+uXhs+qk1cmdjBEGFwqDTjZhc4h/LUAY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a0t+jmhat/H6/60M5ssGNT/UBlLSLN9TgfnWq4LV6yqMNOGx1W5Dnx+uprUyJ30BC
	 l2T+Ae3aiPUMs4lUw5Fjlsu188BL0CX3A0kHLerN+ihafolNO4MqlI+8pNNF2Oo3/h
	 ffw9tnIaEzrKaUR+GCbo6I0Tf5iHKYxlB1MajLXYQNBGH0OtiZSrgY1ijGSjQhOSkd
	 PF8pfIKG8+Al1ZqBBN/RZN+VK3FFATWFiDMvzczqBv36Op731YFjQVmMDPVLOD+EWk
	 J1tX8mJgKDjEzg7oWa/78iZqWleacZtoMbHdYNPZ4pk1JAugRC3fkWyJuLpfFLP9KN
	 jBj6K7JeFzDiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7611CE21EE4;
	Tue, 22 Aug 2023 18:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: ti: Remove unused declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169272722447.9690.11180090609406853402.git-patchwork-notify@kernel.org>
Date: Tue, 22 Aug 2023 18:00:24 +0000
References: <20230821134029.40084-1-yuehaibing@huawei.com>
In-Reply-To: <20230821134029.40084-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 rogerq@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Aug 2023 21:40:29 +0800 you wrote:
> Commit e8609e69470f ("net: ethernet: ti: am65-cpsw: Convert to PHYLINK")
> removed am65_cpsw_nuss_adjust_link() but not its declaration.
> Commit 84640e27f230 ("net: netcp: Add Keystone NetCP core ethernet driver")
> declared but never implemented netcp_device_find_module().
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethernet: ti: Remove unused declarations
    https://git.kernel.org/netdev/net-next/c/a491add19faf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



