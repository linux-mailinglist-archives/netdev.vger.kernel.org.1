Return-Path: <netdev+bounces-266897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFomI/g3smnlJgAAu9opvQ
	(envelope-from <netdev+bounces-266897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 04:50:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D8626CE07
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 04:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91E3D3011154
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665EF37B011;
	Thu, 12 Mar 2026 03:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuzOaZ40"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432143563DD
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 03:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773287414; cv=none; b=oo2yzNj3oS1vmy03a2VM+2sGuDN68KhlLVtnITDaOpU4vjGbTQnswFAmC16LATANiQs8c0ZR13AKfRmpGBuEEC3U68QBKdtcsecYJK4jp3QQOC4OisGQwumfLS678ILWKTA0r5EPtjj2UemP8l3GJg9v2y0X9FFD+gjLioZnCJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773287414; c=relaxed/simple;
	bh=BTpNLKi5b7JdKVh46HJKLw2410huIoWbLEhZwa64oJE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q4SJjlmX+QOdh9l5COhLi/DOGKUN8rGyFBqztSpnl5/NRkcEY/UtbmfFWjh5PaEhJBo1JiKyHkrdy7rzRTpv5thgHNx4UlP7Ov2Vh35oS7zaEkBZm0MaXA+QciF4My7cwkbahw5nbfyQSZkppeC/pImbba7XISIC9+H9rAuy4rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuzOaZ40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9234C4CEF7;
	Thu, 12 Mar 2026 03:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773287413;
	bh=BTpNLKi5b7JdKVh46HJKLw2410huIoWbLEhZwa64oJE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nuzOaZ40ee5/yhHVL7o+WNje46I9y+pAlM1fB5eIRj6CTJuRitAIa0PRifQtEkb44
	 4IbKn1b4FY56AYJTgAZu/9iB9BPh+wq9MgAq+h+r7MxNYTVcJV1ULodHNBPkZ/tDjd
	 Bec4XPJKRERH4MUigir3mzptqynnfBVBfZu0ZHuofTBr0UVcVPqPcDSiO3tK0lc1/Y
	 FGMjQVcYVufmT1e41Sf+28FdUrDTbfiaLhTRJJtND77sBHX9AohzY1KCtxy444ir3t
	 M6QazS4FS8DAKamFpg0WK7yu/FxBVcQaEO36bLaZzhIGKxNXOfdkozachkftTwwulL
	 EEXPGVVRGtnSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EC03808200;
	Thu, 12 Mar 2026 03:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] octeontx2-af: devlink: fix NIX RAS reporter recovery
 condition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177328740955.3930157.15850300877882489500.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 03:50:09 +0000
References: <20260310184824.1183651-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260310184824.1183651-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: sbhatta@marvell.com, hkelam@marvell.com, gakula@marvell.com,
 lcherian@marvell.com, sgoutham@marvell.com, andrew+netdev@lunn.ch,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, alok.a.tiwarilinux@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266897-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31D8626CE07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Mar 2026 11:48:16 -0700 you wrote:
> The NIX RAS health reporter recovery routine checks nix_af_rvu_int to
> decide whether to re-enable NIX_AF_RAS interrupts. This is the RVU
> interrupt status field and is unrelated to RAS events, so the recovery
> flow may incorrectly skip re-enabling NIX_AF_RAS interrupts.
> 
> Check nix_af_rvu_ras instead before writing NIX_AF_RAS_ENA_W1S.
> 
> [...]

Here is the summary with links:
  - [1/2] octeontx2-af: devlink: fix NIX RAS reporter recovery condition
    https://git.kernel.org/netdev/net/c/dc26ca99b835
  - [2/2] octeontx2-af: devlink: fix NIX RAS reporter to use RAS interrupt status
    https://git.kernel.org/netdev/net/c/87f7dff3ec75

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



