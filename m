Return-Path: <netdev+bounces-227787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93265BB722F
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 16:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B5C19E447A
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 14:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89325221703;
	Fri,  3 Oct 2025 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NrPWvo2o"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1530121FF25
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500820; cv=none; b=b35Dbd2nesvjJ8/dIpOaSM++uXSo5Z3+uAKuGpA6MEOcpJyW1jBiHbJRSc0Pjj0ZWlrDC/8kape/mxR0Goukl9hynBY6EpF/JwgPSj9NFA3e1LKSTkVUrwoB2Bd8t9PXkpPhuFvfcmwkCBcAZd4wgUDiRXuJfOvhXk/SRA0lOug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500820; c=relaxed/simple;
	bh=n/x6EVaL52WGwjURRNip7ggo9XG8UK08CgISeqNYxVY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tWyUIn/YT2VLple3YinqxMWLZVvmBQZr+b7xrP57FRn1a+/9tRtLEIR16haxsJo7bS0ADRTmmo0b+LtsNZ9pPNuUTCxNdJsAYjwNau9cqgSyCqKDyVlzRruS7RjaHfvkn98JtyfXAaAbm1V60x9H4r2fuesphW0t2q0NXkr2KmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NrPWvo2o; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2CF24C00D9B;
	Fri,  3 Oct 2025 14:13:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0B40960683;
	Fri,  3 Oct 2025 14:13:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2F89C102F1C37;
	Fri,  3 Oct 2025 16:13:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759500814; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VKIy8Q4FQ7j0TIEBSO4iFWFW5IKLrwDdUNTo8QQwg2Q=;
	b=NrPWvo2o9OSNQasVQR62GORZj/DrtZvYeL58d9DByMHaScOx5qeq6tYh5Bw4AKp71XPmTs
	Sagu9MYLQF2k/DQS3Sp5kv0qWFo0e2cJZOvQ/eOB+wutH2GnEoK4lJJwGjLbXxhBFZarSB
	lY60fojk8AnssnC9iLLg71MJficVo2slVQmGsVJQhsoDj33s+0UNkqJpRysudZUL4gYWDp
	S1WIa7irOU+5Ia+coMfCx23TYmbq0fbyq5eP2kiroilfv0s4q7jAt3v0xZEflWjWddpapC
	nmXhzUUQtgtbiEKL6BDTdYTfEGC9D6hAm9qiImFHyPMT4qOBrIYTtn510FRf0g==
Date: Fri, 3 Oct 2025 16:13:30 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Florian
 Fainelli <f.fainelli@gmail.com>, Simon Horman <horms@kernel.org>, Romain
 Gantois <romain.gantois@bootlin.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>
Subject: Re: [PATCH net] net: mdio: mdio-i2c: Hold the i2c bus lock during
 smbus transactions
Message-ID: <20251003161241.5da55da1@kmaincent-XPS-13-7390>
In-Reply-To: <20251003070311.861135-1-maxime.chevallier@bootlin.com>
References: <20251003070311.861135-1-maxime.chevallier@bootlin.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Fri,  3 Oct 2025 09:03:06 +0200
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> When accessing an MDIO register using single-byte smbus accesses, we have=
 to
> perform 2 consecutive operations targeting the same address,
> first accessing the MSB then the LSB of the 16 bit register:
>=20
>   read_1_byte(addr); <- returns MSB of register at address 'addr'
>   read_1_byte(addr); <- returns LSB
>=20
> Some PHY devices present in SFP such as the Broadcom 5461 don't like
> seeing foreign i2c transactions in-between these 2 smbus accesses, and
> will return the MSB a second time when trying to read the LSB :
>=20
>   read_1_byte(addr); <- returns MSB
>=20
>   	i2c_transaction_for_other_device_on_the_bus();
>=20
>   read_1_byte(addr); <- returns MSB again
>=20
> Given the already fragile nature of accessing PHYs/SFPs with single-byte
> smbus accesses, it's safe to say that this Broadcom PHY may not be the
> only one acting like this.
>=20
> Let's therefore hold the i2c bus lock while performing our smbus
> transactions to avoid interleaved accesses.
>=20
> Fixes: d4bd3aca33c2 ("net: mdio: mdio-i2c: Add support for single-byte SM=
Bus
> operations") Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.=
com>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

