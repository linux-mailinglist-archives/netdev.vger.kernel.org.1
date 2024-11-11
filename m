Return-Path: <netdev+bounces-143780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A4C9C420E
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 16:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2FB285C7B
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 15:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFABD19EEC2;
	Mon, 11 Nov 2024 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IHR1jfmn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DDC19E98D;
	Mon, 11 Nov 2024 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339660; cv=none; b=MWvhI2D8y8fORWoudXBSCSNSYvZcutFKEdzunKv74FSbL/JIxut6Ral9AaHWbp1ti1YdP3sJTja/35sD/C3msqePujhR//XKbdmj2kPbrngktLq5gfFovW9T2RRHpOTEvssOg7ZrrYZYMQ8aAdzEZf2U968L2o5juvK78V6xPB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339660; c=relaxed/simple;
	bh=6wITPXEAPFLR+s1orMkNbUt0ZzpdsYV5Y+f0VjrzMmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ts1TRezsiGsaSKEij3L//OcCrBPHkfbmq4D+o/GVpu4gBy5LcA0sQXYIPWq8FDgKkHJxgbbPJ0yyy8IsZexKD6XXeUYh3X9rO9x0KNacZYmP7IcyK5E1/apprDaIS3scFu6X/20pfEBuIizpl48vppjCUPf5qJSff0ZtIoZKr1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IHR1jfmn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cFzMWki4EHCcYnaZOXl2ZzHIjHSRe9QhhQbfzvxEJ00=; b=IHR1jfmndzYyzQ4iI+KqAgh7Kd
	N1lDfBL0h3B2jOQDlN6us/26f56ray5s9uPnSf0CtlaeBLbT0jC8aGK2cIyNFntiiGcqVI2scjrVu
	0cDaAjBx5BCLqKJls3X2IgzzmJcIPVo0oLBBgTkRYoBqE7Z89OoPNKfqBR2f99SVI2pA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tAWX2-00CuSc-2Y; Mon, 11 Nov 2024 16:40:48 +0100
Date: Mon, 11 Nov 2024 16:40:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC net-next v0 2/2] net: dsa: add option for bridge port HW
 offload
Message-ID: <928411af-4cf7-4b25-9a86-2cf3a5ae6e2a@lunn.ch>
References: <20241111013218.1491641-1-aryan.srivastava@alliedtelesis.co.nz>
 <20241111013218.1491641-3-aryan.srivastava@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111013218.1491641-3-aryan.srivastava@alliedtelesis.co.nz>

On Mon, Nov 11, 2024 at 02:32:17PM +1300, Aryan Srivastava wrote:
> Currently the DSA framework will HW offload any bridge port if there is
> a driver available to support HW offloading. This may not always be the
> preferred case.
> 
> In cases where the ports on the switch chip are being used as purely L3
> interfaces, it is preferred that every packet hits the CPU. In the case
> where these ports are added to a bridge, there is a likelihood of
> packets completely bypassing the CPU and being switched.

This does not make much sense to me. If it is purely L3, you don't
need a bridge, since that is only needed for L2.

I think we need more details to understand what you really mean here.

	Andrew

