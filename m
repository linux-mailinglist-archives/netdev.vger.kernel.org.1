Return-Path: <netdev+bounces-287234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBOLB8JXA2rf5AEAu9opvQ
	(envelope-from <netdev+bounces-287234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:39:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5821524E1B
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C809300B756
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C30D3C8C65;
	Tue, 12 May 2026 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAWe0xzN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9AC3E1717;
	Tue, 12 May 2026 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603631; cv=none; b=tHIx1N0OVUro6FOxmnvhEc+OcopW0niqa+TK+yqF2f8KKlW+NFn8gDRXYTvw1mCurT/QSoVodOqPCa7ZRzBBLna+jTQ3gu5KRgErd3lZZsuB8K/rZseZ+xQvYkwes5+hepwG+Q/o00HnKPAHO405rq3mThO/cjM5sMc2wrGfXIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603631; c=relaxed/simple;
	bh=fXB28kVuTkDkMqgoAEx3TNG/xeQuDfpRTyYYR9Bcoz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiDp7SEvrZgnpzAHvc5mKXiwUg6CF+0ELjJjw3yAC2ZSthLlIP48QCHj/SsZ7QrdbCvypMGVyoGWNvYWWWGOH/0/lGzoVn2naYdSEuQTojUazLlZPhsBE4FstYbpNnBWhCTKdFCb4Axkcqh8LP9t+ODOLUWgcO+4vFrsvKrq/Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAWe0xzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A860BC2BCB0;
	Tue, 12 May 2026 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778603631;
	bh=fXB28kVuTkDkMqgoAEx3TNG/xeQuDfpRTyYYR9Bcoz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAWe0xzNZftlm2rMK+5z7ZTR1c1Rli62/A+p/enKDIBpmsZl+1QinD2bJbO74Ro4Z
	 n8SKVqnizPk+bLAysFD6Hr8s418XdXmlokS2SNOwxbSyPg+3vlPQkr/XSrc0GbZ0jS
	 sIWw2AzdbB033pjpSbNPrRd84l/npLvcxe4b4z94CK5AwQxviurnpvzAvzid4TAdjk
	 VqErqbMz3jts81Hes8cytCOmlgh8UoH/6nPtt38KYMFsuKYhOmQHE1sKIVS7rc5JKH
	 qDLyVNfAI8wv9Myc0fZq3Mj55rlDKkKvu+Nn22psb807paPdmLao0g8/PCF8xLTyKg
	 qNEqAZSvSbBpw==
Date: Tue, 12 May 2026 17:33:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [net-next v3 3/5] dt-bindings: net: starfive,jh7110-dwmac: Add
 jhb100 sgmii rx clk
Message-ID: <20260512-verbalize-nutty-137aedb43c81@spud>
References: <20260507094115.8355-1-minda.chen@starfivetech.com>
 <20260507094115.8355-4-minda.chen@starfivetech.com>
 <20260507-annotate-cleat-52614476a8f7@spud>
 <BJXPR01MB08559464A0F449365088B6ABE6392@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="soViVKHqocBr5BBm"
Content-Disposition: inline
In-Reply-To: <BJXPR01MB08559464A0F449365088B6ABE6392@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
X-Rspamd-Queue-Id: A5821524E1B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287234-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org,st-md-mailman.stormreply.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--soViVKHqocBr5BBm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 11:11:20AM +0000, Minda Chen wrote:
>=20
>=20
> >=20
> > > +
> > > +        clock-names:
> > > +          oneOf:
> > > +            - items:
> > > +                - const: stmmaceth
> > > +                - const: pclk
> > > +                - const: ptp_ref
> > > +                - const: tx
> > > +                - const: gtx
> > > +            - items:
> > > +                - const: stmmaceth
> > > +                - const: pclk
> > > +                - const: ptp_ref
> > > +                - const: tx
> > > +                - const: gtx
> > > +                - const: sgmii_rx
> >=20
> > Can't you just leave this list outside the conditional section, and add=
 the extra
> > item to the end? The only difference appears to be the sgmii_rx clock, =
and it's at
> > the end.
> >=20
> > I'm also not really convinced that this flexibility is required, unless=
 there are
> > some controllers on the platform that do not support sgmii.
> >=20
> > pw-bot: changes-requested
> >=20
> > Cheers,
> > Conor.
> >=20
>=20
> Thanks. Yes, can do it more simple . I think change the clocks-names in p=
roperties like this is Okay.
>=20
>    clock-names:
> +    minItems: 5
>      items:
>        - const: stmmaceth
>        - const: pclk
>        - const: ptp_ref
>        - const: tx
>        - const: gtx
> +      - enum:
> +          - sgmii_rx

This can remain const, only need the enum if there are options.

>=20
> =20
> > >        if:
> > >          properties:
> > >            compatible:
> > > --
> > > 2.17.1
> > >

--soViVKHqocBr5BBm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagNWZwAKCRB4tDGHoIJi
0szgAQCIwA7rp54f62xNDMF0ehEbgxoMB8c08droQhw01YHC6wEAtaCNcVpthUi1
0DMQYR7ZolpGRgfM73GccwFnlpXI8QA=
=TcYb
-----END PGP SIGNATURE-----

--soViVKHqocBr5BBm--

