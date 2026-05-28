Return-Path: <netdev+bounces-292754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPONDg9wGGoSkAgAu9opvQ
	(envelope-from <netdev+bounces-292754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:40:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D24C95F51E9
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B4FB31F4406
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60B52580E1;
	Thu, 28 May 2026 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X3Db+92n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8E378F26
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984343; cv=none; b=d4iGF/upMrChPWfLyNryVqZx7ZghOqEY9AkWIZ8bDY4FyNIU0zV8c7bqxxQA0NGvD7AD/TSj+T5N3DuDIAcLE8RaruaMw+Ld/aNHvtfM7Y201vjTZ5plthxaVoNInvZFIhF7J1O98TWXkKzzg46qKna5qi2qchsYiIaW5/JD/WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984343; c=relaxed/simple;
	bh=OcNJUlJUzmykpLh+CmLPIUdZYxEf1DKHnayfIa0BDjE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Emup+WEZBoiVEooYJXKH958Tb8s1aFgyIJnvl9SM35EuM6CRb04dpEaC8R7zxCC1MvV0TuCIheSRIbeo0h6Y1jvWDhZ5bZoBPwFT3MJI6Lf8leX3HcdSuBLERDNK/TzJFpPel0INbjjfKpNgSbc75TEE/L4lAaeP2u11GPUipG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X3Db+92n; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so68657775e9.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 09:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779984340; x=1780589140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UMdIpYV9sY3lwrEiDRBN2/4tJkpR6wJ/JxpON8KGBwM=;
        b=X3Db+92nU7/idRWaXn134FeKxgTHegAwnLmp2e4U49RBE0AgQQ10wSk8I8fKhOL59M
         YsVvk1jQIqH7kTjEz9ZTmPQawngo8Rvtl3CiFpBO52h7lQgSTwZsJ4T7BkpOLEiOsnOh
         SnsiyRB8vPTBVC3jzmVqABI14ttIZs0AJe8eH7PqjEDrlI8yY0gpTcFLcZRzTfvfVHSR
         04sj2IGMUDqzqcpiAzq0QjdcovesT/Mex21DU9OGdnJEmF/lpk9SPXcn35sPtlqdoqOc
         rKvRu4nTT8MzO0ZuhLLiwcugNG6/KYHYqyFIsd2PJWeWVuOFqSnGBOp9l27wCOX19K1T
         g2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779984340; x=1780589140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMdIpYV9sY3lwrEiDRBN2/4tJkpR6wJ/JxpON8KGBwM=;
        b=JxG4gvCQ/08V8CpYynXY7kjqQgyNNM4S/9Vd8SAidFEHlf1enNEGLh+ddpRk69fleF
         6545eOarcNTOCscWO9HKdNF46H2TwV9npeWRFw9EdKmG2VJ/cim94ID07aoMOeko/K2M
         62X5m0FeLPbDhhdc/88s4xWYtIdy9Bl98+hZDFunCRT9d/uuOSoIJkEZ5ORUYOdPXBxq
         z7kJCbOAxTyc6arilaGCFJ5Ta0+3TcWH1y06nGbfRSNjAH9pzfCyU6REw0G/G21YiIKE
         DLeYOrTuT2LV2AeH5qZQVLDK0BnoiTVvfN7uuPTVEhFvaAvgDhE777ux19NEyGy4s4ns
         nEpA==
X-Gm-Message-State: AOJu0YxFe+p8ZLn4xr/0N0nfhnmQ28M4Kadt7N5Krjw0dy+aDLg9+yAL
	NjfybO9tjAOEtIggEHLAcr8z/DtrYJ/63qVonhb44b1mm7SdCZgHBIgajMVYgOv0r2w=
X-Gm-Gg: Acq92OEYywWL207qLl/Oh6JtLU3M/lWb58WCe1gWC0qCgrLNihjhHgVyZTNgpDa5GtD
	UlNwYaLeMQlToMm4V/7myx+55li4nsFavE4wlib/qtwrNXXp78k5kTw6rPC0aYYtyj9PyXe84a9
	L2AuXjO5bqCdm2yw5UP1oLbCvHqXbvyAgoGgaYvp5dCDJko8nnKgjX79yx31lchFgnhd5FjfsDQ
	EzU0WeqFMP5fIEWKELcBqdVNk1cN/y0P5SSpsnI+Mps5854csSFT79/8kn68R3TtT0ZxK29Rk+y
	IaHOa/929foTXXYa68MkWsq+J5MTEHo8xC00TYTICh1YCMBJnDeXeTqHvBpGng76huCI3UGl1Y+
	sdpnhg7EhcBetYavssHQYBrpugjHcDyig6ku0GknqAmBw5j2W3owgiJbbBFRerAg/dnGAN6nn3G
	43pFL+3ih8p7tlUVa97ImAXerbkjDe47c5NA==
X-Received: by 2002:a05:600c:1d0e:b0:489:1abb:5559 with SMTP id 5b1f17b1804b1-4909479e30emr27991125e9.5.1779984340104;
        Thu, 28 May 2026 09:05:40 -0700 (PDT)
Received: from localhost ([194.183.24.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5a2c87sm14475474f8f.17.2026.05.28.09.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 09:05:39 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 28 May 2026 18:08:59 +0200
To: Lukasz Raczylo <lukasz@raczylo.com>
Cc: netdev@vger.kernel.org, Theo Lebrun <theo.lebrun@bootlin.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 3/3] net: macb: add TX stall watchdog to
 recover from lost TCOMP interrupts
Message-ID: <ahhom_0PJtqnXsv5@apocalypse>
References: <cover.1777064117.git.lukasz@raczylo.com>
 <20260514215459.36109-1-lukasz@raczylo.com>
 <20260514215459.36109-4-lukasz@raczylo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514215459.36109-4-lukasz@raczylo.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292754-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D24C95F51E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Lukasz,

On 22:54 Thu 14 May     , Lukasz Raczylo wrote:
> On PCIe-attached macb instances (BCM2712 + RP1 PCIe south bridge
> on Raspberry Pi 5 is the case I have in front of me), a TCOMP
> interrupt can be lost: the TSTART doorbell can be lost in the
> posted-write fabric (addressed by an earlier patch), or the
> descriptor TX_USED DMA write can be observed late by the driver
> (also addressed earlier).  When that happens the TX ring stalls
> silently until something else kicks TSTART.
> 
> Add a per-queue delayed_work that runs once per second.  It
> detects forward progress on the TX completion path via a per-queue
> bool tx_stall_tail_moved that macb_tx_complete() sets when tx_tail
> advances and the watchdog clears on each tick.  If the ring is
> non-empty (queue->tx_head != queue->tx_tail) and the flag is
> unset when the tick runs, the watchdog calls the existing
> macb_tx_restart() to re-assert TSTART.
> 
> The bool form (rather than a tx_tail snapshot) sidesteps any
> concern about ring-index aliasing between ticks and is the form
> suggested by Phil Elwell when reviewing the same series anchored
> against rpi-6.18.y at raspberrypi/linux#7340 (merged 2026-05-08).
> 
> No new recovery logic is introduced.  macb_tx_restart() already
> exists in this file, is correctly locked (tx_ptr_lock, bp->lock),
> and verifies that the hardware's TBQP is behind the driver's head
> index before re-asserting TSTART.  On a healthy ring it is a
> no-op at the hardware level.
> 
> Cost on a healthy queue: one spin_lock_irqsave / spin_unlock and
> two field assignments per tick.  The delayed_work is only
> scheduled between macb_open() and macb_close() and is cancelled
> synchronously on close.
> 
> A netif_carrier_ok() gate at the top of the tick skips the stall
> check when there is no carrier (no completion is possible without
> a link), eliminating a boot-time false positive where queue->tx_head
> can advance from kernel-queued packets between macb_open() and link
> autoneg completion, while tx_tail stays unchanged because no TCOMPs
> have arrived yet.
> 
> netdev_warn_ratelimited() is used rather than netdev_warn_once() so
> operators can count occurrences across the lifetime of the netdev.
> 
> Link: https://github.com/cilium/cilium/issues/43198
> Link: https://bugs.launchpad.net/ubuntu/+source/linux-raspi/+bug/2133877
> Link: https://github.com/raspberrypi/linux/pull/7340
> Signed-off-by: Lukasz Raczylo <lukasz@raczylo.com>
> ---
>  drivers/net/ethernet/cadence/macb.h      | 10 ++++
>  drivers/net/ethernet/cadence/macb_main.c | 72 ++++++++++++++++++++++++
>  2 files changed, 82 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index ce9037f9e..75df0f75b 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -1282,6 +1282,16 @@ struct macb_queue {
>  	dma_addr_t		tx_ring_dma;
>  	struct work_struct	tx_error_task;
>  	bool			txubr_pending;
> +
> +	/* TX stall watchdog -- see macb_tx_stall_watchdog() in macb_main.c.
> +	 * tx_stall_tail_moved is set by macb_tx_complete() when tx_tail
> +	 * advances and cleared by the watchdog tick on each pass (both
> +	 * under tx_ptr_lock).  Using a bool sidesteps any ring-index
> +	 * aliasing concern between ticks.
> +	 */
> +	struct delayed_work	tx_stall_watchdog_work;
> +	bool			tx_stall_tail_moved;
> +
>  	struct napi_struct	napi_tx;
>  
>  	dma_addr_t		rx_ring_dma;
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index f7fa9e7ad..8245c69e1 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1473,6 +1473,8 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
>  				  packets, bytes);
>  
>  	queue->tx_tail = tail;
> +	if (packets)
> +		queue->tx_stall_tail_moved = true;
>  	if (__netif_subqueue_stopped(bp->dev, queue_index) &&
>  	    CIRC_CNT(queue->tx_head, queue->tx_tail,
>  		     bp->tx_ring_size) <= MACB_TX_WAKEUP_THRESH(bp))
> @@ -2003,6 +2005,70 @@ static int macb_tx_poll(struct napi_struct *napi, int budget)
>  	return work_done;
>  }
>  
> +#define MACB_TX_STALL_INTERVAL_MS	1000
> +
> +/*
> + * TX stall watchdog.
> + *
> + * Recovers from lost TCOMP interrupts on PCIe-attached macb
> + * instances.  macb already has a recovery chain
> + * (txubr_pending -> macb_tx_restart()) that fires on TCOMP; if
> + * TCOMP itself is lost the TX ring stalls silently until something
> + * else kicks TSTART.  This watchdog runs once per second per queue
> + * and calls macb_tx_restart() if the ring is non-empty and
> + * tx_tail has not advanced since the previous tick.
> + *
> + * Movement is tracked via the tx_stall_tail_moved boolean rather
> + * than a tx_tail snapshot, sidestepping any ring-index aliasing
> + * concern.  The bool is set by macb_tx_complete() when tx_tail
> + * advances and cleared here on each tick; both writes are under
> + * tx_ptr_lock so no atomic is required.
> + *
> + * macb_tx_restart() already checks the hardware's TBQP against
> + * the driver's head index before re-asserting TSTART, so on a
> + * healthy ring this is a no-op at the hardware level.  The
> + * watchdog only supplies the missing trigger.
> + */
> +static void macb_tx_stall_watchdog(struct work_struct *work)
> +{
> +	struct macb_queue *queue = container_of(to_delayed_work(work),
> +						struct macb_queue,
> +						tx_stall_watchdog_work);
> +	struct macb *bp = queue->bp;
> +	unsigned int cur_tail, cur_head;
> +	bool stalled = false;
> +	unsigned long flags;
> +
> +	if (!netif_running(bp->dev))
> +		return;
> +
> +	/* No carrier => no completion is possible.  Skip the check
> +	 * but keep the watchdog ticking for when carrier comes up.
> +	 */
> +	if (!netif_carrier_ok(bp->dev))
> +		goto reschedule;
> +
> +	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
> +	cur_tail = queue->tx_tail;
> +	cur_head = queue->tx_head;
> +	if (cur_head != cur_tail && !queue->tx_stall_tail_moved)
> +		stalled = true;
> +	queue->tx_stall_tail_moved = false;
> +	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
> +
> +	if (stalled) {
> +		netdev_warn_ratelimited(bp->dev,
> +					"TX stall detected on queue %u (tail=%u head=%u); re-kicking TSTART\n",
> +					(unsigned int)(queue - bp->queues),
> +					cur_tail, cur_head);
> +		macb_tx_restart(queue);
> +	}
> +
> +reschedule:
> +	schedule_delayed_work(&queue->tx_stall_watchdog_work,
> +			      msecs_to_jiffies(MACB_TX_STALL_INTERVAL_MS));
> +}
> +
>  static void macb_hresp_error_task(struct work_struct *work)
>  {
>  	struct macb *bp = from_work(bp, work, hresp_err_bh_work);
> @@ -3192,6 +3258,9 @@ static int macb_open(struct net_device *dev)
>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
>  		napi_enable(&queue->napi_rx);
>  		napi_enable(&queue->napi_tx);
> +		queue->tx_stall_tail_moved = true;
> +		schedule_delayed_work(&queue->tx_stall_watchdog_work,
> +				      msecs_to_jiffies(MACB_TX_STALL_INTERVAL_MS));
>  	}
>  
>  	macb_init_hw(bp);
> @@ -3242,6 +3311,7 @@ static int macb_close(struct net_device *dev)
>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
>  		napi_disable(&queue->napi_rx);
>  		napi_disable(&queue->napi_tx);
> +		cancel_delayed_work_sync(&queue->tx_stall_watchdog_work);
>  		netdev_tx_reset_queue(netdev_get_tx_queue(dev, q));
>  	}
>  
> @@ -4804,6 +4874,8 @@ static int macb_init_dflt(struct platform_device *pdev)
>  		}
>  
>  		INIT_WORK(&queue->tx_error_task, macb_tx_error_task);
> +		INIT_DELAYED_WORK(&queue->tx_stall_watchdog_work,
> +				  macb_tx_stall_watchdog);
>  		q++;
>  	}
>  
> -- 
> 2.54.0
>

Has this patch seen a V3 version? I guess the only thing it's needed
is something like this:

static void macb_tx_timeout(struct net_device *dev, unsigned int txqueue)
{
        struct macb *bp = netdev_priv(dev);
        macb_tx_restart(&bp->queues[txqueue]);
}

and then setting .ndo_tx_timeout = macb_tx_timeout in macb_netdev_ops.

Many thanks,
Andrea

