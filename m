Return-Path: <netdev+bounces-126754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F6B972623
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 02:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64611F24A20
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 00:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47B52AE69;
	Tue, 10 Sep 2024 00:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLb9Ejmm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07B92943F
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 00:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725927645; cv=none; b=FJ2OJ+BrHr+7DSlKaeRD/VUh6YLNb5Yha//Cm6zVLiBeTCD/Z/DtFEjNksKXCZrqRK9brDaMSM8QL+khJAgQn2lOz8AAWlIXwaP4+ZkBOdhspbIRdUGJjRHkXdkuq+AL8K/CATU5dhZ5T8s+YYuHUtEZTmX7gV4aQVsJGC8tFpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725927645; c=relaxed/simple;
	bh=1lhFn3I1OthpFQtabFkCZWjNVgGAOTo74NA5drwSoYw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q4bHwnqVO4J2fy+vuZFo1wQaKS+yAz7v80OwLdrZmi/Z5MBeA5m5hzbSKaMECDlEeJvK14FaC6n/xSCsc2ycvANqQbwgv8Ie0X+R5I/gXnZ+ConE7b7bMt5C6F8iZJjoheuAUbHoEwLfcTnmz6Lr78nKcrT7eQ0KlSAwHgunges=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLb9Ejmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8FAC4CEC7;
	Tue, 10 Sep 2024 00:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725927645;
	bh=1lhFn3I1OthpFQtabFkCZWjNVgGAOTo74NA5drwSoYw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PLb9EjmmglC4pkK8eZ4wq63eYibENgKU7/2pFrdNk3Ww8NM5Jmx6TjFqJTdaA2KUj
	 YemD3p5OBtvtx+C3yrY6FQ/P3Qa5fZ7pRsKO7xWNMVrmmq/hoj/ZXgWX3rsK24FtSx
	 WGNpl7ptBQJfGArLRJvNIHijRKNebGE4V3GkGPu+xvzlRGrUWTZHg/kjd8UDzMcDGI
	 wvcoFh0h7n1NelTaxHndo9VK6vLfVGOMjAwyEJ3TaOFwvG/K7T5k8SUxuMwOzk9leP
	 i6F5EeFKdydzMyN6iyYBqBChvBTiZJdf2wQhnJd7SLA3+mh4JI9+T8Ug61JKjiyJSM
	 WsOiDupyqsX7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C2D3806654;
	Tue, 10 Sep 2024 00:20:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: remove dev_pick_tx_cpu_id()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172592764600.3964840.10974933934426548682.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 00:20:46 +0000
References: <20240906161059.715546-1-kuba@kernel.org>
In-Reply-To: <20240906161059.715546-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Sep 2024 09:10:59 -0700 you wrote:
> dev_pick_tx_cpu_id() has been introduced with two users by
> commit a4ea8a3dacc3 ("net: Add generic ndo_select_queue functions").
> The use in AF_PACKET has been removed in 2019 by
> commit b71b5837f871 ("packet: rework packet_pick_tx_queue() to use common code selection")
> The other user was a Netlogic XLP driver, removed in 2021 by
> commit 47ac6f567c28 ("staging: Remove Netlogic XLP network driver").
> 
> [...]

Here is the summary with links:
  - [net-next] net: remove dev_pick_tx_cpu_id()
    https://git.kernel.org/netdev/net-next/c/17245a195df4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



