Return-Path: <netdev+bounces-257403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIzYHQlShWmV/wMAu9opvQ
	(envelope-from <netdev+bounces-257403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:29:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38155F94F7
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D6BA3031AF4
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 02:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D49262FF8;
	Fri,  6 Feb 2026 02:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G59MsqOe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04378CA4E;
	Fri,  6 Feb 2026 02:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770344888; cv=none; b=r83sHf+i3nkSoDUbbBlNJuyF0woYnDy1mXuE1F8btc5Ht3r4jLI1be0H0wi7Cf9XIKRQcTYz3JJ8kSS4K6Z7smiIBwpudLqAD9MBjWpj/S/0diZbVtz/IF65FB23mUXD8D2IBYWvIAjliCrZGxYWd5RHEuMrrUA/NC3dhHFQf8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770344888; c=relaxed/simple;
	bh=I2diVQofdvPJyVuDk36062jQ935YdbEiaG0ZWzMo9Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ejwVsjL5LALsLkhYY/GpGEqE0H/ecfC/khNj9tyll0h17YNrvhZn3Ramp/24AJ+xKflJXmr0xLAME/jDcPtLgR19Y5DR8VtF7mJBO714oEAAr+dM1OX7aXpr/ti2hLdrskv2wPRbPZrulpKiBUN4cF3yvqrXKSg1dSPA8PKCLGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G59MsqOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEB0C4CEF7;
	Fri,  6 Feb 2026 02:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770344887;
	bh=I2diVQofdvPJyVuDk36062jQ935YdbEiaG0ZWzMo9Eg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G59MsqOetC91MDNrvE6jfwAJM04OyXFUR4PlSV3n1vc1wZyGU+OD8C61uFohPtVF6
	 Lfbc5+O91P9AmKgk8MiGIuG4q11N0KVnrKQAKrnfkfixka2UJSAt1PIhmgcDAIonFD
	 qOD3K977ZwA2BEqVPuHWcRQgNqLK0vQQhd2IoWHW0s86VbjyiY0TZvf7llE9hSSeIa
	 zWxIqojtCbqQ1iit6zp2JtbbEqomfIA35nitdFNyTOFZeMae09/dAnDuYJEEAxNqZS
	 C9tHGyQa9J2cdXlxqFLSUcBldepwBqNj5Pb1F1nmZHx1xiq5zmEXkSAAKM4ez/0YyC
	 qUUQLNSUJYLJw==
Date: Thu, 5 Feb 2026 18:28:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lukasz Majewski <lukasz.majewski@mailbox.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [net-next v23 2/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20260205182805.196fd832@kernel.org>
In-Reply-To: <20260204232135.1024665-3-lukasz.majewski@mailbox.org>
References: <20260204232135.1024665-1-lukasz.majewski@mailbox.org>
	<20260204232135.1024665-3-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257403-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,gmx.net];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:email,mailbox.org:email]
X-Rspamd-Queue-Id: 38155F94F7
X-Rspamd-Action: no action

On Thu,  5 Feb 2026 00:21:30 +0100 Lukasz Majewski wrote:
> This patch series provides support for More Than IP L2 switch embedded
> in the imx287 SoC.
>=20
> This is a two port switch (placed between uDMA[01] and MAC-NET[01]),
> which can be used for offloading the network traffic.
>=20
> It can be used interchangeably with current FEC driver - to be more
> specific: one can use either of it, depending on the requirements.
>=20
> The biggest difference is the usage of DMA - when FEC is used, separate
> DMAs are available for each ENET-MAC block.
> However, with switch enabled - only the DMA0 is used to send/receive data
> to/form switch (and then switch sends them to respecitive ports).
>=20
> Signed-off-by: Lukasz Majewski <lukasz.majewski@mailbox.org>
> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Transient build failure here:

drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c:1072:32: warning: variable=
 =E2=80=98priv=E2=80=99 set but not used [-Wunused-but-set-variable]
 1072 |         struct mtip_ndev_priv *priv;
      |                                ^~~~

I sent out the AI code reviews while at it, without looking at them.
So please approach them with caution..

