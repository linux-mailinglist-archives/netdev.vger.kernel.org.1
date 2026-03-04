Return-Path: <netdev+bounces-263503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIksNCuBp2liiAAAu9opvQ
	(envelope-from <netdev+bounces-263503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:47:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7312E1F8FDF
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CED0D303D3AE
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 00:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E98288A2;
	Wed,  4 Mar 2026 00:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZaJQBWf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B263368B2;
	Wed,  4 Mar 2026 00:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772585257; cv=none; b=j+owKV7G3xh0qxP47Dj8bJUQWXZ/SET0CinE6M9axu59+wPs5iBIbAl21BGzBTpQER3q/wQzJtjAwSiD1OxHaq6XFO+5kY9aFEtsAlpo4dYJ3zjK0w/z+1ojUsTfThhB3Oz2B8ArlFTc0bg4X8xCg0GCO9RW3P9Ej4mlcJVu94U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772585257; c=relaxed/simple;
	bh=VEGMSRMtXAwgbfeBbhQcBofXpQkKRT5Z8WZUKMAOX38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgRIpM8HK1tm5hyoMQks3IUK2y7phykIzKI50uGFSGs1OTp9u+MsHopM/FyaqInuLiBg0pGoWJaxiNrzLRH/320JSKxc6v0vzwKsW1ncGFp02axT1ADaOHB6Dfxzbtj+qmh4q/+1wrlwxepBeiuR/K88S+TcD4aUtF+6SmDeMZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZaJQBWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5DFC116C6;
	Wed,  4 Mar 2026 00:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772585257;
	bh=VEGMSRMtXAwgbfeBbhQcBofXpQkKRT5Z8WZUKMAOX38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QZaJQBWf7I8pmM/6ZJ4zsjSzJtGhNzRQE6CD4S1mVPptzvU/6lH5lK8jz1yZcE6aK
	 8jUhYVTgqb11gUtPxlHSWCwda8ZbzIiwrTf/c53SMBUVMOHQanGyjhk19++FuPBuJs
	 fa1mxb80xnM3SlGfrqHNVe9jsJvcDgBPlX58Kzxf9bqQX4tXXEXVzFdJwgyNf+UXIF
	 u/xPYkslfzvWDmu7HVBpCgGeQAHf6yc4fXQYuBNNjFDtxE/7mR5ihpWfSK/OsEd1l3
	 rYRnIwMbo5TDY5eYzknl5po8kxlFYRVVAY5icWA35cWhpmZxc+XJltgxnLgmby7Ds/
	 iDBIVJkaQy47g==
Date: Wed, 4 Mar 2026 00:47:29 +0000
From: Conor Dooley <conor@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: lizhi2@eswincomputing.com, devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, wens@kernel.org, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com
Subject: Re: [PATCH net-next v3 1/3] dt-bindings: ethernet: eswin: add clock
 sampling control
Message-ID: <20260304-regulate-verdict-c3a361d2dc83@spud>
References: <20260303061525.846-1-lizhi2@eswincomputing.com>
 <20260303061637.872-1-lizhi2@eswincomputing.com>
 <20260303163846.156d18f7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/4ukRtYrJaxUNGkn"
Content-Disposition: inline
In-Reply-To: <20260303163846.156d18f7@kernel.org>
X-Rspamd-Queue-Id: 7312E1F8FDF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263503-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[eswincomputing.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,einfochips.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[eswincomputing.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action


--/4ukRtYrJaxUNGkn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2026 at 04:38:46PM -0800, Jakub Kicinski wrote:
> On Tue,  3 Mar 2026 14:16:37 +0800 lizhi2@eswincomputing.com wrote:
> > There are currently no in-tree users of the EIC7700 Ethernet driver, so
> > these changes are safe.
>=20
> What do you mean by this sentence? The commit under Fixes was part of
> Linux v6.19 already.

The "funny" thing is that caring about users doesn't even really matter
on the devicetree patch, except for this hunk:
|@@ -81,7 +99,9 @@ properties:
|                          or external clock selection
|           - description: Offset of AXI clock controller Low-Power request
|                          register
|+          - description: Offset of register controlling TXD delay
|           - description: Offset of register controlling TX/RX clock delay
|+          - description: Offset of register controlling RXD delay
|=20
| required:
|   - compatible
And it only matters here because an item is injected mid-list. If this
was moved to the end with the RXD delay, the **dt-binding** changes
don't have issues with safety. I've not looked at whether there are
knock-on concerns about users in the driver or whatever yet, but from a
binding POV only that hunk can break something that currently works.

> > Fixes: 888bd0eca93c ("dt-bindings: ethernet: eswin: Document for EIC770=
0 SoC")

--/4ukRtYrJaxUNGkn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaeBIQAKCRB4tDGHoIJi
0s/JAP9KQAUavWCtxHELp6gO3nomV9WLzwNt5Y73djyNLOwyAgEA/SUoSqFcn6jk
jbiDfJ6siMbhpiAGPUA8gLzHNWUGhQI=
=2KxI
-----END PGP SIGNATURE-----

--/4ukRtYrJaxUNGkn--

