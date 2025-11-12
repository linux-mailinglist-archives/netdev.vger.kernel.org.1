Return-Path: <netdev+bounces-237801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE28C50541
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 03:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037983B25A2
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 02:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8751917F1;
	Wed, 12 Nov 2025 02:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giOWRU/W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DF922301;
	Wed, 12 Nov 2025 02:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762914040; cv=none; b=llJ3xmS9rNc6EKVzmjBQklodmbsqgCj0X1WesMfvDB+vy9TGa6+JSDqtvJZgkT4a+Aa8tgdFhhoyXVdQUWA2nwl6UQV0e0yP9Ey9pMntswBukkOn857fw6jYLfvb72N347Lhz8loS6UMf7tipQjnvjB685S3fNubYEbMa2nSlXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762914040; c=relaxed/simple;
	bh=PKFt6Yalq58XwDx0B7O/4lvJWYHogc48BPfJjedBd7M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gdui62P28Tcp4wCuWSCS5kylgzph36jv40HSEd05DOq03lvCioV7eIFm85DSbqpDVN91okQ7IdKkVo3cn2cotnholA4w0NN1JLn9ilFJZ3FcUiGCksV4O/c2dWlz0WnIQgGPG5ddz33/lqvQHoJoukPFXbFeZeq0QYE2PbA2/Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giOWRU/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB561C4CEFB;
	Wed, 12 Nov 2025 02:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762914040;
	bh=PKFt6Yalq58XwDx0B7O/4lvJWYHogc48BPfJjedBd7M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=giOWRU/WSP2OMU59905oSZ9RuACnDeC40ubBUVrWy9edarQsNyto/s+2ayQkdgAGs
	 HZy66tFZQUl1Q9GpT1AZt7Um8f4D7dyEFGTITIS+EXsRdNOgpEDzRr41Ef1o1gp3Mr
	 1KUo4nllZMwoatg3e1O345bWADAXXbMbonDuyvUJRvsTY8Tf+z9xHl7ZlfV2q5lUjR
	 8MqyQe/lvAK9aHU5F+6tofYjNdrM0mz3sP5tt3NNQ1qexba0afJpEPiDmWrwrzHZSz
	 /u9wdGoIdfcjrZFAANWpHy9B+KZPhu096pYqe08etjdcEi6FibAldL8eJP/5d5/Z9H
	 Edff8NmTBLgcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E47380DBCD;
	Wed, 12 Nov 2025 02:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: sparx5/lan969x: populate netdev of_node
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176291401005.3638373.13399980583922372117.git-patchwork-notify@kernel.org>
Date: Wed, 12 Nov 2025 02:20:10 +0000
References: <20251110124342.199216-1-robert.marko@sartura.hr>
In-Reply-To: <20251110124342.199216-1-robert.marko@sartura.hr>
To: Robert Marko <robert.marko@sartura.hr>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 horatiu.vultur@microchip.com, rmk+kernel@armlinux.org.uk,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, luka.perkov@sartura.hr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Nov 2025 13:42:53 +0100 you wrote:
> Populate of_node for the port netdevs, to make the individual ports
> of_nodes available in sysfs.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
> Changes in v2:
> * Per Daniels suggestion, set it directly in sparx5_create_port()
> instead of doing it in the dedicated netdev registration function.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: sparx5/lan969x: populate netdev of_node
    https://git.kernel.org/netdev/net-next/c/fc6aa0e470e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



