Return-Path: <netdev+bounces-275050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oF5lKGbDz2lH0QYAu9opvQ
	(envelope-from <netdev+bounces-275050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:40:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E31A3949E8
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F62E303099A
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 13:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D84E332909;
	Fri,  3 Apr 2026 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="egdDqpc8"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F172269D18;
	Fri,  3 Apr 2026 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775223541; cv=none; b=bf+v7yfQfO6QlQ3y8gwEyx0fGF4bkOfXbcCtht+JstKyXkkp8oH3HNDZ/hfjbfUDjUcP63+g4lu7MD9Tq7/9SpCrw0PlC7e9UHL8BaEREkrC5vYiBxm5KmJoTTF9acgoeOgn1Z0Mfl83ODtHLyNKBibH0duUbkcxqrAjLvG2qbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775223541; c=relaxed/simple;
	bh=xqFOg+GbR7epeqMzDZBUeC8YfFgZNVdj1MN+En/0iNY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjKz7aPnIdp0i5QvDdo/L8DxIW8PogYXrcL8ZrzwvKt3qfxBb8HuQhI2qa1layS1+2DPEh97tXWibPJeFRBNDAe1frbSLvpSdztTAH2ZCpU8KTVSmWTkWaxw/lBx1oGSTJYg2/TNh2yfGfdlwpaex7Fe6nH7d8DU/C/nt6opZSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=egdDqpc8; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E3C144E428D1;
	Fri,  3 Apr 2026 13:38:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9EFC8603C1;
	Fri,  3 Apr 2026 13:38:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7F16C104500CB;
	Fri,  3 Apr 2026 15:38:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775223534; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=w8XFWZ9yBCRVM6hZS4oBSucSgDFxGPJcG6zp+cLyDT0=;
	b=egdDqpc8Ltvvz7Ev6v8503RlrgPbpVOioWDy7fd+PXEG+bj8Jr+hmLwPLPhobhuIT9Tqye
	m8qOIQ4J4WH1Wjd5cRIP5RpqC1mlcBdjrqyefR+XN88o2/sRVQc2ofQtzI1BDw/kd355+7
	hETps/LK2i69BcoT3S/Afh+s/CdjEtMTlpe1nznhGzsOoSRqzGaRqfyNtyOz+sMQS7+f5R
	Jav3nhg4Dz2TSngqyUXr6McpcGAs/+Ulvkg5jd2UN/fTmtRI2D5UJ6DR+SAANTo4qg6XqY
	C7K8XuUaXEapwf8QL1GX2+/7k48sf44d3DQYiSmP3LLq+l4Q3T8Ya1LRqyFXUQ==
Date: Fri, 3 Apr 2026 15:38:49 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Jakub
 Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: mdio: treat PSE EPROBE_DEFER as
 non-fatal during PHY registration
Message-ID: <20260403153849.2ed7d342@kmaincent-XPS-13-7390>
In-Reply-To: <20260403133111.3304497-1-github@szelinsky.de>
References: <61561526-1e8c-4d0c-a0ff-56da25ee6531@lunn.ch>
	<20260403133111.3304497-1-github@szelinsky.de>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275050-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,pengutronix.de,gmail.com,armlinux.org.uk,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:url,szelinsky.de:email]
X-Rspamd-Queue-Id: 1E31A3949E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri,  3 Apr 2026 15:31:11 +0200
Carlo Szelinsky <github@szelinsky.de> wrote:

> Hi Andrew,
>=20
> Thx for helping me!=20
> I thought of keeping the eager path so we still catch broken DT bindings
> early at boot instead of silently failing later on first ethtool access.
> But you're right, dropping it would simplify things quite a bit. Do you
> think that trade-off is worth it? I will follow your lead.=20

On my side I thinks that's a good idea, and I don't see any issue with that=
 for
now. Oleksij you introduced it here in the first place, is it ok for you?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

