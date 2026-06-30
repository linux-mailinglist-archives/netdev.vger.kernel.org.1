Return-Path: <netdev+bounces-303306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tYocNAv4Q2pimQoAu9opvQ
	(envelope-from <netdev+bounces-303306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:08:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B46136E6C1F
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:08:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=DDaMxoFd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303306-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303306-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 089093058D91
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0263C1973;
	Tue, 30 Jun 2026 17:08:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94683DB310
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 17:08:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839298; cv=none; b=QbFnqTNb/6dkYDdhSxu+Ft1DiykxhRcfVPAQKmEApiEz3GnDXRXPFCEt346dyAUHEGBOn190Cgh9baGpOY/UXMQA0K99KfRvdKqlEUHAB7Emk/DhpefnxWMIs4YIShGLTbLhNUlBD/mmeNmh3FEgxBnsp2jLlqOWJRU55iBsV+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839298; c=relaxed/simple;
	bh=XTU3GZzTxPoqO/NCvfqbI9XRN0RZRKYwxhKHOqFhT8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noxe4i7BvuQeBbZB3ooCVlS4qA2o1A8ciSQdE9IQMZzdAttv41xbKyhiU9jeW/iVCJ/xvWBfxaFV45X4PagnyEa/nngv02h3Qv8kxsU+YXhMxn+zqVbffJQGzngHO2ewFBcHg5ceV8gY+fMcJFNVLeAQzXnDdjrfaskJAPR6i+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=DDaMxoFd; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49241dbf9c1so41163235e9.2
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782839295; x=1783444095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9qwsJL/V5cXTs1YYwm/4hgyvuOLQs7ZaFMiDXmAVm8g=;
        b=DDaMxoFd3f0AxJkaRsJ+6sWV2kruspJqZKka8i/rm+oLMELWrT0nURmlTmvS6u5l04
         otE8AMz+VkbUEm6XFFnYlV3FUa0x5rqMlgK6Kp7fPE9GewBrgdfXIF7FlLSBEJI4VdNw
         fkyCGq04UbjfFDIBjsSNnFvY/zxx+3kaoHt6k7KokUKuHtUCfDam4Y9nDn9ad6R0qRnT
         T7JBpebtfSA2l4ADzTktpLnnKDUCfluMpngSctbaZ4Nlf+8O8Rw07Zj/L8p1Wq6hApkG
         HcEqNSoUKzXGM4RMiXTQtztIBQRbIEbBzMXV/6SlaFNVixNOrSaoOfpCtg9G//SMHUL6
         Cx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782839295; x=1783444095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qwsJL/V5cXTs1YYwm/4hgyvuOLQs7ZaFMiDXmAVm8g=;
        b=JLvAlyptPOokweXZyr8JPtVBjaoXzqCcnJRR6xGK8dWckNQxrsFG/lP3PdkgrMe96M
         2UFn8oZ4UjmWqu2r1p7hcy1XWG5UbkPlypoaPUMALhxER21V5A8c6hr9ZOeTd3e7xITE
         hwJywFn4A/3Ql0EipSjTlB+96MxHJEeq4iQUx0Gmds+zjrt8H0yI0VV6d181EXrP9T+P
         /4X4slmrenFvQdiFdGeXQ/hEyJr8Je7ENFlg4k65mws/PABx5diooQnPsTDDLkBFhxNx
         eyZQJQEzgMPC/O+cf1SVXpKPNIE+YQPAVcichLqI3x8aOH7xou0jbx2ZEcavArEjQW++
         5iGA==
X-Forwarded-Encrypted: i=1; AFNElJ97NzwOtGrEeUvoKMVUlYJWwLyjYr/JpLCUY2q+F+PKalXACJ56C4T6vubJSeTfSJIOP8XI2KY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqC+S/6QWsAEMPk45WGCu36bCH52TMEFFhoRUB0PM2x8WV6C/n
	2bBFvtSIqNaYzRVP/fIAE7nPeexlM1xD8FbUZVrhfLLdPksxynEE//e2XdW4BlJm7WE=
X-Gm-Gg: AfdE7cnbf5gNf3FRjGjbLsDVBMK3rMx310oPlF2kM6S321BAshJgnStDNygTIgR391w
	mmSOFVLqhiI3jVEIf538ybWDwtuBYgTs4KPqfRDJR/Hi8XK2GsAegLgabd+HCVjR5X0FoqdbRH/
	TxEJVOXsnQsO6NvGMxK+7Lag840/J5i6eZnHKtFInI8id0xLwvxwb+0zk9QvkZQtZ/9fP0It+nc
	yV/adctT1lW9F9MdffI45a/OhEAnqsOS/v4vpPtU2VzCb9d7y0Y5l61cK8SeSIDbsKYtULhyeL+
	9rLNksGhZ6UaCdqvqIFrWZBCKjmIPozq6ag1o3Mt4DuIpIkyUSa0S4WySXyNSFGBN5ZoiLazawq
	mFN6MBKyjirHaWOaMzIeqtg+cjnzz5LBvjF5ckxato9DWki24GWbbVDPU7fUea8T3DOB5DPRVTD
	7F8EmfB/HidflecGxyfppkisCHZJAf6SrMwP9Jx3WXawSthxf3okK3tpNgvUp+5EtHN3fqWNDJX
	EVa
X-Received: by 2002:a05:600c:8216:b0:493:bed9:b53d with SMTP id 5b1f17b1804b1-493bed9b678mr2175265e9.31.1782839295000;
        Tue, 30 Jun 2026 10:08:15 -0700 (PDT)
Received: from localhost (p200300f65f47db042a9b551def0a6b94.dip0.t-ipconnect.de. [2003:f6:5f47:db04:2a9b:551d:ef0a:6b94])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493be4eee27sm8674355e9.12.2026.06.30.10.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 10:08:14 -0700 (PDT)
Date: Tue, 30 Jun 2026 19:08:13 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Selvamani.Rajagopal@onsemi.com
Cc: Andrew Lunn <andrew@lunn.ch>, 
	Piergiorgio Beruto <pier.beruto@onsemi.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, Richard Cochran <richardcochran@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jerry Ray <jerry.ray@microchip.com>
Subject: Re: [PATCH net-next v6 12/15] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Message-ID: <akP3jrbFLBfS5UqV@monoceros>
References: <20260629-s2500-mac-phy-support-v6-0-18ce79500371@onsemi.com>
 <20260629-s2500-mac-phy-support-v6-12-18ce79500371@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ntx7bzi7dfhkiyke"
Content-Disposition: inline
In-Reply-To: <20260629-s2500-mac-phy-support-v6-12-18ce79500371@onsemi.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:andrew@lunn.ch,m:pier.beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303306-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[baylibre.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,monoceros:mid,baylibre.com:dkim,baylibre.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B46136E6C1F


--ntx7bzi7dfhkiyke
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH net-next v6 12/15] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
MIME-Version: 1.0

Hello,

On Mon, Jun 29, 2026 at 10:23:42AM -0700, Selvamani Rajagopal via B4 Relay wrote:
> +static const struct spi_device_id s2500_ids[] = {
> +	{ "s2500" },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(spi, s2500_ids);

For consistency, please make this:

	static const struct spi_device_id s2500_ids[] = {
		{ .name = "s2500" },
		{ }
	};
	MODULE_DEVICE_TABLE(spi, s2500_ids);

(i.e. use a named initializer, a space between { and } and no empty line
before MODULE_DEVICE_TABLE()).

Also the driver should probably have a

	MODULE_DEVICE_TABLE(of, s2500_of_match);

Best regards
Uwe

--ntx7bzi7dfhkiyke
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpD9/kACgkQj4D7WH0S
/k6pCwf/QtIw3bESK2sU/WMtvyyN/Abtx6fXW06GvQb6J8/Pp/DEz3MY7edpNCJK
0gDMu5RmoFvl6UIJ1rnjlwuETiSQ8W9VN93JWaUm212dxEho9GpPJ+JqkB1703AS
yHiC55snCYwK/u/sGhSBEO9tZX+Kv5oipsznoQOEUwci40Kc5fZfRhLFWdze/Y/M
O0PINCia51Hs6WRhTU1X3P7oywz7Vk4YhmykaK5FrdBL1HjiH8Un7C2KjEq0vt87
QZJ8Q0rZ2cZ/w9liMwdBKXjiCl1haQuliCLTrDN7u+KzKsjSg5JeL/QJCgaAwznH
d15YeQi0JeqfHWlWVAFdiRlLfp5W/A==
=Oe8T
-----END PGP SIGNATURE-----

--ntx7bzi7dfhkiyke--

