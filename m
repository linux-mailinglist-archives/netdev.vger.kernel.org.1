Return-Path: <netdev+bounces-62140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0B8825E06
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 04:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD411284C6E
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 03:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591B51374;
	Sat,  6 Jan 2024 03:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBrDW6ip"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F82115A5
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 03:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6434C433C8;
	Sat,  6 Jan 2024 03:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704510624;
	bh=JECno8svoBJHpQbBcMkI+zMy6Zj1Jt1Bmq/V6hdpOFo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PBrDW6ipX37XAJNvjWNI9qCAuNKEsHJMZB54jPu11WBx7oXNpwLtuDKE2OzwXGuQa
	 ssllqCeI1GpYF0aXQWCQ1N9lsFHfNKYoHdIm8olekfieAwIgJwT59xgew8YtzC3/ye
	 KWjA+0q+zHdHygg8yCl03vp5E/QV5R91jW2YszABYFLHRPhb9bVbr9qj9lxrBm/TR9
	 ux2/qvGhe8tl8/WPELLeGqaeYzT+TNr6NuJvbRAwOVQQ3Rk++/jnjySaqU4dMvZqW1
	 utHyd8rpa45gp3Oyw2D/wIEGBZShbjDyHXRw0wA5CUIr5RggeO15Ur+MbozjnDyEz9
	 rn4UNQYR6MYAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F95BDCB6F7;
	Sat,  6 Jan 2024 03:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ptp_ocp: adjust MAINTAINERS and mailmap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170451062458.13331.14273192094874629838.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jan 2024 03:10:24 +0000
References: <20240104172540.2379128-1-vadfed@meta.com>
In-Reply-To: <20240104172540.2379128-1-vadfed@meta.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: vadim.fedorenko@linux.dev, kuba@kernel.org, jonathan.lemon@gmail.com,
 vadfed@fb.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 4 Jan 2024 09:25:40 -0800 you wrote:
> From: Vadim Fedorenko <vadfed@fb.com>
> 
> The fb.com domain is going to be deprecated.
> Use personal one for kernel contributions.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@fb.com>
> 
> [...]

Here is the summary with links:
  - [net-next] ptp_ocp: adjust MAINTAINERS and mailmap
    https://git.kernel.org/netdev/net-next/c/795fd9342c62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



