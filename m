Return-Path: <netdev+bounces-90434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025A88AE1F1
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1ED282B98
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 10:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C3561691;
	Tue, 23 Apr 2024 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfAIxfnP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DF75FB9B
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867450; cv=none; b=hVYOZOyDslYv4eoh+bhDvgBqBDL8xsVrJ1su4o/eeSOi+dOaF8I9mG6GwhRCJMtGRDEUMKl81QChRfkWcHbIocO3OKxRRDCRwCw7mkF4Mi8tPLuQQTH3wsu+MTc+uXJMwblaIFeOOwS8ZI3WpDO3zOaO10fBhrEyQBrNqudbUck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867450; c=relaxed/simple;
	bh=+SmTPpHIcONX84+0Yhu4OPOXl2DIJ1MqWejc0uDXfZY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAdTMtG9ciPV3saosoX90nlhtglf/LNSGr889bKoYNc7BJ65QRmwTNCwAeZ8jehGQFCfQ/9lc8MjucxUBpB1qlzoaCDI8jffHdiIgt5ZvZK3Dnc5EF5PDsCzpM1Cd+9DIQRolXpNwCUzOE5/lZes3iDiSmUBIhyvbtf0QVGXl3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfAIxfnP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4663DC2BD11;
	Tue, 23 Apr 2024 10:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713867450;
	bh=+SmTPpHIcONX84+0Yhu4OPOXl2DIJ1MqWejc0uDXfZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BfAIxfnPK0aUY1va6UAfMPJRPzZiwdVt+RwZlfr3tXXrtKGW34tQuXoXpqS0JyIB/
	 fL9hyXddAOr8bGzZzcG3YTPGHu+cjOTqtJyvZBYwZIy5FQ6ptapxSDJbC5B7gppFpy
	 v5/N4b+d+leTeaIAPGtKnXuu4HrxQLs9BShfA7D/iPKvk1qS6fyXFyHrk7gxl93sUS
	 RihxXTIOgSv7pkJ0+8mSmS5B0/q9OtmtWuhIBjRBx8dNFjFMrVSgP+yisf/jW6nqW/
	 JG9Fo5msXoPOBhsCnU1eye89phGVksx3ztyhDl2hQmNX+CTTQL4B5YaXSxz2QHblse
	 sfHtP2IJj9Yow==
Date: Tue, 23 Apr 2024 12:17:25 +0200
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: netdev@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Raju
 Lakkaraju <Raju.Lakkaraju@microchip.com>, Frank Wunderlich
 <frank-w@public-files.de>, Simon Horman <simon.horman@corigine.com>, Andrew
 Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next 2/2] net: sfp: enhance quirk for Fibrestore
 2.5G copper SFP module
Message-ID: <20240423121725.6539c023@dellmb>
In-Reply-To: <919416c4-334a-42da-8140-3ee85e71c15a@gmail.com>
References: <20240422094435.25913-1-kabel@kernel.org>
	<20240422094435.25913-2-kabel@kernel.org>
	<ea9924d3-639b-4332-b870-a9ab2caab11c@gmail.com>
	<20240423104041.080a9876@dellmb>
	<919416c4-334a-42da-8140-3ee85e71c15a@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Apr 2024 10:51:09 +0200
Eric Woudstra <ericwouds@gmail.com> wrote:

> On 4/23/24 10:40, Marek Beh=C3=BAn wrote:
>=20
> >>
> >> Also any code I found for the yt8821 is C22 only. And even more, even
> >> though we are facing with an almost similar MCU, RollBall protocol does
> >> not work. I think it is almost the same mcu, as it responds to the same
> >> eeprom password, and also the rollball password does something, but not
> >> give the expected result.
> >> =20
> >=20
> > What about I2C address 0x56?
> >=20
> > I noticed that the Fibrestore FS SFP-2.5G-T with the realtek chip
> > also exposes clause 22 registers, but the current mdio-i2c driver wont
> > work, because the module implements the access in an incompatible way
> > (we would need to extend mdio-i2c).
> >=20
> > Eric, can you check whether the motorcomm module exposes something on
> > address 0x56? With i2cdump, i.e. on omnia:
> >   i2cdump -y 5 0x56
> > (you will need to change 5 to the i2c controller of the sfp cage).
> > What does it print?
> >=20
> > Marek =20
>=20
> The device at 0x56 is not up at the time the eeprom is checked and read.
> So when it is time to decide whether to use RollBall protocol or not,
> the data at 0x56 cannot be used.

The fixup function for those modules could enable the module and wait
for the 0x56 i2c address...

> We have more info on i2cdumps on the BPI forum (rtl8221b topic and
> yt8821 topic).


