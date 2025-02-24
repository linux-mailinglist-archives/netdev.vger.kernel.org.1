Return-Path: <netdev+bounces-168909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F25BA41737
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 09:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3A918953C3
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 08:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639F11EB5B;
	Mon, 24 Feb 2025 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2aAkUrF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF078C11
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740385399; cv=none; b=a5IL7JOls3UG9xPT0FcwyB2yTzeszj+p1wEyfqGWCgsYrpBSWuQu14swOYuo4+Ye/qUQaCinm3pWeL9P21wTwU5HN5Dx2VIaFbSwIWyoy9z7gveMvnLB0NIHrJkrsVXunzG35X4KpHIfZC0Yl7290sMgtZ6OTwAJqDRf+yHJ9zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740385399; c=relaxed/simple;
	bh=JKQLC08/PidfoBEYxZgzOtPrEzCNTJ6k8jhweXZMlQI=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=ISZukMIkIUnJLce7LbHhWD8cr+5myxF0+KfP4SXaCXdSWP/egfoaEnNFIQBHn6uIu8RXrtX3f8Sj+ywGxihG/3GLt5cTe35aX1udlk4nwXv1rApxn0CDW5TYGZGYDM/SrjpL6o6mi8uPZf4HiqKHSo4qkGYZu4wo2M1xEiNa94c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2aAkUrF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3B0C4CED6;
	Mon, 24 Feb 2025 08:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740385398;
	bh=JKQLC08/PidfoBEYxZgzOtPrEzCNTJ6k8jhweXZMlQI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=V2aAkUrFCCf1riqUveoWeGpPXuqsntYw4lYwHFdm1/MNLsGsAFY6jPXtETEgsg7lj
	 BOU5RZjh+3P7QTfoO1bSdjj+wZI1PYnTpNa0EkrCdrNh1yfrrDkL63UXwCzLfJmzQK
	 wXCY9iMeZ5gMaFcoa/wDWGe8MmP39AILRIRUxr1bgEREBuQDHtNfH3YHVSdGzkyFfI
	 FeN/eqEqgL7XAcza6ZFjbyxWSxnBRHp2XcOh8EGAG/ql+Ya2m7Q625ZaGDKJ4xcnjy
	 rY58COACv6Sp3Srke2EIz4gtLbNESPc0maI0n3BmYAxRxZQfep6gHuN0WGrJNLPwww
	 7CaMFxrhQa2AQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250221051223.576726-1-edumazet@google.com>
References: <20250221051223.576726-1-edumazet@google.com>
Subject: Re: [PATCH net-next] net-sysfs: restore behavior for not running devices
From: Antoine Tenart <atenart@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
To: David S . Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Date: Mon, 24 Feb 2025 09:23:14 +0100
Message-ID: <174038539478.5230.15576331549988523716@kwain>

Quoting Eric Dumazet (2025-02-21 06:12:23)
> modprobe dummy dumdummies=3D1
>=20
> Old behavior :
>=20
> $ cat /sys/class/net/dummy0/carrier
> cat: /sys/class/net/dummy0/carrier: Invalid argument
>=20
> After blamed commit, an empty string is reported.
>=20
> $ cat /sys/class/net/dummy0/carrier
> $
>=20
> In this commit, I restore the old behavior for carrier,
> speed and duplex attributes.
>=20
> Fixes: 79c61899b5ee ("net-sysfs: remove rtnl_trylock from device attribut=
es")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Antoine Tenart <atenart@kernel.org>

Thanks!

> ---
>  net/core/net-sysfs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 3fe2c521e5740436687f09c572754c5d071038f4..f61c1d829811941671981a395=
fc4cbc57cf48d23 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -313,12 +313,13 @@ static ssize_t carrier_show(struct device *dev,
>                             struct device_attribute *attr, char *buf)
>  {
>         struct net_device *netdev =3D to_net_dev(dev);
> -       int ret =3D -EINVAL;
> +       int ret;
> =20
>         ret =3D sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
>         if (ret)
>                 return ret;
> =20
> +       ret =3D -EINVAL;
>         if (netif_running(netdev)) {
>                 /* Synchronize carrier state with link watch,
>                  * see also rtnl_getlink().
> @@ -349,6 +350,7 @@ static ssize_t speed_show(struct device *dev,
>         if (ret)
>                 return ret;
> =20
> +       ret =3D -EINVAL;
>         if (netif_running(netdev)) {
>                 struct ethtool_link_ksettings cmd;
> =20
> @@ -376,6 +378,7 @@ static ssize_t duplex_show(struct device *dev,
>         if (ret)
>                 return ret;
> =20
> +       ret =3D -EINVAL;
>         if (netif_running(netdev)) {
>                 struct ethtool_link_ksettings cmd;
> =20
> --=20
> 2.48.1.601.g30ceb7b040-goog
>=20
>

