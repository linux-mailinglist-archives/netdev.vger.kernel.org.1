Return-Path: <netdev+bounces-256095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF7HGGxfgWnEFwMAu9opvQ
	(envelope-from <netdev+bounces-256095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:37:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DB3D3CF6
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4444E3004C85
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 02:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFDE2F39B5;
	Tue,  3 Feb 2026 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kq43tdBi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF5686348
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 02:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770086247; cv=none; b=WnIOEJ+5spCgILEfO9EGgJM3w3YrlrEYZXJOGDHQC7oFH72xwV/7ysmjNkaYN+4UVQFSFcyJpdEtwPCb+u+PGNj36HzgT4+C1gRXewHW+PPrhJ03C4Db7ZQEAzUNvhTQD/Ij7eaProee5gbNrq8q+HCjx3hwPUrg/vNL2mCx/Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770086247; c=relaxed/simple;
	bh=0Yc1vslu5nVu9VeHEkzYMSBTXGrL8Qka4PDHXuJkRUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMtdnKh5ylvsgsUo91CAG55uOiBlFDm8TigrkuS35tZmoGyguYWCebnppEc9oN7utcpfq6rTqdb5bwk3fSglnlwvkcLK0umhN7ZgvlhmuFAXg3JBf5HyXPfexIx3wj8dJCCv9qdfpfKEByqbvM5bhzZxH6E0wK/bVaU16CFGU04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kq43tdBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A88AC116C6;
	Tue,  3 Feb 2026 02:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770086246;
	bh=0Yc1vslu5nVu9VeHEkzYMSBTXGrL8Qka4PDHXuJkRUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kq43tdBiOitu2f8rhdM/gT/9BGbQ47k+7m60V9CB9jtRyYQCY4LYw4GlQOpMMELkZ
	 4V+D71mO0lePgfP0u5tV9dcChOYX9RID2VTNYZcrLDQGnZ+IB/68dIQ0phSA9zMC5d
	 wRIl1BUbM8p5haRTjHmZuzUNRqCBv+UGo4fw/YeMl53Q8JFSMlPTExXZi9lH8q3rT9
	 GDwfxVKRJ0h9sF5e1Af5AtRIcV3Yd42xVPZdmRBegVQngw1f5Q7uPpfUPsIy8lCOx0
	 fajwEiFBWZpz/lll8sdh4OjsWwjNyODc8AjhCtcqOjerox4z3MiNv6Y4SCiRDuPyUp
	 mBpr8t+CSOVsg==
From: Jakub Kicinski <kuba@kernel.org>
To: Raju.Rangoju@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [2/3] net: amd-xgbe: add ARP offload ethtool self-test
Date: Mon,  2 Feb 2026 18:37:13 -0800
Message-ID: <20260203023713.896262-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202153542.1727429-3-Raju.Rangoju@amd.com>
References: <20260202153542.1727429-3-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256095-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 81DB3D3CF6
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: amd-xgbe: add ARP offload ethtool self-test

This patch adds an ethtool self-test to verify the hardware ARP offload
functionality. The test creates an ARP request, enables ARP offload, and
verifies the hardware responds with an ARP reply.

> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c

[ ... ]

> +static int xgbe_test_arpoffload(struct xgbe_prv_data *pdata)
> +{

[ ... ]

> +	tdata->pt.type = htons(ETH_P_ARP);
> +	tdata->pt.func = xgbe_test_arp_validate;
> +	tdata->pt.dev = pdata->netdev;
> +	tdata->pt.af_packet_priv = tdata;
> +	tdata->packet = &attr;
> +	dev_add_pack(&tdata->pt);

[ ... ]

> +	/* Create ARP request packet */
> +	skb = arp_create(ARPOP_REQUEST, ETH_P_ARP, htonl(dst_ip),
> +			 pdata->netdev,	htonl(src_ip), NULL, src, bcast);
> +	if (!skb) {
> +		ret = -ENOMEM;
> +		goto free;
> +	}

Can this cause a use-after-free? The packet handler is registered via
dev_add_pack() before arp_create() is called. When arp_create() fails,
'goto free' jumps directly to kfree(tdata) without calling
dev_remove_pack(&tdata->pt).

This leaves the packet handler registered with a dangling pointer
(tdata->pt.af_packet_priv = tdata). When any ARP packet subsequently
arrives, xgbe_test_arp_validate() is called and dereferences freed memory:

    struct net_test_priv *tdata = pt->af_packet_priv;
    ...
    if (!ether_addr_equal_unaligned(eth_hdr->h_dest, tdata->packet->src))

Should 'goto free' be changed to 'goto cleanup' here to ensure
dev_remove_pack() is called?
-- 
pw-bot: cr

