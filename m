Return-Path: <netdev+bounces-255316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK8kJOFgfWkDRwIAu9opvQ
	(envelope-from <netdev+bounces-255316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:54:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 374EBC0224
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3DBC30071D3
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 01:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADB633372A;
	Sat, 31 Jan 2026 01:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiGWsRAF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF90133344A;
	Sat, 31 Jan 2026 01:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769824478; cv=none; b=iAJlMfeFqg41PspTQ1jl50ebCT8q90cFHGKELO9jHL+QSRPia9dW2VFJaN/G3mtL5CrfS3TcN422V+DpFDnofZYAlX9eBOmylxQNhsHLLJcQw7yVUepVgDZsJ0fH0CnFfTVTGPmVfUIm02HkbopU7u4wQh6kiyfD4g2zCn5m81o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769824478; c=relaxed/simple;
	bh=PZiP7hTRN8O92xfwMW2wC0dfQY9Tq13ZCF+jHPKg+BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFs+PI0JNNbyEhk+pyx/h6kDMP1lYhzm9EjYvMCYWvRQjiEZLCdaMYLXRqQKn4G3SX+RnWqIwdqSJ+Ht955Yb4mt36xxHQ8S2Iqk+YoUeG2jXOts0fbYGccpHVx5XhWADFobjMnDzZubsbMLWUcddjObmPfCcpIrfXjbFo7Y9+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiGWsRAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EB1C19421;
	Sat, 31 Jan 2026 01:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769824477;
	bh=PZiP7hTRN8O92xfwMW2wC0dfQY9Tq13ZCF+jHPKg+BM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SiGWsRAFbu9Eos8oeV9+LiUDHXRkt15ysjnmqZfOyJI2q7QXFWBnrHjMV0FaJr96C
	 5HbsjyxurBTd+6dJ6pvlVO6dpkjOd52tXTLefRkPsLfrqeolWPNPidlKFznDVusIZ9
	 ofJIwNWN2AsXUcoQkeaqfJuHuHkqKMDBJ64jpRSpgDSf4Fnto1rDN9mpN//MOUaBbn
	 tdjMl7Jlsh5mNuWSicBaCRrougl5neZiYh7SYdjGdeFDdb5uw+kR8GH0BkoiTuvNKM
	 oGE2WKRMs2MkcFioQZ8kK0xJpsqYddfxflKQPcjvxQSREc7uDDFNppX6S2yrk6MAkf
	 9l/JJ1h9r0deQ==
From: Jakub Kicinski <kuba@kernel.org>
To: lukasz.majewski@mailbox.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	devicetree@vger.kernel.org,
	horms@kernel.org,
	krzk+dt@kernel.org,
	s.hauer@pengutronix.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	richardcochran@gmail.com,
	shawnguo@kernel.org,
	edumazet@google.com,
	linux-arm-kernel@lists.infradead.org,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	wahrenst@gmx.net,
	davem@davemloft.net,
	festevam@gmail.com,
	conor+dt@kernel.org,
	imx@lists.linux.dev,
	andrew@lunn.ch,
	robh@kernel.org
Subject: Re: [net-next,v21,3/7] net: mtip: Add buffers management functions to the L2 switch driver
Date: Fri, 30 Jan 2026 17:54:35 -0800
Message-ID: <20260131015435.972356-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129110154.1699976-4-lukasz.majewski@mailbox.org>
References: <20260129110154.1699976-4-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255316-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,pengutronix.de,gmail.com,google.com,lists.infradead.org,lunn.ch,redhat.com,gmx.net,davemloft.net,lists.linux.dev];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 374EBC0224
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: mtip: Add buffers management functions to the L2 switch driver

This patch adds buffer allocation and deallocation functions for the
MTIP L2 switch driver, including page pool management for RX buffers
and bounce buffer allocation for TX.

> diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> --- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> @@ -888,11 +888,99 @@ static void mtip_get_drvinfo(struct net_device *dev,
>
> static void mtip_free_buffers(struct net_device *dev)
> {
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	int i;
> +
> +	for (i = 0; i < RX_RING_SIZE; i++) {
> +		if (!fep->page[i])
> +			continue;
> +
> +		page_pool_put_full_page(fep->page_pool,
> +					fep->page[i], false);
> +		fep->page[i] = NULL;
> +	}
> +
> +	page_pool_destroy(fep->page_pool);
> +	fep->page_pool = NULL;
> +
> +	for (i = 0; i < TX_RING_SIZE; i++)
> +		kfree(fep->tx_bounce[i]);

Should fep->tx_bounce[i] be set to NULL after kfree() here? The RX path
above correctly sets fep->page[i] = NULL after releasing the page, but
the TX path does not NULL out the bounce buffer pointers.

If mtip_alloc_buffers() is called again after a partial allocation
failure (e.g., mtip_open() fails and user retries), the stale pointers
in tx_bounce[] from the previous failed allocation could lead to a
double-free when mtip_free_buffers() is called on the retry failure
path.

Consider the sequence: first mtip_open() allocates tx_bounce[0..5] then
fails at index 6. mtip_free_buffers() frees tx_bounce[0..5] but leaves
stale pointers. Second mtip_open() allocates tx_bounce[0..2] then fails
at index 3. mtip_free_buffers() will kfree() the stale pointers at
tx_bounce[3..5].

[ ... ]

