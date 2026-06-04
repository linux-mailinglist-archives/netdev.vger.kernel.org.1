Return-Path: <netdev+bounces-295078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DhFPHQYxIWqOAQEAu9opvQ
	(envelope-from <netdev+bounces-295078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:02:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1BC63DD19
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:02:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SmkMlDup;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295078-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295078-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B0F930BC2B9
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 07:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC223DD514;
	Thu,  4 Jun 2026 07:50:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720AB3CF04F;
	Thu,  4 Jun 2026 07:50:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559450; cv=none; b=M/abQuafEWrHoPtpLE7hKzSds8OzcRsGg7CQ7GLLMUK0g1pn53GJCQILRoPvPHAI7WM+XyIMlpVBExNRDziYnvOwDKlouXiFVzGuEaZ2gaoVAmhjf4fmzidOW18eFhKw2OYoSr65tNf3tYHmwRYEunml+XM4hoCX2oZa/glVWng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559450; c=relaxed/simple;
	bh=W2oYleXACh7TurlO3lAhx+mXs0ax4vUBLyH+ZxHL3mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHeHh3CDHxWSg4I75u9g7+m9LmMvo9ko83GoM4jM8LVFqC68kzqrf/KQDOuQhSGh3GVn7oxSCv3V67VbTFEpy5jxlFHc3dZTZgq1kDCaZbH90POsyXa43uR/LAcIfkmDrWGqaPnUjbPtGdCAkKo1wktPCRHw0wzqDvbJuvtKyso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmkMlDup; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6FB1F00893;
	Thu,  4 Jun 2026 07:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780559449;
	bh=eVkpopmXEjzkmtW+mdfdXA6VqhjM+b3ISZeK539v+kY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SmkMlDupiqF8dHSJsGfq1EwOMIHu28niCfq6MAsZ+JPfbPMqjLe4KPsq6z0tH/cLU
	 UlQJFszadhv9rEztEJBT7QGdO4UJ6Cz8F44aD6c1zRpqISNce3qmEOpyRWpoyPva6+
	 Wy5Mg1FC952tTdN6DjwEqUxQ6UQ675WQDA1MzHBZzoVQfwSXV69LBIFrErm4xKRPy+
	 qi6Aolr35lX2wRcMbbLqfH2YxI55g2S7hM0ZJcKHOENT4Zs5frGRhqy4DmZb9jQ9lQ
	 ioxm4mo2xvDmflGvHgFRDb4RUoa2sxwWxQVgiD7WL6kAMVUbYhYH/4cWBGYO5FDXYB
	 mmmA1U9lKnQyA==
Date: Thu, 4 Jun 2026 09:50:46 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v9 2/6] net: airoha: Remove private net_device
 pointer in airoha_gdm_dev struct
Message-ID: <aiEuVrrgp9RjieOV@lore-desk>
References: <20260603-airoha-eth-multi-serdes-v9-2-5d476bc2f426@kernel.org>
 <20260604060124.ACAD11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h5pRc1ONNFQaQBzX"
Content-Disposition: inline
In-Reply-To: <20260604060124.ACAD11F00893@smtp.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295078-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:conor+dt@kernel.org,m:robh@kernel.org,m:devicetree@vger.kernel.org,m:netdev@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A1BC63DD19


--h5pRc1ONNFQaQBzX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>=20
> Pre-existing issues:
> - [High] Potential deadlock in airoha_update_hw_stats() due to use of spi=
n_lock() instead of spin_lock_bh().
> --
>=20
> commit d33fdec52e6f77bf6de4ab248729e1a868e78dc6
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> net: airoha: Remove private net_device pointer in airoha_gdm_dev struct
>=20
> This commit removes the redundant net_device pointer from the
> airoha_gdm_dev struct. The code now relies on the netdev_from_priv()
> routine to retrieve the net_device pointer. This is a refactoring change
> with no logical modifications.
>=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 6574901ebd19b..57a16de0a2ec7 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
>=20
> [ ... ]
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but I noticed a potential
> deadlock in airoha_update_hw_stats():
>=20
> drivers/net/ethernet/airoha/airoha_eth.c:airoha_update_hw_stats() {
> 	...
> 	spin_lock(&port->stats.lock);
> 	...
> }
>=20
> Does this code risk a deadlock? The ndo_get_stats64 callback
> (airoha_dev_get_stats64) can be executed in softirq context, while this
> lock is also acquired from process context (e.g., via ethtool) without
> disabling softirqs.
>=20
> If a softirq interrupts the process context reader holding the lock on the
> same CPU, wouldn't it spin forever trying to acquire the same lock? Should
> spin_lock_bh() be used here instead to prevent this?

As pointed out during previous iterations of the series, I do not think thi=
s is
a real issue since ndo_get_stats64() callback can't be run in softirq conte=
xt.
Moreover, the reported issue has not been introduced by this series.

Regards,
Lorenzo

>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260603-airoha-eth-=
multi-serdes-v9-0-5d476bc2f426@kernel.org?part=3D2

--h5pRc1ONNFQaQBzX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaiEuVgAKCRA6cBh0uS2t
rO9MAP0cY5zQexQo1pHNxDD5B87+A/+WhoCaWvg8xGusiLH0cwD8DHaH6dGUBCoS
ElkTy4Vc38fkS90hcHDrqMSMY1HOKQA=
=hEBu
-----END PGP SIGNATURE-----

--h5pRc1ONNFQaQBzX--

