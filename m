Return-Path: <netdev+bounces-247546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C1ECFB97D
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C6EE30B88DD
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A01C21576E;
	Wed,  7 Jan 2026 01:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpvZZTYt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A502116F4;
	Wed,  7 Jan 2026 01:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767749020; cv=none; b=IYMhSKHPfqv/dF/yuQVwal0KO5/WhW5eBmO5XQHia2hOoup2iDVopT4pRwl8VIk2YTgf0rmWuzBw//pC9HsZoYalT+FuVSbI3RMlROQniIl6XawO7RebJhRv4PYA5DxudAqbXDS8uJ9ZCflWqjrLUS+2PdWGOjf52/xYg7G2rrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767749020; c=relaxed/simple;
	bh=763qxR2bvORCx1Vi0uPzzgIA+TsAQAI/ENX/B5RChVc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sv43H16jMyjNYEEDmIwH8sKANdpeigdDJLKLziWqsvzjS3YePxKs4jn7aFcwKQuhdUuu7k0tpH3bMrTwOgzBuigsp9sTELacQW3Svf/23EIxu4LaIemFpvg1Qiaf9DElGq6c+x/WgCH74hQveMg3/PfWjhLvCqJfki/lnDq5GGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpvZZTYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F53C116C6;
	Wed,  7 Jan 2026 01:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767749019;
	bh=763qxR2bvORCx1Vi0uPzzgIA+TsAQAI/ENX/B5RChVc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GpvZZTYt1AtiIR4S6WVjuEDV+9CFj8PHyYA+wmKfmMJm1PHQpeOSmd/rHMq4MJLqc
	 zVsZpW3HSF7i7ISkU6GworHqytgRom47HQ4tRmnsqFiwVGKijpPJwr0i39gkqus2xe
	 99WnVV0+uI1ePIus420aQDOClq16vQPcIWibJQLHogi3fJ7nkKJ6wmbwljDRXHefWg
	 nb494C3LVixax9bQ4qtEnPG6FoQCAP3a4y9VAKaS+QnBZu3s5xYidAQfMZB3mcNSaV
	 2fjwYUNNS7PjlSchEPQc40VqUcI0e69P8nXG4Pj1d+5S+KG1bQgFhADzDpZ+dGBLVR
	 aoxW7Dk7P3VzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78922380CEF5;
	Wed,  7 Jan 2026 01:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: dlink: replace printk() with
 netdev_{info,dbg}() in rio_probe1()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176774881702.2188953.16162987764068619109.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 01:20:17 +0000
References: <20260105130552.8721-2-yyyynoom@gmail.com>
In-Reply-To: <20260105130552.8721-2-yyyynoom@gmail.com>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Jan 2026 22:05:53 +0900 you wrote:
> Replace rio_probe1() printk(KERN_INFO) messages with netdev_{info,dbg}().
> 
> Keep one netdev_info() line for device identification; move the rest to
> netdev_dbg() to avoid spamming the kernel log.
> 
> Log rx_timeout on a separate line since netdev_*() prefixes each
> message and the multi-line formatting looks broken otherwise.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: dlink: replace printk() with netdev_{info,dbg}() in rio_probe1()
    https://git.kernel.org/netdev/net-next/c/b70c5c49238d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



