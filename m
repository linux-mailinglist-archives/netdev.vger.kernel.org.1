Return-Path: <netdev+bounces-232297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72691C03F4F
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 02:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2477A1A65BB3
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 00:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7EB335C7;
	Fri, 24 Oct 2025 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdxuFeOT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7793DD531;
	Fri, 24 Oct 2025 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761265827; cv=none; b=Tc4LnyB4XEEMs+m7AhOs4Tk8TxcuWsapk4Lu44OlrKf7oRXk/3mOsFdBoK2fTa/S4wdYUKOraC/ouJYlfddZTBmVMYqh2vxdUxR40btXyWPj0HviTR6wi8wS/PCLsxZg0q0kVnIPVg4r3U5nHV+f3zJ6Zsmj5zadacZ+0CX4WbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761265827; c=relaxed/simple;
	bh=srpTNTgwCYwhFBSXlWEUoKG6R+8Bosz37CUW0irsSiY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g9ixpA4M+orZmFU1ZjLfsCos8nE4OFNAdhJwGtE8MfAzm+TJUcCLfk5FvA3Mw6AfYxRWMLurKy8e95lKxPrdPQLSDTo16ISUyjXHMo7H465xesEOgDSpPYC2lzTuwlxEpJURLUMCzkPd0pkHYDi/WT+CNNO5xHEjoWKFz2HuoSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdxuFeOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09828C4CEE7;
	Fri, 24 Oct 2025 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761265827;
	bh=srpTNTgwCYwhFBSXlWEUoKG6R+8Bosz37CUW0irsSiY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cdxuFeOT021SzrU8alswtMCfLSumsu8BSXQO0pZyVTAF1PCIlju7wXSrdbAc7ZyCW
	 qZk/Q6mKSk8YPDhT8WU8kLbsMvcLux5zuwoalVXhGOUP3YQWNKgx8dchqkRsweIXDP
	 8YVFE1+r+SHBk2xmG4StONcUIb5v/hjG+35mLuc0WzITLVMp/K1cxOpK9OxHFha/Rw
	 gikubgOrlCK390TxyQn0yeGtfwUIy29geiHVV3LOuIDNfrlNMl/tQTi7KRGR4V4KR9
	 8HjfgYizetyHbx2D+uWOzxTftmImjeDYrwwXTw5qQRhRoNnKJEXLW9OSKx5VhXfnBj
	 sLBnPRHBGNWCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F213809A38;
	Fri, 24 Oct 2025 00:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: unix: remove outdated BSD behavior comment in
 unix_release_sock()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176126580726.3301171.10242960194953968551.git-patchwork-notify@kernel.org>
Date: Fri, 24 Oct 2025 00:30:07 +0000
References: <20251021195906.20389-1-adelodunolaoluwa@yahoo.com>
In-Reply-To: <20251021195906.20389-1-adelodunolaoluwa@yahoo.com>
To: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Cc: kuniyu@google.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Oct 2025 20:59:06 +0100 you wrote:
> Remove the long-standing comment in unix_release_sock() that described a
> behavioral difference between Linux and BSD regarding when ECONNRESET is
> sent to connected UNIX sockets upon closure.
> 
> As confirmed by testing on macOS (similar to BSD behavior), ECONNRESET
> is only observed for SOCK_DGRAM sockets, not for SOCK_STREAM. Meanwhile,
> Linux already returns ECONNRESET in cases where a socket is closed with
> unread data or is not yet accept()ed. This means the previous comment no
> longer accurately describes current behavior and is misleading.
> 
> [...]

Here is the summary with links:
  - [v2] net: unix: remove outdated BSD behavior comment in unix_release_sock()
    https://git.kernel.org/netdev/net-next/c/ec538867a376

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



