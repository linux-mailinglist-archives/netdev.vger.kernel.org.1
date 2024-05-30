Return-Path: <netdev+bounces-99221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A9F8D4263
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7202FB22D34
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 00:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A148E8BEF;
	Thu, 30 May 2024 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKgvoaAC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A746FDC;
	Thu, 30 May 2024 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717029033; cv=none; b=IcxWWh5HQCPwjvXbktKpIVG4lD9eTkBvSCWHTUGVGi1OBLC4bQGDs/2WPRKv1RscqrDwjejmYXnd+ktxC50vkH2CnorJO6Q2T8ZKWxNNnaNQWtIqL/mA/fA/a6NFhP9+tKpvpgNbvmUvHYIFyLsXMNRORTYcw7jRAvdELObXazE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717029033; c=relaxed/simple;
	bh=iOlsCdtGN5mJ24UNtjfirO5jVyeFeACF7esLrZv0bTE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LdzDaX6rYGz0fvrNiktSv8ThtDgylUOUvMEusf+mUW5N5zqNf0fyoNzZHWNGcgd9D258mlw4LlK1/4bSFnlD7LizlLkrHgBNaswG4TOPh12Pmwz7JmqaZ7qG3rdppsppwuLd4IqH5l83WLASHeOarWAsZrqoOJvLJZIDKnkve7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKgvoaAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16ED0C32782;
	Thu, 30 May 2024 00:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717029033;
	bh=iOlsCdtGN5mJ24UNtjfirO5jVyeFeACF7esLrZv0bTE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FKgvoaACJmytLzjCiItceXnpzg+acBVYyfPiieT6pKPFVO8oz6rjXC4xqvRQ/ATVC
	 cwGAycfnWwdcf3xrlTfPwl8K66TuSh/M+7M2Qa0YILC2en8Hj9DWSuUXI/pm/A+3Fl
	 FR+UCCJqVEqhKtgZOQd9hOWDeCFv3nkfvkVwED/dr+0Zrl1JC4VPup6h3jU8rZ0l8T
	 gyyybDlZzCxhup3dARHgQEx6GX/sADx8eN9mbyy05g0hF2STQNsNkGllSTpWnYXzRA
	 MyLBa0DYffUEe0v6smC9GIH5dKdy529JvoA7CIYhf17ycl7ldcS9vC//JPtal+YI49
	 BT8Ga9s9cDgww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00A17CF21E0;
	Thu, 30 May 2024 00:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] netconsole: Do not shutdown dynamic configuration if
 cmdline is invalid
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171702903299.18765.2718725823072532974.git-patchwork-notify@kernel.org>
Date: Thu, 30 May 2024 00:30:32 +0000
References: <20240528084225.3215853-1-leitao@debian.org>
In-Reply-To: <20240528084225.3215853-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, thepacketgeek@gmail.com, aijay@meta.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 May 2024 01:42:24 -0700 you wrote:
> If a user provides an invalid netconsole configuration during boot time
> (e.g., specifying an invalid ethX interface), netconsole will be
> entirely disabled. Consequently, the user won't be able to create new
> entries in /sys/kernel/config/netconsole/ as that directory does not
> exist.
> 
> Apart from misconfiguration, another issue arises when ethX is loaded as
> a module and the netconsole= line in the command line points to ethX,
> resulting in an obvious failure. This renders netconsole unusable, as
> /sys/kernel/config/netconsole/ will never appear. This is more annoying
> since users reconfigure (or just toggle) the configuratin later (see
> commit 5fbd6cdbe304b ("netconsole: Attach cmdline target to dynamic
> target"))
> 
> [...]

Here is the summary with links:
  - [net,v2] netconsole: Do not shutdown dynamic configuration if cmdline is invalid
    https://git.kernel.org/netdev/net-next/c/c3390677f625

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



