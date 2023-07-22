Return-Path: <netdev+bounces-20087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E9E75D8E1
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 04:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2C2282546
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 02:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD9B63C4;
	Sat, 22 Jul 2023 02:10:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEF86AA0
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 02:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01BE9C433C9;
	Sat, 22 Jul 2023 02:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689991820;
	bh=UsCL7n8ZbjFv4PmIhx+hchDRbus/yXH2TcTibEMKQPI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iFrk2Ed5dPfUEgtQNRh+YL/UOdsVT7VgONhIcqQvt23ut5Wv1qUY54NoLlJq4f+HS
	 lSYGLDLVLAJf4TLou829hCieDbBnIQMxMbzrjZo6fE8lMEHTpQ+oDTlpLUY5wS1NTE
	 PEcXySfxRQzoS5Fj+HNNwSbum0aHCmJjKCdhgVID/NRQgJLC8Cu5DFHCKC66pXH00F
	 5ucJQH6nhvzl9XiMja3gxBgVc8LKkW+J1+4fzqf+zYncm2vTNHyqERIeUlxZMQwmvJ
	 TGsRUFtxrumE/yUwvTDg5MZueW2XfNrFUxdbCt5f/hiH5RKAuZLhi0LKVhzwQoPy9l
	 5sDtQkGx1s2mw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7CACC595C1;
	Sat, 22 Jul 2023 02:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] docs: net: clarify the NAPI rules around XDP Tx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168999181988.11383.16650443656675994636.git-patchwork-notify@kernel.org>
Date: Sat, 22 Jul 2023 02:10:19 +0000
References: <20230720161323.2025379-1-kuba@kernel.org>
In-Reply-To: <20230720161323.2025379-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Jul 2023 09:13:23 -0700 you wrote:
> page pool and XDP should not be accessed from IRQ context
> which may happen if drivers try to clean up XDP TX with
> NAPI budget of 0.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: corbet@lwn.net
> CC: linux-doc@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net] docs: net: clarify the NAPI rules around XDP Tx
    https://git.kernel.org/netdev/net/c/32ad45b76990

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



