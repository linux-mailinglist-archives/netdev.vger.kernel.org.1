Return-Path: <netdev+bounces-158260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF48A11413
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB280166A79
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 22:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1862135D1;
	Tue, 14 Jan 2025 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHVJvXJ3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C572135D0
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 22:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736893817; cv=none; b=K3nmDzAmcH3SKxDfQ0eVeR0XJ2aZRgfCBKJ0bXPfm1HMJgZFZBbxc34ZQF7FE6l4TzZm6MLUzoVCh5+7fRrsXsVWuHnJ27LMzDTdN9+tka4M3xwuZjU1Z2JeRw2rLnw1K9IXYFsqMZlh3v4NoYg1EZnz0Cwc0xL6gHJO3hbLKts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736893817; c=relaxed/simple;
	bh=J9Oi4L/oIj+T0y89xET9B7HRjeyvYQBi2X5pas7qnco=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IBkk3TjOwqEE6YoTIniwVgPY5aEsM3rcvBQxuIMx8wlg0WGMOHSZJ7b8wWld3/f2PXDRqsfx7KpYCIFVqaLuIlQELL5/hjEvKSCR9FL/sGBwxozkZBdfyiCKr2HKFuaXmHoJJiFimFMaOtJnt7ewjXUUgGK/sA508qzW24eM9k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHVJvXJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06407C4CEDD;
	Tue, 14 Jan 2025 22:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736893815;
	bh=J9Oi4L/oIj+T0y89xET9B7HRjeyvYQBi2X5pas7qnco=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rHVJvXJ3Nx7iQinfvmVr1wm7NK/tnTWpa1XDX9q/3XaTPB3pQit9dWp+X8+NaUvPR
	 x21YcUYOD0S6b91123Pn4M8fQ9QdnYvGdhKEbHbJ63VzeL2VB9lPuN1ngOuJpSUnKA
	 nAmAEhEzLYSKq6TPNR/N/fuCqnTw65POW5rPW2xYIpvCZV4qyf5pjqGrru7NxSNory
	 UPpVteurQj3B4I7laUTR0YghTZwgNqF0G1+ElCWl2abBbbGNjaayTdymO+O9Bgs2I8
	 HYM4BFxORGgXd3eg0CGAqRES0LbBmTsc9cv22fOvusMVZsyjs8RqMfyTqQLuAEaGEs
	 3wWmULz4nefqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB8FC380AA5F;
	Tue, 14 Jan 2025 22:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/3] tcp: add a new PAWS_ACK drop reason
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173689383778.162948.15353094136956629194.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 22:30:37 +0000
References: <20250113135558.3180360-1-edumazet@google.com>
In-Reply-To: <20250113135558.3180360-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, ncardwell@google.com,
 kuniyu@amazon.com, kerneljasonxing@gmail.com, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Jan 2025 13:55:55 +0000 you wrote:
> Current TCP_RFC7323_PAWS drop reason is too generic and can
> cause confusion.
> 
> One common source for these drops are ACK packets coming too late.
> 
> A prior packet with payload already changed tp->rcv_nxt.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/3] tcp: add drop_reason support to tcp_disordered_ack()
    https://git.kernel.org/netdev/net-next/c/ea98b61bddf4
  - [v2,net-next,2/3] tcp: add TCP_RFC7323_PAWS_ACK drop reason
    https://git.kernel.org/netdev/net-next/c/124c4c32e9f3
  - [v2,net-next,3/3] tcp: add LINUX_MIB_PAWS_OLD_ACK SNMP counter
    https://git.kernel.org/netdev/net-next/c/d16b34479064

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



