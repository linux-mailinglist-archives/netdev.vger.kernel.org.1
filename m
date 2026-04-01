Return-Path: <netdev+bounces-274012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMlAOArozGk/XwYAu9opvQ
	(envelope-from <netdev+bounces-274012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:40:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44456377D53
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BD06312FE39
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 09:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643D63B4E83;
	Wed,  1 Apr 2026 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVo7QRYj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BE63CC9F5
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775035894; cv=none; b=oWFDPj1FlwIsNSaDw/4aeeKCxcFHx/g5NchV9oSReLlLXMMybpS90aNcdWR7wWO8RJUFKN+ahF5+DUoWa9KDpc6/GRnBLEfRLkVUkIBNOChTqSE7UmrF1r2GEcyZZotII+5zBxHjwa0eZGgMC8j3ucMPGDjdW5B8z+seYDd1P0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775035894; c=relaxed/simple;
	bh=Q/yoprHrfJZWsuqDonNq/f4wX5TlUY9l+zA+cSynC2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1blTXn8GchbND1nd1v8QFbqNcv8o2RzA/Vc61dwZf2Es+G/978gzRimb5K58SPZDF+6z3n3cKBhbC0FY60NGGmQbxSGPAJg6P/kz2i06fUUSqOdMESOTI8PfBwFOTySljoCih0z8HVI41oBZIRt8JFOQfLMvdcx0SbUnqZaGmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVo7QRYj; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12776bebe9fso3263182c88.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 02:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775035891; x=1775640691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N1OTRj2kVJfOxvF0ctBbpk4y4Y3ON8r1kg3S3eFfpCg=;
        b=hVo7QRYjpJ+RX3uQCk5ma8Cy4UW1TIWl8mHzrvIH/3oVoPUoJpcap28xaFDsYfNy77
         oF2gO6hy2FGqk0koxZiiw9gHy2uFSZiu3LcVUALxbUHf11puN7uwWplQedqfdinpOTDl
         VV/DITj2jVONYyYV1cw+QGCQs1PVJknd7NH8aUQmJRCSHYSpDFWAPJzM7SrU91gpoB15
         RK9eLJ008viI1SLB93wWEKl4NH86dxrhdjvbJ7SQCnHDmruRGHWdEjmuJ/qFrko+z/su
         Qr+cWzvkWCBwM/wT9KVXNwGVHObQ2Uv1Hm8qkCnrFIP7plJuKfOSV8xadI2FkgC4ltF4
         u8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775035891; x=1775640691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1OTRj2kVJfOxvF0ctBbpk4y4Y3ON8r1kg3S3eFfpCg=;
        b=Dk3+mtYT8TF6u+ESqYv4xzTx/QsXFrz7GuIusD9q8HFM5kPP9Vh93cEbAuDeji/XRB
         uM5lzKttf+k9g8ReZ+TPUYrv+eKplC6qTMgVVr0UcMoTRYljYbxxs+E2p3ImjZUULvZQ
         xpa5MmZn6VDLR8psUHKcVRuQrw7kvGr+ppTwNB8BvL3o2mq95+7+gtTPA9sgOxR9jpxN
         uVffaG1zY7jKDSHj3ViX1QU4zpqJF3oAcj3ZQCX5ZmKNlcDIVY2/ovf9fAbL4YoLlxM5
         QVBP7vR1Wum/vIywuojKujl8wynnDw8kt/a2z4SVkaFVoX0l+Z83YAaCmsKOWUv32LbH
         t/Iw==
X-Forwarded-Encrypted: i=1; AJvYcCU4xMR4N/0TOF1j+9oAI1dZA28sf+ot+0WKY9jHsk1HJvjyueqxrk6Rn+bX0knhFuETKTrThYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ugaRD4ho87fOmrSy33GxtwJghZTFATJ0fZ5azD67jqsB1VDb
	iGWdIu4XVRlNQAWTBOeG6EoeybKQ+ubaoxI2UchnlQJbAaIIbrFuqrPQ
X-Gm-Gg: ATEYQzxNHPekpcZtb/frkOSQ3z8mvKZcTRCQWsLrtySLmQLtzMxFUjjvuJsiIWPAn8E
	75uZ2wQQ7aFvH5A1u1Gtyv3rISCi2d+u78myoHSKZyHCxFJHPjoLxA/LV6N3uZXS21bmcyNsWdX
	vE5W92wolVI3kxWYsfvIbidZVocb+7pnvnmj1JzCFZ//nvYAVDfryKIoeX+6czQc0+UnATOCm/f
	zaTmiXwyb2psZpW6y9Y0ka5feijsohCdACpTsIW9/0J2FTGk1fDuTj7suCoBSiVBT7iChVx+5oQ
	D3A4zbqtphEvX61GEU9swTBy+rEleXF3W85kS+Z3LOuBgZUiP8XYQkHuqM9Ej+PuZNqH/BkRD5B
	npbhuGo1pqgWmin/J+y0nj6SaRcXDpGbwW4ZVgmBs3kxxyRwP30xO6xhUfXh0H0SHf91tA92uNB
	F0GzhD8/L9pcnAxIFZh/k=
X-Received: by 2002:a05:7022:2220:b0:11d:e40f:ee69 with SMTP id a92af1059eb24-12be655bdffmr1753463c88.36.1775035890711;
        Wed, 01 Apr 2026 02:31:30 -0700 (PDT)
Received: from pek-khao-d3 ([128.224.246.2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97cad88sm13369433c88.1.2026.04.01.02.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 02:31:29 -0700 (PDT)
Date: Wed, 1 Apr 2026 17:31:23 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: macb: Factor out the handling of
 non-hot IRQ events into a separate function
Message-ID: <aczl612ZvCBin6hN@pek-khao-d3>
References: <20260328-macb-irq-v1-0-7b3e622fb46c@gmail.com>
 <20260328-macb-irq-v1-3-7b3e622fb46c@gmail.com>
 <20260331195431.7965c24a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rwnv0NpHVjtoH3Qz"
Content-Disposition: inline
In-Reply-To: <20260331195431.7965c24a@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274012-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44456377D53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--rwnv0NpHVjtoH3Qz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 07:54:31PM -0700, Jakub Kicinski wrote:
> On Sat, 28 Mar 2026 18:17:47 +0800 Kevin Hao wrote:
> >  	struct macb_queue *queue =3D dev_id;
> >  	struct macb *bp =3D queue->bp;
> >  	struct net_device *dev =3D bp->dev;
> > -	u32 status, ctrl;
> > +	u32 status;
> >  	bool isr_clear;
>=20
> nit: please try to keep the variable declaration lines sorted longest to
> shortest

Will address this in v2.

Thanks,
Kevin

--rwnv0NpHVjtoH3Qz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmnM5esACgkQk1jtMN6u
sXGypQgAjr0tZpSqpTpmJJtwJ5Sa3ifZnZ/ssCn2JJgi0CRHLJaflQ44+bT1J6Oj
JmTkF29CaOgv53F4NtFmTACBUG2BSU3jMvipcBoVyIDfzRY/zR4CWteEyozgBXjc
hjr6uZf5tEFtFYJjtXAUpDZt9kDXbQevCBfi+4Veuhm3YLxB+cJ+fsCEywhVjFTS
Y90hmSTkKmBqJm8DYZEjKTuFu1zIvSeNPJYPmoGGzFefjIj0ROJ2dacEsDVtpOnR
4dmHolnuqMCQ7diOrE+PXI91ndaJffeNoSKpbj8/lRtB+na1h3Ff0YlzBV0dPVuG
JkPCCKWwDLs0wU+yhDeZFS4TxkEIQQ==
=9FLe
-----END PGP SIGNATURE-----

--rwnv0NpHVjtoH3Qz--

