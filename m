Return-Path: <netdev+bounces-38700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC887BC2B7
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 01:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92DC028202B
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 23:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F55145F62;
	Fri,  6 Oct 2023 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1wkirzB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E663445F58;
	Fri,  6 Oct 2023 23:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFE5FC433C9;
	Fri,  6 Oct 2023 23:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696633225;
	bh=iLB3VidX86HI8t/MRFP3zlFGWfIYgbansv6PAp1fegI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W1wkirzBMzD6MWiBwPm00R3JmMBTwGUzUFdJ34m5RfSTFWcKzladtPhp86M5O9oQN
	 pcwzJhRYrHuNlz6+vWiIEdyxkYM1miP7S2ksBHO/zb99mh37glWPvw6uEfuU7hDC0y
	 an6B2pri4c7U2xk35w50c3GaqGRfvT78pxhpqUlFso0ftWg+0hlsCVnKqfN1mKENjg
	 Y8paLSrEjpV0SbBiWPOGrx9aS679f4CoxeauUtZpnDABFiv9CwEFbTik2MYLfbiwpM
	 bq7to5FN+Qn9XyeyjhFGvkHgHsg0Cq4Z3ODizrXV3K7fC8nPbx5hC2MtECgz8vZKjZ
	 RXd22rxjVi4qA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 992ACE632D2;
	Fri,  6 Oct 2023 23:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ax88796c: replace deprecated strncpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169663322561.31337.8103369640901650797.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 23:00:25 +0000
References: <20231005-strncpy-drivers-net-ethernet-asix-ax88796c_ioctl-c-v1-1-6fafdc38b170@google.com>
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-asix-ax88796c_ioctl-c-v1-1-6fafdc38b170@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: l.stelmach@samsung.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 05 Oct 2023 01:06:26 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> [...]

Here is the summary with links:
  - net: ax88796c: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/9c9e3ab20f35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



