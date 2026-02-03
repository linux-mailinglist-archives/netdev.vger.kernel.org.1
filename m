Return-Path: <netdev+bounces-256093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMITE+NdgWmdFwMAu9opvQ
	(envelope-from <netdev+bounces-256093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:30:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE97AD3C92
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49FCB301325B
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 02:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEED2FF150;
	Tue,  3 Feb 2026 02:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPuIsDW1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAA92FBDFD
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 02:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770085813; cv=none; b=W+sB+g4T3M0UaF1jX2OdBv1r07Di51AXCSnPlNsp3Bo0ZQqBi0URIDJzu/aM9RaDEnOvMioUiOq4aE/xk7d/DGNbd0je+HydzrE91nGAk8f4oodaL5dq5mfaKZpCZ6E02/aPmRn6VHbZRtX3VtndsoiBkS3QYx5W8AWqkeViH5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770085813; c=relaxed/simple;
	bh=cYG17tl28+c2incbI2MMiFCBSxoya/EYTCbJ9IG+jWw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kB+1KJmL6ki4wgNWTxsBD4vieqHkACUc+qyj7xS96hfRlbwz/wPmiFYGe1Kh4CZH2VwL3GmDP2ruKSDczGcotOo/tqPadeticWwyMPPi34QRvOgaVvA5CpIAwapRdOAfXNCVbQfgyD3EBOLn24HQlcy/OHwk8xWlK03NudDObAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPuIsDW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5ADC116C6;
	Tue,  3 Feb 2026 02:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770085813;
	bh=cYG17tl28+c2incbI2MMiFCBSxoya/EYTCbJ9IG+jWw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HPuIsDW1yLDV7x2QeOPED3LwDsFKFaA9SXHbHNilwW9hwEiMVqjRkIha70/ZN/YWb
	 fMMHBdTDvQk6K7IrJgELlGES7QWgBhDb/8GnZwMW6CJmSYUjEktVqA75OESDL/nsmm
	 tbFtE60AQc6UaoI3IVSBvdN89ONGtcbicHQb1QFOi0O2rdAkqMnUBE6IfNiOJAJs2X
	 hiXsScSvvThTu3uIbRwTaWwTSI1cSX4dZa6YeJQbypSxhpaPK/fbOwJokECjSK/3GQ
	 lXAIHvdXvQe08B7ECE6CbX8XgpJUkrQicyle3koo9AaQBk8oRm6nVaYbns+w97inso
	 TK813/Vm6MjJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 90F573808200;
	Tue,  3 Feb 2026 02:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5][pull request] Intel Wired LAN Driver Updates
 2026-01-30 (ice, i40e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177008581037.1282989.17724890649337308112.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 02:30:10 +0000
References: <20260130185401.1091523-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260130185401.1091523-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256093-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: AE97AD3C92
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri, 30 Jan 2026 10:53:53 -0800 you wrote:
> This series contains updates to ice and i40e drivers.
> 
> Grzegorz and Jake resolve issues around timing for E825 that can cause Tx
> timestamps to be missed/interrupts not generated on ice.
> 
> Aaron Ma defers restart of PTP work until after after VSIs are rebuilt
> to prevent NULL pointer dereference for ice.
> 
> [...]

Here is the summary with links:
  - [net,1/5] ice: fix missing TX timestamps interrupts on E825 devices
    https://git.kernel.org/netdev/net/c/99854c167cfc
  - [net,2/5] ice: PTP: fix missing timestamps on E825 hardware
    https://git.kernel.org/netdev/net/c/88b68f35eb43
  - [net,3/5] ice: Fix PTP NULL pointer dereference during VSI rebuild
    https://git.kernel.org/netdev/net/c/fc6f36eaaedc
  - [net,4/5] ice: drop udp_tunnel_get_rx_info() call from ndo_open()
    https://git.kernel.org/netdev/net/c/234e615bfece
  - [net,5/5] i40e: drop udp_tunnel_get_rx_info() call from i40e_open()
    https://git.kernel.org/netdev/net/c/40857194956d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



