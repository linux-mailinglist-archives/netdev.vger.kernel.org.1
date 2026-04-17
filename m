Return-Path: <netdev+bounces-279212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKx7INCe4WkQvgAAu9opvQ
	(envelope-from <netdev+bounces-279212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:45:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AB24164DB
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB85231628AE
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 02:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436D62FD1B6;
	Fri, 17 Apr 2026 02:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nziXgXAE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5BD2F5A12;
	Fri, 17 Apr 2026 02:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776393651; cv=none; b=f8KwL9iMoLImYYMc7XbTSZXS9N2CS8MQWjv2/JOYsuU3xe0kkYw9W0pHBxJdej4OrdJ8bUGZG8M03AK25Z3UOes4sn4cavpFqsnxsCdF2yHFZ3mPUgPUUnFvAV/oncFTZSXN+iqgG7mEs3OcO7J3mxXaDLJVu+JjnqwfPn3fLsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776393651; c=relaxed/simple;
	bh=RE8pXUNFnXrfp8k86oykmMdq+NuDocEHXqwp95teTlA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AbJ0V7JK257jGqOmnuWUlc7dAf7PHNdPZCXSCKCTK3nqjiuiT4YOrL4yHSxcL+N+HJKTQbuPObrJAqUU3EQNj1LH52kpkhS1gjTLFPA907k8ZdT63ogfC4EAPHQqcj+82f8mVuFFuR73xt3jMm1mcRPTAHg0NVVSMZKmYOqBG48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nziXgXAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8597C2BCB3;
	Fri, 17 Apr 2026 02:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776393650;
	bh=RE8pXUNFnXrfp8k86oykmMdq+NuDocEHXqwp95teTlA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nziXgXAEDrvVDkLZpvE+XxCZTTZKH/M0cgCTyVUSO2ln2j+DlzcbyJsIwyuZpEsDG
	 vcgOQCkJO2fjQFNwe5nJ1v/9IAxyVfVAfW4M9mu2CiDbNdVUDR4T+dZwoE/H70UgNG
	 mYC7Zy6zrfRPTI0J+S65v+riyW9x20dQKieQc4KgHT2t1BUOjmfSG/ibHXyuciyc9+
	 peqUsTXW95O8TlCI783Pmcvmgh6OHrgpE6u/kkCz/vpfAA7c5fOpxX07BCI/8d5/TF
	 pLH1TcwabVr46cyJb2FzLu75ShiMqGTXUjgSdulYkca5q/GJwwuA1cWX6NvjxgoBUi
	 hvPtDEWqVDNAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CE6380AA76;
	Fri, 17 Apr 2026 02:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] net: enetc: fix command BD ring issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177639361854.3490984.12957233652551599024.git-patchwork-notify@kernel.org>
Date: Fri, 17 Apr 2026 02:40:18 +0000
References: <20260415060833.2303846-1-wei.fang@nxp.com>
In-Reply-To: <20260415060833.2303846-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, chleroy@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279212-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3AB24164DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Apr 2026 14:08:31 +0800 you wrote:
> Currently, the implementation of command BD ring has two issues, one is
> that the driver may obtain wrong consumer index of the ring, because the
> driver does not mask out the SBE bit of the CIR value, so a wrong index
> will be obtained when a SBE error ouccrs. The other one is that the DMA
> buffer may be used after free. If netc_xmit_ntmp_cmd() times out and
> returns an error, the pending command is not explicitly aborted, while
> ntmp_free_data_mem() unconditionally frees the DMA buffer. If the buffer
> has already been reallocated elsewhere, this may lead to silent memory
> corruption. Because the hardware eventually processes the pending command
> and perform a DMA write of the response to the physical address of the
> freed buffer. So this patch set is to fix these two issues.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] net: enetc: correct the command BD ring consumer index
    https://git.kernel.org/netdev/net/c/759a32900b6f
  - [v2,net,2/2] net: enetc: fix NTMP DMA use-after-free issue
    https://git.kernel.org/netdev/net/c/3cade698881e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



