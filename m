Return-Path: <netdev+bounces-26040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603177769C7
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E49281AAB
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 20:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3DE1DA52;
	Wed,  9 Aug 2023 20:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5141718C2A
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 20:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEBB8C433CC;
	Wed,  9 Aug 2023 20:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691612422;
	bh=Q7q8EGyb7Hasuk7T4Jso0aWgdC3KRG7N2pqffg4YzWQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SToCn6jejpCkPDuUPv5QujUkzFv1Vm/3/MzyHsKLcRQz1+M1W8WrEnBmO/eztB1yL
	 wJWnTjM0lJ79/0yV3W+RrRIBkFIy11ZeeOfCGAYEEjIpjNL/NOSFla0F21Z3PpH5t2
	 jbCLJeee0GGzBc6iiIRBPUur2MS4OG/DqpJIIfqZCr9zRqF2p7JNFHx4vdxmLRO2Be
	 AFv5hHPMOJijA4pEStXPpywcG/Ru84WcAW54JnDv036NBtxRE8NPc19g9MriJhwneA
	 M6+aO62BHxKreNQCpYq+fB+LJNKyL0XbumnoTkTQXzvtrnRIzvPhzYl53/oJvCjfvj
	 Zjp0YJtYDQI5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99902E330A3;
	Wed,  9 Aug 2023 20:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: Remove two unused function declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169161242262.16318.17613471730291974598.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 20:20:22 +0000
References: <20230808144610.19096-1-yuehaibing@huawei.com>
In-Reply-To: <20230808144610.19096-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 8 Aug 2023 22:46:10 +0800 you wrote:
> Commit 1e2dc14509fd ("net: ethtool: Add helpers for reporting test results")
> declared but never implemented these function.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/linux/phy.h | 4 ----
>  1 file changed, 4 deletions(-)

Here is the summary with links:
  - [net-next] net: phy: Remove two unused function declarations
    https://git.kernel.org/netdev/net-next/c/90ed8d3dc34b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



