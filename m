Return-Path: <netdev+bounces-98289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516CA8D08A1
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 18:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 857B928B6D4
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 16:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91FA155CA3;
	Mon, 27 May 2024 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxLEH86g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC93A73473;
	Mon, 27 May 2024 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827461; cv=none; b=T/Uzq31ixP8j+x4V9h1x73LYNK8HIehnNAEFClY8xzZIG8hCbgcAmFlscsgQP8R8agpE6KA3Ljiz7KMeEXePIRRfToKY5KjaqqGl/R8MuBirwda0Z7bO31rBx2pVEcck5YXyrR3ijxq/16FjmWDyZAwOk6V4AJ/WIGstM9B9GRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827461; c=relaxed/simple;
	bh=wFzYxv0fxA4PHm+U+RUFutGQw4gMcFRHBJORjFR0yQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBPEOEuifJknY1+ikpGbShiG8K4+dr9u58qqnuKI7lbe63eaf5xK+1eEbnDAoMfQHShoIrYOziMADuy31NhWXpKWEY/JsCYYYlWSERlQ/o1LSOmUlR9Eys7Omwr1Fn2hrxd82jW9a6hk130RxYV2qOzo+eYFdQAT5pfk1YLhMKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxLEH86g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3878FC32781;
	Mon, 27 May 2024 16:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716827461;
	bh=wFzYxv0fxA4PHm+U+RUFutGQw4gMcFRHBJORjFR0yQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gxLEH86gxe7ZfAK5zKlZ/j7jD2Y0eX49YH9bXtJxDjJg5jP6FjDrRKuCrhqX6jHoP
	 9nKNjpFKFfOmGWTLoQNuwgxsIsk3PIaej0kvKEkhtZbpKOv/fmvoil6O1QhbRo8DYI
	 k1YIa3xSM0SMMvpYrkZXuaRNZVmoSkcqU0oeohtoNQPVP0DXYYWpz8DxvkjRJ5jSYk
	 r9pryL0aDrWu3OeaX8ObokDTvhHWbcsNDAnwVWVr8nq6rwaDRaQQjAr+tATZ5QToqG
	 P2UVj1e49JdccaR4g4zSZfqr4Lk+GDVudiRA72rKEv6EGw+S4VWeRQGY8+cLP/H/pq
	 n0kCv9ZIrLVVQ==
Date: Mon, 27 May 2024 09:30:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Danielle Ratson <danieller@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "sdf@google.com"
 <sdf@google.com>, "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
 "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
 "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
 "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
 "ahmed.zaki@intel.com" <ahmed.zaki@intel.com>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "shayagr@amazon.com" <shayagr@amazon.com>,
 "paul.greenwalt@intel.com" <paul.greenwalt@intel.com>, "jiri@resnulli.us"
 <jiri@resnulli.us>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, mlxsw <mlxsw@nvidia.com>, Petr Machata
 <petrm@nvidia.com>
Subject: Re: [PATCH net-next v5 04/10] ethtool: Add flashing transceiver
 modules' firmware notifications ability
Message-ID: <20240527093059.7e6e17ba@kernel.org>
In-Reply-To: <ZlSwbTwRF6KjPfJ5@shredder>
References: <20240424133023.4150624-5-danieller@nvidia.com>
	<20240429201130.5fad6d05@kernel.org>
	<DM6PR12MB45168DC7D9D9D7A5AE3E2B2DD81A2@DM6PR12MB4516.namprd12.prod.outlook.com>
	<20240430130302.235d612d@kernel.org>
	<ZjH1DCu0rJTL_RYz@shredder>
	<20240501073758.3da76601@kernel.org>
	<DM6PR12MB451687C3C54323473716621ED8EB2@DM6PR12MB4516.namprd12.prod.outlook.com>
	<20240522064519.3e980390@kernel.org>
	<DM6PR12MB451677DBA41EA8A622D3D446D8EB2@DM6PR12MB4516.namprd12.prod.outlook.com>
	<20240522072212.7a21c84b@kernel.org>
	<ZlSwbTwRF6KjPfJ5@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 May 2024 19:10:55 +0300 Ido Schimmel wrote:
> On Wed, May 22, 2024 at 07:22:12AM -0700, Jakub Kicinski wrote:
> > On Wed, 22 May 2024 13:56:11 +0000 Danielle Ratson wrote: =20
> > > The event should match the below:
> > > event =3D=3D NETLINK_URELEASE && notify->protocol =3D=3D NETLINK_GENE=
RIC
> > >=20
> > > Then iterate over the list to look for work that matches the dev and =
portid.
> > > The socket doesn=E2=80=99t close until the work is done in that case.=
  =20
> >=20
> > Okay, good, yes. I think you can use one of the callbacks I mentioned
> > below to achieve the same thing with less complexity than the notifier.=
 =20
>=20
> Danielle already has a POC with the notifier and it's not that
> complicated. I wasn't aware of the netlink notifier, but we found it
> when we tried to understand how other netlink families get notified
> about a socket being closed.
>=20
> Which advantages do you see in the sock_priv_destroy() approach? Are you
> against the notifier approach?

Notifier is not incorrect, but I worry it will result in more code,
and basically duplication of what genl_sk_priv* does. Perhaps you
managed to code it up very neatly - if so feel free to send the v6
and we can discuss further if needed?

> > > > Easiest way to "notice" the socket got closed would probably be to =
add some
> > > > info to genl_sk_priv_*(). ->sock_priv_destroy() will get called. Bu=
t you can also
> > > > get a close notification in the family   =20
> > > > ->unbind callback.   =20
>=20
> Isn't the unbind callback only for multicast (whereas we are using
> unicast)?

True, should work in practice, I think. But sock_priv is much better.

> > > Is there a scenario that we hit this event and won't intend to cancel=
 the work?  =20
> >=20
> > I think it's up to us. I don't see any legit reason for user space to
> > intentionally cancel the flashing. So the only option is that user space
> > is either buggy or has crashed, and the socket got closed before
> > flashing finished. Right? =20
>=20
> We don't think that closing the socket / killing the process mid
> flashing is a legitimate scenario. We looked into it in order to avoid
> sending unicast notifications to a socket that did not ask for them but
> gets them because it was bound to the port ID that was used by the old
> socket.
>=20
> I agree that we don't need to cancel the work and can simply have the
> work item stop sending notifications. User space will get an error if it
> tries to flash a module that is already being flashed in the background.
> WDYT?

SGTM!

