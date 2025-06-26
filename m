Return-Path: <netdev+bounces-201504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1414AE9950
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125BF189BE69
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CB4295D96;
	Thu, 26 Jun 2025 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="O1RiN5oE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CE62877E2;
	Thu, 26 Jun 2025 08:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750928369; cv=none; b=EtBYmRuzNzuw9KYMH0o+GNRHY8x9n+WEfNib44jyxzlYpOr8eLmoARp7mh7PDp0stkX37pV3WFOLeNWrVProTEStJ/4RMSanuB4qv9sDQRuA41eWs9QlKSlGb+oCZa8p8RPBpjjp1d54XXeHCmhcvbRK5sMdAp9xwu1REMXLxMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750928369; c=relaxed/simple;
	bh=UZyC//Zur0wxTN4s368OZ/a2eZQvDDDVt+WdXVio6ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFvtXNyIQSG4B87q4H3bPCcEA6X6XyC8yaGQFiySqN3uE9tcv2v8wepQ2z4mkXbCfCJXqQeGFkKDypoupVqPx0yVzBc5X93VHjrCfx/2Zz3BrrGNMHLSCqrW9ZAejcVGHCvf3B6n7YzpRaKdj7UdVBQGF1bcKWNyGq/2KA3nW6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=O1RiN5oE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8VawFUixkHnSJmGNCGpBOVPOUv/TJd/cOow2tp10MGQ=; b=O1RiN5oEaSsxBnLWa8pS7py4U4
	l3rM/+lk5UFDbid+Q2VZ46JoDsOp58pc+2SO1KAVLC4VWe38cw7QfGQEInWW5R8i/GUmkK1yxwNSS
	ZNvZXlZvKCY//Feaxt1vRx/NOcOnYGHwBsBCzN2aipMq4eDvxtYRUx4WDGbEaY18e/d4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uUiS5-00H1iX-AK; Thu, 26 Jun 2025 10:59:25 +0200
Date: Thu, 26 Jun 2025 10:59:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Wei Fang <wei.fang@nxp.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: fec: allow disable coalescing
Message-ID: <551d7f29-d791-4703-8ce9-dec5baadd383@lunn.ch>
References: <20250625-fec_deactivate_coalescing-v1-1-57a1e41a45d3@pengutronix.de>
 <PAXPR04MB8510C17E1980D456FD9F094F887AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <d60808b3-eb20-40ab-b952-d9cd8d8d68a7@lunn.ch>
 <f2647407-3de0-4afd-bc79-5b58e13f10aa@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2647407-3de0-4afd-bc79-5b58e13f10aa@pengutronix.de>

On Thu, Jun 26, 2025 at 10:33:51AM +0200, Jonas Rebmann wrote:
> Hi Andrew,
> 
> On 2025-06-26 10:12, Andrew Lunn wrote:
> > On Thu, Jun 26, 2025 at 02:36:37AM +0000, Wei Fang wrote:
> > > > 
> > > > -       /* Must be greater than zero to avoid unpredictable behavior */
> > > > -       if (!fep->rx_time_itr || !fep->rx_pkts_itr ||
> > > > -           !fep->tx_time_itr || !fep->tx_pkts_itr)
> > > > -               return;
> > 
> > Hi Wei
> > 
> > When i see a comment like this being removed, i wounder if there is
> > any danger of side effects? Do you know what is being done here is
> > actually safe, for all the different versions of the FEC which support
> > coalescence?
> 
> For reference, this comment is taken in plain from section 11.6.4.1.16.3
> in the i.MX 8M Plus Applications Processor Reference Manual (and is the
> same for the 6UL).
> 
> I was also worried about this so I made sure that in any case where
> either of those is zero, the coalescing enable bit (FEC_ITR_EN) is
> explicitly disabled.
> 
> fec_enet_itr_coal_set is only ever called if FEC_QUIRK_HAS_COALESCE is
> set and for those models, we expect disabling coalescing via FEC_ITR_EN
> -- and consequently also setting the parameters to zero -- to be
> unproblematic. This is also the reset default.

Thanks for the additional details. You could mention this in the
commit message. The commit message allows you to answer reviewers
questions before they ask them...

	Andrew

