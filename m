Return-Path: <netdev+bounces-204712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F76AFBDBB
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 23:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF8F1BC0185
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D1C2877FE;
	Mon,  7 Jul 2025 21:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INJz5NUf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105872080C4;
	Mon,  7 Jul 2025 21:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751924394; cv=none; b=LZfN3y7G7bvXyfbqhBb/q9eShcl088yUa3nJLGEfLFuU9/+pHKkQWM3KbdT1zLnDQcTYSXKOBmOSOz4AO4ucuLrvjAv5MPh+73gcXyAAnIkI2T280/ec/rionlpMyxn5ALySLvbCwteMs25KUFGI6ghPdeRugygc7oEJ0Yj4ob0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751924394; c=relaxed/simple;
	bh=c9uFvhlnAZCHpZ3udc5MhMt4wjQp48SDYYKSwIim9/U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fYlZvPa6rTESl3XPkhcVhZkljuB6Aw+YDo27lEhVdCtO1yGqGXlAThP2snQoqZEjQSu7LP+BgDTp8BYcX0h65J65D6mxcl8krcjDTN0OYGXRPvzkfLBjKAAVSRfEB2/J09SRGZ0+ysG3MV+eb5K+WWJ0+cGHlxDrbAEX4l1CH8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INJz5NUf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A944C4CEE3;
	Mon,  7 Jul 2025 21:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751924393;
	bh=c9uFvhlnAZCHpZ3udc5MhMt4wjQp48SDYYKSwIim9/U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=INJz5NUfod0192g5rH279/tTkTjsL0YL0bdXrlF0tj7aqRib5BUnvb9nEOANTAJ4/
	 aKyFWf/yXs9QAgYSC2uISp1K7OZqqOawDiDeSPp8aIsLiOu6LpTiaxATX3CJW3h+jr
	 1AEI6VAsLkAeguIuo7HO4PsL/tAie1slAVTnpiVhRV2pA5ojmhfx25s9XJxaECzQJ1
	 9+4Bbf0OL/TL717W76AFZENegaUXPIFVoZfEil7xEhHY2mSB0t8vL8EFDtz694Ukh0
	 6km3C6p/vZRK5A0louccQmmJIbVZn6eMHOrjgbB+3mpH2taSXTJ6EI5ROVEqtAIES4
	 kCN0gQTu9u0cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC2738111DD;
	Mon,  7 Jul 2025 21:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: openvswitch: allow providing upcall pid
 for
 the 'execute' command
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175192441650.3428827.8871404040370085526.git-patchwork-notify@kernel.org>
Date: Mon, 07 Jul 2025 21:40:16 +0000
References: <20250702155043.2331772-1-i.maximets@ovn.org>
In-Reply-To: <20250702155043.2331772-1-i.maximets@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, echaudro@redhat.com, aconole@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Jul 2025 17:50:34 +0200 you wrote:
> When a packet enters OVS datapath and there is no flow to handle it,
> packet goes to userspace through a MISS upcall.  With per-CPU upcall
> dispatch mechanism, we're using the current CPU id to select the
> Netlink PID on which to send this packet.  This allows us to send
> packets from the same traffic flow through the same handler.
> 
> The handler will process the packet, install required flow into the
> kernel and re-inject the original packet via OVS_PACKET_CMD_EXECUTE.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: openvswitch: allow providing upcall pid for the 'execute' command
    https://git.kernel.org/netdev/net-next/c/59f44c9ccc3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



