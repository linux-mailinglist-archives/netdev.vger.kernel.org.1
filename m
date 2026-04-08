Return-Path: <netdev+bounces-276576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NOzDXNv1ml2FQgAu9opvQ
	(envelope-from <netdev+bounces-276576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:08:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4743BDFBE
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 891ED301FF8C
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 15:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4559F3D5647;
	Wed,  8 Apr 2026 15:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dX12tYbm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CA63D5256;
	Wed,  8 Apr 2026 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775660895; cv=none; b=VLnSEdx0N/WCUk651Qx+fwsmpzNNqQUsQ/zT3dJbH9r8FyANud9moIHWzRf2EmGlD7GJme/SxM+6CKNIBpQvXGJfr/cREzcT+GQN6Yn3lXYZd6WnMJ4yC/Ykg7qmscpnPuTkeHxEyc0hjuegggZqgIzfxsyB95p+VOlbnL4Eu1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775660895; c=relaxed/simple;
	bh=WLRyeGFRl1sYe2uY24D7mS37xW1BGvN6DhhWt4TBh8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBu5yRH7DmAeRpwAn1vrPHSdGMM7VqUIrQ6uGK6WziijgHayU57l+XnibM/6l5VKEMoEjeKzpcKEhIkoQhJlzwFfrBKdCc44tjvdYhkgjqpj+zP0t41RqtnD9t9JTKjtIWQ6eA308bf0sglSTTFizDeuU5TMWev0FTDjVNBLJnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dX12tYbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF76FC19424;
	Wed,  8 Apr 2026 15:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775660894;
	bh=WLRyeGFRl1sYe2uY24D7mS37xW1BGvN6DhhWt4TBh8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dX12tYbmV7ekivo5RlT9KYS+rAuiZW8dAGfsObS6IeGaV4sBM/nlSrqfQY0Vzq7ZO
	 j2QoKDPhwWV/NoJS1wUHC5wd4ZX70Ych6/rkVITnkkZeuNA37+ObuI9c2mMEvQzZox
	 Bu2vV1Fhwh5gzyQDeTpyw6ateYRSrQbiMNXvjgR2QDJIheJx35ImNu/HIfQxSgxClO
	 FzyzH8XGcGQlcT3ewBEMOb4JkoFRyq9ocffWSz3uXNVqKPyHEMvhDYXGnT52oXL8cu
	 wIl+LxFI7Xgi6xS0jFUoT7DXzqbjdq/J4GVwWBFwQN36PA/ytM7cHfBlJgHVTvU5Uv
	 /ALrZRycMPvcw==
Date: Wed, 8 Apr 2026 16:08:09 +0100
From: Mark Brown <broonie@kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>,
	Justin Iurman <justin.iurman@6wind.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the net-next tree with the netfilter
 tree
Message-ID: <729b748b-e00b-475e-81e0-a666eab24fc6@sirena.org.uk>
References: <adZhwtOYfo-0ImSa@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CQZ+yexN+gkqWo8x"
Content-Disposition: inline
In-Reply-To: <adZhwtOYfo-0ImSa@sirena.org.uk>
X-Cookie: I demand IMPUNITY!
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276576-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC4743BDFBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--CQZ+yexN+gkqWo8x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2026 at 03:10:10PM +0100, Mark Brown wrote:
> Hi all,
>=20
> Today's linux-next merge of the net-next tree got a conflict in:
>=20
>   net/ipv6/seg6_iptunnel.c
>=20
> between commit:
>=20
>   c3812651b522f ("seg6: separate dst_cache for input and output paths in =
seg6 lwtunnel")
>=20
> from the netfilter tree and commit:
>=20
>   78723a62b969a ("seg6: add per-route tunnel source address")
>=20
> from the net-next tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc net/ipv6/seg6_iptunnel.c
> index d6a0f7df90807,e76cc0cc481ec..0000000000000
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> @@@ -48,8 -48,8 +48,9 @@@ static size_t seg6_lwt_headroom(struct=20
>   }
>  =20
>   struct seg6_lwt {
>  -	struct dst_cache cache;
>  +	struct dst_cache cache_input;
>  +	struct dst_cache cache_output;
> + 	struct in6_addr tunsrc;
>   	struct seg6_iptunnel_encap tuninfo[];
>   };
>  =20

This also needs a fixup for a new jump to the error handling paths that
was added in seg6_build_state().

--CQZ+yexN+gkqWo8x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnWb1gACgkQJNaLcl1U
h9Balgf9HV1pIV/UTkHubWSfOV6RsiL/bwFGXH4ChoymuGcK0A7StIVJy/nK4BtC
O2mHixWYu/uWCNdpq65+9JdJPZOSv8O4ootMqi4uDLdjjdKC63+mEHF40r7eyN4p
nbZJOxS7FjL63wjNfv2hsEDA4WFACbd5+blNEVmTlLbVzIU6U3DVG/nchE7dmvYk
ocQkmFDhFx/DTBzQeiCMTnZiW8EOscWesvmBUMiuusfXITrnLUhwkzM90GjWCd8K
s4uoHM1d6Ulrq2aUV6cl9E07FYKpS4QIkIA20uGsSU8mEEc+dnFzanos1DZN8CG4
6QKRO8+/12D4RiN04e+Ufa3zeE9gIw==
=Y477
-----END PGP SIGNATURE-----

--CQZ+yexN+gkqWo8x--

