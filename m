Return-Path: <netdev+bounces-250416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B47DD2AAFA
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4864300ACA6
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD81277CAF;
	Fri, 16 Jan 2026 03:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7w8wVbI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A6B18FC86
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 03:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768533814; cv=none; b=ZWtDM8qKm48hvNa2SOJ1eKlHczhQOWm2LZEtlOs1zgPm4p/VfJ7oR3MrHMm3zjwbabPWnF2XBxx7k6faQtWBuRzJV0ymQnHsCGrbARkyX4ljD/RfaVp52zN/QE/RdVMlhHsGDmCo5KEK0x8LFPr1VCGBxAiECwkIrMiwBZ0jV7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768533814; c=relaxed/simple;
	bh=gmKzqGsl/RvfPJJa9FU1SSee3IHUM3S0HkIe9WG+2AY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NtUMDyTJSSRPeOyJ7lPskFwiZ+8H0jpwPhxYhR9SVEIr2lRhvOwv0Fgs5/ruGGUdNDybLtjDl0iyeuMxcEuvMXKmFZnSsPjbup7TR42PZ3YehnVv3e85FjXuQh3jmTvZ4gOiQumtiwsQtHj8U2bdJJeyumhZ/zlhqq65vNl0NV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7w8wVbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59873C116D0;
	Fri, 16 Jan 2026 03:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768533814;
	bh=gmKzqGsl/RvfPJJa9FU1SSee3IHUM3S0HkIe9WG+2AY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q7w8wVbIR+a3qaXI4/RRqrK2RE16g0/Lslj6P4xzkCITxJoGHP4L4w+CgjILDjJac
	 Uor/R79PPCmlZ2n9FKojb+kco3HoFJ5N0poh9s8ue2lYA8M8eJXhMIP0Cs6SQRp2q4
	 R0M+33L/p2gbaq1+mV3XJOxDM616FI5zyoR5egisWak9zYggmWuxei/VuOmf1LThgo
	 389yTNWGV0SPVSZWKKG71dJKQMH7En5qzpQ2HRY+43bPNADcP0D8rXx8q6fjl4+MNo
	 DlfP7OVd7BNw+/qxNHwJJoflstlRGHYJoqLIKYZlSivcE7coRFKNGB8QO/5N/FZm6Z
	 Z1qivEArrYuJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78E67380AA4B;
	Fri, 16 Jan 2026 03:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] ethtool: Clarify len/n_stats fields in/out
 semantics
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176853360625.65964.1832810243834555951.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 03:20:06 +0000
References: <20260115060544.481550-1-gal@nvidia.com>
In-Reply-To: <20260115060544.481550-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 andrew@lunn.ch, horms@kernel.org, dtatulea@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Jan 2026 08:05:44 +0200 you wrote:
> Document that the 'len' field in ethtool_gstrings and 'n_stats' field in
> ethtool_stats optionally serve dual purposes: on entry they specify the
> number of items requested, and on return they indicate the number
> actually returned (which is not necessarily the same).
> 
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] ethtool: Clarify len/n_stats fields in/out semantics
    https://git.kernel.org/netdev/net-next/c/567873005dca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



