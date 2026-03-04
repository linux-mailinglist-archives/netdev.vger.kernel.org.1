Return-Path: <netdev+bounces-263955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPUCKqBvqGkkugAAu9opvQ
	(envelope-from <netdev+bounces-263955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 18:45:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8F32055C2
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 18:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1525D303B7E5
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 17:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BE43AE197;
	Wed,  4 Mar 2026 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emJ/6PCZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FD837D121;
	Wed,  4 Mar 2026 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772646036; cv=none; b=B0Itu2+bFtqS851pmyqGmJxVt6BHbhe7xrJvQbJgv4KDqCRhhk0cBG+5uwU/4U9CyZDK8EsZSdPun7kV8AACOrFVqSVpwSaBN9rBYXVMmBX7RrZQ+g2p2biQVJZrAGmAyNvk2WTl9RRejcYoptQkNUH5nYHjB+fZn6jr76H+crM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772646036; c=relaxed/simple;
	bh=hCkPhJrx2/1WYA/oRwpsqd0d0QaHcUC6HribQ9ie+dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBk+mPvm7oC7cZZvRuRW84YPcMWK+B8q26r8Bi3qMUqO/bj/yiwp46JS09OHMsbJ+NBGUqR0Z8a02/U93auIQhs4CuQotL37iygt/UYAw6pfr/FYtIjCG84VfvgzNL+uqApMTLvfZFvHeLdZsKDIWfpPEA8rEd/4AY69azDL3bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emJ/6PCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB9EC2BC86;
	Wed,  4 Mar 2026 17:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772646036;
	bh=hCkPhJrx2/1WYA/oRwpsqd0d0QaHcUC6HribQ9ie+dE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=emJ/6PCZPArsH3IdmX5ktR60ozM0L3x8c756LuAWktgRiTJgOd4AbPSDWCs+FoU46
	 nhPxlMeGNwHbevnYDmXfaaP0n3Uv/Oqlt4oK9hKrObFd6TkoZZ6hXehrMCu6IVm5An
	 gTuJNAaSb5SWgI9vKRkL/CHKyDI22CUI4jaqjw9ll2EpUXW6bTEjGEWISW05DHyPYy
	 3zyQc2Dnvq/1pkW3QmJjtPd27JAKaGuMp5Vf3E3+nOBVDrGdWXvDJYKuMnRmgO0EXm
	 QTYvhJDJuNdOrmBvn+SwyRNKg4qJGk2f1l6ftOez/nF/CtKNKHQmP3F+97p4np2gga
	 YcxWjm8c+TZOg==
Date: Wed, 4 Mar 2026 17:40:31 +0000
From: Conor Dooley <conor@kernel.org>
To: Charles Perry <charles.perry@microchip.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: macb: fix SGMII with inband aneg
 disabled
Message-ID: <20260304-cadet-claim-6c3d967dd4ec@spud>
References: <20260224202854.112813-1-charles.perry@microchip.com>
 <20260224202854.112813-2-charles.perry@microchip.com>
 <20260304-nebulizer-rounding-40fbc81a2ba1@spud>
 <aahI1y0NO9ax/V8J@bby-cbu-swbuild03.eng.microchip.com>
 <20260304-unvented-crinkle-37f0bfd03541@spud>
 <aahkCah1pvuNIy03@shell.armlinux.org.uk>
 <aahrJZyn4wxRapVk@bby-cbu-swbuild03.eng.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LF+siSeyCdUoBYFM"
Content-Disposition: inline
In-Reply-To: <aahrJZyn4wxRapVk@bby-cbu-swbuild03.eng.microchip.com>
X-Rspamd-Queue-Id: 2A8F32055C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263955-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action


--LF+siSeyCdUoBYFM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2026 at 09:25:57AM -0800, Charles Perry wrote:
> Conor,
>=20
> Can you send us a snippet of you device tree showing the gem node and the
> phy?

It's in-tree, mpfs.dtsi and mpfs-icicle-kit-common.dtsi.

--LF+siSeyCdUoBYFM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaahujwAKCRB4tDGHoIJi
0goyAQC9aCUzN2MaIrcCYfT5MSV+7Z1TpwOMCkfjCVq5+U1vKQD8CEnAYJPkEhp2
/1MRPU7oShFinXw1gqNt9eCDr8cpVgg=
=6jGp
-----END PGP SIGNATURE-----

--LF+siSeyCdUoBYFM--

