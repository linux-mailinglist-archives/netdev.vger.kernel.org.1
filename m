Return-Path: <netdev+bounces-295585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RsSNAScyImrwTgEAu9opvQ
	(envelope-from <netdev+bounces-295585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:19:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70806644A58
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:19:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=O++CaLF8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295585-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295585-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7BF130073F5
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 02:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F4F3E314A;
	Fri,  5 Jun 2026 02:19:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4764F3537E0;
	Fri,  5 Jun 2026 02:18:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780625943; cv=none; b=QHq9o8HvMN4NVdc4MBag5tQALDrONcsV3uDAPRaXUhEiIBVtMOOvUoef3cPu1ABdiq2q99ddsEvBsLFn8tkas1sItBla2/dD3gj6aCIk+rjW6htpSyMZh2M9Y3wm8or1pAP6dCGrbgwFgNDoTb6GGEnzyNpjkkeCDguHoJ1W6+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780625943; c=relaxed/simple;
	bh=pPJlGcT4H26CdpxxHFB6T5I8HU/ThewofmKN3unxuvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKTOxiD8yloq4CrtDNQvg6ShwYo/diyPPhN3A0tmyQUdIY/DD0r+nAgtOeAkqJptp2iM0x76YaSwE/wMXEJKIz88+OTnq9iRvN9ZxIvqcWBEOQ3PA+mg9/tVEYiYxf9v+sU47VYUCJOeLKnw2KXunDciUehbVB2jghjkVhXMkEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O++CaLF8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA281F00898;
	Fri,  5 Jun 2026 02:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780625935;
	bh=Z/YFoK1DlLyiD3rD9Jae9zwSGdB8zFmwUT4o+JkNbQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O++CaLF8v8wrssJuowzuKTiK6q8AhGFjieZh0Sx7fWLDdO9jbhs33tdFsXwH2fOP/
	 Qgt0hQUOSpCO0XDgBEFu8XgcCweOoOl6khQoBWJF0iIwf3pgXC8GojWK91wnrWKr1g
	 v7I2X9G4lGqCaUNHocPPgP9ViDeDF7iYqhNymnHMcR58lopXWw0GyHsSJzsHP0ejx8
	 ajkkk4nyNlt43GFBbKXfO3ystJy80PDX+WvT4mOLLEO/EwDFI3waTsF6i2i49KXCUR
	 yV5XsPl4vZeZi/T5jY5H+413t6Z1mSLIXOh4cYtb3KQm/EqwCiKcxtM0riH5EPvWgr
	 5IfFIJ6DE4pHQ==
From: Jakub Kicinski <kuba@kernel.org>
To: lukasz.majewski@mailbox.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	lgirdwood@gmail.com,
	nathan@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	krzk+dt@kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	robh@kernel.org
Subject: Re: [net-next v24 3/7] net: mtip: Add buffers management functions to the L2 switch driver
Date: Thu,  4 Jun 2026 19:18:53 -0700
Message-ID: <20260605021853.3594553-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601112437.2216043-4-lukasz.majewski@mailbox.org>
References: <20260601112437.2216043-4-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-295585-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lukasz.majewski@mailbox.org,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:lgirdwood@gmail.com,m:nathan@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:krzk+dt@kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:robh@kernel.org,m:andrew@lunn.ch,m:krzk@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70806644A58

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: mtip: Add buffers management functions to the L2 switch driver

This patch fills in mtip_alloc_buffers() and mtip_free_buffers() for the
MTIP L2 switch driver, replacing the previously empty stubs with real
page_pool setup/teardown and tx_bounce buffer allocation/free.

> diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> index 1d1005a42306..5b5229ee411d 100644
> --- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> +++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> @@ -892,11 +892,101 @@ static void mtip_get_drvinfo(struct net_device *dev,
>  
>  static void mtip_free_buffers(struct net_device *dev)
>  {
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
> +	for (i = 0; i < TX_RING_SIZE; i++) {
> +		kfree(fep->tx_bounce[i]);
> +		fep->tx_bounce[i] = NULL;
> +	}
> +}

[High]
Now that mtip_free_buffers() is no longer an empty stub, can the
mtip_open() error path tear down buffers that another active port is
still using?

Looking at mtip_open():

	if (fep->usage_count == 0) {
		...
		ret = mtip_alloc_buffers(dev);
		if (ret)
			goto mtip_alloc_buffers_err;
	}
	...
	ret = mtip_mii_probe(dev);
	if (ret)
		goto mtip_mii_probe_err;
	...
 mtip_mii_probe_err:
	mtip_free_buffers(dev);
 mtip_alloc_buffers_err:
	if (fep->usage_count == 0) {
		netif_napi_del(&fep->napi);
		clk_disable(fep->clk_ipg);
	}
	return ret;

mtip_alloc_buffers() only runs when fep->usage_count == 0, so the
page_pool, fep->page[] and fep->tx_bounce[] are shared across switch
ports and only allocated on first open. mtip_close() reflects this and
only calls mtip_free_buffers() when fep->usage_count == 1.

When a second port is opened (fep->usage_count > 0) and mtip_mii_probe()
fails, the mtip_mii_probe_err label still calls mtip_free_buffers()
unconditionally, which destroys the page_pool and frees the tx_bounce
buffers that the first, still-active port is using.

Should the mtip_mii_probe_err teardown also be guarded by
fep->usage_count == 0 (or the labels reordered) so buffers are only
freed for the last user, similar to mtip_close()?

After this change the previously harmless call becomes a real teardown,
so the surviving port's NAPI path (mtip_switch_rx() and the later
mtip_update_cbd() refill) would dereference a freed fep->page_pool and
NULL fep->page[] / fep->tx_bounce[] entries whenever the second port's
PHY probe fails while the first port is up.

>  
> +static int mtip_create_page_pool(struct switch_enet_private *fep, int size)
> +{
[ ... ]
> +}
>  
>  static int mtip_alloc_buffers(struct net_device *dev)
>  {
[ ... ]
>  	return 0;
> +
> + err:
> +	mtip_free_buffers(dev);
> +	return -ENOMEM;
>  }
>

