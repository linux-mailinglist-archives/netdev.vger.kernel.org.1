Return-Path: <netdev+bounces-31481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AAE78E477
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 03:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D911C209DA
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 01:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BAA10E1;
	Thu, 31 Aug 2023 01:40:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2869110A
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 01:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D2B3C433C9;
	Thu, 31 Aug 2023 01:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693446024;
	bh=X6Qws0HCzMBH27KXlx+mNHjyVHQ4EAC5O2agjKt3kAc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kr4V+8c5iry4vnUHjTvH3D1CQQr1ugjO1ENDPYQBmxqCnqItFE56H2GXIuQsbG2CR
	 HjSfp5Q9L67Jpa6tAtMZszJUnSD5YLVSUpLmwKVvN/C8OMqdH7ZuVLT82V/hHQYaOp
	 zr5rHSPYoWvpGe5BD/BsbhZV4y53Ql7zLgtZHGPsQuQb4WHbYKXS8aXgr0wLSAziaC
	 77xcvOkty68k5GVMLuKuGVHBGBAywDYOAp7SwHAa8dVQu+Bfez3I4hV5vE42bOCcUJ
	 KqyzyPn4xUdfPYkJ7F3MKjGXfnwJVYsP/Ur/LUaQRWEyQtZFPjy3p0mkobNNHqPUyW
	 l3tSpF77DhiXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5354EE4509F;
	Thu, 31 Aug 2023 01:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] NFC: nxp: add NXP1002
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169344602433.11127.939908141244458546.git-patchwork-notify@kernel.org>
Date: Thu, 31 Aug 2023 01:40:24 +0000
References: <20230829084717.961-1-oneukum@suse.com>
In-Reply-To: <20230829084717.961-1-oneukum@suse.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: krzysztof.kozlowski@linaro.org, u.kleine-koenig@pengutronix.de,
 sridhar.samudrala@intel.com, horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Aug 2023 10:47:17 +0200 you wrote:
> It is backwards compatible
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
>  drivers/nfc/nxp-nci/i2c.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - NFC: nxp: add NXP1002
    https://git.kernel.org/netdev/net/c/8b72d2a1c6cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



