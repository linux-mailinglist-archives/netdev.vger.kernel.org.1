Return-Path: <netdev+bounces-290987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCgQJeb3EGoxgAYAu9opvQ
	(envelope-from <netdev+bounces-290987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:42:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C315BC217
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDAB13028351
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F09322A817;
	Sat, 23 May 2026 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2Bw9Lnq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4FD21D596;
	Sat, 23 May 2026 00:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779496828; cv=none; b=GumbWb+tjsN7Gv3D2LPSRDZL2GGRg9xsHxLzHsDSxmWzYMnbTMuuIBcwAX71vkiICV31qibw5hDnV4HY7e62HYMYeJ0KBaYa82PadFEgfE3qWVg6CjmOte5KsUZVOx5KPTX+B2q3/X/QL/NoyEpIJmj0LXieUbVpVYFhOZy+ZD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779496828; c=relaxed/simple;
	bh=7OuTaTL5G7YFpgp2QVziA1bnJZftylaS5WL3+QhVD0I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ERKaE+fJwyEZEDPoLTjNT2GRtfosVJD9XCOoU98s94mkV2SbVOt00UG4VCzcvqzcVV1zTogNyDcaB0Sk/L7n/4/LoBCkEFQ6ZsdSKDs8aHsUaklc+bTz8Ey5XUiKnuQiP0b1D7V7OgHyitSGG9il69u3emVTflrE321hGpjy2sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2Bw9Lnq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AB41F00A3D;
	Sat, 23 May 2026 00:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779496826;
	bh=D6QnQXTvJExnlymJ4cP5MMMFglbK7wD3z3FYtMP6sJ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=L2Bw9LnqHGlTteARH4uklnFG4+DupmCxk/UwKcqcQ+TF7NqR/9IhZfr89zjx9Itp0
	 CITwIuCJGKOiURI1ojPbUWNV2cR/zKLWyX50RqCvZ92BDNr3EBk67JYGb1zyEmp8as
	 +LAgXOC9leAXpXv5HYvNNY7XxKnYJpSnI2DCmv2FV8gkoFAsrtX57Ii3g31Js0dlDn
	 1QdI5WbHI4ZBXn8w9f69dMw1Ati3izVhO9YhP7mAQPIUvFW4MkLB16iA5/kBr4T0YB
	 MBrmPFmgXxlg4oULvMxvaNbv9FAAfOVPEt3Iufpt1IdbmB8011pFb7bCEoWG9fT7oo
	 ynZEE2HboMqkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19748393100F;
	Sat, 23 May 2026 00:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: stmmac: mmc: Remove duplicate mmc_rx crc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177949683463.1426243.3180007956000869179.git-patchwork-notify@kernel.org>
Date: Sat, 23 May 2026 00:40:34 +0000
References: <20260521-xgmac-mmc_rx_crc-cleanup-v2-1-7d9de09f5898@gmail.com>
In-Reply-To: <20260521-xgmac-mmc_rx_crc-cleanup-v2-1-7d9de09f5898@gmail.com>
To: Abid Ali <dev.taqnialabs@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290987-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 15C315BC217
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 May 2026 16:32:46 +0000 you wrote:
> From: Abid Ali <dev.taqnialabs@gmail.com>
> 
> MMC_XGMAC_RX_CRC_ERR is clear-on-read, and just a single read would
> update the mmc_rx_crc_error counter.
> 
> [1] commit b6cdf09 ("net: stmmac: xgmac: Implement MMC counters").
> The duplicate read appears to have been unintentionally introduced in
> the intial MMC counter implementation. The databook does not mention
> MMC_XGMAC_RX_CRC_ERR needing the additional read.
> 
> [...]

Here is the summary with links:
  - [v2] net: stmmac: mmc: Remove duplicate mmc_rx crc
    https://git.kernel.org/netdev/net-next/c/fd1cdeddd7bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



