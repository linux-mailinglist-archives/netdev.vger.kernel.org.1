Return-Path: <netdev+bounces-265022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9DcGHXeWq2lyegEAu9opvQ
	(envelope-from <netdev+bounces-265022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:07:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AF8229BB8
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F64C3049956
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D272DF132;
	Sat,  7 Mar 2026 03:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoC/OCgS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D161D28A3FA;
	Sat,  7 Mar 2026 03:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772852836; cv=none; b=dCrHdE0Mu27yxSSyDjIGjtablg1hgdr1pyomj0XAha2gHAK5k05qVeQgWBYZpwzLkXJH+BawYgng01te6Ik+C8OAB5eoWgbBtO5agu2rPic/aMLEVaYpq+dhEulSYJQ+BeaSgJtHOqkHRXuKUYDVafWR2Ton77JvYKS4Fo20NZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772852836; c=relaxed/simple;
	bh=afu9EpjY2gduYv1jKXj1sPMoTCLiX5v1K/UCha6pwVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UMwsCBrCQ6aCTslm1/xnDn8RjxAY6/wKjApnyE9WEVFEsCtoFpiprjw7mYnA5YyGLxvVC2dGoMjrL9FgLv1jYM3r1Q1L9RNVEHufIPERmPNuZy4wk2LnCH6FWxjIErxu8vO/utFSyRxJaJxpsngvy3FiT9BFdlr9EirjKj0TQcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoC/OCgS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBB3C4CEF7;
	Sat,  7 Mar 2026 03:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772852836;
	bh=afu9EpjY2gduYv1jKXj1sPMoTCLiX5v1K/UCha6pwVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LoC/OCgS75I4AoFZq78+WE/Ur6Nvr2T2xVGHKUUMDyZ5duxR0qrtO+IqlxbEzF8IW
	 9A9EK1ACSuajZlUEG9rnVS6XDa39BJm+JCsXvcFce0xNS3gwLrEv1s1V1fDkoZK48X
	 k/O83N0VebCSbv0pldfDXqpOtQ/YyPAi7suats1Ctgkpk0rHtFxcXJPay/PkGnH5EK
	 2MO6+Tg2093zxg1y6AQFsOa/Tb9fAwnWmtL2//NCBg9IjOksWY3qpE1aHmfbaNM0ZA
	 UgMev1XDFe0BaKLcAcGvC/QRkNdXHIjE0Ea/MSfWCQURTQt6nEPlsirjoS2g1CCeNj
	 RHv/xTxP7ATcg==
Date: Fri, 6 Mar 2026 19:07:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?B?QmVub8OudA==?= Monin
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Paolo Valerio
 <pvalerio@redhat.com>
Subject: Re: [PATCH net-next 2/2] net: macb: distribute evenly Tx SRAM
 segments
Message-ID: <20260306190714.6cfbf3ce@kernel.org>
In-Reply-To: <20260305-macb-set-channels-v1-2-28e3a96a3dc3@bootlin.com>
References: <20260305-macb-set-channels-v1-0-28e3a96a3dc3@bootlin.com>
	<20260305-macb-set-channels-v1-2-28e3a96a3dc3@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C0AF8229BB8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265022-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, 05 Mar 2026 18:20:15 +0100 Th=C3=A9o Lebrun wrote:
>  MODULE_DESCRIPTION("Cadence MACB/GEM Ethernet driver");
>  MODULE_AUTHOR("Haavard Skinnemoen (Atmel)");
>  MODULE_ALIAS("platform:macb");

these macros should be at the end of the file
you should probably move the test to a new file

> +#ifdef CONFIG_MACB_KUNIT_TEST
> +#include <kunit/test.h>
> +
> +struct macb_sram_segments_case {
> +	unsigned int num_queues, num_segments;
> +};


