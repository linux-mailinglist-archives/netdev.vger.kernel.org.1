Return-Path: <netdev+bounces-304110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 32TeGwxJRmoONwsAu9opvQ
	(envelope-from <netdev+bounces-304110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 13:18:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC34D6F68FA
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 13:18:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b="Te/jtcnb";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304110-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304110-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07D2932840AE
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 10:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507343C5522;
	Thu,  2 Jul 2026 10:48:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22D5390608;
	Thu,  2 Jul 2026 10:48:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989323; cv=none; b=CGHXiTiGM87sqKeExuNKSLX7DZheIC5MsSPSE8Bz+CBFGILUbtKd1dphobJcN5hSEHUQV2UIkTeVztKdqHUeWtJzVegGL14PU6sBno+FLXN6xM6s9w6q+JBPNziHUarq7dBrqRcesu1GBpmnckaX6xvcE/dgPL1nbYL/Jst8In8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989323; c=relaxed/simple;
	bh=Sp68GZrBGbgyvHBbJLWBh3hY+MVXgdcZAzg3rsONWsw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=T7yFBIXYvrRMik8Fu7kNFCXHNiBoBIl76KqdRxvbd61BWcXENQT0bDbRVL9D7tzSropq6l+wtQmIaTvBYFKvblivorrCz3dGB8L16U9uGOXDYYTa4qiIBljQhsXxceKgtZTDdX9IHULpHEo0JDTb7QbO/oQZ5ppuFsgsKXXvV3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Te/jtcnb; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90444A47C9;
	Thu,  2 Jul 2026 12:48:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1782989319; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sjHeEbjoAzrBSvffXbMvr5nbFm9GTwQ0lFY1pEbU+es=;
	b=Te/jtcnbmsMUJqu7b77pmRTDiHhASlroo4CnvPpo/F9hhmjcaO7rhwqzvcnsAGYlqqWXxy
	7nSmh/L53pJetMG7WXZTgGyn595nH3K5sg0Wf5Eu6C6cYIT4pCNQ03W+LU1+cc0902nnxl
	TyXq//9HQ54J12JXIy6FlPbl64vvwDiSSIWfTOTWeXjTpMOMCPCCUHNlDzmYleCGE8sz4C
	sxmwbQV3ufnRbxnInV8VifwdMU1m7n3t39Sm5fJjgcD1vBTasqPy/9p0q/+/4AweKnIbZU
	52Li89gHlEcE9+RCSgnJqsTWbf93wKYgy0ZXvvsogvTKctAuE13h8y76g/ZVdw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 02 Jul 2026 12:48:37 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Russell
 King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Paolo Valerio
 <pvalerio@redhat.com>, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v3 05/15] net: macb: enforce reverse christmas
 tree (RCT) convention
In-Reply-To: <20260701-macb-context-v3-5-00268d5b1502@bootlin.com>
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
 <20260701-macb-context-v3-5-00268d5b1502@bootlin.com>
