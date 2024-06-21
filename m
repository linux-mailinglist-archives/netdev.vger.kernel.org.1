Return-Path: <netdev+bounces-105522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A9B911903
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 05:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE06284340
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 03:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF29129A7E;
	Fri, 21 Jun 2024 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYExPkhz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343F1127B57;
	Fri, 21 Jun 2024 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718940629; cv=none; b=ZndGG4LsLHDttPmg+vgcCnUK6683/X/tfNqe/7KK5eWqimY3hIa9qnvlvszZf/ly0dwHkJmz06J72V8/Pm9h1vRTL5W//FFQlBszW9S0ix7sZfwY4kPREL7XnzPikj36st3oTF6kzz89Z4V2bGH8/KxRQxa9g80CCUxY/ymZhTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718940629; c=relaxed/simple;
	bh=4igYeq9AhDffzOuooujPnWPIYLV5UN9rJkXkaVNxy4Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pZ2y1nPsAFOmpGkNVl7OYilOtVnk50wdU+W4ER+iP6cuox8+6Dk9ovpk31Ixz7LI/JutVZ/2R94VPFyDIpCk092tvSzojJKt+j8edS4O1ifII38pTD487NRyzz0KzOHuGv3UvWIhwUPHjsMga9QQ+M47C0/tDoe2i650yyMBpnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYExPkhz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1425C4AF07;
	Fri, 21 Jun 2024 03:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718940628;
	bh=4igYeq9AhDffzOuooujPnWPIYLV5UN9rJkXkaVNxy4Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WYExPkhz59XvGZklX917Akgqfp6D+1+Lq+KfwV2VOFbaRjKexkMzb7QxuxuzX8bYT
	 D+XrZ+upqLw2550LidgGzUR8kOhDhiCBDDKe4zKzVBiB7r50K4+atnVrut9/BMgizD
	 8Ztsfzg07JukntP0JrEpPhSgwx/qqB7FZpBv4Opm7CkJsQ7pADiltqzI6J2bqnaRvI
	 V6LRPKYEKCZxGZVEt0e9ymkkJ9ITrp0AH01Opy2lw2kz5rY3rF33rInC+097IZ2VVM
	 2cfPWigZDdzyfX5/Pe5J9JSJSnx+fvTQnlVWOZGZvN896FJzF5IaU5ajukcZaH8Gsu
	 jGU+G57t6iqBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F888E7C4C5;
	Fri, 21 Jun 2024 03:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: unexport stmmac_pltfr_init/exit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171894062864.32761.4672204591779196223.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 03:30:28 +0000
References: <20240619140119.26777-1-brgl@bgdev.pl>
In-Reply-To: <20240619140119.26777-1-brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bartosz.golaszewski@linaro.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Jun 2024 16:01:19 +0200 you wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> These functions are only used within the compilation unit they're defined
> in so there's no reason to export them.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: unexport stmmac_pltfr_init/exit()
    https://git.kernel.org/netdev/net-next/c/d21a103b612c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



