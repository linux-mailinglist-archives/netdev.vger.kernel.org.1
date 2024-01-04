Return-Path: <netdev+bounces-61495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6164682407B
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 12:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865CF1C209F8
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 11:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B346210FF;
	Thu,  4 Jan 2024 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGII0F86"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DB9210FB
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 11:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11186C433C9;
	Thu,  4 Jan 2024 11:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704367225;
	bh=l/hdHruuGnQodtuAt+zkbs1EMVZe3RQSuyPfqXm9Swk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NGII0F86u5+O2UeOMGYOztYREiRaBYfmWX5ojQqqsfxWk22RTnDsJ4A3Foq8lv5GC
	 k27HbG/+PEi4kg8YeGKMSEJ1XRQ2qzLJaJHRdLXT8ipWMzHGexY3h3e0Z8goGEajob
	 k4pZIuY86KaSIgblmu1rKtYDpLCNF8Iwg5986zpAHUy8MiuYhYjU2nALt5+iwm39Lr
	 eSO9dLHzdzRydGAMXe9FQaHe8x1QsKllkPP91t9yy22UZ9nh/psRGaAwNWdHkk7rEp
	 PHGsc61SaeW6zKUVmW4YEjbI0ROgX6m/b9P6AzokcYe7giL/QMe2++odZ8LrGhqVuN
	 8TwMa3LjYBazQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC431C3959F;
	Thu,  4 Jan 2024 11:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnxt_en: Remove mis-applied code from
 bnxt_cfg_ntp_filters()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170436722496.25413.10889405333453565942.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 11:20:24 +0000
References: <20240104005924.40813-1-michael.chan@broadcom.com>
In-Reply-To: <20240104005924.40813-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, arnd@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  3 Jan 2024 16:59:24 -0800 you wrote:
> The 2 lines to check for the BNXT_HWRM_PF_UNLOAD_SP_EVENT bit was
> mis-applied to bnxt_cfg_ntp_filters() and should have been applied to
> bnxt_sp_task().
> 
> Fixes: 19241368443f ("bnxt_en: Send PF driver unload notification to all VFs.")
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> 
> [...]

Here is the summary with links:
  - [net] bnxt_en: Remove mis-applied code from bnxt_cfg_ntp_filters()
    https://git.kernel.org/netdev/net/c/e009b2efb7a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



