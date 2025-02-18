Return-Path: <netdev+bounces-167477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17073A3A742
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 20:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9105164A91
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1647F21B9DF;
	Tue, 18 Feb 2025 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="prwidybA"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D9221B9C4
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906576; cv=none; b=RADG/n9whdfrHeIEO46TQ73IAcPgEp/QYhnZD8DAqpxfDsgxkRxYIIbhi36Nj6wylFSylaAR3Hl3Tb7rJuZhs8iHv/dEdi8wkK+DTZSR00Zm4SD0yANVEmSeVxqyYnasGIdTL/n7JeB03NzbcUn/8EL7AiuiFp2V6kdY8Ic42Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906576; c=relaxed/simple;
	bh=wUnAO1ZDvxZpPJeymZsKfkAJ/DnDMsWAHnbCMlFP2vw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=buh9O2TtF+YRza0MKmKmstoGlow9yZxR0c3Eqxz4SENkH9byCjZTvgl8K/x4PRCyYH/RBiSWcWpT9bkDPHrEnTUz4od89D9fSF805+wnNVxBjjJzBp2x1/FszcuxlOPpZ1H+L2+sik63GPGBXTDvfSAQmpq8xPfGl10TVsYllSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=prwidybA; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 833F144444;
	Tue, 18 Feb 2025 19:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739906564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s0Ck/s9l4dl8ts5NEnBIJT3tF6gm0Eapi2M7IOAwyjs=;
	b=prwidybALn4eNqu5JfeWZ48L5rKVUeylKTkvVA+XboC/i3UNSiFQU747gnj8S5J8Sno/U9
	VMmMSvMTkSswvxmBKFCNatViLPVVOgdaCdVxgi12SlMW3NZCzXa1MVRSt1kklhfiLBI2MI
	3kf+6ipv7oi+xn/l+AEIsqZn1OPWIRlX9ToMNtP3NblQNsJRyN8+fQ6utELEr7jw5peIKk
	CUDFCUY9vy34Nzp4EOlH2K3dXzqXrGQOHy/BYy4D1BrT8A57/NnMiA9oEtdHaRrWxuFq62
	1qYrMLCFM/xmZ+VBfRD6YWRt4ObQGuofF06n+/Qm8lbyWfBKFTwEJhCcpm34Fw==
Date: Tue, 18 Feb 2025 20:22:41 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
 donald.hunter@gmail.com, dsahern@kernel.org, petrm@nvidia.com,
 gnault@redhat.com
Subject: Re: [PATCH net-next 5/8] net: fib_rules: Enable port mask usage
Message-ID: <20250218202241.3b0cf52c@kmaincent-XPS-13-7390>
In-Reply-To: <Z7TOVUyjrric13aw@shredder>
References: <20250217134109.311176-1-idosch@nvidia.com>
	<20250217134109.311176-6-idosch@nvidia.com>
	<20250218181523.71926b7e@kmaincent-XPS-13-7390>
	<Z7TOVUyjrric13aw@shredder>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeivddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdtudemfedtheefmegrvdeiieemsgeileekmeekvdgrtdemgeguugekmegsrggvtgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggstddumeeftdehfeemrgdvieeimegsieelkeemkedvrgdtmeeguggukeemsggrvggtpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehiughoshgthhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrv
 hgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 18 Feb 2025 20:15:49 +0200
Ido Schimmel <idosch@nvidia.com> wrote:

> On Tue, Feb 18, 2025 at 06:15:23PM +0100, Kory Maincent wrote:
> > On Mon, 17 Feb 2025 15:41:06 +0200
> > Ido Schimmel <idosch@nvidia.com> wrote:
> >  =20
> > > Allow user space to configure FIB rules that match on the source and
> > > destination ports with a mask, now that support has been added to the
> > > FIB rule core and the IPv4 and IPv6 address families.
> > >=20
> > > Reviewed-by: Petr Machata <petrm@nvidia.com>
> > > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > > ---
> > >  net/core/fib_rules.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
> > > index ba6beaa63f44..5ddd34cbe7f6 100644
> > > --- a/net/core/fib_rules.c
> > > +++ b/net/core/fib_rules.c
> > > @@ -843,8 +843,8 @@ static const struct nla_policy
> > > fib_rule_policy[FRA_MAX + 1] =3D { [FRA_DSCP]	=3D
> > > NLA_POLICY_MAX(NLA_U8, INET_DSCP_MASK >> 2), [FRA_FLOWLABEL] =3D { .t=
ype =3D
> > > NLA_BE32 }, [FRA_FLOWLABEL_MASK] =3D { .type =3D NLA_BE32 },
> > > -	[FRA_SPORT_MASK] =3D { .type =3D NLA_REJECT },
> > > -	[FRA_DPORT_MASK] =3D { .type =3D NLA_REJECT },
> > > +	[FRA_SPORT_MASK] =3D { .type =3D NLA_U16 },
> > > +	[FRA_DPORT_MASK] =3D { .type =3D NLA_U16 },
> > >  }; =20
> >=20
> > I don't get the purpose of this patch and patch 1.
> > Couldn't you have patch 3 and 4 first, then patch 2 that adds the netli=
nk
> > and UAPI support? =20
>=20
> Current order is:
>=20
> 1. Add attributes as REJECT.
> 2. Add support in core.
> 3. Add support in IPv4.
> 4. Add support in IPv6.
> 5. Expose feature to user space.
>=20
> Looks straight forward and easy to review to me and that's the order I
> prefer.

Ok, it is surprising to me. If there is an issue in patch 2,3 or 4. git
bisect will locate patch 5 and it won't be easy to find the real patch that
cause the issue. Having this type of patch series in the git history will h=
arder
the issue debugging.
I was not am not a net maintainer so I won't complain more and will let them
decide.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

