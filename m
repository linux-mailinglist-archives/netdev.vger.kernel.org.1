Return-Path: <netdev+bounces-42544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0A17CF48E
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4DABB20BB8
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F5617754;
	Thu, 19 Oct 2023 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSSq5N9G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C193D14F90;
	Thu, 19 Oct 2023 10:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25E0EC433C9;
	Thu, 19 Oct 2023 10:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697709622;
	bh=Ust3tqT8Nr7NNkT7auo5nBLJdPeEJGcBcQPmoUCuqVg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eSSq5N9GXvC0L/ihJuOmx9CdkL6LXAhA/ZARGLRMSlycigN73MiVemK8hKD6wllnt
	 U8Fbv5EHkNqAblhf5pBaDod0H4+41LguC2gCLUwTkj0yzg4l5zgiM4zcHN03Kt729S
	 F3KatGIiSRaaTtwfUiOi5TOW4ub2i/fQrRBpXGGwQ+v+zbd/ltDAmhWNExq6InOXYC
	 zU/EC5mMlkrsatViLLtqCacqwY/gURKwUOziI+v0/e7yURNERJkShGWI7zqf7NFOPu
	 yK2fLsc/aPSjBdjDJS9f2dvpaiTfL5tcpK7qfD5/iN+cImaELi0mdzkZBW/kZU6I+D
	 L6ANhPARAkwJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D37BC73FE1;
	Thu, 19 Oct 2023 10:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] docs: networking: document multi-RSS context
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169770962204.19107.17825778933794494234.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 10:00:22 +0000
References: <20231018010758.2382742-1-kuba@kernel.org>
In-Reply-To: <20231018010758.2382742-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, ecree.xilinx@gmail.com, corbet@lwn.net,
 linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 17 Oct 2023 18:07:58 -0700 you wrote:
> There seems to be no docs for the concept of multiple RSS
> contexts and how to configure it. I had to explain it three
> times recently, the last one being the charm, document it.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: ecree.xilinx@gmail.com
> CC: corbet@lwn.net
> CC: linux-doc@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next] docs: networking: document multi-RSS context
    https://git.kernel.org/netdev/net-next/c/b91f2e13c972

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



