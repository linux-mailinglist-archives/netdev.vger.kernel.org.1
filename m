Return-Path: <netdev+bounces-189850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CDFAB3EA5
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 19:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A35165CE2
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 17:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C25F29551D;
	Mon, 12 May 2025 17:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mkoks5cL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F018467;
	Mon, 12 May 2025 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747069676; cv=none; b=CkM8tCkKBFmm5JaMEcfMJ+GRx6hoDQPgV1leT8zQfAygsTji8rNJFxWJXxRmgTMmyXM09sDDHwUmz7ZWXcnkFBlab39vLYjD27VH/SXkjF4/DAK1RgErFgOo5tUR1nOUp62pCCuDFVKNSWUNOrxQrrfrnN4aI1fZ4OiAqgSQ/vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747069676; c=relaxed/simple;
	bh=mLmEqOzVCecMhSZ9SrTL+1guOX+BsjLm7ABFb3jdDGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFFERQbjTg4XteUVKluBGC4nBKXzzsGerWBkBuT1LntsXOLv3rrxc2WtFdrBib32C6TvAq2l4hQj5GWF512dLlRtENBp4ZILbZRjADXnHTH5iI7GFPxqPSrHiS0M0NHFWIh6tSVt/g4cRdcIKWqxCPLqlz1wFC59VOne1eB4Ipg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mkoks5cL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=AIX9i9XOoogJsxM2MKGz+jWDm2A2YEEjwp/MY1BWXgM=; b=mk
	oks5cLithMxuvu28S06tNcTQiAzT/5r6o6bwui5XQdulLQr352SjyHoSJnO5cbfs9qO2h0SIGat5q
	sgW7QMmNRAsLza8+iTgsIcYO09hzsLjmQfBTmZyeQzYDm2FfDZxlBjOG1WXI9K7LwRUWsqpULe4av
	eqqrJLe6239WeTk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uEWcr-00CMd6-AR; Mon, 12 May 2025 19:07:37 +0200
Date: Mon, 12 May 2025 19:07:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Damien =?iso-8859-1?Q?Ri=E9gel?= <damien.riegel@silabs.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Silicon Labs Kernel Team <linux-devel@silabs.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org
Subject: Re: [RFC net-next 00/15] Add support for Silicon Labs CPC
Message-ID: <6fea7d17-8e08-42c7-a297-d4f5a3377661@lunn.ch>
References: <20250512012748.79749-1-damien.riegel@silabs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250512012748.79749-1-damien.riegel@silabs.com>

On Sun, May 11, 2025 at 09:27:33PM -0400, Damien Riégel wrote:
> Hi,
> 
> 
> This patchset brings initial support for Silicon Labs CPC protocol,
> standing for Co-Processor Communication. This protocol is used by the
> EFR32 Series [1]. These devices offer a variety for radio protocols,
> such as Bluetooth, Z-Wave, Zigbee [2].

Before we get too deep into the details of the patches, please could
you do a compare/contrast to Greybus.

The core of Greybus is already in the kernel, with some more bits
being in staging. I don't know it too well, but at first glance it
looks very similar. We should not duplicate that.

Also, this patch adds Bluetooth, you talk about Z-Wave and Zigbee. But
the EFR32 is a general purpose SoC, with I2C, SPI, PWM, UART. Greybus
has support for these, although the code is current in staging. But
for staging code, it is actually pretty good.

Why should we add a vendor implementation when we already appear to
have something which does most of what is needed?

	Andrew

