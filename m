Return-Path: <netdev+bounces-214165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7020DB28654
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 21:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C478B6326D
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680C9220F22;
	Fri, 15 Aug 2025 19:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DzgDTcAF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C973275846
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285813; cv=none; b=bIDRgLZOAN94V8fm1hEXdtaIZbybqoSJ06xmzYR5jWfdwi5y4oQsmVGGOkrl1d30Nnw6B0P4teiFwPtvkNR+gJOH/9JRlI2DRXJRYyXVXkpyJLvbALMYyzFyM4JUgAGKWxa6jGtrXANil/eC1R2cuuoMmIWqpaaaXwsykT3o8DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285813; c=relaxed/simple;
	bh=hPBnPUn+o8/Zf0E4ReAbSiAeLrNLmk2kXFpVZ02Um9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B84uZlfE6tYepyIq6bH7x1t1Xc+fWjy4x44vegVKATUjChk3Lrpz/xl/xg9pddw2U/hEnTnIsiqibwrWpmPd9BMXhM57Baaw8C7FZe9AOBbT1KBEIjtHfeIeFqg6p+vWZ2X+Uw8prveU5CCO8gD7z6Rl8ZdshCTW0lDePe6ElHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DzgDTcAF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=VuX52Da5UFxUO+eNGpzO/LSOz8OXUxwYC9ifnmgM2Zs=; b=Dz
	gDTcAFwdvUV/iAA/MVqv26pEavmqjdyv3Dld5oI+iYswiOyiLehRC1kB2FuUP1A+h2KMYmueu2p0D
	BIqHwCHbVgkhibnG1oVuI6h7EetmjRvOFkQAhJ9JmOkWbGeZDeIe3KI/051pbbhFO3S46K7+HJbo2
	3JrYA2+oITpKKlA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1un01P-004rAF-00; Fri, 15 Aug 2025 21:23:27 +0200
Date: Fri, 15 Aug 2025 21:23:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Guilherme Novaes Lima <acc.guilhermenl@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Seeking guidance on Rust porting for network driver as a
 learning project
Message-ID: <a47f7bd8-57fc-4255-9329-6b4129ce8d36@lunn.ch>
References: <355E9163-9274-49C3-98AB-7354B9C091B7@gmail.com>
 <e59430e9-ed20-4358-bddf-fa5bf6f0d0da@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e59430e9-ed20-4358-bddf-fa5bf6f0d0da@lunn.ch>

On Fri, Aug 15, 2025 at 09:10:34PM +0200, Andrew Lunn wrote:
> > If there are any maintainers or experienced folks willing to offer
> > guidance or suggest a suitable driver for this kind of project, I’d
> > be very grateful.
> 
> The problem is, network devices make use of a very large number of
> APIs into core Linux. It is hard to write a Rust networking driver
> until there are rust bindings for all these APIs.
> 
> To stand any chance of writing a networking driver in Rust, you need
> to find a really simple device. How far has Rust got with I2C or SPI?
> Is it possible to write a simple Rust I2C or SPI client driver? If so,
> maybe look for an I2C or SPI network device which is currently
> unsupported. That will simplify things a lot.
> 
> Or maybe see if you can find a USB Ethernet dongle which is currently
> unsupported, that would make use of usbnet to provide most of the
> code. You then need a Rust binding onto usbnet, plus a number of other
> Rust bindings onto anything else needed.

Another idea might be an Ethernet switch which is not supported by DSA
at the moment. Such drivers tend to only call a few APIs. You need to
be able to read/write registers in the switch, which is generally
MDIO, SPI, or I2C. And you need to implement a subset of struct
dsa_switch_ops. DSA switch drivers don't actually handle frames, which
makes them a lot simpler in terms of Rust bindings.

	Andrew

