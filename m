Return-Path: <netdev+bounces-152666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 870969F528E
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 18:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F501189368D
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 17:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822571F867B;
	Tue, 17 Dec 2024 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XdPmlVl2"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC891F8675;
	Tue, 17 Dec 2024 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455838; cv=none; b=Ubp/7AQwFlEzHU8yrsyzeNkafSZXpq8yWXdHCU1SJ52DJTTlEV0B/HqlJ+ZPYvSvpoErMmlpQi/1Qq04ynXB2nON/iu/iU6S0vYZhxKDnaDtdRpSqdCuDFI74lPuKuSsIDwRp5L907kQcGuTvMW/XryviTmK6bk+K+YgIMrMhFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455838; c=relaxed/simple;
	bh=f0KxTvZs+Z4A6NRP57qnVQ3D8rE/TQ7ZAjAAjFTeeNA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cMsxSYEfRD9O5dG47/8Sh667Co7f83t5zYUpVQUkVkXlUnhSVlzS54H9hobdDbKXjCMDHSAXmU8CvkERJbQ62ec+HViu3YMoBTzpVt+9PGL8RX0E/yJoQkc83qQwAXIUvpRM80wXAnps9/5zdoSsYh3Zp8fIBEPlCfO7yhTVrmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XdPmlVl2; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 18BD3E0004;
	Tue, 17 Dec 2024 17:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734455833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ATVwJF9TkZPbMtVUlB2623GdQBxgV9d9dzo4IRLkn04=;
	b=XdPmlVl25UGMlCEF+kaD6vL8z8TZkkNYgn+ck2jL3DTa4x3D6Lzvo7Hw8xpwka0WFWWUP2
	krPyD16MmoSHTJbcGyh/UCi6d3xNgZsT52shhB2AXsBcHr/gd0fvw6pltLIY3IOvx5Rzfd
	27zV+CIfLydXJafyeNpj0wsaFxm4xc/uRn6tg7ioyqTpWhIlMb8MZtsXSKoawxYIcDkptk
	PS8eFY23hUoORhewm127oFXI2EfCFKvRM0VVpDSzdDRMA3ego5oz6Za/IwYQF8FWp6EjOy
	X7rs5r8LSnIYDOoT7zYvs9UQxB/rvQuSkCciviqDFfm4TMc60muusYbEnAeoVQ==
Date: Tue, 17 Dec 2024 18:17:12 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+a344326c05c98ba19682@syzkaller.appspotmail.com,
 thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] net: ethtool: Fix suspicious rcu_dereference
 usage
Message-ID: <20241217181712.049b5524@kmaincent-XPS-13-7390>
In-Reply-To: <CANn89iJ3sax3eRDPCF+sgk4FQzTn45eFuz+c+tE9sD+gE_f4jA@mail.gmail.com>
References: <20241217140323.782346-1-kory.maincent@bootlin.com>
	<CANn89iJ3sax3eRDPCF+sgk4FQzTn45eFuz+c+tE9sD+gE_f4jA@mail.gmail.com>
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

On Tue, 17 Dec 2024 16:47:07 +0100
Eric Dumazet <edumazet@google.com> wrote:

> On Tue, Dec 17, 2024 at 3:03=E2=80=AFPM Kory Maincent <kory.maincent@boot=
lin.com>
> wrote:
> >
> > The __ethtool_get_ts_info function can be called with or without the
> > rtnl lock held. When the rtnl lock is not held, using rtnl_dereference()
> > triggers a warning due to improper lock context.
> >
> > Replace rtnl_dereference() with rcu_dereference_rtnl() to safely
> > dereference the RCU pointer in both scenarios, ensuring proper handling
> > regardless of the rtnl lock state.
> >
> > Reported-by: syzbot+a344326c05c98ba19682@syzkaller.appspotmail.com
> > Closes:
> > https://lore.kernel.org/netdev/676147f8.050a0220.37aaf.0154.GAE@google.=
com/
> > Fixes: b9e3f7dc9ed9 ("net: ethtool: tsinfo: Enhance tsinfo to support
> > several hwtstamp by net topology") Signed-off-by: Kory Maincent
> > <kory.maincent@bootlin.com> --- net/ethtool/common.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> > index 02f941f667dd..ec6f2e2caaf9 100644
> > --- a/net/ethtool/common.c
> > +++ b/net/ethtool/common.c
> > @@ -870,7 +870,7 @@ int __ethtool_get_ts_info(struct net_device *dev,
> >  {
> >         struct hwtstamp_provider *hwprov;
> >
> > -       hwprov =3D rtnl_dereference(dev->hwprov);
> > +       hwprov =3D rcu_dereference_rtnl(dev->hwprov);
> >         /* No provider specified, use default behavior */
> >         if (!hwprov) {
> >                 const struct ethtool_ops *ops =3D dev->ethtool_ops; =20
>=20
> I have to ask : Can you tell how this patch has been tested ?

Oh, it was not at all sufficiently tested. Sorry!
I thought I had spotted the issue but I hadn't.

> rcu is not held according to syzbot report.
>=20
> If rtnl and rcu are not held, lockdep will still complain.

You are totally right.
I may be able to see it with the timestamping kselftest. I will try.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

