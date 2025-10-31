Return-Path: <netdev+bounces-234646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58719C25041
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 13:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F373ACF47
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561A7348871;
	Fri, 31 Oct 2025 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Gi2elDP7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472811B142D;
	Fri, 31 Oct 2025 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913890; cv=none; b=WYiOjFFZlGNAxrjqBYnsE9WVvTVylG0j6i73ibppjgr00JZCm101Awzw9T8o2PsjpRwHnMA26Ou4PBgwRSWZvLzdsFvc5HSj+Ifc9DuM0s36nA8fxGYrwqJkz1liuBeuOr+W/djwzR04e3h+heAOJ0sx4P9VmlNCqBcKXuSI42A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913890; c=relaxed/simple;
	bh=BB5MOJGAVcdNd8OyLaHPub0S39Sbsei9GmLKIfB6kss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grySdA5NDqNsre7Z15hdopyGSqcfp3ioCjQT03vcWJmDF/5duwXNUdBphqp7D0Y6T7S8AjsuIduvvwtTNSra1oqS3pCgSc9MwTv4QxcXppCraXsASprF4gYUsBpnFKftpA+KB2jYUzYbn+yoH6tssTBJFxjVTK0xTp+JdBnbAao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Gi2elDP7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=d2FCYC7D36HFZv9IvfozZxXlDh5wK0T/QIEPgoR4o5M=; b=Gi2elDP7xLpfFTJ+Lp6A8TSr7R
	Nd6q1bXXFo7Q/7TX0kE6ZjqtqeQjMG2oy7JT+ozuGI5KFP7Iy9Oz2fbTPdIf8PczK7ldZd7bb8H3G
	l4nns1QoqSeXcychHTpjScb4ZJe92eB9m5xe23Hn/Zq6Aac/+W2oL1B6SNlQKHi3DZBc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vEoHo-00Cb4i-Cq; Fri, 31 Oct 2025 13:31:20 +0100
Date: Fri, 31 Oct 2025 13:31:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Aziz Sellami <aziz.sellami@nxp.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/3] net: enetc: add port MDIO support for both
 i.MX94 and i.MX95
Message-ID: <fef3dbdc-50e4-4388-a32e-b5ae9aaaed6d@lunn.ch>
References: <20251030091538.581541-1-wei.fang@nxp.com>
 <f6db67ec-9eb0-4730-af18-31214afe2e09@lunn.ch>
 <PAXPR04MB8510744BB954BB245FA7A4A088F8A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510744BB954BB245FA7A4A088F8A@PAXPR04MB8510.eurprd04.prod.outlook.com>

> What we get from the DT is the external PHY address, just like the mdio
> driver, this external PHY address based on the board, ENETC needs to
> know its external PHY address so that its port MIDO can work properly.

So i don't get this. MDIO is just a bus, two lines. It can have up to
32 devices on it. The bus master should not need to have any idea what
devices are on it, it just twiddles the lines as requested.

Why does it need to know the external PHY address? In general, the
only thing which needs to know the PHY address is phylib.

	Andrew

