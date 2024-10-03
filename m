Return-Path: <netdev+bounces-131500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ABE98EAF9
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 10:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA001C21B8F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 08:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521BB7F48C;
	Thu,  3 Oct 2024 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AAxkc/mx"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A155E10940;
	Thu,  3 Oct 2024 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727942508; cv=none; b=sql9ySH2ACQ4lHG2szKi9hjBnfPiK1c6jfaJJOZinulTkLOaNav/ovHJxIaQvh5YKqpzUGP2J+gEr2FP5Crib2osYWkEZ1bQKYiICmo428PZ1SpmX7iWKOuvL2LUzAJ0480ZNFUdr0O4ZAXeLix7+0jvb82+eVrBu8JV/Jh43yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727942508; c=relaxed/simple;
	bh=s8rhgO4icTGT7mesBVisBIN/aFhxQ7Ku3vUQsN8le2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SuhsAuca3AK33G/SIJ1UQ1AmMksdU41qg7HEUZC/pQj0maM0gIQ0DTn/qEFeEnJWLnRdE5OV/03iiWuCqtzWx7RCnKa6Ng4Sh4XSs/YoZXNb+mFeaNSbvwJyTSmRWtwGzn5SX5pX1zW89n1mscdxgWgosyLpNd+Gn4yCv8O7LOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AAxkc/mx; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A2B66FF80B;
	Thu,  3 Oct 2024 08:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727942503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UtIpPwgDb7sTORjc+DbIwbzuLRI0mwmB7mFQ6yVwpvs=;
	b=AAxkc/mxZvjZPzcs+E2uLWyyO0WQ1HdDvLaqL3qgbPgugA2ToG0O7Jp9CGlkjc2zLCMmPv
	vQ1eYu3lI8AVMag14GQ45mh2Uf3QQ+uSSNSDAmhYroVzZkyaOmN/HZEqBwcS+KrTpGfE8S
	1er89FO4NFbotF0l/of1IVWsP81UXTKbkxVa4BcVqG9EHhroaPcKSFz8ujP3BR3eclhXSY
	EkZojh1puEv1kptv9GeznjCs7noJ0lZk2VRLlWCUUmStLcKNgntgIPijumx1mfqFsgDoaS
	Ye40Bb+XRchYqzQZsQTt2XvRO6wWx2w76fJh/SJtXz5aZNs+QDn1dlp5p7VfoA==
Date: Thu, 3 Oct 2024 10:01:40 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de
Subject: Re: [PATCH net-next 08/12] net: pse-pd: pd692x0: Add support for
 PSE PI priority feature
Message-ID: <20241003100140.153f660e@kmaincent-XPS-13-7390>
In-Reply-To: <1e9cdab6-f15e-4569-9c71-eb540e94b2fe@lunn.ch>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
	<20241002-feature_poe_port_prio-v1-8-787054f74ed5@bootlin.com>
	<1e9cdab6-f15e-4569-9c71-eb540e94b2fe@lunn.ch>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 3 Oct 2024 01:41:02 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > +	msg =3D pd692x0_msg_template_list[PD692X0_MSG_SET_PORT_PARAM];
> > +	msg.sub[2] =3D id;
> > +	/* Controller priority from 1 to 3 */
> > +	msg.data[4] =3D prio + 1; =20
>=20
> Does 0 have a meaning? It just seems an odd design if it does not.

PD692x0 has an odd firmware design from the beginning. ;)
Yes, the priority available are from 1 to 3. Setting it to 0 does nothing.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

