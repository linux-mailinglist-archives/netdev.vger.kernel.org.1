Return-Path: <netdev+bounces-144957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71179C8E62
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B122286EA9
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA68117B4EC;
	Thu, 14 Nov 2024 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="G7yxOFWL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C645674D;
	Thu, 14 Nov 2024 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598187; cv=none; b=nXwC6hUQkXfuOIjmpp0Qz04kArR0SgE4EerZ94UXVw2r3VwmOwq9bdxdzmMb5LIP/KvZsjatFx9rzZJ8v/K4iwy/VoTXAlVo6g887OK9ewQ9NAhZYPduaZY6iI0dyUEzmpdAoY9VJ7QoQ5kTre7j9MThgBRMnYI0MeVcLNs62cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598187; c=relaxed/simple;
	bh=7n44/lPFV5rLRFjWlIbC4VGm/9gmdnzkglBlySRJ47o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JT6Ojqpgg7npMlrEVeix/80fZ6oS7hfLB5tRDRw6vYaICHHNCr/LLemQGo+Jo2JO+vDVed2juwB7jgvtECUJ6X/KPyNX1gzp13HtF8H64/AoEhiGUDxYsRMkxq1e7Mxwgd1mNRhqFq0Ogr4WEOfuUVlrPtLfc90R0mMnh7aHKd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=G7yxOFWL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=L5NNmxoIrWnV5LsjCwamFbSUE5DffIpqUp06lnEtS80=; b=G7yxOFWLO2WIS3PCkUu9g+3Xoj
	FTF3zD3g2z2XDIZZSb6diFYSU/D6fuhJGmig7n7BZzboBux53qw2RGbou659C4wINFjCJtAW8DeMT
	F+acUHQ9ECoG4JNF0nFHZMyRuJMd9so+MOtIEJ+iDdE0E8+yRIA8B3dUq1m1B4Trpf7I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tBbmr-00DJSY-Po; Thu, 14 Nov 2024 16:29:37 +0100
Date: Thu, 14 Nov 2024 16:29:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: sff,sfp: Fix "interrupts"
 property typo
Message-ID: <00acd3f9-d6c5-49ff-91af-1613b8c309b5@lunn.ch>
References: <20241113225825.1785588-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113225825.1785588-2-robh@kernel.org>

On Wed, Nov 13, 2024 at 04:58:25PM -0600, Rob Herring (Arm) wrote:
> The example has "interrupt" property which is not a defined property. It
> should be "interrupts" instead. "interrupts" also should not contain a
> phandle.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

