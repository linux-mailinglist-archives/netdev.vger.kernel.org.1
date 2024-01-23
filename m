Return-Path: <netdev+bounces-65074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAE2839244
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507001C211D7
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 15:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598485FBAA;
	Tue, 23 Jan 2024 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pwaller.net header.i=@pwaller.net header.b="Ft3jafNZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.foo.to (mail.foo.to [144.76.29.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02DE5FBA6
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.29.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022854; cv=none; b=dzuc/GcooeJJjgPX2ORvYQ/l+QqH/NrBt2D8DQVf3Ad7MocjnLONIcfPtH13Tdgv08jaQQCmAb/3uo4eEIuXRWbJgTVaMIaw3pMmB8f/LEwBwhTmK5CI/QVf8U/RRiEE54mOjGD0/ZGpgEpdOwxznwmmVyD/nZkwZpkcSs1qY3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022854; c=relaxed/simple;
	bh=v/S+6f3ILduvjD/9cm93TlQhDZ0D8uWEvZsyWzTwMwY=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=o8vmwAjIh6N2meICjmEO1w3L7pUUgYJBkvYOx5oLREbS6jju/XJ+AYWx6GUg4KXs2P829WVhnLuN/CNCL7rUkWIlamJLddDol0kNLzYioVBqnVSzRO3Pn2XbcsbIraPsJpc3nH3pHJTDwLVTlDo34DbyE7A/S/GHW8RWRaTrxLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwaller.net; spf=pass smtp.mailfrom=pwaller.net; dkim=pass (1024-bit key) header.d=pwaller.net header.i=@pwaller.net header.b=Ft3jafNZ; arc=none smtp.client-ip=144.76.29.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwaller.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pwaller.net
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pwaller.net; s=mail;
	t=1706022845; bh=v/S+6f3ILduvjD/9cm93TlQhDZ0D8uWEvZsyWzTwMwY=;
	h=From:Subject:Date:References:Cc:In-Reply-To:To:From;
	b=Ft3jafNZCcJlODA/2A7h8ubJPKaF8xoyBtPxDRbjoDhibjvWliBNqwijeDbT26DVR
	 4xIQHLhmwFwbmZ6HBsJxVOY8nofrCnmkG/bLcCTybC9ibPfBPdSY/v94PqD6D69VhE
	 /vuvR1asRvfinWBSLcMRy5pBCXiUcqbvSYE7Fe78=
Content-Transfer-Encoding: quoted-printable
From: Peter Waller <p@pwaller.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [EXT] Aquantia ethernet driver suspend/resume issues
Date: Tue, 23 Jan 2024 15:13:54 +0000
Message-Id: <E8060D65-F6C2-4AF5-AE3F-8ED8A30F95EF@pwaller.net>
References: <3b607ba8-ef5a-56b3-c907-694c0bde437c@marvell.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Netdev <netdev@vger.kernel.org>
In-Reply-To: <3b607ba8-ef5a-56b3-c907-694c0bde437c@marvell.com>
To: Igor Russkikh <irusskikh@marvell.com>
X-Mailer: iPhone Mail (21C66)

True, it is a warning rather than a hard crash, though shutdown hangs. Thank=
s for the workaround.

I can provide more dmesg when I=E2=80=99m back at my computer. Do you need t=
he whole thing or is there something in particular you want from it? =46rom m=
emory there isn=E2=80=99t much more in the way of messages that looked conne=
cted to me.

Sent from my mobile, please excuse brevity

> On 23 Jan 2024, at 14:59, Igor Russkikh <irusskikh@marvell.com> wrote:
>=20
> =EF=BB=BF
>> On 1/21/2024 10:05 PM, Peter Waller wrote:
>> I see a fix for double free [0] landed in 6.7; I've been running that
>> for a few days and have hit a resume from suspend issue twice. Stack
>> trace looks a little different (via __iommu_dma_map instead of
>> __iommu_dma_free), provided below.
>>=20
>> I've had resume issues with the atlantic driver since I've had this
>> hardware, but it went away for a while and seems as though it may have
>> come back with 6.7. (No crashes since logs begin on Dec 15 till Jan 12,
>> Upgrade to 6.7; crashes 20th and 21st, though my usage style of the
>> system has also varied, maybe crashes are associated with higher memory
>> usage?).
>=20
> Hi Peter,
>=20
> Are these hard crashes, or just warnings in dmesg you see?
> =46rom the log you provided it looks like a warning, meaning system is usa=
ble
> and driver can be restored with `if down/up` sequence.
>=20
> If so, then this is somewhat expected, because I'm still looking into
> how to refactor this suspend/resume cycle to reduce mem usage.
> Permanent workaround would be to reduce rx/tx ring sizes with something li=
ke
>=20
>    ethtool -G rx 1024 tx 1024
>=20
> If its a hard panic, we should look deeper into it.
>=20
>> Possibly unrelated but I also see fairly frequent (1 to ten times per
>> boot, since logs begin?) messages in my logs of the form "atlantic
>> 0000:0c:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=3D0x0014
>> address=3D0xffce8000 flags=3D0x0020]".
>=20
> Seems to be unrelated, but basically indicates HW or FW tries to access un=
mapped
> memory addresses, and iommu catches that.
> Full dmesg may help analyze this.
>=20
> Regards
>  Igor


