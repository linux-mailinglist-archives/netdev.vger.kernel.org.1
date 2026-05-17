Return-Path: <netdev+bounces-288695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBxMDqdoCWouYwQAu9opvQ
	(envelope-from <netdev+bounces-288695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 09:05:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7F555F97A
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 09:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B73093009CE3
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 07:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A93A30596F;
	Sun, 17 May 2026 07:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="a8dBa3UY"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C331D2FE56F;
	Sun, 17 May 2026 07:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779001507; cv=none; b=Si0a2u4WSBelYTiqIwLjKgP/7+LlMHee96/MSlxOf9UfhwNmwvP0ojBMfTozifbh87NZYUPHYLPvrPeS0f7hmHZIIe9RjtOslS6CeQSjaTwZ7xL4yYiZsc/fTKkgR8m5PvFXWc2/8yyCmz7p8j8VXbWRO+9+ALRW3DLnsg20Uow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779001507; c=relaxed/simple;
	bh=DWQ5ZaUVofMOuDdmYgrDHa0mOV3/SOqI62+qZdxC5wU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=EamuvSmdqbNZ6jWEfQg/9XXA5V3Lts9R6inHL1OEHTnJwPQ2Ql2FD9NBlTg76JKXFhUA6IuIbSRpt6kymrJGbcsx/XAOZHtq1uAU87k0QozH80u2Koy2XPKN87eyE0DgpXdLsYd0hPLd5VcgsJkbNO7v4p8qM2O68IPWT4X3hRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=a8dBa3UY; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B6AD1A03A9;
	Sun, 17 May 2026 09:04:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1779001494; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pFeBYRizKV6K71+3q3fTFs33sI9qE9UPh7FEnkLXwcs=;
	b=a8dBa3UY7384Sd7z/2YJaRaRnmrBuKG5EECzv103lf8ic9ORM8Rqj2NyH7Pxk0tDFXZXZX
	TpPymTX2D5YgTTlomyoMrp2wUiklMzf/8g1SEObuk7Q8ookoHMzoeeJeys8MFkmPlEkTR6
	GvY0GzXMNj5m9u1m9cVy/uKj/jiScx5A1Kdjeg+sX3oJd3DdlO7XkaoNimMWQLBNqKAMy0
	eNj2KGXth2AFfURJ8aqiUZKkPoOeUUfONg9mq4gqNy/hj0e99J2jB5sxgABq1VHrqmbNxd
	qu+lH7gcwmQKK8w+7OUwlq42D2qYM9psSYfPc8fnxBjfigFMHwqmaIPrBZSS8w==
Date: Sun, 17 May 2026 09:04:51 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>
CC: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: honor eee_disabled_modes in phy_support_eee()
User-Agent: Thunderbird for Android
In-Reply-To: <c18fa685-0ff6-4783-a26e-aa375df1ed71@lunn.ch>
References: <20260516-devel-phy-support-eee-fix-v1-1-59debc00eda0@tipi-net.de> <c18fa685-0ff6-4783-a26e-aa375df1ed71@lunn.ch>
Message-ID: <4F3CE9FF-E600-4122-8864-8A072C1D225E@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 8E7F555F97A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.65 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-288695-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,pengutronix.de,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Andrew

On May 16, 2026 4:40:25 PM GMT+02:00, Andrew Lunn <andrew@lunn=2Ech> wrote=
:
>On Sat, May 16, 2026 at 06:51:02AM +0200, Nicolai Buchwitz wrote:
>> phy_support_eee() copies supported_eee into advertising_eee
>> unconditionally, overwriting any filtering applied during phy_probe()
>> based on DT eee-broken-* properties or driver-populated
>> eee_disabled_modes=2E MAC drivers that call phy_support_eee() after
>> probe (e=2Eg=2E bcmgenet, fec, lan743x, lan78xx, r8169) then cause the =
PHY
>> to advertise EEE for modes the user marked as broken=2E
>>=20
>> The symptom is that ethtool --show-eee on the local interface reports
>> "not supported" (supported & ~eee_disabled_modes is empty) while the
>> link partner sees EEE negotiated and active=2E
>>=20
>> phy_probe() already filters advertising_eee via eee_disabled_modes
>> after calling of_set_phy_eee_broken()=2E Apply the same mask in
>> phy_support_eee() so the filtering survives the copy=2E
>
>I don't think this not the full fix=2E

You're right, this only fixes the initial behavior on boot=2E

>
>of_set_phy_eee_broken() sets phydev->eee_disabled_modes=2E
>
>genphy_c45_ethtool_get_eee() masks supported_eee with this when
>reporting to user space what is supported=2E
>
>genphy_c45_ethtool_set_eee() will also mask what user space passes in,
>if it is not empty=2E However, if nothing is passed in,
>phy_advertise_eee_all() is used, and that does not make use of
>phydev->eee_disabled_modes, which i think it should=2E

Agree, will fix this in v2=2E

>
>So while your fix seems correct, i don't think on its own, it is
>sufficient=2E Whenever phydev->supported_eee is used, we need to review
>the code and see if it should be masked by phydev->eee_disabled_modes=2E

I will have a look and try to catch all scenarios=2E

>
>    Andrew
>
>---
>pw-bot: cr

Thanks
Nicolai

