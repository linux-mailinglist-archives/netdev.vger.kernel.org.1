Return-Path: <netdev+bounces-288146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO5WN8F5BmqFkAIAu9opvQ
	(envelope-from <netdev+bounces-288146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:41:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF57D548794
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B1B63004C8B
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FF436308F;
	Fri, 15 May 2026 01:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iX25rDEx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3BC329C71;
	Fri, 15 May 2026 01:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809263; cv=none; b=CcuY7OILHMrtRAstGR9PXJ0ui2qponUpUSR5We41pFZQxFDumFhJInIlUAtvpCKc/074eEWq7lGbdrLzWkXIvMF+HZFDzHBrjHeN4wQdrB/C1iRJke2pNqlzK8M0EY7/HVxZg7hF4mToZ1RGAofqTu0cYGR+09s+/KvoMM9vRPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809263; c=relaxed/simple;
	bh=oF9m7euIaNJILGC206y36PG5TlezdDXjD2Gnt2tH1GM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RvKMjrEPUO8HAbfibM2Xy3s3dag+1IQqt2fwsXUx1KJsJbqajJ7lbqgdNAinrtZX9bBJGc5OfZ2zuqbB5J/Ud8xYv0GW392Tc3KmMMSkAU05cGPDDVdOX4Ho8O8+/0Hp7/6Wb8FXh84nODfDxDJhQp3bY9g3u42eJv7Z/KZzeBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iX25rDEx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451CBC2BCB3;
	Fri, 15 May 2026 01:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778809263;
	bh=oF9m7euIaNJILGC206y36PG5TlezdDXjD2Gnt2tH1GM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iX25rDExsQYoHa23+bOkIrVGtNYF5MuPzIz0rjUFWNnl6K286d6u86cXMoGhmQmAY
	 FzugZZOup22EictgcQ0NEhCs/GJbk2On5NEau5J3Bok0zCo3hUOViv+cJH6atFBg6F
	 qp+VDFYaJVvX3Lz3qcW66acWoZqaZcsvMJSQM8UHkJHoPy4WhyDfLEsTT7vIuwJWLp
	 bRjTMMMOMPqKvyHyMlWf1+kshwoUmuOJsXMes2uApsJ/RIAn2qFpzbblZ+Xo5MY4qA
	 nVwo041uttb7gWCe0ZKcw9w0XelVmMVid5IJalqg/dSscFP3jtT5ZPvojdv/bh8D5t
	 kde1VMOeG9DNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C4539E4DB8;
	Fri, 15 May 2026 01:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/mlx5e: Don't leak RSS context in case of error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177880920780.156468.13963375231913940790.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 01:40:07 +0000
References: <20260513062737.333259-1-tariqt@nvidia.com>
In-Reply-To: <20260513062737.333259-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, ayal@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 dtatulea@nvidia.com, noren@nvidia.com, ychemla@nvidia.com
X-Rspamd-Queue-Id: DF57D548794
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288146-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 May 2026 09:27:37 +0300 you wrote:
> From: Gal Pressman <gal@nvidia.com>
> 
> If mlx5e_rx_res_rss_set_rxfh() fails during mlx5e_create_rxfh_context(),
> the RSS context is not cleaned up.
> This leaves a stale entry in 'res->rss[rss_idx]' that occupies a context
> slot.
> 
> [...]

Here is the summary with links:
  - [net] net/mlx5e: Don't leak RSS context in case of error
    https://git.kernel.org/netdev/net/c/c9d08c8c4c50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



