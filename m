Return-Path: <netdev+bounces-90391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369548ADFF0
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 10:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677CE1C228F4
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 08:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D04954FA0;
	Tue, 23 Apr 2024 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAWWlpyO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AC454913
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861647; cv=none; b=igze1H9A7hfgJwSKdl3H1+tpUbOSFztjs5j7hyI/1lojmphpIBUVBKNwXlamlk9UWic3B34Dx9dJe81496BWfZ6FgItsozXcIkkKeaEuTfwtDoC9ureexFXeP5I246QyhdOMwf67TQqD4QFiw/HguZz7i2100SoMT+nfwqfZOMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861647; c=relaxed/simple;
	bh=/3NNL8E9rqu/KD80ikV6+qb39GR/qDWlCsxfeJ5iKGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=di0Eh4SqTUQmGRNmbGIOqppCM8x8DnI6GZhOqrL5bJLciy9tj2sLwc9rwKDt1wgcSLr9H+iJAeSRpKNZg4XyJCVpfc7jZ5pgyekkQ8hHnaQk5e5svi8Xao3oSWgSG1Qmkmk0jBtZbfnlGGERb5+mlO6EBKsGBW5bepq+Cw1ca+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAWWlpyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71FAC116B1;
	Tue, 23 Apr 2024 08:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713861646;
	bh=/3NNL8E9rqu/KD80ikV6+qb39GR/qDWlCsxfeJ5iKGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IAWWlpyOKY4DHt7wpx20/u5OmEOwSQPG/YYJXP5XUqw07q2HmsfRrO9cGsEs1MXq4
	 iEIV0Mumke0OEKBi4llmHf78L0WyK5I/ZXM8a/52cQBOWxJJ8rfWd6RNKpeaFvXl3T
	 hRgXj8hT+SlYmbES+pv+G5guWM+3OoTk6URAHP3M8FXD84hFpA5gvI/Amw2e44i74i
	 Hk0CcjEA0L+oW6xIJcj/+ZZbV0I/kMI+La1qtL1hXMyiao55kKx7jOQUbfImR1nwzd
	 mRNXhd6aEtQwGMANOQOG2zNYMz4JfSEVtbbI5gU8n9Cqozrg6Z86x5fxEyM4O4UE/7
	 gUoX8b1AOlUPQ==
Date: Tue, 23 Apr 2024 10:40:41 +0200
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: netdev@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Raju
 Lakkaraju <Raju.Lakkaraju@microchip.com>, Frank Wunderlich
 <frank-w@public-files.de>, Simon Horman <simon.horman@corigine.com>, Andrew
 Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next 2/2] net: sfp: enhance quirk for Fibrestore
 2.5G copper SFP module
Message-ID: <20240423104041.080a9876@dellmb>
In-Reply-To: <ea9924d3-639b-4332-b870-a9ab2caab11c@gmail.com>
References: <20240422094435.25913-1-kabel@kernel.org>
	<20240422094435.25913-2-kabel@kernel.org>
	<ea9924d3-639b-4332-b870-a9ab2caab11c@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Apr 2024 07:54:39 +0200
Eric Woudstra <ericwouds@gmail.com> wrote:

> On 4/22/24 11:44, Marek Beh=C3=BAn wrote:
>=20
> > Frank, Russell, do you still have access to OEM SFP-2.5G-T module?
> > It could make sense to try this quirk also for those modeuls, instead
> > of the current sfp_quirk_oem_2_5 =20
>=20
> It was part of the previous patch-set until and including v2:
> "rtl8221b/8251b add C45 instances and SerDes switching"
>=20
> Note that it does:
> 	sfp->id.base.extended_cc =3D SFF8024_ECC_2_5GBASE_T;
> As the OEM modules have not set this byte. We need it, so that we know
> that the sfp_may_have_phy().
>=20
> After v2 I have dropped it, as it would break functioning some sfp-module=
s.
>=20
> As OEM vendors know the eeprom password of the Rollball sfp modules,
> they use it in any way they want, not taking in to account that mainline
> kernel uses it for unique identification.
>=20
> Vendor 1 sells "OEM", "SFP-2.5G-T" with a rtl8221b on it.
> Vendor 2 sells "OEM", "SFP-2.5G-T" with a yt8821 on it.
>=20
> So on the OEM modules, we cannot rely solely on the two strings anymore.
>=20
> Introducing the patch, would break the modules with the yt8821 on it. It
> does not have any support in mainline.
>=20
> Also any code I found for the yt8821 is C22 only. And even more, even
> though we are facing with an almost similar MCU, RollBall protocol does
> not work. I think it is almost the same mcu, as it responds to the same
> eeprom password, and also the rollball password does something, but not
> give the expected result.
>=20

What about I2C address 0x56?

I noticed that the Fibrestore FS SFP-2.5G-T with the realtek chip
also exposes clause 22 registers, but the current mdio-i2c driver wont
work, because the module implements the access in an incompatible way
(we would need to extend mdio-i2c).

Eric, can you check whether the motorcomm module exposes something on
address 0x56? With i2cdump, i.e. on omnia:
  i2cdump -y 5 0x56
(you will need to change 5 to the i2c controller of the sfp cage).
What does it print?

Marek

