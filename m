Return-Path: <netdev+bounces-277423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yG+kHsL32GkYkQgAu9opvQ
	(envelope-from <netdev+bounces-277423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:14:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BAA3D805D
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 481A030066B5
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3894377011;
	Fri, 10 Apr 2026 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+I3U6gU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC63314D16;
	Fri, 10 Apr 2026 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775826879; cv=none; b=gxXSo7bxA1JCh6NfKauAfJ8O/Rl5Z+7O9gOCaJeP9fgCQET1IltJKTvrG1w65cWkZICVDPjy/hMzLjIoscQHTUF3pejRSruOslIOPCBIFDFBxvGmKV/kO6dgAHfewExgIj0v7ptqF3eBmsO6Th7WEk076ZTgPRUcqHYvSzUfsSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775826879; c=relaxed/simple;
	bh=mQ/7OrrwieJDTdrH7hooz4EEuxSFq4IEqgQU97DnhbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbcKeUVYBy4UyJ1eidtS1rxsNOjPToVrTe0NOelMzvGyraB6DKHn4SGKdb9N9XABJjG0JM0gSPN4UjUB6nKkkfbSgqDfKB+3tj0vrkoKuOfug5BpkucKdVIDZSCWJ3zUgYsIVTfRKRStrbQEH6JIMWrIlOyfx0YoryIGkxjCqiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+I3U6gU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244F8C19421;
	Fri, 10 Apr 2026 13:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775826879;
	bh=mQ/7OrrwieJDTdrH7hooz4EEuxSFq4IEqgQU97DnhbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L+I3U6gU0OxyPmQwzoqXjiYH+t54Yehw5ewLHCuioPKr8KMz6sHE7MaTydXX6Igmv
	 +2iM+/lwImgN+0lJbzlr3uC1yPV3kTzA+TxM+9NiQhUZLcXlshdlFkqCdLiOpxdIHB
	 Hkh/TS4sTMKxPhihYha/+QFydpIgHWLpkYTQx7MlAzhWXjTZfWqTBFeEZSxLgjPR83
	 hdzMrTfS4IWLvGQKrq6KfQYbQJMkBO3kCZzmAGz0kdw6tyBjqcEscPt5qwYxawDE/V
	 JYQxffvP869eX9CC5YyLB95QBAF/vAK18VkgOlrOi5NOImbPjnRVYJs+HnEDhG9Ca0
	 /JQXer2WhHuJg==
Date: Fri, 10 Apr 2026 15:14:37 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ansuelsmth@gmail.com,
	benjamin.larsson@genexis.eu, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 01/12] dt-bindings: net: airoha: Add EN7581
 ethernet-ports properties
Message-ID: <adj3vW7TKXccLSXa@lore-desk>
References: <20260406-airoha-eth-multi-serdes-v3-1-ab6ea49d59ff@kernel.org>
 <20260410025717.1809904-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w8PmPGRkvaOhX7h0"
Content-Disposition: inline
In-Reply-To: <20260410025717.1809904-1-kuba@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-277423-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 13BAA3D805D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--w8PmPGRkvaOhX7h0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This is an AI-generated review of your patch. The human sending this
> email says "For your consideration."
> ---
> dt-bindings: net: airoha: Add EN7581 ethernet-ports properties
>=20
> This commit introduces the ethernet-port property to model a net_device
> connected via an external arbiter to the GDM3 or GDM4 ports on EN7581
> and AN7583 SoCs.
>=20
> > diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.ya=
ml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > index fbe2ddcdd909c..ebbd433e9c9fb 100644
> > --- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > +++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > @@ -130,6 +130,30 @@ patternProperties:
> >          maximum: 4
> >          description: GMAC port identifier
> > =20
> > +      '#address-cells':
> > +        const: 1
> > +      '#size-cells':
> > +        const: 0
> > +
> > +    patternProperties:
> > +      "^ethernet-port@[0-5]$":
>=20
> The commit message states that GDM1 and GDM2 do not support connection
> with the external arbiter. However, since this pattern property appears to
> be placed inside the generic ^ethernet@[1-4]$ block, does this allow a
> device tree to incorrectly configure ethernet-port subnodes on ethernet@1
> or ethernet@2 and still pass schema validation?

ack, I will fix it in v4

>=20
> Could this be restricted to GDM3 and GDM4, perhaps by splitting the
> patternProperties or using an if/then block based on the reg property?
>=20
> > +        type: object
> > +        unevaluatedProperties: false
> > +        $ref: ethernet-controller.yaml#
>=20
> Does referencing ethernet-controller.yaml cause a validation conflict her=
e?
>=20
> The ethernet-controller.yaml schema enforces a strict nodename pattern
> of ^ethernet(@.*)?$. Since these new nodes use the -port suffix and are
> named ethernet-port@X, will they unconditionally fail the node name
> validation enforced by the referenced schema during dt_binding_check?

ack, I will fix it in v4

Regards,
Lorenzo

>=20
> [ ... ]
> --=20
> pw-bot: cr

--w8PmPGRkvaOhX7h0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCadj3vQAKCRA6cBh0uS2t
rBlnAQChofOe0utPGIDu5PUixZsRZzjAtGGT6M2YM583zTPi5wD9H2ST3gaJBBny
9/CzLBUS8ZiATfT1pwiaaFdOA9BHig0=
=dppY
-----END PGP SIGNATURE-----

--w8PmPGRkvaOhX7h0--

