Return-Path: <netdev+bounces-57514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D777E813428
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 16:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81A1B1F221FD
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 15:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB60D5C90E;
	Thu, 14 Dec 2023 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="q5IIbZNo"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FFB124;
	Thu, 14 Dec 2023 07:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1702566604; x=1703171404; i=wahrenst@gmx.net;
	bh=uSq+XXTYVv4fmdVVfmAK8ycHoy9TNiBddJGsI4Vmj4E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=q5IIbZNoReGHhX3QtGKTP7mbI6eKpMFNU5GlgWXJjvUo7hT8oO0yqk609ZA51gEi
	 cyo/3RezAsJUs1rNrDgvY3p+OPX5dLfT94am0JBj9jSmUYc7sTmGYSnX6sxWjqmux
	 BaYm3YTTfy2/nws32t9osC8jq2PAUsytksG2Wo9URCK6I7sGYuLZzCOAoXG/UKi7a
	 8Dsnoe/Ba6gH0XAQXo4BirkwcyGwds8L8LIuH35P9L05HJOtfWBNr1y5QRMwjBddl
	 keDvNpo5TuADpRWwAc/GBklseH6msBPN6aL0gX1CYUy2skvO/M7zXicVbrXg8fGwz
	 pOfH8N1NaNKU+zEKWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVeI8-1qobV226I0-00Rbdc; Thu, 14
 Dec 2023 16:10:04 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 10/12 net-next] qca_spi: Adjust log of SPI_REG_RDBUF_BYTE_AVA
Date: Thu, 14 Dec 2023 16:09:42 +0100
Message-Id: <20231214150944.55808-11-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214150944.55808-1-wahrenst@gmx.net>
References: <20231214150944.55808-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c+A7nN0FN1C8wTnC6p1F3+SEI0HZ3i1L9DXP1LITWrDaII/Uo+V
 G+nOmQfpAZvKBGgCrTMFuj8nApP7BmU0UqlRFrHz0JkYeCxkD0k402DImQacM6XQUtcPtb4
 RA8nOZC40gSFB8lPvs37S/9mKgYICAR6gjB+v9kI2Od2trWgtRokqr1i+1wciwwsBNbzQgX
 TZ4yVh8v2hKpIBLbAE6Fw==
UI-OutboundReport: notjunk:1;M01:P0:6ebsGJKkiuk=;ViXKrX+bsBlqEPVocz4iy5439Qo
 HRfVCDhaeL5Hjd2bsXWzvw2PAEvddfI/ynzxB9DKbpvKrwuR7A54iuSgLbgen3kstOTIuvyJl
 /bcFRYfuKedGJG2GNId0tjCTTVV1KL2KyTQqBJ1Y5xRt14ufigeAhQ6RRlwHcwDlLKUrUUFaA
 9/UwakDgSFK7sbjI4/Ope8JVuJhcbfppbaidHzPo2ULS4EFMby8oRMTwBevRXsunRmucTk4TS
 pjVG/yCGFp1ynWJ7EuyojnxfJmHyNbavpXsY189QqUwgrEPyVtoF+ZEwwkSItBjirD6zXrtAr
 mQ30N36KmNkNq3lXmV8ct933e47+QGdbKyEW7+jhK9NNhFIx6IGJ5UOdaMKRsODnkH32P+BF2
 sriB5qKbk7MZQTJneXzK2hj6OkCwKV0j+YMHxbrJlSEd2Gtcc18NJBqBPuTWY/s7JsqoVNHvz
 cX0kWi5wyedNOjAHYwZB2zA0PUzOw6X0Z9+UHQwBA9swLI8mHXwHZDvsMUDMJvfZw8nkfvmje
 49aU2eWtaWXJ4Y/URKgS7LqJK37c02pEncI/VOnFQDJngCbb6gNnQ85acqlf2SNDZoW4dRCBQ
 llEF36AETiaK84ANXrQFUcyx9czx/cd4J7tb9j6ORN3ZuZWxI3WGX7sK1OzxdwvMeRlajvMQX
 DJJbsQNCNZt101p/3p3TeKAWr8BKsLcKeooxTf+cN1OSmRzSuCBCZJvyL7SRj25J9/Jh1XY4D
 GKWLlCOAkL/4AvANVLAS0KAL0yUr8UOwvabGcTlllitpos9wF9O7RHrG8JdNdG04l/DzekubD
 acA6Pm9G75yZZFrjys3LIib/4xbKtm5WlgfGv8lCoKOtkVe3JEZqPKM2g3oO59RaVKdeFT8XV
 0ennFbzCY9wrF3Rem/Ru3EX+BK6r7ibPsplR73FT+rky/P2SXNsO096fyQHz8NXA/oc3q9yCT
 1ki3Kw==

All known SPI registers of the QCA700x are 16 bit long. So adjust
the formater width accordingly.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index a9188b19d1fb..fc05959ba825 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -359,7 +359,7 @@ qcaspi_receive(struct qcaspi *qca)
 	/* Read the packet size. */
 	qcaspi_read_register(qca, SPI_REG_RDBUF_BYTE_AVA, &available);

-	netdev_dbg(net_dev, "qcaspi_receive: SPI_REG_RDBUF_BYTE_AVA: Value: %08x=
\n",
+	netdev_dbg(net_dev, "qcaspi_receive: SPI_REG_RDBUF_BYTE_AVA: Value: %04x=
\n",
 		   available);

 	if (available > QCASPI_HW_BUF_LEN + QCASPI_HW_PKT_LEN) {
=2D-
2.34.1


