Return-Path: <netdev+bounces-25595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08A5774E05
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 00:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8465C1C20F9F
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C63918037;
	Tue,  8 Aug 2023 22:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB15F1802B
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 22:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A9E9C433CB;
	Tue,  8 Aug 2023 22:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691532626;
	bh=WKGXWxFTPGe5rOCTFMv7qFop5jSm+DWrw9yT4MUWMDY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dBW8i2C+BR9TzecA0g2WKsO+Y6z0JagxoNsDWY3B8yRmknYGxoHY3dgXxdPYdWm9G
	 s/0EVT5/gcF60QD7tnAh35hc4PJF0kyDEDag8K0z12wfjAusPHeuqQw0/sCsAcWa0e
	 NXt9RU9ZvqrYe5VsB7TydbYEikEGu7YCgruDRlqkUt9P/OrA5WVMLtNOO17uO2Pgl8
	 8yZeRbIkDi0Z3RP1BwSRPJRyRwdl/8gE5G1OHXUQlP6C7TAhVQM65NuWydsiwOnZU8
	 O5bcUmFTeL6iteds4UQZ8g64oInP5G2In8CWF8kTZ+fOMy0u88XFUtyrgijK4zHKLk
	 mqt1WUDYy1vBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70AA6E33094;
	Tue,  8 Aug 2023 22:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] bnxt_en: Fix 2 compile warnings in bnxt_dcb.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169153262645.13746.15905080876234597676.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 22:10:26 +0000
References: <20230807145720.159645-1-michael.chan@broadcom.com>
In-Reply-To: <20230807145720.159645-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com,
 gustavo@embeddedor.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Aug 2023 07:57:18 -0700 you wrote:
> Fix 2 similar warnings in bnxt_dcb.c related to the cos2bw interface
> definitions in bnxt_hsi.h.
> 
> Michael Chan (2):
>   bnxt_en: Fix W=1 warning in bnxt_dcb.c from fortify memcpy()
>   bnxt_en: Fix W=stringop-overflow warning in bnxt_dcb.c
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] bnxt_en: Fix W=1 warning in bnxt_dcb.c from fortify memcpy()
    https://git.kernel.org/netdev/net-next/c/ac1b8c978a7a
  - [net-next,2/2] bnxt_en: Fix W=stringop-overflow warning in bnxt_dcb.c
    https://git.kernel.org/netdev/net-next/c/3d5ecada049f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



