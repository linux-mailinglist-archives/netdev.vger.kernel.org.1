Return-Path: <netdev+bounces-300071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DSxgDSJbMmr+ywUAu9opvQ
	(envelope-from <netdev+bounces-300071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:30:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C30016978E8
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:30:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=hSn8944j;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300071-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300071-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FFA4300B9FF
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B315D3B83FC;
	Wed, 17 Jun 2026 08:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1D837F728
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 08:30:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781685023; cv=none; b=SSTgoEsE3l2TKD6vCia9HaA+nx0pUmVzrjiTRq9Okwo4gohzheN6l8alrgmJJSOB0M8jd90OLy0kuxOsMg5eP3Kg0P6EHqR3D157GZsbcnn61rX4fMn1pGyJovEGvZu0ACVt1hVb0VIqrpTCLVPoTlYPwpR1AzLlVERQ+Tm/k+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781685023; c=relaxed/simple;
	bh=j28ta1hYZFYxT8vblKPL5FNIZVUAwPfv6Wan/TiNKO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTBQC07H1e7jqVMHAkClTnTkWYL4tHKi+xatL3/zNBuj7/V8WSbPSZ/x305Nmy6EPwS7+Iy6VsTidxjW7o6KaAe82w5JwIRWZ3t0w+gM4Aa3VOnm+SIk4+NYm3ZVh0cayk1VbQir1NCSR5v/rb2xWpDBpWH9Ifj2sXfzRfG3fNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=hSn8944j; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-491609cdd8fso29005315e9.2
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 01:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781685021; x=1782289821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GMveFE2bKqbauRYws9K38JlTmPH4YVDEd1weIT1nREU=;
        b=hSn8944jpI3CrZyUA+RRGY1Mv1M8JctpVzGyAcTb1lZ/TZcH3Cvivg+MMnJygw4I6P
         v3mFD3fiN+xyKSi5LY855cH0GMixAb6NaoH/IaedArDKGC8GBmdWW4ybsh6PIM3Td795
         fE7+T1TQ0w5yl1M/VBGhMjhgOfJuyfOhpqrgihU+ZXCt9KNXC/XlTW65uxBM12eIniJP
         0pq1MwxcNi6VNAh4XNo5JnmGM5rbRJZjrZUIqFWbQCj1WYaX/5MNLQfdUzPG9xOoGDpu
         TyIl9sXYqpqVnQDwbQHEoA3mbZQVu5pEDfbPgv+gQXMyemN/vNQctMPh3Xv+CTzWT2ex
         wNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781685021; x=1782289821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMveFE2bKqbauRYws9K38JlTmPH4YVDEd1weIT1nREU=;
        b=J143ewMA9cF8J+Co0ewHH+hYBxTA8Y4MRokdVUnPNEdiK7RjwUiPHSONJZ/cwkwrfz
         q0v5JO528hqEA+j/VlVlCcu3S8YRDr6fMgzytTaUGqP1lRZ0t/p5Zue9ZPTIPGgeWmce
         pv7WOZ2NkXe4gSwzw6RmkG3Dg/ilCTeNpthGc/37/UqPjHrYVEBjCO1lJArJdsAh79/Y
         jpZZe73/09AkGYTPQxitr4iPxaBLSIqWl6egtOtV0NAHpFoYKWDMJc1xwnAM/1s/AcpE
         RvwOknUGgLNY0kweIEOlO3mPD1voalTcnqTR9H1mkEuti092Pohmx+6ET3QDaJuUGT5h
         g6dw==
X-Forwarded-Encrypted: i=1; AFNElJ9GTCJxSUQH2Z3lPztAFUNUQbKuhQEbKUocaQSk5nkbPG4qR0+UeQEAmetJsn8uM/hw2vgdxhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIqabsWfNdu27lhF5GnEXNZVNU83789w6V2jdqulSKzB8AbT3k
	VNyI8QQxHKKw7Hnzp/wDQYYKItLw0VBAnjzLb2QKTCqC/jZWrwQy7OaeVlVKyQQ5pNw=
X-Gm-Gg: Acq92OGXGpLs4N1I26KVGEpTwVXZIvYfDO6ZCgihtkduDrMriviHLXWe+iao9wO2Ekw
	VjcQ1SX4y6eDLlJF9PytH+HpCYiLqIW7r5LGtR+esUj9PguOg6WSQBoujtlREAKxipv12KwgbGH
	V/AxekCTzad0dfDktYZNxY/lXlkhaisQTFmMfkMPJuc3r3KQOWt/xxXUC//c0LHhk+IB6ujTUFq
	5pmeNZQvr2dMDlZO27CsnRsfNVMnyI+zaydWnS3bsJnGJSdm687Z4q4riDsgvxtl8EKM7zDBO5w
	AMHvBEgwTIHQaajBvzZ2h3762OPwpNHPupQD8RGt0LeiY3kPN6EyBgZS2WTH5ab+JX25E9KEEms
	ImeBx5e+TBA+k6mfs3u11ICW8+Ld1l62pIuNHtvgpQ7eUnc2nga5m8kIbKwzv3ZM+Jb347N5BWw
	zSb9Pgdyyt7pJYSRxC5mn1FHkpRdepDMaz28xngFvXabPKXBeX1M1R9TF7/INfaiI8iNrjIRipY
	4D5
X-Received: by 2002:a05:600c:e547:10b0:492:2ffd:8f8 with SMTP id 5b1f17b1804b1-492333acb7emr35813705e9.15.1781685020650;
        Wed, 17 Jun 2026 01:30:20 -0700 (PDT)
Received: from localhost (p200300f65f47db04bc2080ea3c93ea6d.dip0.t-ipconnect.de. [2003:f6:5f47:db04:bc20:80ea:3c93:ea6d])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49233438eebsm50982705e9.0.2026.06.17.01.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 01:30:19 -0700 (PDT)
Date: Wed, 17 Jun 2026 10:30:19 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: han.junyang@zte.com.cn
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, ran.ming@zte.com.cn, 
	han.chengfei@zte.com.cn, zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next v6 1/2] dinghai: add ZTE network driver support
