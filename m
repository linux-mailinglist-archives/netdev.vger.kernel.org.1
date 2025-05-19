Return-Path: <netdev+bounces-191533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6343ABBD89
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 14:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97FC4189767F
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0968B20012B;
	Mon, 19 May 2025 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="JAHkrCh1"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C111714B3;
	Mon, 19 May 2025 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747657016; cv=none; b=e41IusY5QYYEagZ54SedyRn9+gvcjuzpf0xgenL2/i/NX4Fac/24Rhyg/vBJ5ZfT0kOj7hZSEElwddyXOMzvmx+v3goUf9FmmVFCHJT7tgKsOWwvzisQbczilY+ajLUJcKCr+C80+XmT0L5IVVrOMB5nsKPDDj/TqvIdFnwNVzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747657016; c=relaxed/simple;
	bh=DOkKNp4l7AMqnBeiOcr0K3qq8IbXhMNaPz7rbisR8PA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c2jI1fYe+U7DjT+3LZA2L8I6lG1EoIRj4EwVkUoGFZMSTDpKDCcJUeOyn9yPWAw+vKh/XhOXE1JcITIaLlBxKEmF9NiPbCXzCCAigwfJ8S2SCDl3mBvVLVqejtlaJExOGxBRNjIXVIuPybyIEWEDZNCTR5WlccVd3COjqg5UtIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=JAHkrCh1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54JCGH6b8937724, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747656977; bh=DOkKNp4l7AMqnBeiOcr0K3qq8IbXhMNaPz7rbisR8PA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=JAHkrCh1B7t7YOkle2atNXaWGpNSth9zm/SRBlzZuGMwYJgusYPPyz86RJe+rligI
	 Oyj58Wn2hoQF7J8G52tkLR1mnOZan0mAjyj0lSoZA+BRo4mHaXsN9hUssQsPg3jBMy
	 mXYFoiq5JF9a/1nRjzKtgIBIr+h3J2KBYUzAXmPTeaH+SXtcpGO4ZAoKTFSzUPodua
	 FTWb+iFyD/SLXet4XzhfB0T36veNAt3i0cpCY7b9BIlY4Y0nQhIx+NxAJ91q4kGwQm
	 zbDCud5AIBz1YekqughpEHaZvrh8d2Lo5Nri5RcLvBKRCt86xxjxgGQOsmPKU/sJ5v
	 NWIfr6xOzk1ag==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54JCGH6b8937724
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 20:16:17 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 May 2025 20:16:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 19 May 2025 20:16:11 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 19 May 2025 20:16:11 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "horms@kernel.org"
	<horms@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu
	<larry.chiu@realtek.com>, Joe Damato <jdamato@fastly.com>
Subject: RE: [PATCH net-next v2] rtase: Use min() instead of min_t()
Thread-Topic: [PATCH net-next v2] rtase: Use min() instead of min_t()
Thread-Index: AQHbtawdSIC/HJstr0OxTEOUNg41/rPaAlkA
Date: Mon, 19 May 2025 12:16:11 +0000
Message-ID: <bb78d791abe34d9cbac30e75e7bec373@realtek.com>
References: <20250425063429.29742-1-justinlai0215@realtek.com>
In-Reply-To: <20250425063429.29742-1-justinlai0215@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> -----Original Message-----
> From: Justin Lai <justinlai0215@realtek.com>
> Sent: Friday, April 25, 2025 2:34 PM
> To: kuba@kernel.org
> Cc: davem@davemloft.net; edumazet@google.com; pabeni@redhat.com;
> andrew+netdev@lunn.ch; linux-kernel@vger.kernel.org;
> netdev@vger.kernel.org; horms@kernel.org; Ping-Ke Shih
> <pkshih@realtek.com>; Larry Chiu <larry.chiu@realtek.com>; Justin Lai
> <justinlai0215@realtek.com>; Joe Damato <jdamato@fastly.com>
> Subject: [PATCH net-next v2] rtase: Use min() instead of min_t()
>=20
> Use min() instead of min_t() to avoid the possibility of casting to the
> wrong type.
>=20
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> Reviewed-by: Joe Damato <jdamato@fastly.com>
> ---
> v1 -> v2:
> - Remove the Fixes tag.
> ---
>  drivers/net/ethernet/realtek/rtase/rtase_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> index 6251548d50ff..8c902eaeb5ec 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -1983,7 +1983,7 @@ static u16 rtase_calc_time_mitigation(u32 time_us)
>  	u8 msb, time_count, time_unit;
>  	u16 int_miti;
>=20
> -	time_us =3D min_t(int, time_us, RTASE_MITI_MAX_TIME);
> +	time_us =3D min(time_us, RTASE_MITI_MAX_TIME);
>=20
>  	msb =3D fls(time_us);
>  	if (msb >=3D RTASE_MITI_COUNT_BIT_NUM) {
> @@ -2005,7 +2005,7 @@ static u16 rtase_calc_packet_num_mitigation(u16
> pkt_num)
>  	u8 msb, pkt_num_count, pkt_num_unit;
>  	u16 int_miti;
>=20
> -	pkt_num =3D min_t(int, pkt_num, RTASE_MITI_MAX_PKT_NUM);
> +	pkt_num =3D min(pkt_num, RTASE_MITI_MAX_PKT_NUM);
>=20
>  	if (pkt_num > 60) {
>  		pkt_num_unit =3D RTASE_MITI_MAX_PKT_NUM_IDX;
> --
> 2.34.1

Hi reviewers,

I apologize for the interruption, I would like to ask why this patch is
rejected on patchwork.

Justin

