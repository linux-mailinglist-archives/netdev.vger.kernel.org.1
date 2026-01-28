Return-Path: <netdev+bounces-254070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LsIGtlzeWkHxQEAu9opvQ
	(envelope-from <netdev+bounces-254070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:26:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2FF9C399
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E473530214FF
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E892989B7;
	Wed, 28 Jan 2026 02:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bU+7UPiQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBC628C864;
	Wed, 28 Jan 2026 02:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567158; cv=none; b=QICzE5U/m3nzDcL2YAF+YcMfpLUsWRhQs7WfrxtWew682LruUXvYIgFD+IE7b1hUBcBubWb2Yi5jKeo9HUXeJwLEqry+85hX/WY2CtmIsX0nMGAk9InVQdMdpFbgj/RxJwghVv99dt3RBrNB0Wb2pQqRV/2A90g6eB6huVorQ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567158; c=relaxed/simple;
	bh=1fMfmkSAk2FmGtHJNUwOGGC3405qV/fBN6ZwGBNp60A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiXNMP7udGuYmYgcN1C4bfX2qPOtWoQrqlxy/5EWbo3HskQRpmAx+yy/lGfCC1gFvuuYiqbiifBO+3G/Tbl+yMD0q2HtBXGe2J0Xl9ckc9EkMMaHOW8HXhOMNtEEkWPDHW3RjJ5TOyE4wdTRg/9oSnp1vbdbqGvo4gcGsvgmN+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bU+7UPiQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321C6C116C6;
	Wed, 28 Jan 2026 02:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769567158;
	bh=1fMfmkSAk2FmGtHJNUwOGGC3405qV/fBN6ZwGBNp60A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bU+7UPiQao2Uv+KInv+Huemi8CQCdoEi3gTJNXH/8bNhnAEKTirqHbgS8pLRFIKMS
	 VXebTqtj8c5B25y1BO1y9l97mL7hpz/4gaZDvqTuBGbPP39JXwGbI4BztjdXFRk5Bs
	 bJgDELrDuzfn4mOhes927UBeueifCUxLw2KWOIQYbRLFE4fI//ctySSp6YYQ8N4n5n
	 MQqfbmI4m+o7/zJSgkoKmEbVqaUhek7W6BM3cG5/qMAezhtxCb3KQM9UVVGicqWiYI
	 OeBgO+BEqymmNv9lqZ7LMjEv6b1QoWRPf0+R4fhKEzTUlEuWeHW9C8OSzJNVn+7Spq
	 FFaKY7NfPLdlg==
From: Jakub Kicinski <kuba@kernel.org>
To: lukasz.majewski@mailbox.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	festevam@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	horms@kernel.org,
	shawnguo@kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	wahrenst@gmx.net,
	pabeni@redhat.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	richardcochran@gmail.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	andrew@lunn.ch
Subject: Re: [net-next,v20,3/7] net: mtip: Add buffers management functions to the L2 switch driver
Date: Tue, 27 Jan 2026 18:25:54 -0800
Message-ID: <20260128022554.4151421-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126103400.1683125-4-lukasz.majewski@mailbox.org>
References: <20260126103400.1683125-4-lukasz.majewski@mailbox.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lists.infradead.org,pengutronix.de,lists.linux.dev,vger.kernel.org,gmx.net,redhat.com,davemloft.net,google.com,lunn.ch];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-254070-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: BC2FF9C399
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: mtip: Add buffers management functions to the L2 switch driver

This patch adds buffer management functions for the MTIP L2 switch
driver, implementing mtip_free_buffers(), mtip_create_page_pool(), and
mtip_alloc_buffers() for RX page pool and TX bounce buffer handling.

> diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> index 03c5163d6508..9c21a3d29c1c 100644
> --- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> @@ -888,11 +888,96 @@ static void mtip_get_drvinfo(struct net_device *dev,
>
>  static void mtip_free_buffers(struct net_device *dev)
>  {
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	int i;
> +
> +	for (i = 0; i < RX_RING_SIZE; i++) {
> +		page_pool_put_full_page(fep->page_pool,
> +					fep->page[i], false);

Can fep->page[i] be NULL here?  When mtip_alloc_buffers() fails partway
through the RX allocation loop, it calls mtip_free_buffers() via the
error path.  At that point, only some fep->page[] entries have been
allocated - the rest remain NULL from the kzalloc initialization.

The call chain page_pool_put_full_page()->page_pool_put_netmem()->
page_pool_unref_and_test()->page_pool_unref_netmem()->
netmem_get_pp_ref_count_ref() will attempt to access &NULL->pp_ref_count
when passed a NULL page, causing a NULL pointer dereference.

Should there be a NULL check before calling page_pool_put_full_page()?

> +		fep->page[i] = NULL;
> +	}
> +
> +	page_pool_destroy(fep->page_pool);
> +	fep->page_pool = NULL;
> +
> +	for (i = 0; i < TX_RING_SIZE; i++)
> +		kfree(fep->tx_bounce[i]);
>  }

[ ... ]

> +static int mtip_alloc_buffers(struct net_device *dev)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	struct cbd_t *bdp;
> +	struct page *page;
> +	int i, ret;
> +
> +	ret = mtip_create_page_pool(fep, RX_RING_SIZE);
> +	if (ret < 0) {
> +		dev_err(&fep->pdev->dev, "Failed to create page pool\n");
> +		return ret;
> +	}
> +
> +	bdp = fep->rx_bd_base;
> +	for (i = 0; i < RX_RING_SIZE; i++) {
> +		page = page_pool_dev_alloc_pages(fep->page_pool);
> +		if (!page) {
> +			dev_err(&fep->pdev->dev,
> +				"Failed to allocate page for rx buffer\n");
> +			goto err;
> +		}

[ ... ]

> + err:
> +	mtip_free_buffers(dev);

When this error path is taken, fep->page[] may contain NULL entries for
pages that were never allocated.

> +	return -ENOMEM;
>  }

