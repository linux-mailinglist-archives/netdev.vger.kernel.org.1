Return-Path: <netdev+bounces-28998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BF77815F6
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91FE1C20B6E
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 00:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0F2366;
	Sat, 19 Aug 2023 00:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FF1362
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 00:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBC6DC433C9;
	Sat, 19 Aug 2023 00:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692403821;
	bh=bM0YEqZMOLY1Jph4P86ZCvdPAe2HnmaPaNs3ksmpDjA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bBHk9rVZbckyWlEiXyVqjyobTJXGcQ/AYx2z8WjqbnccxHPNY4/apyhQe4s0BL/Rn
	 SaRMeacqiAlsryCojb2WCMTm508gQ50/xdH9D3dR51XIAKEZEGv74L1NVVcs/NQm/r
	 HTTVAJvrFGxsVK6WbaKPMXaf3cH6nnwcsj8xluRrVIpEXWxBX8s18vKWK9XHF6paiw
	 nk2UWyqtzVjda3ERgMAxsMnlrtdn0HStVECGiEArhJTp+jlmje0xRl9Rx0nwGLg2RV
	 Ku4dbyuwxMwKdIYp5UoTiglTZhzDOmtbj+bo5xdPFWJPiKKErfSYrVw9YyPBBrtvi4
	 lfcloPA0x3gHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BFF98E1F65A;
	Sat, 19 Aug 2023 00:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: dm9051: Use PTR_ERR_OR_ZERO() to simplify
 code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169240382178.13403.12067734724246511367.git-patchwork-notify@kernel.org>
Date: Sat, 19 Aug 2023 00:10:21 +0000
References: <20230817022418.3588831-1-ruanjinjie@huawei.com>
In-Reply-To: <20230817022418.3588831-1-ruanjinjie@huawei.com>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Aug 2023 10:24:18 +0800 you wrote:
> Return PTR_ERR_OR_ZERO() instead of return 0 or PTR_ERR() to
> simplify code.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> v2:
> - Update the subject prefix.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: dm9051: Use PTR_ERR_OR_ZERO() to simplify code
    https://git.kernel.org/netdev/net-next/c/829b3357dd97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



