Return-Path: <netdev+bounces-273093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI9YL/0wymkA6AUAu9opvQ
	(envelope-from <netdev+bounces-273093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:14:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27665356F76
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA5BD30892DB
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 08:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBA13ACEFF;
	Mon, 30 Mar 2026 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8r/ZN4Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85B53ACA70;
	Mon, 30 Mar 2026 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774858094; cv=none; b=tGPIJZKPMiAGmsvxD6QuAQ7edTVcBqK+Tt4NmVJMrk5DJkSFVrMdL1yX9UltYlXMFhH3cGw9uO92cASKrQdeaGsT5d6wXNvw6++P1HiM8NBwJYIcX84Wby1rwipQQjhEk+WN18zoZ6EuvgQTJCqUay7BbeIm1qm46EhnSQ1Flek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774858094; c=relaxed/simple;
	bh=WCrGrXBRzw3Kv3fNUxxYQyeRIObn7RdJ/sUqUBNRyb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NL7kOtCoMWGXOVbIqkuxR1ldHu0rlaVw7PGXq9vS1CheM1nanfjZyiM+2LubawI6KTKwqSm82NS+PJQ350QG7rcGn/ocZUphR27xo8VmgRsSY3db9z62kzg4SX5v6KSmusvfTr4gihSoKMNuaby07xNpIHydujIMCCGb6ZE2Ryw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8r/ZN4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9246EC2BCB4;
	Mon, 30 Mar 2026 08:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774858094;
	bh=WCrGrXBRzw3Kv3fNUxxYQyeRIObn7RdJ/sUqUBNRyb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P8r/ZN4QlWHd5eTR5Z6U6Mo2prZPK+wl8OmlZEewr+yefBoZWEiid8MH4KlpyqOKu
	 6F09K58FT1fwI4bkSgqlZ9LsyeEvEXZRXYrQR2rmgf9KLq9m6cjsxPJISf/F2ndQYf
	 wGnJpJpwxfCYXAmY7FY8ezMqNcfktKbP9hbWFnnLlmkieXvmNcWFUvdN7Kv83+cd3A
	 TrAZEcXyxchyQ12INEtah9NJ6YgenzXI+tomBYZjFwEYI0PrdUqt4XtC2gnfOMNTFQ
	 0PhdzeLtlzbMLeQ0d6dx0B4JUCOUM+1SVrgXvPdHIsiwKW9IZiOu2KLhqB7ya9cSgk
	 7Azs76izr/c9Q==
Date: Mon, 30 Mar 2026 10:08:11 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, Xuegang Lu <xuegang.lu@airoha.com>
Subject: Re: [PATCH net-next 00/10] net: airoha: Support multiple net_devices
 connected to the same GDM port
Message-ID: <acova-OzNROZPypL@lore-desk>
References: <20260329-airoha-eth-multi-serdes-v1-0-00f52dc360ca@kernel.org>
 <20260329103653.7593cbb2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T79mHm2wjmVHKFmE"
Content-Disposition: inline
In-Reply-To: <20260329103653.7593cbb2@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273093-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,lists.infradead.org,vger.kernel.org,airoha.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 27665356F76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--T79mHm2wjmVHKFmE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, 29 Mar 2026 15:07:50 +0200 Lorenzo Bianconi wrote:
> > EN7581 or AN7583 SoCs support connecting multiple external SerDes (e.g.
> > Ethernet or USB SerDes) to GDM3 or GDM4 ports via a hw multiplexer that
> > manages the traffic in a TDM manner. As a result multiple net_devices c=
an
> > connect to the same GDM{3,4} port and there is a theoretical "1:n"
> > relation between GDM ports and net_devices.
>=20
> Does not apply.

Hi Jakub,

ack, I will rebase in v2.

Regards,
Lorenzo

--T79mHm2wjmVHKFmE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCacovawAKCRA6cBh0uS2t
rLjsAQDqRNDCLAkpZdLlO6pj8AWlmRpg/HjyTEK9ZSoHwgMlHAEApL4xBjPwtYZN
nwAYpyHCC9SZNb8pHXJrM/i12uFA5wM=
=wkgu
-----END PGP SIGNATURE-----

--T79mHm2wjmVHKFmE--

