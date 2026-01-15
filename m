Return-Path: <netdev+bounces-250285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 018DAD27101
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 19:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B738C306C497
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFD73EC829;
	Thu, 15 Jan 2026 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2AAm5y+B"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FC83D331E;
	Thu, 15 Jan 2026 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499446; cv=none; b=WZuGcyhf+sKgqNvyrlpsTEXWGk0TvevgECJ4i901QurBQtkZeiXbUhrvcOMbaJrbZ85GE9dPWEHG1/GdmstTXLTCREqC8GFDd4zvXk8ZMjMkhrP1sYOfSOPJZKDNmqt3DckBiZjZbV1qTww51MwqRqW5cPxMGG2LYsIN8mX7kYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499446; c=relaxed/simple;
	bh=i25XwYpLXKExtbSv+EaBUvAAC9IPVYouqtTSkICRLOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzTkfLfgqjvCiBHG50xtggC7UrZ282vjrGg9DIjgv3/VQreugVwpC/nDOQOjbui+ZFZCBSUMwUPwi6j289wvICeMaUAeqgj5jgRu4mlqJ2phTscGJM4g73Uf6VF9GSjx+frRkRCW+zqmZdKPSXMtHgQ29pZqlFvMMIhftq8K1ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2AAm5y+B; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+6xb8o2Ek3tuPFQPXpObbPkIvoMHfb2HLA4bjqRg0b8=; b=2AAm5y+BIP3Fmq4cxnlrEl8McR
	9Coy+P/Sw/9CfvKmeA37H8zDpdfSD+ghP7fGsvCEFdS9V1+H3+I0UPCoSFVSpu50iBGwSdv7kZEcr
	zfCofb+xjPW52CFxyW4ruicCj190SdVYDcXe4DPTF+iT1QNriiVK5qotGs18dEaGk1XU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vgRUT-002y26-C2; Thu, 15 Jan 2026 18:50:37 +0100
Date: Thu, 15 Jan 2026 18:50:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
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
Message-ID: <13947d52-b50d-425e-b06d-772242c75153@lunn.ch>
References: <75f9d8c9-20a9-4b7e-a41c-8a17c8288550@kernel.org>
 <69676b6c.050a0220.5afb9.88e4@mx.google.com>
 <e2d2c011-e041-4cf7-9ff5-7d042cd9005f@kernel.org>
 <69677256.5d0a0220.2dc5a5.fad0@mx.google.com>
 <76bbffa8-e830-4d02-a676-b494616568a2@lunn.ch>
 <6967c46a.5d0a0220.1ba90b.393c@mx.google.com>
 <9340a82a-bae8-4ef6-9484-3d2842cf34aa@lunn.ch>
 <aWfdY53PQPcqTpYv@lore-desk>
 <e8b48d9e-f5ba-400b-8e4a-66ea7608c9ae@lunn.ch>
 <aWgaHqXylN2eyS5R@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWgaHqXylN2eyS5R@lore-desk>

On Wed, Jan 14, 2026 at 11:35:10PM +0100, Lorenzo Bianconi wrote:
> > > In the current codebase the NPU driver does not need to access the WiFi PCIe
> > > slot (or any other external device) since the offloading (wired and wireless)
> > > is fully managed by the NPU chip (hw + firmware binaries).
> > 
> > Are you saying the NPU itself enumerates the PCI busses and finds the
> > WiFi device?  If it can do that, why not ask it which PCI device it is
> > using?
> 
> nope, we do not need any PCI enumeration in the NPU driver at the moment
> (please see below).
> 
> > 
> > Or this the PCI slot to use somehow embedded within the firmware?
> 
> in the current implementation the NPU driver does not need any reference to
> WiFi or Ethernet devices. The NPU exports offloading APIs to consumer devices
> (e.g. WiFi or Ethernet devices). In particular,
> 1- during NPU module probe, the NPU driver configures NPU hw registers and
>    loads the NPU firmware binaries.
> 2- NPU consumers (ethernet and/or wifi devices) get a reference to the NPU
>    device via device-tree in order to consume NPU APIs for offloading.
> 3- netfilter flowtable offloads traffic to the selected ethernet and/or WiFi
>    device that runs the NPU APIs accessible via the NPU reference obtained via
>    dts.
> 
> The issue here is the NPU firmware binaries for EN7581, loaded by the NPU
> driver during NPU probe and used for offloading, depend on the WiFi chipset
> (e.g. MT7996 or MT7992) available on the EN7581 board (we have two different
> NPU binaries for MT7996 offloading and for MT7992 offloading).

Maybe i'm getting the NPU wrong, but i assumed it was directly talking
to the Ethernet and WiFi device on the PCIe bus, bypassing the host?
If so, it most somehow know what PCIe slots these devices use?

   Andrew

