Return-Path: <netdev+bounces-14618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66485742AF1
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 19:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9654C1C20AA8
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 17:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AB313AC3;
	Thu, 29 Jun 2023 17:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4B7134D4
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 17:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9CC0C433C8;
	Thu, 29 Jun 2023 17:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688058022;
	bh=jifAkiBI/CrBj7P6QISEb1V2H4847hk3VBaJlkypxpk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vn5A+otrMbqMupmDMTMqYAELkkn1oIKIVpnsazAHwMTuYOP7YzXczusCng4dHoqXM
	 OmA4H6Sc5bQ5NssO4Gz1Woj0jn3Y72TwgXp+bIkVupD5ghwBDOlQ3RNwqzWj9al0Op
	 C8h9FPufZSIklQv0HHNbAL10wGE56aU31kEsBLyhBIsS/DW18RWxod262Lo2SAQE5k
	 YJe3qzf3KTucSDlV9k9VQv0ZAu/ndCK0Ak/2ZLW/7kw0zQTvVMo12MK2Kpkz5fOH7/
	 qPpc+EPBbI+2Xj12IjBGLc0oSxp1rh2hI1vmLVdmROt7bppz0wnSRxOXIQgNB+CTBt
	 AjQmeKrXlqnqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B4CBC43158;
	Thu, 29 Jun 2023 17:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Add MODULE_FIRMWARE() for FIRMWARE_TG357766.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168805802256.17171.1706510206505722006.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jun 2023 17:00:22 +0000
References: <ZJt7LKzjdz8+dClx@tobhe.de>
In-Reply-To: <ZJt7LKzjdz8+dClx@tobhe.de>
To: Tobias Heider <me@tobhe.de>
Cc: siva.kallam@broadcom.com, prashant@broadcom.com, mchan@broadcom.com,
 netdev@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Jun 2023 02:13:32 +0200 you wrote:
> Fixes a bug where on the M1 mac mini initramfs-tools fails to
> include the necessary firmware into the initrd.
> 
> Signed-off-by: Tobias Heider <me@tobhe.de>
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - Add MODULE_FIRMWARE() for FIRMWARE_TG357766.
    https://git.kernel.org/netdev/net/c/046f753da614

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



