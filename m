Return-Path: <netdev+bounces-120156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A70FC95875C
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503A91F22972
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0DD18FDC4;
	Tue, 20 Aug 2024 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzTeIKPn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72EE18E039;
	Tue, 20 Aug 2024 12:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724158296; cv=none; b=sbYwY8iK9w+1gUs6HtRP68RZWlh2icUwyY/Ej23sk9uBPN9F6Wt6d8Q110egosm4fiNatLaCE1oB45bN5MQc9j+0hZYLTeS9l7Xq5h+1dUo9eASyddICZvEfDN1jaEcOcWsc3WpVc7NkHXzWukphD+Hvmcm3mjGWBZOqpN2EYDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724158296; c=relaxed/simple;
	bh=p67qGnzj0hFV+rLece/SOAzVgxRPmFrPcwZF78eqbcw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cg+CQs0QfOiihvjkY0XKcm0tlufvT9/M/9gfVQsQTryOcKmYdXXJ6zFkB7U4x83Dz7NTJRgXEJvUCHuZRHG35yW0sYxwpuaZeua/IXffyGTVkBXfOhbbV+9gArOD76BHSX51ju9THgfv1uSqf7FL21jDVUeRa3YPpNsf5ZRqXeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzTeIKPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D42C4AF0B;
	Tue, 20 Aug 2024 12:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724158295;
	bh=p67qGnzj0hFV+rLece/SOAzVgxRPmFrPcwZF78eqbcw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EzTeIKPn5gLP0KVL8CPMKXD+sOpTDEXQRPogaEG9MNIYKtDLl1adtk1zh56HZ57kn
	 0/6S5W1neYxcWPmPGRR8Jeb4KPhVKPGvIj2wxK80b/AOsT1v77I7Vu4hHFKVapujwu
	 0W9891mgzUtx/mF86JTNoGUU8VjgyL9q+f/JDvstoWNv44Cg8JVZSMO5z3VHvIEtcZ
	 NKUUV4fT2UU+HJCeKE3Af+I3ZaVUOKCOplPW78LqnogmJmZ4xzR1KvH55HQ92PUV5E
	 lZmqga2YmL4SZElFBW/27CZwepW+E70q/f5OcTDcX9kAnC76pMP5EuuAJrAXkMQRZd
	 oE3KtlyamENFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EAF3804CA6;
	Tue, 20 Aug 2024 12:51:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] ip6_tunnel: Fix broken GRO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172415829474.1131310.14083868521176252198.git-patchwork-notify@kernel.org>
Date: Tue, 20 Aug 2024 12:51:34 +0000
References: <20240815151419.109864-1-tbogendoerfer@suse.de>
In-Reply-To: <20240815151419.109864-1-tbogendoerfer@suse.de>
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 15 Aug 2024 17:14:16 +0200 you wrote:
> GRO code checks for matching layer 2 headers to see, if packet belongs
> to the same flow and because ip6 tunnel set dev->hard_header_len
> this check fails in cases, where it shouldn't. To fix this don't
> set hard_header_len, but use needed_headroom like ipv4/ip_tunnel.c
> does.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> 
> [...]

Here is the summary with links:
  - [v2,net] ip6_tunnel: Fix broken GRO
    https://git.kernel.org/netdev/net/c/4b3e33fcc38f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



