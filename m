Return-Path: <netdev+bounces-179315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E41A7BF49
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9288A17B9DE
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 14:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5938F1F4195;
	Fri,  4 Apr 2025 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6dNVx3t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE961EB1A9;
	Fri,  4 Apr 2025 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743777010; cv=none; b=Xa/SmWP1zhBZNCsaq6z919Km4hyGK0ZU9PMJn02h0LOP9n+70RihDrP2OfEVgkax7kUnx/WTrjg7yRa88sg1X1tjMywY6WHojCaCfYry2u0Ujwk8Hc4Ran++iPMAm/Ds7CcanOiyOF5VFjB+115FQ9Z5tno5Xnpnx6f7JhsoR1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743777010; c=relaxed/simple;
	bh=wTP+D4IXKBwvsj7zTnOsBaG/zgIJXbKgSf+ZGdl7G00=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oZg5cYlIm/Vm8hyPyP9aBgr8eVMY9gn4gBGkeCZjVA/+xN54v0DUjd2kC85vUVY1ZqKC42TH2VPef4pdxi4X4pS7hCCV65cPeDKqRV6cPC8jfuM9iBzb7COKha8rqbEPPCSEA+NPNQITkKKZtp/EcZ93ARDYlzSgxBEvkjTlbAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6dNVx3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB42C4CEEC;
	Fri,  4 Apr 2025 14:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743777010;
	bh=wTP+D4IXKBwvsj7zTnOsBaG/zgIJXbKgSf+ZGdl7G00=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b6dNVx3teeL8lUgEUSRmHqYqUzXA1JtIg5ncxTL3o9kYORzEQ+2/xb9SkZwPL8lmM
	 /H4DcE9hggLrCueV82UC7YjQYRDUbSLe4JLk4XneDUE7GUHjtUjTpV/jHYJmIm/sv8
	 enFLih/8RqAwFUGKPZC/jvbS+B5+gQuvXEs2zRH4+z1a7Q/FNTD8Ze7d4kXNYAHC7a
	 SbIYkNwwLpNDS6YQ4V+Vm92Fsa7iGY6P5O44rhYrsU3bYWU+YTtrRjk54Ltd1JFvpe
	 do+w9mqG1B9FHxSdc1QUkK2St8wjK9sy/2SuNzyMcop1jBKwqeSf2yz4lC28Q5scwT
	 Md6DyU4DasLPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FC93822D28;
	Fri,  4 Apr 2025 14:30:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/1] usbnet:fix NPE during rx_complete
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174377704699.3279917.8004013265274717921.git-patchwork-notify@kernel.org>
Date: Fri, 04 Apr 2025 14:30:46 +0000
References: <cover.1743584159.git.luying1@xiaomi.com>
In-Reply-To: <cover.1743584159.git.luying1@xiaomi.com>
To: Ying Lu <luying526@gmail.com>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, luying1@xiaomi.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Apr 2025 16:58:58 +0800 you wrote:
> From: Ying Lu <luying1@xiaomi.com>
> 
> The patchset fix the issue caused by the following modifications:
> commit 04e906839a053f092ef53f4fb2d610983412b904
> (usbnet: fix cyclical race on disconnect with work queue)
> 
> The issue:
> The usb_submit_urb function lacks a usbnet_going_away validation,
> whereas __usbnet_queue_skb includes this check. This inconsistency
> creates a race condition where: A URB request may succeed, but
> the corresponding SKB data fails to be queued.
> 
> [...]

Here is the summary with links:
  - [v4,1/1] usbnet:fix NPE during rx_complete
    https://git.kernel.org/netdev/net/c/51de36000934

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



