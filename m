Return-Path: <netdev+bounces-194021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7D4AC6DDF
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 18:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DBF21884F57
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 16:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6521A28D83B;
	Wed, 28 May 2025 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Hc85KsCc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81816283C8E;
	Wed, 28 May 2025 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748449196; cv=none; b=Bq0F3i8jfIEJwbdZw4URTBsx7u4ffKdo4cUL1vA2LaiU9EqNqCO/8VDA0VJMjFp6/dH1ZPFk++4JvGirvNf7/RV/ieGzQ1k4VrjLa/pzCrazY1ZaX6ot7GsALGVDRRr7OEWL59q87cQhFU3ElnG+SF/Y05V+cIfPJikgfxAzgCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748449196; c=relaxed/simple;
	bh=qXJ+IqF7/m//76C8fW+mrTCbhGzi0qHG48chXP0zz94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I90EvDYROxhb+1NMTk4qjIQyaZfT0/8Z4kCFYc7cEZCY5GgFzWJ5QQ71B7EZE5/KAnIjU5/Fbez8/CbB021WKdWHHAp+//m+ZIVVAspiOPkxh2gzQwbxORHz7nltoYB24gNIJKy+O8dQeOWk28+inkdSVe6j66KkR1TsC7OxRZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Hc85KsCc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HBGgu+PfumtYHtFWP6ldbnKLzKxWqLSqPhfinDYGxe0=; b=Hc85KsCcSxtr3DnRBNcInCYQgN
	kYsvXqr6Nbn3E83MCxyzvZvoeaMyy7CeREfC2jEeEka4CKYj2v4vdvmVrVpc/hDGwG1GR5+39tjLR
	+kHLu7mBmDBE+BXlq2gzNhC5I7Ebf+VyNt8kRBrEa0/Fa4YhRtOm6ahiUHsglAv9HFO4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uKJVE-00EC2y-Ga; Wed, 28 May 2025 18:19:40 +0200
Date: Wed, 28 May 2025 18:19:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Matthew Gerlach <matthew.gerlach@altera.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, richardcochran@gmail.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mun Yew Tham <mun.yew.tham@altera.com>
Subject: Re: [PATCH v2] dt-bindings: net: Convert socfpga-dwmac bindings to
 yaml
Message-ID: <c8ba074c-c689-44f0-9513-59661b12e232@lunn.ch>
References: <20250528144650.48343-1-matthew.gerlach@altera.com>
 <20250528170650.2357ea07@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528170650.2357ea07@fedora.home>

> > +  phy-mode:
> > +    enum:
> > +      - rgmii
> 
> You're missing rgmii-id, rgmii-rxid and rgmii-txid

And it is unlikely anybody actually needs rgmii. rgmii-id should be
the most used rgmii variant.

	Andrew

