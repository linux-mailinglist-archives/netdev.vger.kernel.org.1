Return-Path: <netdev+bounces-167150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D90FA39045
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5561722B3
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 01:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90B813B7A3;
	Tue, 18 Feb 2025 01:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3HyX2ch"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55A513AD05
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 01:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739841618; cv=none; b=qL6kR0W53Qzwpd7tYD9oC4RhI7Ri5a7S2Gu4/QUNCBhgl2aizZ3OlW2VC/cP83RXtG9gpHu5Ro6pChXFb+im4J5dvjjmU+y4LvS0WAi8IypCTMw0dWSEnaY5heCnGpeviQduw/kYC+czbFLzMxBZ2tm4U59CHomhcayv0nOLKPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739841618; c=relaxed/simple;
	bh=1d0D01SsN7CPhK5R2uzPsO/QAzAPAQUna+USB54YmIw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=luJUUBWGRvQnIDWMqv14QJ/OWpZnTaRRHke+HSLfiAXKXS7TjvfHu5tT4P51dDn/YPP6qk776rzz+GEG5Upywo3YQRzZB5rN++4N8bI98UdXlLpZAREmwXlEj5YF2RdiKUBG1Bz3Moovz6U6BIq0tSlxyMq/Vw3bT5DFRXYTtCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3HyX2ch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E17C4CEEA;
	Tue, 18 Feb 2025 01:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739841618;
	bh=1d0D01SsN7CPhK5R2uzPsO/QAzAPAQUna+USB54YmIw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p3HyX2chvLmAsEDd/Ta1PMIrSH8W4I41yYFVEsk6Uo5CBQQtTdSNeWrSpyYyt7qqH
	 uon9cfaoqex8lczAjCKc9qXiN23SQYElLEYFJ2TkUPLJZGMo6KMncxz5mh60UXiUnt
	 LCnZU0WGJRWUnmD5jlxLnRVxZGdOhJhS0VXz42TU7kC6MDdC49319t18smNmSZtgqf
	 iPQk5mTWoBcMpp84nJngJdiHug65h31RE3fQvk5jagRRrpE6wnxVpjqGphnNRQXNnC
	 k5SNsMA14rgaxd8JCrMk1OPizcjQxchgdHrSK4OyV9T4tSr8cG7a/rgtg15A1zni97
	 QrDmD+9CRQXJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF59380AAD5;
	Tue, 18 Feb 2025 01:20:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] netdev: clarify GSO vs csum in qstats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173984164850.3591662.2894953533517397015.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 01:20:48 +0000
References: <20250214224601.2271201-1-kuba@kernel.org>
In-Reply-To: <20250214224601.2271201-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 willemb@google.com, ecree.xilinx@gmail.com, neescoba@cisco.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Feb 2025 14:46:01 -0800 you wrote:
> Could be just me, but I had to pause and double check that the Tx csum
> counter in qstat should include GSO'd packets. GSO pretty much implies
> csum so one could possibly interpret the csum counter as pure csum offload.
> 
> But the counters are based on virtio:
> 
>   [tx_needs_csum]
>       The number of packets which require checksum calculation by the device.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] netdev: clarify GSO vs csum in qstats
    https://git.kernel.org/netdev/net-next/c/b5e489003abc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



