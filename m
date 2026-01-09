Return-Path: <netdev+bounces-248547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96456D0B13B
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 16:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED9703080367
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 15:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DDE3612D6;
	Fri,  9 Jan 2026 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2EoYfzll"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB2F15E8B;
	Fri,  9 Jan 2026 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767973878; cv=none; b=imXNOawNhreGOVI9CUYAKbsoLsnFkJK8hjr92zcfd9mLRI9ADUVVVZDdn57z4pEp6bsJo6FypJppJQCZqvJmpzSYX70Tx0ieyxJZyUPK5iA64b0x8VmHLasqx1r3bpiNFWrugbzhZ2+DoNO9XzyAjpHqBvOx0bYVNgFA6EXiU7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767973878; c=relaxed/simple;
	bh=y0HorsxF5/QlD0Y6FNqzItbMDkDlt4gkOHeAjGt9EZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RE+i21v1ozd/iMi0IzmDKXaSBQbjve3sCDonpg4VSvVGQZlC4B/0DfJzpM9L+z4DKSdNn3fcRgWaEkSS5+vr+ddLHhFSd+9nMPDZcOXhUfMKIX1N15eWJsuN8WzMYNSSIOfMybf1a4wlv9f9VfEV86PdqJj7EAmJcGqUl1C/VRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2EoYfzll; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C8D694E41FFA;
	Fri,  9 Jan 2026 15:51:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 89A14606C6;
	Fri,  9 Jan 2026 15:51:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CDD11103C8945;
	Fri,  9 Jan 2026 16:51:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767973872; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=6I/Ni4wQII7DZWXM60ziK85lLsB02CaOXjvT8C5MYpY=;
	b=2EoYfzll3JUwSnCNxdGEdCy/8USUoJS40cPkZWtnIq45CXjKlxjyReZ1DmhPX8PgUwMeWS
	4CGDcuysNh67wCN42NEv9Yd95Cn1AaSt6fFiVsg+rSdVtVipgtpZ6luiiFiFDOsYIlzGh8
	URmAgelq0kYnXKTHUb+Iw+zcmcvfzQeKY7/4XKZ5ZIFGIMCQRhukR14aYMkfGWMuSjdq6e
	mSTWK6iKsU1YcauJRWDaO7JCG5lf7bCQ55803DiqIMEBVQqJ8z+PTXayGoRkVv/otIS9Gv
	xE886CYR7XyNDOiCLKUcqhi4sfskyEsgMMzhBqn/hjU3kzKvvtdB6LvfDiaKew==
Message-ID: <466efdd2-ffe2-4d2e-b964-decde3d6369b@bootlin.com>
Date: Fri, 9 Jan 2026 16:51:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net: sfp: add SMBus I2C block support
To: Jonas Jelonek <jelonek.jonas@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
References: <20260109101321.2804-1-jelonek.jonas@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260109101321.2804-1-jelonek.jonas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 09/01/2026 11:13, Jonas Jelonek wrote:
> Commit 7662abf4db94 ("net: phy: sfp: Add support for SMBus module access")
> added support for SMBus-only controllers for module access. However,
> this is restricted to single-byte accesses and has the implication that
> hwmon is disabled (due to missing atomicity of 16-bit accesses) and
> warnings are printed.
> 
> There are probably a lot of SMBus-only I2C controllers out in the wild
> which support block reads. Right now, they don't work with SFP modules.
> This applies - amongst others - to I2C/SMBus-only controllers in Realtek
> longan and mango SoCs.
> 
> Downstream in OpenWrt, a patch similar to the abovementioned patch is
> used for current LTS kernel 6.12. However, this uses byte-access for all
> kinds of access and thus disregards the atomicity for wider access.
> 
> Introduce read/write SMBus I2C block operations to support SMBus-only
> controllers with appropriate support for block read/write. Those
> operations are used for all accesses if supported, otherwise the
> single-byte operations will be used. With block reads, atomicity for
> 16-bit reads as required by hwmon is preserved and thus, hwmon can be
> used.
> 
> The implementation requires the I2C_FUNC_SMBUS_I2C_BLOCK to be
> supported as it relies on reading a pre-defined amount of bytes.
> This isn't intended by the official SMBus Block Read but supported by
> several I2C controllers/drivers.
> 
> Support for word access is not implemented due to issues regarding
> endianness.

This patch should probably be accompanied with a similar addition to the
mdio-i2c driver. for now, we only support full-featured I2C adapters, or
single-byte smbus, nothing in-between :(

Do you have something like this in the pipe ? not that this blocks this
particular patch, however I think that Russell's suggestion of making
this generic is the way to go.

Maxime

