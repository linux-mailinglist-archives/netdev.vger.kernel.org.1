Return-Path: <netdev+bounces-227376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3147BAD6A4
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 17:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899394A3ED2
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 14:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11372FFDE6;
	Tue, 30 Sep 2025 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YPUpBDJH"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A87199939
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244316; cv=none; b=bWz8Z0ljHsdRpzFVI886UJgY+S2xZL8LvHnNWlG6qkCXnQUzQ81xhp4IIv1vMgUFWPy0Y6u1G2aqikMYQgN95t1f4lpK35dcCMq11kISkSI6m+2TnqM80YWRgrRI9C9O22VGINRQMVK2oT6aq+rfV9UrO1rezYFVIKY+M/e/O8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244316; c=relaxed/simple;
	bh=+Cv04hXie9pY5t+rS6VTb4NEvQMis80rh95/j5M/3Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T29DQy1bHBm2XLQQUuE85wzPSGUEhtFYUKOYEsG2ucVPiczjp9IXNYXp6TduoM9f+xXeo71+MqLVNyruCH/djGM0mVVR7MhYd40eBC2d2Q+gU7A2OG+aRhiFvA8G1YRsn/7/UuVSaYDXshK06W9wG+Gwwtf6F4jPyp4uDxhKtf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YPUpBDJH; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F34F91A0FE6;
	Tue, 30 Sep 2025 14:58:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C0FD9606E4;
	Tue, 30 Sep 2025 14:58:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 86CBB102F17E4;
	Tue, 30 Sep 2025 16:58:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759244309; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZtixQfXh2RNBNsi9rC4zcpKRdA5LL7GRjttgvrRwt6g=;
	b=YPUpBDJH0FiT0B9vXEKuBmUcyaXIQAmY0AMlq2YEvx4DUwlWcAY4OOkBhR4EKQrCL3UgTP
	vlUjk2aou2wMfPs/XIcgun/AdaULEZc+16bS6RCzGYJfsjNZVuRZooBAy/wkbn5s/W34YH
	4O65KoO8EYlBggTe+tvjjygt9patwxitWMQOqc/nXsZgDuBfZORddQi5PtartnPLnC0z7l
	SyEbztEtwBaKGBcqrevu4XwSRsLf6rlOSVMwwMzpN3NfWPY4A/giCzCKhxDwvHBvV4JZEM
	PwK/5cCSKrbtGw9N52guUI2M/DTxlzqE1aQL4XIFFlwJ9J3vWN+52PZHlGG/sA==
Date: Tue, 30 Sep 2025 16:58:17 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, kernel@pengutronix.de, Dent
 Project <dentproject@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] Preserve PSE PD692x0 configuration across
 reboots
Message-ID: <20250930165817.2e3e756d@kmaincent-XPS-13-7390>
In-Reply-To: <89ed50ab-07da-4514-b240-ed3d05400e91@redhat.com>
References: <20250930-feature_pd692x0_reboot_keep_conf-v1-0-620dce7ee8a2@bootlin.com>
	<89ed50ab-07da-4514-b240-ed3d05400e91@redhat.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 30 Sep 2025 16:40:51 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> On 9/30/25 11:12 AM, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > Previously, the driver would always reconfigure the PSE hardware on
> > probe, causing a port matrix reflash that resulted in temporary power
> > loss to all connected devices. This change maintains power continuity
> > by preserving existing configuration when the PSE has been previously
> > initialized.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> > Kory Maincent (3):
> >       net: pse-pd: pd692x0: Replace __free macro with explicit kfree ca=
lls
> >       net: pse-pd: pd692x0: Separate configuration parsing from hardware
> > setup net: pse-pd: pd692x0: Preserve PSE configuration across reboots
> >=20
> >  drivers/net/pse-pd/pd692x0.c | 155
> > +++++++++++++++++++++++++++++++------------ 1 file changed, 112
> > insertions(+), 43 deletions(-) =20
>=20
> ## Form letter - net-next-closed
>=20
> The merge window for v6.18 has begun and therefore net-next is closed
> for new drivers, features, code refactoring and optimizations. We are
> currently accepting bug fixes only.
>=20
> Please repost when net-next reopens after October 12th.
>=20
> RFC patches sent for review only are obviously welcome at any time.

Oops sorry that is totally true and I forgot that we have entered the merge
window. Sorry for the noise :/

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

