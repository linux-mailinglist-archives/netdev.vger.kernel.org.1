Return-Path: <netdev+bounces-128014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB6B977795
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 05:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB601C2457A
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 03:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1D51B011C;
	Fri, 13 Sep 2024 03:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxD3IGnN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED89D3716D
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 03:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726199438; cv=none; b=qo2D93zNqQ8vXKonxCSf8Fc8/7iKnkXm/N+QTAgCT2zfW0L3QqXfcW1SQDehXORefmvXXJFP7dzYN1jZEapLyuEY+99p1fkwF+IVi+r61bykmiWntmQXKwy/jMR1BaGGLNZD5a6kFcmZbS3qBK6hFf6Owru2nHhzhyJjVWbz0Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726199438; c=relaxed/simple;
	bh=GdXdamobVdzpNlNflkKweSvSeyrPkhdgHNq1XVxQ73E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jl7uq/+nPDixs9cg1xfqIMuOHsj0kpH4KqGW5mWyTHK9pqmKMVZJUvMD67l5FqVCJZSpXLk9nX4/eogC8SUscvXh5w/sTMjh5lBvQzFguTGWxkZTA80OwBtfbh5MXUETb7GLDWD/tPb6Dq/1ANNINbPJfhSZfrTmFXmDyF821RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxD3IGnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D41C4CEC0;
	Fri, 13 Sep 2024 03:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726199437;
	bh=GdXdamobVdzpNlNflkKweSvSeyrPkhdgHNq1XVxQ73E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uxD3IGnNDhOMaqCt72zjIynzGmRI4NMZeq5v/H1MaPvwRrFJxjiJNMixi7/DT2pIV
	 nHXgPin+0ALQDSI+wAVS6EcYzV0mlXP1MkE6dMwy5pGYBJmvl7dLrA8x5eh0kFFd9p
	 CqIu+IdwcNy+Si8PwO3T2hHIwYE2sYld98XH1cVl2bReB6VcFW/yDIOXeDOR1oWzg4
	 ycG2i4ymspnq6wPeOZ5IdN7jdVzPxd68KBWOnZ2Zpqfqp6UvCc+57e21FLpB/zZkTa
	 aj5ypqAEOyi32VmASiSdGMon01lpHCq6E8vRf6ET+PStuPs+2VjfaCLdpWjp04Fpgf
	 I55hcXsPnhKkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB7B3806644;
	Fri, 13 Sep 2024 03:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: caif: remove unused name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172619943820.1807670.2883321107231970667.git-patchwork-notify@kernel.org>
Date: Fri, 13 Sep 2024 03:50:38 +0000
References: <20240911015228.1555779-1-kuba@kernel.org>
In-Reply-To: <20240911015228.1555779-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, justinstitt@google.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Sep 2024 18:52:28 -0700 you wrote:
> Justin sent a patch to use strscpy_pad() instead of strncpy()
> on the name field. Simon rightly asked why the _pad() version
> is used, and looking closer name seems completely unused,
> the last code which referred to it was removed in
> commit 8391c4aab1aa ("caif: Bugfixes in CAIF netdevice for close and flow control")
> 
> Link: https://lore.kernel.org/20240909-strncpy-net-caif-chnl_net-c-v1-1-438eb870c155@google.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: caif: remove unused name
    https://git.kernel.org/netdev/net-next/c/5905c024a776

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



