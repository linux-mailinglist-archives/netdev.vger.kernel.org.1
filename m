Return-Path: <netdev+bounces-168234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C078A3E339
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 19:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9FE17D39E
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F78D1FECC1;
	Thu, 20 Feb 2025 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EvigQLSJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B551914A82;
	Thu, 20 Feb 2025 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074552; cv=none; b=txM77xDLN5UVlI06lVZmClKeiWDk4l6IlQHkM2oyXeZNB/FDjX6SSKF0qfN5DiEzafqbByN9rssTC0OgPXA9vhIuQnTorqmzj7ru37QY/qAK6jxaQgRIWJ9QO6KaVfEM6BPzV3iuGltYrxf97lb0BmqajxXYfGdNapSk1jrpO0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074552; c=relaxed/simple;
	bh=E1pGQyaQr3qlO+uwIw1KGJtc0UZ1uS9xhmAjaRu6vBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5kezf0EzScfF58V0fBwae0k8EdhG7GjWi4Vsyv8K5TpBj69qT//5S/H+sxlDn3FpMkyl+Qbdf39Zw/qOqZw6loFV/9vNBtO9hoVHmfug/QKpTbUY3QVqGi7t4qJPyWKmAnupgDIh279LaWRRryPXubsN7oOFDIYfedbUenVjuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EvigQLSJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=naD3nFUkCeAMKrIyhX8nL89Xs8uS7yXZfKUtxRZ6Ugk=; b=EvigQLSJCJIxRjxn/+fHbBAPjH
	Mxg3BU5VBBzWSi1tLco3h3dE1AsEbqaePq57I+v512IJe269b0yN8RgA8lGRJxT7u9a0XAQM0xE0t
	1Uk2++/9bHc0sQOmKdoz14h4+NDS37AVDuq61LVmb8WrS0WNHt8eQ+mVI5H4Z5fepw8Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tlAsF-00G2k7-9g; Thu, 20 Feb 2025 19:02:11 +0100
Date: Thu, 20 Feb 2025 19:02:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: j.ne@posteo.net
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: net: Convert fsl,gianfar to YAML
Message-ID: <771e89d6-60e7-4fc6-a501-b6349837cfe7@lunn.ch>
References: <20250220-gianfar-yaml-v1-0-0ba97fd1ef92@posteo.net>
 <20250220-gianfar-yaml-v1-3-0ba97fd1ef92@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220-gianfar-yaml-v1-3-0ba97fd1ef92@posteo.net>

> +examples:
> +  - |
> +    ethernet@24000 {
> +        device_type = "network";
> +        model = "TSEC";
> +        compatible = "gianfar";
> +        reg = <0x24000 0x1000>;
> +        local-mac-address = [ 00 E0 0C 00 73 00 ];

That is a valid Motorola MAC address. It is probably not a good idea
to use it in an example, somebody might copy it into a real .dts file.
Typically you use 00 00 00 00 00 00 so there is an empty property the
bootloader can fill in with a unique MAC address.

	Andrew

