Return-Path: <netdev+bounces-233163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383A0C0D644
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 13:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27C4407A55
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 11:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2832FD1AD;
	Mon, 27 Oct 2025 11:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DCq38wp/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB7C2E54D3;
	Mon, 27 Oct 2025 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761566168; cv=none; b=iwEMsbD+SQBgXAcRwCALIR7owlDbSkFuJKdfXKB8tB/yxN12gxEbnUJLqdUv/YToHWWLHjefSEz1L44T/PfLkclR8Cl+rLw2TPLQLCFgSlAKYHyGSKB4tIkKvqX+If/NuV9eO7HJrz+tc9nuXnctHXUbpPtH/QKDY3D7tLvUxp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761566168; c=relaxed/simple;
	bh=KmYaTo348YjP4HyvnnZHStoXxSWLzJQlIO+CZ5eLoCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyR1rO2fbUZWKcsJmPpvwCW12uE6uHlUSDs0gjeALWBgSxXLHFz8HV2Csr5fROdW4oCyJrKjan29CLTDmpP2FjRxHlGb5c/fOCQvBomPYkmHXDxH0X79JNgxgVYeK8hYAOp9Up8X1rZr7PK7h+QB1wq30cyJ/UzH+1/4JnqklXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DCq38wp/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h7ig+q44iVKbBRKUCUTFLVXFEUPAwlIHxU7LpAvTWo0=; b=DCq38wp/1YFLOCu+BXB1B2lwWm
	UL955g0KbOORhSxGZmCw8uV3K53DQmGlKnYxGr4Jo1O5u734SnBuVW+Tzq/lSwpdRGDyFi1S1sLnp
	SQ7LK9Ias7C/qIgQ0y6vPwkfbvcveD6UJJTXwLGaLR6Bl3r839l36DMu45WHPE1nTyWw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDLpH-00CBaV-DM; Mon, 27 Oct 2025 12:55:51 +0100
Date: Mon, 27 Oct 2025 12:55:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sven Eckelmann <se@simonwunderlich.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sw@simonwunderlich.de, Issam Hamdi <ih@simonwunderlich.de>
Subject: Re: [PATCH] net: phy: realtek: Add RTL8224 cable testing support
Message-ID: <fc65d6d1-6e59-47e1-8818-bc5279107549@lunn.ch>
References: <20251024-rtl8224-cable-test-v1-1-e3cda89ac98f@simonwunderlich.de>
 <3b1d35d7-ed62-4351-9e94-28e614d7f763@lunn.ch>
 <8597775.T7Z3S40VBb@ripper>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8597775.T7Z3S40VBb@ripper>

On Mon, Oct 27, 2025 at 08:49:36AM +0100, Sven Eckelmann wrote:
> On Monday, 27 October 2025 01:16:12 CET Andrew Lunn wrote:
> > > +#define RTL8224_SRAM_RTCT_FAULT_BUSY		BIT(0)
> > > +#define RTL8224_SRAM_RTCT_FAULT_OPEN		BIT(3)
> > > +#define RTL8224_SRAM_RTCT_FAULT_SAME_SHORT	BIT(4)
> > > +#define RTL8224_SRAM_RTCT_FAULT_OK		BIT(5)
> > > +#define RTL8224_SRAM_RTCT_FAULT_DONE		BIT(6)
> > > +#define RTL8224_SRAM_RTCT_FAULT_CROSS_SHORT	BIT(7)
> > 
> > It is unusual these are bits. Does the datasheet say what happens if
> > the cable is both same short and cross short?
> 
> Unfortunately, the datasheet doesn't say anything about cable tests.
> 
> > 
> > > +static int rtl8224_cable_test_result_trans(u32 result)
> > > +{
> > > +	if (result & RTL8224_SRAM_RTCT_FAULT_SAME_SHORT)
> > > +		return ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT;
> > > +
> > > +	if (result & RTL8224_SRAM_RTCT_FAULT_BUSY)
> > > +		return ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC;
> > > +
> > > +	if (result & RTL8224_SRAM_RTCT_FAULT_CROSS_SHORT)
> > > +		return ETHTOOL_A_CABLE_RESULT_CODE_CROSS_SHORT;
> > 
> > I don't remember seeing a PHY able to report both same short and cross
> > short at the same time. Maybe there has been, but there is no code for
> > it. We could add such a code.
> 
> I've tried it a couple of times (with shorts at different lengths) but was not 
> able to do this. For me, it looks like the RTL8224 can represent these faults 
> in parallel but not actual detect them in parallel.

O.K. Thanks for the explanation. The code is good as it is.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

