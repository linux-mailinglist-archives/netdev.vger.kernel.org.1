Return-Path: <netdev+bounces-13837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2130173D310
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 20:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D35F1C2040C
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 18:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395D16AD7;
	Sun, 25 Jun 2023 18:50:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26E42569
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 18:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AC0CC433C9;
	Sun, 25 Jun 2023 18:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687719019;
	bh=tKafGQGyvxiWupzMJVZrhKrT0glm8/qi1LiqnW1C0fQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CbXcUN4i8wRlzWjGgp9tAqaWB1hqXYDnDZbS/jDoSsFr8Nle5zcJFSALmdeM73134
	 04FoRP7n7o9EH6mMlI1u8JPLEYYEeL5YOFqlsgC1FwExHYZjOPdia7r60HgIMDUICV
	 DsvSJvD01toASPHKkuqV58CP21kxgT5NHM1zBona4rLNO28ukTG3ZjKyquD9BtM3wm
	 uc/FSdMckLkIQwaCxBHr1rkWaH6SrezpGyrNQcPdhErm0gvY/CcpXCnfQbsRgqvPKb
	 LXI0TtNnYc0n2rUod1iNOobknCDtPLUc75aydSr45M01288Y1fpx1Ovb8d4FZBiioB
	 nPOWxFDnhTHJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41DF7E21ECD;
	Sun, 25 Jun 2023 18:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] man: fix typos found by Lintian
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168771901926.25635.2716847822449149455.git-patchwork-notify@kernel.org>
Date: Sun, 25 Jun 2023 18:50:19 +0000
References: <20230615010659.1435955-1-luca.boccassi@gmail.com>
In-Reply-To: <20230615010659.1435955-1-luca.boccassi@gmail.com>
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu, 15 Jun 2023 02:06:59 +0100 you wrote:
> From: Luca Boccassi <bluca@debian.org>
> 
> Signed-off-by: Luca Boccassi <bluca@debian.org>
> ---
>  man/man8/dcb-apptrust.8 | 2 +-
>  man/man8/tc-netem.8     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [iproute2] man: fix typos found by Lintian
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=c441f68ba9bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



