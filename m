Return-Path: <netdev+bounces-150453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5C69EA496
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14141888F2F
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 02:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74331EB3D;
	Tue, 10 Dec 2024 02:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="enJAW2oz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10BC233129;
	Tue, 10 Dec 2024 02:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796051; cv=none; b=PrWM5RP/C2LTJ3xcF1cChS45NSxh2FT2n5dU7xuK2ILMluI+UfMbLLAixQywyGlGH6UdAo0PpMElLf02cECX7m7WkEb/uT/IB0DJesQ38eFcew5SKmClLVcnpEu2ES6QVfwMbU3a2mDFxllnjTkvQKZ3LS8Kd8B6pwxlK/Nng6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796051; c=relaxed/simple;
	bh=rGRzQZoyQfuuv92peCjVoy/oOFIWBYFMBTtRRW9g79w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jy1asmrtxkJgreEjgwXiSzq0Xfy3xBKrqhrqW4cL4fHQBSjH7nx2zAXErpw7czbSJi0O1a9WPYhtL5X9uojsqGRPE5/CgiS/FhhnUzL0Or7880JnPgnIqlOiODAN5T5GEld+D3RX93NToYapBwmdU7mQlSxBJhCryAZeuvAqyhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=enJAW2oz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=povrhvmjxZa9v1hScmFSUe8xmqpIX2xZQ2m8/B12Ksc=; b=enJAW2ozdkJu1xQ4vW+xApi4Vs
	0UYNj2LOdQwQuqMa4C+aS7rF81IcHYVTaIycC61GAnNho4TvRnWQMVq4OC+mR4czKPhqP1Ysplz3k
	y3Rx0ElXmMmRM0KQu14k3OuqedUG25EXiTugLdKQg04RBLivoZ+cT4PkAjUmc6FZYL6I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKpYI-00Fk0t-8F; Tue, 10 Dec 2024 03:00:42 +0100
Date: Tue, 10 Dec 2024 03:00:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 01/11] net: usb: lan78xx: Add error handling
 to lan78xx_setup_irq_domain
Message-ID: <037d499c-079a-4e60-874b-545eb5d1ae3d@lunn.ch>
References: <20241209130751.703182-1-o.rempel@pengutronix.de>
 <20241209130751.703182-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209130751.703182-2-o.rempel@pengutronix.de>

On Mon, Dec 09, 2024 at 02:07:41PM +0100, Oleksij Rempel wrote:
> Update `lan78xx_setup_irq_domain` to handle errors in
> `lan78xx_read_reg`.  Return the error code immediately if the read
> operation fails, ensuring proper error propagation during IRQ domain
> setup.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