Message-ID: <fb720848271f0d95b455c0ad1f97c41d@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_RECIPIENTS(0.00)[m:theo.lebrun@bootlin.com,m:conor.dooley@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:pvalerio@redhat.com,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-304110-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,tuxon.dev,mobileye.com,bootlin.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid,tipi-net.de:from_mime,bootlin.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC34D6F68FA

On 1.7.2026 17:59, Théo Lebrun wrote:
> Enforce the reverse christmas tree convention in those functions:
> 
>    macb_tx_error_task()
>    gem_rx_refill()
>    gem_rx()
>    macb_rx_frame()
>    macb_init_rx_ring()
>    macb_rx()
>    macb_rx_pending()
>    macb_start_xmit()
> 
> The goal is to minimise unrelated diff in future patches.
> 
> In macb_tx_error_task(), we fold the assignment into the declaration
> statement.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 61 
> ++++++++++++++++----------------
>  1 file changed, 30 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index 3b75797381b6..8b52122bc134 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1254,20 +1254,19 @@ static dma_addr_t macb_get_addr(struct macb 
> *bp, struct macb_dma_desc *desc)
> 
>  static void macb_tx_error_task(struct work_struct *work)
>  {
> -	struct macb_queue	*queue = container_of(work, struct macb_queue,
> -						      tx_error_task);
> -	bool			halt_timeout = false;
> -	struct macb		*bp = queue->bp;
> -	unsigned int		q;
> -	u32			packets = 0;
> -	u32			bytes = 0;
> -	struct macb_tx_skb	*tx_skb;
> -	struct macb_dma_desc	*desc;
> -	struct sk_buff		*skb;
> -	unsigned int		tail;
> -	unsigned long		flags;
> +	struct macb_queue *queue = container_of(work, struct macb_queue,
> +						tx_error_task);
> +	unsigned int q = queue - queue->bp->queues;
> +	struct macb *bp = queue->bp;
> +	struct macb_tx_skb *tx_skb;
> +	struct macb_dma_desc *desc;
> +	bool halt_timeout = false;
> +	struct sk_buff *skb;
> +	unsigned long flags;
> +	unsigned int tail;
> +	u32 packets = 0;
> +	u32 bytes = 0;
> 
> -	q = queue - bp->queues;
>  	netdev_vdbg(bp->netdev, "macb_tx_error_task: q = %u, t = %u, h = 
> %u\n",
>  		    q, queue->tx_tail, queue->tx_head);
> 
> @@ -1487,11 +1486,11 @@ static int macb_tx_complete(struct macb_queue 
> *queue, int budget)
> 
>  static void gem_rx_refill(struct macb_queue *queue)
>  {
> -	unsigned int		entry;
> -	struct sk_buff		*skb;
> -	dma_addr_t		paddr;
>  	struct macb *bp = queue->bp;
>  	struct macb_dma_desc *desc;
> +	struct sk_buff *skb;
> +	unsigned int entry;
> +	dma_addr_t paddr;
> 
>  	while (CIRC_SPACE(queue->rx_prepared_head, queue->rx_tail,
>  			bp->rx_ring_size) > 0) {
> @@ -1584,11 +1583,11 @@ static int gem_rx(struct macb_queue *queue, 
> struct napi_struct *napi,
>  		  int budget)
>  {
>  	struct macb *bp = queue->bp;
> -	unsigned int		len;
> -	unsigned int		entry;
> -	struct sk_buff		*skb;
> -	struct macb_dma_desc	*desc;
> -	int			count = 0;
> +	struct macb_dma_desc *desc;
> +	struct sk_buff *skb;
> +	unsigned int entry;
> +	unsigned int len;
> +	int count = 0;
> 
>  	while (count < budget) {
>  		u32 ctrl;
> @@ -1674,12 +1673,12 @@ static int gem_rx(struct macb_queue *queue, 
> struct napi_struct *napi,
>  static int macb_rx_frame(struct macb_queue *queue, struct napi_struct 
> *napi,
>  			 unsigned int first_frag, unsigned int last_frag)
>  {
> -	unsigned int len;
> -	unsigned int frag;
> +	struct macb *bp = queue->bp;
> +	struct macb_dma_desc *desc;
>  	unsigned int offset;
>  	struct sk_buff *skb;
> -	struct macb_dma_desc *desc;
> -	struct macb *bp = queue->bp;
> +	unsigned int frag;
> +	unsigned int len;
> 
>  	desc = macb_rx_desc(queue, last_frag);
>  	len = desc->ctrl & bp->rx_frm_len_mask;
> @@ -1755,9 +1754,9 @@ static int macb_rx_frame(struct macb_queue 
> *queue, struct napi_struct *napi,
> 
>  static inline void macb_init_rx_ring(struct macb_queue *queue)
>  {
> +	struct macb_dma_desc *desc = NULL;
>  	struct macb *bp = queue->bp;
>  	dma_addr_t addr;
> -	struct macb_dma_desc *desc = NULL;
>  	int i;
> 
>  	addr = queue->rx_buffers_dma;
> @@ -1776,9 +1775,9 @@ static int macb_rx(struct macb_queue *queue, 
> struct napi_struct *napi,
>  {
>  	struct macb *bp = queue->bp;
>  	bool reset_rx_queue = false;
> -	int received = 0;
> -	unsigned int tail;
>  	int first_frag = -1;
> +	unsigned int tail;
> +	int received = 0;
> 
>  	for (tail = queue->rx_tail; budget > 0; tail++) {
>  		struct macb_dma_desc *desc = macb_rx_desc(queue, tail);
> @@ -1853,8 +1852,8 @@ static int macb_rx(struct macb_queue *queue, 
> struct napi_struct *napi,
>  static bool macb_rx_pending(struct macb_queue *queue)
>  {
>  	struct macb *bp = queue->bp;
> -	unsigned int		entry;
> -	struct macb_dma_desc	*desc;
> +	struct macb_dma_desc *desc;
> +	unsigned int entry;
> 
>  	entry = macb_rx_ring_wrap(bp, queue->rx_tail);
>  	desc = macb_rx_desc(queue, entry);
> @@ -2474,10 +2473,10 @@ static netdev_tx_t macb_start_xmit(struct 
> sk_buff *skb,
>  	unsigned int q = skb_get_queue_mapping(skb);
>  	unsigned int desc_cnt, nr_frags, frag_size, f;
>  	struct macb_queue *queue = &bp->queues[q];
> +	netdev_tx_t ret = NETDEV_TX_OK;
>  	unsigned int hdrlen;
>  	unsigned long flags;
>  	bool is_lso;
> -	netdev_tx_t ret = NETDEV_TX_OK;
> 
>  	if (macb_clear_csum(skb)) {
>  		dev_kfree_skb_any(skb);

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai

