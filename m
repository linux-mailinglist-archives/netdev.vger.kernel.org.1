Return-Path: <netdev+bounces-179212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E52DA7B237
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 01:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C1177A6280
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A161D932F;
	Thu,  3 Apr 2025 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2GzWwYi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCE31D7E37
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743721797; cv=none; b=Is0DSCQGlCzgSNLKBZfpkDS5NXRdvxAgaRoXwcqOj0t51vf9kkz5Fb5/vwuS5sNcOhx4K7QA/OK3Hjtm1psyEuhF1tMVYP95VdTdjpuy50qfUr0J9Kw8LJnsCQvfMZmjpeExZS5khImaQYE5NJdWoSpqais9YAzuXtaqlWaPSf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743721797; c=relaxed/simple;
	bh=2CqpddN/wfKick4HTlyPSeQL7RGmtAYXvHbMe394SFc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A2vUGz0HxKUKTv3EqhuS2Tg9Ru8ZKGvrsx4YOIiYnCmoGj/dKNM0mkz7sbwgwZP3qGAgCA5sdlkP1HDT3ffq1YETs1zFdmXlPXuTWsTcADj8Tp+TWDUNnqPyS93XmRb+u1gCwIEfAuuNOd+j/xJdKQGekPdXJk/u5hz4p0HhoVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2GzWwYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7675CC4CEE3;
	Thu,  3 Apr 2025 23:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743721797;
	bh=2CqpddN/wfKick4HTlyPSeQL7RGmtAYXvHbMe394SFc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m2GzWwYiRQYGK0BumjGnyqWBay0ozl15hittWviBTe6YSJwwi8rCMR4HgheKCOtgV
	 ZTK3PkJrF8Gn+gT66sGFgKtpXeFglfh1B3fjvwj8y/+OLoPD1++UGkVoyIXNqJjmXa
	 i+8SntynblbtyKXj8OcEgrhuP9PzoctRLKq9PZK62/gen0lA1EYMjGncBjrGiqFQ+m
	 SWmVMKg+50BSrpmMX2pJR5r90UAjMvQUNWckq+5/3gR9Nlc8YREa4hjFSQkImswfli
	 lWfnQV9j+t2nzjuCvku39VF9Gqmm+P1vmVDRKv0F900IrC3bJwUpTmcChS+CkcbIQn
	 42uFiLVqBq12A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE359380664C;
	Thu,  3 Apr 2025 23:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] io_uring/zcrx: fix selftests w/ updated netdev Python
 helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174372183449.2713510.14199940221920424041.git-patchwork-notify@kernel.org>
Date: Thu, 03 Apr 2025 23:10:34 +0000
References: <20250402172414.895276-1-dw@davidwei.uk>
In-Reply-To: <20250402172414.895276-1-dw@davidwei.uk>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Apr 2025 10:24:14 -0700 you wrote:
> Fix io_uring zero copy rx selftest with updated netdev Python helpers.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  tools/testing/selftests/drivers/net/hw/iou-zcrx.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net] io_uring/zcrx: fix selftests w/ updated netdev Python helpers
    https://git.kernel.org/netdev/net/c/c0f21784bca5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



