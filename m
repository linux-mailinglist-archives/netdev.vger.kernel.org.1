Return-Path: <netdev+bounces-223078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1BBB57D78
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A811888C9C
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 13:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4D131814A;
	Mon, 15 Sep 2025 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HwcrGxrA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5117313291;
	Mon, 15 Sep 2025 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943293; cv=none; b=q6+8pGq7jzryqcICN3ZPTubsse2wroX/eUhn00bgCwpx2cZh/opjnqt8IHrEym0ArXJh7XGN84k9L00nWgHMgIInPKicJuQxQKDwmOTsTxRENw6ZmPDcPBir0xIJBx5/ZVG414wQ7ivyowzxQs7vhdVNirdOxX92THFn1l/XwA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943293; c=relaxed/simple;
	bh=fPtIoj0FkrwQP2tgb+LAMXtFykuyWDiFG6GIu6JEh3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcTYiNWfe0i6qb5YCHvMmVGpurNtzwpiz2zVQeVVgjt0GMQi42yxDzD3IRmvvtC45mogHyU8SsLR/hfLyDqmlv2oR4yeHtzrzCGxbzsE2uwJWJBBrcRPgU4URwkkC/t49488SCiRJx/Tw/qpP6KdixOI+3ALDzfA/7vkqQxf588=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HwcrGxrA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tIaERIBIwJafIeyw2K3jSp5OGzOS9qBC9uS4brU4IqM=; b=HwcrGxrAnnF7LG6L1V8LREbJR8
	KJLkr1Pd2zBaMbrs+4EAsXp/0peBgG+d98LTmKRBVY6f2GwbELwKIlFqU6kYF5FAw844uUkglUx/S
	QYQsuFvGBIJAOeQcbFzx7Ho9lMjIHBuJL23kha+3Qs69S/CHeo6OtvgBuKOY1+5Q23k4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uy9M0-008Rj1-1W; Mon, 15 Sep 2025 15:34:48 +0200
Date: Mon, 15 Sep 2025 15:34:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v2 3/5] net: cadence: macb: Add support for Raspberry Pi
 RP1 ethernet controller
Message-ID: <d2afd474-1514-4663-9e96-7efea30a5eaa@lunn.ch>
References: <20250822093440.53941-1-svarbanov@suse.de>
 <20250822093440.53941-4-svarbanov@suse.de>
 <0142ac69-f0eb-4135-b0d2-50c9fec27d43@suse.de>
 <8715a21b-83ac-4bc1-b856-fa90bb5b809f@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8715a21b-83ac-4bc1-b856-fa90bb5b809f@suse.de>

On Mon, Sep 15, 2025 at 02:27:34PM +0300, Stanimir Varbanov wrote:
> 
> 
> On 9/10/25 2:32 PM, Stanimir Varbanov wrote:
> > Hi Jakub,
> > 
> > On 8/22/25 12:34 PM, Stanimir Varbanov wrote:
> >> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> >>
> >> The RP1 chip has the Cadence GEM block, but wants the tx_clock
> >> to always run at 125MHz, in the same way as sama7g5.
> >> Add the relevant configuration.
> >>
> >> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> >> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> >> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> >> ---
> >>  drivers/net/ethernet/cadence/macb_main.c | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>
> > 
> > This patch is missing in net-next but ("dt-bindings: net: cdns,macb: Add
> > compatible for Raspberry Pi RP1") from this series has been applied.
> > 
> > Could you take this patch as well, please.
> 
> Gentle ping.

Such pings are ignored. Please rebase the patch to net-next and submit
it again.

	Andrew

