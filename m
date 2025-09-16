Return-Path: <netdev+bounces-223660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0F5B59D54
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF8824E25CD
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA432F616D;
	Tue, 16 Sep 2025 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="afyD42e0"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817F62550CA
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039603; cv=none; b=jPxRvgzPUJU3dcO5oP12cZyMBAv6rs56G0oDqOZm5yasBBKk0BsSLAOB6XidjiRnVRq6ADrM/qKsezdxgpIkVKFe3glzmTUEBbQQwoZBRBpsAYvK4vry/X8jK12qE3XRx9dcW/FZJivMENd8NrCm8cB+BHKWuaj2EIwhAX2vej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039603; c=relaxed/simple;
	bh=2KVXFAZp5IcHcS48N3SKVacU5EiaWni1hFMGzAygg3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ST1LRd3n9OT0aUtHbjvLdTuB/5z6n+QjYxipeg1rcL3AZB2bRGmfumDkFVCu6TMuJva2q/ZaLIdPoyUs++W4cfwixeLa4XbM67iXcErq20LtRubHqX0nPJo1ta/RoMQdshJVzbJmrSM6sQ6Je6yRRdPvMpfarfW3mOvH5EL0FzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=afyD42e0; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A01D21A0D84;
	Tue, 16 Sep 2025 16:19:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 680976061E;
	Tue, 16 Sep 2025 16:19:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 18884102F17A0;
	Tue, 16 Sep 2025 18:19:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758039597; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ej+wp5p0fJnjhQXj/WM+W+BpDjADolh8Mt44etUbHsE=;
	b=afyD42e0P2VcYx6l8yshxYMReM4wzxrYhRibzcL67RgODiVLwheEMFqYZsO2BCeG9v9EZJ
	oGV/GwwRuycg9f4Uq3ssq9uDTc7B1wpZ45tsnPtxwIYoYRVv3heT5yhCFg9kWHO2hrrmAR
	dQGBo0puAotlCcXXmvvM8U3u23wDa5dNNBHcdp5jh6ULItRzto0uNxmrFYBKLJvsh+ZnKq
	kn2jga8rRUaWBPP4dvlwZt4nTOmcAwGg/AZ8hXde3My17d5uaZH/NI5cZCK81RdWP+9Vin
	2etuv1M52cSY/OTJrkurXHicj0WeezV70rLIwz0T//a7DpfOzGRBFC4Jq87jTA==
Date: Tue, 16 Sep 2025 18:19:53 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: David Ahern <dsahern@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH iproute2-next 1/2] scripts: Add uapi header import
 script
Message-ID: <20250916181953.1c0aa4ee@kmaincent-XPS-13-7390>
In-Reply-To: <7d03fa72-b6ca-4f98-9f48-634ea45a0cc8@gmail.com>
References: <20250909-feature_uapi_import-v1-0-50269539ff8a@bootlin.com>
	<20250909-feature_uapi_import-v1-1-50269539ff8a@bootlin.com>
	<20250916074155.48794eae@hermes.local>
	<20250916180100.5f9db66d@kmaincent-XPS-13-7390>
	<7d03fa72-b6ca-4f98-9f48-634ea45a0cc8@gmail.com>
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

On Tue, 16 Sep 2025 10:05:16 -0600
David Ahern <dsahern@gmail.com> wrote:

> On 9/16/25 10:01 AM, Kory Maincent wrote:
> > On Tue, 16 Sep 2025 07:41:55 -0700
> > Stephen Hemminger <stephen@networkplumber.org> wrote:
> >  =20
> >> On Tue, 09 Sep 2025 15:21:42 +0200
> >> Kory Maincent <kory.maincent@bootlin.com> wrote:
> >> =20
>  [...] =20
> >>
> >> Script I use is much simpler. =20
> >=20
> > The aim of my patch was to add a standard way of updating the uAPI head=
er.
> > Indeed I supposed you maintainers, already have a script for that but f=
or
> > developers that add support for new features they don't have such scrip=
ts.
> > People even may do it manually, even if I hope that's not the case.
> > We can see that the git commit messages on include/uapi/ are not
> > really consistent.=20
> >=20
> > IMHO using the same script as ethtool was natural.
> > The final decision is your call but I think we should have a standard s=
cript
> > whatever it is.
> >=20
> > Regards, =20
>=20
> There are separate needs.
>=20
> I sync include/uapi for iproute2-next based on net-next. rdma and vdpa
> have separate -next trees which is why they have their own include/uapi
> directories. This script makes this part much easier for me hence why I
> merged it.
>=20
> Stephen will ensure all uapi headers match the kernel release meaning
> Linus' tree.

Oh, ok. Thanks for the clarification.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

