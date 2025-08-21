Return-Path: <netdev+bounces-215633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A755B2FB85
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F64AE6721
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 13:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4156F340D8E;
	Thu, 21 Aug 2025 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xcSk12ef"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7620133EB15;
	Thu, 21 Aug 2025 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783752; cv=none; b=s2Gxq9RM/qf5YBb6daWFLIQXmXAZ3XDKfHLgzBoJf0tIEyEKhgDgCzlF+a+P3qV0UUIAIsyT+TKAbusIpJn3ITSNiEuporjxZK7l8OXb8dItW/Ofcxl3QcI2+X0ei9umKWTLnhOISEr4/jIvViHdyOJ6DpX1FUTG8AS/mRQiFRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783752; c=relaxed/simple;
	bh=h4drEKTvextJIC6C7hYqLQ1NtGkmFug5A+EBlYiBSFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmNo2i+ju4yRihjM+4I05tm11PJ1Ikv6R0vlGyXG+WsHg7bBSAAwU7reXMERuFp2BEzVE5/pz12dVaksxXJdOEVDXIlFrbUXra1BdAmmmvqhKjd9nvPIP6+sixt7CqldyBf8eQq1rR5I+zmNC49xYoICVH7z+cdAIJDgxMyfC5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xcSk12ef; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=IsjHE15ag86pxy6KC8Bhf9DKPrEYWKWK49RylE83y40=; b=xc
	Sk12efTZH+sSoCsHS3SeSzx7JAXoTk8MTgjPHN5RtfO66TJ1hFIdUgfCOtz5gB6QhbkxzeY2FKGvZ
	gAbBJ2RI3oRVRdFbn2DzZAZCPXt3yIuUQC9nm7LsUqTz0sHvTZPPiQBCsHeCjLFEEEDJA46384DVJ
	AfNGn/hToj9yRag=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1up5YW-005SO5-I4; Thu, 21 Aug 2025 15:42:16 +0200
Date: Thu, 21 Aug 2025 15:42:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yangfl <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next v5 1/3] dt-bindings: net: dsa: yt921x: Add Motorcomm
 YT921x switch support
Message-ID: <f76df98e-f743-4dc2-9f10-93b97f69addb@lunn.ch>
References: <20250820075420.1601068-1-mmyangfl@gmail.com>
 <20250820075420.1601068-2-mmyangfl@gmail.com>
 <ce66b757-f17d-458c-83f4-e8f2785c271c@lunn.ch>
 <CAAXyoMMpf9u7aZO204moF5DHd+QR4aAxxdtEdTx-iU77DKhBDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXyoMMpf9u7aZO204moF5DHd+QR4aAxxdtEdTx-iU77DKhBDg@mail.gmail.com>

On Thu, Aug 21, 2025 at 08:50:18PM +0800, Yangfl wrote:
> On Thu, Aug 21, 2025 at 8:41 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > +        switch@1d {
> > > +            compatible = "motorcomm,yt9215";
> > > +            /* default 0x1d, alternate 0x0 */
> > > +            reg = <0x1d>;
> >
> > Just curious, what does alternative 0x0 mean? Does this switch have
> > only one strapping pin for address, so it either uses address 0x1d or
> > 0x0?
> >
> >         Andrew
> 
> Yes. I've seen this approach on other chips (offering two MDIO
> phyaddrs), so this should be a common practice.

If it only supports two addresses, you could add a constrain in the
binding that reg is [0x0, 0x1d].

	Andrew

