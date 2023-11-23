Return-Path: <netdev+bounces-50577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAA87F6293
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 16:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66064B214A0
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 15:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E8835EF4;
	Thu, 23 Nov 2023 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cg4fiPpM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ddJhE6LI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF3FD48
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 07:19:51 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id B2D4121983;
	Thu, 23 Nov 2023 15:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700752789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NbGI01xt+Pd5OK2RBNMpsyqxOx2BIh18clyFB4+XlNU=;
	b=cg4fiPpMlf0G1EjhUJsw8e3YJKtlihxfZs4lgrUjwrbKpYi23I1s2DCY8hP5rSaBEUMjDK
	yFGWxDgl+tTllUqftfKNxwOclhEnaxfyP3yIdomeO/vz5aiBuATKzEK5wxoU7DBClYcZ2z
	RQdBZJBIw8zf9e4riNoOVSv39ZNH+hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700752789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NbGI01xt+Pd5OK2RBNMpsyqxOx2BIh18clyFB4+XlNU=;
	b=ddJhE6LI0FY/1T9tItcUgjbUhM8qaBI+qfwCQCtizzjQlmrZiC5/gWnMesVOJgh7GAT7Sb
	K42U+pxIX+6hQpAg==
Received: from lion.mk-sys.cz (mkubecek.udp.ovpn2.nue.suse.de [10.163.44.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id A55232C15C;
	Thu, 23 Nov 2023 15:19:49 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 222F32016B; Thu, 23 Nov 2023 16:19:49 +0100 (CET)
Date: Thu, 23 Nov 2023 16:19:49 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: Ivar Simensen <is@datarespons.no>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: ethtool module info only reports hex info
Message-ID: <20231123151949.ky37p6fp4mnq6oq6@lion.mk-sys.cz>
References: <AM0PR03MB5938EE1722EF2C75112B86F5B9B9A@AM0PR03MB5938.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2yrbkilqyawnatis"
Content-Disposition: inline
In-Reply-To: <AM0PR03MB5938EE1722EF2C75112B86F5B9B9A@AM0PR03MB5938.eurprd03.prod.outlook.com>
X-Spamd-Bar: +++++++++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of mkubecek@suse.cz) smtp.mailfrom=mkubecek@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [13.66 / 50.00];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 RCVD_COUNT_TWO(0.00)[2];
	 BAYES_HAM(-1.23)[89.43%]
X-Spam-Score: 13.66
X-Rspamd-Queue-Id: B2D4121983


--2yrbkilqyawnatis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 07:42:07AM +0000, Ivar Simensen wrote:
> Hi
> I'm not sure if this is a conscious decision or a bug, but I
> discovered a change of behavior between version 5.4 an 5.16 according
> to get module info from a SFP Fiber connector: "ethtool -m ens5".
>=20
> After upgrading a target from Ubuntu 18.04 to 22.04, I discovered that
> the ethtool just report a hex dump when I tried to verify my fiber SFP
> connectors. In 18.04 I got a report with ethtool. I have tried to
> upgrade from version 5.16 to 6.1 and 6.5, but it did not fix the
> issue. I then downgraded to version 5.4 and now it works again.

Are you sure your ethtool was built with pretty dumps enabled?

Michal

--2yrbkilqyawnatis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmVfbZEACgkQ538sG/LR
dpUdCwgAkANz75YYjHoe4FD/+Aj7I7ym5FaRd9FQiU4Qj0UpriZvwiz1q07e5N2R
8RLDoBp+jbxIzNjuLY3Z04PgJ/sIAmqgFXHAPaAfMX5lmkxdWuff4yFhE+hCD0MG
fE42VJJBEuHlo829r1fZD28SpGWPEqR2xr7bqDMJoxPlqkK8AkfxTSqv3jFds8Cf
IhJA4bg/il/OI1IJrFzRG2jLvShHqSfBrA2y90lnRhS0P1UNyeY7PE/CNndz+6zm
4j0STxG2dlzOuTejvjBAVFhxYX0bh3juNcl5aybtzkki/Cs1SDJVwGlmlPwtRlE7
R2ZLqZXgx+vfr675+OtclmNHtt+WaA==
=Fp6D
-----END PGP SIGNATURE-----

--2yrbkilqyawnatis--

