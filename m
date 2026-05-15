Return-Path: <netdev+bounces-288255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAI3IAbpBmpKowIAu9opvQ
	(envelope-from <netdev+bounces-288255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:36:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA3054C836
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CD2C3016538
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A60C436343;
	Fri, 15 May 2026 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLeGmsfC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6645642EEDE;
	Fri, 15 May 2026 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836324; cv=none; b=ndLn34hGlmMASTF9ZAdjzyubuHvs4gmbAxAYhMPhDN22PPB8rPHGaAc5iev5ThTflDJMYkyeqXIup2NaQw6IW+8/bwmjeVDB/g83scoBGRHhuOwslKP1iThad64YD98WXZpuSM3Hit/0wt6tJfCOPYc0bb6egcjszmh/LbWOOe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836324; c=relaxed/simple;
	bh=ezInJyFm/d7b/zaAGKXD/lqLjaLONJlsN86X11bWh9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhaMtvI4toejJ0ow1ec31TMUSkpHxHlF/f+Oma0b/TDhVf0niTD6NsaMmeqhYJclFYlSSrMwQUvZTjY0reemxJHPfXBWPDYqGQEFQjSeemCHgk0woLvZkmK28Nz15XqAsaYhlVsYs+SIuUZsFX+Ft2gW4mCdh/xucBcud4BJpJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLeGmsfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D50C2BCB0;
	Fri, 15 May 2026 09:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778836324;
	bh=ezInJyFm/d7b/zaAGKXD/lqLjaLONJlsN86X11bWh9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dLeGmsfC42LmUDWjMf22yS8ryXFBK3vitMGaWOkpBa7G1omlyYY2fM7uSiv9gkZQi
	 z1gjt0dJl6Q9G+PdpJby27SceI9nJRtTw07Q0jbkHqik1WyMPysHoRkkbvElLPvaC+
	 wQU3yCrKOYSBeev1ZVhMP545xJVWernWYlLBboa4xapfiDpM+AYe2DHwcCYZsbYHMX
	 UGmDx7bj3Xvyt53FNtS2jkYjVUMVd+CnVjxc+5lmS4hEWhE7nh/i9+2WtBYFlSDJM8
	 DNMrNPmSQqy18YShS05KIHUQ9f0kMdxTBeZTDQeH4zsVv6uQkHqpx5/D89qtE9LKFA
	 eR/FYsG1SKqlQ==
Date: Fri, 15 May 2026 11:12:00 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v6 01/12] dt-bindings: net: airoha: Add EN7581
 ethernet-ports properties
Message-ID: <agbjYLb3FeFSVoyb@lore-desk>
References: <20260511-airoha-eth-multi-serdes-v6-0-c899462c4f75@kernel.org>
 <20260511-airoha-eth-multi-serdes-v6-1-c899462c4f75@kernel.org>
 <20260514140130.GA257001-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0BJ5H8Z2afeCFdbr"
Content-Disposition: inline
In-Reply-To: <20260514140130.GA257001-robh@kernel.org>
X-Rspamd-Queue-Id: 8CA3054C836
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-288255-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action


--0BJ5H8Z2afeCFdbr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, May 11, 2026 at 12:49:27PM +0200, Lorenzo Bianconi wrote:
> > EN7581 and AN7583 SoCs support connecting multiple external SerDes to G=
DM3
> > or GDM4 ports via a hw arbiter that manages the traffic in a TDM manner.
> > As a result multiple net_devices can connect to the same GDM{3,4} port
> > and there is a theoretical "1:n" relation between GDM ports and
> > net_devices.
> > Introduce the ethernet-port property in order to model a given net_devi=
ce
> > that is connected via the external arbiter to the GDM{3,4} port (that
> > is represented by the ethernet property. Please note GDM1 or GDM2 does =
not
> > support the connection with the external arbiter and are represented
> > by ethernet property.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../devicetree/bindings/net/airoha,en7581-eth.yaml | 64 ++++++++++++++=
+++++++-
> >  1 file changed, 63 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.ya=
ml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > index fbe2ddcdd909..642f300c0945 100644
> > --- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > +++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > @@ -130,6 +130,50 @@ patternProperties:
> >          maximum: 4
> >          description: GMAC port identifier
> > =20
> > +      '#address-cells':
> > +        const: 1
>=20
> blank line

ack, I will fix it in v7.

>=20
> > +      '#size-cells':
> > +        const: 0
> > +
> > +    allOf:
> > +      - if:
> > +          properties:
> > +            reg:
> > +              contains:
> > +                items:
> > +                  - enum:
> > +                      - 3
> > +                      - 4
> > +        then:
> > +          properties:
> > +            '#address-cells':
> > +              const: 1
> > +            '#size-cells':
> > +              const: 0
>=20
> Why do you have these twice? Drop this one.

ack, I will fix it in v7.

>=20
> > +
> > +          patternProperties:
> > +            "^ethernet-port@[0-5]$":
> > +              type: object
> > +              unevaluatedProperties: false
> > +              $ref: ethernet-controller.yaml#
> > +              description: External ethernet port ID available on the =
GDM port
> > +
> > +              properties:
> > +                compatible:
> > +                  const: airoha,eth-port
> > +
> > +                reg:
> > +                  maxItems: 1
>=20
> Instead, 'maximum: 5'.

ack, I will fix it in v7.

>=20
> > +                  description: External ethernet port identifier
> > +
> > +              required:
> > +                - reg
> > +                - compatible
> > +
> > +          required:
> > +            - "#address-cells"
> > +            - "#size-cells"
> > +
> >      required:
> >        - reg
> >        - compatible
> > @@ -191,9 +235,27 @@ examples:
> >          #address-cells =3D <1>;
> >          #size-cells =3D <0>;
> > =20
> > -        mac: ethernet@1 {
> > +        mac1: ethernet@1 {
>=20
> Just drop unused labels.

ack, I will fix it in v7.

Regards,
Lorenzo

>=20
> >            compatible =3D "airoha,eth-mac";
> >            reg =3D <1>;
> >          };
> > +
> > +        mac4: ethernet@4 {
> > +          compatible =3D "airoha,eth-mac";
> > +          reg =3D <4>;
> > +
> > +          #address-cells =3D <1>;
> > +          #size-cells =3D <0>;
> > +
> > +          ethernet-port@0 {
> > +            compatible =3D "airoha,eth-port";
> > +            reg =3D <0>;
> > +          };
> > +
> > +          ethernet-port@1 {
> > +            compatible =3D "airoha,eth-port";
> > +            reg =3D <1>;
> > +          };
> > +        };
> >        };
> >      };
> >=20
> > --=20
> > 2.54.0
> >=20

--0BJ5H8Z2afeCFdbr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagbjYAAKCRA6cBh0uS2t
rOXiAP44pwN0k6371R9brljGliJaHzd+jLmOlP+Fz+duEXskIwEAx58Rf002P7nU
Tst7hPK0DwlRxEsE9KgSF4NcFS/08A8=
=EZ9T
-----END PGP SIGNATURE-----

--0BJ5H8Z2afeCFdbr--

