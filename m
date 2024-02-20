Return-Path: <netdev+bounces-73338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4365985BF3C
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 15:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E222B20DDF
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 14:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE8A6BB38;
	Tue, 20 Feb 2024 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLGJ3WHx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B28F67E91
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441183; cv=none; b=kxay2nsjJVQ6h4Ss/tK7OM7JyzazVmtQqOcz4HcY2AoFr4ToA545WX3s6uQ6Zrj8LWOjte++yiSA/0UKWSLsDt+HMj2daI7CI1OtycUUZDE7xUjNQZSleSj4Rhjt9V4c65N1M++WIH9A2ME2dvfqRtqOULVH5pNWwqYi8++BjLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441183; c=relaxed/simple;
	bh=Vl8sRftmVCAC+0ik4/WZAg9S0fv7UNvmWT1ZfD0nRrE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DU8bV7yX2RmJfAkvSc2CAww2C8887mmEOST8Rmm951FbC5QHLxyYiyhxnUgtQN4onl7Oo7t8qCMBvHqHiB59aZyEOBeXGQf8JZsSd1f19qKNhwqOehH9mclRMS9tnUrg5RBWDt4OWDgW+81cucdtKk9DvOf+/8cM9+2HfoRTLnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLGJ3WHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B422EC433C7;
	Tue, 20 Feb 2024 14:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708441183;
	bh=Vl8sRftmVCAC+0ik4/WZAg9S0fv7UNvmWT1ZfD0nRrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lLGJ3WHxzpNDBV3ojyZQqGl0Uyrp2J6Ex5QBIC4TCvtwisrXtwPPWVxJZOZqGhWA4
	 nO+apD1StgdrGlgEvWOaneTzEihR4KcsN9jcylWGvJZWxp+ykwnDYtv0TLlv9wB7qi
	 eIG7/n2uGVjnjbYRyMT/+og7VbaihCts5VmUNHqY/LAnd2T8Y2OasI4hKiNQDdcUtc
	 2J2Xz7+nBQpwqKkkSSpMy5V4x7QFTEyhaqmWE6z49j+f5CaIUx18k77u/9LOUf0d/Y
	 pVXHIcFQm2yg4BiXhEnKhyOBUU8cl+e6/B89uAG0xAuN2GqWDpYtT5jxn87bwW5Fd0
	 lQ0FgawSVtf3w==
Date: Tue, 20 Feb 2024 06:59:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>, Christian Stewart
 <christian@aperture.us>
Cc: Marc Haber <mh+netdev@zugschlus.de>, Florian Fainelli
 <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 alexandre.torgue@foss.st.com, Jose Abreu <joabreu@synopsys.com>, Chen-Yu
 Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, Jisheng Zhang <jszhang@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: stmmac on Banana PI CPU stalls since Linux 6.6
Message-ID: <20240220065941.6efa100f@kernel.org>
In-Reply-To: <20240219204421.2f6019c1@meshulam.tesarici.cz>
References: <8efb36c2-a696-4de7-b3d7-2238d4ab5ebb@lunn.ch>
	<ZbKiBKj7Ljkx6NCO@torres.zugschlus.de>
	<229642a6-3bbb-4ec8-9240-7b8e3dc57345@lunn.ch>
	<99682651-06b4-4c69-b693-a0a06947b2ca@gmail.com>
	<20240126085122.21e0a8a2@meshulam.tesarici.cz>
	<ZbOPXAFfWujlk20q@torres.zugschlus.de>
	<20240126121028.2463aa68@meshulam.tesarici.cz>
	<ZcFBL6tCPMtmcc7c@torres.zugschlus.de>
	<0ba9eb60-9634-4378-8cbb-aea40b947142@gmail.com>
	<20240206092351.59b10030@meshulam.tesarici.cz>
	<ZcoL0MseDC69s2_P@torres.zugschlus.de>
	<CA+h8R2okfaYn-=toQPCkQUEZ6oLuwfjZ0ZZ-zRiN9A2fBFmzHQ@mail.gmail.com>
	<20240219204421.2f6019c1@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Feb 2024 20:44:21 +0100 Petr Tesa=C5=99=C3=ADk wrote:
> If you're running a 6.7 stable kernel, my patch has just been added to
> the 6.7-stable tree.
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/t=
ree/queue-6.7/net-stmmac-protect-updates-of-64-bit-statistics-counters.patch
>=20
> However, lockdep has reported an issue with it:
>=20
> https://lore.kernel.org/lkml/ea1567d9-ce66-45e6-8168-ac40a47d1821@roeck-u=
s.net/
>=20
> This new report has not yet been properly understood, but FWIW I've
> been running stable with my patch for over a month now.

Christian got an actual soft lockup, not just a lockdep warning, tho.
Christian, could you run the stack trace thru scripts/decode_stacktrace
and tell us which loop it's stuck on?

