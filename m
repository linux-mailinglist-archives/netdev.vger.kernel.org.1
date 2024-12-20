Return-Path: <netdev+bounces-153548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1D19F8A10
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6764A16A3B8
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 02:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F39229D05;
	Fri, 20 Dec 2024 02:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0Uzak7o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B67827462
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 02:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734661219; cv=none; b=NTG8kpi8RzMj1NVJNGQPRZbBxP//JoPupAzVHryEo2K0H9cqy97C85Lq6fBQ5MQE8E5P9Jz7g8ihcC75cJgyVR+LtLoJ4VGdcHZyF+WaR7gHt1vlBjgn5t48Mn70Iz7SYBBO6BjOsw9REq/rTqe4kVkaAvuRVilPWBHHwWTcb5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734661219; c=relaxed/simple;
	bh=lpvAnIrxLGhMGu13wWNhP69fQbPgWfOTN3s9LoXosaI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rkUnseDBz0gGkr9WHMlcdp75gKIVESVVAt1M+Dn0ksaI8fHysIRnR3H5gqttyvbfU+u3g30J1CsVqp7LlSUhgyEMAqEdZVGnKmXnJIDHWzNJm8DWQWSuJwoE1MYJFet9eBP3Ozbgn4mbeWeUFHvCD8EQ3E9JbdW4gw6yx3AOQCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0Uzak7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC80AC4CECE;
	Fri, 20 Dec 2024 02:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734661219;
	bh=lpvAnIrxLGhMGu13wWNhP69fQbPgWfOTN3s9LoXosaI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m0Uzak7ot/U6i0ZPODH65qMeJvvY2e62KWEWG1vNTat0w9PPCwEl+di4kFtiX3Dmf
	 nPJ/SHPBmZEcytqFWnkJ1fvcVfW0FDQbC2Nc2UZUkMZCze8iGl7dldoaXpz9/uUWy2
	 +FN8ToHNx1uiFXmFKQ7urwFBKcuV05SAOkLKXKt0l6LB6VJVwl4ozGc+6vP2qgsVJg
	 j/YpMhQa1bryJ32huIRAFjBzI8gs8TsgtU4plh+cDxx5m8eDF5qqehSpbaM/GX/OmY
	 YaLJuG8uzzWGPP3r+0pjRK+XTKnM02IfcCsorXK4rAM7aubXvFP5TS35lOijPoMxBN
	 xbDXWauSBBruA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE463806656;
	Fri, 20 Dec 2024 02:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: netlink: catch attempts to send empty messages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173466123650.2451213.749392746922936874.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 02:20:36 +0000
References: <20241218024400.824355-1-kuba@kernel.org>
In-Reply-To: <20241218024400.824355-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Dec 2024 18:44:00 -0800 you wrote:
> syzbot can figure out a way to redirect a netlink message to a tap.
> Sending empty skbs to devices is not valid and we end up hitting
> a skb_assert_len() in __dev_queue_xmit().
> 
> Make catching these mistakes easier, assert the skb size directly
> in netlink core.
> 
> [...]

Here is the summary with links:
  - [net-next] net: netlink: catch attempts to send empty messages
    https://git.kernel.org/netdev/net-next/c/75e2c86c7b18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



