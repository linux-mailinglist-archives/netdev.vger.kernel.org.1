Return-Path: <netdev+bounces-176864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A65A6C9C9
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 11:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D311B664D3
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 10:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6362206BB;
	Sat, 22 Mar 2025 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sokCtSAy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6246D1FBCB8;
	Sat, 22 Mar 2025 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742640369; cv=none; b=EEFCDTRU76NbRkytUY4idTwx+iUp76Z8eyeMMgHlnF5us1qmUWGjrRIy01zVL1NJ0iLwB/zhIu9CQ8kbXykbMfBfiwh529PuSU8rWIcpk7n19eeb9e2I/8WCcs52tg8PryqIyral4teIJI+QbGUhb639w8ldCUS4+Cu/qcNyEhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742640369; c=relaxed/simple;
	bh=WvsfIMCgFBv4pVF1dShM5iom4fQh6xwiwk9nAbHBOws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WdwTBfNu+hvJ/OJDP6U3qxqyZmQmUG+bJNwPYIhFpwFpwmEd13VxOnzoI2o64FphO5ooiz3UDvJ3GpW9zg8Hc58GKV/zoXQI2n9ufiXwioyyXjySL9pBOzN0zfjBy9diKd/qJ0EftNGGuT+ZN3vbd+CD5RUTreEJ7Wpki6N89WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sokCtSAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7597C4CEE9;
	Sat, 22 Mar 2025 10:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742640368;
	bh=WvsfIMCgFBv4pVF1dShM5iom4fQh6xwiwk9nAbHBOws=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sokCtSAyV0oNiaHrxRyRH98M5aC+ElLAfurhvpG6jAfln73dsqObCOg1TP+YJHRzL
	 Hx+gWDQQJiTIO3nlOIQuP7zGuB0Cz4qp+BRIQWtlJFEaDkGfbslMluSQ4/uUkQ5xha
	 y54L9eqmV82wNRGz5YFgQL7dPQy6XNtnRioDgvSkIJ0Fx7i0PyM+LAX8BoBeTLYBAT
	 p9H85tQ9JjxWp4AMXbYGwYZhTbjkSR/sQuH3dvycjPnctSxNGyF4xH3R4IixlE8vSS
	 2/xvGvGN+stn1geuXWfsbLYdz9o5fWyG0lnQjtQJ11vwNPjsz2xgHxhleaQxrb6mGN
	 2IocdklnVhlhw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6EBC35FFC;
	Sat, 22 Mar 2025 10:46:08 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Sat, 22 Mar 2025 11:45:58 +0100
Subject: [PATCH net-next v7 7/7] net: tn40xx: add pci-id of the
 aqr105-based Tehuti TN4010 cards
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-tn9510-v3a-v7-7-672a9a3d8628@gmx.net>
References: <20250322-tn9510-v3a-v7-0-672a9a3d8628@gmx.net>
In-Reply-To: <20250322-tn9510-v3a-v7-0-672a9a3d8628@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans-Frieder Vogt <hfdevel@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742640367; l=1270;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=PWNMuGZpqBv+vmVUoj6REOMISB+bfZAmxP1coZ2ZFQg=;
 b=WsBBv9kNz/emyE5iuDsO6UJOghCNbGwmqJVuOZp841cWIRa7zZxzy6WrMmt3e/iine+x06AW8
 ihuJiJ3RUROCV3Z9hDqKXud8C4+3vVOEnREANMaRAApB/55tLe67Uf6
X-Developer-Key: i=hfdevel@gmx.net; a=ed25519;
 pk=s3DJ3DFe6BJDRAcnd7VGvvwPXcLgV8mrfbpt8B9coRc=
X-Endpoint-Received: by B4 Relay for hfdevel@gmx.net/20240915 with
 auth_id=209
X-Original-From: Hans-Frieder Vogt <hfdevel@gmx.net>
Reply-To: hfdevel@gmx.net

From: Hans-Frieder Vogt <hfdevel@gmx.net>

Add the PCI-ID of the AQR105-based Tehuti TN4010 cards to allow loading
of the tn40xx driver on these cards. Here, I chose the detailed definition
with the subvendor ID similar to the QT2025 cards with the PCI-ID
TEHUTI:0x4022, because there is a card with an AQ2104 hiding amongst the
AQR105 cards, and they all come with the same PCI-ID (TEHUTI:0x4025). But
the AQ2104 is currently not supported.

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
---
 drivers/net/ethernet/tehuti/tn40.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
index a4dd04fc6d89e7f7efd77145a5dd883884b30c4b..558b791a97edddc86923f121f5fd75d9f910ac79 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -1835,6 +1835,10 @@ static const struct pci_device_id tn40_id_table[] = {
 			 PCI_VENDOR_ID_ASUSTEK, 0x8709) },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4022,
 			 PCI_VENDOR_ID_EDIMAX, 0x8103) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, PCI_DEVICE_ID_TEHUTI_TN9510,
+			 PCI_VENDOR_ID_TEHUTI, 0x3015) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, PCI_DEVICE_ID_TEHUTI_TN9510,
+			 PCI_VENDOR_ID_EDIMAX, 0x8102) },
 	{ }
 };
 

-- 
2.47.2



