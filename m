Return-Path: <netdev+bounces-89608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 307178AADCE
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 13:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54AF1C20906
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 11:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6D881720;
	Fri, 19 Apr 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtqwZFy6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558E380029
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713526827; cv=none; b=V4PImvL/N+shAv7pXQcKatvPBj1+LknlCb9Uo6cXFWBwT/TuQ52z4T2yAa8Ia/27pNoys6gN9Sr91m1a8Y72skdFs1eXysHZj4xaeK5jwvcz7X3bgbqaUcDzi35oiSK7EnDOXvi3K/jeGIFNvFOXYdQmJG/51Ovyk1b4RO8iBtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713526827; c=relaxed/simple;
	bh=iSlQtKREFBrk107DHLgvM9l6qc/wU0OliXspGWtgbxA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KJND4asV/2w2aRXGSHLK97ZDkv+qKWxqBw38EwGZIvAbPIW+iuMbAuvxCrQOpWNgLB0iNIw7NRaukLyFVVjCsitpGKN8ljXa6XzIYH3sqBNXGJmkaqNO0l3hlfdHAtRT3OqpKOi888Wx2yd9AMsYzs0YRpvfmT8w0Eg7GPNW9eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtqwZFy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB11EC2BD10;
	Fri, 19 Apr 2024 11:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713526826;
	bh=iSlQtKREFBrk107DHLgvM9l6qc/wU0OliXspGWtgbxA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZtqwZFy6/+fzzU6ln/8okfJDlTehmbIz7H8ywsDt98P2zzPd/Ww1URq31ubpSpqSA
	 v2xXWpxovk1aGvdXqH6jdqDlTIzs8YJZ043jqT9anZxMmkclwzBNHTRYNJ9DZ+HUZu
	 5MO/S6lEimKQY+dFmq6hsW74FmXY/O7k0bSgfHf5oyIOtEHgu8OklBOD2SX4FC+Jtc
	 St2d/HwVIKnKtQjPAa+tkvWe64BxzIiVQ3etDZl9f9giAJ+VLo7mJghbX/b8ZDbeK1
	 MHrvz5jGvhGew5Y1hbfeXIMcM5q22GEymsj4kAd0EiCWXoE6dpYadw2Z0iVatKJ7t/
	 L+Ab2Be/GPlWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9297C433E9;
	Fri, 19 Apr 2024 11:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] neighbour: convert neigh_dump_info() to RCU
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171352682675.11045.4640653458191585742.git-patchwork-notify@kernel.org>
Date: Fri, 19 Apr 2024 11:40:26 +0000
References: <20240418095106.3680616-1-edumazet@google.com>
In-Reply-To: <20240418095106.3680616-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, dsahern@kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 18 Apr 2024 09:51:03 +0000 you wrote:
> Remove RTNL requirement for "ip neighbour show" command.
> 
> Eric Dumazet (3):
>   neighbour: add RCU protection to neigh_tables[]
>   neighbour: fix neigh_dump_info() return value
>   neighbour: no longer hold RTNL in neigh_dump_info()
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] neighbour: add RCU protection to neigh_tables[]
    https://git.kernel.org/netdev/net-next/c/f8f2eb9de69a
  - [net-next,2/3] neighbour: fix neigh_dump_info() return value
    https://git.kernel.org/netdev/net-next/c/7e4975f7e7fb
  - [net-next,3/3] neighbour: no longer hold RTNL in neigh_dump_info()
    https://git.kernel.org/netdev/net-next/c/ba0f78069423

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



