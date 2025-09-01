Return-Path: <netdev+bounces-218883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8376DB3EF31
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8B9485723
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEBF25BEE5;
	Mon,  1 Sep 2025 20:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIKZscx3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EEC25A2B5;
	Mon,  1 Sep 2025 20:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756757404; cv=none; b=QJ05BFwELuVMjeo8y2GZs576g4yOyoPlGYO7lv2T6So9oyKj8CHB5mGgeYQq/hRa5kdouyK256R4TLWJ0WlFV1+5Qvwy+Fi4IXQm2blF2mvYkFkxSO0P2+mGppUKQJRCQDrnO8ZuIyiWAElmc/rV1INhn0LSEeCKfWNt/egpAZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756757404; c=relaxed/simple;
	bh=ymT14rwWbD8Y2vD4GrUiNATLT7e39pPldzKr2MaM3EA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FusIFF41G4b6W1RQYXYgFkafXqlqIKz02eJWzP+1MJgyDSegy3sxy4iHzIgiGE1dylNf7G7+gerMLqQhKPbOktBc+YIuYjrDFMzdVn98+KpY7Vp1VaGk+FuLMJdE/UTIrsDxyuZ4yf1hxZFQW4RT8HcLJKqJZGmAd9IYdr2Y29M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIKZscx3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF833C4CEF5;
	Mon,  1 Sep 2025 20:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756757404;
	bh=ymT14rwWbD8Y2vD4GrUiNATLT7e39pPldzKr2MaM3EA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rIKZscx3GMTqz0hvIRBMrpVaNBVhcn2KwKTIIZDC6YTBic12pl8ak2fwLtptUnqEP
	 3Diq9+Dqokz5tJTFH9Lfk5pUS6j7QT5zJfFssUqtnThxaPPJmAVrZAfreDNA7v1lbZ
	 LgY75M3xfl9tXj0xgbnjo7wzoFMijSqxL3n58ALktpGgitzvaZrSUmZkNHgIX58zln
	 Tw9k8sqN1DEsJjm0v18E7F21Z80yFAXVB+J9XoB/HHwIsIUt6Nst9675ziE9KTyndz
	 hp0u7v/VnyUtKRW0OTQPQINu0ZV78J/O2ydNDr0VYa1bF/2Ljm1A93vtoW57BrT0p9
	 hf/lZXyQa4Tbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF4B383BF4E;
	Mon,  1 Sep 2025 20:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethernet: qualcomm: QCOM_PPE should depend on
 ARCH_QCOM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175675740974.3870710.18252773056077128098.git-patchwork-notify@kernel.org>
Date: Mon, 01 Sep 2025 20:10:09 +0000
References: 
 <eb7bd6e6ce27eb6d602a63184d9daa80127e32bd.1756466786.git.geert+renesas@glider.be>
In-Reply-To: 
 <eb7bd6e6ce27eb6d602a63184d9daa80127e32bd.1756466786.git.geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: quic_luoj@quicinc.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Aug 2025 13:27:06 +0200 you wrote:
> The Qualcomm Technologies, Inc. Packet Process Engine (PPE) is only
> present on Qualcomm IPQ SoCs.  Hence add a dependency on ARCH_QCOM, to
> prevent asking the user about this driver when configuring a kernel
> without Qualcomm platform support,
> 
> Fixes: 353a0f1d5b27606b ("net: ethernet: qualcomm: Add PPE driver for IPQ9574 SoC")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> [...]

Here is the summary with links:
  - net: ethernet: qualcomm: QCOM_PPE should depend on ARCH_QCOM
    https://git.kernel.org/netdev/net-next/c/35dface61cfe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



