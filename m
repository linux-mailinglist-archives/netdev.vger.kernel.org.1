Return-Path: <netdev+bounces-123450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B066964E4F
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED47F281FDA
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 19:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B171B9B41;
	Thu, 29 Aug 2024 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlL3RfaU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9051B9B37
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724958028; cv=none; b=sD9GtY3rDsPEHNvyVPCY67WNxxfgsq6b4rcJroSrJSsVQfh6D9nNsB1Y/xuFOUjJddN+3gOcWPQXyxU+NSaeWSjDeZJxlV4VdgqIs9QJY4TUiq0Ex9Agv4AapQebLGP9JzzopmLPoJ0WXzzD/TJVbkbxZwpCmkVX58KGj+qcH+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724958028; c=relaxed/simple;
	bh=rENTTZpPBUXcPdl52dS0CFVG2uxO/QVzABUQqulI+hw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LiZyjO1gCCsLTuTaMhZqDT/V+weW8fHzhEUWLPMGsdKoGGx/cPPyzyexTX3xuEht1dBt1F9lnD9jh3ujFheZN7hU8J2ckjcKHjBBfPdoz4pqiQABTx6OgG1SCVvNVOWYY64siAyD8ws63fFedNb/MTBr+CLNqP9cE3HkAzTPp9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlL3RfaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1E0C4CECC;
	Thu, 29 Aug 2024 19:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724958028;
	bh=rENTTZpPBUXcPdl52dS0CFVG2uxO/QVzABUQqulI+hw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PlL3RfaU/NsdequH0/Fuhiy5QbjxlJcFPMX/yJRfppG7y0COlWeRb3+fkk+OiP2fr
	 886jczVg8WmPABLIL3GpN4IPYTDLwte9DFqn4VrVIdM/i0g8wle8x0+kKw5JAQTXXk
	 LcSyV3Yju0IccuDYiDyyl5esCOVz2SB9r/FvhhGOWYEpgjmYxkegr7kOry2og0ZoF5
	 1DQ2JbvKJR9Ldoo1j/zKz2QvkvFQnxmZCoTS/jA2Dp8uid37GHf9c3PYx+49nJICdf
	 PCTxSz3HMMWZ0cpFZa0J35lcJxnLMI3nGXeZnExlxLmqweOgKrJwhi3Bayopi3V9FP
	 i5XlDfJynEFfQ==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6846F3822FEE;
	Thu, 29 Aug 2024 19:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: realtek: make use of dev_err_cast_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172495802941.2053394.5474705950160235000.git-patchwork-notify@kernel.org>
Date: Thu, 29 Aug 2024 19:00:29 +0000
References: <20240828121805.3696631-1-lihongbo22@huawei.com>
In-Reply-To: <20240828121805.3696631-1-lihongbo22@huawei.com>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Aug 2024 20:18:05 +0800 you wrote:
> Using dev_err_cast_probe() to simplify the code.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  drivers/net/dsa/realtek/rtl83xx.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net-next] net: dsa: realtek: make use of dev_err_cast_probe()
    https://git.kernel.org/netdev/net-next/c/9023fda2f186

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



