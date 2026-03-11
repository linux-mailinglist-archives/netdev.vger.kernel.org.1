Return-Path: <netdev+bounces-266743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LbTeJTO3sWmTEwAAu9opvQ
	(envelope-from <netdev+bounces-266743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:40:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3779268BC8
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A4003092D75
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 18:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4321FA272;
	Wed, 11 Mar 2026 18:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ua9W7DXT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75783D170D;
	Wed, 11 Mar 2026 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773254378; cv=none; b=MiRLa6YiyTNsy6RnKfV/chPSn5P+RSAart125U5fN3K90UUvtlpV997S9fApRzBXm3fhFIAQ6KKixrG6Pf0zTa3eUDd1/yfh1qlQY0ZhIRD1y/zQoqC7l8PxRrqsFTJDjjbUMqG/tDMM39fyqbgcwNvZQefpOAEQi06jp15dcN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773254378; c=relaxed/simple;
	bh=ASGMOVVlKPraU2epURzctOrNGTJoobbm41HEI2fCR1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qi84t6CLAR1RyAJQGlYEEq3F8TO7imB//G4UAEtU0czUJa7aXsh/RHgzCM0AR1gjyrarddDRLHXnn7R3hb66AMScUNo77XIR/ZfzS1AVnIQ0ID3a91htvY7UX1VgkJNdWz/J/x4zqf0u5u3JibgthDnqtB0n4OqtGpnJfacQcg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ua9W7DXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FA8C4CEF7;
	Wed, 11 Mar 2026 18:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773254378;
	bh=ASGMOVVlKPraU2epURzctOrNGTJoobbm41HEI2fCR1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ua9W7DXTZhgcWR4Msm26H1ymyCpNtCktO4mEDuKUaRU8/TQf2VQYMBeEYjqXWMvNC
	 Y2VRQgVu5ET/dFEkhMm0K+TVe7hzaJfwms1jOXumguH0bErw80PBGWID+o07SdSL40
	 k8BAT2HFa9GSXZPtW3AskBTkTN0I4peF55s/0xpfyT8ZRfdkMxAT8+LPh3suv55/BK
	 CYn96CLuCQ7YAEhoROMK9g6MQNPH82HirWEGDtNT5zjGTM12hxh0dqjHZTiagj+R77
	 ZwzKEOPY8rEWJOMlXEpj51kWn3o08M66DKocs2Htr74hv5tNW9ZBZxniD/JbjEbT8C
	 l/g22wevnwhWA==
Date: Wed, 11 Mar 2026 18:39:30 +0000
From: Conor Dooley <conor@kernel.org>
To: jan.petrous@oss.nxp.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	rmk+kernel@armlinux.org.uk, vladimir.oltean@nxp.com,
	boon.khai.ng@altera.com
Subject: Re: [PATCH v10 4/5] dt-bindings: net: nxp,s32-dwmac: Declare
 per-queue interrupts
Message-ID: <20260311-surname-implode-7ca49ed23079@spud>
References: <20260311-dwmac_multi_irq-v10-0-7ab1669759b5@oss.nxp.com>
 <20260311-dwmac_multi_irq-v10-4-7ab1669759b5@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gzKQwFqV6iz70t2h"
Content-Disposition: inline
In-Reply-To: <20260311-dwmac_multi_irq-v10-4-7ab1669759b5@oss.nxp.com>
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
	TAGGED_FROM(0.00)[bounces-266743-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,armlinux.org.uk,altera.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3779268BC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--gzKQwFqV6iz70t2h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>


--gzKQwFqV6iz70t2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabG24gAKCRB4tDGHoIJi
0i4EAP9b10n2cCkM9UMFiKRsDjhMNgnKFLf691BlIJH3dXwU+QEAt2QDDb5EgdT5
KAbTSCGw9hwrM99VxedaO6ntRecwBA4=
=xY2z
-----END PGP SIGNATURE-----

--gzKQwFqV6iz70t2h--

