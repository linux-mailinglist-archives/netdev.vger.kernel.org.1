Return-Path: <netdev+bounces-229772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9F7BE0AAD
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2633B1103
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8BF30CDB8;
	Wed, 15 Oct 2025 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyQvZ+X3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CCB30C63B;
	Wed, 15 Oct 2025 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760560831; cv=none; b=CkIBayM+y+ZQKh0ZvX95wKQbJilg2bE5/dVjoQijiyDvA9Jju0mJwMJtwwafPOisMqbZt6TQ8FmpcP/aQ0V5c2W19v6VHQivh73MyNe4tgp8h1FJIS+lW8FLbVNZ2ZCA56V0LxNB/rvVx6ct7/lkB08iORHgd6jddy2Y1NQK2CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760560831; c=relaxed/simple;
	bh=NHv5GZAIqoNybI4ki8D6N8tlk32hbI+g8RHx3SEw4FY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k6kIdtVdYXbdOVjOja/Mpbey5ppy+akyBmssXz0B7RXGlELASAVSf8T+Ubka8QU+Cv6sA7AjS7kpQZdf7KhI4ih/cRGHr/cqW1RMWcZHCaw+H1dvQ2T7KHz2bChNiwWj5iLeicd840n+GqMSRNMOq4nam/ZzCJBx520INIUUgls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyQvZ+X3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4277C4CEF8;
	Wed, 15 Oct 2025 20:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760560830;
	bh=NHv5GZAIqoNybI4ki8D6N8tlk32hbI+g8RHx3SEw4FY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kyQvZ+X3aahr9uhUivE43oFqnsiJ1EoSMmxHqSVHxCZ9Q2sqeHoA+SzRoSYVS5QSO
	 jJs7LPEM1yX4w8x6McCsePdEqbdIkePifYz3yB+R7oKXZy2LhnU8k7ujinSfPgr6NO
	 oHDXWj++4D0oR9WIkphCh7Y+KGA7ZDRQWq8RHxZXqtqp5J+haGTiyf/RAE8Y8OqlDK
	 mbqFsUB32gOonspcVdPOlRbB6Yq58K6DjzEU9AzNH/8EXabcaXDsBbCNiT7YoJN89j
	 6Vx7eatS/ipyGQDVukrPSstjrMMAOmeNz9ziRdvlNJru7mWij5e3rJaboKilt6qS56
	 86Z8Nbc4dkzWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD52380DBDF;
	Wed, 15 Oct 2025 20:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8152: Advertise software timestamp information.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176056081549.1041854.11723126347879763424.git-patchwork-notify@kernel.org>
Date: Wed, 15 Oct 2025 20:40:15 +0000
References: <20251014055234.46527-1-rawal.abhishek92@gmail.com>
In-Reply-To: <20251014055234.46527-1-rawal.abhishek92@gmail.com>
To: Abhishek Rawal <rawal.abhishek92@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, arawal@redhat.com,
 jamie.bainbridge@gmail.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Oct 2025 11:22:33 +0530 you wrote:
> From: Abhishek Rawal <rawal.abhishek92@gmail.com>
> 
> Driver calls skb_tx_timestamp(skb) in rtl8152_start_xmit(), but does not advertise the capability in ethtool.
> Advertise software timestamp capabilities on struct ethtool_ops.
> 
> Signed-off-by: Abhishek Rawal <rawal.abhishek92@gmail.com>
> Reviewed-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] r8152: Advertise software timestamp information.
    https://git.kernel.org/netdev/net-next/c/a8e846b8d93d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



