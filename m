Return-Path: <netdev+bounces-238345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5491CC57AA7
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 14:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E6E4A1162
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4AE351FC1;
	Thu, 13 Nov 2025 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R4jJCC3A"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF7C3BB40;
	Thu, 13 Nov 2025 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039430; cv=none; b=EudYj6xVg7ORtC9s1ItSHZJ9yEA5/GOCF+QGPROjrC85AoVeS58jZXiT/2TzpYloUhttnPKdDf7jN279r4u71CWagYXBYEowzsmGf+DOBbv+y/ZfUuTI5N30o0fkSNaOlolUIgSglueGpXq3MZfG0D1MJ9L8wIsdUzqlMCdaN7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039430; c=relaxed/simple;
	bh=5oOe1a4PbomAK6yVAsa9nA3xwjD2FdDgO97kL0K8LI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsGFe7196AnT00QGCx71KmkN5DtmNWdnXz43eNbY+s4sps3gw6iVJ80nUEb224FB0F4QcMK5TJy4F7LC3RvJGx3tlthSPDpJ0bWzSLNk1RoZ2QOh2Ng72p3c+RlX7h2K0Vg+L8580hFlYJTXtRiru3MEJmB9jPs00y9ramHTGLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=R4jJCC3A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9Bt+rsMKlH39POr8mMm4yPrVUrElP+dkqHGXrTU3Za4=; b=R4jJCC3AXXxejvPWBxKCZ/Z0Yh
	c4Pjxx80ZOmzLS1RfCF9cZq1fEgP/OMs1/PMOR3CDQOsuf4vH6vHPgWtI1BPvvsAvg+LJQJ+qPnV+
	lR/5kBvD8GhkPC219K4/h4MkScO9lWA8hSUClDMo2Ob3UJwartgcXSx6NpzbPC5OcYYE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vJX5f-00DrZU-SR; Thu, 13 Nov 2025 14:10:19 +0100
Date: Thu, 13 Nov 2025 14:10:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"eric@nelint.com" <eric@nelint.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 4/5] net: fec: remove rx_align from
 fec_enet_private
Message-ID: <808e68e6-ba0e-4a2d-8b20-8555f53c586f@lunn.ch>
References: <20251111100057.2660101-1-wei.fang@nxp.com>
 <20251111100057.2660101-5-wei.fang@nxp.com>
 <116fd5af-048d-48e1-b2b8-3a42a061e02f@lunn.ch>
 <PAXPR04MB85109979C5B15727F510F87188CDA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85109979C5B15727F510F87188CDA@PAXPR04MB8510.eurprd04.prod.outlook.com>

> Sorry, I misremembered the value of XDP_PACKET_HEADROOM. it should
> be 256 bytes.
> 
> See fec_enet_alloc_rxq_buffers():
> 
> phys_addr = page_pool_get_dma_addr(page) + FEC_ENET_XDP_HEADROOM;
> bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
> 
> I will correct it in v2, thanks

So you could add a BUILD_BUG_ON() test which makes sure
FEC_ENET_XDP_HEADROOM gives you the needed alignment. That way it is
both "documented" and enforced. And it costs nothing at runtime.

	Andrew

