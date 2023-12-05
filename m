Return-Path: <netdev+bounces-53975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D46898057DF
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 15:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0BA281B3F
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 14:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6844A65ECA;
	Tue,  5 Dec 2023 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoullTc7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4722A18F
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 14:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8307C433C9;
	Tue,  5 Dec 2023 14:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701787824;
	bh=VVDxm6oONgHLGn7mC1aQKyK5BXNMwRgtPv7JaM0VSz0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AoullTc7wYmOj+z89p8n0TSMtTON/N0kpU2uWqpHCt1yfKp5bmDC2eMfmxm4+6/7s
	 t2FLdJB8OA0QXpOtDyE8uIZ8W5JCm0lYu5vpV7zEnPU5v+adVpyhiN93HgEfqELZpX
	 XaXrRv8dTRskCF4fcrF/f5yFIUoB4OCrE6PmZXQb8ZYyYeQnom3/wNP8cOCy/wVRGO
	 ioiCGdz3PVxp1OIKcddv5bTb6uT794nauXoNnR26ZHKeDKvhKOAdQ1fQX86RaoToMF
	 fRhz901CRC5ONq0jVvyPyH0lZpRkzm3C6SyPkN0gXE/xanDbHx1OGPNs9G+CgfsMkq
	 i07Jq/WZyoQoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B6B5C43170;
	Tue,  5 Dec 2023 14:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] octeontx2-af: fix a use-after-free in
 rvu_npa_register_reporters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170178782463.5866.15530520826379861519.git-patchwork-notify@kernel.org>
Date: Tue, 05 Dec 2023 14:50:24 +0000
References: <20231202095902.3264863-1-alexious@zju.edu.cn>
In-Reply-To: <20231202095902.3264863-1-alexious@zju.edu.cn>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 george.cherian@marvell.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  2 Dec 2023 17:59:02 +0800 you wrote:
> The rvu_dl will be freed in rvu_npa_health_reporters_destroy(rvu_dl)
> after the create_workqueue fails, and after that free, the rvu_dl will
> be translate back through rvu_npa_health_reporters_create,
> rvu_health_reporters_create, and rvu_register_dl. Finally it goes to the
> err_dl_health label, being freed again in
> rvu_health_reporters_destroy(rvu) by rvu_npa_health_reporters_destroy.
> In the second calls of rvu_npa_health_reporters_destroy, however,
> it uses rvu_dl->rvu_npa_health_reporter, which is already freed at
> the end of rvu_npa_health_reporters_destroy in the first call.
> 
> [...]

Here is the summary with links:
  - octeontx2-af: fix a use-after-free in rvu_npa_register_reporters
    https://git.kernel.org/netdev/net/c/3c91c909f13f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



