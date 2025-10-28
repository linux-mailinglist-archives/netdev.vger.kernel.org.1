Return-Path: <netdev+bounces-233356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F9DC127B9
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D12B5E3F9D
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578981FBC8E;
	Tue, 28 Oct 2025 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRx4KZ3x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3221F1518;
	Tue, 28 Oct 2025 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761613233; cv=none; b=kootyuDL4mGOnc11bRDgrMyMeAWo1OPHOSLQLQ83rkcaQHJoa5XxTuihia6GUKvR6Ia/wmNpZ6vdjbutHXMjzCA5yuZq6dyaH/cVjR4qK9VYACVLjAO8thd0yjz1nRqjvS4zpJuKVBMRfSaOtsdcT4JXHNC6DV3MZC3z0jcRQTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761613233; c=relaxed/simple;
	bh=fA6kp6i4fMynXNGD7ux+k7WmbXqSfdfIdOEEHNF2CVM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TIOkIiy7+oLI+ETOH4G8NrcukSkaTzp5WOCFeV9KrQQ1mBGjq9hICuZsOv4r9rlDpbINr4MTvLxPhWizJhvm2Sn6f+YkIHGOyGkkEWj3RM/NIlEdNWjLmQQDctYBbmYe7ulOZCW1xKDX+qQqt4khOB88ZzikP9V2J5UHLl2uR/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRx4KZ3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F956C4CEFB;
	Tue, 28 Oct 2025 01:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761613232;
	bh=fA6kp6i4fMynXNGD7ux+k7WmbXqSfdfIdOEEHNF2CVM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WRx4KZ3xYkOfYEhatByb0Eu4qgkFmwrdipdpoUcuRWWfsc1T6PurPGleUjC/47TwI
	 CSvP+TP4bj9+75NbPe+D4O14tsz2TA/MHfm48E6oDZuRbixKrSzJV7Mre66jk0pMgP
	 AvRqEo1ZvhR6EoT/qEM7gkSM46Q2r4XC8O4uEp7/ki10En6KDgKaT5f/mcK1Df1xT1
	 z5Tv9FjO0dWE9WL5oFDSTtRpX2UaDABd2t6EdPPSas1Xo6rfw56U1w33q/1hWePgK/
	 H+P+llVj0UYP0pwan3+cQF8aIrqQId0r7cTu+TbIMV4b36zhaKiB02yuiqKgcf0oBl
	 vfZx2n5B8awMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD3439D60B9;
	Tue, 28 Oct 2025 01:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: mark ISDN subsystem as orphan
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176161321041.1646308.6785182692740278117.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 01:00:10 +0000
References: <20251023092406.56699-1-bagasdotme@gmail.com>
In-Reply-To: <20251023092406.56699-1-bagasdotme@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 isdn@linux-pingi.de

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Oct 2025 16:24:06 +0700 you wrote:
> We have not heard any activities from Karsten in years:
> 
>   - Last review tag was nine years ago in commit a921e9bd4e22a7
>     ("isdn: i4l: move active-isdn drivers to staging")
>   - Last message on lore was in October 2020 [1].
> 
> Furthermore, messages to isdn mailing list bounce.
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: mark ISDN subsystem as orphan
    https://git.kernel.org/netdev/net/c/e3a0ca09acbe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



