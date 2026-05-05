Return-Path: <netdev+bounces-284390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M83K4Hu+WlqFQMAu9opvQ
	(envelope-from <netdev+bounces-284390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:20:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEA64CE55E
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D8C930B85ED
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C6B47A0C7;
	Tue,  5 May 2026 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EY5O1JZ0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94094436372
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986861; cv=none; b=XCOMIx5xbUJpirtO9ftIPrBsUmpePXl2ZBDaRjjPFqYBBjxLvJURiddyUqzFq1RPJgoktWYbJfGqMsRhkbIYTmL020YPX9Gm6NhW4UWORmFI+PLF94U4uZm/1RTav47p4ej+dzoS2Mjvw+qbQuJW1gvzvd1VPC1si2e6gevCNEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986861; c=relaxed/simple;
	bh=q28iWBuu6TPcU54v8k5R72S0oXL9TmtHnN5OMgn5yFg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFqr74li2LvVyF95sHx0b0Lk7WA+aYm28yFgcFxomTg8RKD4dIDt5AfCua9HVZJuK3HA/vdJaz1rZhdlV1/rwIUua33r4cN1toeyR7FPiRJsuqSCIOODc/sctsMsyIyyNfR8mrGg6MsS5JLqOyE7pPe1R/YZd+qQ3BKFqCu2TR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EY5O1JZ0; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43fe608cb92so3112037f8f.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 06:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777986858; x=1778591658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=00Gzf353kwdb1ZwQdVZ5r/R1yScWtg1pxdKWd+hUbQI=;
        b=EY5O1JZ0AxJyOflmP6TW9SlKGaicce7fpPKTDUvDYIqYGabzD1QgPul+5f4x12w31s
         ECiWrjyBOPtkaxNB4DrSmnXgzQG2UHJd4Rl5LxBJ3OwzUNOuy+ui4+o8crDVTebSEUlK
         wXaArfJ4jbZ1eFZQd3hf3eS/IIqm9gSapZOH+qFWihI/VnJ4T1tmNHZaEkU1xcqRjgZW
         xF6oHUZLSMj4Ehpkxb9HrwnPEbR66vUEZh/T+TpBET032TCuczJGMp/pa98RwcXr2qnF
         pUlSkzIMpB9N+cEsyRbWgo3X1UJ/W/aXv1pYM9zwDFFzbbZiGrW4yPEzkQ54kszeYdrM
         kvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777986858; x=1778591658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00Gzf353kwdb1ZwQdVZ5r/R1yScWtg1pxdKWd+hUbQI=;
        b=c87ebk3OrE6mBiCNgskOMO9vYKeaMwkj1uHZ4c4tbPIIv/2rUjpwNuR1pW/awsWmN7
         CB5wJCGEsmN+Qi75sT6wefg9vOqQdVSSeHSnbuDibuc7qHHgMr74WZkE317lWlf0V2/z
         hk2gnaV76qUjztaUQ/jruEuc2ouvuYIt/NCBeM3wgO4pMh6+IvrZVqlNm/TAY9QTutAY
         pPmGVZbPGBXb1xfXfCep4bdRszNosqgCBI93k+g8u4z/Dqw2uhUOXFa2BugX62cCcgm8
         ho8Mf36osQME074la/p91LrlS+kiLjvsB9KEsOP/9psvKutG2SYVEyBKgR8Rc3ifSOs8
         z1BA==
X-Gm-Message-State: AOJu0YzObzLqdZ8uid00ywV6chwv2hqW2fCNZR9XFBJULeUca9W+thvm
	z7ek9ZRs8GVqIssr83hLeF2/GhB2UWljuc90CtHtJhlwqUgEAS1P1pRDSja2o7J8iaQG/Q3u+pw
	tGsHppVc=
X-Gm-Gg: AeBDieuClxvABRfaenyHpVzCHRWbdz56k/c45SFXfd2MUC3f0e0fR6enJImrZyVIYfF
	dMEV2EW9CGTQ6ZCthBnuEz/W223mmoBWy3mncVYogwSgwol4Y+o2gSuUXo/A0ICQqKL7rI3NXwj
	VxuIe+HKF9grGHpbOBIBqaVxZMLFdG8sEjcbfF8KplR+OD2d164789bX4FO9V3FI9G6yr3L86+o
	FpFdBrDGf5V2WU1WMEKt2N99a29E6KAMgnRnSgdU0lbjIplnYpDSOkJOhxsKrtJjpbjX3uMu/PS
	LE/2EsDBbwoeGyIviYoHrRknGZ0x8MBTDp5kF3IF5UNdscoXAuUmmN8h0mKGmaFCFyybMp2Wj8N
	CkHboQmip9diugKUvrZrt/FnQW+Ocxf2eNZdxu0Oi1J56A/j9BNqrcHmddQiqtJnvs27aQ/Pn81
	n4wIkMhZ+fJG3hSk+20BvgpsBIO3CSwo4j8QAw25GVp4uHkJjLEIaSw0E1dcNJy2kRtZwxVsYb5
	41PVIc=
X-Received: by 2002:a05:6000:2911:b0:441:3144:efc5 with SMTP id ffacd0b85a97d-44bb67cf042mr24716352f8f.42.1777986857973;
        Tue, 05 May 2026 06:14:17 -0700 (PDT)
Received: from localhost (host-79-47-155-212.retail.telecomitalia.it. [79.47.155.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960902sm4932144f8f.28.2026.05.05.06.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:14:17 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Tue, 5 May 2026 15:17:33 +0200
To: Lukasz Raczylo <lukasz@raczylo.com>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org
Subject: Re: [RFC PATCH net-next 1/3] net: macb: flush PCIe posted write
 after TSTART doorbell
Message-ID: <afnt7Txq23RafQUF@apocalypse>
References: <cover.1777064117.git.lukasz@raczylo.com>
 <3106d546d494f2f52ec832e7f7d04f534286e254.1777064117.git.lukasz@raczylo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3106d546d494f2f52ec832e7f7d04f534286e254.1777064117.git.lukasz@raczylo.com>
X-Rspamd-Queue-Id: DEEA64CE55E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284390-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,launchpad.net:url,raczylo.com:email]

Hi Lukasz,

On 23:38 Fri 24 Apr     , Lukasz Raczylo wrote:
> macb_start_xmit() and macb_tx_restart() kick transmission by
> OR-ing MACB_BIT(TSTART) into NCR.  On PCIe-attached macb instances
> (BCM2712 + RP1 PCIe south bridge on Raspberry Pi 5 is the setup we
> have in front of us), writes to NCR are posted PCIe writes: they
> are not guaranteed to reach the device before the issuing CPU
> returns.  If the TSTART doorbell does not reach the MAC, no TX
> begins, no TCOMP completion arrives, and the ring remains
> quiescent without any kernel-visible indication.
> 
> Note that the raspberrypi/linux vendor fork carries a local patch
> around the TSTART site (a queue->tx_pending breadcrumb that is
> promoted to queue->txubr_pending by the next TCOMP interrupt,
> triggering macb_tx_restart()).  That workaround makes the loss
> recoverable under traffic, but it cannot help if TCOMP itself is
> not raised because no TX started -- which is exactly the case we
> are targeting here.  The handshake is not present in mainline.
> 
> Add a read-back of NCR after each TSTART write in macb_start_xmit()
> and macb_tx_restart().  The read is an architected PCIe read
> barrier for earlier posted writes on the same path; it ensures the
> doorbell has reached the MAC before the functions return.
> 
> We do not yet have direct hardware evidence that TSTART is being
> lost on the RP1 path (that would require a PCIe protocol analyser,
> or at minimum a before/after counter on queue->tx_stall_last_tail
> with and without this patch applied in isolation).  This patch is
> one of a three-patch series ("candidate fixes for silent TX stall
> on BCM2712/RP1"); see the cover letter for context.  We have
> verified the series compiles and applies cleanly against mainline
> HEAD and against raspberrypi/linux rpi-6.18.y @ f2f68e79f16f;
> runtime verification is pending.
> 
> Link: https://github.com/cilium/cilium/issues/43198
> Link: https://bugs.launchpad.net/ubuntu/+source/linux-raspi/+bug/2133877
> Signed-off-by: Lukasz Raczylo <lukasz@raczylo.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index a12aa2124..b6cca55ad 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1922,6 +1922,13 @@ static void macb_tx_restart(struct macb_queue *queue)
>  
>  	spin_lock(&bp->lock);
>  	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
> +	/*
> +	 * Flush the PCIe posted-write queue so the TSTART doorbell
> +	 * reliably reaches the MAC.  Without this, the write can sit
> +	 * in the fabric and the MAC never advances, causing a silent
> +	 * TX stall.
> +	 */
> +	(void)macb_readl(bp, NCR);

Do you expect it to be a temporal issue (in the comment you stated that the write should be delivered
before the function returns) or is it just a dropped packet error? In the former case can you please
explain why? If it's the latter, I'd expect the dropped packet to increment the counter in the AER,
and I'm pretty sure it didn't when I performed my tests.

Many thanks,
Andrea

>  	spin_unlock(&bp->lock);
>  
>  out_tx_ptr_unlock:
> @@ -2560,6 +2567,11 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	spin_lock(&bp->lock);
>  	macb_tx_lpi_wake(bp);
>  	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
> +	/*
> +	 * Flush the PCIe posted-write queue; see the comment in
> +	 * macb_tx_restart() for the reasoning.
> +	 */
> +	(void)macb_readl(bp, NCR);
>  	spin_unlock(&bp->lock);
>  
>  	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1)
> -- 
> 2.53.0
> 