Message-ID: <ajJagkqGSeRcZQaq@monoceros>
References: <20260616212106742_trNLb7r-FL04eDlJO8tT@zte.com.cn>
 <20260616213057452I2KLm3mVgWYl_SUTy_YYS@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xqlvqc5tauhy2wrh"
Content-Disposition: inline
In-Reply-To: <20260616213057452I2KLm3mVgWYl_SUTy_YYS@zte.com.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:han.junyang@zte.com.cn,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:ran.ming@zte.com.cn,m:han.chengfei@zte.com.cn,m:zhang.yanze@zte.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-300071-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,baylibre.com:dkim,baylibre.com:from_mime,monoceros:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C30016978E8


--xqlvqc5tauhy2wrh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH net-next v6 1/2] dinghai: add ZTE network driver support
MIME-Version: 1.0

Hello,

On Tue, Jun 16, 2026 at 09:30:57PM +0800, han.junyang@zte.com.cn wrote:
> +static const struct pci_device_id dh_pf_pci_table[] = {
> +	{ PCI_DEVICE(ZXDH_PF_VENDOR_ID, ZXDH_PF_DEVICE_ID), 0 },
> +	{ PCI_DEVICE(ZXDH_PF_VENDOR_ID, ZXDH_VF_DEVICE_ID), 0 },
> +	{ 0, }
> +};

Please make this:

+static const struct pci_device_id dh_pf_pci_table[] = {
+	{ PCI_DEVICE(ZXDH_PF_VENDOR_ID, ZXDH_PF_DEVICE_ID) },
+	{ PCI_DEVICE(ZXDH_PF_VENDOR_ID, ZXDH_VF_DEVICE_ID) },
+	{ }
+};

(because the assignment to .driver_data is superflous and initializing
it using a list expression is in the way for one of my patch quests).

Best regards
Uwe

--xqlvqc5tauhy2wrh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoyWxgACgkQj4D7WH0S
/k6S4wgAt+PUM+vXfFVNU5cU1HsGHaE7gmyf5MHQL5f/bsN4l6fg+B+HGJoXH7/Y
0CD7UmM/OE/YUTer4NNvVrWaOiSgVSNN3gJwnmitdOjVdq/OL8NdvPIN70r3ft+b
Ek381wgzboDUHABrWIhv/E2CWya64nl3FXdP7FupTho7WegFrTiaJBC6hG8lGRR2
fgZSvFTTognGWOeMhJnEVe0ZaB5NIz9EUlykwFEaLCN/O2GkisjmWPpbF7X7oDuC
2d9U/qQqvusBHBt8+rML/fajDT8la8WRv+dEU+jjoUJlni8u58GfMvtFKToGG1jR
SHdDQ87ePaBHNIdHVLu0E7RCF0Y5gQ==
=SQ2S
-----END PGP SIGNATURE-----

--xqlvqc5tauhy2wrh--

