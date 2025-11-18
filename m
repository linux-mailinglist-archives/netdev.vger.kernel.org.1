Return-Path: <netdev+bounces-239313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C00ADC66CC3
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id D0D3229A21
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F342FF660;
	Tue, 18 Nov 2025 01:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/+piTJV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3000D2FCC1B
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 01:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763428249; cv=none; b=h0Mlqc3LvvhoTkLiN+onm3bGNxwROI8uZvKjCMB4erubtMzaxjNAcOGkyHUkh108spGyeWuVEgBoKxQyQy4ZCfdIxE3U5FknmO7k+H+tm4LLxZJTszafhut9R0qpjc1PFFm3cY0RFTCVTnou62DhoMRja36e6a/gagx3KFzwruc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763428249; c=relaxed/simple;
	bh=9vTzVSS0l6qWOWGceeucSXI/gfzIgIl4DU8owlEvKso=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OKaNJ+OrL4dybb2h5HmtFGwaMuJDQlAHiY1yGSF8fv/fgk+oV0JluQ8xzh9vCoRjmRxROEh/QizdM5ceCwt3/3VhQm4mBFh+hsTzdGdXFNYCb6WfUnHLcNhEOpwiATBl6CB6KsbsqREOAd6h57MoJtDk7LSqxWDAR4IaehxG2D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/+piTJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765FEC113D0;
	Tue, 18 Nov 2025 01:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763428247;
	bh=9vTzVSS0l6qWOWGceeucSXI/gfzIgIl4DU8owlEvKso=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q/+piTJVAmVsQDkNTEApFOOWii8mmKg3AQiJUptud/+P1DKyz0Fzevcsusvdgx4+K
	 6LftqHRPA4Z++vNnZ1lBXDt7Z8IYVrXJKHPTUqYiqFNldzA4wNBBtYxQT5lGDQNkHz
	 wOV2mV0QliDNuvmMqPZC2rSbfSyo4WOKETJLyLAv+jjzcKJbb4rfB+5EHokl2PWZic
	 Ln9NNqzEWl2f16XM1PUo+x+3cXvRMV+/WG+1GLDA6a59GXbn7jNRS0wLYp0jiDnfuv
	 cLkLhWkQJ6K1iGQCDhdpBbqTJ0d3oq6KeYTnEYs/qIBTfFOFFpBiJjU2rsO4csZ4Q0
	 G94di+nHWYcCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF743809A18;
	Tue, 18 Nov 2025 01:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: reduce tcp_comp_sack_slack_ns default value to
 10
 usec
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176342821343.3535669.11620353095531584631.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 01:10:13 +0000
References: <20251114135141.3810964-1-edumazet@google.com>
In-Reply-To: <20251114135141.3810964-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Nov 2025 13:51:41 +0000 you wrote:
> net.ipv4.tcp_comp_sack_slack_ns current default value is too high.
> 
> When a flow has many drops (1 % or more), and small RTT, adding 100 usec
> before sending SACK stalls the sender relying on getting SACK
> fast enough to keep the pipe busy.
> 
> Decrease the default to 10 usec.
> 
> [...]

Here is the summary with links:
  - [net] tcp: reduce tcp_comp_sack_slack_ns default value to 10 usec
    https://git.kernel.org/netdev/net-next/c/ca412f25d6b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



