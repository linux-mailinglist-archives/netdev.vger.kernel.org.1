Return-Path: <netdev+bounces-217111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1D2B3763B
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 02:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7471E17E864
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 00:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FED91D618A;
	Wed, 27 Aug 2025 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ack80bo6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765211C9DE5;
	Wed, 27 Aug 2025 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756255801; cv=none; b=AUM8A6iqrACiYTXAChkG51h0SrzwJ0tVTnvE9V8wts3vv72d10Iy3J7xOuNJvyAaMl2Np9uUg9eGdNcQtkAjKG8HlXUKlLygrjKmAGyRHZNBpAKFX30Sp1UUPVFXj32OhB0hDjPxtm5Xl39BPm3Kh94a3GZgm2FQaogbt4wCeb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756255801; c=relaxed/simple;
	bh=+H8klAL/riVemsqz8qkZr7HZoKVNZhLlkM/cfFsoVQk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fS7XcbYEHLEIajWxMF4f5u9cqTTvj6P3ofhK5jQvnXrSVfttDTfkhXFdklsWSW9sP+ggWBbh3VTPqvbJKJ+DgpWKk0R6X2gvmmZK/RzUrhVwS+PINIFy5KcrYgCZzfnIQm98AifnwsnUDqhkxgmFhItDpQmOHp+Os3HQgAJQLDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ack80bo6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882C4C4CEF1;
	Wed, 27 Aug 2025 00:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756255800;
	bh=+H8klAL/riVemsqz8qkZr7HZoKVNZhLlkM/cfFsoVQk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ack80bo6LQWq3uUJ8w7681ZznOUvpLebslYjDe10sX5MS/xuw/1wlNJyl1T8Ey7R+
	 f8F9RWUuA/qFYZRKyO+KGUvN7qQN5hVrg30+VzVJiQ2uzuvUNF21FaoalrJxmK3P8a
	 Zd7VMzdXK2vibCf8bnABjFa8M45ESXSCxB+MQk14dltY8RnA9Fx4dPhiiX+gRbiBPP
	 Wvf8FA9FRSowbJbP/tOL/UFEEQx5CTK+7kG45nMMPYryJLeRgoFKzPU+wuaEwb4YAz
	 GdrS1MivYnrsHV2bfkZoiLbFr1ZZa+oMb8yTCqZp6h94sIvmGbjT+4xDCTD4EQGUX9
	 lhLdQVkL5FnLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3415B383BF70;
	Wed, 27 Aug 2025 00:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: macb: Fix offset error in gem_update_stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175625580800.152740.10775103761853498420.git-patchwork-notify@kernel.org>
Date: Wed, 27 Aug 2025 00:50:08 +0000
References: <20250825172134.681861-1-sean.anderson@linux.dev>
In-Reply-To: <20250825172134.681861-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 claudiu.beznea@tuxon.dev, nicolas.ferre@microchip.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Aug 2025 13:21:34 -0400 you wrote:
> hw_stats now has only one variable for tx_octets/rx_octets, so we should
> only increment p once, not twice. This would cause the statistics to be
> reported under the wrong categories in `ethtool -S --all-groups` (which
> uses hw_stats) but not `ethtool -S` (which uses ethtool_stats).
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> Fixes: f6af690a295a ("net: cadence: macb: Report standard stats")
> 
> [...]

Here is the summary with links:
  - [net] net: macb: Fix offset error in gem_update_stats
    https://git.kernel.org/netdev/net/c/16c8a3a67ec7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



