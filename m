Return-Path: <netdev+bounces-303388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BU2kDtQ/RGqJrQoAu9opvQ
	(envelope-from <netdev+bounces-303388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 00:14:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D786E85A4
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 00:14:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PJgsHN6y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303388-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303388-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE35730EDAB2
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 22:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2BC331214;
	Tue, 30 Jun 2026 22:13:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E2F30FC23
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 22:13:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782857585; cv=none; b=DyxZ16Dma9dj3I3GqtAoSP5xCIIcVeIRkdRgYUGzFuqXjgn9tbLkvDiO1BsB3BwlfIQyzER12chS0x+LTdyE8Is4UQGyw1QTOlP15R0s7xAg4EkloqJ8zFdWX9aJ+vQ/LgZT4nzXX3sQyvs9cJRdrwl1YBBa2PVaZdNsiPdtdis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782857585; c=relaxed/simple;
	bh=a/lxtTDTDg9qHZ1XxJGp6GALUnxVcyilFnlyp8deNr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CyWl+KCXt88aEw8tX/4C3H8l0gerGuAx0QHzPaV085EjGrQuLEz9VwV0rasvnhmvdXKaDFtp7DoxCxPJqxXBv7SwJVVbUUaW73P+6sFdhMe9Nt6D96IMpUHoI2b1SpXrC3UxOnEURCnshKkpPKDi1Ym7V2b0fZMwG4DVbl7eexI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJgsHN6y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A4A1F00AC4
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 22:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782857583;
	bh=HM1j74yODPhJMYhAe8Gysw58b33HB8UlPnD7jYgM3wc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PJgsHN6yFCy6uM8OzJ5er++rKVozMaAHvyDqrhtYfMPCCxrpB8AXLUA6uGg+5VklC
	 9duGS1uMgl4p3p5uoQL7TK9MhvxKTa2dKSCMTkS2w2VwjlYEbiWAkQa2L67HL5VVVd
	 9uvKdyQ3g4QVOBg20tia94Xcv+JC3R0uEMn+QJKcGoYACQdi1ovvRcZqMegBGiFT4p
	 hLtNn0IurWdCmVibLCpjZx2NvYHdoGJBdwYHxHXG+WkxypEPGGiZsPFfWJoND2Kal+
	 98zSH13AxZSGRmzDL3hBFy5vxpfe1HN4oOXaZk4ptIHXrsgqLoTMTFxyer7juhoAp7
	 7YulToC5Pm34w==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aea9d606f0so4354268e87.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:13:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpLhJVvKZbqkdWUQQJVQYOh78f4B7l277e7JII6pHR2QjBhmAWGZQkwJiWjongvjrvdEv5KW0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI/ChWOZOiPWQFUjvtF49YwHwkmA7/1AokkJgwFspOlnYiPbeV
	6ABWA0JDCjNb/KU2kkHboEee/DV1Mibv3VgkHeXsg/O8anO9a1+TwQrTH8eP752Dc3XMmAFnr8p
	Epit3Asap/u46ZahftaMuiL9+V7eR4eE=
X-Received: by 2002:a05:6512:1248:b0:5ae:b2cf:8204 with SMTP id
 2adb3069b0e04-5aec10a3841mr657448e87.2.1782857582274; Tue, 30 Jun 2026
 15:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630092406.150587-1-manikandan.m@microchip.com> <20260630092406.150587-2-manikandan.m@microchip.com>
In-Reply-To: <20260630092406.150587-2-manikandan.m@microchip.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 1 Jul 2026 00:12:47 +0200
X-Gmail-Original-Message-ID: <CAD++jL=FkEfpz-LW0vmPpZ28fLfGFMWo5E479Mapz55YUxKNAQ@mail.gmail.com>
X-Gm-Features: AVVi8CcLJOfvOFl8jmVmAP_uzLY_UWoBigmB1_kTp6EN1gm7rCEox0bV8PbTeSw
Message-ID: <CAD++jL=FkEfpz-LW0vmPpZ28fLfGFMWo5E479Mapz55YUxKNAQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: mtd: jedec,spi-nor: allow the SFDP to
 be exposed via NVMEM
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: pratyush@kernel.org, mwalle@kernel.org, takahiro.kuwano@infineon.com, 
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, srini@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, linux@armlinux.org.uk, richardcochran@gmail.com, 
	arnd@arndb.de, michael@walle.cc, linux-mtd@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303388-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:manikandan.m@microchip.com,m:pratyush@kernel.org,m:mwalle@kernel.org,m:takahiro.kuwano@infineon.com,m:miquel.raynal@bootlin.com,m:richard@nod.at,m:vigneshr@ti.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:srini@kernel.org,m:nicolas.ferre@microchip.com,m:alexandre.belloni@bootlin.com,m:claudiu.beznea@tuxon.dev,m:linux@armlinux.org.uk,m:richardcochran@gmail.com,m:arnd@arndb.de,m:michael@walle.cc,m:linux-mtd@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,infineon.com,bootlin.com,nod.at,ti.com,microchip.com,tuxon.dev,armlinux.org.uk,gmail.com,arndb.de,walle.cc,lists.infradead.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,microchip.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91D786E85A4

Hi Manikandan,

thanks for your patch!

On Tue, Jun 30, 2026 at 11:24=E2=80=AFAM Manikandan Muralidharan
<manikandan.m@microchip.com> wrote:

> Add an optional "sfdp" child node (compatible "jedec,sfdp") that
> describes the SFDP as a read-only NVMEM provider via nvmem.yaml, so its
> contents (e.g. a vendor EUI-48/EUI-64) can be read through NVMEM cells.
>
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>

I would expect it to follow nvmem conventions like this, notice
compatibles specific-to-general with sfdp first:

sfdp {
    /* NVMEM provided by SFDP */
    compatible =3D "jedec,sfdp", "nvmem-cells";
    label =3D "SFDP";
    read-only;
    #address-cells =3D <1>;
    #size-cells =3D <1>;

    mac0: macaddr@0x00 {
        reg =3D <0x00 0x06>;
    };
    mac1: macaddr@0x06 {
        reg =3D <0x06 0x06>;
    };
};

Your example should definitely be more elaborate like this,
just an opaque sfdp node will not suffice. Maybe a separate
example?

Yours,
Linus Walleij

