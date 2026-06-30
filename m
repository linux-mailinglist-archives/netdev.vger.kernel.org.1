Return-Path: <netdev+bounces-303393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /S0BK5dDRGpqrgoAu9opvQ
	(envelope-from <netdev+bounces-303393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 00:30:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6CC6E86B7
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 00:30:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=a3nZipE5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303393-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303393-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58742301F1E8
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 22:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B248328B71;
	Tue, 30 Jun 2026 22:27:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D47F29C327
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 22:27:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858452; cv=none; b=IWCh2gqGFZyGgi293duKXtIvIX+Rbc1ZLx9cYZKVGVBpe+0EepHe/Ld5wEccOR8Y3DSM2jRMYA1kvhSzaj+3eAWLFb38X+1gVEmOhRYR6eyfZBh5XNW59qJlfypts+yWONo4YN0dKfyxxVrLLpnYBZ+DDiwbio5+zXa2GpTZuR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858452; c=relaxed/simple;
	bh=TTcVu3N5A2qxImNE8jx0tO9sA0vxx21QZu6VSH0wmU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XL+Ga00LgMq/n1j65GGqimUD58Ek5u+CnHTPQT9B9PvyrsdQ4x2wze3tQwZH3wE5AslTkEIIXvyt5IZOPdLL+l+AJMMwZ1NlqY5YTgjWmBLtQVTx9BvNifCsxTFUuhQ5mgAJs/vMfWlNLP7ZFMzPOKRsoMQ1jhsgwd8X7ZWSm+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3nZipE5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A761F0155D
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 22:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782858450;
	bh=TTcVu3N5A2qxImNE8jx0tO9sA0vxx21QZu6VSH0wmU4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=a3nZipE5rJA5y3N4Pt43hJP+a36yVR5xrcMfyXU20kSXL/EMJ9K0p232l6Wre9wwp
	 XZGaTAaW+es9sgk2ARLIAXeZYTEfZEKo5NkLTX00wcwnR0btmfhuX2qmDgsgRcXS/Q
	 BaQDKyMcLqkohVenN5e9fDl+zIbBLwde996RnNIGz3h3eKEQE15LGapkSZsv9IMD0m
	 Iqoina2XyIvqZEumLIqhlDlgyvjWqtUVlH/1DwkhbLX9mv9yy2rvdW7YtvW9bGvLLU
	 x9VHYe8+Vd4Yjn/Rs6RW4nQMcWgQ6Jl5XlPCKLmcmP5L7dbjrZpWPH2Edj+0omjQhI
	 Ur0N2LFTC6dYA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39af87c4589so33491fa.2
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:27:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrwrzYGp4dBwtzgb97TbVcNzcpIVkIlCI9Qbp20Kbfk7JFv36ehsslM1pJ+vbqHfUTtfiVVoro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Su+OCyuUwD5FxKXXvqSKODQuZHeWlQN7xbcJeTzuRZNNOexf
	eASmFyW0yXFqhw/HmREygua/qL5GvdHR+QWysiuJNz9Bj1tj1S3SnVmfGfVi39neFt4bix1X4lD
	EdhMiTFua57c62Kxk6RupOgn1HVrVG0c=
X-Received: by 2002:ac2:4bd0:0:b0:5ae:a2b5:3ae3 with SMTP id
 2adb3069b0e04-5aebdbb32bdmr1526007e87.29.1782858449161; Tue, 30 Jun 2026
 15:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630092406.150587-1-manikandan.m@microchip.com> <20260630092406.150587-6-manikandan.m@microchip.com>
In-Reply-To: <20260630092406.150587-6-manikandan.m@microchip.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 1 Jul 2026 00:27:17 +0200
X-Gmail-Original-Message-ID: <CAD++jLmURCUfQNoTgLeTRtxfoWxgyPcmHv6rJpmB1gXWFL+NGA@mail.gmail.com>
X-Gm-Features: AVVi8CfX0Qclfl00TlhG9NPtI9hB9ExKc-14XAFH9ZzPrWiRzE1N9YyLdRCBq80
Message-ID: <CAD++jLmURCUfQNoTgLeTRtxfoWxgyPcmHv6rJpmB1gXWFL+NGA@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] ARM: dts: microchip: sama5d27_wlsom1: use
 fixed-partitions for QSPI flash
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303393-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,microchip.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF6CC6E86B7

On Tue, Jun 30, 2026 at 11:26=E2=80=AFAM Manikandan Muralidharan
<manikandan.m@microchip.com> wrote:

> Move the QSPI flash partitions under a "partitions" node with the
> "fixed-partitions" compatible, as required by the current MTD partition
> binding, instead of declaring them as direct children of the flash node.
> No functional change.
>
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

