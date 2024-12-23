Return-Path: <netdev+bounces-154079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2579FB3C4
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3931884A3B
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4F51BE871;
	Mon, 23 Dec 2024 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+9A9nNb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96791B413F
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734976822; cv=none; b=RvXR4oY9Ik7XbeP07jzJJa5cRzLjBY9QgEqQQpg3ZFyOhqMy726TQv0c3iXojmvLGG4MfoMz3ksWpL3xXTdjwGTaLkC3MmB7i5OtxwxyYry2/inZVN/ADlfyRvcANz5pF9biRcKqI4lMJG0P7XqiX7yZCIJbb7ZvX19RyY3u0oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734976822; c=relaxed/simple;
	bh=XMGJZtCdSqM9z1Pjrl5PW1FJp9SMINHHby/OyH/PVBA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a6gbc9Gc9soLznr/G7pHIMpXw2jKzxDQNgGgBWsNppCbR3dPQHTqohzkZbq4YdwbjQxbQ9OhJpKAPDLXU9eFy6r6UmDvd0nmDgHC7B7y1HPgKQcqejOyevLppdt1DVKVTPdNNa8ePU3Bk55EjaIo5VC5qM3tkWXNG9SarFB1TLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+9A9nNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F9BC4CED3;
	Mon, 23 Dec 2024 18:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734976821;
	bh=XMGJZtCdSqM9z1Pjrl5PW1FJp9SMINHHby/OyH/PVBA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r+9A9nNb9XJFQKBlyaUuwLuZ+KaFASI9ch0RRlPz017OkGA1sY4BBTzb/5ymV9uLi
	 a5Jdr9tRmfl69bZLKYRumHRt8NqIU8b+0R4gBz92WezH/2gyg1nd6bbig2qdTXDQvQ
	 JJHXMujEzlAA+bPVGICXE9XMIWQuyc7+Mvf3KL44/vgJWfm5UUiu0En1rP/gXqWzjN
	 0/9CVeeJ6I8EiqPAoxsyCYhVP8eK27os5DpcYf9VTbpLyGj9XYCajn7iNJ4zPrE3Ww
	 HDm9rXP1GdwjYDHgktOXFHq0d1oFnZe5uuxMqGDZM2d0OPRI1hdaPS44GLLWxTb8nV
	 OQ7mssMfNGBUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BF83805DB2;
	Mon, 23 Dec 2024 18:00:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] eth: fbnic: fix csr boundary for RPM RAM section
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173497683965.3919340.13914375919588313789.git-patchwork-notify@kernel.org>
Date: Mon, 23 Dec 2024 18:00:39 +0000
References: <20241218232614.439329-1-mohsin.bashr@gmail.com>
In-Reply-To: <20241218232614.439329-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
 andrew@lunn.ch, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, kernel-team@meta.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Dec 2024 15:25:58 -0800 you wrote:
> The CSR dump support leverages the FBNIC_BOUNDS macro, which pads the end
> condition for each section by adding an offset of 1. However, the RPC RAM
> section, which is dumped differently from other sections, does not rely
> on this macro and instead directly uses end boundary address. Hence,
> subtracting 1 from the end address results in skipping a register.
> 
> Fixes 3d12862b216d (“eth: fbnic: Add support to dump registers”)
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] eth: fbnic: fix csr boundary for RPM RAM section
    https://git.kernel.org/netdev/net/c/a072ffd896ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



