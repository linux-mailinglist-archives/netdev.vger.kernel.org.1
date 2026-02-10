Return-Path: <netdev+bounces-258053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Pf0FjIFi2kdPQAAu9opvQ
	(envelope-from <netdev+bounces-258053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 11:15:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FD711986F
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 11:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5254130C252E
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 10:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F5034B183;
	Tue, 10 Feb 2026 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A72yDi4o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BB734A786;
	Tue, 10 Feb 2026 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770718229; cv=none; b=gW4ZXj33Iq0gHJ0rGuKDr0ChsAg+SxRxrYN0Q21WJntyh7NTqG0KFJNt/Q3AYEPwtGTPcpY+Vmbq88vgG15WMw5SK2l8aVCZA4duW8YphmOeBF+kBaiCMHJYS26iMWvClHAxhmC73g3gs+YsJrlR3qqKH9nE+4nMWkg9h8tinLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770718229; c=relaxed/simple;
	bh=FMBaXuFQeBrt8fJEzPTuhWQ23fYLV56pEAMm2NMWTtQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UQJSmwmQG3sOB/swwAszxsuZiZfkTtsKHz8Z/DTv8DEYAC64y3QDODd7VZw+3qq2vmkS927H0dUWC7mVbiLqKW9CqX/A8jYxaIWAQhUDf5UNAJZ/eGx26kxqtul5RJqSeNklrnSZDePWZpUS5Kw8FGOLRUObJi/rePZLo5X1UE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A72yDi4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538BCC116C6;
	Tue, 10 Feb 2026 10:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770718229;
	bh=FMBaXuFQeBrt8fJEzPTuhWQ23fYLV56pEAMm2NMWTtQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A72yDi4oURF59QiUNMNV3Z8GAHqR3gkQXkmFNvKfqrddYbwrPNFWpRLnnvaEvZ5Lt
	 C2INGLJbgw9d6fh+eaf6qjLRPMqMuWkGZCTBbInRygDUQi0JBIuLRcDLwy63qaREYi
	 xEJeijZUg9UB33h0SlOzSANe3FsuwEIIfBMziqY4A2HWQtWhERKJDbKtrnN1wYO98W
	 RlaqZLFncHyvgjkC89LMBkXs13d4N1ULT3bx0Woi+fcuKP3XjIOwaf+nvF0pi3LasH
	 Ck9roETDe7R6bST8f5olV4P/9aWO8aIyCwihbMusOWKf7qlkLs6b9g71JjTlNGoHVS
	 j2ZTF81B1RKWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B08439B167A;
	Tue, 10 Feb 2026 10:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 net-next 00/15] net: fec: improve XDP copy mode and add
 AF_XDP zero-copy support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177071822482.3446472.4693550669604123129.git-patchwork-notify@kernel.org>
Date: Tue, 10 Feb 2026 10:10:24 +0000
References: <20260205085742.2685134-1-wei.fang@nxp.com>
In-Reply-To: <20260205085742.2685134-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, frank.li@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 bpf@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258053-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,lists.linux.dev];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2FD711986F
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  5 Feb 2026 16:57:27 +0800 you wrote:
> This patch set optimizes the XDP copy mode logic as follows.
> 
> 1. Separate the processing of RX XDP frames from fec_enet_rx_queue(),
> and adds a separate function fec_enet_rx_queue_xdp() for handling XDP
> frames.
> 
> 2. For TX XDP packets, using the batch sending method to avoid frequent
> MMIO writes.
> 
> [...]

Here is the summary with links:
  - [v7,net-next,01/15] net: fec: add fec_txq_trigger_xmit() helper
    https://git.kernel.org/netdev/net-next/c/c8d4ad91765c
  - [v7,net-next,02/15] net: fec: add fec_rx_error_check() to check RX errors
    https://git.kernel.org/netdev/net-next/c/ff306e9a1963
  - [v7,net-next,03/15] net: fec: add rx_shift to indicate the extra bytes padded in front of RX frame
    https://git.kernel.org/netdev/net-next/c/385d19b56761
  - [v7,net-next,04/15] net: fec: add fec_build_skb() to build a skb
    https://git.kernel.org/netdev/net-next/c/54a6e86ba4ff
  - [v7,net-next,05/15] net: fec: improve fec_enet_rx_queue()
    https://git.kernel.org/netdev/net-next/c/bc609f97b140
  - [v7,net-next,06/15] net: fec: add fec_enet_rx_queue_xdp() for XDP path
    https://git.kernel.org/netdev/net-next/c/5ff3d3ddcdbe
  - [v7,net-next,07/15] net: fec: add tx_qid parameter to fec_enet_xdp_tx_xmit()
    https://git.kernel.org/netdev/net-next/c/8a3344bb734f
  - [v7,net-next,08/15] net: fec: transmit XDP frames in bulk
    https://git.kernel.org/netdev/net-next/c/2ff7a7d3928b
  - [v7,net-next,09/15] net: fec: remove unnecessary NULL pointer check when clearing TX BD ring
    https://git.kernel.org/netdev/net-next/c/2dcc93475559
  - [v7,net-next,10/15] net: fec: use switch statement to check the type of tx_buf
    https://git.kernel.org/netdev/net-next/c/8492e4f1959c
  - [v7,net-next,11/15] net: fec: remove the size parameter from fec_enet_create_page_pool()
    https://git.kernel.org/netdev/net-next/c/6729b24c1c2f
  - [v7,net-next,12/15] net: fec: move xdp_rxq_info* APIs out of fec_enet_create_page_pool()
    https://git.kernel.org/netdev/net-next/c/edd393153ef0
  - [v7,net-next,13/15] net: fec: add fec_alloc_rxq_buffers_pp() to allocate buffers from page pool
    https://git.kernel.org/netdev/net-next/c/a2ae70c0efe4
  - [v7,net-next,14/15] net: fec: improve fec_enet_tx_queue()
    https://git.kernel.org/netdev/net-next/c/fee723a48cbe
  - [v7,net-next,15/15] net: fec: add AF_XDP zero-copy support
    https://git.kernel.org/netdev/net-next/c/25eb3058eb70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



