Return-Path: <netdev+bounces-186876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC1FAA3B59
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 00:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3584A7EE5
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34032749CA;
	Tue, 29 Apr 2025 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhnWsvWq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F072749FB;
	Tue, 29 Apr 2025 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745965197; cv=none; b=VTTeJ0q/caMNrxoAUgv3XG7r16AxC4tnrvVNK+xWW9RA2+328iPcgN2LQyx16+cZ0Kc8fCYTxmO1NkEOsQxehIZhCtgtN7+NICSCEd/fx84qrzzw3ORZriIWQfI7R8VvUzGcwmLSJHzQzyFC0PGa/GzlIetWvFprybc5kDd5t/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745965197; c=relaxed/simple;
	bh=daUAcPTEeuETxUAaU1lkbXlmV2kQIN/19KAiyeuvBVE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q6l0JGeV12MfZEb/XvHSNo/NumaRN1v7RCUFFlISBgLR305pkG61aPLrpxbZpl97HlOMjytqQcS2WqcS6zRe4UH6uHOvM6IZXpVN/5ET0YiegefrlZZX9KUE33D/ei5FGl0Rm6Le9mYthsIgF4bA1uXgweflkvT8H52qivf++w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhnWsvWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CBAC4CEEA;
	Tue, 29 Apr 2025 22:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745965197;
	bh=daUAcPTEeuETxUAaU1lkbXlmV2kQIN/19KAiyeuvBVE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uhnWsvWq7jZIzzwnVfoeupG9/JbocQZ3KKlzF43rxpF8cjqQVy3RzHiPCwXAJiWlF
	 blSCZYDc9evwCOkH2UQ+M8Kh/22alI73fTPBGtkMm5dE+cDPIYA7yv8Cquos0xpKZU
	 Zz2fFGwBKbpO+XN6KrT5ZA3uoHrn9rA2bjnrHfEb+SEIXGPYYnPrl4Idu0o1EXfzfL
	 D0rpnnSNeH+YCrp/cyBIuWJZ1OC9tdPW3HdJR7Z+4jCVz0l0MyeNLeAI9NaurFdsJg
	 EjroD+Ya49ujOJGdxJAaml/Dk56wu73gFeWMe17zguGiJtljNeD6RD5RonyoZj9Y/H
	 2kg6MWVUNU3OQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DC53822D4E;
	Tue, 29 Apr 2025 22:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ipv6: fix UDPv6 GSO segmentation with NAT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174596523600.1813341.14258160090818205931.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 22:20:36 +0000
References: <20250426153210.14044-1-nbd@nbd.name>
In-Reply-To: <20250426153210.14044-1-nbd@nbd.name>
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 steffen.klassert@secunet.com, willemb@google.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 26 Apr 2025 17:32:09 +0200 you wrote:
> If any address or port is changed, update it in all packets and recalculate
> checksum.
> 
> Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/ipv4/udp_offload.c | 61 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net] net: ipv6: fix UDPv6 GSO segmentation with NAT
    https://git.kernel.org/netdev/net/c/b936a9b8d4a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



