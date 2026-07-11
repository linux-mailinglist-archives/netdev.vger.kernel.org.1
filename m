Return-Path: <netdev+bounces-306901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9w4LC6OwUmqQSQMAu9opvQ
	(envelope-from <netdev+bounces-306901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 23:07:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 485F5742EB8
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 23:07:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Txs1xkIS;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306901-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306901-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34D493023F83
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 21:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B64121ABBB;
	Sat, 11 Jul 2026 21:04:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4AE305679
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 21:04:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783803853; cv=none; b=HjtP4rkB39U2KNINpvP0j7oYuVfdOp8ZV0vo1whJTHZhcEOR9iMPrJKt+Wq/47SZGR4zBOJbuTBamEqONa2U2HEePkBpCCScNrbAwAahJBtPbfEsKdUBCAmZE8jBeJPO/SM9+WO92DkUd6LYi6iin/q+ddkG2WF6n/TocKYgEnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783803853; c=relaxed/simple;
	bh=cERCI6uVF9g47+lyhONovzvk5XFd5tFIJTjvMC/kf8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cluSwK0pIx0evEYVIhJdXmks8+Y2iovanoBG+/ZkUPt0dV5uDb0d8jfoe8cxDQVPtaziUEz1ioEneeqLuZTOmZ/1gFskDWt9bgJMVaf5fLFLMXiu/sPituvNrHQolrOwj5/dUV9f+2JIhhNKZB3VkokNMISiu9lLuwYMPPH7VGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Txs1xkIS; arc=none smtp.client-ip=95.215.58.186
Message-ID: <45d2be78-4e58-445e-81b2-75dbcd15402f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783803847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z5WuK1x1fHq3Mg+KyPpmOrUlIIIjpEDexQ1uLTd5pas=;
	b=Txs1xkISM7iyukESV9HHLrnQS8R2PsL+z8ijLSJN6sX1f654R0e80F+jSY8LVuf0zH/aHv
	WgobdxcXa63L+inTzkIKS2xTURgQj/VJvQdHmgFAjKj6/0a9mP1aOltFPr6y5qh+HboN1I
	nGsSjUwOL2HAH853qQIrzjjynuX2KTo=
Date: Sat, 11 Jul 2026 22:03:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ethtool: Embed FEC hist ranges as buffer in struct
To: Eric Joyner <eric.joyner@amd.com>, netdev@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Simon Horman <horms@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Brett Creeley <brett.creeley@amd.com>, Breno Leitao <leitao@debian.org>,
 "Nikhil P. Rao" <nikhil.rao@amd.com>
References: <20260710230026.47721-1-eric.joyner@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260710230026.47721-1-eric.joyner@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306901-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:eric.joyner@amd.com,m:netdev@vger.kernel.org,m:michael.chan@broadcom.com,m:pavan.chebbi@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:horms@kernel.org,m:maxime.chevallier@bootlin.com,m:brett.creeley@amd.com,m:leitao@debian.org,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amd.com:email,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 485F5742EB8

On 11/07/2026 00:00, Eric Joyner wrote:
> When a driver's .get_fec_stats() handler is called and the driver
> supports FEC histogram stats, the driver supplies the histogram bin
> ranges via a pointer.  This pointer is assigned while under the netdev
> ops lock in fec_prepare_data(), but the actual data is only read after
> the lock is released; so this allows the driver to change the ranges
> (e.g. from another .get_fec_stats() call) while the current call chain
> is reading them in fec_fill_reply().
> 
> Fix this by embedding a buffer for the driver-supplied ranges in struct
> ethtool_fec_hist instead of using a pointer; this ensures there's an
> ethtool core-owned consistent copy that can be used after the netdev ops
> lock is dropped and later in fec_fill_reply(). While some drivers like
> bnxt use a constant struct for their ranges and won't be affected by
> this issue, others like mlx5 (and eventually ionic) will use a
> dynamically constructed range struct and could potentially run into an
> issue.

I didn't like the idea of dynamic range, FEC is not changing while the
link is UP, I don't see a reason to dynamically reconstruct histogram
bins every single call. And the histogram itself is stable per HW per
FEC, can be constant pre-defined struct in a driver, like in bnxt.

But if dynamic allocation is the only option, then yes, we have to
change this ABI.

> Since the kernel API changed here, change the in-tree drivers that
> report FEC histogram stats to copy their ranges instead of just
> supplying a pointer.
> 
> Fixes: cc2f08129925 ("ethtool: add FEC bins histogram report")
> Signed-off-by: Eric Joyner <eric.joyner@amd.com>

