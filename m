Return-Path: <netdev+bounces-251101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5F3D3AB43
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC7F830A4BDE
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4424C36E47F;
	Mon, 19 Jan 2026 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y9I5nMCn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235F130FF30;
	Mon, 19 Jan 2026 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831485; cv=none; b=rjxEp/OUrMB6/PvRdjx34mqSSl+VOYfQHd3rV1Axgb6heo/0tvG1wph9AqFkFV3m6FlEKg/CDUdE5PHy26oRSqyBkz7rEjPhxqLp2ti043FrLLxm+cr9bLsHfP6P4RqCnWMU9tfn8DPNOUzoxty/y2YlGtP9vR423epMiJjYVsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831485; c=relaxed/simple;
	bh=VbSSmsgeCeEqen19Ot1xUCONBpHTnwPjssuuU8Y1I60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKnwwh4TtUhU5fDqPvdUTWmwQOvNp8XEfJCq0sHG5eXDM4pOXaEVm6VlIyess02NX95IbvjL2oGIdBck3sSZJ9gJ4x6pUSn2D8Rx/OViUB2zE/CgYAr189WGdrKuViJ3Qey6NubXxfsIvDbBcc9htI9FkzHU4YgL61E7XPmt9nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Y9I5nMCn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=T0rl3SMhzSTIAUIp4+rR+1cMtdJOvQXiZGRrtdfINPM=; b=Y9I5nMCnbG8ouhn6DeqAN+7SUT
	Ekkdoaqk+ZJbli/QK35eSVEF8Dssh8nvRD7e4yWodA2vxW8vmlRYZQI3ckcZNG2XiBBY860rTWJFe
	tuXBJh6sWjFmoVMXS/cC3Tt7TQrER1bb5X3TNETy0e7Ru4lWKiY6eQudT6yW7TKCDTd4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vhprn-003VE9-KF; Mon, 19 Jan 2026 15:04:27 +0100
Date: Mon, 19 Jan 2026 15:04:27 +0100
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
Message-ID: <cd1fd7b4-64a1-4b73-86aa-d3621ed814b4@lunn.ch>
References: <6967c46a.5d0a0220.1ba90b.393c@mx.google.com>
 <9340a82a-bae8-4ef6-9484-3d2842cf34aa@lunn.ch>
 <aWfdY53PQPcqTpYv@lore-desk>
 <e8b48d9e-f5ba-400b-8e4a-66ea7608c9ae@lunn.ch>
 <aWgaHqXylN2eyS5R@lore-desk>
 <13947d52-b50d-425e-b06d-772242c75153@lunn.ch>
 <aWoAnwF4JhMshN1H@lore-desk>
 <aWvMhXIy5Qpniv39@lore-desk>
 <30f44777-776f-49b1-b2f5-e1918e8052fd@lunn.ch>
 <aW4QixwAJHaHWBBc@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW4QixwAJHaHWBBc@lore-desk>

> > So is the firmware name a property of the board?
> 
> We need to run different binaries on the NPU based on the MT76 WiFi chip
> available on the board since the MT76 DMA rings layout changes between MT76 SoC
> revisions (e.g. Egle MT7996 vs Kite MT7992). In this sense, I agree, the
> firmware name is a board property.

O.K, lets go with v1 then. List the firmware filename in the board
.dts file.

     Andrew

