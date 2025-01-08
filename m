Return-Path: <netdev+bounces-156430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 520C7A065D2
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 21:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51FAD1648BD
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 20:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F58202C55;
	Wed,  8 Jan 2025 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cokaGl5r"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7F120127E;
	Wed,  8 Jan 2025 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736367271; cv=none; b=uSlmRcoMi4/zXpS5OgYdhK7C3YWyOdXKvWT7Zko+zNH/9+b4JoiJghYj6Sv+7oaA5M6GtdttSoXSVrHlFOUNrw5UEgUHhhjOXv/W/2ORql0xwCnlXha8Wm1HufmMPK/CaNXhvLEMnR8WPGOcXz6YzwCUT30zTawadXG4Cv1hWrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736367271; c=relaxed/simple;
	bh=fWXWqOox9j68tKJYQQyfrzCuN3RmXdh/TDYs9UfDP7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCkm/zJYYG0aLZD0gEirxl0Xy8f6kQDuTzzMNnS5KdUFD71y4mA5+v5kuewgJWwBn4xQXTaJWQCkF7LPQDyDJi1n9YxBvF1/LNr8XUCILcKHGWd/KqFtPhBeyn6NZYQ7E+qlPrpfQscnStwJ6H7awLXHtnHBR/flWRamDTrsoh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cokaGl5r; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hs8uP3N/mTdsE3JF6EEgjMUW9ubX3QrUliIYU0W1Efw=; b=cokaGl5rbCCWR5PLEEXlzlK4cg
	61kIh8CGC74Kzu7whTHy6mmGZiSShEsvkL/AiJ79CgmLhcin6x2cZmY33bJNEFJBTn2rnElphfZ8A
	QoBXD8JA3+CWcAR2AKXIabgI7RguloybklWjZ7s0SMDRD9wP03I3Y1lpAgkiPSW+xw0s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tVcR0-002fvx-Ne; Wed, 08 Jan 2025 21:13:46 +0100
Date: Wed, 8 Jan 2025 21:13:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ratbert@faraday-tech.com, openipmi-developer@lists.sourceforge.net,
	netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, eajames@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/10] ARM: dts: aspeed: system1: Add RGMII support
Message-ID: <b80b9224-d428-4ad9-a30d-40e2d30be654@lunn.ch>
References: <20250108163640.1374680-1-ninad@linux.ibm.com>
 <20250108163640.1374680-6-ninad@linux.ibm.com>
 <1dd0165b-22ff-4354-bfcb-85027e787830@lunn.ch>
 <0aaa13de-2282-4ea3-a11b-4edefb7d6dd3@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aaa13de-2282-4ea3-a11b-4edefb7d6dd3@linux.ibm.com>

On Wed, Jan 08, 2025 at 12:43:07PM -0600, Ninad Palsule wrote:
> Hello Andrew,
> 
> 
> On 1/8/25 11:03, Andrew Lunn wrote:
> > On Wed, Jan 08, 2025 at 10:36:33AM -0600, Ninad Palsule wrote:
> > > system1 has 2 transceiver connected through the RGMII interfaces. Added
> > > device tree entry to enable RGMII support.
> > > 
> > > ASPEED AST2600 documentation recommends using 'rgmii-rxid' as a
> > > 'phy-mode' for mac0 and mac1 to enable the RX interface delay from the
> > > PHY chip.
> > You appear to if ignored my comment. Please don't do that. If you have
> > no idea about RGMII delays, please say so, so i can help you debug
> > what is wrong.
> > 
> > NACK
> 
> I think there is a misunderstanding. I did not ignore your comment. I have
> contacted ASPEED and asked them to respond. I think Jacky from Aspeed
> replied to your mail.

You did not mention in the cover letter, or the patch. I asked for a
detailed explanation in the commit message why it is correct, which
you did not do.

Now we have more details, it is clear Ethernet support for this board
needs to wait until we figure out how to fix the MAC driver. Please
either wait with this patchset until that is done, or drop this one
patch for the moment and submit it later once the MAC driver is fixed.

      Andrew


