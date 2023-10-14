Return-Path: <netdev+bounces-40935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA27C7C9208
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 03:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 931A0282F37
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 01:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4558111B;
	Sat, 14 Oct 2023 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlIpxPBE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840F31106
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 01:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1FE2C43395;
	Sat, 14 Oct 2023 01:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697245827;
	bh=UQUTbUeDYB4EVNdj0uFAZ0IRog8SALj0h3eKfdROwbU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OlIpxPBEDKy71M3/wXUHpmfwfMiRuXQJuc7vu9vcN4bRvboYGv6MX39ZqiCG8LQxw
	 ORYRgT1Oz/FmepyeUkvMzzYa1uV+Cow8IOigjtozcSxtN/U+oo94v9OaPstaw7TvAf
	 3jG6uJ+zFjNe8IZITiwRJYoQ8/WB/QxGXp2o9FxueB2hEJDgCi/TCuRnKUyxsaCXeW
	 h37aEcUX9v/gO/ES2zWGdknMZz2NMzsDoOLXyi5fUnouAnWW8qVpNuEu0wZlRBwDux
	 ss5jGW050T3/jIot4c7bv2dK7xPNgvzNVuIQWwLB/EDO0SU29nMqWYTEGhgfKXPiaL
	 rhrHDi6oFiVaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE98AE1F666;
	Sat, 14 Oct 2023 01:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] appletalk: remove special handling code for ipddp
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169724582690.12217.13440898400700144351.git-patchwork-notify@kernel.org>
Date: Sat, 14 Oct 2023 01:10:26 +0000
References: <20231012063443.22368-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20231012063443.22368-1-lukas.bulwahn@gmail.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, arnd@arndb.de, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Oct 2023 08:34:43 +0200 you wrote:
> After commit 1dab47139e61 ("appletalk: remove ipddp driver") removes the
> config IPDDP, there is some minor code clean-up possible in the appletalk
> network layer.
> 
> Remove some code in appletalk layer after the ipddp driver is gone.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> 
> [...]

Here is the summary with links:
  - appletalk: remove special handling code for ipddp
    https://git.kernel.org/netdev/net-next/c/85605fb694f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



