Return-Path: <netdev+bounces-119266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB56955040
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 19:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36FDD2881C7
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 17:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FBC1BE227;
	Fri, 16 Aug 2024 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpdtIuLW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C0E1AD9F9
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830688; cv=none; b=UayOTubdiZ4VOO0i8UiNxFZ3U/+xmlIXlVwcBvsQQND0h8cbLod/TyBDXOYmmy39t4fUcnTBqWv1ZQqhBIQR9n5Z5CIpcsLRBCQvHoW6QADX2wAN9UQdjqmvk3ZU1EaZ0b6XLTpqvBKlFvWjfK5o1MDI8XahhcaZQaztVfIqwIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830688; c=relaxed/simple;
	bh=BQ+OR88UGjPnrwLrkIuV1d7JHzm6nJEgeooJRaKTk6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KEUbxN0KdOqdZ7rOZ/5YmuQE/Z4Rq5iGxaRiq50PFX7JxoM490J4oPSqblVxLAZqvCe8TtUgCMySLkCX2yc9zyJPkeffN0ifu8/I9WTXo4sVWtQX6swzeUQcST1RzqChoxaZ2AIgiA+9kKjOiJV8B4xZnboPAt/OJg7dJwRVApo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpdtIuLW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9B7C32782;
	Fri, 16 Aug 2024 17:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723830687;
	bh=BQ+OR88UGjPnrwLrkIuV1d7JHzm6nJEgeooJRaKTk6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gpdtIuLWo2XeX1ZYDf//7OmweAJy1+3gOEc+qyvSkdbHwE2kUcnHJGcU1PKiDbbb5
	 21baLq1Cp/2PXPqXIrwg6eW4JKZv8obtDx5DhJKSMJrij1uYELOf9fXhOs5uYjiAz6
	 l/TNGkd5aSM2fh2m1k1G3Q3Xw8cLQ3tccEJzyWMPIUnzA31eOulUD29zslefJW5QeV
	 opZWbukhlHWh8VC0ILWV/pliz6xXRzUCsDVcODSzjRadGWnitRbP1fdDhQn6QyJbYk
	 hWsJy2Eog54aAvNIOhs0T7Ih1pnPGO4wyuKBKp8VhSHj7d84cjoDUSqYtj2Hg3P28I
	 VaI4ppXM0oD6A==
Date: Fri, 16 Aug 2024 10:51:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?= <maze@google.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Linux Network Development
 Mailing List <netdev@vger.kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, "Kory Maincent (Dent Project)"
 <kory.maincent@bootlin.com>, Ahmed Zaki <ahmed.zaki@intel.com>, Edward Cree
 <ecree.xilinx@gmail.com>, Yuyang Huang <yuyanghuang@google.com>, Lorenzo
 Colitti <lorenzo@google.com>
Subject: Re: [PATCH net-next] ethtool: add tunable api to disable various
 firmware offloads
Message-ID: <20240816105126.080acb51@kernel.org>
In-Reply-To: <CANP3RGdMEYrbHWMEb-gTUgNRwje66FTihccVgrg6s4z0c0a+Kw@mail.gmail.com>
References: <20240813223325.3522113-1-maze@google.com>
	<20240814173248.685681d7@kernel.org>
	<CANP3RGdMEYrbHWMEb-gTUgNRwje66FTihccVgrg6s4z0c0a+Kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Aug 2024 17:49:42 -0700 Maciej =C5=BBenczykowski wrote:
> I am of course in a very hard position here, as I don't own any
> drivers/firmware - AFAIK even Pixel's wifi/cell drivers aren't Google
> owned/maintained, but rather Broadcom/Synaptics/Qualcomm/Mediatek/etc
> as appropriate...
>=20
> I do know there is a need for an api of this sort (not necessarily
> exactly this patch though), and if we merge something (sane :-) ) into
> Linux, we can then backport that (either to LTS or just to ACK), and
> then we (as in Google) can require implementations (for new
> hardware/drivers) in future versions of Android...

That's why I'm suggesting the LLDP in the Intel Ethernet driver.
Others may disagree but for me it's close enough to merge a "enable
L2 protocol agent" sort of an API. We don't need to have upstream users
for each proto. Bigger cause of sadness is that the API IIUC is a part
of a deprecation path, IOW once APF comes, it will become dead weight.
Luckily it's not a lot of code.

> Presumably that would result in implementations in many drivers,
> though not necessarily any in-tree ones (I have no idea what the
> current state of in-vs-out-of-tree drivers is wrt. Android wifi/cell
> hardware)
>=20
> This is very much a chicken-and-egg problem though.  As long as there
> is no 'public' API, the default approach is for per-vendor or even
> per-chip / per-driver custom apis, hidden behind Android HALs.  For
> example we have such an Android HAL api for disabling ND offload on at
> least one of our devices.  Of course the HAL itself is backed by
> calling into the driver - just over some driver specific netlink...

I wonder if there's anything we can share between APF style offloads
and Jamal's P4 work, if it materializes.

