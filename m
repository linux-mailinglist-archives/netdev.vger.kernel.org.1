Return-Path: <netdev+bounces-214232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BA1B28929
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 02:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63251CC0C17
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 00:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9771FC3;
	Sat, 16 Aug 2025 00:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MjkUJ0rH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3992010957;
	Sat, 16 Aug 2025 00:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755303516; cv=none; b=tyX/UeOMbyZ2IjAWRqqjpZ2jvJ4ty77NQ+1okIZ42upr1LGI6ckfQlknync78x8+wHBc1QxIwRUlLXRks2/+OoKAe0eyRSrqsJh2BfkBPxzrRIk0S8iRcDZagBRAuMDE1S+U2Vi2QSZpEo6Jh2JrKhFN2xUfX+ebMQSrPvUTWUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755303516; c=relaxed/simple;
	bh=5egSqttg+zhq6JKFgoxyFAWXu1lGsjRBE1PauwRUfEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2NcnnGIBDj0NyqUhQyaAvFEO7OXsKHiY1ePzpHQ60pCyoiBIylXeQkqrZSePMDpemEBy89KliKRzvZvhf1P/fLRlr7qhOm3mDewFRWeboxZ+ZcPjGCs7IdttWiZ94vPY4He1MvbfdCqjetOxr38yAFSZh7y01ejzus+ySlEGXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MjkUJ0rH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ko1+mkIT7bYw/SCpq1gobXQboTLe77dTl2YpjhZDnOs=; b=MjkUJ0rHyoIO3POmly8MKNLxXJ
	QukjgnljN238hKfTozbtCWOkWH1TbCHqkwGF93WO2rTZEp6j4wuBiM+1VotuN11KwomVIRtIAWj3i
	I16/wXcHg91xSLB0Xd0EQQfESYZ8kjsMIM0LsBh1UOlwc/3YEZjRLYYx6c1FIgfIHcUI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1un4co-004sJx-5R; Sat, 16 Aug 2025 02:18:22 +0200
Date: Sat, 16 Aug 2025 02:18:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Artur Rojek <contact@artur-rojek.eu>
Cc: Rob Landley <rob@landley.net>, Jeff Dionne <jeff@coresemi.io>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: j2: Introduce J-Core EMAC
Message-ID: <ee607928-1845-47aa-90a1-6511decda49d@lunn.ch>
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
 <20250815194806.1202589-4-contact@artur-rojek.eu>
 <973c6f96-6020-43e0-a7cf-9c129611da13@lunn.ch>
 <b1a9b50471d80d51691dfbe1c0dbe6fb@artur-rojek.eu>
 <02ce17e8f00955bab53194a366b9a542@artur-rojek.eu>
 <fc6ed96e-2bab-4f2f-9479-32a895b9b1b2@lunn.ch>
 <7a4154eef1cd243e30953d3423e97ab1@artur-rojek.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a4154eef1cd243e30953d3423e97ab1@artur-rojek.eu>

> Yes, it's an IC+ IP101ALF 10/100 Ethernet PHY [1]. It does have both MDC
> and MDIO pins connected, however I suspect that nothing really
> configures it, and it simply runs on default register values (which
> allow for valid operation in 100Mb/s mode, it seems). I doubt there is
> another IP core to handle MDIO, as this SoC design is optimized for
> minimal utilization of FPGA blocks. Does it make sense to you that a MAC
> could run without any access to an MDIO bus?

It can work like that. You will likely have problems if the link ever
negotiates 10Mbps or 100Mbps half duplex. You generally need to change
something in the MAC to support different speeds and duplex. Without
being able to talk to the PHY over MDIO you have no idea what it has
negotiated with the link peer.

	Andrew

