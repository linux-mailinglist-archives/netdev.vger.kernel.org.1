Return-Path: <netdev+bounces-140744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A699B7C9D
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 15:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688201C209B1
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 14:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B628584A52;
	Thu, 31 Oct 2024 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hweOotzg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910F2442C
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730384382; cv=none; b=makxKZKqEU3ErJCav9wdMFneU66HpgT7C1RU9i/15NdFARZ2NPxc4u+KTOtCUCTH/ycgBopiGUcnjhgqrJGavjjBpBwoXme1mCUoHEu4rAaUgfCeV6K9j07ezc4n6WdIkmQ/llgmaP9Q0cirGsqivJbD0hgItDbbEjOrBmLOllY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730384382; c=relaxed/simple;
	bh=kvu/pNOvG5FZT1n14j6qWW3Zde2m2OO4VVYELDoWxLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eChglPr9ybrZ9RmDm/3VNrd5479d9y/g834rFrQKt4D1Fw6Hm7Wd3Tbx5gVPSaZpcKDYpXdGLrdRqAbazdcKO2VxZaPSEZolL6hZFGXhkDR58QB0/xEVgnJFwUtTuaAJeVWMSoyh+jumpOCJQBBYNO3h93xQ8jfCaAr6Jt2NJS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hweOotzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B5FC4DE00;
	Thu, 31 Oct 2024 14:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730384382;
	bh=kvu/pNOvG5FZT1n14j6qWW3Zde2m2OO4VVYELDoWxLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hweOotzgnuI9+0LQv5EEgRrxW1sbD7PYRwnhXQ/oob00uYp/8wQSBdNsbmXLoXW3z
	 w0PNTun9kUlvk0MSVq1qwYyN+9KrsnxZFcAVXxv6zyZvSMPnAwyWciEu56CspyATly
	 7doJePMC60ihjAdOCbqyWeNP1ieKEk3SkJd97lkUxxfv5L3ScubAaqT3avOKvWpmS6
	 C/hxgxp40ZbOQFdQiH8GhrIym7r/SIm+3CEffsSrZLWklQCN7bt8mCw8xrpgH2zJ/x
	 /UwyJts0qWVgyk+FB05Dp3M04QH8SnHM7wYRdlHuHF2yta/160nHRhPEp1xJe3m0cc
	 V3Nd12DRz+moQ==
Date: Thu, 31 Oct 2024 15:19:39 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: dsa: mt7530: Add TBF qdisc offload support
Message-ID: <ZyOR-w_KtIXk0ug6@lore-desk>
References: <20241030-mt7530-tc-offload-v1-1-f7eeffaf3d9e@kernel.org>
 <a66528bd-37cb-46b2-90e5-37b10dfa9c78@arinc9.com>
 <ZyM5CPfQYHc_Eolh@lore-desk>
 <d2776a19-5176-4ce4-9306-273ec7cda0a6@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ysKMVCDzL0oWX2I+"
Content-Disposition: inline
In-Reply-To: <d2776a19-5176-4ce4-9306-273ec7cda0a6@arinc9.com>


--ysKMVCDzL0oWX2I+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 31/10/2024 11:00, Lorenzo Bianconi wrote:
> > > On 30/10/2024 22:29, Lorenzo Bianconi wrote:
> > > > Introduce port_setup_tc callback in mt7530 dsa driver in order to e=
nable
> > > > dsa ports rate shaping via hw Token Bucket Filter (TBF) for hw swit=
ched
> > > > traffic. Enable hw TBF just for EN7581 SoC for the moment.
> > >=20
> > > Is this because you didn't test it on the other models? Let me know if
> > > that's the case and I'll test it.
> >=20
> > yep, exactly. I have tested it just on EN7581 since I do not have any o=
ther
> > boards for testing at the moment. If you confirm it works on other SoCs=
 too,
> > I can remove the limitation.
>=20
> Seems to be working fine on MT7530. As we have tested this on the oldest
> and newest models that use this switching IP, I'm going to assume it will
> work on the other models as well. You can remove the limitation. Also,
> please change MT7530_ERLCR_P and MT7530_GERLCR to MT753X_ERLCR_P and
> MT753X_GERLCR.

ack, thx for testing. I will fix it in v2.

Regards,
Lorenzo

>=20
> tc qdisc add dev lan4 root tbf rate 10mbit burst 10kb latency 50ms
>=20
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-5.00   sec  5.88 MBytes  9.85 Mbits/sec    4             sen=
der
> [  5]   0.00-5.00   sec  5.50 MBytes  9.23 Mbits/sec                  rec=
eiver
>=20
> tc qdisc del dev lan4 root
>=20
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-5.00   sec   469 MBytes   786 Mbits/sec    0             sen=
der
> [  5]   0.00-5.00   sec   468 MBytes   785 Mbits/sec                  rec=
eiver
>=20
> tc qdisc add dev lan4 root tbf rate 11mbit burst 10kb latency 50ms
>=20
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-5.00   sec  6.38 MBytes  10.7 Mbits/sec    6             sen=
der
> [  5]   0.00-5.00   sec  6.00 MBytes  10.1 Mbits/sec                  rec=
eiver
>=20
> tc qdisc del dev lan4 root
>=20
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-5.00   sec   467 MBytes   783 Mbits/sec    0             sen=
der
> [  5]   0.00-5.00   sec   466 MBytes   783 Mbits/sec                  rec=
eiver
>=20
> tc qdisc add dev lan4 root tbf rate 11mbit burst 10kb latency 50ms
> tc qdisc replace dev lan4 root tbf rate 10mbit burst 10kb latency 50ms
>=20
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-5.00   sec  5.88 MBytes  9.85 Mbits/sec    4             sen=
der
> [  5]   0.00-5.00   sec  5.50 MBytes  9.23 Mbits/sec                  rec=
eiver
>=20
> Ar=C4=B1n=C3=A7

--ysKMVCDzL0oWX2I+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZyOR+wAKCRA6cBh0uS2t
rGGrAP43x9ir/OC4Nuio7b+xx3gu7hiiiMPEZ1q8QZZQfNE+cwD/V1qt3XVM+x3Q
oN0FLzDtJ8l0dGS2xaSdjjTcL/hnpwU=
=WgBX
-----END PGP SIGNATURE-----

--ysKMVCDzL0oWX2I+--

