Return-Path: <netdev+bounces-36699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5DF7B152A
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 09:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0778B282A1F
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 07:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1985831A71;
	Thu, 28 Sep 2023 07:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066B1538C
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 07:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69E04C433CA;
	Thu, 28 Sep 2023 07:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695886824;
	bh=pjqPuAcv283NJ+TTvlNQXtbmZPqANr6CrDjBHJ/KfnY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T6649gcgKr76DAgluac1RhPWkNH/YnWbRi1O3EJTCHk7+/de9yncQV36OOqLVVJhZ
	 Alcu50t3hIMxfo/Pzj+hWn0jycBiRrNLPnfbcUyqLBhUy26ZNMoZ21yyIDoAtrfTP5
	 odoKL+kw189JSjvOro9botquGe6E/E4tYSrTadibwfqiKVFSuH0LQt3vvhH0zOPR3Q
	 L7VKNAKKA7YX7anLeZXffIdzR42GLO5HDwoSi9adnCe+znOQH8folYRZkr6a18rQul
	 bDAu2jea33cjv0LH4piKqZSzUr+L6atBUsAJZ/GPSS140pTk/CQiMD9NaLNEB0F3zB
	 piIRfFGrJ0qDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DD6FC395E0;
	Thu, 28 Sep 2023 07:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] net: sfp: add quirk for Fiberstone GPON-ONU-34-20BI
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169588682431.24360.15438983222452175812.git-patchwork-notify@kernel.org>
Date: Thu, 28 Sep 2023 07:40:24 +0000
References: <20230919124720.8210-1-ansuelsmth@gmail.com>
In-Reply-To: <20230919124720.8210-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 19 Sep 2023 14:47:20 +0200 you wrote:
> Fiberstone GPON-ONU-34-20B can operate at 2500base-X, but report 1.2GBd
> NRZ in their EEPROM.
> 
> The module also require the ignore tx fault fixup similar to Huawei MA5671A
> as it gets disabled on error messages with serial redirection enabled.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: sfp: add quirk for Fiberstone GPON-ONU-34-20BI
    https://git.kernel.org/netdev/net-next/c/d387e34fec40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



