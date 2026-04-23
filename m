Return-Path: <netdev+bounces-280631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGK0C1HI6WnAkAIAu9opvQ
	(envelope-from <netdev+bounces-280631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:20:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEF544DE90
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29D843008278
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3018022F767;
	Thu, 23 Apr 2026 07:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwL4Ig2g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBEA1F5821
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 07:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776928847; cv=none; b=lzaC0rBdN1VC6CqSWLg/rYh+d62YoGyd7GCXLnLLYpdgw654MpcdcXK7uFUIGnD3FTCspGP0PHONQxlmTwzOt3nVTOUf/PkzkntG9k0ktqP923raPESXLti5Yu6MhWmSHeUP/V0ojZ42cbw2xyK2c4lupplwTzmghNUS8bTcFs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776928847; c=relaxed/simple;
	bh=SmX0sRFqnNZjqfPDFK0N1hGVs5C10+dJXyOfzNRMxfc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jV9wecztV8sgzqZVPo5RZrwvHowQlQI+y1GAfuJMGewSLX/6+N4p35bt14YLg8Sym6KoAJIBkP2/v/InCkuAJ9WH7lSLoQWZy8ozdckxMgwKTWlGN3ftO1ygyNiKl3DgTHBM0ydtK8YdikiyT8SQ6eOekwAPeNIlYHt8hebpDtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwL4Ig2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93B5C2BCAF;
	Thu, 23 Apr 2026 07:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776928846;
	bh=SmX0sRFqnNZjqfPDFK0N1hGVs5C10+dJXyOfzNRMxfc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UwL4Ig2gxvdLNTuHsGl5Lj61OCLBOKz4TZeYg2kFtbuw5HADzBVF0QHXcGm6TPv9i
	 UoXiWy6ve4yhch7xEQcOynojCN14pDhh8vRUPgUJjLBG16MKtqWSz2DgnkbcMcTcZt
	 /kqIOeCC9shdsr6BAM0YW0VPTHDhfutEY9adoBYNaPedWPdq81G8btclQvLlnK1G5l
	 u5t/28VO0PZCvdGZAJcuNhhysicjQbVHj74sYZ51lvlvQF3gFJ97qXSIZUTkT1PutU
	 9MBN9nWH06M1eiI2WjMbwDYN5JMZ87QnBLr6Zf7UwFTFwryUXzNrT0OlSEFJ/LCE3o
	 MwvWptj7BW/bA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E07CA380CFDB;
	Thu, 23 Apr 2026 07:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/2] net: airoha: Fix
 airoha_qdma_cleanup_tx_queue()
 processing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177692880880.14264.2972373340507100909.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 07:20:08 +0000
References: 
 <20260417-airoha_qdma_cleanup_tx_queue-fix-net-v4-0-e04bcc2c9642@kernel.org>
In-Reply-To: 
 <20260417-airoha_qdma_cleanup_tx_queue-fix-net-v4-0-e04bcc2c9642@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280631-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BCEF544DE90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 17 Apr 2026 08:36:30 +0200 you wrote:
> Add missing bits in airoha_qdma_cleanup_tx_queue routine.
> Fix airoha_qdma_cleanup_tx_queue processing errors intorduced in commit
> '3f47e67dff1f7 ("net: airoha: Add the capability to consume out-of-order
> DMA tx descriptors")'.
> 
> ---
> Changes in v4:
> - Drop patch 2/3 to move entries to queue head in case of DMA mapping
>   failure in airoha_dev_xmit().
> - Link to v3: https://lore.kernel.org/r/20260416-airoha_qdma_cleanup_tx_queue-fix-net-v3-0-2b69f5788580@kernel.org
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] net: airoha: Move ndesc initialization at end of airoha_qdma_init_tx()
    https://git.kernel.org/netdev/net/c/f329924bb494
  - [net,v4,2/2] net: airoha: Add missing bits in airoha_qdma_cleanup_tx_queue()
    https://git.kernel.org/netdev/net/c/3309965fe44c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



