Return-Path: <netdev+bounces-289997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EP5hF0bVDWrW3wUAu9opvQ
	(envelope-from <netdev+bounces-289997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:37:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AA45910AC
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3440A30E6EB6
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688843F4124;
	Wed, 20 May 2026 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="t4lJ0fky"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D49D3F2101;
	Wed, 20 May 2026 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290860; cv=none; b=fqUOZIYuSAQsrvob7kb8yi+vghOaF+oN+PaWbXDo6Dhf7LyGd7NtkV8pvFGxXNp8BQaLRDDex/y+kUhUzhD/KLhYooimDvqm8kYucvCQpnlcUrKYk7T0EJxjGHy7oBTHlGbWvUIiNKqcPO9SGctMU3rFEo31mjslJ/tCg4Flzvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290860; c=relaxed/simple;
	bh=/dicLWyiTLIqJjMDqVvLE8H2Gl4zdK09ndu9K0HRk/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iyi6dutbvBWUxcOjwKm3Y6ifoLDuBpRht+x+kLQwJdo+RlQDBIsNoRpI2utPmpSC4zl7TcsfBbYQPsf/NIshqJXbVfanLroZ7tNg2IYDJkbI/rtvFxIkKaNk9erh+4PSPpIwZUj3l2Jgk1LanQ4evEi4qJYdqQbfo9jyxVzlZxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=t4lJ0fky; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JQPeBgT0x9f1XP/QHtccMLVQq0iA+4UUdcKuFEPxVD8=; b=t4lJ0fkyVyt32Heo44vAc5XaPm
	tpjHmCfftDGnV0rv5zSDtHevhfxIPkn9+UtOKgFpzmsjhFoZW+KTy23OO+zT6hVOm9vy4ZF/1G0dx
	fDJhlw+wNunGt8ZjFeU9cA0AcECVJAaAVsnVKbN71WNvNKZ3iLWLHSTSrI235cm3OsOo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPipW-003r3S-Nc; Wed, 20 May 2026 17:27:30 +0200
Date: Wed, 20 May 2026 17:27:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ciprian Regus <ciprian.regus@analog.com>
Cc: selvamani.rajagopal@onsemi.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, parthiban.veerasooran@microchip.com
Subject: Re: [PATCH net 1/2] net: ethernet: oa_tc6: Interrupt is active low,
 level triggered.
Message-ID: <d17d1c7f-5fd6-41de-b935-83f96acde6d0@lunn.ch>
References: <CY8PR02MB9249D2392242AF27988B9C0583042@CY8PR02MB9249.namprd02.prod.outlook.com>
 <20260520151621.405125-1-ciprian.regus@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520151621.405125-1-ciprian.regus@analog.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289997-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: E9AA45910AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 06:16:21PM +0300, Ciprian Regus wrote:
> >        ret = devm_request_irq(&tc6->spi->dev, tc6->spi->irq, oa_tc6_macphy_isr,
> >-                              IRQF_TRIGGER_FALLING, dev_name(&tc6->spi->dev),
> >+                              IRQF_TRIGGER_LOW, dev_name(&tc6->spi->dev),
> >                               tc6);
> 
> oa_tc6_macphy_isr() doesn't clear the interrupt condition

Since this is an SPI device, there is no way it can clear the
condition, that needs a blocking operation.

> devm_request_threaded_irq(..., IRQF_TRIGGER_LOW | IRQF_ONESHOT, ...)
> 
> (together with some rework to call oa_tc6_try_spi_transfer() from the
> threaded irq part).

Threaded makes sense. Not so sure about ONESHOT. We need it to fire
again when the thread handler exists and the condition is still true.

      Andrew

