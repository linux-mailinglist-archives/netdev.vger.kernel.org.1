Return-Path: <netdev+bounces-88882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BB38A8EAE
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 00:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69F61F21EAF
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 22:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F9B80C14;
	Wed, 17 Apr 2024 22:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xPEFXTuI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989D72134B
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713391353; cv=none; b=pnrhoxwsIkt8eNQMfcy1Ku8uabKBseykLdzplIrWw9mNg/FTfqeGeA/ocVB9CqbyjIvVfbZENQi5veJo4sdz6QZqb1nUC7R7rLxcZL1PjvAHpSLC5TjEdOxX7zABM/iyXB395X3xOd2feB+VzLHyFC86uq8PzXUhtFIQiVItLPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713391353; c=relaxed/simple;
	bh=bu/4b1nQG3qd7NnohD+IUmostsLLwiF7mNvCYpEgIOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LU9dUsKiH/86wLXtcl5S6ZPMKYOG786DoJT7t/wpYyMjWe1o9f/ZidiOfxORtsk7CM4by3To2s6yRhXapWbkGPI5KrluV95FVvouDyrCcwPm8Eocs9p/s12ZAOznlywNwmxKlCzonQpb3GPJvtxdM8z+j9hr8b5MA+0SDm/cygU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xPEFXTuI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cqmTA1cGqmgQqHvwJfyXslc2g9QSnVyqWYInuUH3HjY=; b=xPEFXTuIOuDl00Ny9ipguf+6+o
	Hwwb60Ba0n5kjppOW/e/4suyP0Hw1hZISGWY4NMPM32OWZb9XUv9mrSUI4f0JZMNdM7bT/kdwGFt2
	fAL/qrU0SlcXIS/WvxGc9y7/8WBFLd+mY/F9XPlT8UMaICdIm3odKKltziP4KvaKXVSU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rxDMH-00DHpT-Aj; Thu, 18 Apr 2024 00:02:25 +0200
Date: Thu, 18 Apr 2024 00:02:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: SIMON BABY <simonkbaby@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: support needed for DSA (macb driver with marvel 6390)
Message-ID: <891684f3-9f23-49fe-bdbd-650a539c5321@lunn.ch>
References: <CAEFUPH3dvgvS27UDF+XHZcZbo6YSuHuo6bZeydFq740KmAD04g@mail.gmail.com>
 <CAEFUPH3o2A0uKwb4Om=gRJ5snKxS6AGBjEnFaPmm2bTUXiHN9Q@mail.gmail.com>
 <CAEFUPH1PYfECian1KAmMW=neEVtEQCeLkbZuXV2ZvY6HWH8dFg@mail.gmail.com>
 <CAEFUPH1iE27OabKiFqj7iKmpzBNpn--kUyHwsXtK5OA8q=uOnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEFUPH1iE27OabKiFqj7iKmpzBNpn--kUyHwsXtK5OA8q=uOnQ@mail.gmail.com>

> => mdio write 0xe2800034 0x58029800
> => mdio write 0xe2800034 0x68060000
> => mdio read 0xe2800034
> Reading from bus ethernet@e2800000
> PHY at address 0:
> -494927820 - 0xffff

That does not look like valid usage of the commands:

https://github.com/u-boot/u-boot/blob/master/cmd/mdio.c#L317

	Andrew

