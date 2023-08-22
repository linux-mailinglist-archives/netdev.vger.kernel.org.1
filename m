Return-Path: <netdev+bounces-29583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39653783E28
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 12:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFAE6280DCE
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 10:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E588839;
	Tue, 22 Aug 2023 10:45:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD48629A0
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 10:45:43 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867A9FB;
	Tue, 22 Aug 2023 03:45:42 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5E8881C000F; Tue, 22 Aug 2023 12:45:41 +0200 (CEST)
Date: Tue, 22 Aug 2023 12:45:40 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jiri Benc <jbenc@redhat.com>,
	"David S . Miller" <davem@davemloft.net>, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 4/9] vxlan: generalize vxlan_parse_gpe_hdr
 and remove unused args
Message-ID: <ZOSR1KDjz6Qq2eUa@duo.ucw.cz>
References: <20230813161427.1089101-1-sashal@kernel.org>
 <20230813161427.1089101-4-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oOsTmPMt7U6WTNng"
Content-Disposition: inline
In-Reply-To: <20230813161427.1089101-4-sashal@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--oOsTmPMt7U6WTNng
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Jiri Benc <jbenc@redhat.com>
>=20
> [ Upstream commit 17a0a64448b568442a101de09575f81ffdc45d15 ]
>=20
> The vxlan_parse_gpe_hdr function extracts the next protocol value from
> the GPE header and marks GPE bits as parsed.
>=20
> In order to be used in the next patch, split the function into protocol
> extraction and bit marking. The bit marking is meaningful only in
> vxlan_rcv; move it directly there.
>=20
> Rename the function to vxlan_parse_gpe_proto to reflect what it now
> does. Remove unused arguments skb and vxflags. Move the function earlier
> in the file to allow it to be called from more places in the next
> patch.

This seems to be a cleanup/preparation for a patch we don't have
queued for 4.14. Please drop.

Best regards,
							Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--oOsTmPMt7U6WTNng
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZOSR1AAKCRAw5/Bqldv6
8mKhAJ9pUfT+HA5jxPpK61CW88dp4CxlSACaAnSnMayAjI5FG6c2pci1IjKcGy4=
=4ws1
-----END PGP SIGNATURE-----

--oOsTmPMt7U6WTNng--

