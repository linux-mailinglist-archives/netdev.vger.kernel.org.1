Return-Path: <netdev+bounces-97347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BF78CAEFC
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 15:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582871C218D2
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 13:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B28770F1;
	Tue, 21 May 2024 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oJVH025p"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430862F5B;
	Tue, 21 May 2024 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296871; cv=none; b=cLd4X+6ftz6X0PamaaQdmzE5vnd37QMcdKg6Adq9AH/eTDygcHovfLlk8zACyMjdkbaBlwnGyouUrlO5hKoIqoxh47DyTLxLj4HW8cCI5SAeTv4XINRR3hrMxJhPlvMBQ5T9hjnTTEveXToT92KIT/4ur5dmfAKHFMMgkQI0E+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296871; c=relaxed/simple;
	bh=0r2A/v5zTLGjt/RcEPdSyLJqs1OI5TzLsZItAT64RbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uovEL2ZQTpbs89R8ZfyCx+CDfDDxbzswXzoyeqGRlLL04nNAIYm/5/jYB8DXamHHLEIsZ55e3KA5AZ6XTDpRMA8Om73lCjN21osg50s3MkoUcmw8Xny48GWkAsbSXtM9Lo++PTYjuvwfGi0Atf4CLMEZMy69ZzhI39LiU02hx64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oJVH025p; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3KgJPyI97V1XLw0zpYFO1oZq2MkLIkhIRp0FEGTpZBA=; b=oJVH025pAQT0RkiLtpNrQZ1+9u
	cywTqk37o2uuwJYoLlW21CCtQd+ksuGpH5iT1M7aMHO4ms6WqqNyx3ElPpfv5+X9eIV9KpJi66htl
	ZUsqBPEfIx8h2YqypRKHhHv9+UNcHnOYuswu8gD5Ct1MZhHzlZhRbW+tAe9sA7NkSzSc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s9PDQ-00FlD2-6J; Tue, 21 May 2024 15:07:40 +0200
Date: Tue, 21 May 2024 15:07:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, rogerq@kernel.org,
	danishanwar@ti.com, vladimir.oltean@nxp.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, vigneshr@ti.com,
	misael.lopez@ti.com, srk@ti.com
Subject: Re: [RFC PATCH net-next 01/28] docs: networking: ti: add driver doc
 for CPSW Proxy Client
Message-ID: <e99109c0-b0b4-43db-a7c7-dedb5753aaf9@lunn.ch>
References: <20240518124234.2671651-1-s-vadapalli@ti.com>
 <20240518124234.2671651-2-s-vadapalli@ti.com>
 <642c8217-49fe-4c54-8d62-9550202c02c9@lunn.ch>
 <0b0c1b07-756e-439e-bfc5-53824fd2a61c@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b0c1b07-756e-439e-bfc5-53824fd2a61c@ti.com>

> Andrew,
> 
> Thank you for reviewing the patch and sharing your feedback. While I
> have come across other Switch Designs / Architecture, I am yet to go
> through the one you have mentioned below. I will go through it in detail
> and will follow up with my understanding in a future reply. This reply
> is intended to be an acknowledgment that I have read your feedback.
> I also wanted to clarify the use-case which this series targets. The
> requirements of the use-case are:
> 1. Independent Ethernet Switch functionality: Switch operation and
> configuration when Linux is not functional (Fast startup, Low Power
> Mode, Safety use-cases).
> 2. Dynamic Ethernet Switch configuration changes performed based on the
> applications which run on various cores.

Please make sure these requirements are clearly stated in the design.

The support for switches in Linux has initially come from big data
centre switches, and smaller SOHO switches you found in OpenWRT class
devices. The switchdev model has worked well so far for these use
cases. However, i do understand you have additional requirements.

Ideally we want to extend the existing model to support additional use
cases, not create a second parallel model. And we want a vendor
agnostic extensions of the switchdev model, something which all
automotive vendors can use, and non-automotive systems which have a
similar architecture.

	Andrew

