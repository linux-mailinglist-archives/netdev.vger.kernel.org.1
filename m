Return-Path: <netdev+bounces-219163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35B2B401F4
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 15:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36DA482C87
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 13:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36152DFA31;
	Tue,  2 Sep 2025 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McYXWR2M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB3A2D595B
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818003; cv=none; b=T/wWL4U61jEMcmYwK83lZB5Ysf51SNQisiJIU7KiQevRgtsSEC/EWmugfeWtSa66/NU0CMglZAm1UWp7R927XvMquZCDKb25LStcFTWAYkeBCSVUDx2Deg8b5LQjoNpNOQP+qQknXMx6g/RhArx1wtervG9JiXD49gJ9zvVdKnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818003; c=relaxed/simple;
	bh=CC0o88EdyvQhLxLbMndlyc/vLhq/S+L7b8liOvHXC/I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WZiYMQ4ckN3B2luzr9PevDrtk4a7Da74225p2BnAHhq1e6+Imq32vP+ykydbT8MMBzgR4oWi3gM76BgTFHG5vhDUEf/Q8wnrtaKI/1vqIpUNHMZSVWGRdmGKksi1B7INgHQS/zuhIpeqUQIr/GlNevLGhZCSZP3M6v73FfYO6So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McYXWR2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71099C4CEF9;
	Tue,  2 Sep 2025 13:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756818003;
	bh=CC0o88EdyvQhLxLbMndlyc/vLhq/S+L7b8liOvHXC/I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=McYXWR2MFXFu7//+HtPB6i6OUsFTc2AyGkk/n1Kgho7KKn7M8UFUo1VaOX6wUBBaK
	 1zss9WNXx5zmu34qyw+cHlSuz2LwOshkMnsnrTAuQZHptTZc9/l7IzYhAoj9D3p3lO
	 SAMcZhtLmelyrx9oJ2qS1E1kwitLrGNs/ce0wRWWBBwF/JFCHJLPY3HF/XOGodpV3u
	 k6Tk7WHZJGBNWqrOmRDGBXvibJp1DfagdOApcAgcKaa4HkTU3ezwbsFDWPAunW1kFj
	 a0WYAxhnbktVX8BzrTRcH/uf3e5MAzS9qf5KPSNgR40ccUM82UkNuaC5GV2TDVyiFA
	 lI1Ds2iufDfwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB32A383C250;
	Tue,  2 Sep 2025 13:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mctp: usb: initialise mac header in RX path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175681800852.285041.17987777014140847824.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 13:00:08 +0000
References: 
 <20250829-mctp-usb-mac-header-v1-1-338ad725e183@codeconstruct.com.au>
In-Reply-To: 
 <20250829-mctp-usb-mac-header-v1-1-338ad725e183@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: matt@codeconstruct.com.au, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 29 Aug 2025 15:40:23 +0800 you wrote:
> We're not currently setting skb->mac_header on ingress, and the netdev
> core rx path expects it. Without it, we'll hit a warning on DEBUG_NETDEV
> from commit 1e4033b53db4 ("net: skb_reset_mac_len() must check if
> mac_header was set")
> 
> Initialise the mac_header to refer to the USB transport header.
> 
> [...]

Here is the summary with links:
  - [net] net: mctp: usb: initialise mac header in RX path
    https://git.kernel.org/netdev/net/c/e27e34bc9941

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



