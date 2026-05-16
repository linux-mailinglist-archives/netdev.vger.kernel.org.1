Return-Path: <netdev+bounces-288577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JZ8OMaYDCGqRVAMAu9opvQ
	(envelope-from <netdev+bounces-288577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 07:41:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 233A655A53D
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 07:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A96830125D7
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 05:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1ED3161AB;
	Sat, 16 May 2026 05:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="1QAE0D7b"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3928E2D1913;
	Sat, 16 May 2026 05:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778910114; cv=none; b=OXqdRXkBc/pD96wMHrm8CdDJGHgLzOpsxhTUu5ADURS0rvNhwtLPcfWMBV8JKugujxzhpXFemTzP2hRRyv7maLeyhGCVUG7+ACg0T/D94jD9lS9PFwS9l8x4zcP2xJLznNWxB3GhgTTIVq8x4XegQzWPRZxR1MzoyF09yGm6yIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778910114; c=relaxed/simple;
	bh=WJzd1PcwZiCHxaN5z/EFhC71qMLZlK/JY9XnalfqhmI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=MwEdN2N44HWjHZP3EkQvugbvpbPVAO8hCfsOk3b0BA6rwXnUdvyapkkwzTb/ESAmgpefPBTQizAyM2RYSjgJYmwpSHXWdQYEF1N9yzGAA+tDlIydcbqa6oyFzHWcEPDtvHWfR+QhGE1E36mOKMeTB/l3BhcviOt+9mPOMDoBucg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=1QAE0D7b; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C0C7A3A42;
	Sat, 16 May 2026 07:41:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1778910109; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sn0vD4w5rGnhC29ssAWiOKrVgaxGD18MsQSfOpiU5Zk=;
	b=1QAE0D7byiGBUR3XRU3xzWQNfe5aK/hrX18jP8A8Qp1P5oqUmEJOaKNTNn9o3TJU7ve7Id
	l23NHN5H7VIRpmLSjzdOSDhdk4PuZLZNX0AI12IzB1N+JF6EBqKvDe4qYoq/MSCRc/YUY+
	SJq0/IYUQ8lt0yBk29V0gQc36CkdBvlDC1OfSw3NihX2Z7z9TpRP9Npwzwh4oKLniNJf8Z
	5vpvhdeOVur+ZPMts0Ac5xbMXWdLRrgYIvEfd3x5LPa3ZPxCvT1tWEtuoKuVZFYu5JAm2k
	XkWe/ObHgu+zNdYjI1o2JzPNbdLAPvZbYdjBKeBIIeJSYPDqhEDvc/D7OpDMGw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 16 May 2026 07:41:47 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Tejun Heo
 <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker
 <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [RFC PATCH net-next] net: macb: Move delayed work on
 system_dfl_wq
In-Reply-To: <20260515152721.344380-1-marco.crivellari@suse.com>
References: <20260515152721.344380-1-marco.crivellari@suse.com>
Message-ID: <790e1a195d6bb5732bb061b4c5ac73a8@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 233A655A53D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-288577-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linutronix.de,suse.com,microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,redhat.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Action: no action

On 15.5.2026 17:27, Marco Crivellari wrote:
> Currently the code enqueue work items using {queue|mod}_delayed_work(),
> using system_wq, which will be deprecated soon and replaced by
> system_percpu_wq.
> 
>    commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and 
> system_dfl_wq")
> 
> The function(s) mentioned earlier, end up calling 
> __queue_delayed_work(),
> which set a global timer that could fire anywhere, enqueuing the work
> where the timer fired.
> 
> Unbound works could benefit from scheduler task placement, to optimize
> performance and power consumption.
> 
> Since the workqueue work doesn't rely on per-cpu variables, there is no
> obvious reason that justify the use of a per-cpu workqueue. So change
> system_wq with system_dfl_wq so that the work may benefit from
> scheduler task placement.
> 
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index a12aa21244e8..42328b5ca403 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -672,7 +672,7 @@ static void macb_tx_lpi_work_fn(struct work_struct 
> *work)
>  static void macb_tx_lpi_schedule(struct macb *bp)
>  {
>  	if (bp->eee_active)
> -		mod_delayed_work(system_wq, &bp->tx_lpi_work,
> +		mod_delayed_work(system_dfl_wq, &bp->tx_lpi_work,
>  				 usecs_to_jiffies(bp->tx_lpi_timer));
>  }
> 
> @@ -724,7 +724,7 @@ static int macb_mac_enable_tx_lpi(struct 
> phylink_config *config, u32 timer,
>  	/* Defer initial LPI entry by 1 second after link-up per
>  	 * IEEE 802.3az section 22.7a.
>  	 */
> -	mod_delayed_work(system_wq, &bp->tx_lpi_work, 
> msecs_to_jiffies(1000));
> +	mod_delayed_work(system_dfl_wq, &bp->tx_lpi_work, 
> msecs_to_jiffies(1000));
> 
>  	return 0;
>  }

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai

