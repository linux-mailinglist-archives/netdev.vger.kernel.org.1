Return-Path: <netdev+bounces-303591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Wx4aNSPyRGoD3woAu9opvQ
	(envelope-from <netdev+bounces-303591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:55:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE406EC6A3
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 12:55:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jj9yNpcE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303591-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303591-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FBD0300823A
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 10:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B23340801E;
	Wed,  1 Jul 2026 10:54:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC76540488C
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 10:54:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903248; cv=none; b=Wp0YS4bg7fyle2T5wvxR3Q8pJ5yJ+6NCDSoJ44oVLq2y8mOCkObuhNcs6WXnbXF8dOiTwoWcnYXJ7ATtFrchJVMyC/SnewV+B4Het2t7a7M5FfCJ98unvbPaTk5Vyr6bfDvZveBXPN9LkH+GjsQMBstUJhNMcuetT7rs82rHm10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903248; c=relaxed/simple;
	bh=KfPLUHbv6VqfMJCkJoMTAP4YFtOSL1LJmXwMk+chWo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Que/iiUYOSSDxDAeV6Nvwxqt732iUj6HzFIFt6Ld0AU/88rE4K00doSfPIIeLcC+LqonUeKBubz/7hVIvMY0vt8tfA50vAGIiQUOwyYPBfJh/f3Jwa7iEM76b9a+qNA3+vXtxnh2z5aEiA9IfoYkqyof6Bkzqug1ObQeeg3dstE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jj9yNpcE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270B31F00AC4
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 10:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782903244;
	bh=3dFhZqVXlPw7AKqdGyCXcF9/T5J+z7jeRJ0PFE89kgg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jj9yNpcE4V6NcdQD4g05CJvWOH6GRskIlx3Mmm69xy5BxwxpnrT5BqC0gHnRaUFyt
	 O23edhYADsdZPU+HZKUrz/oCTTvue+X/Sp2hJmpFu2roFbszryTFSeR5HMka7v15M0
	 piz/7BCnE+I5rarI7mx8TRbeX572MZy+4DIlZ/RUU66TBUrN+Iq/kEMOXU8miLkKR/
	 QaT0LjyVP4y6A2O8sI1q6SOw1xZHoV69d7p4H5xqnwLeHBVh4QgicvGaOohR+OLjXv
	 72+VPyRgVlGIGtnMYgbqhMcUS4kG1TMB0E3Vyt8d/L1Qp43iVzWVF/2cfTSmxugvBM
	 17ZM8I8DSAy/A==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aeb18fe7ceso306564e87.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 03:54:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RovwAfCexDRmUVOzG7umPm+/7j/GZvDEG5tLWv/Je3PouUHtvrZu7qGY10Onsoujdb33h0VZKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi4B8qViF1LRFMG1rOqJHZMote6uyY9uUPVuRIhHXfD++lGDhZ
	wcKnIxzbhsS/KXPtUz1JMnx9JO9/4DbJcr1/DA9GASPUW4EhxPFobRvRSxdLLmxNGfNHzIqC7AO
	UA0NxeBJEkCEyPtzkmzs9YHaH2aSTmrI=
X-Received: by 2002:a05:6512:1043:b0:5ad:67d6:a2d9 with SMTP id
 2adb3069b0e04-5aec68b453fmr281719e87.39.1782903242946; Wed, 01 Jul 2026
 03:54:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630092406.150587-1-manikandan.m@microchip.com>
 <20260630092406.150587-2-manikandan.m@microchip.com> <CAD++jL=FkEfpz-LW0vmPpZ28fLfGFMWo5E479Mapz55YUxKNAQ@mail.gmail.com>
 <DJN3HIIAY4LE.3MXU9Q2YFSCJJ@walle.cc>
In-Reply-To: <DJN3HIIAY4LE.3MXU9Q2YFSCJJ@walle.cc>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 1 Jul 2026 12:53:49 +0200
X-Gmail-Original-Message-ID: <CAD++jLntmnwU3gAQfDn2nd4CQ_7HY6S_kBguVtZvVT1PktFCPw@mail.gmail.com>
X-Gm-Features: AVVi8Ce_77SqNNQU5uO1pZpVOGBbpgsRt39tcDkp1nPUZH97o9So0gRgVCLSXDs
Message-ID: <CAD++jLntmnwU3gAQfDn2nd4CQ_7HY6S_kBguVtZvVT1PktFCPw@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: mtd: jedec,spi-nor: allow the SFDP to
 be exposed via NVMEM
To: Michael Walle <michael@walle.cc>
Cc: Manikandan Muralidharan <manikandan.m@microchip.com>, pratyush@kernel.org, mwalle@kernel.org, 
	takahiro.kuwano@infineon.com, miquel.raynal@bootlin.com, richard@nod.at, 
	vigneshr@ti.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	srini@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, linux@armlinux.org.uk, richardcochran@gmail.com, 
	arnd@arndb.de, linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-303591-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael@walle.cc,m:manikandan.m@microchip.com,m:pratyush@kernel.org,m:mwalle@kernel.org,m:takahiro.kuwano@infineon.com,m:miquel.raynal@bootlin.com,m:richard@nod.at,m:vigneshr@ti.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:srini@kernel.org,m:nicolas.ferre@microchip.com,m:alexandre.belloni@bootlin.com,m:claudiu.beznea@tuxon.dev,m:linux@armlinux.org.uk,m:richardcochran@gmail.com,m:arnd@arndb.de,m:linux-mtd@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[microchip.com,kernel.org,infineon.com,bootlin.com,nod.at,ti.com,tuxon.dev,armlinux.org.uk,gmail.com,arndb.de,lists.infradead.org,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FE406EC6A3

On Wed, Jul 1, 2026 at 10:34=E2=80=AFAM Michael Walle <michael@walle.cc> wr=
ote:

> If I'm correct, this is the old style, see commit bd912c991d2e
> ("dt-bindings: nvmem: layouts: add fixed-layout"). So it should
> eventually look like:
>
> sfdp {
>      compatible =3D "jedec,sfdp";
(...)
> Also I'm not sure if we really need to add the "nvmem-cells" here.
> IIRC in MTD it was there to tell a driver to add an nvmem device to
> an already existing compatible/node.
>
> Apart from the MTD case, I've just found qcom,smem-part,yaml which
> has compatible =3D "nvmem-cells".

You're right, I was using old information, discard my comments...
Reviewed-by: Linus Walleij <linusw@kernel.org>

I think my comment in the driver to check for the compatible
instead of the node name is still valid though.

Yours,
Linus Walleij

