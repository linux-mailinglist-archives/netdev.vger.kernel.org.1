Return-Path: <netdev+bounces-108649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ACD924D23
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 03:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82BDE1C2231E
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 01:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F7E184E;
	Wed,  3 Jul 2024 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgG2Cmnc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F98B1373;
	Wed,  3 Jul 2024 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719969631; cv=none; b=JIsRjBV7505DdlHTxeZktz78tWcZSP5eoeYr3FwNWJ0sBSfgDQYaYRtjGxFrg0G0G94GFrPJ5WB+NVAn7aWEWYO6CedpEl0pwIgDvontL266ktyhApqMm7rjysJiOOPhEzETcOWOvrrFnbV6BP/mtthYQ9MS8TsYlVTtqFtAJYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719969631; c=relaxed/simple;
	bh=QV2MWnvWsfKtMoeZhvR2F6Vi2ET2lxENq1QixB4mQwo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QJEUuQPJht4+V5EBYMwvamoUvKYpjG1i0+WXSm+yc8i0BsFmKVKX8f7hETA94VzzA3/zfgXysf6Hw1SLJ4se7vDvzM3JQ6snro+wc9sOMLB6W6JOJWDWhcjYv8QzELn/pxWNQonQD49x8q044xkOoZK2ATVjZzHSL3SF8ElmMKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgG2Cmnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A1DCC32781;
	Wed,  3 Jul 2024 01:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719969631;
	bh=QV2MWnvWsfKtMoeZhvR2F6Vi2ET2lxENq1QixB4mQwo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rgG2CmncugFRv5DgkZfECxbuRlfZNNyIDQB3WU0rpc7GXxEzxfw6VQaBH6w1G9B76
	 +oR1NR3fBGvIRaOISAoWSzvchjEybaLvhDiXRLF6aXB4dkJuAWmG3e914i0A3kMKH6
	 6CWAQJs4lp1QY0tE9I9QRo2a3r6BsxAPuwo/6tcC7abJaGiRbfU7nlxVaZdGTDx23J
	 FgzBkWfeIPBnQphF6sJbjPBosjw0aQWsdt7jr9jWrY87ainC4PbWSGQ+2IIL2eUFuJ
	 tOG2JCrX/op4hOQX+HNxfbIRdoImbiMy1iOzxChU670zxIghvJUn5LD0BjTLOXRkRw
	 EGmaUh/+vGxwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 163FFC43331;
	Wed,  3 Jul 2024 01:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH net v2] net: phy: aquantia: add missing include guards
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171996963108.13027.12603287594410117442.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jul 2024 01:20:31 +0000
References: <20240701080322.9569-1-brgl@bgdev.pl>
In-Reply-To: <20240701080322.9569-1-brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bartosz.golaszewski@linaro.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Jul 2024 10:03:22 +0200 you wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The header is missing the include guards so add them.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Fixes: fb470f70fea7 ("net: phy: aquantia: add hwmon support")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> [...]

Here is the summary with links:
  - [RESEND,net,v2] net: phy: aquantia: add missing include guards
    https://git.kernel.org/netdev/net/c/219343755eae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



