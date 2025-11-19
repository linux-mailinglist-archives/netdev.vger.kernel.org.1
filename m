Return-Path: <netdev+bounces-239881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ACEC6D83C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 99ADB28B3E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244022ED873;
	Wed, 19 Nov 2025 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="HgJKgAcd"
X-Original-To: netdev@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF3C25A359
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 08:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542176; cv=none; b=A9V9UtaRC51G3xvOQf8CGtdCq7B2wNwo2WHVG8fVrtdkf6BGBzIHQ7u54cel8Hl6nZngPaHUgkqeACPXwe9ZNWmGdOywXFHpFXqyLPQJY4QU8Np9lrAPS7YO5J/36eWRjIRYYr870/AeHET95AR4B4x61vxSiEGMF9mZ+bun4Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542176; c=relaxed/simple;
	bh=ndKhJLYUe0wawN+sr4iey36tYZnP9ODBF3Vi8ITyQkQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RwrYB2v4QxpZw1fbEMEmWKvV9vVLRDWvcRL89npFYrcn0GAUZOcPGo4H0VqjEblkhzF6fTa6myVFKkUy2HwmHJ1440cnhuhfwqFOW7+vVvxcoIwYJEaNEtv7VAaWqM6oVBf77ZWoSf2NNc/kpMqyp0NOJRA4eXR3tEVEMMu6WzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=HgJKgAcd; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To
	:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+RBxsi6WE4vUrp92bPLo40XuJcHjG32mltzhBtdhj14=; b=HgJKgAcdnSq29MDkV/Z60vqWxn
	jwkjZAaIrtiR/O42NCDa3XdtkSni76wzCQTWs0oEBy+YCfG9DYRoaEP01jpxfF44v5BK9y1Jy6N4P
	48dMgZ07GsQUT+3APmuF/HqdHRWUNgD5zLO7cP1JYFtc1d+qEiq48r85/owvbA2avPDRmX4BUOXSI
	f/ycG0QsKWDC3v4tCXuoxXz4Y7FHCXo8WIeHkNzF8pY2zux3H8x8qLkH9tHNQkD1KUWbTLosHnKRq
	YV7bO/V9eMh6YNzagPaU4YAHwuYzQxZR758szDoD1E4XXymM5lEjvE7ZTIuzwqMQiFir3Cx0Xp4PT
	hOcBKfdQ==;
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH V2] net: 3com/3c515 fix build error
From: =?utf-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
In-Reply-To: <20251118180533.4aae2524@kernel.org>
Date: Wed, 19 Nov 2025 09:49:29 +0100
Cc: netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D36550A7-DB30-4262-8C19-F7C2EAD511D2@exactco.de>
References: <20251118.121556.485782007294139002.rene@exactco.de>
 <20251118180533.4aae2524@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> On 19. Nov 2025, at 03:05, Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> On Tue, 18 Nov 2025 12:15:56 +0100 (CET) Ren=C3=A9 Rebe wrote:
>> 3c515 stopped building for me some time ago, fix:
>>=20
>> drivers/net/ethernet/3com/3c515.o: error: objtool: cleanup_module(): =
Magic init_module() function name is deprecated, use module_init(fn) =
instead
>> make[6]: *** [scripts/Makefile.build:203: =
drivers/net/ethernet/3com/3c515.o] Error 255
>=20
> Looks like this has already been fixed by 1471a274b76d1469a

Great, I=E2=80=99m usually basing on Linus=E2=80=99 tree.

Thanks!
	Ren=C3=A9

--=20
https://exactco.de - https://t2linux.com - https://patreon.com/renerebe=

