Return-Path: <netdev+bounces-180389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF111A812D3
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5DC24E2208
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847F022FF2E;
	Tue,  8 Apr 2025 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fl62+fyw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF1822E3E7
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744130983; cv=none; b=luvl3ayvMUHUUWeBvolvo5SxfU9a1JMcznOHTIjA+bsRtZJhG0v4tGtSJFQAMq9YBXW9C6m57z80zIuiyuGXfhwJkoDjI0rs2PVfOH5dCrCjQ93tSxsXeLdnKIssskSGplyaPcWPCIAZWpGEownXYX8wSChNpYy/zYmc/DhWl3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744130983; c=relaxed/simple;
	bh=docnkBXYdwDwkqgQOlHMc19oD/O+yTnHvXJK4hwfkS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pI+9rbzHuy8INnKR1lwHNh5aXR8yDX4Knl4Ao0WVNeIhF6rn4GpGSUgqfOuwnrZzME9lnenLOPNlqZWer/43CIvf8B9xhjuKD8wmZNlw/j60kR4P0Z178QoKCb6hNVzIZAgwKOK2ywnAKNet3Zyd+MOBdnrBcF7Qb4iK4lYsqpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fl62+fyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70726C4CEE5;
	Tue,  8 Apr 2025 16:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744130982;
	bh=docnkBXYdwDwkqgQOlHMc19oD/O+yTnHvXJK4hwfkS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fl62+fywj4jxzSGT/WAqz9WgAiCtRQOxjtU3zqKUryAI8/J56zLD+j/S8x7rbdkfP
	 qojXTPh0KeuzF9FsVsEWulPUxhWmp9hRfmPdnbGAyowv9FrRG5B6OrE3eHSOoGvGAq
	 HgZq/G8DdzpZmLbHlAL6TsJYjElWds5uj7XjWImoOs5xFQVWIbBjxGUJmGWUSN5mj9
	 CpqQARUdAsrKCsXQS/X/Y1BUWyXCitbkaunxQ/4AHuOauwFYEGlpB7rr9Z03Rt2xxw
	 lCSijPRNvYWoNko4ExexiqSwlPgKk0HlY0G46iijreoI72tpgUBuo4reS6vESobMXN
	 5QmAzWPlxHQ8A==
Date: Tue, 8 Apr 2025 18:49:40 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: airoha: Add l2_flows rhashtable
Message-ID: <Z_VTpBhntxXPncsv@lore-desk>
References: <20250407-airoha-flowtable-l2b-v1-0-18777778e568@kernel.org>
 <20250407-airoha-flowtable-l2b-v1-1-18777778e568@kernel.org>
 <Z/VCYwQS5hWqe/y0@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VqEHdJY9D56yjHxB"
Content-Disposition: inline
In-Reply-To: <Z/VCYwQS5hWqe/y0@localhost.localdomain>


--VqEHdJY9D56yjHxB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Apr 07, 2025 at 04:18:30PM +0200, Lorenzo Bianconi wrote:
> > Introduce l2_flows rhashtable in airoha_ppe struct in order to
> > store L2 flows committed by upper layers of the kernel. This is a
> > preliminary patch in order to offload L2 traffic rules.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> The patch logic and coding style looks OK to me.
> Just one question inline.
>=20
> Thanks,
> Michal
>=20
> > ---
> >  drivers/net/ethernet/airoha/airoha_eth.h | 15 ++++++-
> >  drivers/net/ethernet/airoha/airoha_ppe.c | 67 ++++++++++++++++++++++++=
+++-----
> >  2 files changed, 72 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/eth=
ernet/airoha/airoha_eth.h
> > index ec8908f904c61988c3dc973e187596c49af139fb..57925648155b104021c1082=
1096ba267c9c7cef6 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.h
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> > @@ -422,12 +422,23 @@ struct airoha_flow_data {
> >  	} pppoe;
> >  };
> > =20
> > +enum airoha_flow_entry_type {
> > +	FLOW_TYPE_L4,
>=20
> I didn't find any usage of L4 flow type in the series.
> Is that reserved for future series? Shouldn't it be added together with
> its usage then?

Hi Michal,

FLOW_TYPE_L4 is equal to 0 so it is the default value for
airoha_flow_table_entry type when not set explicitly.
It is done this way to reduce code changes.

Regards,
Lorenzo

>=20
> > +	FLOW_TYPE_L2,
> > +	FLOW_TYPE_L2_SUBFLOW,
> > +};
> > +

--VqEHdJY9D56yjHxB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ/VTpAAKCRA6cBh0uS2t
rGyDAQD+/MiN9rnT3IcrZdxscKWStrcvisFTzqCG87xrS38scwEA1zJ7zNWR7F7M
2jHW6MMsL97uScqhfJbq9aDNi5vn9g4=
=tsCu
-----END PGP SIGNATURE-----

--VqEHdJY9D56yjHxB--

