Return-Path: <netdev+bounces-266023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA3/N9D/r2mmdwIAu9opvQ
	(envelope-from <netdev+bounces-266023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:26:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB3824AAEA
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0B30300E24F
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93DC381AF8;
	Tue, 10 Mar 2026 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uC47DIaT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B4D37F007;
	Tue, 10 Mar 2026 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141612; cv=none; b=petlU7Q6iBCV+dZuHWvlegpXLfC1Za5pfD/lOTajKpNsrITyZj7pLpktqAb32sYNZGdUrlet8YNLBU4S/2joyMcwQQYtTkWf0jCoGWNttCjMw7F/j3OrdYWEtmpG3QroKluMpBqI4fD+b2C3hqeZLhPc3Oz7g0xGq8JBWtexSds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141612; c=relaxed/simple;
	bh=j2K+/MlPJ4v8a/IomATkpkFBHRwJov93d/c1nb/fdfA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=blKVaNtgNcUsZaHYVqWBNZqtOpAuS2WaRJMBLJ3jTKMlfeKXDHG+oLmyTZA6VPo8LImn5yGE7seh6KNXO8vXR//C7dVTssUEuFyxe8F9vMfJCLSnwMNmuba+o1q12zbLyn0e/iXCpcWYeZJ4xfYzODBKXCTvQUMMAc3teuy5b3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uC47DIaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E46C19423;
	Tue, 10 Mar 2026 11:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141612;
	bh=j2K+/MlPJ4v8a/IomATkpkFBHRwJov93d/c1nb/fdfA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uC47DIaTUzwhPjtIGQ0SaZ59lpLhDM4OE4MljYmqap3x4YIxoLZlddqjZb3xokZf5
	 yIxgEjFERSBKMpgQsgqupGSguAOaq8OlPfpcEzRHUWV/oFwGddgFN4Bl7iTCjLHIJy
	 oruVjfLnVh3WZCT1uf+SgiWqi2neNyQPqCq2rQhQOj05acMSJfMWwgJGnMiC3y1kUx
	 JOkwGTjV25V3v8Z2Nq8g3OGorjwSjRYtDGNS3FkLM+Wr0Fa+7EN7W7IKuqaAcorRRU
	 KQDCL2UMqlV4k66s3J9Bf7ljST/wnedIihJY5Xij1TlXhdnBt3zfmzmDYZTzyHF/r5
	 DHY2X9KSrrLvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F183808200;
	Tue, 10 Mar 2026 11:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net 0/3] amd-xgbe: RX adaptation and PHY handling fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177314160955.2198076.10740915136308263708.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 11:20:09 +0000
References: <20260306111629.1515676-1-Raju.Rangoju@amd.com>
In-Reply-To: <20260306111629.1515676-1-Raju.Rangoju@amd.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, horms@kernel.org, Shyam-sundar.S-k@amd.com
X-Rspamd-Queue-Id: 4DB3824AAEA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-266023-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 6 Mar 2026 16:46:26 +0530 you wrote:
> This series fixes several issues in the amd-xgbe driver related to RX
> adaptation and PHY handling in 10GBASE-KR mode, particularly when
> auto-negotiation is disabled.
> 
> Patch 1 fixes link status handling during RX adaptation by correctly
> reading the latched link status bit so transient link drops are
> detected without losing the current state.
> 
> [...]

Here is the summary with links:
  - [v3,net,1/3] amd-xgbe: fix link status handling in xgbe_rx_adaptation
    https://git.kernel.org/netdev/net/c/6485cb96be5c
  - [v3,net,2/3] amd-xgbe: prevent CRC errors during RX adaptation with AN disabled
    https://git.kernel.org/netdev/net/c/27a4dd0c702b
  - [v3,net,3/3] amd-xgbe: reset PHY settings before starting PHY
    https://git.kernel.org/netdev/net/c/a8ba129af468

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



