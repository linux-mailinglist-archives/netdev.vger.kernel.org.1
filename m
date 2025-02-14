Return-Path: <netdev+bounces-166396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55704A35E88
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853B31884F84
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 13:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CB6263F4D;
	Fri, 14 Feb 2025 13:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GMat5fW/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8A977102;
	Fri, 14 Feb 2025 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739538633; cv=none; b=qjdFBt00U0Iz+hG+tRHxKJX9/FU7pKB3R6mZiCPE7rNWJro3h/GoDNX7h4pFm+LHKrxPnccUYbo5LuVtkCtLc9AHP4uzGoN9AZ8CBFN3sbzEEXN3xV3Buk04SALS9VuKNsj+4FsLWesTa/OymT1tYZ8fGl/aHfQtVUPKUA7CK6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739538633; c=relaxed/simple;
	bh=QlPRonjpsELaN3mstlXIcrb2TexcIyZ9zBtEQDdwNBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAZvLwpniMXr2LTWgqoGcuBsazK4g8P5U/SWcO6GsacCvEb1UdmwofHnUo8ZE97f8OQZBpA1d9WbBZJZ7I/tfS5fTlQGNb4LGJXL4U2PWknKm8fbuuVqmsb/7KOVrxHgjxRzVMZKEBLkXHSWaFvpb2Ot4VJXgV1AULwXV7NdKHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GMat5fW/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WVC5KPxHIUTpQJAWz4Yd0Tr3K7nMkABHyOzsn0Ycnho=; b=GMat5fW/wTe2S9Xc13bsmUgHVp
	BSKW20FGbgUDU2G628ymjJcueeL0WXBX702Wr9IeQ67colXklE/H+g5+B3a8DtXQ8qLrhA1kKa8+I
	l4YYAWTKEKK3W9u0MPt6QyRtnhoSlP2hh5zW85j+tOTIHUJWo29swQCGqLzhfRxLwLi0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tivSH-00E4Ry-UD; Fri, 14 Feb 2025 14:10:05 +0100
Date: Fri, 14 Feb 2025 14:10:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Swathi K S <swathi.ks@samsung.com>
Cc: krzk+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	'Pankaj Dubey' <pankaj.dubey@samsung.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: net: Add FSD EQoS device tree
 bindings
Message-ID: <ffb13051-ab93-4729-8b98-20e278552673@lunn.ch>
References: <20250213044624.37334-1-swathi.ks@samsung.com>
 <CGME20250213044955epcas5p110d1e582c8ee02579ead73f9686819ff@epcas5p1.samsung.com>
 <20250213044624.37334-2-swathi.ks@samsung.com>
 <85e0dec0-5b40-427a-9417-cae0ed2aa484@lunn.ch>
 <00b001db7e9f$ca7cfbd0$5f76f370$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b001db7e9f$ca7cfbd0$5f76f370$@samsung.com>

On Fri, Feb 14, 2025 at 10:47:39AM +0530, Swathi K S wrote:
> 
> 
> > -----Original Message-----
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: 14 February 2025 05:50
> > To: Swathi K S <swathi.ks@samsung.com>
> > Cc: krzk+dt@kernel.org; andrew+netdev@lunn.ch; davem@davemloft.net;
> > edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> > robh@kernel.org; conor+dt@kernel.org; richardcochran@gmail.com;
> > mcoquelin.stm32@gmail.com; alexandre.torgue@foss.st.com;
> > rmk+kernel@armlinux.org.uk; netdev@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v6 1/2] dt-bindings: net: Add FSD EQoS device tree
> > bindings
> > 
> > > +  phy-mode:
> > > +    enum:
> > > +      - rgmii-id
> > 
> > phy-mode is normally a board property, in the .dts file, since the board
> might
> > decide to have extra long clock lines and so want 'rgmii'.
> > 
> > The only reason i can think of putting rgmii-id here is if the MAC only
> > supports 'rgmii-id', it is impossible to make it not add delays.
> > If that is true, a comment would be good.
> 
> 
> Hi Andrew,
> Thanks for reviewing.
> I think we already discussed this part some time back here [1]
> [1] :
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20230814112539.7
> 0453-2-sriranjani.p@samsung.com/#25879995
> Please do let me know if there is any other concern on this.

We partially discussed this in this thread.

As i said, what value you need here depends on the board design. The
PCB could provide the 2ns delay, in which case, 'rgmii' would be the
correct value to have in the board .dts file. Hence the binding should
not restrict the value of phy-mode to just rgmii-id. All 4 rmgii
values should be accepted.

The only reason you would force only rgmii-id is if the MAC/PHY pair
cannot do anything else. If that really is true, i would expect a
comment in the binding, and the MAC driver to return -EINVAL for
anything but rgmii-id.

	Andrew

