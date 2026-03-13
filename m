Return-Path: <netdev+bounces-267442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HHzMfoGtGlvfwAAu9opvQ
	(envelope-from <netdev+bounces-267442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:45:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3047F283329
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D93C630692CE
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD442EC54C;
	Fri, 13 Mar 2026 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="X5Z6kWzV"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3683D29E116;
	Fri, 13 Mar 2026 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773405943; cv=none; b=Lj4xBMSJhWBhxY66QKCC5Sc14f+teLCEQ42/wUAbe86XfNx6bkoR35cCcRCXTGeYWr2yNvqA6GWhR2IBIqls4uuJUYnZSlwibjHeoZL8PlxBSMj8cgx3up5oKzvr7iVsOQcoBHPqemSQLhNXSqC/5CSbU9rim68nmDoWciZU7Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773405943; c=relaxed/simple;
	bh=Ekj7aRQNWx1AZSY3KviItzQEDlkzGy0tWmfbcRdwtV4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=XKGIv6PvBQywU3QyglPUXgwnDbOwTQJjgpIFD6SqgUUC1+ziq4rwRE9M7Um7kkVQ6ontkGNMSRVlQBUqBTdhZ6cqwNX3djWU38ByUZNJWQRyTzsitumEl5DWojLRQhRUo6XjHvg2m0O2owOF9N6O8WovL9xT7NFzq6aZVIManrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=X5Z6kWzV; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 23C62A002C;
	Fri, 13 Mar 2026 13:45:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773405937; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=A/47jnKZviCg6uCxxtHoDQRxJVDuZQz5+RJqU7FcO/c=;
	b=X5Z6kWzVrRPMiOriiFH6ZhD6TV95cqwr+aJEyqjlunKJoxz4c10Ol6ykL5j3nnILphpBEM
	8SNm7q1JtINj1RUtIoRYdlUwq/A0eUGdyIGj4IMmDdaR7UYW1sAU7oxLO+Mqlbd2OixdXT
	LQUcZQ3W9zFHwgdYZJHh8BdHH6V1hbU3BRIzoLaVSmZiW296Yu8FuJMNZs46iAjf7TmEDI
	9sc3jjRADpB/BqXeSJowFt7yO07smy8voT+akZDKyXbHbUzYV/VHdNzlQLpqmV8Oe+d1uu
	91NN33rrGcX6WD09sR/zsubqMR0KD5Rod4C2c83UEa2pMFye/x1enn4mSiaDTw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 13 Mar 2026 13:45:33 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Doug Berger
 <opendmb@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Vikas Gupta
 <vikas.gupta@broadcom.com>, Bhargava Marreddy
 <bhargava.marreddy@broadcom.com>, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>, Eric Biggers <ebiggers@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, =?UTF-8?Q?Markus_Bl=C3=B6chl?=
 <mbloch@rooftopnetworks.de>, Arnd Bergmann <arnd@arndb.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/6] net: bcmgenet: add XDP_TX support
In-Reply-To: <20260313113737.GA209052@kernel-ep2>
References: <20260313092101.1344954-1-nb@tipi-net.de>
 <20260313092101.1344954-5-nb@tipi-net.de>
 <20260313113737.GA209052@kernel-ep2>
Message-ID: <5cb0916bdb19ea33e11ea93f7174fd76@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267442-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,broadcom.com,rooftopnetworks.de,arndb.de,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3047F283329
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 13.3.2026 12:37, Subbaraya Sundeep wrote:
> Hi,

Hi Sundeep

> 
> On 2026-03-13 at 14:50:59, Nicolai Buchwitz (nb@tipi-net.de) wrote:
>> Implement XDP_TX by submitting XDP frames through the default TX ring
>> (DESC_INDEX). The frame is DMA-mapped and placed into a single TX
>> descriptor with SOP|EOP|APPEND_CRC flags.
>> 
>> The xdp_frame pointer is stored in the TX control block so that
>> bcmgenet_free_tx_cb() can call xdp_return_frame() on TX completion,
>> returning the page to the originating page_pool.
>> 
>> The page_pool DMA direction is changed from DMA_FROM_DEVICE to
>> DMA_BIDIRECTIONAL to support the TX DMA mapping of received pages.
>> 
>> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
>> ---
>>  .../net/ethernet/broadcom/genet/bcmgenet.c    | 73 
>> ++++++++++++++++++-
>>  .../net/ethernet/broadcom/genet/bcmgenet.h    |  1 +
>>  2 files changed, 71 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
>> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> index d43729fc2b1b..373ba5878ca1 100644
>> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> @@ -1893,6 +1893,12 @@ static struct sk_buff 
>> *bcmgenet_free_tx_cb(struct device *dev,
>>  		if (cb == GENET_CB(skb)->last_cb)
>>  			return skb;
>> 
>> +	} else if (cb->xdpf) {
>> +		dma_unmap_single(dev, dma_unmap_addr(cb, dma_addr),
>> +				 dma_unmap_len(cb, dma_len), DMA_TO_DEVICE);
>> +		dma_unmap_addr_set(cb, dma_addr, 0);
>> +		xdp_return_frame(cb->xdpf);
>> +		cb->xdpf = NULL;
>>  	} else if (dma_unmap_addr(cb, dma_addr)) {
>>  		dma_unmap_page(dev,
>>  			       dma_unmap_addr(cb, dma_addr),
>> @@ -2299,10 +2305,62 @@ static struct sk_buff 
>> *bcmgenet_xdp_build_skb(struct bcmgenet_rx_ring *ring,
>>  	return skb;
>>  }
>> 
>> +static bool bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
>> +				     struct xdp_frame *xdpf)
>> +{
>> +	struct bcmgenet_tx_ring *ring = &priv->tx_rings[DESC_INDEX];
>> +	struct device *kdev = &priv->pdev->dev;
>> +	struct enet_cb *tx_cb_ptr;
>> +	dma_addr_t mapping;
>> +	u32 len_stat;
>> +
>> +	spin_lock(&ring->lock);
>> +
>> +	if (ring->free_bds < 1) {
>> +		spin_unlock(&ring->lock);
>> +		return false;
>> +	}
>> +
>> +	tx_cb_ptr = bcmgenet_get_txcb(priv, ring);
>> +
>> +	mapping = dma_map_single(kdev, xdpf->data, xdpf->len, 
>> DMA_TO_DEVICE);
> 
> AFAIU you are transmitting the frame received on a RQ which is from the 
> page pool
> and already dma mapped. Do you have to do dma_map again?
> 
> Thanks,
> Sundeep
> 

You're right. Since the page_pool is configured with DMA_BIDIRECTIONAL,
the pages are already mapped and we can reuse the existing mapping for
XDP_TX frames. The initial implementation took the simple route of
mapping everything uniformly, but that's unnecessary overhead for the
local XDP_TX case.

In v2 I'll add a bool dma_map parameter to bcmgenet_xdp_xmit_frame()
(following the mvneta/stmmac pattern): XDP_TX will reuse the page_pool
mapping via page_pool_get_dma_addr() + dma_sync_single_for_device(),
while ndo_xdp_xmit will keep dma_map_single() for foreign frames. The
cleanup path will be split accordingly.

Regards
Nicolai

>> [...]

