Return-Path: <netdev+bounces-17889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BB8753686
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 11:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0921C21613
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 09:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DD3FC14;
	Fri, 14 Jul 2023 09:30:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072B3F9FE
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 09:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FB7CC433C9;
	Fri, 14 Jul 2023 09:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689327023;
	bh=mVo5/EDqkTNsP+lUQZUcWTJmfP3T/nO3C4QAcsibzqU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TBW3hIhPwBgznA4xxudRlO7wwcQkR0eZOTjrPL1RxUJqknU7rk3Iq773Pwumwvnry
	 Pjb0gslK8uM9ftmK2bl+RmQ1LYprytswrVX2PTRIoVYdClOhTu5VQniFasW9rzkkzT
	 gGyglX1j48SQYM6L3p5/Ju6YRSJWbvhYX6aKElsAHAcIaXCis/1mrnwJtcO2eAQdTR
	 A5aIIxabZNmBkmfE8pnW9YmLpKq5+Sp9z2G8a8+mEhODVpQ+ordg/kNJrDG0htrnpU
	 L7+OSFaSWfnJye7XcyXHRe0o3qUJD0YOhAp5jxw/MKKJ4dSRTeCIr+O48VaOAWB87S
	 NlymoBSdE9e1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C6ABF83708;
	Fri, 14 Jul 2023 09:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] gve: trivial spell fix Recive to Receive
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168932702330.18845.16437279432945002152.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jul 2023 09:30:23 +0000
References: <168926364598.10492.9222703767497099182.stgit@firesoul>
In-Reply-To: <168926364598.10492.9222703767497099182.stgit@firesoul>
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: kernel-janitors@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 13 Jul 2023 17:54:37 +0200 you wrote:
> Spotted this trivial spell mistake while casually reading
> the google GVE driver code.
> 
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>  drivers/net/ethernet/google/gve/gve_desc.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> [...]

Here is the summary with links:
  - [net-next] gve: trivial spell fix Recive to Receive
    https://git.kernel.org/netdev/net-next/c/68af900072c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



