Return-Path: <netdev+bounces-306625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jrBiASIcUWoJ/gIAu9opvQ
	(envelope-from <netdev+bounces-306625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 18:21:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCE773C8B1
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 18:21:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XOquKgoC;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306625-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306625-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7891300D303
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 16:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D6B368D5B;
	Fri, 10 Jul 2026 16:18:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04EB368957;
	Fri, 10 Jul 2026 16:18:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783700291; cv=none; b=lrBDw+e4vgZM6bX0gs2K/KUbXADAD5x3GRU+Ihgm2xDQOcQNLrcdyUkZqxKTp1jMnxc+bbAA+FLm12sSbcgAovJtJXvOjBLQiI4dYldB8f/pq6G4ft/81zAIQoyTAM6kzcXutmZkaeCkywGaBERYzwiQfk5PJckG6Al9h5edoo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783700291; c=relaxed/simple;
	bh=yHO9LHmXL00lTgCqTetKK3+7jZ6BLoqg/vlXs8MBWRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnNh56iyv2FabubZTaKRyZnYnc0XdN/D3flniLkhPBqDan9ELVh0Z12KWgW5H6tHGP1sGyh1yZewGo23ck+XfwtgJ3QM7+P1BzhE1JgK88YswQae0mh/B3k4jN77J1YtJA7p2tCvA97pWTGyI/dA58UUAIzye6jotZz9VgSE9Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOquKgoC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B435C1F000E9;
	Fri, 10 Jul 2026 16:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783700287;
	bh=+87cri3jOCre4gN5g3PJi59fqdvefMnbXISUfYiK2HI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XOquKgoCaxsnb/bbVs7Q+TqE+IqITlwbiPXeb27zeCjMGRVbVtUPSOK1EjNemhgeQ
	 grvSfNq025jnbDCqDHlFf9QOOrRf57k/GC2kgLcaNpCr3jkziAl+AnKXDDoiiur3kB
	 ZYARdkxCAE0/pmvZakCFb2dyGwmp8ERHxRWdXepzZdoK1phg2gOEArwE4JJdrivzej
	 Kj97PFaBAwBEErgWV6FGr+YnHO/QJUzG+qs9NK1TpOz8jsvcImSDSkWLNxsgxbst45
	 lqAoSu2Sffo+7hEG6FHTG3bEZt3DoSMcS9rt4PC0yMPcmrasBhkqfOaS44H/6VTV/6
	 ujUHPks4zzxPg==
Date: Fri, 10 Jul 2026 17:18:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Ahmed Naseef <naseefkm@gmail.com>
Cc: netdev@vger.kernel.org,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Sean Wang <sean.wang@mediatek.com>,
	Vladimir Oltean <olteanv@gmail.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: dsa: mediatek,mt7530: add
 econet,en7528-switch
Message-ID: <20260710-coil-clothes-d316a54585aa@spud>
References: <cover.1783680864.git.naseefkm@gmail.com>
 <68e85666b6dfedab719aaa388450eb86312eccd0.1783680864.git.naseefkm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="neuiONwNeDF1oEBK"
Content-Disposition: inline
In-Reply-To: <68e85666b6dfedab719aaa388450eb86312eccd0.1783680864.git.naseefkm@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:naseefkm@gmail.com,m:netdev@vger.kernel.org,m:arinc.unal@arinc9.com,m:chester.a.unal@arinc9.com,m:davem@davemloft.net,m:andrew@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:conor+dt@kernel.org,m:dqfext@gmail.com,m:daniel@makrotopia.org,m:edumazet@google.com,m:kuba@kernel.org,m:krzk+dt@kernel.org,m:Landen.Chao@mediatek.com,m:matthias.bgg@gmail.com,m:pabeni@redhat.com,m:robh@kernel.org,m:linux@armlinux.org.uk,m:sean.wang@mediatek.com,m:olteanv@gmail.com,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:conor@kernel.org,m:krzk@kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306625-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,arinc9.com,davemloft.net,lunn.ch,collabora.com,kernel.org,gmail.com,makrotopia.org,google.com,mediatek.com,redhat.com,armlinux.org.uk,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,spud:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CCE773C8B1

--neuiONwNeDF1oEBK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 02:54:23PM +0400, Ahmed Naseef wrote:
> The EcoNet EN7528 MIPS SoC integrates an MT7530 Gigabit switch,
> memory-mapped in the SoC register space like the built-in switches of
> the MediaTek MT7988 and Airoha EN7581/AN7583 SoCs. Its four user ports
> are connected to integrated Gigabit PHYs and its CPU port is connected
> internally to the SoC Ethernet MAC.

Please note what actually makes this different from the other devices
such that it cannot use a fallback. It's not clear from this description
if the described features are shared with other devices or unique.
pw-bot: changes-requested

Thanks,
Conor.

>=20
> Add the econet,en7528-switch compatible, with the same constraints as
> the other built-in switches.
>=20
> Signed-off-by: Ahmed Naseef <naseefkm@gmail.com>
> ---
>  .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml         | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.ya=
ml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> index 815a90808901..90b3582b7619 100644
> --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> @@ -100,6 +100,10 @@ properties:
>            Built-in switch of the Airoha AN7583 SoC
>          const: airoha,an7583-switch
> =20
> +      - description:
> +          Built-in switch of the EcoNet EN7528 SoC
> +        const: econet,en7528-switch
> +
>    reg:
>      maxItems: 1
> =20
> @@ -318,6 +322,7 @@ allOf:
>              - mediatek,mt7988-switch
>              - airoha,en7581-switch
>              - airoha,an7583-switch
> +            - econet,en7528-switch
>      then:
>        $ref: "#/$defs/builtin-dsa-port"
>        properties:
> --=20
> 2.34.1
>=20

--neuiONwNeDF1oEBK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCalEbOAAKCRB4tDGHoIJi
0kIhAQCUBiplgyxEntk6QyhZt9CXKwFJOJ7gva/4BQwVdFxyiwD8D6hZszUurWV/
K0wbb9440qRylthWGC8R34zydOrj4QE=
=0iY3
-----END PGP SIGNATURE-----

--neuiONwNeDF1oEBK--

