Return-Path: <netdev+bounces-33542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139F479E6C9
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 13:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8AC1C20ECD
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 11:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B921EA96;
	Wed, 13 Sep 2023 11:30:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1552F1E538
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 11:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA83BC433D9;
	Wed, 13 Sep 2023 11:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694604626;
	bh=g7T0TzpfdJArNG8rECZYJF7G7f5qO0ZdMc0p5WrhkQI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kZatnpsnTLVRvUkUAGKUXL/VOHb4c8+d0DsnugK949FNAloEshK4WS6R+rsPWKKMf
	 FsrgyB4gcL62Eh1eXuEG6M1yBKKsXmy1IMIXkoJwEvcIKju8ELHzZrtINI4N9Vnv9y
	 3GJmJGWovWsE8x2ZZohjTGSLVuIo3vbFYYMgdwTDUUqOevaBuD9BAxywr6Kf7m0e+i
	 rPjSLZw/h/VykSQ238gUHt5U5o8BrO+AyIE7uJYzeuRDdRcasgASuxMZf2Ma92Px3e
	 XQjLBf0+b5FSeYZo7fZVy1iJs1TIjWyiEVhCDY1VIFgBe8o25Yad1uKrHqS9NmxC8h
	 quhoTu+6Ubnmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6F13E1C28E;
	Wed, 13 Sep 2023 11:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: update tg3 maintainer list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169460462680.4298.7936233085025302003.git-patchwork-notify@kernel.org>
Date: Wed, 13 Sep 2023 11:30:26 +0000
References: <20230911200059.7246-1-gospo@broadcom.com>
In-Reply-To: <20230911200059.7246-1-gospo@broadcom.com>
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: netdev@vger.kernel.org, gospo@broadcom.com, siva.kallam@broadcom.com,
 prashant.sreedharan@broadcom.com, mchan@broadcom.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 11 Sep 2023 16:00:59 -0400 you wrote:
> From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> 
> Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
> Signed-off-by: Pavan Chebbi pavan.chebbi@broadcom.com
> Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
> Signed-off-by: Prashant Sreedharan <prashant.sreedharan@broadcom.com>
> Reviewed-by: Michael Chan <mchan@broadcom.com>
> 
> [...]

Here is the summary with links:
  - [net-next] MAINTAINERS: update tg3 maintainer list
    https://git.kernel.org/netdev/net-next/c/a4a09ac64ef2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



