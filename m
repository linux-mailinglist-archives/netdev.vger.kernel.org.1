Return-Path: <netdev+bounces-128445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5909798A8
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 22:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E731A281DEE
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 20:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F601C6F66;
	Sun, 15 Sep 2024 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="q2fOYgcm"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C907D1CD31
	for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726431145; cv=none; b=OpO5YzmKPPVk6r5PgpLtDGsleVmChMCbCZzGWZttS3r4LLJ3+RhCfASjvgXZLLOmEn39l6ytVmVfFgW/4JPkmiq3ZRcp7e3jE38XDgF0QAwYuIe2JaTQqIEU7YX89Ik3+LMvCqB/7AYhh1GxJR11ZxngaTgenFFZwqREmBrc2HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726431145; c=relaxed/simple;
	bh=2L9l60ZJN5DDpI3I+X5pUpR6vyJ1OSF1B4yWImD2qIs=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date; b=pKbVPgUY0X9lOjYcgZOs9NpPtODGOMQrjXj01LH0RkKlvIDrQQOQoU/fS3rxpLI7e/Wro/wgltjENuxELl5yA6ILCx+bj7QqYLAIhR37LHXVeRZ4Q+n3rfAe+7/c/z6ufvKmMMtkvPGGAzzD2MaEM7NtH4zI1OD/q3khkJbn794=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=q2fOYgcm; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1726431127; x=1727035927; i=hfdevel@gmx.net;
	bh=fP2Gwd74iMjsLVnqkUBp8cu+BsoySHENyn14k873Za4=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=q2fOYgcmIIU5dbjkhv5htC1RQrlVS9fD0AZBzXRtUlG0qSlZnS9W1q/C4/dyNEiV
	 pYuHEBlMnpOyXmimsAmuPFnH+WvXyXNqFraSSZAKEBV4L6Pwb5FKMsnGYVyi8vo6M
	 mxcuRr/rfXU9h5iBvNZX70XK/hmiB8iM9vO58W08cnV96nwOQ3SbwjdGatXO5AwWD
	 gfSWNhUag8U+AsNyhqes6PLD1wWrHeSTYdpqZN74zKMa0KlgYMmxkLvtwEjOR4+49
	 MBTQEgYTwiQ7tP9vA6i1Ds0F4v1uzkTfYmUp7J3oiD2a7TRxwFgsG+AnUtof+/OhO
	 N+x9YuDYSncZGGmbKQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [77.33.175.99] ([77.33.175.99]) by web-mail.gmx.net
 (3c-app-gmx-bap07.server.lan [172.19.172.77]) (via HTTP); Sun, 15 Sep 2024
 22:12:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-dc1aa080-4a62-4b56-8030-1841ae570b2d-1726431127141@3c-app-gmx-bap07>
From: Hans-Frieder Vogt <hfdevel@gmx.net>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 7/7] net: tn40xx: add pci-id of the aqr105-based
 tehuti tn4010 cards
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Sep 2024 22:12:07 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:lXDm5HiudnHHMrPOnSjLHMi8BjJZKAx1IILsjYzdSWc2I8ydgsv9fLUOfWiLIOC+3Hgga
 WkVZshG4DJ7xTtkDMC823DXqrIv1xUjpPLz802kiOlj55lCEwVhhZ7QUrnBhg8xja0tNJtPAY+5t
 1j0cWE4fc7J9pAHR7e+67E3pycIa9b624I2VZWMeCA1GCh1qUMvEaxYxMmcC9zfCgMJIPm++gy8i
 uB40wHuIqwCYdVJooJW98DfQwBLHViCNvAW3r21zq1cbJ6faLL6bnvvz+9nsew21uguA9NJdxeyU
 oM=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:potrQmyEHqA=;5Fh1T5i8tmoWPhwIUtAlF5fxSrg
 ksTXKZuEjbRu2Wyzchw/+LED2NdgczVaN+Yvd4hDjGAiHxnrjzxXj4n9TXqTSqkx4uTktePq+
 qUQa+1VVaZm1fD3tzck94MWMoojE92Y8hcMKrndKVOzTZjpC5SCwq3hF3WFMEfHRGxhP8uDt0
 InlD//w98q+dSd0sIW6o/0PKK6H9mq1FSHFeptqTVQSWoc6I6VSOFa6rJlxWqVHlH3TEz5hEv
 1nbAPBUB8mQjeGBU1HNX/qqzUrKbr8IIAVFvEv4UBBqa/quMIw07mnfcJKmx+dtNioEB9PP4Y
 PDF4nQQ2TLswimcE/8DgMirKp+sz0ssUkUsCqH93p/ik3xUxU04gIDEcUq19FLgyqplQvVAc8
 v6i/8lcdnk13WWDgz7okB4N2HnDG8CZ1b6vYXl+1HumWTJOYIG4K9ILE7fg9kpa9x7/fCrT9O
 ZmsdNcKe3KHGvDlqdF8K2b6Ozi4xFnpE2kfQMKaTWDJ7cz2OFrVAE93+j4tI4MYxNXhn2qxlS
 4iSOFARixvuD5etgyz7WdzCiz641YqDmDd2O4t9QAqTUPtn4JWNdn/1g4KAc5mipxRHXVMz+7
 GzPG+nAoRI0Vd6SFlrLERfAn7FrpkK1OCRnPRt3e5sSsGVGA6wshh3Zl3w+q0qG2qeOlyhF7S
 JFeNEtbNuGqSS7lYxIqE6fNIN7C/tnf9jiHLjLlOiA==
Content-Transfer-Encoding: quoted-printable

Add the PCI-ID of the AQR105-based Tehuti TN4010 cards to allow loading of=
 the
tn40xx driver on these cards. Here, I chose the detailed definition with t=
he
subvendor ID similar to the QT2025 cards with the PCI-ID TEHUTI:0x4022,
because there is a card with an AQ2104 hiding amongst the AQR105 cards, an=
d
they all come with the same PCI-ID (TEHUTI:0x4025). And the AQ2104 is not =
yet
supported.

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
=2D--
 drivers/net/ethernet/tehuti/tn40.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/teh=
uti/tn40.c
index 9ccf5cd89663..59d979d82aad 100644
=2D-- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -1839,6 +1839,10 @@ static const struct pci_device_id tn40_id_table[] =
=3D {
 			 PCI_VENDOR_ID_ASUSTEK, 0x8709) },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4022,
 			 PCI_VENDOR_ID_EDIMAX, 0x8103) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4025,
+			 PCI_VENDOR_ID_TEHUTI, 0x3015) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4025,
+			 PCI_VENDOR_ID_EDIMAX, 0x8102) },
 	{ }
 };

=2D-
2.45.2


