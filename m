Return-Path: <netdev+bounces-24158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1073E76F059
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 19:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46FCB1C20832
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 17:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E9F24175;
	Thu,  3 Aug 2023 17:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E380924170
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 17:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B42DC433CA;
	Thu,  3 Aug 2023 17:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691082622;
	bh=rRRAZWtGjW0m8fmR7xGvje/vBtWVT3mgxWcgMHWGj2g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IJ49mEbTwA/Te99SRzv4tH3meGD1JRlRTIt1VTyq4Ilbj+KziKXz/+XWJDIpU2cI3
	 +zGFXMtk+GTlU1hKeulrsAY7EshEcvL+cG78bLs5Y9/0ch2s7U2IAd9MzzzbsrnykM
	 MSGr5tlPROrcsCiZsFwg6hyL0RnJUshZtf50EO8UBCWa7AzCNBZRNkl+137H95OOeh
	 gYEh5MMEX0kDxWeJvZSxp+ZgbDlsd10/l8bZU1DbPGadVmGqIkMMxNzyQM5cFAvqQz
	 mws2vlTiVzgyJktCa6YKiRtI3xEGBXFxvNRXrRdBbodx/78F6QZ3a3/1PjgYYeLxFX
	 KYnoWSH2j/Z9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E013C595C1;
	Thu,  3 Aug 2023 17:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] docs: net: page_pool: sync dev and kdoc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169108262224.22535.14254448439348599449.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 17:10:22 +0000
References: <20230802161821.3621985-1-kuba@kernel.org>
In-Reply-To: <20230802161821.3621985-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, aleksander.lobakin@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Aug 2023 09:18:19 -0700 you wrote:
> Document PP_FLAG_DMA_SYNC_DEV based on recent conversation.
> Use kdoc to document structs and functions, to avoid duplication.
> 
> Olek, this will conflict with your work, but I think that trying
> to make progress in parallel is the best course of action...
> Retargetting at net-next to make it a little less bad.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] docs: net: page_pool: document PP_FLAG_DMA_SYNC_DEV parameters
    https://git.kernel.org/netdev/net-next/c/e70380650a32
  - [net-next,v2,2/2] docs: net: page_pool: use kdoc to avoid duplicating the information
    https://git.kernel.org/netdev/net-next/c/82e896d992fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



