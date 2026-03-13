Return-Path: <netdev+bounces-267419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDtfBDD1s2nYdgAAu9opvQ
	(envelope-from <netdev+bounces-267419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:29:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DEC2823BB
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F13B30498C8
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF2C3845B5;
	Fri, 13 Mar 2026 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hc3EiEhR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC5719D093
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773401348; cv=none; b=htNNFV3HFQhMGmDP0DY5ruu6FznvxfV7Zo+3XfwZ4loG/haKTqKi1mRbH+f9Q+ihy4GlOAS63GIMILXJFEm0KyOzW/OCN5UYQ7wT7HmVcGHlNjKQnHwjX5YiVigASssgZu9IC3KLFo1+Npz1jIuODKb1asC4DONypKDgIMW4iBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773401348; c=relaxed/simple;
	bh=We4xbhCLnVGWb+FeULUEnWlzdRYYUPWL5jBwuKXCQdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFuZKtzh6vh5kORMJ4g2LVJ4dO/hyyTZVCatp3+sp/ll7vHO5vBZRWjTjW5k9WXjDTzCx0hQCTs2U438+5AzX9ED+0N2NSGeKUPGX0SXU/iR9+UxvOYdEFzu8Q3gv6VZV37lpKjExaKso6/k0wmHbuKCS1vSan9WRLcgmS0S7Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hc3EiEhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97075C19421;
	Fri, 13 Mar 2026 11:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773401348;
	bh=We4xbhCLnVGWb+FeULUEnWlzdRYYUPWL5jBwuKXCQdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hc3EiEhRZ459XQjJbLdmBLwVMNVL783S6CzqheN9VJdxfHy/efoHoocDgjuT/2Teg
	 dPO4Mno6qvsTahx9yPBlXH9IhUW68z6GP7G6azE4TDK5J0mSxYn6ZsPCmIU51sk7vs
	 zX//xodgRr6coA0rKDOpkVkQgcHRShX20pMP06IRVk5O1Y8inrMxAEq1Ij/ULNpXxI
	 2cOISIldv7ZgzbO7TGuVgsoYOqiWKjHrUQyL5JQetvM7tuRidRcUj53ORwskHDp5uU
	 7p/+sN7npJDPticbnDu9K5s6E28HEGslt2EK7PBCkMQF1LSnYKiUzAfToY3mGj1/vi
	 wFCmNRydPfjdw==
Date: Fri, 13 Mar 2026 12:29:05 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Remove airoha_dev_stop() in
 airoha_remove()
Message-ID: <abP1ARU0xdMUq8_e@lore-desk>
References: <20260311-airoha-remove-ndo_stop-remove-v1-1-596fe853b2e1@kernel.org>
 <20260312182128.33d2d88c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5IoUYz3qF2Nrx8Dy"
Content-Disposition: inline
In-Reply-To: <20260312182128.33d2d88c@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267419-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75DEC2823BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--5IoUYz3qF2Nrx8Dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, 11 Mar 2026 10:54:57 +0100 Lorenzo Bianconi wrote:
> > Do not call airoha_dev_stop routine explicitly in airoha_remove()
> > since it is already executed by unregister_netdev() if necessary
>=20
> This one is a fix I think? We underflow the atomic if the port
> is already down. Once again, commit message way too terse :(

Hi Jakub,

ack, I will post v2 targetting net instead of net-next improving the commit
message.

Regards,
Lorenzo

> --=20
> pw-bot: cr

--5IoUYz3qF2Nrx8Dy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCabP1AQAKCRA6cBh0uS2t
rLEVAQDiiXdm1BxS4JyeMV9BgqqOADTgmX5CNx0dAqXpb0bI2gD8D4YNYpnLwf8r
7QtzRLSdbg5A7rAQwhMMQ70zeScODQ8=
=zyl8
-----END PGP SIGNATURE-----

--5IoUYz3qF2Nrx8Dy--

