Return-Path: <netdev+bounces-126133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B61CE96FEE7
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 03:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20192284190
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C29A5258;
	Sat,  7 Sep 2024 01:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkHLATM+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F054689
	for <netdev@vger.kernel.org>; Sat,  7 Sep 2024 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725671657; cv=none; b=lMROUXE++oXZyT/fKqRDBn9JRtVAz8Lw3yj66Nza2bhXx3BWCaghAZAhqrVVJgi5skY4/moYcPbSlDAqop5anCDu7DyLTCieRA7yN9wncvP9UxmsnOaRza15c9VrUJLRJQYJKw99dCsBuF9nZ61g7pz3UpDTGV6zZQhzHjCcuRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725671657; c=relaxed/simple;
	bh=wf51T13dH53Kyjr9k6X4rECRSev9KzFZmG/yaTpBkVo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0Od8WgFLWvccFL09MEIXb6fifq5zmaRNhWAIDksoqmsWWzGpSsX+44tOGBNd5oo4tOYl6Qcc+FDJBBEE6ZIwM7o9QcgExaCPKCj/KTbr+sdUuUkeOyjRJUpgXRcDlqqDvEq2v0DjBw/QraenluvvGDEncrU8HqUMIz59lxus9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkHLATM+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BCAC4CEC4;
	Sat,  7 Sep 2024 01:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725671656;
	bh=wf51T13dH53Kyjr9k6X4rECRSev9KzFZmG/yaTpBkVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DkHLATM+cQka/l4F4KRRYxp7D456XNqh0W+W6SFpZU/mIByFNDGDwiV4JigTEY14P
	 Yux8T0xXHh3TtYfNqNsdeXKp3JlAysw4ypCnJgvcrHwN7+6gQIYrbYoSqK6rjXwKMM
	 XY3KXwxZ8eDdV0i7T5n1GCVPyU28Id6ARxh66KZaqHx1y+9Qv/mYA9wV6YFjn3UJ8T
	 M+q2Nmmqqumhz+9IB2MbYatQczwi9yV/aGKVSlcUFX7Op0HBnsK2/f53JJp811cGJL
	 a6Ufdnfsvxwcsc4k/HrAFVSI4FqTIx6RXZEaazusyO1epdMyC1ANXyqp1MYrBiSXoK
	 8HnDqJU81Xj1A==
Date: Fri, 6 Sep 2024 18:14:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>, Jamal Hadi
 Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Dave Taht <dave.taht@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, cake@lists.bufferbloat.net, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] sch_cake: constify inverse square root cache
Message-ID: <20240906181415.11d34150@kernel.org>
In-Reply-To: <20240904100516.16926-1-toke@redhat.com>
References: <20240904100516.16926-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  4 Sep 2024 12:05:16 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> +/* There is a big difference in timing between the accurate values place=
d in the
> + * cache and the approximations given by a single Newton step for small =
count
> + * values, particularly when stepping from count 1 to 2 or vice versa. H=
ence,
> + * these values are calculated using eight Newton steps, using the imple=
mentation
> + * below. Above 16, a single Newton step gives sufficient accuracy in ei=
ther
> + * direction, given the precision stored.

Please line wrap the comments at 80 chars.

> + * The magnitude of the error when stepping up to count 2 is such as to =
give
> + * the value that *should* have been produced at count 4.
> + */
> +
>  #define REC_INV_SQRT_CACHE (16)
> -static u32 cobalt_rec_inv_sqrt_cache[REC_INV_SQRT_CACHE] =3D {0};
> +static const u32 inv_sqrt_cache[REC_INV_SQRT_CACHE] =3D {
> +	        ~0,         ~0, 3037000500, 2479700525,
> +	2147483647, 1920767767, 1753413056, 1623345051,
> +	1518500250, 1431655765, 1358187914, 1294981364,
> +	1239850263, 1191209601, 1147878294, 1108955788

checkpatch asks to use tabs to indent the ~0, which seems fair
--=20
pw-bot: cr

