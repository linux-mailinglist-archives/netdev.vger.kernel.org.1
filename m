Return-Path: <netdev+bounces-181689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEDAA86260
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9CA13B0137
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 15:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CED620FA90;
	Fri, 11 Apr 2025 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbhzcTJ/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B8B1FDA;
	Fri, 11 Apr 2025 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744386808; cv=none; b=NmEYmo0+ybqEGwIkQqcitGRQlCNLysQxk2diM9r73EXo8Uv0aV8QD8lgPh7WLyrCy9+moKf0xGYd2Iz0LUVeanEBbD2VTvFZpU+Wu6rQMFmfZL7n4YWJd857TQJScwp0eaFRP29tY31ObubgK7WS+pYqJqitVGR1gtnXG9VBsUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744386808; c=relaxed/simple;
	bh=WpLLjD7bOW1+fhZZ7vlzZrNDNsR7j0cmT3HhyvWs3dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BO5kQhy2sfONziC7o0XSu4uUtwvQqu2MgNacgeTHz1lT1VRjCGcA2i8c0onwr/i9KyuSRt1eQm58+6KD8UHiIbc3748CRe1Rmq5wIzytntzAHLq8mOWiLLsxCQxb45pPMxWbWZFb8AxYt+sZoAP90+fT/yEh6Owa+jTRPn2oSB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbhzcTJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F5CC4CEE2;
	Fri, 11 Apr 2025 15:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744386808;
	bh=WpLLjD7bOW1+fhZZ7vlzZrNDNsR7j0cmT3HhyvWs3dE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CbhzcTJ/RcGu4IXToUC3ZYA40ZZJtE9BKTx9YhPlHKNMv9K3T70fHI/McAFA9hPHY
	 cg6juXNyihAA4hVHHcsfqtlhAC6GMkMOkKKJRszHAeHE+zi3M0ilQPCTQ2KGv2L/b9
	 LBY8ggDrYbuhadgyBz7t1e7lZ+PYdoD2xvFpkwJJe76TbWVHAcTp4aROeJPnGUlg4x
	 xtVfg/CA1u0/3qj04YOkSocRlsTIZIn8SaHwlbjWpf7SREQsWNTgQmU5MlPzwtCP1t
	 GbtbU27P5qU2qVnIZXt2pMVpNfEhFE/zJBg8+nGh3rY/KwE2zw23P8eDPqQBia2DCN
	 DWZDUwWqjkErQ==
Date: Fri, 11 Apr 2025 16:53:23 +0100
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH net-next v2 2/2] net: phy: Add Marvell PHY PTP support
Message-ID: <20250411155323.GK395307@horms.kernel.org>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
 <20250407-feature_marvell_ptp-v2-2-a297d3214846@bootlin.com>
 <20250408154934.GZ395307@horms.kernel.org>
 <20250409100757.07b00067@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409100757.07b00067@kmaincent-XPS-13-7390>

On Wed, Apr 09, 2025 at 10:07:57AM +0200, Kory Maincent wrote:
> On Tue, 8 Apr 2025 16:49:34 +0100
> Simon Horman <horms@kernel.org> wrote:
> 
> > On Mon, Apr 07, 2025 at 04:03:01PM +0200, Kory Maincent wrote:
> > > From: Russell King <rmk+kernel@armlinux.org.uk>
> > > 
> > > From: Russell King <rmk+kernel@armlinux.org.uk>
> > > 
> > > Add PTP basic support for Marvell 88E151x PHYs. These PHYs support
> > > timestamping the egress and ingress of packets, but does not support
> > > any packet modification.
> > > 
> > > The PHYs support hardware pins for providing an external clock for the
> > > TAI counter, and a separate pin that can be used for event capture or
> > > generation of a trigger (either a pulse or periodic).  This code does
> > > not support either of these modes.
> > > 
> > > The driver takes inspiration from the Marvell 88E6xxx DSA and DP83640
> > > drivers.  The hardware is very similar to the implementation found in
> > > the 88E6xxx DSA driver, but the access methods are very different,
> > > although it may be possible to create a library that both can use
> > > along with accessor functions.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > > 
> > > Add support for interruption.
> > > Fix L2 PTP encapsulation frame detection.
> > > Fix first PTP timestamp being dropped.
> > > Fix Kconfig to depends on MARVELL_PHY.
> > > Update comments to use kdoc.
> > > 
> > > Co-developed-by: Kory Maincent <kory.maincent@bootlin.com>
> > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>  
> > 
> > Hi Kory,
> > 
> > Some minor feedback from my side.
> > 
> > > ---
> > > 
> > > Russell I don't know which email I should use, so I keep your old SOB.  
> > 
> > Russell's SOB seems to be missing.
> 
> It is, 5 lines higher, but maybe you prefer to have them all together. 

This thread seems to have subsequently gone elsewhere.
But, FTR, yes, I would prefer all tags together.

...

