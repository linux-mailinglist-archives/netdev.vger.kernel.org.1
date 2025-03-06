Return-Path: <netdev+bounces-172339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EE8A54457
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38A597A5A95
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 08:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E084E1FBEA6;
	Thu,  6 Mar 2025 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVTVvhdZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E171DF964;
	Thu,  6 Mar 2025 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741248768; cv=none; b=eLkMHO2RGXEVFpitqjxw/GLCAKjDQ3cGG0ThTZkgoQKCpmFC9j3aICDVbS9JVP05vc0rUey0uYTpRDCnxoDX/MQRsolC5RlCTdS/ccAnH+RMkZj07Yfra644GqN/2RGYl9/Q+omIDAu6BDhITR0Dbz4gb+hj9jWLx+31j3Cm8wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741248768; c=relaxed/simple;
	bh=91HAbFKr7vBKjRHPh0vxDKg8p6ugHwwzn5VdM9GPrV8=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=RQfu5ptIh9ovosZAiVabAESU2JrpUUko7DcvT9U1e7VSesA0+ka/sKkdSIHOZePal5jthCF4jLq+p0f+HLXk9eJw3pQBpPtjx8gpPYYM7TkJ/prXAauiGYwYzi+PZ3FYPuW/BHtUiyEvzV4ZljO+DfyYs1g5yE5PVr7SqS9nbtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVTVvhdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81449C4CEE0;
	Thu,  6 Mar 2025 08:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741248768;
	bh=91HAbFKr7vBKjRHPh0vxDKg8p6ugHwwzn5VdM9GPrV8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=YVTVvhdZD38kw3XWzYl9bT4ixATz5AjarMGBIoTY8YrM7wEDY5vmkHwThyQ2Fa8CF
	 z4l/hAwV7fDGOU8rWHADcuNoC9rC8xwfzthkIHESwQs0tjlR+cXfNpYJuJmHzMO/q6
	 Ukkof8dlEA8MburZ+4uARDiwV9tgmhVBtbiZIO7PsIQpXfW8Q+2fZLUZwyXWxmLSMA
	 gRwX3iWEcR1hSIjp5i+42JwKXDeVALajUkmtrL+VEJwkG/NGaWZCNcuYo0Jjcyem8+
	 K4yDivhSwyeqUYUyA+9aDI6frqoWL+AC4qFo4Rq+gG3l4SVWdGDvySYUdwtB1kbS+0
	 g7HYswoOr/gUA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250305235307.14829-1-qasdev00@gmail.com>
References: <20250305235307.14829-1-qasdev00@gmail.com>
Subject: Re: [PATCH] net-sysfs: fix NULL pointer dereference
From: Antoine Tenart <atenart@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
To: Qasim Ijaz <qasdev00@gmail.com>, aleksander.lobakin@intel.com, davem@davemloft.net, edumazet@google.com, horms@kernel.org, jdamato@fastly.com, kuba@kernel.org, pabeni@redhat.com
Date: Thu, 06 Mar 2025 09:12:44 +0100
Message-ID: <174124876418.4824.8589202932419197412@kwain>

Quoting Qasim Ijaz (2025-03-06 00:53:07)
> Commit <79c61899b5ee> introduces a potential NULL pointer dereference=20
> in the sysfs_rtnl_lock() function when initialising kn:
>=20
>         kn =3D sysfs_break_active_protection(kobj, attr);
>        =20
> The commit overlooks the fact that sysfs_break_active_protection can=20
> return NULL if kernfs_find_and_get() fails to find and get the kernfs_nod=
e=20
> with the given name.=20

If it fails to get it, should we let sysfs_rtnl_lock continue is
execution?

> Later on the code calls sysfs_unbreak_active_protection(kn)=20
> unconditionally, which could lead to a NULL pointer dereference.
>=20
> Resolve this bug by introducing a NULL check before using kn
> in the sysfs_unbreak_active_protection() call.

Did you see this in practice? Can you describe what led to this?

Thanks!
Antoine

> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> Fixes: 79c61899b5ee ("net-sysfs: remove rtnl_trylock from device attribut=
es")
> ---
>  net/core/net-sysfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 8d9dc048a548..c5085588e536 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -117,7 +117,8 @@ static int sysfs_rtnl_lock(struct kobject *kobj, stru=
ct attribute *attr,
>          * the rtnl lock.
>          */
>  unbreak:
> -       sysfs_unbreak_active_protection(kn);
> +       if (kn)
> +               sysfs_unbreak_active_protection(kn);
>         dev_put(ndev);
> =20
>         return ret;
> --=20
> 2.39.5
>=20
>

