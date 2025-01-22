Return-Path: <netdev+bounces-160364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C14DFA19635
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 17:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296C73A7ABF
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 16:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338A3215050;
	Wed, 22 Jan 2025 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MZVGYEPu"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAB721504D;
	Wed, 22 Jan 2025 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737562358; cv=none; b=oX29hVLrOvauzem7oVLVea7+mhFyBiL4QSATQS/O86mN8wQRjAGMUDayF/DD9hb5sOefUg3RRbVHYadVkVPBBjxsmj0R7AshOr7lVsLVFGU+s1KeVNnleNHWE+4+2lYKtF0o5e3mVmHN2SXqG8yd05cZ6jTicL+9fSl0JboOZV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737562358; c=relaxed/simple;
	bh=Ss0ivYiq3qYwXu2RnysmIeReJX+53a3xDuWsv5s8DGI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hK3nrKsDqAcGJraVzJTv4eljqsT/hSnHFEV9Pem+x5e8Cpw8qaJVvs6L44T7LalItvfwQRmVaU3nIyVZSnbxVEWq06zI+FKFGi6yl6ehpIqBGA0l2F2Z6Uc4vWFMjRDM7ks9kOU/3gHHfnXCVKEz894KWj+Iyd0MlTIsGTu8Xqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MZVGYEPu; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BC037C0005;
	Wed, 22 Jan 2025 16:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737562353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxsHTcPv4sm6yAgaSsxSIAKm1+TIlbp8nqRUuKiL1kI=;
	b=MZVGYEPublgdSVBbcMCGziiHNUR4lWkqaQ+3gGjRD5P6/47Ib9k+wSMHzaEYOlCsABnvw7
	KazuMys5ksdyvXvK5KNW/KY/7zYBngNSVeOVPexQalQ/yuWWiy/8smo0IV2llO99LQk1Rq
	BHvNl5zBTBMitxaHPwgA5pI00cVSlSYkNSS58tIpB8glDEgTML9YyLPQvNgPqJ3O2MSKeS
	3JLprlAk/f+kkOluq1jr33U4/1TbiAbCPPT0xZ9GJsbbEpY1SOuJ1T/BJ79bZdL1qD8uhS
	YH/ZSZIeledSoAUd6INlYWVWsmFQCJsuDNjhF8B6X/AvoBkqPeyC8880PwNz1g==
Date: Wed, 22 Jan 2025 17:12:29 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>, thomas.petazzoni@bootlin.com, Andrew
 Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?=
 <niklas.soderlund@ragnatech.se>, Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH net-next v3] net: phy: Fix suspicious rcu_dereference
 usage
Message-ID: <20250122171229.3e0b2111@kmaincent-XPS-13-7390>
In-Reply-To: <f8b5beb4-ac3d-417c-810e-d96901f688db@bp.renesas.com>
References: <20250120141926.1290763-1-kory.maincent@bootlin.com>
	<20250120111228.6bd61673@kernel.org>
	<20250121103845.6e135477@kmaincent-XPS-13-7390>
	<134f69de-64f9-4d36-94ff-22b93cb32f2e@bp.renesas.com>
	<20250121140124.259e36e0@kmaincent-XPS-13-7390>
	<d512e107-68ac-4594-a7cb-8c26be4b3280@bp.renesas.com>
	<20250121171156.790df4ba@kmaincent-XPS-13-7390>
	<f8b5beb4-ac3d-417c-810e-d96901f688db@bp.renesas.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 22 Jan 2025 14:03:37 +0000
Paul Barker <paul.barker.ct@bp.renesas.com> wrote:

> On 21/01/2025 16:11, Kory Maincent wrote:
> > On Tue, 21 Jan 2025 15:44:34 +0000
> > Paul Barker <paul.barker.ct@bp.renesas.com> wrote:
> >  =20
> >> On 21/01/2025 13:01, Kory Maincent wrote:
> >>  =20
>  [...] =20
>  [...] =20
>  [...] =20
> >>
> >> ravb_ptp_stop() modifies a couple of device registers and calls
> >> ptp_clock_unregister(). I don't see anything to suggest that this
> >> requires the rtnl lock to be held, unless I am missing something. =20
> >=20
> > What happens if two ptp_clock_unregister() with the same ptp_clock poin=
ter
> > are called simultaneously? From ravb_suspend and ravb_set_ringparam for
> > example. It may cause some errors.
> > For example the ptp->kworker pointer could be used after a kfree.
> > https://elixir.bootlin.com/linux/v6.12.6/source/drivers/ptp/ptp_clock.c=
#L416
> > =20
>=20
> I've dug into this some more today and looked at the suspend/resume
> paths of other Ethernet drivers for comparison.
>=20
> netif_device_detach() and netif_device_attach() seem to be safe to call
> without holding the rtnl lock, e.g. the stmmac driver does this.
>=20
> In the suspend path, we should hold the rtnl lock across the calls to
> ravb_wol_setup() and ravb_close().
>=20
> In the resume path, we should hold the rtnl lock across the calls to
> ravb_wol_restore() and ravb_open(). I don't think there is any harm in
> holding the rtnl lock while we call pm_runtime_force_resume(), so we can
> take the lock before checking priv->wol_enabled and release after
> calling ravb_open().
>=20
> How does that sound?

Yes that sound nice, and similar to what I thought.
I will send a patch, I also found the same issue on sh_eth driver.

Regards
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

