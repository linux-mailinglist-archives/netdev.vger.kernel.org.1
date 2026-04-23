Return-Path: <netdev+bounces-280719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOA+FLT66WnkpwIAu9opvQ
	(envelope-from <netdev+bounces-280719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:55:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAD3450F80
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE7CB308BF3B
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC083E51DB;
	Thu, 23 Apr 2026 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dH6bjqKI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8774C3E51CC
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941449; cv=none; b=akHCFj4m/Wu1S3QhnJut3sMSGpLqkMhNCsGUl2Ji/dB5EW9yiLNSm49GDW+pCsqdnCdK5m/RTb/7hcCLtDwxwdPrZOp8pxbN60nJSsrBZz3HwWl52+2YEjtdwJxk6/nM9pMqjq3sWBPGuFhrIYSp1vxO09a7sbY9FJLowb25t+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941449; c=relaxed/simple;
	bh=OoQqwn2Iom7hNKT4z8ZQdCpip2kOL8Jkaka02RiKb3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=adBHw8YfscQIStJyErK0wDM6ApWt0zJN8RF6NfWnbrS7YSi399Zg0UWgIz7g7mxmX3Om4T1P1yNuOLEom7Cg1xOWVI7jpzKbhHd+3BlYigmYbRAnIetxKSQWS3s54FUtbMPE7BWXN+SLUWwb6ZQJDA2nNYc/q/HhDBOmVELiOiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dH6bjqKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E6DC2BCB2;
	Thu, 23 Apr 2026 10:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776941449;
	bh=OoQqwn2Iom7hNKT4z8ZQdCpip2kOL8Jkaka02RiKb3c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dH6bjqKIYbxUSinZQaMk4rNByUSI11UsgfVAvZxk/SOQM9DNSYbCxJuvR+3fOTQ4i
	 zBHLinJ2iRmExO9ERrcWOxzoQk1aFXcitbdSfUHQbaoUVcv37rOdwekTq+NzeWQX9b
	 ZOVhezlNPkwitrF1NnyvskTVkPdMgXSTB114B0ET3ZmzDfbE3XhSNyTKIcOys1ytWu
	 4Qsx8ZpPphF5x+TmkR+GTsiSWxNcPz1+tiFI3C13bWqJDRi7ShoHBIpj18SfydrTnI
	 Hp6joLSONp77J1YZSDM8jgE5UF6gGwnmo3IMtMjQFehthzEjoip0LoH93noN1b7/Dd
	 ZfTPeT4aOJgeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD93380CFFD;
	Thu, 23 Apr 2026 10:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net: airoha: Fix NULL pointer derefrences in
 airoha_qdma_cleanup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177694141104.106550.318427383838791397.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 10:50:11 +0000
References: 
 <20260420-airoha_qdma_init_rx_queue-fix-v2-0-d99347e5c18d@kernel.org>
In-Reply-To: 
 <20260420-airoha_qdma_init_rx_queue-fix-v2-0-d99347e5c18d@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280719-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CAD3450F80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 20 Apr 2026 10:07:46 +0200 you wrote:
> Fix two possible NULL pointer derefrences in airoha_qdma_cleanup routine
> if airoha_qdma_init() fails.
> 
> ---
> Changes in v2:
> - Move page_pool allocation after desc list allocation in
>   airoha_qdma_init_rx_queue()
> - Move netif_napi_add_tx() after irq desc queue allocation in
>   airoha_qdma_tx_irq_init()
> - Link to v1: https://lore.kernel.org/r/20260417-airoha_qdma_init_rx_queue-fix-v1-0-db9fa5e468e5@kernel.org
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: airoha: Move ndesc initialization at end of airoha_qdma_init_rx_queue()
    https://git.kernel.org/netdev/net/c/379050947a18
  - [net,v2,2/2] net: airoha: Add size check for TX NAPIs in airoha_qdma_cleanup()
    https://git.kernel.org/netdev/net/c/4b91cb65789b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



