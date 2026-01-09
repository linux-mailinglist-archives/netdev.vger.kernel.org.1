Return-Path: <netdev+bounces-248559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB09D0B81B
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 18:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6546230049E5
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 17:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3CE23BF91;
	Fri,  9 Jan 2026 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o+Zuqulr"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F0633987
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767978214; cv=none; b=lA8itpv1v6qr1bcnb1YUMIJgh0yu4vde3dwGumPmYrql1sZvGzihYB6McOb3HuoTDVroSB4Jh7N24pOFyocQxAQ0qkioGzxmWfOlERVyqlOkEp2NMIL60qkaZCwIQJv69Hpi2UPE1wpw4NU7YcAkCD0izhg3U1md+bgSP0ErzR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767978214; c=relaxed/simple;
	bh=GciVdrLGqKqjZVomSujkQwwcRhzQdjYUEsK3b4k6SLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/FA2I+LmLLfdrT2rQGWSKfO8R3gZkkdTt+Ql0h5Gaa6h1eiOavut3Kak5NjYGmAb4NWFHADvyNeP4SKOp6ga1dtpADW79mDAE7OgFpmGFHZ8L7Z39zeKr3sUVy7/SvC/ncVVMy/cOmsQUwtdnyUMT/5Q5ogAwUQrKO6oJNrw4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o+Zuqulr; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2E07F1A274F;
	Fri,  9 Jan 2026 17:03:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E6CAA606C6;
	Fri,  9 Jan 2026 17:03:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 24B70103C8973;
	Fri,  9 Jan 2026 18:03:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767978209; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=/hirXnvwiKhOFYJfFGbrF0QopFMao6ZvUwkFoSIivM0=;
	b=o+Zuqulr4IGdOCkw5zxI4Hi/+BeICf9grrVTw92/CdCY9W3IhO7GQbN7rleGuTKa+WPuxH
	lfUTAaqAJw7cD50os7W60eNdAiwISgjcJM78jq+xgPn1D/DU1iZRlmsV1fx8LrT/Tb5Qpc
	NWTrIaSBamhSG6Elxk4xzAnUMKtsk5zrfUgoLW/ljGts4Sm8vQfV01qiX70mkpqSmisfMZ
	kCp9ViqUb3MfB/Z6aaB1k5ophAmAeH76Q1Iq+G7hoZyUw/7aMzOx73I4imfUvCK8xuNSHn
	kzLOZ5m9NPpP6UBYiFtWwuyPpYWD38PSGhSGI/+R3VOAzxiKKM70Ooqq1kRCyA==
Message-ID: <0c181c3d-cb68-4ce4-b505-6fc9d10495cd@bootlin.com>
Date: Fri, 9 Jan 2026 18:03:23 +0100
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
 <466efdd2-ffe2-4d2e-b964-decde3d6369b@bootlin.com>
 <397e0cdd-86de-4978-a068-da8237b6e247@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <397e0cdd-86de-4978-a068-da8237b6e247@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jonas,

On 09/01/2026 17:48, Jonas Jelonek wrote:
> Hi Maxime,
> 
> On 09.01.26 16:51, Maxime Chevallier wrote:
>> Hi,
>>
>> On 09/01/2026 11:13, Jonas Jelonek wrote:
>>> Commit 7662abf4db94 ("net: phy: sfp: Add support for SMBus module access")
>>> added support for SMBus-only controllers for module access. However,
>>> this is restricted to single-byte accesses and has the implication that
>>> hwmon is disabled (due to missing atomicity of 16-bit accesses) and
>>> warnings are printed.
>>>
>>> There are probably a lot of SMBus-only I2C controllers out in the wild
>>> which support block reads. Right now, they don't work with SFP modules.
>>> This applies - amongst others - to I2C/SMBus-only controllers in Realtek
>>> longan and mango SoCs.
>>>
>>> Downstream in OpenWrt, a patch similar to the abovementioned patch is
>>> used for current LTS kernel 6.12. However, this uses byte-access for all
>>> kinds of access and thus disregards the atomicity for wider access.
>>>
>>> Introduce read/write SMBus I2C block operations to support SMBus-only
>>> controllers with appropriate support for block read/write. Those
>>> operations are used for all accesses if supported, otherwise the
>>> single-byte operations will be used. With block reads, atomicity for
>>> 16-bit reads as required by hwmon is preserved and thus, hwmon can be
>>> used.
>>>
>>> The implementation requires the I2C_FUNC_SMBUS_I2C_BLOCK to be
>>> supported as it relies on reading a pre-defined amount of bytes.
>>> This isn't intended by the official SMBus Block Read but supported by
>>> several I2C controllers/drivers.
>>>
>>> Support for word access is not implemented due to issues regarding
>>> endianness.
>> This patch should probably be accompanied with a similar addition to the
>> mdio-i2c driver. for now, we only support full-featured I2C adapters, or
>> single-byte smbus, nothing in-between :(
>>
>> Do you have something like this in the pipe ? not that this blocks this
>> particular patch, however I think that Russell's suggestion of making
>> this generic is the way to go.
> 
> I agree to Russell's suggestion and will work on that. Apart from that, I haven't
> considered a similar change for mdio-i2c yet. No issue to deal with that but 
> I think I have no way to test this properly.

ACK, I'll gladly help with testing. This should actually be easily
achievable with a board that has a real i2c interface connected to the
SFP cage, as there's a i2c smbus emulation layer. The SMBus helpers will
work with a true I2C adapter, you may have to tweak the code though.

This is relevant for modules that have a built-in PHY that you can
access, if you don't have any I can run some tests here, I have more
than enough modules...

If you don't have time at all for that, I may give this a shot at some
point, but my time is a bit scarce right now :'(

Maxime



>> Maxime
> 
> Best,
> Jonas


