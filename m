Return-Path: <netdev+bounces-156378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A1CA0638D
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 18:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7173818873D2
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D5F1FFC77;
	Wed,  8 Jan 2025 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QewUZCRo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC411FF1A5;
	Wed,  8 Jan 2025 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357807; cv=none; b=fl8vzDlC9LOt9kKbQdfOF/AfHAkDjX7vPdXppzFj7GZWx/DnJU7qlquMB7/VlvNTRx57oFz7Wn1TKELFnZZrWBXGqcxHMkIHdgjSQRl8igEANPTIOFFBVTGbg8HwxeXPPfOzoLwqWjwJZJs22M+V7Sr//NOq/N8curs9o5nTY3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357807; c=relaxed/simple;
	bh=fUPWWZWsygl+U58W2lAdFfUgtBDcAS6ANTeaEo9s32U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxL8aDxa8BffAbAeX58TU/0fndohi9VIo7QMWt2+d6xEpqSr+E1GavTvsiVvNbgz3NuePLzt0uybNjtpeO3mGKR4LJZaEaa1OUJvSK0E/dxdcgl+oZxCkOIu2jJxHBmxhWvMwmQYsADrRV/n3hmYHcFLdVz9OsUq4vBK0rFzgv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QewUZCRo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06A7C4CED3;
	Wed,  8 Jan 2025 17:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736357806;
	bh=fUPWWZWsygl+U58W2lAdFfUgtBDcAS6ANTeaEo9s32U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QewUZCRo8zyOil4xVNbevjHkojmmsFsHaawW2D6s1bySbSPlXs9R1N4qE8cQX6tID
	 2Zu+gfiZVKwiv6oAIORxfpqkEqtg0NUc8+O/0aXprYcqRS/xSn6tzOLv5VtsZQwcoW
	 XehQhgIzRhv0qKm5y1yrED9oc0fE8LOhpPTL11RF4cY0EHYjge63kuMSMxH4LL/TZ1
	 ZO3a4Q4stezJxRD1LNXQQpgYGwZ+giGors7v8ueNACsHP3vSgWnncvJ+zYEPXQp65i
	 DHvWKrBB1QK4RcE+yOqAVsHWLnsshD2j4TNZ+AUryyVBRCCzUTvDnB6TQiIU2Hq/55
	 PwMVFYElBIr/A==
Date: Wed, 8 Jan 2025 09:36:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 08/14] net: pse-pd: Split ethtool_get_status
 into multiple callbacks
Message-ID: <20250108093645.72947028@kernel.org>
In-Reply-To: <20250108102736.18c8a58f@kmaincent-XPS-13-7390>
References: <20250104-b4-feature_poe_arrange-v1-0-92f804bd74ed@bootlin.com>
	<20250104-b4-feature_poe_arrange-v1-8-92f804bd74ed@bootlin.com>
	<20250107171554.742dcf59@kernel.org>
	<20250108102736.18c8a58f@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Jan 2025 10:27:36 +0100 Kory Maincent wrote:
> > Is there a reason this is defined in ethtool.h? =20
>=20
> I moved in to ethtool because the PSE drivers does not need it anymore.
> I can keep it in pse.h.
>=20
> > I have a weak preference towards keeping it in pse-pd/pse.h
> > since touching ethtool.h rebuilds bulk of networking code.
> > From that perspective it's also suboptimal that pse-pd/pse.h
> > pulls in ethtool.h. =20
>=20
> Do you prefer the other way around, ethtool.h pulls in pse.h?

No, no, I'd say the order of deceasing preference is:
 - headers are independent
 - smaller header includes bigger one
 - bigger one includes smaller one

> Several structure are used in ethtool, PSE core and even drivers at the s=
ame
> time so I don't have much choice. Or, is it preferable to add a new heade=
r?

=46rom a quick look it seemed like pse.h definitely needs the enums from
the uAPI. But I couldn't find anything from the kernel side ethtool.h
header it'd actually require (struct ethtool_c33_pse_ext_state_info
can be moved to pse.h as well?).

Anyways, it's not a major issue for existing code, more of forward guidance.

