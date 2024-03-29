Return-Path: <netdev+bounces-83437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7671892441
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 20:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4619F1F22AA8
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 19:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BAF13341C;
	Fri, 29 Mar 2024 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3FjMkd8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C4354BFD
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740633; cv=none; b=VXT8BpyWo8OsT5UU9g0dAeBIPYq/8GYSkxwRntq0ZcBa6LaBI0KqBiWXiUZgG9+I2/+qIZO2kiPJ+JD9pSHOzyXHBQAUmSzkt8s+LkjEN2FGL+AkBFIkp9VOlowxSojXJNer2YlGupU3wvicV5HvtQoVyfs1BVGm/50qr+z8Q9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740633; c=relaxed/simple;
	bh=ijnxAbzIs8ONVdZ7egCWV4fTD1tC9S9rGdRTTQzTy34=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cj26YAYvyYsePaKIwFtDCli0iRjDLk1M2Z9fZ8XLbgecd5eQ2YHfvv7tzRmCNEw1Ra8jGiHOXsESTvh2W7FPytvkgVI91nc1N45qLWF05X44K7NMG+YTtHPRX3AsCiXtLjGqyPpU2fJO+zcuy7I8AOnKeToiUYOZigVuhG1TBtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3FjMkd8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35A77C433A6;
	Fri, 29 Mar 2024 19:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711740633;
	bh=ijnxAbzIs8ONVdZ7egCWV4fTD1tC9S9rGdRTTQzTy34=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H3FjMkd8YVnUeht+fQ6WAbPVMKzRgIWgMc7/XsWVslbMIikUdPvcaCNwLA5+gkMCp
	 eGTEVKerX2mEM60mNAH/facJU5b+zvu/8/4wlW49GrJYCf+5gQwCCSH7wEV4vbbS/V
	 2HF509nldfmsewhc2L5J71CTrBMs6TpRuDZlEArh8V4Mz1gSkQPrdMIgbgW82uxDdP
	 wKAwsD5YVHeFKgbuCInYBiTkkAsw7iyCpJLqMZFDA3IEGkH20o5126ExL9uiRrCo+h
	 4kAwuz78oh9pxGqMWn1ffLYX5VHCbyeI+OFJoDxK0GzYbcpWD1GnWBNuKMKJik6RCX
	 E8Pbkdjhk6SHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26DF8D8BCE9;
	Fri, 29 Mar 2024 19:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] Add IP/port information to UDP drop
 tracepoint
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171174063315.18563.13899044939054991387.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 19:30:33 +0000
References: <cover.1711475011.git.balazs.scheidler@axoflow.com>
In-Reply-To: <cover.1711475011.git.balazs.scheidler@axoflow.com>
To: Balazs Scheidler <bazsi77@gmail.com>
Cc: kerneljasonxing@gmail.com, kuniyu@amazon.com, netdev@vger.kernel.org,
 balazs.scheidler@axoflow.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Mar 2024 19:05:45 +0100 you wrote:
> Hi,
> 
> In our use-case we would like to recover the properties of dropped UDP
> packets. Unfortunately the current udp_fail_queue_rcv_skb tracepoint
> only exposes the port number of the receiving socket.
> 
> This patch-set will add the source/dest ip/port to the tracepoint, while
> keeping the socket's local port as well for compatibility.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] net: port TP_STORE_ADDR_PORTS_SKB macro to be tcp/udp independent
    https://git.kernel.org/netdev/net-next/c/a0ad11fc2632
  - [net-next,v4,2/2] net: udp: add IP/port data to the tracepoint udp/udp_fail_queue_rcv_skb
    https://git.kernel.org/netdev/net-next/c/e9669a00bba7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



