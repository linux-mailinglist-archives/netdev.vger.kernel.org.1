Return-Path: <netdev+bounces-226666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD44EBA3D63
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D8E4A5944
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 13:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243FD24678F;
	Fri, 26 Sep 2025 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bAxUBVms"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F68B2F60C0;
	Fri, 26 Sep 2025 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892451; cv=none; b=D74WGLhGR5hSDprg0H2FaDnR8XXFDxKsJJFx8XpI3wN+UTWa4xaCt5SVMisOdCKkH+qyoK1RqChNewu0UjPDQr/spNvNHALZpH3NTscmKmhg3sh+bBxRsCVP3Jd5SNyc/xMqAJos5A7CEdYmcQZTkwnry5c0COdavWSUodnKhk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892451; c=relaxed/simple;
	bh=QFy5Xugv7IuXmF7OnZ3unWRPjWRRxUAInaLATPWisLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caLIVpYlbNTeqLaSkVSoYH0EsX0+ovAalMn5ypEQYmQCRAXDFZrQOuX0YyKAj0MbcBhRN5pDC0hkF2WR6nmXMBm5XikbIB+hj84IRE7antv+VvSbjpnQ9QlaVuaPoytNeBzt2VZK00m6WcQ1e3lBUFLpr0wp1PiARkcSH2S0qYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bAxUBVms; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kvU6KD7Ak/321B2u+fHBnh40uEfH4ng9JZ8nC2TDsf0=; b=bAxUBVmsN253AhMCtPQUHqMIq+
	QGk3woA5i14j6ZrLUoOzYYFzdnqQnmpMo/GKyccGGnv01zquk9TOyvQQeNGR+yVcs9l/5+ibX2SjH
	AAw+jHRo/K961zgv5jmm2OgLlSQjsgPiwYTbjpFD4GAP7k5cnPb/WbCOMeR7s8jdTMak=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v28Gt-009Z4n-OX; Fri, 26 Sep 2025 15:13:59 +0200
Date: Fri, 26 Sep 2025 15:13:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: andrew+netdev <andrew+netdev@lunn.ch>, davem <davem@davemloft.net>,
	edumazet <edumazet@google.com>, kuba <kuba@kernel.org>,
	pabeni <pabeni@redhat.com>, danishanwar <danishanwar@ti.com>,
	rogerq <rogerq@kernel.org>, pmohan <pmohan@couthit.com>,
	basharath <basharath@couthit.com>, afd <afd@ti.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>,
	srk <srk@ti.com>, rogerq <rogerq@ti.com>,
	krishna <krishna@couthit.com>, mohan <mohan@couthit.com>
Subject: Re: [PATCH net-next 0/3] RSTP SWITCH support for PRU-ICSSM Ethernet
 driver
Message-ID: <383e4a23-447e-4024-8dc9-fc52ea209025@lunn.ch>
References: <20250925141246.3433603-1-parvathi@couthit.com>
 <0080e79a-cf10-43a1-9fc5-864e2b5f5d7a@lunn.ch>
 <773982362.433508.1758892145106.JavaMail.zimbra@couthit.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <773982362.433508.1758892145106.JavaMail.zimbra@couthit.local>

> No, this patch-set applies to both STP and RSTP. The driver and firmware
> responds to the port-state transitions and FDB operations through the
> standard Linux switchdev/bridge interfaces, with no STP/RSTP related
> logic executed in driver/firmware.
> 
> We referred to RSTP in the commit message as it is our primary use case
> and it implies support for STP as well.

I would not say RSTP implied STP, because the higher level
implementation is very different. You need to know the low level
details to understand they use the same driver API.

Please generalise the commit messages, mention STP as well as RSTP.

Thanks
	Andrew

