Return-Path: <netdev+bounces-22965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8F776A363
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 23:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07DCB1C20D4D
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 21:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087841E534;
	Mon, 31 Jul 2023 21:50:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F113E1E517
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 21:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 724C2C433C7;
	Mon, 31 Jul 2023 21:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690840222;
	bh=b7GuPhvW+caI+IgBWtWJ288PaFDgBloQho1XulayYdI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ol7eUez+aCTR8lYkr8Yoj5YdkJCqNqaJDaj9lBmx3+uy1iG6N6KqPlh2SZIXiofFi
	 zkSq8i7oIbuMcbWmd0aT1hzav6Unend6SLdlX70LNc3b0utPOKnXruLZqBp1hxogHG
	 +FyYQOJg4BhkwG/kinsFqrrXPFNJNREvYSLAo0Feym/w+scXvn+MfSZsXHHUTZLptH
	 UpduFoeK/w8lHkJM1CN6pySgHkBojTEYhOr/E0uhMSdOgF0IHwrgwdXaebAoaw+f64
	 +Evqmr+l6h6ROr40ERDC6BlCofwEMyoKAKtDIASvxm1InIvDQfmWQXDopNDB9picL4
	 N0DLr0SKK0QAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CCBDE96ABF;
	Mon, 31 Jul 2023 21:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] vsock: Remove unused function declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169084022230.13504.17004715594026718607.git-patchwork-notify@kernel.org>
Date: Mon, 31 Jul 2023 21:50:22 +0000
References: <20230729122036.32988-1-yuehaibing@huawei.com>
In-Reply-To: <20230729122036.32988-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com,
 sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 29 Jul 2023 20:20:36 +0800 you wrote:
> These are never implemented since introduction in
> commit d021c344051a ("VSOCK: Introduce VM Sockets")
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/vmw_vsock/vmci_transport.h | 3 ---
>  1 file changed, 3 deletions(-)

Here is the summary with links:
  - [net-next] vsock: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/634e44971981

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



