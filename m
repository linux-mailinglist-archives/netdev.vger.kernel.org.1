Return-Path: <netdev+bounces-277610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKi5A26D2WmvqQgAu9opvQ
	(envelope-from <netdev+bounces-277610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 01:10:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F643DD673
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 01:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08912300E498
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F85B343D7F;
	Fri, 10 Apr 2026 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4yH7//R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C00F34E768
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 23:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775862632; cv=none; b=u6EXjK29Ripr89sJf3p1uojKkqXs9zedOW05GvJydHpNJIknptGWcj9MgafgA2EtElT6q+REG+RB37G9OZOQ1ii0hi3pHj8g99yROHWeUpSbnunLLT2ixDdi+3qY7Pcdwnr04dEBahoxh20VXHJxzbIyTlYB6I156sQpkxh3W7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775862632; c=relaxed/simple;
	bh=d03e/dwvqQqza4+LkOtN4S9qpgWPwtbFnEF2jM8WwD4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jCnRGWLmZ7sCIjzey9syXcvpuw/MDHSkGDB9lzQNOXKdE/awRRRPohIAeZxgdPgJU/5RXa1f/ZxM9Y325ptoZ9YbjGyKk21slOYPhAgEZdnJZu9BNsu4XXBmjvTFbzPqE0VWkMgch58Pda8z4GsHSyogPVIZBxtrEGxR7tS6VYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4yH7//R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75376C19421;
	Fri, 10 Apr 2026 23:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775862631;
	bh=d03e/dwvqQqza4+LkOtN4S9qpgWPwtbFnEF2jM8WwD4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c4yH7//Ryte+HInfzodnE8TM+M7waoNYQV18sNZWou6kgUEXpzvAiRrcW8Q44bXWQ
	 8UNd1k4doTFMrbPUAq4VSFR4aMfEK8lWumOrzM+p3JKDyzNbcKUzY0ujgFhLaeOPuI
	 W3sYzccII5DOjY5jIHDOQHE1zTN6YMlIqpxN6JWdEDgY4G3aqsnBvbimojwcrcB+fN
	 YV7WmkxQkHzrE4Q4H5nKnzj54kjjG1Lz1CtW5IT8zK1sFJUNHJhoTK/kuKqFq6uNh5
	 wJ+LsMnsnc0xLtZS5Uh6+vZXjtd7jBxLjB/PVDVW8Bkg4mxwujDPc8+CqdbayGGaZx
	 i93RBW3EknWCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CF53809A88;
	Fri, 10 Apr 2026 23:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Fix FE_PSE_BUF_SET configuration if PPE2
 is available
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177586260580.2678602.13239417012036836659.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 23:10:05 +0000
References: <20260408-airoha-reg_fe_pse_buf_set-v1-1-0c4fa8f4d1d9@kernel.org>
In-Reply-To: <20260408-airoha-reg_fe_pse_buf_set-v1-1-0c4fa8f4d1d9@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, xuegang.lu@airoha.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277610-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,airoha.com:email]
X-Rspamd-Queue-Id: 05F643DD673
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 08 Apr 2026 12:20:09 +0200 you wrote:
> airoha_fe_set routine is used to set specified bits to 1 in the selected
> register. In the FE_PSE_BUF_SET case this can due to a overestimation of
> the required buffers for I/O queues since we can miss to set some bits
> of PSE_ALLRSV_MASK subfield to 0. Fix the issue relying on airoha_fe_rmw
> routine instead.
> 
> Fixes: 8e38e08f2c560 ("net: airoha: fix PSE memory configuration in airoha_fe_pse_ports_init()")
> Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Fix FE_PSE_BUF_SET configuration if PPE2 is available
    https://git.kernel.org/netdev/net/c/02f729643959

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



