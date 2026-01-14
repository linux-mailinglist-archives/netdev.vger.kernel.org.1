Return-Path: <netdev+bounces-249919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0DAD20A06
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 18:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8199B30146F4
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 17:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F3C32ABC3;
	Wed, 14 Jan 2026 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RP/MpWm/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BE8329E46;
	Wed, 14 Jan 2026 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768412877; cv=none; b=tWF7rot/dOGkXp6KSaDFJDuCcmmEeTOMO0e/LcY3NaglAkFfkX0Kpo7kpIYxOUG2obH+YHzqwcZDr1/cnXVLWahV+F+c/EghL3aHtyswz/UTFHhGo4iZgMCTBBLzRVvbc4dc/5mYs2dvqLPApOWk12NUfdJiq3YC/pIV3+ikqaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768412877; c=relaxed/simple;
	bh=yu2p+5/mcf8djkexz3bzB1VOl744pGcBn759PQgo7P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfN2pwNzsCxmM/M+tNInKvPyhYcHBZEAaFVTq9kt8y9L3BAgi2FScCZM49X1CGTregy37DqkinSPng8SSamICtiTjUm9NFKP+Jtze5xdF1Bo9TnGbDgP0RG3TGq7gzR8bTVEQk6wzkzuUOgLtiAua65qmYjmfVqZqBp4pVAihBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RP/MpWm/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XG98XXWLm122wWN3H5/0OaDdF3a45orRwXDXa/HYuAA=; b=RP/MpWm/ItaE40/w2jeE8X5Mfj
	8D7l4clLFVFkOuKMoIH7cj+YPrydgMJ1eeQvcBL5wzmhpO3j41n1f3/Ftttyp8T54tWXWClcU644Z
	EV3OyyU3H6wYLsEim1iqclB57Y7VjaD9WXT0G7PUz6PZ9fBJpnh9wGCoT5iw1wkOOQC0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vg4yA-002pWl-OJ; Wed, 14 Jan 2026 18:47:46 +0100
Date: Wed, 14 Jan 2026 18:47:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: airoha: npu: Add
 EN7581-7996 support
Message-ID: <9340a82a-bae8-4ef6-9484-3d2842cf34aa@lunn.ch>
References: <20260113-airoha-npu-firmware-name-v2-0-28cb3d230206@kernel.org>
 <20260113-airoha-npu-firmware-name-v2-1-28cb3d230206@kernel.org>
 <20260114-heretic-optimal-seahorse-bb094d@quoll>
 <aWdbWN6HS0fRqeDk@lore-desk>
 <75f9d8c9-20a9-4b7e-a41c-8a17c8288550@kernel.org>
 <69676b6c.050a0220.5afb9.88e4@mx.google.com>
 <e2d2c011-e041-4cf7-9ff5-7d042cd9005f@kernel.org>
 <69677256.5d0a0220.2dc5a5.fad0@mx.google.com>
 <76bbffa8-e830-4d02-a676-b494616568a2@lunn.ch>
 <6967c46a.5d0a0220.1ba90b.393c@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6967c46a.5d0a0220.1ba90b.393c@mx.google.com>

On Wed, Jan 14, 2026 at 05:29:28PM +0100, Christian Marangi wrote:
> On Wed, Jan 14, 2026 at 04:56:02PM +0100, Andrew Lunn wrote:
> > > > Yes. What you plug into PCI is not a part of this hardware, so cannot be
> > > > part of the compatible.
> > > > 
> > > 
> > > Thanks for the quick response. Just to make sure Lorenzo doesn't get
> > > confused, I guess a v3 would be sending v1 again (firmware-names
> > > implementation series) with the review tag and we should be done with
> > > this.
> > 
> > Since this is a PCI device, you can ask it what it is, and then load
> > the correct firmware based on the PCI vendor:product. You don't need
> > to describe the hardware in DT because it is enumerable.
> > 
> 
> Hi Andrew,
> 
> I think it's problematic to create a bind between the NPU and
> PCIe.

But the NPU must already be bound to PCIe. How else does it know which
PCIe slot the WiFi card is on, so it can make use of it?

     Andrew

