Return-Path: <netdev+bounces-276789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBxPJwES12khKwgAu9opvQ
	(envelope-from <netdev+bounces-276789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:42:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CD43C59B1
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3C5E302E33C
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE50536C5A1;
	Thu,  9 Apr 2026 02:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+xvTZge"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B02E36AB72;
	Thu,  9 Apr 2026 02:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775702442; cv=none; b=hhNvIx6RzP5GlFqoZ/VHyRqB0Gvf72hjF542ac9MxyxFI3MtNJ2FazxA2dAAonBRpm6Yrp2Y9rHzIemPUl4ddwvQT5i8L0EzjwoLPSIdCMyWOalc2SOO+/oHAg/GSEgKmxHh6oVNOGDMfpc5eLIVCoR6LSmowYMzFzKhtT8GnfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775702442; c=relaxed/simple;
	bh=+e7CPWpzDmc4JZUBwfyphcWzvMJZyRAI8BM0oGDfdk0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zpr9mhi0nnPI+65L8lT7ehVFlDxOF3SayZQ5EnwRJSnhCSnvlh1WSvJyHGK1BjoFOElAu31uc3q+ZRvjPtlYAwYM0kbAr5QZe4OZYlf6Dpo5EVXF+c1W+imRoyQ4kCRLADW8cOB1SURkS1UKztBZPbCmFFLVgZ5LZocJ2ficyHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+xvTZge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5386EC2BC9E;
	Thu,  9 Apr 2026 02:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775702442;
	bh=+e7CPWpzDmc4JZUBwfyphcWzvMJZyRAI8BM0oGDfdk0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h+xvTZgemK/XJLEg3HUcukjVNaBEyUn1W+mmvQzbkOFBM77RHMb8LoqWgiNfDg72y
	 S4NE1l0KR0mCrIp3GllSuEeApUhzCLwORGQOVjIE5jpA1TJ+r4NOUQ2mkzL55OERxT
	 /1awDHCK3FETkKyh/+yEAxHdqXUhLDeV9UROSaV/A4d2NkZ+pKvzRAXe41PDnK8br5
	 9CMvG6FvEomBrlRB/PdNGn52nNn+BtUbwCYmdzF9BNO9uvZIcSwbgtAixetwTk6uII
	 OhKDFogYbhZI8t13vHKp1v3ZByEPkkHUCdb0SCZb8vQKybu18OKPuPwkd8I0GsE0p6
	 GpnztCoKCAMWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0093930793;
	Thu,  9 Apr 2026 02:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: initialize sk_rx_queue_mapping in sk_clone()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570241829.964658.13177362315432736913.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 02:40:18 +0000
References: <20260407084219.95718-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260407084219.95718-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, edumazet@google.com, kuniyu@google.com,
 pabeni@redhat.com, willemb@google.com, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, soheil@google.com, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-276789-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3CD43C59B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Apr 2026 16:42:18 +0800 you wrote:
> sk_clone() initializes sk_tx_queue_mapping via sk_tx_queue_clear()
> but does not initialize sk_rx_queue_mapping. Since this field is in
> the sk_dontcopy region, it is neither copied from the parent socket
> by sock_copy() nor zeroed by sk_prot_alloc() (called without
> __GFP_ZERO from sk_clone).
> 
> Commit 03cfda4fa6ea ("tcp: fix another uninit-value
> (sk_rx_queue_mapping)") attempted to fix this by introducing
> sk_mark_napi_id_set() with force_set=true in tcp_child_process().
> However, sk_mark_napi_id_set() -> sk_rx_queue_set() only writes
> when skb_rx_queue_recorded(skb) is true. If the 3-way handshake
> ACK arrives through a device that does not record rx_queue (e.g.
> loopback or veth), sk_rx_queue_mapping remains uninitialized.
> 
> [...]

Here is the summary with links:
  - [net] net: initialize sk_rx_queue_mapping in sk_clone()
    https://git.kernel.org/netdev/net-next/c/1a6b3965385a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



