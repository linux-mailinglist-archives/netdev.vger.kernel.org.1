Return-Path: <netdev+bounces-27882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34AB77D827
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 04:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5422816E0
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 02:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E240B3FDC;
	Wed, 16 Aug 2023 02:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E0717E9;
	Wed, 16 Aug 2023 02:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADB7CC4339A;
	Wed, 16 Aug 2023 02:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692151822;
	bh=LEZiyAZvEFf3DpLJrZwKPIG/qGDBJjfBRWr7FWdg6v4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JoOoEOO8DdvoFLVXg0WWZwr2HzVw1Tp6xisYS2s61PcO6pHtdD+Z2+9ysQm9Y/d8d
	 hScf63lQjbCqNflmQvPLRZIGqD63balgLlZkB7XMIzDUgiL5moEveLQQJljPFTq4vD
	 1Vr2+QbJPPFBF0B27lxVuVqjtPNicCPdIJ8qsBXbNgi5vij1QFRLjPQ/5azjfomfU2
	 +bfGgMFdc3mxWqXBGDuhOcFdPEbMMAwZLrS91lm8tis0hTk+Vdkqx7zUM5+Ue2ypBb
	 GyCcthQbC3MALJ83ktiZ58vN3ClJ1tUVqsezMLEpeqToJhcZJ8kxe6qefsBIOOYfWY
	 EIYl+WtKPVaZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92F15C395C5;
	Wed, 16 Aug 2023 02:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qed: remove unused 'resp_size' calculation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169215182259.21752.4980057098192603283.git-patchwork-notify@kernel.org>
Date: Wed, 16 Aug 2023 02:10:22 +0000
References: <20230814074512.1067715-1-arnd@kernel.org>
In-Reply-To: <20230814074512.1067715-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: aelior@marvell.com, manishc@marvell.com, arnd@arndb.de,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
 Yuval.Mintz@qlogic.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Aug 2023 09:45:03 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Newer versions of clang warn about this variable being assigned but
> never used:
> 
> drivers/net/ethernet/qlogic/qed/qed_vf.c:63:67: error: parameter 'resp_size' set but not used [-Werror,-Wunused-but-set-parameter]
> 
> [...]

Here is the summary with links:
  - qed: remove unused 'resp_size' calculation
    https://git.kernel.org/netdev/net-next/c/7a456b894ea5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



