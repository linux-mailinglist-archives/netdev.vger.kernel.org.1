Return-Path: <netdev+bounces-296643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HBZ/NZPnJmptmwIAu9opvQ
	(envelope-from <netdev+bounces-296643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:02:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AEF658762
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:02:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oBipKPHm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296643-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296643-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B4323183C13
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 15:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F643D564B;
	Mon,  8 Jun 2026 15:27:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A7536E466;
	Mon,  8 Jun 2026 15:27:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932455; cv=none; b=Xr2XoMajJy+aZNlFIHBNsCJnnbuAz3zz18XEQG3vCOIw9cpaPg2IWOBY1okkN8BKCOkqqdS2OIHo7Q0yGHkGtqeaoiOHQdg4yj+giKMVNoydTmQKX7r70K+qLPvwocC5aW4P5B+T8BIswHyPy2Ic1Pq5nN8rmP+GhVwMWXZTMI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932455; c=relaxed/simple;
	bh=Q6yMyuPrbfxp3d26feDoU/0MUfkyFzRW0W2fSiT2+lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8UOLfmgu5IVfmcZe/XBNEyZIaFrZ1yXOQhXYdgrm/1pqdAAyS3KoA9DZduw4RNeAQB4/IfCE6T+s4x8JcY943P3czJMtbBBxkcSdbxPq3km0rHn3ygX8qyQYwMXDkriBNrI1DwpqVFl2Vo02hDknol1HGvdjyJyhyI/G9674bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBipKPHm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465DC1F00898;
	Mon,  8 Jun 2026 15:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780932453;
	bh=7AZ5vL34kYiiZacEbj+ZT/dglapfGdO2Op3ikt3we7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oBipKPHmEASagnU/g698KdvqU2dIkb4E5BUVk3yvYWBM4KLqWoqps17YWY2SHhRNo
	 66LNtfzCYMIi3hBneUB3C3L8hhY88Irj7NphiIjvrVzR3WL5oS41gF0ye35SVRdRDa
	 233hcXhm7laO4/rESAkMmsqMI9dkBma8Wieth9AHB3jRsLugNRE0eVmoYrvVqhlY6I
	 r2SgzRCTrwmBfgwxX2zhIuWPnQjmoH2tzeEHKYYbLkuYbruLIvKaYDy6Au/hO98kDS
	 bDI8eYZ9sHvUy174bPd6FL6Fw0ARxWfHvNyFli2tnEYz9EsWdD/gkEUdUVDXb6X4iJ
	 eVewDUTn2RNGQ==
From: Simon Horman <horms@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	Jose.Abreu@synopsys.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: stmmac: xgmac2: disable RBUE in default RX interrupt mask
Date: Mon,  8 Jun 2026 16:27:17 +0100
Message-ID: <20260608152717.157757-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604094512.21243-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260604094512.21243-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-296643-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,synopsys.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71AEF658762

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: stmmac: xgmac2: disable RBUE in default RX interrupt mask

This commit removes the RX Buffer Unavailable (RBUE) interrupt from the
default enable masks for XGMAC2 devices. This is intended to prevent MAC
interrupt storms that can occur under heavy RX pressure when the DMA
runs out of RX descriptors.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> index 51943705a2b03..b5fdc253a2f24 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -379,9 +379,9 @@
>  #define XGMAC_RIE			BIT(6)
>  #define XGMAC_TBUE			BIT(2)
>  #define XGMAC_TIE			BIT(0)
> -#define XGMAC_DMA_INT_DEFAULT_EN	(XGMAC_NIE | XGMAC_AIE | XGMAC_RBUE | \
> +#define XGMAC_DMA_INT_DEFAULT_EN	(XGMAC_NIE | XGMAC_AIE | \
>  					XGMAC_RIE | XGMAC_TIE)
> -#define XGMAC_DMA_INT_DEFAULT_RX	(XGMAC_RBUE | XGMAC_RIE)
> +#define XGMAC_DMA_INT_DEFAULT_RX	(XGMAC_RIE)

[Severity: High]
Does removing the RBUE interrupt break the driver's ability to recover from
RX out-of-memory conditions, leading to a permanent RX queue stall?

When stmmac_rx() processes packets, it calls stmmac_rx_refill() to replenish
the ring descriptors. If page_pool_alloc_pages() fails due to memory
pressure, the descriptors remain empty:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_rx_refill() {
    ...
    buf->page = page_pool_alloc_pages(rx_q->page_pool, gfp);
    if (!buf->page)
        break;
    ...
}

stmmac_rx() then returns the number of processed packets, which will be
less than the NAPI budget if the ring is empty. This causes
stmmac_napi_poll_rx() to complete NAPI and re-enable interrupts:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_napi_poll_rx() {
    ...
    work_done = stmmac_rx(priv, budget, chan);
    if (work_done < budget && napi_complete_done(napi, work_done)) {
        ...
        stmmac_enable_dma_irq(priv, priv->ioaddr, chan, 1, 0);
    }
    ...
}

When the hardware subsequently tries to receive a packet, it finds no
descriptors and enters the Receive Buffer Unavailable (RBU) state. By
removing XGMAC_RBUE from the RX interrupt enable mask, the MAC will no
longer trigger an interrupt for the RBU state.

Because no packets can be successfully received without descriptors, the
normal Receive Interrupt (RIE) will also never fire. With NAPI stopped and
no interrupts firing, the driver has no polling timer to retry allocation,
which could result in a permanent stall of the RX queue.

>  #define XGMAC_DMA_INT_DEFAULT_TX	(XGMAC_TIE)
>  #define XGMAC_DMA_CH_Rx_WATCHDOG(x)	(0x0000313c + (0x80 * (x)))
>  #define XGMAC_RWT			GENMASK(7, 0)

