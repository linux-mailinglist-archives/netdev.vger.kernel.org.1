Return-Path: <netdev+bounces-246771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E15CF11B6
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 16:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44371300095A
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 15:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75C4126F0A;
	Sun,  4 Jan 2026 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqU0IPz/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DDE3A1E70
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767540663; cv=none; b=ENsrShxT3NnQNCuzBFZu/iX37S6OEDt3Md8a4IK8ZoK6JJarsorjs7Sl1tP0KSM7E3ljBM1mVaMULsfJn2hzIr8jtFXC7QlHmjdhMGx+W39poqXdbkdqFbKSMHhNDpTVeB/nBE352KjPoIw7uE7zBN/UY7FXcM5B72d6CystJa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767540663; c=relaxed/simple;
	bh=slVGIa+8aT7GN0lzc0qY9gza/fZppSF2guqvZQAxHAY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JyhfsiHnpCl6uOAvTTONazxBjHNhduRG/HbSDFLeKziwTqiKNP17Ucj4yRdrYKr43Dsk1v9pPXoMmSL6IL/CoO9VF3xuNQlFqL9Qo/1Ozd30fJqqmMafscB961fV+w4HskxmTZPby2c1vtFcYtVrC/MddPrZUlH2C5TclP9hoIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqU0IPz/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB88BC4CEF7;
	Sun,  4 Jan 2026 15:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767540663;
	bh=slVGIa+8aT7GN0lzc0qY9gza/fZppSF2guqvZQAxHAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kqU0IPz/MRYiII2fTF6B64Tv/IkJOM27AMpMEp1pDJ+O0nM2yQScT8MRMefayPEVq
	 nnmiUgwcx6M+Asqvh9mYzHsxPpF7/6zX8BqV+Gs0i8NP2TaHziwCU4+RAlkdX30jlg
	 Fo6T0X9f6DcAKsuBcQH94z51KfCJoT4YXDUDeoQwOUWTfnM976b3fuYJDObR5Rl19E
	 WcVMIM2T08eIinrqaHeWK25WF0jddsY5nj7eiNx1sESZkP7jj3xutuXNl9qpaC/Zaz
	 zwPzbJ2cUctcDMvjG4faxoUcaCvm2WUiRANh8zUqexmU4o5Ugena5GElbIw93se/fc
	 CejsHTW0ME8eg==
Date: Sun, 4 Jan 2026 07:31:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "edumazet@google.com" <edumazet@google.com>, "alsi@bang-olufsen.dk"
 <alsi@bang-olufsen.dk>, "olteanv@gmail.com" <olteanv@gmail.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH v3] net: dsa: realtek: rtl8365mb: remove ifOutDiscards
 from rx_packets
Message-ID: <20260104073101.2b3a0baa@kernel.org>
In-Reply-To: <d2339247-19a6-4614-a91c-86d79c2b4d00@yahoo.com>
References: <2114795695.8721689.1763312184906.ref@mail.yahoo.com>
	<2114795695.8721689.1763312184906@mail.yahoo.com>
	<234545199.8734622.1763313511799@mail.yahoo.com>
	<d2339247-19a6-4614-a91c-86d79c2b4d00@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 3 Jan 2026 20:17:49 +0100 Mieczyslaw Nalewaj wrote:
> rx_packets should report the number of frames successfully received:
> unicast + multicast + broadcast. Subtracting ifOutDiscards (a TX
> counter) is incorrect and can undercount RX packets. RX drops are
> already reported via rx_dropped (e.g. etherStatsDropEvents), so
> there is no need to adjust rx_packets.
>=20
> This patch removes the subtraction of ifOutDiscards from rx_packets
> in rtl8365mb_stats_update().
>=20
> Fixes: 4af2950c50c8634ed2865cf81e607034f78b84aa

12 characters of the hash in the fixes tag is enough, and don't wrap it.

>  =C2=A0("net: dsa: realtek-smi: add rtl8365mb subdriver for RTL8365MB-VC")
>=20
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> ---
>  =C2=A0drivers/net/dsa/realtek/rtl8365mb.c | 3 +--
>  =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>=20
> --- a/drivers/net/dsa/realtek/rtl8365mb.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb.c
> @@ -2180,8 +2180,7 @@ static void rtl8365mb_stats_update(struc
>=20
>  =C2=A0 =C2=A0 =C2=A0stats->rx_packets =3D cnt[RTL8365MB_MIB_ifInUcastPkt=
s] +
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cnt[RTL836=
5MB_MIB_ifInMulticastPkts] +
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cnt[RTL8365MB_MI=
B_ifInBroadcastPkts] -
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cnt[RTL8365MB_MI=
B_ifOutDiscards];
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cnt[RTL8365MB_MI=
B_ifInBroadcastPkts];
>=20
>  =C2=A0 =C2=A0 =C2=A0stats->tx_packets =3D cnt[RTL8365MB_MIB_ifOutUcastPk=
ts] +
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cnt[RTL836=
5MB_MIB_ifOutMulticastPkts] +

Patch seems to make sense but it's mangled by your email client.
Please try resending with git send-email. Also please have a read of:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
--=20
pw-bot: cr

