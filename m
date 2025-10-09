Return-Path: <netdev+bounces-228433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22426BCACC6
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 22:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDFE14E2784
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 20:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C62526F28B;
	Thu,  9 Oct 2025 20:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="RsElYeKw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC626CE23
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 20:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760041498; cv=none; b=fHWPTMK0HlLH2tGOBaN+OplnjvWkeQRPlniUSgW+lSw2twZpTamTsFOBngyubzVxAg4V1BT9qZiO5Q/jIda4bynrGuzWz+SMA/4uswUYEN2NzfzGSGq4NMTZOF931++FKVg9cJs4vXdD7Zm+iWhYmQwEs3Zd0PWi7EhXaXK2YQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760041498; c=relaxed/simple;
	bh=BHd7lLBx7AYhSrKNdnqkY6uoG/CPiuqoFXvgIGhkI4Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QympnxAbbO8pvlmEbZSLyKuuLZqh8/easmajt8ms8PX8h4nPiET26aTh01hG6wVZvcxA1J22/fFM36g4hV+OfCdNCR77bsrcJWFApVniyKDKeYHi+FxEEZdKLsUn6OY5To0RvbasHlpAcLft5dHDlxD4ZHJKRyjksCSl4kCVTZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=RsElYeKw; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1760041488; x=1760300688;
	bh=BHd7lLBx7AYhSrKNdnqkY6uoG/CPiuqoFXvgIGhkI4Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RsElYeKwV5cdfXJmxXWKul3p0b6I595nlYpR8J4aozQ9+wbAo2QTZkO5NPY8VeDxD
	 hUAf/pcHFB4HYJR3GeKpPepu4bduY76Iygr64wTWDfxmzaZLQorlQGOEBVjVWIuqLd
	 BitUHP9vJJKjHuQP4m9qMmznQGNRtzKrQemHu/RhvFmwTTePO141pR62W0orr00JZY
	 TVoQwMgXb5K/9Vrx77yVgcUllkLyy5ueILJH325Ctti7Ufh6tLcgPxGEUVESKAq0P4
	 oA9yNIeeUCRPOTos4OxqzhIrfuHH599YYRL+B6x7Z71KEfw94W6WuxmlQqUUcHWula
	 NOZwe0piq4TXg==
Date: Thu, 09 Oct 2025 20:24:43 +0000
To: Donald Hunter <donald.hunter@gmail.com>
From: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH] doc/netlink: Expand nftables specification
Message-ID: <8DeRsroLNgWYQgSbBhZxQ50aX1W-Q6so6LeuEBhe4_OJoqFqd2jEaCEIGQn3DlJeGs2Ci_lF0FRWjKkSJhbHbn_BEq-B5M3qsiJn5-FjQ1E=@protonmail.com>
In-Reply-To: <CAD4GDZyvO-Uw73hRRhcu7ZSuhXR_XmpTzx_GVyO5qFVukov4dA@mail.gmail.com>
References: <20251002184950.1033210-1-one-d-wide@protonmail.com> <m25xcssae1.fsf@gmail.com> <CAD4GDZyvO-Uw73hRRhcu7ZSuhXR_XmpTzx_GVyO5qFVukov4dA@mail.gmail.com>
Feedback-ID: 59017272:user:proton
X-Pm-Message-ID: 13a74045b7f559f6a15aff4ee92cc735575dbd72
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, October 3rd, 2025 at 6:05 PM, Jakub Kicinski <kuba@kernel.org> w=
rote:
> Hm, hm, hm. So for "do" we use empty replies to mean that the reply
> will actually arrive but it will have no attributes. Whether an
> operation returns a reply or not cannot be changed once operation
> was added without breaking uAPI. So the empty reply is a way for us
> to "reserve" the reply because we think we may need it in the future.
>=20
> Or at least that's what my faulty memory of the situation is.
>=20
> What an empty dump reply is I do not know. How we could have a dump
> enumerating objects without producing replies!? :$


I spent some time annotating the missing attributes, so fixing the rst scri=
pt
isn't required, at least for this patch. Thanks for clarifying though, I di=
dn't
notice the distinction at first.


On Friday, October 3rd, 2025 at 9:04 PM, Jakub Kicinski <kuba@kernel.org> w=
rote:
> Please don't send a reply in a previous thread and 4 min later a new
> version of the patch :(


Sorry ._. I will use this (older) thread.


On Monday, October 6th, 2025 at 2:08 PM, Donald Hunter <donald.hunter@gmail=
.com> wrote:
> On Mon, 6 Oct 2025 at 09:29, Donald Hunter donald.hunter@gmail.com wrote:
> > Can you run
> >=20
> > yamllint Documentation/netlink/specs
> >=20
> > The patch adds several errors and warnings.
> >=20
> > Cheers!
>=20
>=20
> Can you also use the nftables schema with the python cli, or at least run=
:
>=20
> ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/nftables.=
yaml
>
> (This is something we should automate as part of make -C tools/net/ynl)


Done. All 3 are working in patch v3.


> The spec has a lot of schema errors to resolve. You'll also need
> changes to the netlink-raw.yaml schema because it is missing the 'max'
> check.
>=20
> diff --git a/Documentation/netlink/netlink-raw.yaml
> b/Documentation/netlink/netlink-raw.yaml
> index 246fa07bccf6..9cb3cc78a0af 100644
> --- a/Documentation/netlink/netlink-raw.yaml
> +++ b/Documentation/netlink/netlink-raw.yaml
> @@ -19,6 +19,12 @@ $defs:
> type: [ string, integer ]
> pattern: ^[0-9A-Za-z_-]+( - 1)?$
> minimum: 0
> + len-or-limit:
> + # literal int, const name, or limit based on fixed-width type
> + # e.g. u8-min, u16-max, etc.
> + type: [ string, integer ]
> + pattern: ^[0-9A-Za-z_-]+$
> + minimum: 0
>=20
> # Schema for specs
> title: Protocol
> @@ -270,7 +276,10 @@ properties:
> type: string
> min:
> description: Min value for an integer attribute.
> - type: integer
> + $ref: '#/$defs/len-or-limit'
> + max:
> + description: Max value for an integer attribute.
> + $ref: '#/$defs/len-or-limit'
> min-len:
> description: Min length for a binary attribute.
> $ref: '#/$defs/len-or-define'


Thanks, will use. I would've otherwise ended up just removing these annotat=
ions :)

