Return-Path: <netdev+bounces-273834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yN5xGeyAzGkFTgYAu9opvQ
	(envelope-from <netdev+bounces-273834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:20:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E353373C5F
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6078D3015CA7
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 02:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF532D9EC2;
	Wed,  1 Apr 2026 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdUZgJEd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65F51A683D;
	Wed,  1 Apr 2026 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775010025; cv=none; b=hPZVes5A5F6qjKUHe0/nwVW08gM6d99zLXt8MfxiJSLUqDyfxpnSjGfDG28ElWeM2APL8OmH0sUkqleyLx2mo/iZl/3181OxlIiDB2qZzKfstrqvTMLcW0KfU5kWbNzxD1qcrg5ZZ3i8pGuyJX2QlrZDYj6btNO2MVlB8y+D130=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775010025; c=relaxed/simple;
	bh=/nZY0DkTwLxSbo/sjUync98GIpbhFVraebdGjCFuVYo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m2HpVNyYZhO74YmCb3cJwJRUo5jhjDRnR0MVu/hPe5yPhqoO5MBzDZYWrRnV+lZ9wvG4FJzuVoj6214cRvoLyKf5D9EnjV9HTR8zSWXM+2Sdhn1/D/gOZv0EDp55IePzwRYPrSZxajwKC5/RgJZkRczzJzu7wBA1pDgIFs6F3zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdUZgJEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41144C19423;
	Wed,  1 Apr 2026 02:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775010025;
	bh=/nZY0DkTwLxSbo/sjUync98GIpbhFVraebdGjCFuVYo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RdUZgJEdGeLPEcAlgZzciii26rJyE9d/hxI73CbHoTOeTt1Bv+eLDVGL/baWpGhXl
	 i9gqpSuC+JKux8EOt7ZPOLxHh9e5KlUz26QGC+mkwsk9G95bffp7yqTkOsrDZYLT9A
	 8Z+mOmoyGmb6Zcrk5PHvP23do/HdQp2DbcEv01I/G0oHs6YRv2cVfacxonQ3h9wwPb
	 nJuJicZgmuNqsaPkLjnQTkdg5Igi0CNaDe1zMArjJoce7J6FdIpzspFREOOTARy+3T
	 U4PejEJ5ZrzCS0CDxaK6g5w7HMOjjykx01h+JhGNp1yIMQsOvE6QKQG55rS+lbTnmS
	 SQVHcDOTg9/LA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E603808203;
	Wed,  1 Apr 2026 02:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] sfc: add transmit timestamping support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177501000854.3035943.12820254814166171408.git-patchwork-notify@kernel.org>
Date: Wed, 01 Apr 2026 02:20:08 +0000
References: <20260330063236.247057-1-ibakolla@redhat.com>
In-Reply-To: <20260330063236.247057-1-ibakolla@redhat.com>
To: Izabela Bakollari <ibakolla@redhat.com>
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,amd.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-273834-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E353373C5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Mar 2026 08:32:35 +0200 you wrote:
> Add ethtool op to advertise TX timestamping. Insert a
> skb_tx_timestamp call in __efx_enqueue_skb.
> 
> Signed-off-by: Izabela Bakollari <ibakolla@redhat.com>
> Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>  drivers/net/ethernet/sfc/ethtool.c | 2 ++
>  drivers/net/ethernet/sfc/tx.c      | 2 ++
>  2 files changed, 4 insertions(+)

Here is the summary with links:
  - [net-next,v2] sfc: add transmit timestamping support
    https://git.kernel.org/netdev/net-next/c/6730f184abdc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



