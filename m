Return-Path: <netdev+bounces-106141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFC3914F2E
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024741F211F6
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B377140E58;
	Mon, 24 Jun 2024 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YQLAgVj5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C4F140399;
	Mon, 24 Jun 2024 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719237157; cv=none; b=HgdkAQiTFUa57ouxChEeuXyGSt3PFTmxItLqI2wr5yJuAYQLmD6nTMIGAD9GrjQFJx5rL8gxKDHu/SpE8L7v8AiVzBNBcNt9XnQ7SSGQKXOiQjlKJqdBLeoR7zNxrdkoo293A/anpbrBKLzVQ2bd0HBp7DF/bgts8ncaRMPrbxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719237157; c=relaxed/simple;
	bh=8D9fEVi/qdwD0qRfLW8p9zkJnY9H20kJ0GevCBULIyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0EwRPfwRzIUQEmG5QuWIqoaLBYmhhj3lLzpvO5bS9sgtWhupIhNBbH9/r40bS7vtFXVYIFxzYkc4MJEn+ZGWQ3deaP+whTkfR0rHG/bFRgiMGk7H3DYOCLCSIJVeNo332CIdFV7JYQOF2wStpVnqdONE60uOMY/l1rgdMjFxDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YQLAgVj5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=W6LOzw6hb+XYQO888bOfZ/p7AYY/He9tqOE7LkaBWHs=; b=YQLAgVj5EKnCX9L5pKECZ+87dy
	HS/JqNuqWvIa6rez1e7VFQqWmhWyG/XIRcsnGUYQweFyJTipybYWncAENsknV5h0n6cAaZdbJgXKP
	mQjr5IEMWJ2lKu9dtx/EGJqjDWkBYMyUI5e+Dm9HL37wUMDR0dec5LRWYbjJK8Ao1unM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sLk7M-000r6m-Sn; Mon, 24 Jun 2024 15:52:24 +0200
Date: Mon, 24 Jun 2024 15:52:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek Vasut <marex@denx.de>
Cc: netdev@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Joakim Zhang <qiangqing.zhang@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org, kernel@dh-electronics.com
Subject: Re: [net-next,PATCH] dt-bindings: net: realtek,rtl82xx: Document
 known PHY IDs as compatible strings
Message-ID: <bad5be97-d2fa-4bd4-9d89-ddf8d9c72ec0@lunn.ch>
References: <20240623194225.76667-1-marex@denx.de>
 <cc539292-0b76-46b8-99b3-508b7bc7d94d@lunn.ch>
 <085b1167-ed94-4527-af0f-dc7df2f2c354@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <085b1167-ed94-4527-af0f-dc7df2f2c354@denx.de>

On Mon, Jun 24, 2024 at 01:52:49AM +0200, Marek Vasut wrote:
> On 6/23/24 10:00 PM, Andrew Lunn wrote:
> > >     - $ref: ethernet-phy.yaml#
> > >   properties:
> > > +  compatible:
> > > +    enum:
> > > +      - ethernet-phy-id0000.8201
> > 
> > I'm not sure that one should be listed. It is not an official ID,
> > since it does not have an OUI. In fact, this is one of the rare cases
> > where actually listing a compatible in DT makes sense, because you can
> > override the broken hardware and give a correct ID in realtek address
> > space.
> 
> Hmmm, so, shall I drop this ID or keep it ?
> 
> I generally put the PHY IDs into DT so the PHY drivers can correctly handle
> clock and reset sequencing for those PHYs, before the PHY ID registers can
> be read out of the PHY.

Are there any in kernel .dts files using it? We could add it, if it is
needed to keep the DT validation tools are happy. But we should also
be deprecating this compatible, replacing it with one allocated from
realteks range.

	 Andrew

