Return-Path: <netdev+bounces-91371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E84C8B2561
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 17:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0F51C22FE3
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 15:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900AA14C5B0;
	Thu, 25 Apr 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMeJK9sQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B22D14C59D
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059630; cv=none; b=rkg55/mArE/hNcs2LyoobP5usPsjN2rGG7iXr5jU4bMmyeI2mDgid/Rl2wp+prD+ox7eM6kURH7r2T97U3bc/TnnKQjSTWrNLW0PiaqWZjAqTup38rJVEjZdCKbf2+GJ3Q+IsPRjaRm5xew8mdasW/LcK4pyJEMAGjCWDwUvqmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059630; c=relaxed/simple;
	bh=+QcR8985vIwL8viPfMrtwg+cNp4EcbPRrIYj8oafarE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lS/Qgyu0XDRSrgyp0G7anAUE5ycRew201U/ZER3LpNs65MEeNcDvMC7NGFH4JHB5d1js3LTItC6uqMTMU0++qtN2MebnbduQd4ssuYBuepzrCTVBydN5bcE2EWxDQNCb0/TkOPcxvBBpX6uMazhIFaxrdU0iqAxRsb2qTj/43QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMeJK9sQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 125F9C2BD11;
	Thu, 25 Apr 2024 15:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714059630;
	bh=+QcR8985vIwL8viPfMrtwg+cNp4EcbPRrIYj8oafarE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oMeJK9sQuWahpZ5Dh0n5BQDDkrMucNeydQx+5qt8zcBOu0ef1RNYju+7l9br/RriU
	 SfTXNpjJl5X3euRFyMiC2gjNbEmBu/cwiUXjHEar1HXmwQ9V2RujfbEz94OwQ4xrh6
	 JoAxUJAS07zsQ8A93OCYLqMV956ACstOkdw2mgg2VIkptITRuCNOi/NZdZGYIGnChG
	 TWFME4zWsD+Dx/t7uk+1kseqkTRdZYSA7SvlgQmiLyX3EQLRvxtTlcfOdUZ3LFGvv4
	 o1EdpcmF2V6J6ejWRYPM5lGcoHc6VWEX0zcuaTvVTktFiW8e4kWj5UlfBk1eolU8Lq
	 ZnooKUN3BgSZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED457C595CE;
	Thu, 25 Apr 2024 15:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: b44: set pause params only when interface is up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171405962996.10966.1317044622368248803.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 15:40:29 +0000
References: <87y192oolj.fsf@a16n.net>
In-Reply-To: <87y192oolj.fsf@a16n.net>
To: =?utf-8?q?Peter_M=C3=BCnster_=3Cpm=40a16n=2Enet=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Apr 2024 15:51:52 +0200 you wrote:
> b44_free_rings() accesses b44::rx_buffers (and ::tx_buffers)
> unconditionally, but b44::rx_buffers is only valid when the
> device is up (they get allocated in b44_open(), and deallocated
> again in b44_close()), any other time these are just a NULL pointers.
> 
> So if you try to change the pause params while the network interface
> is disabled/administratively down, everything explodes (which likely
> netifd tries to do).
> 
> [...]

Here is the summary with links:
  - [net,v4] net: b44: set pause params only when interface is up
    https://git.kernel.org/netdev/net/c/e3eb7dd47bd4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



