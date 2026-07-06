Return-Path: <netdev+bounces-305154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P6AaJwvjS2ptcAEAu9opvQ
	(envelope-from <netdev+bounces-305154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:16:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26347713C26
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:16:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Nse05hhV;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305154-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305154-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B95D3069268
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 17:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AAA2EEE85;
	Mon,  6 Jul 2026 17:08:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185FF2F3600;
	Mon,  6 Jul 2026 17:08:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357698; cv=none; b=QrLxD8GDbh8LB1IG5jRe2oiwPWxhRRv8k45fqu963rzmpfwtslDrchfLJW4+T8STI6PHgHpkYf/ljhja+QmOQeORUTm9ET2uO6leUOtCHLewGWH7I9wVvYTneQkcWQRpc2Kd5Ch1/c05DtBiut5QKXNjTrGEtVl5eBkmHm0Wx+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357698; c=relaxed/simple;
	bh=2rSZjEsp5OEHtcOzVRP/sLkWWKpSDMJBaA1fd7pebnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggN386BqgvJuu4YbVQWMLcDW1kmQI8rd2/OHFV8fZNh/BfP3QkKSJQ5d4wZDdOnNTEGEP5/PZDj1VRLMHqK7Su1fRNIf2MiE+iD0H9AIhSVJpKRa4BKwEDBKfq+wYKuicN76aO0tXMddO/V2joNK0pHA/P4weZI0A6+F0TsAAxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nse05hhV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA381F000E9;
	Mon,  6 Jul 2026 17:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783357696;
	bh=2rSZjEsp5OEHtcOzVRP/sLkWWKpSDMJBaA1fd7pebnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nse05hhVOPrnhtSgBHOy7fISUS+1vnV3Ia17Z5+8niA2kZ6f8XlmYeDQ8DGuwFux8
	 LAhEihu7E6olPQ2FWfzdkrdUbyyVhrxw9JwzN+HPgOyde882KHtCUqAQVSD7uOPSIZ
	 dbrnl1aMuqleU7ZqRux37SRrUEaOtiWLzUIEHzqcVzt6GJR5Aja2FScnT/yNERIvEE
	 edEZZ4vK6mBz7WzmUDAHroCGBI1gkWg6F3Tpz/SSdW0EzEe6T44Hd1j9xFGs/C1LCi
	 VnoUX9/UkpBxU4frfxs2BiwkmH1/d/vUTWkm12ODYd8bGmxv38xh9GzCHFOjzVxygX
	 Sh9ZdGVbKoC9g==
Date: Mon, 6 Jul 2026 18:08:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz, daniel@makrotopia.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/8] dt-bindings: net: realtek,rtl9301-mdio:
 Add RTL83xx series
Message-ID: <20260706-appetizer-take-344fa928d4f9@spud>
References: <20260705163532.2853959-1-markus.stockhausen@gmx.de>
 <20260705163532.2853959-2-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8HVq63c/bhncdKJl"
Content-Disposition: inline
In-Reply-To: <20260705163532.2853959-2-markus.stockhausen@gmx.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:markus.stockhausen@gmx.de,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[gmx.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305154-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:email,spud:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 26347713C26

--8HVq63c/bhncdKJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>


--8HVq63c/bhncdKJl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakvg+wAKCRB4tDGHoIJi
0uO/AQCjwiRwYM34GZ9K9F08RCHRek4H5Zot8m3BX20UCRXMUwD9HIzy4luZK1Df
38k+i1KhEs4f1YvaY7LKnz+oPdi1WwI=
=rg/X
-----END PGP SIGNATURE-----

--8HVq63c/bhncdKJl--

