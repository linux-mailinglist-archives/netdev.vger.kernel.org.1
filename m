Return-Path: <netdev+bounces-144673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A58EF9C815F
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 04:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33941B259BC
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 03:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630D31EB9F1;
	Thu, 14 Nov 2024 03:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoruIqWf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B8D1EABDF;
	Thu, 14 Nov 2024 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731553822; cv=none; b=oJ1l8PUFgL5CihMl49GitjyqDvrqf+LadK/5oh8+wVO4xWYVYe48DK/Iv3yvgXHnWxJCoA1tyueWZ6rZqAcfNvUfghEWNL9KPqeqaSuW+CDSzfQgDFweoEiN2/xLOCFiKpaZk7wJHKWlwm3D2IKfUIb6zAFKXB7cV6TUgi79uGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731553822; c=relaxed/simple;
	bh=GLbVmIqMQok7XEpZtjFkl/69O4TC2qyOOzy0QtQ84Ac=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aHwxgM/D1NIYpzPBz8Vgl5yIM+D+V0SJodNpcFLGcycDLyArEX7WQovOsLh6y72i48wWJL7FUDFpCoC2rGhAexkVMMhP07WtsgEXcT4FantrqK/6JkEFKqS2s8fl1l/if1nfeMc2+0hi6VtVcNUoYiWcz3B16s+lSxJOP9qfU/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoruIqWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE598C4CED7;
	Thu, 14 Nov 2024 03:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731553821;
	bh=GLbVmIqMQok7XEpZtjFkl/69O4TC2qyOOzy0QtQ84Ac=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OoruIqWfTUtkLIsdc8COjJ/FyesDfBdoleGRHh7IXlEtGoMMH/TsvkQjlx4pFzcmT
	 Mz560iH0intHotbQbp8RkOKHITY3UMtOU8wpGBUEGDgH4LKdCOhxKX01cVfmZh/OnY
	 5k4O/LZn7evZd2szzqO1sJMLEXIg5OD79xhkfuSvIF5Nljgugo/ybnPkdtliJBy1cx
	 K3dQ2QDFXvsH+MOI7BIxrpRStLcBbUw0zz/EQ0wVSYErM9gntFVMq1t4gdrcFam2nJ
	 3nNBLUxjpD9Bs5LWgmJZS0X/VWTEkovzFY7c/3k0iHLeXqo2K1GY9OxCvqhnk7o/br
	 TwlWuQAtx5zAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C4B3809A80;
	Thu, 14 Nov 2024 03:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] samples: pktgen: correct dev to DEV
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173155383199.1467456.16232649908337123107.git-patchwork-notify@kernel.org>
Date: Thu, 14 Nov 2024 03:10:31 +0000
References: <20241112030347.1849335-1-wei.fang@nxp.com>
In-Reply-To: <20241112030347.1849335-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, hawk@kernel.org, lorenzo@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Nov 2024 11:03:47 +0800 you wrote:
> In the pktgen_sample01_simple.sh script, the device variable is uppercase
> 'DEV' instead of lowercase 'dev'. Because of this typo, the script cannot
> enable UDP tx checksum.
> 
> Fixes: 460a9aa23de6 ("samples: pktgen: add UDP tx checksum support")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> 
> [...]

Here is the summary with links:
  - [net] samples: pktgen: correct dev to DEV
    https://git.kernel.org/netdev/net/c/3342dc8b4623

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



