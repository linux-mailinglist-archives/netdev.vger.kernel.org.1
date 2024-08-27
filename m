Return-Path: <netdev+bounces-122116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8516B95FF1A
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 04:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83101C21C93
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 02:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FFD8F40;
	Tue, 27 Aug 2024 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7Jg40W0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF50101E6;
	Tue, 27 Aug 2024 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724725827; cv=none; b=cYOk6MTu1ZASFY8N3MOLca0etmS+J3SMVgHda4zP5KKI6cbdCilCyrby7XWarYWzkPGyET1oFnwUcNASyWEWX6jCcctkWY2XSJT77MQ78J6n9BpvVZiua94/Idy4RsTCfdfPp4S5D7SO0ZtnhMgSB52lj33L2/MqiK/qgiFafrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724725827; c=relaxed/simple;
	bh=gUPeWmKpbplPVKujJpH1VQiCSH8b9fBVibsthXYlSRM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IigNYieFLoGgfnXMEG4fPjSM/nCZX+sY/BJr8JnpALLg6SEy1aZj0ir4CsArJ29/Hrv5n3unSWC8beg0b2XMJzU9DEBbzkkCMuqgZWNuuC1sCgEPPgHG7ke5me8U2jJ8hiCrNSWcuK15p24fXGlG+14Or6pjBIrL81gX2QReqEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7Jg40W0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE495C8B7A4;
	Tue, 27 Aug 2024 02:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724725826;
	bh=gUPeWmKpbplPVKujJpH1VQiCSH8b9fBVibsthXYlSRM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e7Jg40W0Ouqh2YRxLYR4cuDveoymz2ulqrm6QxSWKMBfVz6+0cOj22PioWSLnpQAt
	 C0DzjbHQiobsxrzEeUDHopdrB4dWQR2HwSWI9A9Ey0BLGyGzCZ+vIyNR1tCDRSwM8O
	 C3g/NqXWW+a1vNJ3LIfNMA7gUTBToXXHMhFD2wcGmJFLSsODHHcUq1mX0l0s+W770d
	 wS+mJpljCYl/EDUqIerYuGolTXlt2VmsKomBZga2gIdy2yMm3fUuKEC/15/m116gUL
	 nn7XpcrVNBjWPc4i9wenJQwWHMTxKv0xmjwd9mHisB4hzWxChAC7Ke0zpooSppl2yH
	 0260KmOPImIIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E383806660;
	Tue, 27 Aug 2024 02:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix 10M Link issue on AM64x
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172472582701.186086.11839760889090049540.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 02:30:27 +0000
References: <20240823120412.1262536-1-danishanwar@ti.com>
In-Reply-To: <20240823120412.1262536-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: andrew@lunn.ch, dan.carpenter@linaro.org, diogo.ivo@siemens.com,
 jan.kiszka@siemens.com, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com,
 vigneshr@ti.com, rogerq@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Aug 2024 17:34:12 +0530 you wrote:
> Crash is seen on AM64x 10M link when connecting / disconnecting multiple
> times.
> 
> The fix for this is to enable quirk_10m_link_issue for AM64x.
> 
> Fixes: b256e13378a9 ("net: ti: icssg-prueth: Add AM64x icssg support")
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> 
> [...]

Here is the summary with links:
  - [net] net: ti: icssg-prueth: Fix 10M Link issue on AM64x
    https://git.kernel.org/netdev/net/c/e846be0fba85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



