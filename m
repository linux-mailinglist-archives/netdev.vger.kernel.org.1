Return-Path: <netdev+bounces-100167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D73988D8008
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 12:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7455A1F21BB4
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 10:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68178175B;
	Mon,  3 Jun 2024 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="J7yOWHhs"
X-Original-To: netdev@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC72107A8
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 10:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717410778; cv=none; b=nv8bzBfDCu6i32I0oJpwhFyk0s2+OAHspnmUmQQhC0GYYNh/SUi7/QzALw456TgpokOibb8w/wcJSG4xc89NlVdDzMloDTrMWVCeAJN1w/LtKprYuiUkfWOEU608Agm1d+I3Ah29JssRWpawym1kzUUmgF+U94tffOwF1q8gc3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717410778; c=relaxed/simple;
	bh=f/NEvHh40tpuSFE1MHBOUXb7sNP4hG/Bs32my0ug3pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilI66hFnDaefm52X8Hyh08fVpUINkfz9HPG0WDWHX+rXGLsnxhVFUR/UnbCrYYmsm2hVApzi4Jp1Bgo14S6CXd4NGTls1G/MtbffF1//mf8Q3EIQCilYnjI3wwj0Guc6a3RkcNo33e57n/NJmMV6jdl+W4H96taCMkTPLgBmxHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=J7yOWHhs; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=f/NE
	vHh40tpuSFE1MHBOUXb7sNP4hG/Bs32my0ug3pY=; b=J7yOWHhs7QLyKiXM4S8z
	VZlZT4+jzUl6ioh9e3ug2w1ah1+VuO2InvMXeGVqLxA4SOnBGd+5VsYuvzJp7kNz
	3WFoahWSDA6tTkRCxpiZnUDJf71cHdOCpxkYBkGTxUgZZqNYDHYvy3CcHy4H3Shj
	ZG3qYEABpqfi2zyGGLnzBakSI+sCPT3SWTO0uqK2uoYzjEXISlAnp4CPomliDPav
	4/mYGryCe2itLVCmzmnyAGLylU12dkC03g4sGRviq5ZYlDmuDkjkUtYG52vGb3mF
	q695fQXTH7jHucsUN21aWHCQbBJofOoqk0p5GWnbZyinIb+FsXo5oBsenaZExE//
	qQ==
Received: (qmail 1921517 invoked from network); 3 Jun 2024 12:32:54 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2024 12:32:54 +0200
X-UD-Smtp-Session: l3s3148p1@7+4j2/kZEL4gAwDPXzLGAH1eNELjOc3g
Date: Mon, 3 Jun 2024 12:32:54 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] can: rcar_canfd: Improve printing of global
 operational state
Message-ID: <v64dgu7ogdnsviwois2qtj2rhix7ucalfwhf7f3ywspi2egaan@f6gsr5aqncl5>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org
References: <cover.1716973640.git.geert+renesas@glider.be>
 <14c8c5ce026e9fec128404706d1c73c8ffa11ced.1716973640.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tyntc7e66w6odslp"
Content-Disposition: inline
In-Reply-To: <14c8c5ce026e9fec128404706d1c73c8ffa11ced.1716973640.git.geert+renesas@glider.be>


--tyntc7e66w6odslp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 11:12:14AM +0200, Geert Uytterhoeven wrote:
> Replace the printing of internal numerical values by the printing of
> strings reflecting their meaning, to make the message self-explanatory.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Yes, useful!

Reviewed-by: Wolfram Sang <wsa@kernel.org>


--tyntc7e66w6odslp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZdm9YACgkQFA3kzBSg
KbZ12Q/7BgWg7TlyQOPIM4PFm3RkSv+9vMZ9uKrAAhsmPmrTnUm5w2hQ7ig0e6Yn
H4FK8PioGANtsWn+sAPLqcelHCKpNZWUUrqSN+yRq47jXpgmvCTQXtXlXQ/dVVWy
SnccbJsj8sPztaTPb4h3NFUAA0zqRMz/oIkYxUpQ9m0lcXt60oxegAr/XsHrctxE
Z3bC+MgjUU5P7qIQOGF2ov5ANAaIqjEvbVFuzTJmhHclD1eY/zBUHWtg1geHKLIu
lSzRtPUuXIjzM2PzWseuPB1r3jyb6m9BBLvX5MD/ssn7Qd5nJTUXLVlUpxT9WngF
oUKaoJQVehpr6IpyZg+6EsvNyUNo9RPSn7y4i7kbD8ffudQhsL0aoIxHpdr1tEHp
5rr5oVyJPlW8UL5SGALH7yUJKXqB2meJ1coGV+IbnHR0ts0boeDywnGxLKGvMyOn
5+9u/GSP0illZzFSVYjcBGMon+yimhPIuNNm4ZYnCeWKf5wQEl3WwTqiAA1U+i6b
858Vbx3YsCzHJZGuN6saqHn7kFQ2hxYn2Gi3ClN76rygt8tb0XvUnGNJjoArsfmZ
0y4QB49k77aeD7MGhszI5nnurVTC99sAn8HymLs++6rZXZNxV0TeQc2TYrwElmeX
Y3UNu0pcRBRJgVFHKz/MKrqoJRrN//joRudGy4GumRf3tLCJcrE=
=vUmM
-----END PGP SIGNATURE-----

--tyntc7e66w6odslp--

