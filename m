Return-Path: <netdev+bounces-263692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLRZOPT7p2mvnAAAu9opvQ
	(envelope-from <netdev+bounces-263692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:31:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DDB1FD9CC
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA6B43033E59
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 09:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D583976BC;
	Wed,  4 Mar 2026 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nM++lJkf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796143976AA;
	Wed,  4 Mar 2026 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772616665; cv=none; b=cusH7L4SHkWCnx8FQYNSiR/5xFAetMsakZwPwJm1xscfPta9lIGhd59cJiqbZQ7ExYd4cLAQLuBTSWmF5ngipduWy/BrammaTbG4Z8tphdI4s61FLGGWZwv4JYwPrmFD9gqe3sm2fw2dRO16+R/545Rf4pixryRQDfZZfhyOSFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772616665; c=relaxed/simple;
	bh=zgQE9FPg79NGedD2qfd8rrEbgmI4ffrc7T2hh1mMJGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeXd8RtlH9DxsE1jO4OE8IAvyzMKyrf7S1a/PL5i6v7uMhVf2tbLdAoTVpMwGgIiV/AldPGZgVm1LT2aqQ/IIqmXj57j4C8vDUNK/ifU2EEHJhtQ2CJOVLqCD1a+4AxUVm0CzRZVN+WRVUPeE5FrrduGFz1yke0qh7k3GHvAt2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nM++lJkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99223C19425;
	Wed,  4 Mar 2026 09:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772616664;
	bh=zgQE9FPg79NGedD2qfd8rrEbgmI4ffrc7T2hh1mMJGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nM++lJkfi0p1/jKfOa1D+SffAY8be/O9gEmD2PT9ZTwuqGwVM1VSkTvzj+W7HiYE/
	 u1bt9hSCZdXwGoyy71KOHeyUeE5T5BQ3/LHCed27eQcXArBchaxw7NyiRKJUB4FunA
	 HBgTGF2hDdooYslK8PIhi4PWwpvCin/mEoz/9Op0AHUHIPgnIGgTUlNLnu/Rioj8x1
	 /6RhEweeWR2ms7D/bxvbWrFo+/ISYanwH6djArYLBHXYdakBjHdtP0GeovKHxhhCQJ
	 JE7u1UuyeHI73A1i7yFg5/TPmB28KzDjkCncr8WDbuGtARNrAmf02o7AGBos5Je4C4
	 hYKrLmEEfy1sQ==
Date: Wed, 4 Mar 2026 09:30:57 +0000
From: Conor Dooley <conor@kernel.org>
To: Bo Gan <ganboing@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, lizhi2@eswincomputing.com,
	devicetree@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	wens@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com
Subject: Re: [PATCH net-next v3 1/3] dt-bindings: ethernet: eswin: add clock
 sampling control
Message-ID: <20260304-capable-setback-908ba5b5c858@spud>
References: <20260303061525.846-1-lizhi2@eswincomputing.com>
 <20260303061637.872-1-lizhi2@eswincomputing.com>
 <20260303163846.156d18f7@kernel.org>
 <20260304-regulate-verdict-c3a361d2dc83@spud>
 <05a15890-392c-41c3-9566-8eb506ddfe5f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VyT/OApBJ2ELuMkj"
Content-Disposition: inline
In-Reply-To: <05a15890-392c-41c3-9566-8eb506ddfe5f@gmail.com>
X-Rspamd-Queue-Id: E1DDB1FD9CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263692-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,eswincomputing.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,einfochips.com];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[eswincomputing.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action


--VyT/OApBJ2ELuMkj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2026 at 05:23:18PM -0800, Bo Gan wrote:
> Hi All,
>=20
> On 3/3/26 16:47, Conor Dooley wrote:
> > On Tue, Mar 03, 2026 at 04:38:46PM -0800, Jakub Kicinski wrote:
> > > On Tue,  3 Mar 2026 14:16:37 +0800 lizhi2@eswincomputing.com wrote:
> > > > There are currently no in-tree users of the EIC7700 Ethernet driver=
, so
> > > > these changes are safe.
> > >=20
> > > What do you mean by this sentence? The commit under Fixes was part of
> > > Linux v6.19 already.
> >=20
> > The "funny" thing is that caring about users doesn't even really matter
> > on the devicetree patch, except for this hunk:
> > |@@ -81,7 +99,9 @@ properties:
> > |                          or external clock selection
> > |           - description: Offset of AXI clock controller Low-Power req=
uest
> > |                          register
> > |+          - description: Offset of register controlling TXD delay
> > |           - description: Offset of register controlling TX/RX clock d=
elay
> > |+          - description: Offset of register controlling RXD delay
> > |
> > | required:
> > |   - compatible
> > And it only matters here because an item is injected mid-list. If this
> > was moved to the end with the RXD delay, the **dt-binding** changes
> > don't have issues with safety. I've not looked at whether there are
> > knock-on concerns about users in the driver or whatever yet, but from a
> > binding POV only that hunk can break something that currently works.
>=20
> This was already discussed here in v1:
> https://lore.kernel.org/lkml/e7183ae1-8b8b-4e77-9f4e-3bc1b4b63556@lunn.ch/
>=20
> The device-tree is not checked in yet by ESWIN folks, so there's currently
> no user of the dt-binding. No need to worry about backward compat.

The binding and driver exist, there doesn't need to be a dts in tree for
there to be potential users. If the break was important I might not
care, but this seems to be a gratuitous break, since the new items could
be added to the end of the list and compatibility maintained without
incurring any more difficulty for you.

--VyT/OApBJ2ELuMkj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaf70QAKCRB4tDGHoIJi
0t+yAQDaqUwbBXUnRZdznNlE9A9+14ZFfzPctlXgnLmjDlK8KQEAznLn0a9hkqF9
NpmQ3RerxFbR3zZlgJKl/8p/5oYxngk=
=yS9x
-----END PGP SIGNATURE-----

--VyT/OApBJ2ELuMkj--

