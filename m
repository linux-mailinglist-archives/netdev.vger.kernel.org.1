Return-Path: <netdev+bounces-249938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 264ACD2124D
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 21:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6F9A302C20F
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 20:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6955D3559C4;
	Wed, 14 Jan 2026 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aS5xEqGj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDDB13AF2;
	Wed, 14 Jan 2026 20:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768421733; cv=none; b=egmIJjq95xV9nO39/9SGHC+ytwDfQzcF3zXZDRutLFYppcJWmsOYzZvu+Cd63nVEV81q1w5M6ZCMqtqW+4GR3QeuznFt6vCOsHBKnDiSPtDRSvyQjeHHnKOuHDbSjZnH8bpsmTFMS/rlOLHwKJ2VwnwC4AaXFbXHztt92kcCeRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768421733; c=relaxed/simple;
	bh=t6EPBE8TiEfhpPXLMXa+gBTGLS2XyvfxiIxhtg7fozk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZMgeTjoM/qBDpcHWUGLcJJZpxEqNj5OEFiHqrA9s8F24Wd/0iUqnCB02VvEW3xIMw6apApC2wYds/9OuI0/Udirs5vO5UA6qH0QQ0+oIM+U1BHMs6X8YxRiug3wblXHrTKHnvfCy2Rkbqfh4UucSnOZlMLVz8cYg5heNeAP7pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aS5xEqGj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8z6/tHemAyDUZ6LGRZmbfUFeZIhjen3VER7FZfVnFpc=; b=aS5xEqGjmG+E5F66GzJ46hO7mw
	2ylPpsavqTgjSwkIvXwhPTiUslTgntwK1WteYq+FYOiQRP6H1bPUP5CpiD6kAqp8XJ3+hF0Sn6Wgv
	MPfTze7+rthU2+SJp6XqyYXaxHtm/tWu6H9b2M5Iv6Bkl6274+KYDpIG7GD3XCOBOmGA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vg7Gx-002qQc-3R; Wed, 14 Jan 2026 21:15:19 +0100
Date: Wed, 14 Jan 2026 21:15:19 +0100
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
Message-ID: <e8b48d9e-f5ba-400b-8e4a-66ea7608c9ae@lunn.ch>
References: <20260114-heretic-optimal-seahorse-bb094d@quoll>
 <aWdbWN6HS0fRqeDk@lore-desk>
 <75f9d8c9-20a9-4b7e-a41c-8a17c8288550@kernel.org>
 <69676b6c.050a0220.5afb9.88e4@mx.google.com>
 <e2d2c011-e041-4cf7-9ff5-7d042cd9005f@kernel.org>
 <69677256.5d0a0220.2dc5a5.fad0@mx.google.com>
 <76bbffa8-e830-4d02-a676-b494616568a2@lunn.ch>
 <6967c46a.5d0a0220.1ba90b.393c@mx.google.com>
 <9340a82a-bae8-4ef6-9484-3d2842cf34aa@lunn.ch>
 <aWfdY53PQPcqTpYv@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWfdY53PQPcqTpYv@lore-desk>

> In the current codebase the NPU driver does not need to access the WiFi PCIe
> slot (or any other external device) since the offloading (wired and wireless)
> is fully managed by the NPU chip (hw + firmware binaries).

Are you saying the NPU itself enumerates the PCI busses and finds the
WiFi device?  If it can do that, why not ask it which PCI device it is
using?

Or this the PCI slot to use somehow embedded within the firmware?

Or is it simply hard coded in the NPU silicon which slot to use?

   Andrew

