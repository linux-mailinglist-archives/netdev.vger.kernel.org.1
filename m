Return-Path: <netdev+bounces-254591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B+dNtUBe2n9AQIAu9opvQ
	(envelope-from <netdev+bounces-254591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 07:44:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81332AC4E0
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 07:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 890A03006793
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E080377577;
	Thu, 29 Jan 2026 06:44:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E5D2E888A
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 06:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769669076; cv=none; b=cxGQSjUqll9xrobSpEHB6hpNv+JHFUE27ZhT5klBVIcyp6P7o/WOLYDPk9gJzM0VnMs6kP6jH4KyDu+a3ONZp5+G5Z7EKDOThQAmSH2UiBtG5V7+4YlJ0yxXPeI3bFpP56T3HBTsQgZMf5qLCiNY44ytw3aIAf63qhkUhUwFTO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769669076; c=relaxed/simple;
	bh=mXmrwsGmQmX7MW8fFkOdMv3Rg0g8EnYtGIgJRk6I23w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AppM/kHO1tdKgLZXwrGPmbOv0ojvcVCKk8T0FpTUWnr7kLSe7uByDcXH9lCg7M8UTtfkWH/iGSBeWmJgsUEm4zV7jSpYVMtKf7NFz3l4K7Oi3Nn2T937tMnqwih8QpqCAomc6zacAurFUWa2P2MfPXh0RsH04/B0+NxT5ATfLrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vlLlS-0007KF-HR; Thu, 29 Jan 2026 07:44:26 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vlLlS-0032gZ-2l;
	Thu, 29 Jan 2026 07:44:26 +0100
Received: from pengutronix.de (p54b15bf8.dip0.t-ipconnect.de [84.177.91.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D5B314DADAE;
	Thu, 29 Jan 2026 06:44:25 +0000 (UTC)
Date: Thu, 29 Jan 2026 07:44:25 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	linux-can@vger.kernel.org
Subject: Re: [net-next 0/6] move CAN skb headroom content to skb extensions
Message-ID: <20260129-versatile-tuscan-mongrel-f9b173-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260125201601.5018-1-socketcan@hartkopp.net>
 <20260127174937.4c5fc226@kernel.org>
 <67cb17f4-2f72-4847-aa04-3633f3d8df33@hartkopp.net>
 <20260128-booby-of-phenomenal-proficiency-4db5ab-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3b6m56hj4sgwdimi"
Content-Disposition: inline
In-Reply-To: <20260128-booby-of-phenomenal-proficiency-4db5ab-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254591-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 81332AC4E0
X-Rspamd-Action: no action


--3b6m56hj4sgwdimi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [net-next 0/6] move CAN skb headroom content to skb extensions
MIME-Version: 1.0

On 28.01.2026 10:07:13, Marc Kleine-Budde wrote:
> I'll do. In the mean time, please have a look at b4, it has support for
> sending patches via a web hook.

Hooray for switching to b4!

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3b6m56hj4sgwdimi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAml7AcYACgkQDHRl3/mQ
kZxaSgf+Mb5ckRX1ZZWduW3yXGxqrmzOAGB4FMC3FJzi6dl+brC5j7IEs4KH0hch
wxfb8/UI0iLHKHcB88Rolxpb6dcXtpILHTpQI3VrMz4EdL0x0/aw20UsDyf9JiMS
ah/YcWjvcBBLR6Hz3YK93RzhDOO+fyf08o9xUcZr04HBXKlT0jKLr+mc2PLehfut
0JiZdWhs8mcteXg++JNZrvE93qv8tcrvEziDSgWutGY3bCY65OZFVJwKplzI0SX0
ZAzVV8hI8As0WYGLEpI/qu/AlkcsYk5fVUTAotCgp8dduS7WjfKMZJYI1x2jtDyn
XPMncei0fMtsCFSU3kQOo1bGBPXXhQ==
=EKea
-----END PGP SIGNATURE-----

--3b6m56hj4sgwdimi--

