Return-Path: <netdev+bounces-160964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6FBA1C78E
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 12:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035FB1887F8E
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 11:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAF013BC3F;
	Sun, 26 Jan 2025 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.de header.i=max.schulze@online.de header.b="Zam4M+LM"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016C111CAF;
	Sun, 26 Jan 2025 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737891752; cv=none; b=XQWFouumV3mrO8B4SXkdS4p8XvsH/Vf80THkyirLNCMjit8AMI4/pqEZRGrcJ5ShZhOHXVQojomZcjM+wRiZuJ03BI6YH9ShHisdYvu7tycmcAe7L4YAjW2zsHMGtDhTQZQCFZjO1ttNra0+BFifT2jFv21ZEOXYMj5A6GZrAtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737891752; c=relaxed/simple;
	bh=uMXzi9aCGWH0enUR8WKQCjj51OSUapoaASbQIgj2wwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQr+G4/yKlIXziZKJ0+02LyFQ0SRt31cx3tgcS0p2zIt6Y/eOBFMn90HvkoRhsuiRAowZ2Qpp9D09TO+vG+qa7bcoibZb42DjqMS6tbfYZS0hBher6PW6YpsR/drh0itEJ9FzHbKhce+HVkMxInDv6YbTA/nmIACun4+ySEZHM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de; spf=pass smtp.mailfrom=online.de; dkim=pass (2048-bit key) header.d=online.de header.i=max.schulze@online.de header.b=Zam4M+LM; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1737891737; x=1738496537; i=max.schulze@online.de;
	bh=KqZn8qPv3kkLeFBRLV17MFn7Gb1309Ecx2bdj3fttYg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Zam4M+LMx3pCdjG+DF2Dn9oHpqXgfSqnOkNKrDn3IM0SdO5dumFkOv89wPshgJ3i
	 saJVoRWlokh1q0cIHqLIA/exfeQanbM4b8nvtHh7Ifm4uXkFFTjoYbzbmgLmK6ias
	 edwsEE6Abn0pqZOwcrO2lHF9OcCvOVbPr7pDlEdOiOwzyxlGxPYqVTsTHaP0ph753
	 hz9y+RcncN/JElmfXoVAZb3FbEFPSiQnRYKR8eYNp6S/hw0TGAfNbGqC/ydJEG1WR
	 IIZ/Twj34E+BLqhs9h2uWshq+ej4g15t9MU6F+FBcC0ZzuMMwwaRIJaWx3lNhCVd5
	 d9v5hYVlpnZ2sfcCaA==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from ubu24desk.fritz.box ([84.160.55.49]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MGQaz-1thnG82tMT-00Fcc5; Sun, 26 Jan 2025 12:42:17 +0100
From: Max Schulze <max.schulze@online.de>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	andrew+netdev@lunn.ch
Cc: Max Schulze <max.schulze@online.de>,
	s.kreiensen@lyconsys.com,
	dhollis@davehollis.com
Subject: [PATCH] net: usb: asix: add FiberGecko DeviceID
Date: Sun, 26 Jan 2025 12:42:01 +0100
Message-ID: <20250126114203.12940-1-max.schulze@online.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1407426826-11335-2-git-send-email-dhollis@davehollis.com>
References: <1407426826-11335-2-git-send-email-dhollis@davehollis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hF7fH4yR1pLCZRY0mtF0U6lPspjEChkdBHlLGPAT7hhp+uOEH/b
 Aq4AlCuCFnMkd4+rW02X/IY9nPL9bkAWIErBFoh+hsLkOrEc4oEHOdD/PahUo+Dc4ULG9tz
 46kZ7I+g+VHyj0eUN7uVlPJzeekjvEC2buiLiqCv15B4AiWYJ0qA42vwIjTN9R3DBufmpg0
 9oA3PvpZExcJporiPRKnw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:z4//WFpEIpM=;FGn/myH4vTslDCetC5GP82BIHxI
 8D9GjePXsYBXFQDEqZG25JF89gcaqJcuwk9woRmzeLcnxr9+2BErlS+TKIkFe/fgDQiqout30
 P1cRYMLVt5SBPowCsIZ2PYS3xAdIBMeMyzUcEWkfkfy6yBqVRZZDYGh7I3favfnbSwZsOzuCl
 KA2FYmK3iqa34OkyyO2Y/tolWVZZzycs3YWL9syyNLkKGs9/5fSmmTDh8BjCzFI+mTT0QDfwy
 MxJrGeDdW2GnOqO8VNKJZmdH3WX12x8RyubI9mLfTjYi9L8is0D+9vP1LaNMlF6ghc6Qx76LS
 TEUj6+WQolfT38MgSZEgtgKnixvvfjNnH0qh/k9xws0pgD3BmifZcdNrVZGnzHIYEhhBwDqQx
 4r432FUDCias2zveawtUlo6i2V8Bn/wjk1f5BvaEX4QivWuIIlKMRYkBSLs6BZSj/8RNPtBQn
 EUink8gfsgQM97oMcXIiTx4IjHXUGlvUpgFKRqB1pKFSJU7totRfeg6KDgVutfuYnuGGxKzX9
 Fyaq0fLK7C2S4XxYsbAuT2+rpKhdWnOiR9BTGQ27bciQ5c0r1QF6r698ZcPY018XsqBuWCI60
 aY2t6hICuT0q5lb5aSoDfWU0OP1eJ4+OB2GHbFrlhYI3ZFJaaiOk2eMz+Ah+joLxF57cz/Fmq
 MxuupfqwgZIeSp71IQkceQatJ63FAUXE9AGHfzGPKQbd7yBV83SDT3vMltAwgmNxYx+9xYhB2
 UwYG7MY9oUBjQsCsn8x7piYyQetxbSlyW5NEek8hpBMJ70kaSe8P1sg4aUn6c6HBF8EnDsgmQ
 D4Yir2ObV2BIrD/MzeaK0iNG2luk+5i6BHyd/eAQI19WVgWQlUxM/qZjcDpZy03lLtv+AgKxH
 oMUbWgbpz0kuyQpSOS3DCkPCNmFUvw/RkH8pydputv/8lPcmhN8Lt4xp4pop2Bpk/h9D3TL6W
 9P2n1ZdXhhD4oMAbzdwGFQrgiRNlorjfTIW7OYKrR4/c+A0EoA5PjTX0a0rzvpqNLDlLcF7RO
 6qw/BpEG8LmkzfbmUik730nVk8QtXOg6OFssI1zATG8GOPY6kylbGi2HkrfLMf7OEfLewnP9K
 KHQfCEsxgz6fwLUX1LWmByIifLPEKlnRBWOA3jDyH1GCkzpqyiYw==

Signed-off-by: Max Schulze <max.schulze@online.de>
Tested-by: Max Schulze <max.schulze@online.de>
Suggested-by: David Hollis <dhollis@davehollis.com>
Reported-by: Sven Kreiensen <s.kreiensen@lyconsys.com>
Link: https://marc.info/?l=3Dlinux-netdev&m=3D140742722321328
=2D--

This patch had previously been suggested at "Link:".

However, I found that the flag quirk is not necessary and I suspect
it has never worked (because it references ".flag" whereas the
identifying value is in ".data")

I have compiled this and tested successfully with two devices.
As it now only adds the USB Id it generates no extra maintenance
burden that's why I suggest it for inclusion.

 drivers/net/usb/asix_devices.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices=
.c
index 57d6e5abc30e..ef7aae8f3594 100644
=2D-- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -1421,6 +1421,19 @@ static const struct driver_info hg20f9_info =3D {
 	.data =3D FLAG_EEPROM_MAC,
 };

+static const struct driver_info lyconsys_fibergecko100_info =3D {
+	.description =3D "LyconSys FiberGecko 100 USB 2.0 to SFP Adapter",
+	.bind =3D ax88178_bind,
+	.status =3D asix_status,
+	.link_reset =3D ax88178_link_reset,
+	.reset =3D ax88178_link_reset,
+	.flags =3D FLAG_ETHER | FLAG_FRAMING_AX | FLAG_LINK_INTR |
+		 FLAG_MULTI_PACKET,
+	.rx_fixup =3D	asix_rx_fixup_common,
+	.tx_fixup =3D	asix_tx_fixup,
+	.data =3D 0x20061201,
+};
+
 static const struct usb_device_id	products [] =3D {
 {
 	// Linksys USB200M
@@ -1578,6 +1591,10 @@ static const struct usb_device_id	products [] =3D {
 	// Linux Automation GmbH USB 10Base-T1L
 	USB_DEVICE(0x33f7, 0x0004),
 	.driver_info =3D (unsigned long) &lxausb_t1l_info,
+}, {
+	/* LyconSys FiberGecko 100 */
+	USB_DEVICE(0x1d2a, 0x0801),
+	.driver_info =3D (unsigned long) &lyconsys_fibergecko100_info,
 },
 	{ },		// END
 };
=2D-
2.43.0


