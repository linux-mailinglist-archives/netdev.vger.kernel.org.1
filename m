Return-Path: <netdev+bounces-247549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFE8CFB9B6
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 037BA309482F
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D20221F17;
	Wed,  7 Jan 2026 01:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOFx5r/G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479F721FF35;
	Wed,  7 Jan 2026 01:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767749613; cv=none; b=A7hQZiiMrG4bb18aUO/EyRZJGf9xFCXtbxNTwtmjXpODuz96t6xOTHhcCnQcfLLRy47eEAGVkQTCEZMlMtYIwcrFFFklTJKL5ZVuXN6EyAE9teN3cQYXrB7tqeUWqzyTp32c/JOE/shMCTnU5Nf3ptw+BE45406EmymFKJ9Lgl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767749613; c=relaxed/simple;
	bh=Bkg9f6/NbPeFe5mEbuyYvHYsYWTau5anjv6yiwS7F74=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=thS7hRA3N7mjLy2lvJFJQEFe0cf3VGzrUJ8k8c/ZHKf7C+3/HYAezhDGK+wgAk5u5xpNFwVLRsjzpRuH9AdN6s4l3GGXCOarusuel8m0WMKkGvGut0FW+zI12oFF/NHtvcyRMCjEE1ElHM3E9Q/dS36MWk8MIo8EelULhEbOmCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOFx5r/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8B5C116C6;
	Wed,  7 Jan 2026 01:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767749612;
	bh=Bkg9f6/NbPeFe5mEbuyYvHYsYWTau5anjv6yiwS7F74=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FOFx5r/GXnUORCSsX5NGUrELA6+EhkkTRG8APKsAGD9CgL8PneJjgLd6EFdvsQbXa
	 hzEv82rOC/7fWIher72ylKJukAxCn5a2TG+yF0T+hCwUGDROEP0aQ2jRs7EkrHN9sy
	 sxuzrTyFieiGh7wlCxqrF8VBCVR/C9t6GEyFmWyo1nmFePLQ+Of2gVKCqLGhmq1drb
	 hRbifv3kQCv4yXvborlCBvU4544xU1tt74EZflW8GdNHRbYZbMXR1fW55E9OH7Rf07
	 DfuVMoU400gL8A2Jqw82J9iPqYUDuW/9h7GC23U6dO7eS0P41uPTsLTDP1vJleR4hG
	 f0aVxdpMCuTVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78886380CEF5;
	Wed,  7 Jan 2026 01:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: gve: convert to use .get_rx_ring_count
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176774941027.2191782.13133818511895829631.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 01:30:10 +0000
References: <20260105-gxring_google-v2-1-e7cfe924d429@debian.org>
In-Reply-To: <20260105-gxring_google-v2-1-e7cfe924d429@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, nktgrg@google.com,
 willemb@google.com, kernel-team@meta.com, sbhatta@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 05 Jan 2026 07:28:26 -0800 you wrote:
> Convert the Google Virtual Ethernet (GVE) driver to use the new
> .get_rx_ring_count ethtool operation instead of handling
> ETHTOOL_GRXRINGS in .get_rxnfc. This simplifies the code by moving the
> ring count query to a dedicated callback.
> 
> The new callback provides the same functionality in a more direct way,
> following the ongoing ethtool API modernization.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: gve: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/48b27ea6239a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



