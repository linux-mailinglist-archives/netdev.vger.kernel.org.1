Return-Path: <netdev+bounces-301717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vwOeJXAIPGrFiwgAu9opvQ
	(envelope-from <netdev+bounces-301717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:40:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBAC6C0075
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:40:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="CZIR/ww8";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301717-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301717-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45DA43071CB8
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 16:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2533254BB;
	Wed, 24 Jun 2026 16:37:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3129E31A556;
	Wed, 24 Jun 2026 16:37:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319047; cv=none; b=ZubyhZstVFm0SSjU6SnAGGsEVc+jP7AypKB24HF26vbhwGqsFrp9fzgscCRQPYR4VYAzcpTUGXsRM7puLvmtxqxJJGOGs/WgWQCdH+2GNmNBK0v0dosytTOCHzy0wCvossbHFNd7sZsDqmLisPGRMLpTLe2/lIfGxFhOCG2c8SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319047; c=relaxed/simple;
	bh=SsErrDI/mgcCYhyXKs4NAB/r5R1yy/JAlJmDhHKMVUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElVhoneiJannAIXjtfGgu0VKbb8jZav+vw7J3m9aJ94ASI2qgTsr0RnUkhbNTxrri1JBsRYIRwIVmayQok9RGJL0lKHyANUp2KDXBYqQAcAbGTUIDM0tR6ZFJbH+GrfjHhXjpR+ADXEfyhgKxmLcTopj29G/3PgK8TGqLCr07aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZIR/ww8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E3A1F00A3D;
	Wed, 24 Jun 2026 16:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782319045;
	bh=SsErrDI/mgcCYhyXKs4NAB/r5R1yy/JAlJmDhHKMVUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CZIR/ww8kd5Wkj3xWfPpdHxIMhi3TEMx0JzM9Uc+2pgczg3xBnti4IQQcWebTZXGe
	 YhRX3U4AEfu0f8Di5E4tzW6MLB11dqtcJj/TU24vxorEm4fySGMd94TEFp6FTwSjzW
	 qlur4txbLATnb0fEJFEMEVMHa5+66a4RLCDtMnoGLamATZuI5uOWbL2PbpKlvx6mLC
	 jAxgsvz7+gA3s7M9s0Zd7jyMtXn/QQKsNZjnvRaDxE/27Dp6JtM7ubnT5/mEWGeHbR
	 nkOffsaHxOxXmbKLsWk+eOlsJRxnrr4de5yIgVNrtKg8XaNE3Fm5yiyoX6FTVAfyy7
	 AA7x0gMQMKYlg==
Date: Wed, 24 Jun 2026 17:37:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Yanan He <grumpycat921013@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wu <david.wu@rock-chips.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 3/7] dt-bindings: net: rockchip-dwmac: Allow 9 clocks
Message-ID: <20260624-pushover-umpire-2744c5b17d9f@spud>
References: <20260624-rv1126-alientek-dlrv1126-v1-0-5aef608a3f64@gmail.com>
 <20260624-rv1126-alientek-dlrv1126-v1-3-5aef608a3f64@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Iu3PME21ajoZ7jPL"
Content-Disposition: inline
In-Reply-To: <20260624-rv1126-alientek-dlrv1126-v1-3-5aef608a3f64@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-301717-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:grumpycat921013@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:david.wu@rock-chips.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,sntech.de,lunn.ch,davemloft.net,google.com,redhat.com,rock-chips.com,gmail.com,foss.st.com,vger.kernel.org,lists.infradead.org,st-md-mailman.stormreply.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DBAC6C0075


--Iu3PME21ajoZ7jPL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Per Heiko's comments,
pw-bot: changes-requested

Cheers,
Conor.

--Iu3PME21ajoZ7jPL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajwHwAAKCRB4tDGHoIJi
0t6UAQCGHAggz42SGgsn5kHWftoPdggs6Ej/e9AZZFp538uTbgEA9wRMI5IUOoth
h0Ufb6nzQPziJL1JprN+zfmV4EYGGAQ=
=PF6F
-----END PGP SIGNATURE-----

--Iu3PME21ajoZ7jPL--

