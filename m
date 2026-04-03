Return-Path: <netdev+bounces-274821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJYYLUAUz2nXsgYAu9opvQ
	(envelope-from <netdev+bounces-274821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:13:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F0B38FE27
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BEAA8304FE25
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 01:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E651F282F39;
	Fri,  3 Apr 2026 01:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkzsc+oW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2656282F1C;
	Fri,  3 Apr 2026 01:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775178652; cv=none; b=rxWYl6Uehol4ixx+qZOBMUddAaZ9ZC9Xz6dpA0zZSyuKH0UNazNZcML97SY6rAo5ifsjchmDKqsDxnMfgbrzykFANfNZ6+x+1dIyDpn5IhvNyHQoWVPcTBbetsVtTM0q73v4wiC2aJwCn0G0ndaIv20DnZ3lKeqoe5qshOqufHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775178652; c=relaxed/simple;
	bh=SN0j/suU8TQtoUkdeuEkG7fN6maLuHbyR5EPwKQtf8s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rNX+ndKnrTzO+DYsDeBcxIKMVps3cYfLxY6h/z1Vq/QjP4PJGUy2H04+Q/bUi+e1Cynz2p4E6HTwZjZq43haZEuXKwSCoMsrAOtsNXRzimMFxVjKgTiSqNB0o4DrF8ZHzYu+w0LuLCxnCSwp3VNEo2P/aI8NQ82lqrlAbD58jFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkzsc+oW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6952C116C6;
	Fri,  3 Apr 2026 01:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775178652;
	bh=SN0j/suU8TQtoUkdeuEkG7fN6maLuHbyR5EPwKQtf8s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pkzsc+oWYsSqI+0Ql3S6q3VyPnxK6uEqfrWWb2j3E/ibwq189G89pyWGtLlVuKEDo
	 qpJQFhxp4NvJJs7HiHAx3XhN+CsGUnqX7aiBoG3x3Bf/s+qBPN12z1h3kcGimk0isn
	 vVvX/wT9HZ59Cvxd416vY+ex/H6HFgMKLIB7aaFVJQWcR83y5uqpc2PJSEx5BDRPn+
	 /CzYI3gJ7ogLSKOhfQZNit9GdDSlmmscc2aWHOVHZj4qoOFOkCxvtVGlJ/znl6shUv
	 bgU7RIqBCB/oGASmP//+CJmViX3R1tn4wN5fZRCyaDBBMWy2+QphJ7/G5Jy4B87TpC
	 E4snAOKNQF2tQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E723809A09;
	Fri,  3 Apr 2026 01:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8152: Add helper functions for SRAM2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177517863489.685228.13309073142770503126.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 01:10:34 +0000
References: <20260401115542.34601-1-nic_swsd@realtek.com>
In-Reply-To: <20260401115542.34601-1-nic_swsd@realtek.com>
To: Chih Kai Hsu <hsu.chih.kai@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 nic_swsd@realtek.com, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, edumazet@google.com, bjorn@mork.no,
 pabeni@redhat.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-274821-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B5F0B38FE27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 1 Apr 2026 19:55:41 +0800 you wrote:
> Add the following helper functions for SRAM2 access to simplify the code
> and improve readability:
> 
> - sram2_write() - write data to SRAM2 address
> - sram2_read() - read data from SRAM2 address
> - sram2_write_w0w1() - read-modify-write operation
> 
> [...]

Here is the summary with links:
  - [net-next] r8152: Add helper functions for SRAM2
    https://git.kernel.org/netdev/net-next/c/86f5dd4e0ff2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



