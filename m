Return-Path: <netdev+bounces-21845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 468A0765002
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 11:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46B501C215AC
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 09:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160B9107A0;
	Thu, 27 Jul 2023 09:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D3FF9C8
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33986C433C8;
	Thu, 27 Jul 2023 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690450820;
	bh=Zd0dPb8TVGeERT7/4wvq7KJBLl1ufDeyUKpTCPJK7eo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HPMK6HBJxPCcES1W0M/Tcc7pcdrkAgcczetcAU9pM52EJZahIRg6/H7RJ9Aq4lWDl
	 raeud7PNzMfGvftIP76XyDJSCfhdoTKbu0lON2vAS7kEYxLuMktSElbEinF7J49IxM
	 iLAwWtuKbHE/yNOKCq7zEMtWSgkkhsr8MAjIXlggQD17uom6b6gmLmpGZXdkb7XO6z
	 uZrXZuPyCBMlkiNWpxYCIeJY1M6tBSIqj0ZP0cmvqRwKbEXFlg/O9z58e+KNddXaW5
	 r4VNim+79wGjrPqFL4g44v93oOtQmh7BjdN8tZ/64EhUL1RMqeF75xMSuvbzKPd4tp
	 vCF8WUgv0260A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19EE0C691D7;
	Thu, 27 Jul 2023 09:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] af_unix: Terminate sun_path when bind()ing pathname
 socket.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169045082010.21055.13857475536970488585.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jul 2023 09:40:20 +0000
References: <20230726190828.47874-1-kuniyu@amazon.com>
In-Reply-To: <20230726190828.47874-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, simon.horman@corigine.com, keescook@chromium.org,
 kuni1840@gmail.com, netdev@vger.kernel.org, oliver.sang@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 26 Jul 2023 12:08:28 -0700 you wrote:
> kernel test robot reported slab-out-of-bounds access in strlen(). [0]
> 
> Commit 06d4c8a80836 ("af_unix: Fix fortify_panic() in unix_bind_bsd().")
> removed unix_mkname_bsd() call in unix_bind_bsd().
> 
> If sunaddr->sun_path is not terminated by user and we don't enable
> CONFIG_INIT_STACK_ALL_ZERO=y, strlen() will do the out-of-bounds access
> during file creation.
> 
> [...]

Here is the summary with links:
  - [v1,net] af_unix: Terminate sun_path when bind()ing pathname socket.
    https://git.kernel.org/netdev/net/c/ecb4534b6a1c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



