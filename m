Return-Path: <netdev+bounces-191809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A27FABD592
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 12:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95BBE1620D8
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 10:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B40269CFD;
	Tue, 20 May 2025 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siHNuvtC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDCB1A3177
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747738196; cv=none; b=L57QEGxfs2Qnys3JWLBGGaW6D/IIN+FIzWHlZbrmv2N/HXGsgw/bRchTdfv5zKhJbKgdAdrvmgxghcoHYEzddWcwi7p2Ae3tWYS9NMHhyGfz+TXnx+g7BcN0mRS83r0Aeu2GCt2skVk4AU0HqTEQTxwLM8dFaGi6dZqRHnLFmkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747738196; c=relaxed/simple;
	bh=/bKGV9MAHUzsTfQt9N51BwCwYmlTb1cXbI66SgtHRI8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hJkd9LGvrx58hL4uoBXLKGG6aLy3K+kyAep5XKEPaQ4KO85z1kaq4L/TxuomkR6Izkj/7/fcyNi9UoTpkuDg+r4z4WMfdOhuOxGXUsHS0HXM+eiYHgGabwZYnBi651+n0gcZsN/hTg5WAIkxOhbLXe+OZ14O7eHedelPM88zX8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siHNuvtC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0130DC4CEE9;
	Tue, 20 May 2025 10:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747738196;
	bh=/bKGV9MAHUzsTfQt9N51BwCwYmlTb1cXbI66SgtHRI8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=siHNuvtC+uvn0OepxhNoQQP6VaRdtcDHPophwdY2FVCuva7FptjhEUd4AZ6htd39k
	 XhNKtwVMHRHNfkiPlR7KPJrHk1ZPdzc0h9o3Qh7QyKS+vVSREJHr9P4X4C/CMQ2j16
	 4KkZisSUwNwql4uHY99smGNj/oJNw5YRn/wOhw5rtwmOgT5zr1TKEKAykjVjC5gdTd
	 d1LrBbJJGaPAAvzgLxgocMN8a6KS91TwQ1RF3H5Ic7FVVjMzgVPcm7nPEUzmJO9ohH
	 z/ugxGd7U986kR/sh51ZgJF1L3U7ix2t9Av9ntUB5qwLv3ycH2T5mHkopThR4YZTgi
	 YiFXaigIJS8PQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FA7380AA70;
	Tue, 20 May 2025 10:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] octeontx2-pf: Add tracepoint for NIX_PARSE_S
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174773823201.1264167.11954102216898347230.git-patchwork-notify@kernel.org>
Date: Tue, 20 May 2025 10:50:32 +0000
References: <1747331048-15347-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1747331048-15347-1-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, gakula@marvell.com,
 hkelam@marvell.com, sgoutham@marvell.com, lcherian@marvell.com,
 bbhushan2@marvell.com, jerinj@marvell.com, netdev@vger.kernel.org,
 rkannoth@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 15 May 2025 23:14:08 +0530 you wrote:
> The NIX_PARSE_S structure populated by hardware in the
> NIX RX CQE has parsing information for the received packet.
> A tracepoint to dump the all words of NIX_PARSE_S
> is helpful in debugging packet parser.
> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-pf: Add tracepoint for NIX_PARSE_S
    https://git.kernel.org/netdev/net-next/c/9ab0ac0e532a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



