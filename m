Return-Path: <netdev+bounces-275007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id p+fONvqqz2lCzAYAu9opvQ
	(envelope-from <netdev+bounces-275007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:56:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 439AA393D67
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78FF93016AE8
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 11:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4993BED0C;
	Fri,  3 Apr 2026 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLufVd3z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FED43BC670;
	Fri,  3 Apr 2026 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775217394; cv=none; b=CiCqEXpelk2Z9MPCPydpkZ02E18pKImDvMk4Zl4CWkQRtFvfEsCqWgLBdQ4x1A6CcU4/tCIEJpjsKpMrRre2g70O5mOjIga20WxuY0h+NamJxqB0PX0DbS4WnVeFIXirbLXMbVDGcMX3HBNdG6ww5BRc8SHZzBlXj2+QELMWC8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775217394; c=relaxed/simple;
	bh=9l7YRnXiJeaUSputbifksPPi0XaXtllvN3GOhiFO6oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wg7/uRao3z49jGQ4yyvZCYtmTLUnIJfj7gug1FVM+ceuL2rKXOvkk4j+ekE0Zaz+7zdc4XBy0f+UFQnMOlBDyaJbSaYvsPWUyxEZXOcF/2ngPZ0ZI35vWaWrMWZPM0/dfAM/CDuax6muNAuxcD9YByyLC7sfEGYY9SYs0d9xr/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLufVd3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3A6C4CEF7;
	Fri,  3 Apr 2026 11:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775217393;
	bh=9l7YRnXiJeaUSputbifksPPi0XaXtllvN3GOhiFO6oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLufVd3zXy9jubkTC9dwkw2QYzwtvaWjru+m4ZdRkawSNi9+nrDNC6gUO4mGVS6/R
	 gkBybMRFcG6wp9frSh1UrnRTFmFAIWeWQ6JjhxrMtKfvi/L8jlqp4jSjvl7EXEDDzs
	 ZtNPjIHE0ChL+R5ThH0m0bg+INk64ahwnxdcJwFR/q6vQTBSBkwaCRWtjZT24m2vTQ
	 7MxtkfclOy/wmKMdP417H2f+HSQV3sLIh5VH4IlCqqK1iv9HKmpZHIBbN8ejL1uHof
	 f/augOwXmiWn/yGSuidAzKcnlp7ywm1cPXBOrcNHhnI6tgb8ARqohzJKj7eqgaBFB+
	 mw/4aiwR3j/hQ==
Date: Fri, 3 Apr 2026 12:56:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Robin Murphy <robin.murphy@arm.com>,
	Leon Romanovsky <leon@kernel.org>,
	Paul Burton <paul.burton@mips.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Dumazet <edumazet@google.com>, Toshi Kani <toshi.kani@hp.com>,
	Christoph Hellwig <hch@lst.de>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Johan Hovold <johan@kernel.org>, alexander.stein@ew.tq-group.com,
	andrew@codeconstruct.com.au, andrew@lunn.ch,
	andriy.shevchenko@linux.intel.com, astewart@tektelic.com,
	bhelgaas@google.com, brgl@kernel.org, davem@davemloft.net,
	devicetree@vger.kernel.org, driver-core@lists.linux.dev,
	hkallweit1@gmail.com, jirislaby@kernel.org, joel@jms.id.au,
	kees@kernel.org, kuba@kernel.org, lgirdwood@gmail.com,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	linux@armlinux.org.uk, mani@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, robh@kernel.org
Subject: Re: [PATCH v3 8/9] driver core: Replace dev->of_node_reused with
 DEV_FLAG_OF_NODE_REUSED
Message-ID: <fdbe1d8b-d323-414d-a705-cf2dbafe2fcc@sirena.org.uk>
References: <20260403005005.30424-1-dianders@chromium.org>
 <20260402174925.v3.8.I806b8636cd3724f6cd1f5e199318ab8694472d90@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7NZIk4CoO0re4Kx0"
Content-Disposition: inline
In-Reply-To: <20260402174925.v3.8.I806b8636cd3724f6cd1f5e199318ab8694472d90@changeid>
X-Cookie: The Korean War must have been fun.
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275007-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,rowland.harvard.edu,arm.com,mips.com,intel.com,google.com,hp.com,lst.de,ozlabs.ru,ew.tq-group.com,codeconstruct.com.au,lunn.ch,linux.intel.com,tektelic.com,davemloft.net,vger.kernel.org,lists.linux.dev,gmail.com,jms.id.au,lists.infradead.org,lists.ozlabs.org,armlinux.org.uk,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 439AA393D67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--7NZIk4CoO0re4Kx0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 02, 2026 at 05:49:54PM -0700, Douglas Anderson wrote:
> In C, bitfields are not necessarily safe to modify from multiple
> threads without locking. Switch "of_node_reused" over to the "flags"
> field so modifications are safe.

Acked-by: Mark Brown <broonie@kernel.org>

--7NZIk4CoO0re4Kx0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnPqucACgkQJNaLcl1U
h9BRKQf+LiK4wJzBJvOcF8tPspBBv5slh1Rv07RAYfhsMajrfvb91fBup9erBnC7
uop2lhbeef3E4GYUNM3af2BFUVTr6Q2yQsCgV5p3nED9j4EZmCsCSp3X0Hbcc+S1
RmxEf3FESw5jl5dAifyRzEtHhqMmQoiJiWHstiX08tmRvb230IM4SoMj9/XTx/hJ
qZLOPBhvbwfqLgqtzR6YbvKHy+eG/muzoWEC6sNgi5JBsNQEeCY0Dp4nSfxbN1i6
VGMAgiL64FDOsOQ3BG7hFoQ0OFAsOB2CiaPDKh4qopTzS+avykiGQvxzCn4XfBfo
8ZM+Nrnu/VYKm5P6K3uIcHF11UpYhg==
=Rocu
-----END PGP SIGNATURE-----

--7NZIk4CoO0re4Kx0--

