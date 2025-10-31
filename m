Return-Path: <netdev+bounces-234702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78426C262CA
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6AC564046
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 16:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8254B216E32;
	Fri, 31 Oct 2025 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5gs+JV2T"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D36170826
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928342; cv=none; b=iTzk9UCGFyiERdk/qRysuxGLwo4xU02xDwtNrvzbiPpsWM0nzLX5D+Zsy7JkZMxhZTd6uVQmf0FXaNbluxGEUbHLcfCH/qTRE2bF1yart4hZJF3HFuY5NtetWNJoeD/wfJ2MtlbkoYqak1b3lsyjq891t2CU62fU9fDNtE5yGXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928342; c=relaxed/simple;
	bh=7pdWxG/RDotdyA7DCg2I4I4V87d0sqAQ7wDPi3paYfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPBu74TKsS5WsJgqirf9dBM6f4WythjtedZROJ3m0XGx7ZWTdsbzB0XO701QALmijRR/PA+QIiPMaEXkwO4I2S54mtSy4rmdct9jspAmXG3zIsZ7E0mK8XdKk7RxBavOrj4wSJdJeFKxUYFNqVMMhQzDizarw+6Yk6sOKgzeCAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5gs+JV2T; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LE2gAHNJuZAnwpBapM/xpJMopdvBPc/OaCOV+/VxsAg=; b=5gs+JV2TjOMn6a3kiiEor+Gl9u
	FmWdRYrNiZvrh/e9Q+fFlnikcZCTFITriToEVPVlMLbHKxDfahx4j4FSQClvygW9AFHVDxWu+vmGB
	/Hq9aXdCCQk1k1p+wmjvi2gG7AWk5OZqBbXs5hbYSiu3kPJA6rCVYcYl/BHvA2VH/A+c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vEs2u-00CcEE-KG; Fri, 31 Oct 2025 17:32:12 +0100
Date: Fri, 31 Oct 2025 17:32:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: ansuelsmth@gmail.com, hkallweit1@gmail.com, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH net] net: mdio: Check regmap pointer returned by
 device_node_to_regmap()
Message-ID: <f1f2746c-15e1-4d97-87d2-ed2e20e56cb0@lunn.ch>
References: <20251031161607.58581-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031161607.58581-1-alok.a.tiwari@oracle.com>

On Fri, Oct 31, 2025 at 09:15:53AM -0700, Alok Tiwari wrote:
> The call to device_node_to_regmap() in airoha_mdio_probe() can return
> an ERR_PTR() if regmap initialization fails. Currently, the driver
> stores the pointer without validation, which could lead to a crash
> if it is later dereferenced.
> 
> Add an IS_ERR() check and return the corresponding error code to make
> the probe path more robust.
> 
> Fixes: 67e3ba978361 ("net: mdio: Add MDIO bus controller for Airoha AN7583")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

