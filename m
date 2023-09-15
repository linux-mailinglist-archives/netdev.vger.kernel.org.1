Return-Path: <netdev+bounces-34073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 297907A1F6D
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 15:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3181C2097C
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 13:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8494B1096B;
	Fri, 15 Sep 2023 13:00:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C14107BD
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 13:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC091C43391;
	Fri, 15 Sep 2023 13:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694782826;
	bh=76yJ9uq8Wm+A3ULyt02D/DhghQd9p17VeJRR0YidpVc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TP80jSjES0FygjSQJzpZI1AOdT2qPFuG8Uv7UhS8JB+LDfP9kH6XE6xvLfXLmoYZv
	 v7o8JP4gYHae/MoPn2adQgdxKv8RUS4bzBLabwW+9rZ8Dk4n+mSqqEft25rPIit1xz
	 jTcCvw63Bi8Wpp6J9dxO5ZfGDSdVuahB/avNgNpOf21BlsXVl3uEJ/ZQDdB9O7FEYq
	 sC4qMSQGleksLv787AJAfveWF7ZOW2K1Tb5jspqfeWhVJQ1xj0iNntUgbeYNfHZdpv
	 J/ze7gGk+sFcIeYvo+GgRXNy0n3Dl1dEkJwEgIjbc+o3cwtjr8gTOLNMVO1B2kDJnb
	 UWcyXfIegQYCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A108FE22AF6;
	Fri, 15 Sep 2023 13:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: indent an if statement
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169478282665.10241.11990246045934976904.git-patchwork-notify@kernel.org>
Date: Fri, 15 Sep 2023 13:00:26 +0000
References: <de6b9eed-7049-45c6-aa49-ca7990c979c8@moroto.mountain>
In-Reply-To: <de6b9eed-7049-45c6-aa49-ca7990c979c8@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 13 Sep 2023 12:36:29 +0300 you wrote:
> Indent this if statement one tab.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> Applies to net and net-next, but it's just a white space issue so it
> should go into net-next.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: indent an if statement
    https://git.kernel.org/netdev/net-next/c/4fa5ce3e3a10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



