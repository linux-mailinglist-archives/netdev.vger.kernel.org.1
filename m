Return-Path: <netdev+bounces-195498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4445AD0864
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 21:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA013B40DA
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 19:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC491E25E1;
	Fri,  6 Jun 2025 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qPy/3hOP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379CB1D5ABA;
	Fri,  6 Jun 2025 19:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749236430; cv=none; b=KXqK6b4tYT4EMhpw4St4ND9FU15yd8ciSLtI3a6ta+LVT9l0q/c3b7mhTEPevX6hauSbER1acpWT7X1OSYnqtYC2TGKjPiRvaEPwDOFnqZ0D6sPFp6Dm+ptIQsuFnp7nbxncD/rc0ZBM46XqlYaa+pGFQ8GOa32xUsuvApuJrE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749236430; c=relaxed/simple;
	bh=5KcYOuP9Bp6AaoJ7GHk98O3XtDcUIlK36IsMsvU9YlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyPFDIMoALsPK/o7srnd+MioszMPNJ2hLwVoVnI5R9XmJUWyiFyZlsv3l4stI6GHGkBLIq5FKUF1/ONq1+pWU0jyLONAmi5NRvM7uER+P06QJ9eRo7yuOsqAB5wx5eczj2APH4DIAoktIs+n5W+PxSILcdfCnLyxfUMYOyeOhmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qPy/3hOP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qVdfQHxOR4Lbp77RPtgpucjvQYLMZtLojILsgf+H/8M=; b=qPy/3hOPPe0qm/j1t/HvUP3tKC
	Zhqcjg/r+Ocu3Y/1UrMclkOyntGdiznqhJpcE0XpG7cOSyBh4Ae/j6hvsOKk+CkY9umrvBZaWFqZi
	PdoskEUC2JvzBvFfj0UDCQ5LrTF2+N3uX/PGacMy8pL4poa+dnooDDk60fjV32k2vAN0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uNcIb-00EvRL-Qr; Fri, 06 Jun 2025 21:00:17 +0200
Date: Fri, 6 Jun 2025 21:00:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ch9200: use BIT macro for bitmask constants
Message-ID: <d4bd7daf-b7a0-4640-a888-6f5e269d69b1@lunn.ch>
References: <20250606160723.12679-1-qasdev00@gmail.com>
 <486738a4-c3ea-4af2-ba78-53bf8522ccb1@lunn.ch>
 <aEMjFjQo1QZoKEXw@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEMjFjQo1QZoKEXw@gmail.com>

> I don't, I did try to buy it but after searching for it but I couldn't
> find it anywhere. I do however have the hardware for the this:
>  
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/usb/dm9601.c
> 
> Would the phylib porting apply to this too? If so I would love to work
> on it.

Yes, please do work on that. Having the hardware makes a big
difference. And you are likely to learn a lot more with hardware you
can test with.

	Andrew


