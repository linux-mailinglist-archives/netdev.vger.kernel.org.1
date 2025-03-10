Return-Path: <netdev+bounces-173615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B04ACA5A1F8
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 19:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4583C1884184
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 18:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5945234984;
	Mon, 10 Mar 2025 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="nVBDurFU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-70.smtpout.orange.fr [80.12.242.70])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D1B2356DA;
	Mon, 10 Mar 2025 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630514; cv=none; b=R7C7ujM+pFIGNG4MWHoTi3WgKtU2X+4eiSnx70bhZxm7IsqvBcJuA3bCKfi4N0sf2IQ43+W1m2QUKHDUlnOz/8Mm3KtuBcuA1BQReoIrum4bWnm2WPujmKQpiUVYcXACyAtTRyOKmCaJwAS/lVUWPzfduYrteqP98z6YmHIJ69c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630514; c=relaxed/simple;
	bh=7uL5ZmR9eqpqABbNyHdQiScorxeToFNyfHq3wBewTFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=byDLZcad64Ba+VH9sZaNj3UdQWPDAIsPaatX+wO8zgCEyObNn4puGU/q28Ilzhg9M+V8lRdpl9fAfJy5ODEIoDTV1SuyNtgz0Emz0eNyu58ky5yzwSB/KkBkk49KzZxCuMymBK5y3igm7+bYscBuHkRw6dzfPBbYu6cgcr89G6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=nVBDurFU; arc=none smtp.client-ip=80.12.242.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id rhW1t3ie5TOr6rhW5tb3js; Mon, 10 Mar 2025 19:06:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741629982;
	bh=WMRX0mNpYOtHYTyQMB9DnGlTp5zfxDqIujyHCenYZGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=nVBDurFUW6yoBONmf6n1QGzDRUs8Ilm53aR81Wn/NLb7Toz7f9TsmjM+aWzu6vjEU
	 rPKC08lHZdLiZgUTWxcVxy/oOxn/L696t9gCC3KvoM5g8UpvfgHAD4Lk5DeGhTrLKV
	 z8HzRZB1JI7+VTl6mCvPU1i4kr84lKnRM6d4mRp3ZP+xtJ6IXPceivyApSZXr/D/oI
	 kHter8T7bQ+JmSNCqlYFBY5H17SMDeJ60918smfsGv458M3Xh+LgYNOSg8U+7Z8DIV
	 q3EIAF6bu9rUQ2oKgjds7QC56EU0ZBgfupl+G1oin2Ll6tQjM6/mf/IDQc8xqzEHwf
	 5z2CtBKXxzU7g==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 10 Mar 2025 19:06:22 +0100
X-ME-IP: 90.11.132.44
Message-ID: <3514933e-0fdd-4f1e-b1e4-b72a638edfc8@wanadoo.fr>
Date: Mon, 10 Mar 2025 19:06:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9] net: mdio: Add RTL9300 MDIO driver
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 sander@svanheule.net, markus.stockhausen@gmx.de
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20250309232536.19141-1-chris.packham@alliedtelesis.co.nz>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250309232536.19141-1-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 10/03/2025 à 00:25, Chris Packham a écrit :
> Add a driver for the MDIO controller on the RTL9300 family of Ethernet
> switches with integrated SoC. There are 4 physical SMI interfaces on the
> RTL9300 however access is done using the switch ports. The driver takes
> the MDIO bus hierarchy from the DTS and uses this to configure the
> switch ports so they are associated with the correct PHY. This mapping
> is also used when dealing with software requests from phylib.

...

> +	fwnode_for_each_child_node(ports, port) {
> +		struct device_node *mdio_dn;
> +		u32 addr;
> +		u32 bus;
> +		u32 pn;
> +
> +		struct device_node *phy_dn __free(device_node) =
> +			of_parse_phandle(to_of_node(port), "phy-handle", 0);
> +		/* skip ports without phys */
> +		if (!phy_dn)
> +			continue;
> +
> +		mdio_dn = phy_dn->parent;
> +		/* only map ports that are connected to this mdio-controller */
> +		if (mdio_dn->parent != dev->of_node)
> +			continue;
> +
> +		err = fwnode_property_read_u32(port, "reg", &pn);
> +		if (err)
> +			return err;
> +
> +		if (pn >= MAX_PORTS)
> +			return dev_err_probe(dev, -EINVAL, "illegal port number %d\n", pn);

While checking for illegal port numbers, does the following make sense:

	if (test_bit(pn, priv->valid_ports)
		return dev_err_probe(dev, -EINVAL, "duplicated port number %d\n", pn);

> +
> +		err = of_property_read_u32(mdio_dn, "reg", &bus);
> +		if (err)
> +			return err;
> +
> +		if (bus >= MAX_SMI_BUSSES)
> +			return dev_err_probe(dev, -EINVAL, "illegal smi bus number %d\n", bus);
> +
> +		err = of_property_read_u32(phy_dn, "reg", &addr);
> +		if (err)
> +			return err;
> +
> +		bitmap_set(priv->valid_ports, pn, 1);

set_bit(pn, priv->valid_ports) ?

> +		priv->smi_bus[pn] = bus;
> +		priv->smi_addr[pn] = addr;
> +	}

...

CJ

