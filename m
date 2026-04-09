Return-Path: <netdev+bounces-276852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPQjH8VM12lpMQgAu9opvQ
	(envelope-from <netdev+bounces-276852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 08:52:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F76A3C6B44
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 08:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42F993018C34
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 06:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824FC34BA33;
	Thu,  9 Apr 2026 06:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="rqMLF0c3"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A7934D3AC;
	Thu,  9 Apr 2026 06:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775717549; cv=none; b=ApXuTkxFKBHjW9ovVFBJMrUcr6ljv5d6AaMXU3rxu8fswDmVgXUU3miXB02LUN+Tu+afKShONbTV9CNSyuGwu6hgHj3ELy/QkeCx0me6j779GQno2P31SgWXtq/AxinmVT9V8sBXztV+RSbiiJq0rDcuYH2TSgdKDzcM3RneY5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775717549; c=relaxed/simple;
	bh=oYlOFI+G9ipoNZWPwrQ9ezesOQsMB6sUcAy2UukQwk0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=p6vDEgG7pNjiRN0ewQZT152o6+7HoHQFyqsl5NEQxcC9W24ofrhJGyl4c5EvQXjS8qBUw5sQ3M/Ou2H0HH51f5p8W9inKRiKLL+jvVh/vp/1858byC9YdlYaG4sjOPyAhKlD2EHOU3Y6+vJNVLX/E1JAS4EH9YwB26MB66LD5eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=rqMLF0c3; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 62E22A58A0;
	Thu,  9 Apr 2026 08:52:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775717534; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hbDthcgoEkrLsFRWuDut1NVJE/b6M6xIdxfGNrr05Cc=;
	b=rqMLF0c35cE2V/Kd1zORDzLhBA8lZi4ZDUb+OPUHn+uhdT/vvllo9sOjA6Wj9tJCT0iAzl
	2R5yfBVdUNuOOnEpU6sjhLk89xrIJi87jNA6gzapsBnD08RneVc2ndzMAquGZEzkFihyOj
	Hh0OLlwtK/erzrOPVB5wjIyKfkRrLaOI/zVXyJOCwJj+7iAxIEL0PxVDIoKRgC95qW2nwP
	zjNz+E+AvaCHnvVbHDOw9D20feqcCzLbHnSL52oUyl8iQDSVoW7vZqqrsFIW7i5YPfjWsS
	BJxED457IWWgmXIOTNAb/+O3dcw4kEBDs7tfGnvTtvyFgkPYBs7TBReqQlwjdw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 09 Apr 2026 08:52:11 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Ronald Wahl <ronald.wahl@raritan.com>, Yicong Hui
 <yiconghui@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [net,PATCH v2] net: ks8851: Reinstate disabling of BHs around IRQ
 handler
In-Reply-To: <20260408162535.98108-1-marex@nabladev.com>
References: <20260408162535.98108-1-marex@nabladev.com>
Message-ID: <6391ee36b7d9c66d33c734650ebfb7fe@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276852-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,google.com,kernel.org,redhat.com,raritan.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_DNSFAIL(0.00)[tipi-net.de : query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F76A3C6B44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Marek

On 8.4.2026 18:24, Marek Vasut wrote:

> [...]

> +	bool			no_bh_in_irq_handler;

> [...]

> +/**
> + * ks8851_irq_nobh - IRQ handler with BH disabled
> + * @irq: IRQ number
> + * @_ks: cookie
> + *
> + * Wrapper which calls ks8851_irq() with BH disabled.
> + */
> +static irqreturn_t ks8851_irq_nobh(int irq, void *_ks)
> +{
> +	irqreturn_t ret;
> +
> +	local_bh_disable();
> +	ret = ks8851_irq(irq, _ks);
> +	local_bh_enable();
> +
> +	return ret;
> +}
> +
>  /**
>   * ks8851_flush_tx_work - flush outstanding TX work
>   * @ks: The device state
> @@ -408,7 +426,9 @@ static int ks8851_net_open(struct net_device *dev)
>  	unsigned long flags;
>  	int ret;
> 
> -	ret = request_threaded_irq(dev->irq, NULL, ks8851_irq,
> +	ret = request_threaded_irq(dev->irq, NULL,
> +				   ks->no_bh_in_irq_handler ?
> +				   ks8851_irq_nobh : ks8851_irq,

This works, but wouldn't it be simpler to put the BH disable
into the PAR lock/unlock directly?

   static void ks8851_lock_par(...)
   {
       local_bh_disable();
       spin_lock_irqsave(&ksp->lock, *flags);
   }

   static void ks8851_unlock_par(...)
   {
       spin_unlock_irqrestore(&ksp->lock, *flags);
       local_bh_enable();
   }

No flag, no wrapper, no conditional in request_threaded_irq.
And it protects all PAR lock/unlock callsites, not just the
IRQ handler.

> [...]

Regards
Nicolai

Tested-by: Nicolai Buchwitz <nb@tipi-net.de>  # KS8851 SPI, non-RT

