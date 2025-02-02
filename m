Return-Path: <netdev+bounces-161993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3476CA2500B
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 21:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86F616324B
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 20:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C652144CD;
	Sun,  2 Feb 2025 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWBm2m+/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEB120B81B
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738529949; cv=none; b=lqvDMJ+oicsGeLouA68ZWLgd1wYUURCUtesFmB/VsA85ZjzM3aod2J5ixSP1LpdYPRMTpZmqZ6R132m41XfM4EizD4iELQCvjwP2rx3w9B9fWEtgoo+l7RFSdBfu24k0WlGkVcTh7yZrwGr/WV6SNqerFVyxD8dlw9/OquQogL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738529949; c=relaxed/simple;
	bh=0fQhXOV/qtLxqaoUqitnjipLcPZn+gCBTGRPFO43BTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ut7prD65jEhw5NUyFqeKBtAiRbuoF+VsYnzPsMc36C7epUNZeMPMFAWOvSE/DNlTkKYtPyd4B235k2BvTb6elGSYneDl0XC3TTlS2NktL08IBiClInmKvwtBHt8EhTUghp+lCDeiAYSLzFY+UlgPrkCjHf/53BA9wcLQZiVFFkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWBm2m+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDD7C4CED1;
	Sun,  2 Feb 2025 20:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738529949;
	bh=0fQhXOV/qtLxqaoUqitnjipLcPZn+gCBTGRPFO43BTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hWBm2m+/VWOQ9HtBozi69pKucyVdE9ifG5RRtu6vg4G55Xfr/cYYeGOFDyWhMStWG
	 pDClgClnQR6PyTzDnjoy5AuTVuciR8El/e7GfV8YaVr3zvw7ehX0yEZJ/Azcsq338h
	 +HvI4aIQ+IaQ1+pkHBiwKMT/O4EbBdjEa3iUk13df9ej9mUJLAJMe8OQZDy/TU01+L
	 7tJKO5uqcIYde/BBfFEG11JaKQ0s64qiEB0jUOew1NUw8dwnCNShUajPaW0piT+tzQ
	 u4zLl9KgPrLY7qezU1MI1NjiJIcxhZJLoSHDXC0N773UoMEIOo/3Dpc/7srSX9o7rw
	 TSMgRCrhsIs4A==
Date: Sun, 2 Feb 2025 21:59:06 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, nbd@nbd.name,
	sean.wang@mediatek.com, upstream@airoha.com
Subject: Re: Move airoha in a dedicated folder
Message-ID: <Z5_cmtVmYiNKkpe4@lore-desk>
References: <Z54XRR9DE7MIc0Sk@lore-desk>
 <20250201155009.GA211663@kernel.org>
 <CA+_ehUwFTa2VvfqeTPyedFDWBHj3PeUem=ASMrrh1h3++yLc_A@mail.gmail.com>
 <634c90a1-e671-42ae-9751-fee3a599af20@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3jL9FCI5FvMrsozU"
Content-Disposition: inline
In-Reply-To: <634c90a1-e671-42ae-9751-fee3a599af20@lunn.ch>


--3jL9FCI5FvMrsozU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Hi,
> > may I push for a dedicated Airoha directory? (/net/ethernet/airoha ?)
> >=20
> > With new SoC it seems Airoha is progressively detaching from Mediatek.
>=20
> The vendor name is actually not very relevant. Linux has a much longer
> life than most vendors. Assets get bought and sold, but they keep the
> same name in Linux simply to make Maintenance simpler. FEC has not
> been part of Freescale for a long time. Microsemi and micrel are part
> of microchip, but we still call them microsemi and micrel, because who
> knows, microchip might soon be eaten by somebody bigger, or broken up?
>=20
> > Putting stuff in ethernet/mediatek/airoha would imply starting to
> > use format like #include "../stuff.h" and maybe we would start to
> > import stuff from mediatek that should not be used by airoha.
>=20
> obj-$(CONFIG_NET_AIROHA) +=3D airoha_eth.o
>=20
> #include <linux/etherdevice.h>
> #include <linux/iopoll.h>
> #include <linux/kernel.h>
> #include <linux/netdevice.h>
> #include <linux/of.h>
> #include <linux/of_net.h>
> #include <linux/platform_device.h>
> #include <linux/reset.h>
> #include <linux/tcp.h>
> #include <linux/u64_stats_sync.h>
> #include <net/dsa.h>
> #include <net/page_pool/helpers.h>
> #include <net/pkt_cls.h>
> #include <uapi/linux/ppp_defs.h>
>=20
> I don't see anything being shared. Maybe that is just because those
> features are not implemented yet? But if there is sharing, we do want
> code to be shared, rather than copy/paste bugs and code between
> drivers.
>=20
> Maybe drivers/net/ethernet/wangxun is a good model to follow, although
> i might put the headers in include/linux/net/mediatek rather than do
> relative #includes.

I do not think we can reuse many code from MTK codebase since, even if the
Packet Switch Engine (PSE)/Packet Processor Engine (PPE) architecture is
similar to MTK one (you can find a diagram here [0]), Airoha SoC runs a NPU
to configure the PPE module and we can't access the hw directly as we do
for MTK. Moreover, the PPE entry layout is slightly different and we could
reuse just some MTK definitions. For these reasons I guess it does not worth
to have a structure similar to wangxun's one (lib + hw specific code), maybe
just move the driver in a dedicated folder? (e.g. drivers/net/ethernet/airo=
ha)

Regards,
Lorenzo

[0] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/com=
mit/?id=3D23020f04932701d5c8363e60756f12b43b8ed752

>=20
> 	Andrew


--3jL9FCI5FvMrsozU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ5/cmgAKCRA6cBh0uS2t
rPHzAQCjRDtWa42Xr7ZAZSo1atAcgh3r/2EjeQSIiFI407B++wEAtISrMF9xnrr3
enR8A9CM7onabJiwycemZRWTGJP5xwg=
=fbaa
-----END PGP SIGNATURE-----

--3jL9FCI5FvMrsozU--

