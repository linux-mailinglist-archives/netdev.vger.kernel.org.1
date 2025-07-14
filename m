Return-Path: <netdev+bounces-206900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F72AB04B22
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FCD816350A
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A6D277CB3;
	Mon, 14 Jul 2025 22:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fwkO7GOy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F2A278143;
	Mon, 14 Jul 2025 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533886; cv=none; b=VjMjgAODN7EGM+IOMgZlTGcehDM9CvoL3sbGQgRpx9lbLsXKORLOiDkwaPuvp/60l0SZFdimgexSOofb9XxLSBaoXfDuFpx88qF2jo/Kb2GfnaB6g22qy0bGbbeLf77eKKmMHEJn/ZtbDjlXA8ciNyjGlli/Vf6mLlV1DrFtWTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533886; c=relaxed/simple;
	bh=gikK7X29ADLPP3hAzfPrF5Nps/L5jYUoRTLn2trqKxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKDHTNziiQJiG2vFHpkOReIHmgRA9uLiLqbapT8Qc8LWFt+GQ2fugTfahRO3yG5p5fOHZW5Lf5+oKk87HPIXNnWLVvL8hCwkXkowAJJ0YnnVtyC+Kh1hyf+O76SoWtYXVXBTb3nN9fWQaajnIzsTJDuMuCdpcgB1v71VcjC1sYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fwkO7GOy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=re5vEpWzxNdWCjr9r1o7knlAw2oLCVrTuWhoL9AZx4g=; b=fwkO7GOy6gh70PKilmMQibFb0V
	+X4ndIAYAZUUWrnjfTRP7MHxTmBVi+zHqVuapH+IzjGGDso9u2dFZSrzGOP8AGHidmECNpmwKXGGh
	CG4oA5yqgTt3iutTmvACQjNmfT/f0eZzSKKNYQZPTskc1ActSOjcK2horL4AroxCqVGA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ubS7N-001W4h-3e; Tue, 15 Jul 2025 00:57:53 +0200
Date: Tue, 15 Jul 2025 00:57:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matthew Gerlach <matthew.gerlach@altera.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, dinguyen@kernel.org,
	maxime.chevallier@bootlin.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: socfpga: agilex5: enable gmac2 on the
 Agilex5 dev kit
Message-ID: <8b7f0946-4c95-465a-a462-48fa9887aade@lunn.ch>
References: <20250714152528.311398-1-matthew.gerlach@altera.com>
 <20250714152528.311398-4-matthew.gerlach@altera.com>
 <de1e4302-0262-4bcc-b324-49bfc2f5fd11@lunn.ch>
 <256054d7-351a-4b1c-8e1a-48628ace091d@altera.com>
 <86e1e04a-3242-482c-adb0-dde7375561c1@lunn.ch>
 <baed95d4-c220-4d3b-8173-fc673660432d@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baed95d4-c220-4d3b-8173-fc673660432d@altera.com>

> Currently the
> driver, drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c, and its
> bindings, Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml,
> allow all rgmii phy-modes.

There is nothing unusual about allowing all four RGMII modes. Somebody
might design a board with the 2ns delay via extra long clocks lines,
or some other form of delay lines. Such a board would need 'rgmii',
and they do exist, a board like this was added this cycle. There is
one rather odd board with a DT file which has extra long clock line
for TX, but not RX! That needs rgmii-rxid. The majority of boards
don't have any delays on the PCB, so need 'rgmii-id'.

	Andrew

