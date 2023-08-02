Return-Path: <netdev+bounces-23772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7869276D79B
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 21:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7562818E3
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 19:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036971078F;
	Wed,  2 Aug 2023 19:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBFADDB6
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35F37C433C9;
	Wed,  2 Aug 2023 19:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691004023;
	bh=gbiDfVXj1+c0Vs+4kZ+hhpK4TfrK9HF41Rz+SADNj0A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p+c1f0+FGDKaQfWC9whtlK5T5momjHokWK4MgcwZZ6jg3Ymr8UFPj13mI4H235PXj
	 8aKecCqJPl+3hUW47BcTpIAaM8+XMbHtF9P+ctP40hd/cDRNr0B0Xwsm7zAowPqP5S
	 9aECz6c2a96x7y0S6MYQn4QscfO25DGLntg8uSv5hmMYWdvsGIz+SSPuQkHuv25Uz2
	 b0wWzli2PI0/GZ+Sh4UoVb+rpPsfOF0u74SIzUQAZ/DZRCVnIaJEbKnZ8YJiGeiUTU
	 gqMnTFgTHWPnsek+5CDxp4omtoQn9pByf3c+j3r4lk5Fz4vvc4Ty5ifcAw/NnGB6SS
	 LDxKYWK4FnsxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D3EDE270D1;
	Wed,  2 Aug 2023 19:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] cirrus: cs89x0: fix the return value handle and
 remove redundant dev_warn() for platform_get_irq()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169100402311.28133.12521114483862754799.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 19:20:23 +0000
References: <20230801133121.416319-1-ruanjinjie@huawei.com>
In-Reply-To: <20230801133121.416319-1-ruanjinjie@huawei.com>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, wei.fang@nxp.com, robh@kernel.org,
 bhupesh.sharma@linaro.org, arnd@arndb.de, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Aug 2023 21:31:21 +0800 you wrote:
> There is no possible for platform_get_irq() to return 0
> and the return value of platform_get_irq() is more sensible
> to show the error reason.
> 
> And there is no need to call the dev_warn() function directly to print
> a custom message when handling an error from platform_get_irq() function as
> it is going to display an appropriate error message in case of a failure.
> 
> [...]

Here is the summary with links:
  - [net-next] cirrus: cs89x0: fix the return value handle and remove redundant dev_warn() for platform_get_irq()
    https://git.kernel.org/netdev/net-next/c/497c3a5fb3ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



