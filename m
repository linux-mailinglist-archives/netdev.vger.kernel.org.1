Return-Path: <netdev+bounces-52005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4117FCDD3
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 05:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB77E1C210B8
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 04:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157576FAD;
	Wed, 29 Nov 2023 04:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K74Boapr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E451F5681;
	Wed, 29 Nov 2023 04:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A3DFC433C7;
	Wed, 29 Nov 2023 04:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701231626;
	bh=Ou+HbCwAZNtVyvKkQu4UL6dQP8XxTciGlMesA6B9BXY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K74Boapr6wb4wUK0yCVf6kY5Y/SXbccHILIdgR70Ap/5iTb07WfmKzpldc8CtTj0r
	 GFZ7GzIpRCBRU00qsTXg7toK6QQoDDeSGMeqRsdRF/CAbWkM5yZ/Ill1o+qIeL/uyN
	 ZloT7qjJqRz9cBeXp1fqUiUrRUhNIwRYMoLdtNejeVq4FZIRkpRGPMZO/NDL4Q6Gcf
	 jwgTmkhXUKQxsrCT2skD2ZqGPzzouuq9ZkGQjqKiJyOESEUUREMo5AwduAtlKLjhyW
	 p7x9P4ztoQqoCsWB1r5CB18ORFtjLtmp8DnJCF0YBRv5mT7T0vTO6/1/+CEoIRTKxH
	 8l0K7528PgIlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5EDEADFAA81;
	Wed, 29 Nov 2023 04:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ice: fix error code in ice_eswitch_attach()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170123162638.8478.17403370132597128071.git-patchwork-notify@kernel.org>
Date: Wed, 29 Nov 2023 04:20:26 +0000
References: <e0349ee5-76e6-4ff4-812f-4aa0d3f76ae7@moroto.mountain>
In-Reply-To: <e0349ee5-76e6-4ff4-812f-4aa0d3f76ae7@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: michal.swiatkowski@linux.intel.com, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, piotr.raczynski@intel.com,
 wojciech.drewek@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Nov 2023 15:59:17 +0300 you wrote:
> Set the "err" variable on this error path.
> 
> Fixes: fff292b47ac1 ("ice: add VF representors one by one")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] ice: fix error code in ice_eswitch_attach()
    https://git.kernel.org/netdev/net-next/c/1bc9d12e1c92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



