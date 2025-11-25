Return-Path: <netdev+bounces-241695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C3BC876E4
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 00:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0B677353C25
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9195F25B311;
	Tue, 25 Nov 2025 23:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="58f9Yita"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87F9232785;
	Tue, 25 Nov 2025 23:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764112226; cv=none; b=XpIxMc1op+vS9VN5rXQKPfi0fQbTkZpoJ/I6eTe2lk4AbDY+G1wbEoGr/orOt0V1Krb6bApa72lNy9TSc547LaYKxJgadpld4MDMaP8wDzChVJdhzD3tv0e9yJmDDUBHiHkONqzJRRcXJpNEyEpQh14okidYHEVTHA8HsFMRKOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764112226; c=relaxed/simple;
	bh=9WFGHRfzuZmo7ze9/bRVr8Wd8HWI+y1rHuqnuOBCqoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7gSO6j2bcCEhPMSq9on85HgD5EZQAm7n9QgCIZWSPF69To5ykiDfKMFbP2OJiArJvtYdAD4WX1e5eSxLmxRbzHAr3siGyt4qr2WMxiAhZXAyhxfUAjpJxyIdFNk/EqkJpz1qkhnDIU1wHoQAfOhyfBEnFOHxBaRCJz2fJf4Bjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=58f9Yita; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YyFiofBQtrUHgNXy41+0qvqylDe4aR1wSaSVgEZxals=; b=58f9YitaFkn4NTOcmfMjHfaeyX
	sKLMUFxNDEcgYrlEf7KhWh8DBMaTVLMdoSVAFzf4wB8Q8O2U5NspOvfvhjoY+qDs0fo0IdCpTKJIF
	IG4rMrOyAr7VM0gvtmMwNsoiLuLTfB3mx+denZLZq9zWOjr+Kj7zP6KiK1IYz8/NvEfY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vO2An-00F4mC-AW; Wed, 26 Nov 2025 00:10:13 +0100
Date: Wed, 26 Nov 2025 00:10:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/1] net: mdio: remove redundant fwnode cleanup
Message-ID: <8adc81c3-7f61-4148-9ec6-ef69d0988b4b@lunn.ch>
References: <00847693daa8f7c8ff5dfa19dd35fc712fa4e2b5.1763995734.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00847693daa8f7c8ff5dfa19dd35fc712fa4e2b5.1763995734.git.buday.csaba@prolan.hu>

On Mon, Nov 24, 2025 at 03:50:44PM +0100, Buday Csaba wrote:
> Remove redundant fwnode cleanup in of_mdiobus_register_device()
> and xpcs_plat_init_dev().
> 
> mdio_device_free() eventually calls mdio_device_release(),
> which already performs fwnode_handle_put(), making the manual
> cleanup unnecessary.
> 
> Combine fwnode_handle_get() with device_set_node() in
> of_mdiobus_register_device() for clarity.
> 
> Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

