Return-Path: <netdev+bounces-243120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B44DC99B18
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 02:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34A623455CB
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 01:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011711ACEDA;
	Tue,  2 Dec 2025 01:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6q/LtSw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE07119DF8D;
	Tue,  2 Dec 2025 01:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764637406; cv=none; b=s0P9mlwIAyrbYSH9QY5wVhd4aHHTrwNvfJuIzxxO+g1NsoTcgbpZR19wptZIxRK01DeEU05AX+cK4E7dxIOcsXoET57lrzzS4yiaOD3h995KqsvudKzm73xeoIiMifQbL5mHpLirJU4eJLULNkhPwM9ptT0eQxc2OpgtX1MKxxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764637406; c=relaxed/simple;
	bh=bDUyO/8pwGPWgnqf9TEf/6/As5sSaALRjTm2IoGnL+U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GICvwXelxUoHCV4ttTeRe0SAZRLfX+QRcpxmO07OEWK1qriUkHmK1PTB36t/53JaL1I/EqLnbskonMjXm+DtJ3Wv0wMfcp6uyu6LdVzvxg4xhW7cczcSOM3ZbzonLNaMwSrjhPC1YIOIRmlxRt/VWQ6U5yYgapIYV7o1HdGER9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6q/LtSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E7FC4CEF1;
	Tue,  2 Dec 2025 01:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764637406;
	bh=bDUyO/8pwGPWgnqf9TEf/6/As5sSaALRjTm2IoGnL+U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O6q/LtSwmyMowyRrOlHRD+XK4tslIK0Nv9ZI9OrhWeCRqKt/ptBO55pqlaTKUYJJB
	 ry+OOAs+60ZNBUXURm56TiQqL+D7PSR5aeXuwuUPBy1EFCQ/7QYlmEhtQFy7aRl5IP
	 Q8bVanK8ef3Jk0CjIzgipXfnzltfHTKYaH/erOByZNJYrywk0lhWLRYxaQbV6wQAxi
	 HOvWixVP0UqhYK3xKPtVvsciYvz0qrwKgKgTo2eFK3dtQmUcOXIIWttxijF9PqP4vd
	 yI2JXlq6IZYLzbc+Z6JuF4UK/ZQOwJ3Q1znuvgni51fdzekbRADw4KW7yTsrzY992N
	 2KSlUg8B4Nc2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5816381196B;
	Tue,  2 Dec 2025 01:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ps3_gelic_net: Use napi_alloc_skb() and
 napi_gro_receive()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176463722628.2619157.40495973344298966.git-patchwork-notify@kernel.org>
Date: Tue, 02 Dec 2025 01:00:26 +0000
References: <20251130194155.1950980-1-fuchsfl@gmail.com>
In-Reply-To: <20251130194155.1950980-1-fuchsfl@gmail.com>
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: geoff@infradead.org, netdev@vger.kernel.org, kuba@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 30 Nov 2025 20:41:55 +0100 you wrote:
> Use the napi functions napi_alloc_skb() and napi_gro_receive() instead
> of netdev_alloc_skb() and netif_receive_skb() for more efficient packet
> receiving. The switch to napi aware functions increases the RX
> throughput, reduces the occurrence of retransmissions and improves the
> resilience against SKB allocation failures.
> 
> Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: ps3_gelic_net: Use napi_alloc_skb() and napi_gro_receive()
    https://git.kernel.org/netdev/net-next/c/d8e08149a5ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



