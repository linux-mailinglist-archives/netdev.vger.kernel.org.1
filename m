Return-Path: <netdev+bounces-135823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2966599F4B5
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 20:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F901C232C2
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 18:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CD3229139;
	Tue, 15 Oct 2024 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amSCJzcA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC53A229132;
	Tue, 15 Oct 2024 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015237; cv=none; b=r4BM9qqBYkEb1p1847grUEAKcjWzG5elJqp4f6cNNogZpsq51XCZ/JvUI6AWuoUUtq7rBQYc0ps70lo2lchARZRe70TeAReKjhWkXVhkqYCEPbVKW+NWEX9/RYkmm1MEVcd7v3i56b6yz7jqgQD7ozzz7xNKV8xYRRDXNxB+9AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015237; c=relaxed/simple;
	bh=fdbd65EpwTQwaAunrY+wHtKWSQ6zq5EpEVq1loN4KaI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TJg0g7E2Pe/s92myoTbVQqP4w85AwSxysvP0UNGUvQ3KDrTDdJrAQ0HDJlhD7Yt3+qJvn71JNbqPCeGx0Mc++1GeBJT+wVYZr1nUJG7BW2nUmAM5ABc+RWsvzYBd/0LjfKOXexlmb99N3E//cLUahU1Lfk0afkEwYcAPUz+saJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amSCJzcA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455A5C4CEC7;
	Tue, 15 Oct 2024 18:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729015237;
	bh=fdbd65EpwTQwaAunrY+wHtKWSQ6zq5EpEVq1loN4KaI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=amSCJzcApuRPxhbYBQKcE1D2W1DIsFnjQ8nbXR66jYXTIHhGfjQBuSqZjXla1czfq
	 cJ8vab6ReUUNkjxiBCBNNACyrrJX4efZO2DmKuVdOjsfBSrNmfkzUjpKoS9ZowtkoH
	 yMupU+NO2xvA8HilkmSxz3qclhOn9DyoiLpMrH3cnBo7U1MGYAiNX5H4ad1/gSBmdd
	 wuu8mPy2URn3X4Y0h8oa3I0UkV8sJBAHv0PxB8/11g3wBklMMgXE2Xyme64TRiVM/j
	 Ut3d5rwA5efDp1iZdqFByi4SadoKfShEuSNdgngXxngX+WS5Gx5WsEZO3iZ9oX8SH3
	 a+v/WTS4dGdLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B02BF3809A8A;
	Tue, 15 Oct 2024 18:00:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] net: ethernet: freescale: Use %pa to format
 resource_size_t
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172901524224.1243233.8750809850342370605.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 18:00:42 +0000
References: <20241014-net-pa-fmt-v1-0-dcc9afb8858b@kernel.org>
In-Reply-To: <20241014-net-pa-fmt-v1-0-dcc9afb8858b@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, pantelis.antoniou@gmail.com, geert@linux-m68k.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Oct 2024 11:48:06 +0100 you wrote:
> Hi,
> 
> This short series addersses the formatting of variables of
> type resource_size_t in freescale drivers.
> 
> The correct format string for resource_size_t is %pa which
> acts on the address of the variable to be formatted [1].
> 
> [...]

Here is the summary with links:
  - [1/2] net: fec_mpc52xx_phy: Use %pa to format resource_size_t
    https://git.kernel.org/netdev/net-next/c/020bfdc4ed94
  - [2/2] net: ethernet: fs_enet: Use %pa to format resource_size_t
    https://git.kernel.org/netdev/net-next/c/45fe45fada26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



