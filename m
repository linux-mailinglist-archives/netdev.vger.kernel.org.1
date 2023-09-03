Return-Path: <netdev+bounces-31844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A271790C0C
	for <lists+netdev@lfdr.de>; Sun,  3 Sep 2023 15:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D561C20621
	for <lists+netdev@lfdr.de>; Sun,  3 Sep 2023 13:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4FE23AA;
	Sun,  3 Sep 2023 13:12:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D38E210B
	for <netdev@vger.kernel.org>; Sun,  3 Sep 2023 13:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69C23C433CA;
	Sun,  3 Sep 2023 13:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693746753;
	bh=g8pSR9QSVK6IeE2/A0s/1+eGsGP0iQjvdmE/KxRxGHs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bGcMumlA/LMwxHzciuPWXEmAmoGpA8XWLb+ZxkzxMGAEh6tVIyf9qQRK43A8t2FMW
	 mQhhBJuN5VVYjh8KcC/wjBFlZyOoaBHn/qkpGAumIimER83M6Qg7Q/YVqi5CXwE307
	 NKT/ecSNY4LjYP2/7Phsenq+jsSuV2pzVPsXqe2TEgglG24RAHS21ZcZ3YfK1Vn5SC
	 fg5pztGMbFctuS1lX+q7kYuzDaFUwvWrF2/HBM4yzVkHkrh9cj8qxFH8TirM4h2cU5
	 CWp+gk4CjowMmt0dGBL7j8uxDahM+wJcVl6xlq1GmalOh5VleOzb8iExsSBXy9aujv
	 UIiZPXpmZnlVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C894E29F39;
	Sun,  3 Sep 2023 13:12:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] igb: disable virtualization features on 82580
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169374675330.16952.10821656752298867430.git-patchwork-notify@kernel.org>
Date: Sun, 03 Sep 2023 13:12:33 +0000
References: <20230831121914.660875-1-vinschen@redhat.com>
In-Reply-To: <20230831121914.660875-1-vinschen@redhat.com>
To: Corinna Vinschen <vinschen@redhat.com>
Cc: anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 31 Aug 2023 14:19:13 +0200 you wrote:
> Disable virtualization features on 82580 just as on i210/i211.
> This avoids that virt functions are acidentally called on 82850.
> 
> Fixes: 55cac248caa4 ("igb: Add full support for 82580 devices")
> Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [v2,net] igb: disable virtualization features on 82580
    https://git.kernel.org/netdev/net/c/fa09bc40b21a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



