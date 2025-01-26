Return-Path: <netdev+bounces-160980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5E7A1C7A7
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 13:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F19753A72E4
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 12:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50EB1531DB;
	Sun, 26 Jan 2025 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.de header.i=max.schulze@online.de header.b="irHIBIRL"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C12A59;
	Sun, 26 Jan 2025 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737893569; cv=none; b=GS79NlRXAjy1L7OrGk7UUyuUisVg9l101huGipAADYicOfol7D97nYS6O7ItE1hyaFBMb0JklgutBSQTdxV0Qy4MHfDYOjCM22h1EwhJqxltkzJJYbZviivTKri4QTHfBRkDhlKnxQl/SShBqfbfRCWCZI5mLl1eX5Ld5IzDGpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737893569; c=relaxed/simple;
	bh=n3Zuxo4+ofp6lzypUh52/XEAVt6q6ffux8GFlyD0BgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYWZDen2DZtxOw8O9nl9aIKQ+hVe3WTTzWlZHjg9UFB4LRuap/gjTcEhlrkbUgeeSLkU+Nr7CLx1I+nqscgMd5DRCEXCy+jqqgDnz1fjeW184vAj6uCqw+8uL8kVoALhD7fhV9cV2yoB1ZFA1HNyy2VjqHZMo1O3zxRexuHwZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de; spf=pass smtp.mailfrom=online.de; dkim=pass (2048-bit key) header.d=online.de header.i=max.schulze@online.de header.b=irHIBIRL; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1737893562; x=1738498362; i=max.schulze@online.de;
	bh=yOo6p5moP6tZOTasWbdStw1xoOjx+08m41VytHHVAs4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=irHIBIRL4Ot1LI5F1Bg50C0fShHppgmp+XJLPKLDXd03gxiWgucZ/WH+pRze6290
	 P6OQhAv7jcL863h2Cf3Rp8y6qeFOZ26Pbm6KvPuuH1hZ3L4/BvrRxu9N+/tZrhRNB
	 DrFYr22pWf1m0wHQf3BAkKDHX9Zsdt/o9QHFM+IrZ1PyjB+n+wuQcKKyzSbMCmBTD
	 qok84GnMWqXzJxSS/WTmVATUBQqHc9PotV8KVFG7A6YssyWf0MnBin79LWhXEO/sM
	 /oyfAjaThy+IfJgX5dGuzWAVuF/4VZ0f1++SdEJWflQnfLv9un6Ny+MeDwFv5788R
	 mGxBGhlAOtWU76AgJQ==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from ubu24desk.fritz.box ([84.160.55.49]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MLzeb-1tty1o3Sev-00VW2y; Sun, 26 Jan 2025 13:12:41 +0100
From: Max Schulze <max.schulze@online.de>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	andrew+netdev@lunn.ch
Cc: Max Schulze <max.schulze@online.de>,
	s.kreiensen@lyconsys.com,
	dhollis@davehollis.com
Subject: [PATCH v2] net: usb: asix: add FiberGecko DeviceID
Date: Sun, 26 Jan 2025 13:12:19 +0100
Message-ID: <20250126121227.14781-1-max.schulze@online.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250126114203.12940-1-max.schulze@online.de>
References: <20250126114203.12940-1-max.schulze@online.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hcR076eFuWWKyloIIB2hQQ1DxZDx17p5t/eEJdS30mFsY9XpVNB
 uheUdmcsRiArJzYmrkg9Q4rq+/Fo+MX9qTjPM//Jlo7WzfMJ6qw7puf7dLnt6Qk9fRP8WQr
 WARIxvMBol9GZ+wqt02QUTfdubgQdlHKhQqqwyhYi0vra0ueuIC9kgQg5WszPzhM05RgVmp
 rpYJn8YQOmLQYyYhU661w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IH3Z69r/3aU=;eB0CHAlbyx54cipdnGhK0hsY3n5
 MvcMG1ye0DUS5Nj+g1kFQ9oTvN7SngJ1s1iCyDalNdFw4QXYEtJtTjGmxx88uKbqyyqCjodoZ
 abXYb7ynBI9B5K/06KMWOJPmqSsmSdOrC1QIDusU61eKb3Gcr5y+zbkaPCDdaGnFNXTxMLaxf
 jjmzpmx5ZjFQJTdM6FRUbRR8pE8IHU9iUV2MRYGTBGWP9sKoEa6KSSanpPcvhjqb7IRMLAA79
 x1WD5+z532nGMSYHM0pxJ4jhQVW8GGApqRBCDUlvXQSuQZP5lrFZvo61d5ZEa22RT3f0Y5ABB
 CihSNZLhhE58nLPyuWAVsHSWRZocIPltfuOdiGlifT5aoHZEp4ecB+9Ud7ysQowde2RUXdP46
 EmLPmv/BPCbuHSCf7ueLt+F3nsTgGW3hb9gCY9wQCPBHLMlKi0s39CvAQyx00Vwu+CcqR3DP8
 HLk6EKkvrek6YL/0G78/WMeDOrZNHhCeikFHflmv3TcnigwtSrlrqPsAmCVma1HHTuQDj/Gs4
 io5sQbVASxwN4EStyR3D7B2YjvtCtVHhKYU7caBs5OdmNRcHKOi0UNQk99eKeXSVwkS8eywSH
 f0HcRpgwcSciQuj1wwq73IIAPQSyRGPvwj65I2iV8WjfRFDTTles4y4VRUXQ33RRuTlcpulOa
 wUu+y2HxQnFtP5XuBqOMRlkScFq9ZnL41AvUWJsHGFdnVBCfiunGmA2oXWoVSaqY8lvkYGObl
 PSQnrUNhUF5RLxveIG14ozbIt0QMI0q/mYeD68kWHTMiCCBBqYI5feAdRrWevSBMvd6nxoVW0
 mzTxoc2zAY9Yzabok27e14hVa+3wH1xtgRJC6y+zPM+NrqOlARjQCQyApfySBcdIQAxqev5bB
 v1wNRvatUfb9u0QYY/W0CFL/biJC/fmh1cgCTeaGoQog7VrxZ8aUBYVfpPX6F59GA1ccsFUiL
 SVWhgofvXZIwpV2SL1inEsgwxN6rbuupwPfu0UGuRXka7BjckWPJnlmdFCbZPX3vi6TGSEu4n
 BNKvGlHlt21+ff/gNRLHwZCzBIbvpt50ShLmlvyl9o821WGP/yfY5XihqdD9tmApOvumgy3Jf
 ckjsJH3WuAr/CNV487lFsMcCVkY0GQXZ5heIQMfcWkIMViXUgozaKjtlU236IiK9LqmENmIjk
 =

Signed-off-by: Max Schulze <max.schulze@online.de>
Tested-by: Max Schulze <max.schulze@online.de>
Suggested-by: David Hollis <dhollis@davehollis.com>
Reported-by: Sven Kreiensen <s.kreiensen@lyconsys.com>

=2D--

v2: change Spacing on Initializer, change Mailing List link
This patch had previously been suggested at
https://lore.kernel.org/netdev/1407426826-11335-2-git-send-email-dhollis@d=
avehollis.com/

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
+	.rx_fixup =3D asix_rx_fixup_common,
+	.tx_fixup =3D asix_tx_fixup,
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


