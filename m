Return-Path: <netdev+bounces-177514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AE4A706A7
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D8B18969D9
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0255125BAA9;
	Tue, 25 Mar 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biaTrMoM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D279C25B690
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919601; cv=none; b=CaGM1sE7UsSa3HhuzDaS2/5w/OZ/aiFiv+qOpDxUEr7FbPNxoOyjBylpg01RM5zFs+v1c8zICxjTcLghuN4qBUdUFQKa8pDUkNzdT4EKKFZO50taAR6nWgvJxTXbsZ/Xsq1MTE7rBMrvjp3GreKR69/eHfISxmBzliz5YPyUB9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919601; c=relaxed/simple;
	bh=2Cuonc60Zc96f6GEEXv/qpnc+BLi8dX87up1YOU3Emg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h0AameOwaQZftFKUSYEfuKbbI+XWpVOajHX6NfrPGMQeYT4iDxKO5SDc/v33I0Vztr8jFCzOsN+dVNtHYSnEbw4VPJ6NdvAWdLfp16IZ7e3cXHyJeJmI1GX9fYrYUE/5kE0R4SLb2wQ4xbvawWw+wNTdlvXfYg8qmku28W/w64A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biaTrMoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B95C4CEEA;
	Tue, 25 Mar 2025 16:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742919601;
	bh=2Cuonc60Zc96f6GEEXv/qpnc+BLi8dX87up1YOU3Emg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=biaTrMoMZQ8aa2G6y7uaqSh124WYFR5W8KH5+5GQGwYPbJZlUwqI+neHrGu5iNocC
	 SNFu4fPWOEPLaC7R4sd/GBbI1XqAqtVtWuXvmUsqhwafW1oC73Os1VAmKyLfO6xuA6
	 H1wGooiZ7VxTKW9OfczgU6fW6XkfL7fsWatu4w+ctxXI/zcjiC6rAyb+5uVmI7okoa
	 uDw2C72SKZxN+lSPRKObg3EsJ4HhbRVjsaU+Qwucd0VjwuEwrv8P0vADvds283bqCT
	 LzZlAGw4STY5XlEUN22Hd3JeykwcpvLVM219apwNTd5FHMSlrb6zeXFS5CRstiRSTB
	 S1oCxNqH17d8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3DD380CFE7;
	Tue, 25 Mar 2025 16:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/8] xfrm: prevent high SEQ input in non-ESN mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174291963751.636425.15470353663766995913.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 16:20:37 +0000
References: <20250324061855.4116819-2-steffen.klassert@secunet.com>
In-Reply-To: <20250324061855.4116819-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Mon, 24 Mar 2025 07:18:48 +0100 you wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> In non-ESN mode, the SEQ numbers are limited to 32 bits and seq_hi/oseq_hi
> are not used. So make sure that user gets proper error message, in case
> such assignment occurred.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> 
> [...]

Here is the summary with links:
  - [1/8] xfrm: prevent high SEQ input in non-ESN mode
    https://git.kernel.org/netdev/net-next/c/e3aa43a50a64
  - [2/8] xfrm: delay initialization of offload path till its actually requested
    https://git.kernel.org/netdev/net-next/c/585b64f5a620
  - [3/8] xfrm: simplify SA initialization routine
    https://git.kernel.org/netdev/net-next/c/b6ccf61aa4fd
  - [4/8] xfrm: rely on XFRM offload
    https://git.kernel.org/netdev/net-next/c/49431af6c4ef
  - [5/8] xfrm: provide common xdo_dev_offload_ok callback implementation
    https://git.kernel.org/netdev/net-next/c/cc18f482e8b6
  - [6/8] xfrm: check for PMTU in tunnel mode for packet offload
    https://git.kernel.org/netdev/net-next/c/ca70c104e151
  - [7/8] xfrm: state: make xfrm_state_lookup_byaddr lockless
    https://git.kernel.org/netdev/net-next/c/2e460eefbd44
  - [8/8] xfrm: Remove unnecessary NULL check in xfrm_lookup_with_ifid()
    https://git.kernel.org/netdev/net-next/c/399e0aae5aab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



