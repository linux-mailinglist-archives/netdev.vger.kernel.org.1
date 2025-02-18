Return-Path: <netdev+bounces-167428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E752CA3A3DB
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0694161E3C
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 17:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E1426983F;
	Tue, 18 Feb 2025 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mfCuEOGh"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9872126E648
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898936; cv=none; b=ephgbPTKEymnqA+KzrOH24TcU8JqUvN1iviaLmxtFeHCuNzDbS2UaPi/3YH6cphDq6z9jgOmL4TlP/xm+BUErzYj+wEp9xehhH3KcwwJZEf5jYpw9uCc8jMDunevjfg+suvSpssj6hldTT98aUN9jeYQLZS+xxEdb8dmlbuVXBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898936; c=relaxed/simple;
	bh=WqXuLzgMxDqbx35g4hAObsmHu2LdfWz2UG42BCC6r5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kf/XcxCAiwwlqbugASRc+qiczHE8ljDTcvqceOefE3I13OMLqSJ2UnYpLyOJI+kzKBlXFFpzHqZUdIKzQepAf6VleJ2Pi6YBOJgWPNYpscm62bSc4o7AmO4smiUO+7bV/CMcMU0XidowNARgmcrGzHhQwfyViJIiqEOM+fSMWfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mfCuEOGh; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0EC6B4329A;
	Tue, 18 Feb 2025 17:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739898926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ze0gjov6UFAM9Nc2SES+UkpImak9wX6sdp3PqJj9fuw=;
	b=mfCuEOGhdBWCTTjQXn7puXH9uMLu7PdC3opoLIloQDJBdLzycQeydTuCilKeyPMooePCNC
	IfR84k+DNJXL+XieStp5Mlmc4F5YHx1mG54NwUouKL2VtITlCspL14YAXY/4eJOSCYauOb
	MkbeBRLGkGuesxg4BmIkNAiQhPYfjEoK+uK7G05VxeLnemvri4uXJFgRDAzv2NzEAkWJFl
	FrCkY+sbumv6aHPX9g0otQnIa4Tnrr10/kCI7rHfRyCPMp/3PWbrX+LKUufET+OJA9j4Fg
	aQyZCEB6R5sc3wNRa13AnHiHqW+OmYodXUvc2EzSwc/iSxEvWIYrelpGf/eQ/g==
Date: Tue, 18 Feb 2025 18:15:23 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <edumazet@google.com>, <horms@kernel.org>,
 <donald.hunter@gmail.com>, <dsahern@kernel.org>, <petrm@nvidia.com>,
 <gnault@redhat.com>
Subject: Re: [PATCH net-next 5/8] net: fib_rules: Enable port mask usage
Message-ID: <20250218181523.71926b7e@kmaincent-XPS-13-7390>
In-Reply-To: <20250217134109.311176-6-idosch@nvidia.com>
References: <20250217134109.311176-1-idosch@nvidia.com>
	<20250217134109.311176-6-idosch@nvidia.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudeklecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdtudemfedtheefmegrvdeiieemsgeileekmeekvdgrtdemgeguugekmegsrggvtgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggstddumeeftdehfeemrgdvieeimegsieelkeemkedvrgdtmeeguggukeemsggrvggtpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehiughoshgthhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrv
 hgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 17 Feb 2025 15:41:06 +0200
Ido Schimmel <idosch@nvidia.com> wrote:

> Allow user space to configure FIB rules that match on the source and
> destination ports with a mask, now that support has been added to the
> FIB rule core and the IPv4 and IPv6 address families.
>=20
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/core/fib_rules.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
> index ba6beaa63f44..5ddd34cbe7f6 100644
> --- a/net/core/fib_rules.c
> +++ b/net/core/fib_rules.c
> @@ -843,8 +843,8 @@ static const struct nla_policy fib_rule_policy[FRA_MA=
X +
> 1] =3D { [FRA_DSCP]	=3D NLA_POLICY_MAX(NLA_U8, INET_DSCP_MASK >> 2),
>  	[FRA_FLOWLABEL] =3D { .type =3D NLA_BE32 },
>  	[FRA_FLOWLABEL_MASK] =3D { .type =3D NLA_BE32 },
> -	[FRA_SPORT_MASK] =3D { .type =3D NLA_REJECT },
> -	[FRA_DPORT_MASK] =3D { .type =3D NLA_REJECT },
> +	[FRA_SPORT_MASK] =3D { .type =3D NLA_U16 },
> +	[FRA_DPORT_MASK] =3D { .type =3D NLA_U16 },
>  };

I don't get the purpose of this patch and patch 1.
Couldn't you have patch 3 and 4 first, then patch 2 that adds the netlink a=
nd
UAPI support?

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

