Return-Path: <netdev+bounces-274559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMh0Gg92zmk6nwYAu9opvQ
	(envelope-from <netdev+bounces-274559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:58:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7FB38A20A
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 15:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12EBC3015ED7
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 13:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E8D3C871B;
	Thu,  2 Apr 2026 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHa/uVf8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD40611E
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775137470; cv=none; b=fIJeJD1D3iOtuU6TiFmHm5TmiqG0AihIUoLv2bqV+K8JAScr3w2WWm7ata4oqyGidsITdTknxOjyOegGHXttVqj6u5MdXqhulePD0NvGNJx9K+4v3j2qFgE8NULlPu1nh7vwOUrQdQ0MLPvrq2h+/8OOmU7rxiR51pLokPC/AYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775137470; c=relaxed/simple;
	bh=Z+qPhBp9y4NgDaGjDqYC7FJZi9JldU7bS4Ysv9kcAcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYOiX7nUvnbstFMPmiNuzU4hzG2+zoZNWYkxAncwdsAB/TSve+QSuOWzBBKMkFBakN18Azl5ndJ/sEIwThvt5qDBo+dYnfD2XyzoqM6MN4XMbJAopfrMW5+Gce/QZVaUDznubeWb7JhuLDWFkTMTdm21tqKxjbfVTb2sH7LJaUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rHa/uVf8; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ca4ff720ccso882393eec.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 06:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775137467; x=1775742267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+qPhBp9y4NgDaGjDqYC7FJZi9JldU7bS4Ysv9kcAcA=;
        b=rHa/uVf87B9tRuMlZoao4vsNI7ssZ5FvD4nAchy5IR76+zsbfI326TFPolsRJXR0V0
         Yh+y/30K1WPzGmbhNwMNkoDM+WzcX9A122lQJdJn4qYfqxBkuOXKsvxV+XaNquYxV3JQ
         yA19wbnZ6UyI76D6SGk9HQTTIplqb0Ccq4jveyEg2dZ07DrrpWe5IjFLw8s/wZmUJQbk
         FwEsnpneY730qqqGBBnD7eUvPsxjZFPLyLhfmZmwBMXVqpvaCqINyNS1g08Fw/0UfPk6
         qUPp7E6s3lARHvquCmqQCl4WBJ5bHhTzxRXu9YgBvM1OqVVU+3mO+CcoN0r/r2RO5+uB
         V+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775137467; x=1775742267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+qPhBp9y4NgDaGjDqYC7FJZi9JldU7bS4Ysv9kcAcA=;
        b=e6xjIFFRGj6bev31ujaGWghAkPrJS0TtFKerCYjimOSAT1EGSXvPhdJBwHB/or00kR
         TFV7R9zLCcx+hRTmI0QIEJyw1oHP+s8bSzdGlv6mv0Xv2/ulW0Ob7WN0R07EBYmgm5Gz
         dnTSnRtAtPkx6egANdxxfsvyIY/XTLCuBaAYZzzh2VRmCrfwQiWU0OL8uJyk6lqRwqI1
         hgpUtlfyKUIsG8TDDH+q0qZT9etbNH0dM6lQI0EsJLjk1jez24nB6BkJBrh5RHIL7TAc
         1cUtUZm5hl1dNTGog53+1l2OOi3hHuoSgqYXdLBRiFvHiqoBE7W7A7xVRmptkzBmqoEQ
         LGtg==
X-Forwarded-Encrypted: i=1; AJvYcCVuj+Ccip6iy1eXlbdd9HeSLZueL5T+l9BkMqpMcRR0O5TOPX9Uv9GcQh+XK2g6aV4LoteAIKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNd4WHIg7ReguQqrWObNNl87q1q0m71C7NCm6oAPz8rDkWNWuw
	3DdH/QR3saDv3qQQ9bM+T2KeXCLDwAd3SCxAQh3qTd57fEuK74/T6fI/
X-Gm-Gg: AeBDiesPNunAgmGxNUKfz9BHxJvhL4ldfH4p/T5sTes4NYmuyVrDRZlScjIownymLqP
	6zKOQNsfjXn+FhHczyTm0C/cchLSgyztZ5H2BbdsxqNp5Meuzjso8HRrevads7JfZBThxe8/sU9
	Bmy9C843w1tN0IvhOtI2Hzbq6tTDMZ/6XKlfWUpbyvwOZya2YLUAzixmaJVgFRBtsmFrNLCI/sH
	FOQ+GMftPJhiaGGg6/EJR/he5Ro9Y9wo2bncmCGvGTF04jNJeC3AmSyx9ptGVUY2OnN+e8JWfSf
	HrU8VtCKZAI4STXiNNCr79QCmZFAH4/pO/hMm4IBLjM+MvF53lPmwcNi53Szhz1QcyEp+VHKlvE
	NiVjsuuU/37SDCSVNoA1Yh5bpPNQImThbS/IVHAuPTyIUApA/yp/IgwpY7PZgsKg7/lmYKGKpE8
	T7siSWPQXLi3kEBMqTlMo=
X-Received: by 2002:a05:7300:2d09:b0:2c4:8990:393a with SMTP id 5a478bee46e88-2cad8a53d7dmr1022191eec.19.1775137467167;
        Thu, 02 Apr 2026 06:44:27 -0700 (PDT)
Received: from pek-khao-d3 ([128.224.246.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c20b195sm2435549eec.16.2026.04.02.06.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 06:44:26 -0700 (PDT)
Date: Thu, 2 Apr 2026 21:44:20 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: macb: Consolidate
 MACB_CAPS_ISR_CLEAR_ON_WRITE checks in IRQ handler
Message-ID: <ac5ytN_VLuq8NLtZ@pek-khao-d3>
References: <20260328-macb-irq-v1-0-7b3e622fb46c@gmail.com>
 <20260328-macb-irq-v1-2-7b3e622fb46c@gmail.com>
 <20260331195400.16bb697c@kernel.org>
 <aczly5AD_PkYv6mJ@pek-khao-d3>
 <e113d9e0ad3d3b63bfe124509c4af851@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hqEX76IGBaiYAsNh"
Content-Disposition: inline
In-Reply-To: <e113d9e0ad3d3b63bfe124509c4af851@tipi-net.de>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274559-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A7FB38A20A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--hqEX76IGBaiYAsNh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2026 at 01:49:28PM +0200, Nicolai Buchwitz wrote:
>=20
> I'm always a fan of optimizations, but I guess in this case the
> saved ldrb is negligible next to the MMIO in the same path. We're
> talking a single L1 cache hit (~1ns) vs an uncacheable register
> write (~100ns+). Patch 3 also re-reads bp->caps in
> macb_interrupt_misc() anyway, undoing the local bool for the misc
> path.
>=20
> I'd ack Jakub's helper approach. A macb_queue_isr_clear() would
> be consistent across all callsites, including the 7 other
> instances you counted outside macb_interrupt().

Fair enough. I have used macb_queue_isr_clear() in v2.

Thanks,
Kevin

--hqEX76IGBaiYAsNh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmnOcrQACgkQk1jtMN6u
sXHyhwf/YFEkkfUL+CxTx+6P4yFzfZsR5J9t8WJ56pSPwQArVu6wroIBj1tH2eSW
eOUxXPgLoxNz/sPBMZJDK4dZtJoWFoSxhVgQCrRtj6RJhLVXilrR362XdjkG+TG2
/fXoTNnuWQajq5ct5oilQwNfla+2MSGYPiYmqF49ftx8wc4doEDZyXU3+8kZpZqn
HZliZbCEjd6fXst+ELp5gjAYKvdSvy5uk9OVs5GJojIgpuzODOKWGe8XKnFv/5B2
2MY0yv4e2Tg7q9itfg6X2Vy7Pf5+aArEfkt1qXBC/i1rIKd83zwqJGfKIbXPuz0+
yB2JZA70jTZCW2/hXIsf74subgyqsA==
=jopF
-----END PGP SIGNATURE-----

--hqEX76IGBaiYAsNh--

