Return-Path: <netdev+bounces-256688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBs3I902g2kwjAMAu9opvQ
	(envelope-from <netdev+bounces-256688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 13:09:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C47CE5963
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 13:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96647300490B
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 12:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B2D3ED11A;
	Wed,  4 Feb 2026 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpT9SBxm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E56C3ED11F
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206938; cv=none; b=jX1v/ciesoPaK0q7EyfW2xLYpVR89h4ka1DN4iJ0oSVlOQKDZpVjqcel5esXDdSqFC6iR8wsOs6XnPft6YqbjX5rkxaiutSmFqfGftysK/cWhSPi0VaeJmvwFunibpjQgH4lh0uEdbvl/p+MC/BPIKwscJEphpEgQolHScoCS/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206938; c=relaxed/simple;
	bh=UUviRPGbzzkQIB3bfEJMdwX3h0vP0qCfzC2iQvSakNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VT9PXEac5o27Vs5sa/LV6C1nHswInTdV4WBDe1EFU6JbnQ7exNRRELgLzgZjteOp2iiJdqMT9UqoKRet7T7DetSjwsGygh+cDgyqFPdqjkSvECyLcuxdHkYBces4ebwxbaVXHJJIHY5YZ0Nnh+Tg90ImUhfW5nvSmBKhVls2NsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpT9SBxm; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-501488a12cbso81542551cf.3
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 04:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770206937; x=1770811737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UUviRPGbzzkQIB3bfEJMdwX3h0vP0qCfzC2iQvSakNA=;
        b=DpT9SBxm4QHMs3xEjMvQDY4zQI52NWnWeFEkb3Hh5iUEroDNniek5sEf29M/IDfLFN
         s8oK96nXmjh9flID8RYtVDnPgSbAZhFBEPdqg5c5kG+cNtGf0scvgnyMGIG4ssDH4/gP
         aNXGtdFEvAucnMNVQ56npOOmfkRt+0iKq4iZ4VjFeVeEdy+yQeeRtu2ap9A7BT//eNdn
         D/F1RsJFSs+fM2oxQpZuM84qd9jDLcb8v1DCKo6diQhW2+a/V4zhX/vo22+7Tj3syTog
         4OYk8W+OsDhFIuaax2x22FQBgU+1MOscldmJNHuwk8RllOc103LXWNGScUZcMFeGDXku
         9v4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770206937; x=1770811737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUviRPGbzzkQIB3bfEJMdwX3h0vP0qCfzC2iQvSakNA=;
        b=aRp+wuCPLr0yxG74oXguR5qxto07ro4IRSrNH50V+rc5VBPoidv9lAFOJipXJzzxFU
         A2e53NIV5B7hzYyQ3svJJ1wIB0cpJc98gpZOLJe+k6R8VRz5zxpWtnUbragdWGYqOJp0
         pbs8L7NXH273SD7HZA1ye2R3ZAQrY7ga7/9s49z/OTA+PewxB5fq8KtizSHBKhvC4mo+
         PCRuKwHKC3j5E4dgAymdHp/bDOepN3hy8P9fIFlStj3rR5QEg4i/2lXTG72SCEoPMuSY
         t25F2KQ+KZ578N51Ym/Vu0YI8GbXAs9enzBlUFJZXSDPUbfV2CrPweKdrV38hsaxEfaW
         w3pQ==
X-Gm-Message-State: AOJu0Yy0bFgdFwlKfX+upV5GNEbnLIe1mDvUV1W2DohZkNObAtjGaVLd
	mcOLztXPHrq8NBdP2JUi/Jh4eE1orOLJJg2mfVd108nVABodWoBcZqOh
X-Gm-Gg: AZuq6aJJXjzuVgX6vx7XcabC8M99TSAYLmmvT4UyCPRUEtW+8wROcGZtLgHpG0puB9w
	GTAq5VzFKXmwvJoUxeYZYO60gj4eO+OoxaZL9YQozUrla6iPfqeHHs1BILyxBIKEB1CpvVCCRXZ
	a4iS4S88fRxzEkO1p9Kq8LQJCcGWCKyheeBtbtNZVLs6zM9IrqN5MvN1I6gsz1ADVfQAb0eHv3G
	I72UoRc4SysR3jKoCYYJ8B/bkvjRxW6hQK47YIFahdUZCaQaCCVEOSLtqDWKSNs3LOcqaQuLRjq
	c6HIgDYTAZaoGc84fVffEUcfbQniDGIuvSKw39t85FtrzG0tcwI/CgYzC4FDi0GfAfmUrTWOdr1
	lUAP2dx5zpRR1w3frDpJWxBR+9J5xQeez2fLfE9sDG+tf3DjH7MPJ+0K4zuXEcqBu7p6sIsT+Ct
	jy4pNApok=
X-Received: by 2002:ac8:5847:0:b0:4ff:a40d:d2b2 with SMTP id d75a77b69052e-5061c0dd361mr33710771cf.16.1770206936812;
        Wed, 04 Feb 2026 04:08:56 -0800 (PST)
Received: from pek-khao-d3 ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5061c21e75fsm16408671cf.34.2026.02.04.04.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:08:56 -0800 (PST)
Date: Wed, 4 Feb 2026 20:08:48 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Byungchul Park <byungchul@sk.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Himanshu Mittal <h-mittal1@ti.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Meghana Malladi <m-malladi@ti.com>, Paolo Abeni <pabeni@redhat.com>,
	Roger Quadros <rogerq@kernel.org>, Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net-next 1/2] net: ti: icssg-prueth-sr1: Remove unused
 workqueue
Message-ID: <aYM20LhFdizztfrH@pek-khao-d3>
References: <20260204-icssg-prueth-workqueue-v1-0-9a892f4b293d@gmail.com>
 <20260204-icssg-prueth-workqueue-v1-1-9a892f4b293d@gmail.com>
 <b81fc1cb-066a-43be-8cb4-90a45bfc4b06@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0eorNAEsC7mvlorp"
Content-Disposition: inline
In-Reply-To: <b81fc1cb-066a-43be-8cb4-90a45bfc4b06@web.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256688-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_TO(0.00)[web.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C47CE5963
X-Rspamd-Action: no action


--0eorNAEsC7mvlorp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2026 at 11:38:37AM +0100, Markus Elfring wrote:
> > The dedicated workqueue emac->cmd_wq is not utilized in this driver and
> > can be safely removed.
>=20
> Wording suggestion:
> Remove the work queue =E2=80=9Cemac->cmd_wq=E2=80=9D because it is not ut=
ilized in this driver.

Will update.

Thanks,
Kevin

--0eorNAEsC7mvlorp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmmDNtAACgkQk1jtMN6u
sXGLFQf+Pl6kC5qcHNXnjVLfsBQrMlYCKCtl/+iv4YRYbnlIpgpc8njzuKjpuVxL
OHEyryLo0Mf+ctNsh0kDa5P8UHdSueT+A1E9VMc+aSABopzF42Pm1neUEurT7ILg
v9mkrQo4KFwa0Pil7WhOh+lgqRuxB/8UIYwSnu+fnPTdo6kaBclDCF4t32Rzl0td
UE8m4fOrIHsDu2821TqsFIBYjX2393NiVp4R4sjxoqcA7MxAZNvlvu66IJEERwE9
x52Eh+Y3QRA62eIqpjeik8qKrymMaZKKZXMdmO+sFNOA77Lo2IR+zJn/tGZONKt9
oH44+CFhLBW1WGj0uStrPn8x5fXvaA==
=U//q
-----END PGP SIGNATURE-----

--0eorNAEsC7mvlorp--

