Return-Path: <netdev+bounces-273967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKYQN+PPzGlFWwYAu9opvQ
	(envelope-from <netdev+bounces-273967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:57:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3653765E5
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 381433072108
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07513932D1;
	Wed,  1 Apr 2026 07:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Z7TzvARy"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0483338B157
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775029659; cv=none; b=K372T94W7tvFD0ROrI5g3sit/PvCgyKyFnTw1zPzAUvlvbfN/RBIY7Vqw1uJ8/rBhBzaW5H+UE5RXf9P82kkY7Wcp44YwOGgsNEvq+XFw2NZWvltWY1AR10TpDA3XLLDDcfyECEQdpLuldAXPfCy0jwm1Co2YBMA4rff0dGFfG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775029659; c=relaxed/simple;
	bh=ta/b9mb9PhX7NWzYBYsjlwKw1j/ZhvuAs1Q63BONb/0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=cBAgojYq2pPU5lZ9t+tbx1hykrID2y+o6BpVe65vXyIKFjqX+kzTq7vCWYPdgeV2G42zQri1bvU3EE1SPxeENPN+qf+Squ+nK9ZaSzX9OUGDqQ/XeUviYjxG0OSmAM07CoI4dAqbac9k7TQRBGGgcw4AIfczukG9VgwYlbGOW3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Z7TzvARy; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 87B39A5860;
	Wed,  1 Apr 2026 09:47:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775029652; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TJ/onB010N86yTqr2fxvYvqXl6w6EoERbIpLsKzY7Y0=;
	b=Z7TzvARy3/IwS9VW01zvrISZWToXS/Q3FONvj6r8bJFGnqh4ZnrZUDHV1+wdhFEDEoERwF
	mzX931x97J9rE4+3j89mrlM0+7NyGAOmWWB9v1H4cBKcBJFhO+dspRHLt+MvqDt+hyvw2G
	zppFh4xgo9gVJ7judSTZeoIn+zDLbawT3fZdTfYkfXIhSWl8UgDakIpvTPg5JU7zgWJb7P
	D/Hu/y+mPWEHqNsDvem/kCp//Q5jFAv+NWio8E0yXqCtLOhwStdQUfG4TwfDfr/idex3nE
	yJ55/mlJMg/ddL5RkCcPUsRD8Rfh9WIkxQ4HpPa8DSJyzmi8MlBgwDGQWGkM5A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 01 Apr 2026 09:47:31 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, florian.fainelli@broadcom.com,
 opendmb@gmail.com
Subject: Re: [PATCH net v2 4/4] net: bcmgenet: relax the xmit ring full case
In-Reply-To: <20260401003840.3112454-5-justin.chen@broadcom.com>
References: <20260401003840.3112454-1-justin.chen@broadcom.com>
 <20260401003840.3112454-5-justin.chen@broadcom.com>
Message-ID: <71b87f5416d6d6d41396b5008702ccac@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,kernel.org,google.com,davemloft.net,lunn.ch,broadcom.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-273967-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_DNSFAIL(0.00)[tipi-net.de : query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:mid]
X-Rspamd-Queue-Id: CD3653765E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1.4.2026 02:38, Justin Chen wrote:
> We have a queue size of 32. If a packet is multiple fragments we can
> run through this queue really quickly. Currently we stop the xmit
> queue at SKB_FRAG_SIZE which by default can take up half the queue.
> Instead lets just look at the incoming packet and freeze the queue
> if the incoming packet has more fragments than free_bds. This will
> relieve some of the queue timeouts we have been seeing.
> 
> Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/genet/bcmgenet.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 54f71b1e85fc..a1aa1278842e 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -2018,10 +2018,10 @@ static int bcmgenet_tx_poll(struct napi_struct 
> *napi, int budget)
> 
>  	spin_lock(&ring->lock);
>  	work_done = __bcmgenet_tx_reclaim(ring->priv->dev, ring);
> -	if (ring->free_bds > (MAX_SKB_FRAGS + 1)) {
> -		txq = netdev_get_tx_queue(ring->priv->dev, ring->index);
> +	txq = netdev_get_tx_queue(ring->priv->dev, ring->index);
> +	if (netif_tx_queue_stopped(txq))
>  		netif_tx_wake_queue(txq);
> -	}
> +
>  	spin_unlock(&ring->lock);
> 
>  	if (work_done == 0) {
> @@ -2224,9 +2224,6 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff 
> *skb, struct net_device *dev)
> 
>  	netdev_tx_sent_queue(txq, GENET_CB(skb)->bytes_sent);
> 
> -	if (ring->free_bds <= (MAX_SKB_FRAGS + 1))
> -		netif_tx_stop_queue(txq);
> -

With this removed, the only queue stop is the NETDEV_TX_BUSY path at
entry. That means every ring-full hits BUSY and requeues rather than
stopping proactively on the previous transmit.

Would it work to keep the proactive stop but base it on the actual
packet size instead of MAX_SKB_FRAGS?

	if (ring->free_bds <= (nr_frags + 1))
		netif_tx_stop_queue(txq);

That avoids reserving half the ring for the worst case while still
preventing BUSY from becoming the normal path.

>  	if (!netdev_xmit_more() || netif_xmit_stopped(txq))
>  		/* Packets are ready, update producer index */
>  		bcmgenet_tdma_ring_writel(priv, ring->index,

This wakes unconditionally even if only 1 BD was reclaimed. Combined
with the above, it can create a tight stop/wake/BUSY thrash when the
ring is near-full.

Thanks

Nicolai

