Return-Path: <netdev+bounces-259787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBNsJo/hmGmHNwMAu9opvQ
	(envelope-from <netdev+bounces-259787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 23:34:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B9D16B411
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 23:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0FBF3037164
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 22:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA07310631;
	Fri, 20 Feb 2026 22:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNXx+2cP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0749F30DEDC;
	Fri, 20 Feb 2026 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771626811; cv=none; b=eG9FqyA5vwgi2+ffPJsN8taVj3OsZDZcvVpgoIdBWHxr+/pWtDcajN7NIdVH7aaAvDEA27ic1/BbZjQm8Fo2mxxmgnmSU+f987y/AtaUTYFDO/gbhEiKcIIUpS57iAdxnDhZQiTFFgBTBA5TCvNnV3zW6L7TlWdjjq/sNo2nt9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771626811; c=relaxed/simple;
	bh=G9PuysDIOK/utZRbimCSxhU/vbP4rAjGxg+IEV+ae54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJiikRKCs21wmC2tx4J+V3S9hhKxLujz13GCa+K6K08FaDW+GKeICW6YFZmdJNvHq/Zn/k82WfpZloH5a1TTUK2sCcBRNcDTIEKpUvlU3EqYuT1Nedub3MVfEMpcc87wIjzokZ+IL65cRF+cSXgSZowDZfHjneZgwNuvyofo8Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNXx+2cP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A792BC116C6;
	Fri, 20 Feb 2026 22:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771626810;
	bh=G9PuysDIOK/utZRbimCSxhU/vbP4rAjGxg+IEV+ae54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SNXx+2cPe2NT7jVmcXy7HE3rBU8gwmDxq6hL5mJOFf02N4LMXhG1I18E9a/bDBo95
	 bAJraTFMNy6JFmPIPfqhegVu1VGFhNE2uSGy55whYy+FUwAoN5DewVQyGoDpuOhobf
	 NFa2rAV4bDOUAvjlRUTrjN7Nku+/Y60InifvB2G4kLa15yfaqv1cbAowVl0KDPzxpd
	 1S2NqywtjlmmBwP3q6HCNJzF0BXLIX9WBZdS+5o0c/yOsaIWeMgCWdEy61WpIHoUG5
	 Z86BcMyrkXz1EE9ram94kvly2XqDkzL6Ry0uy8W/82ZixMUrF8iNARRjT6ndArXMDH
	 pDvQDdqyzrLIA==
Date: Fri, 20 Feb 2026 22:33:24 +0000
From: Conor Dooley <conor@kernel.org>
To: Max Hsu <max.hsu@sifive.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Thomas Gleixner <tglx@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 2/5] dt-bindings: interrupt-controller: Add SiFive
 FU740-C000 PLIC
Message-ID: <20260220-outdoors-shortwave-1d96b888d6c2@spud>
References: <20260220-fu740-v1-0-c8af54130c58@sifive.com>
 <20260220-fu740-v1-2-c8af54130c58@sifive.com>
 <20260220-contest-ambiguity-1a4099520bdf@spud>
 <CAHibDyy1mA2s9_UjKGPemRaKNSvyq07Ok5+4yruQ1uXX+R-Pkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1+7JBjJXa3ddPAxb"
Content-Disposition: inline
In-Reply-To: <CAHibDyy1mA2s9_UjKGPemRaKNSvyq07Ok5+4yruQ1uXX+R-Pkg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259787-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E7B9D16B411
X-Rspamd-Action: no action


--1+7JBjJXa3ddPAxb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 21, 2026 at 02:49:19AM +0800, Max Hsu wrote:
> On Fri, Feb 20, 2026 at 09:23:18 +0000, Conor Dooley wrote:
> > So do the general rules for devicetree bindings, that's not something
> > SiFive specific FWIW.
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Thanks for the review and the ack, Conor.
>=20
> I'll update the commit message in v2 to reference the general device
> tree conventions.

It's fine as-is, was just pointing out that this is a general guideline.
The SiFive document is mostly about the naming of the fallback
compatibles etc that represent the IP core, rather than the soc-specific
part.

--1+7JBjJXa3ddPAxb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZjhNAAKCRB4tDGHoIJi
0iSNAP9hJhb7PGWy2jnnfpHwcJa19CkzkGwxwor9OoYtlCtP7AEAwzDYTk1Mm1E8
1RRVikALQOU4P5c2hFz7flV/0fZGfws=
=WXTM
-----END PGP SIGNATURE-----

--1+7JBjJXa3ddPAxb--

