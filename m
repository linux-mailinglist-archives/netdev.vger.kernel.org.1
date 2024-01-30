Return-Path: <netdev+bounces-67177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C302842419
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 12:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B7D1F299FC
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 11:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DF7679E5;
	Tue, 30 Jan 2024 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pej0mRpq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F3C6773C;
	Tue, 30 Jan 2024 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615426; cv=none; b=MoVpRRrSTPSrz2v3FM/aw9AxOr8dAm7gikp/s5M0plpDPhJ1eCrpoLgLoTesEpFBMhya2b23q7zad35xf0konN7zMcBxe4ZQG6jlEC+6TfLSO9bSvJiMZ9AAhGgdoQhndJF1BiGoFhqsjG6mgsbWP2PROaT7Rsisb61wAhF5C14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615426; c=relaxed/simple;
	bh=hAbt0R3JyB9b9U8JpgKDOo3g3rIPK/9wxkAqo2FRgdI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VgNIcAQflU+OPSjUMm10KVO2j9+xvBg0Rj2WZI5aVKEu7jT+m5D+EpSKvzADyJienmChU++QG6rXTHHq+x6zzKYZhrE02/nNz0I5CMMHj6LIbLkKS8bx+cBBXIHfxUdkKjUNZBDyEVDROxhEECdso5A5hbDq14nFahjOy6qZ6oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pej0mRpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84247C43390;
	Tue, 30 Jan 2024 11:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706615425;
	bh=hAbt0R3JyB9b9U8JpgKDOo3g3rIPK/9wxkAqo2FRgdI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pej0mRpqiv4KgOQo96p1Y0Zv/DQhrgZAkZPGSGFZd/XlKJQm6JL40kcvWpcaZNcVi
	 XlToj8+xOwgUtHBTVGfv/o12KznjPqcmvr5acDkVIYsQnIBz4J9pvpcI8PTcCO3c1O
	 qs7fC/9/MC9IG3MbfsmvQwiaA1eRcT3RQeH9piY6tsOtPtQdv1VFWaS1lbi/EvMlVj
	 VuN3nfWfbjDA6T7CbuGWVu4WqMZpC4N1cjzG/Y4DDioeaRMpr+glr5egLJfjI1BSMi
	 jSrxii6jE4WKm2HWAXNLr3PAQDffAE9oDOuWMojka9CsPRJMQvRkl1aR/RlBzCKXzr
	 3NOP5dps7gh7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68976C395F3;
	Tue, 30 Jan 2024 11:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] [net] ipv6: Ensure natural alignment of const ipv6
 loopback and router addresses
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170661542542.16715.3965983655239127583.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 11:50:25 +0000
References: <ZbNuFM1bFqoH-UoY@p100>
In-Reply-To: <ZbNuFM1bFqoH-UoY@p100>
To: Helge Deller <deller@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 26 Jan 2024 09:32:20 +0100 you wrote:
> On a parisc64 kernel I sometimes notice this kernel warning:
> Kernel unaligned access to 0x40ff8814 at ndisc_send_skb+0xc0/0x4d8
> 
> The address 0x40ff8814 points to the in6addr_linklocal_allrouters
> variable and the warning simply means that some ipv6 function tries to
> read a 64-bit word directly from the not-64-bit aligned
> in6addr_linklocal_allrouters variable.
> 
> [...]

Here is the summary with links:
  - [v2,net] ipv6: Ensure natural alignment of const ipv6 loopback and router addresses
    https://git.kernel.org/netdev/net/c/60365049ccba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



