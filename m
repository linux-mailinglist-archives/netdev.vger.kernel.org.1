Return-Path: <netdev+bounces-43373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D8E7D2BFE
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 09:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18306281414
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 07:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F6210954;
	Mon, 23 Oct 2023 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CQ8TadK4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0757B23BE;
	Mon, 23 Oct 2023 07:56:50 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FF5A6;
	Mon, 23 Oct 2023 00:56:48 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3F05C1BF207;
	Mon, 23 Oct 2023 07:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1698047807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FldUiPq2BVMslpj+LMlD/+0WOMlyM3q9lq9JRLhO7T4=;
	b=CQ8TadK4mSFFfHLaFInunrFRvQzMXYmYLy+ebruncOoe0yXYLr2MXaXSlaUwxs2J0hNedI
	FA9qvTLKnW2FMH8g8XmzkpRt2kCqi8Zk7YyzQZni2/v7uhiTSwl27qku0xUCSGK2Zkph+/
	7YIY2fd5uIpMg2XJl2XRBBC2i1X346RcxG4uVEuHAOkAA0KkWegyAQe6rEbXIOBJa5P3nm
	HFm3QMApYRifzOY+fz0EYu5NqLp7zTReO2Nqj7Tqs9IZ0WU0bnrE0B6pKlan/ZZKjfhf/d
	JmDgGnxMvL18mL32D03WxdzGcipTkv0iqbrJ4XKdpZWvdAPuRAA2zjObu/EWEQ==
Date: Mon, 23 Oct 2023 09:56:41 +0200
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v6 12/16] net: Replace hwtstamp_source by
 timestamping layer
Message-ID: <20231023095641.75dd89c6@kmaincent-XPS-13-7390>
In-Reply-To: <20231020184714.3b3816fd@kernel.org>
References: <20231019-feature_ptp_netnext-v6-0-71affc27b0e5@bootlin.com>
	<20231019-feature_ptp_netnext-v6-12-71affc27b0e5@bootlin.com>
	<20231020184714.3b3816fd@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Fri, 20 Oct 2023 18:47:14 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 19 Oct 2023 16:29:27 +0200 Kory Maincent wrote:
> > Replace hwtstamp_source which is only used by the kernel_hwtstamp_config
> > structure by the more widely use timestamp_layer structure. This is done
> > to prepare the support of selectable timestamping source.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> =20
>=20
> Temporarily breaks the build :(
>=20
> net/core/dev_ioctl.c:335:44: error: use of undeclared identifier
> 'NET_TIMESTAMPING'; did you mean 'NO_TIMESTAMPING'? cfg->source =3D phy_t=
s ?
> PHY_TIMESTAMPING : NET_TIMESTAMPING; ^~~~~~~~~~~~~~~~
>                                                   NO_TIMESTAMPING
> include/uapi/linux/net_tstamp.h:18:2: note: 'NO_TIMESTAMPING' declared he=
re
>         NO_TIMESTAMPING,
>         ^

Doh, I forgot to run the in-between patch build procedures. Sorry about tha=
t.

K=C3=B6ry

