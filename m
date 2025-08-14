Return-Path: <netdev+bounces-213798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A50B26B8D
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 17:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEBF43ACD48
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 15:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4174D23A995;
	Thu, 14 Aug 2025 15:48:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from shell.v3.sk (mail.v3.sk [167.172.186.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D96224228;
	Thu, 14 Aug 2025 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.186.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186485; cv=none; b=hQGU5ZjJ6snNZCvp0F6emwZIDaXVVnPnVuAM2AtymlblmegrbVp9mrvK5vCneJviL7PiXD23EQS+1ZvwRGZ5aB1RXx86lfER4te73Pqjgw0nMwdEkIzNUKADaDSk00rO59OrP6e6UmspLUl+KYwcT5ndEl+GVYdLX7iXqfjotyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186485; c=relaxed/simple;
	bh=s8KNsp7BNC0sFhjKDy4BMu7Z+N1vCKe2TLy+YefCpXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JjigSZJolPZgkBo4EVV11llLxU0IRbz3ug9Qzh3Q1LRp8GK2BpyPfmpYiovicLtKAfYJpASec3YmvTHlmDFUZGnD6dk8IYOeslWyvgYgTEaVH8ERa0L2RfEJks9+r65+mu81OLF2cOG3Gst9nydboPwMCOi5fa26R+EUR/T6Jn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk; spf=pass smtp.mailfrom=v3.sk; arc=none smtp.client-ip=167.172.186.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v3.sk
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.v3.sk (Postfix) with ESMTP id 8D664E0CDA;
	Thu, 14 Aug 2025 15:33:11 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
	by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id GJ29SGzT_LgR; Thu, 14 Aug 2025 15:33:11 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.v3.sk (Postfix) with ESMTP id EF061E0D99;
	Thu, 14 Aug 2025 15:33:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
	by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4tUiINBx1hD4; Thu, 14 Aug 2025 15:33:10 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
	by zimbra.v3.sk (Postfix) with ESMTPSA id 52D60E0CDA;
	Thu, 14 Aug 2025 15:33:10 +0000 (UTC)
From: Lubomir Rintel <lkundrak@v3.sk>
To: Oliver Neukum <oliver@neukum.org>
Cc: Lubomir Rintel <lkundrak@v3.sk>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cdc_ncm: Flag Intel OEM version of Fibocom L850-GL as WWAN
Date: Thu, 14 Aug 2025 17:42:14 +0200
Message-ID: <20250814154214.250103-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This lets NetworkManager/ModemManager know that this is a modem and
needs to be connected first.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/usb/cdc_ncm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 34e82f1e37d9..95f95529ed95 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -2075,6 +2075,13 @@ static const struct usb_device_id cdc_devs[] =3D {
 	  .driver_info =3D (unsigned long)&wwan_info,
 	},
=20
+	/* Intel modem (label from OEM reads Fibocom L850-GL) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x8087, 0x095a,
+		USB_CLASS_COMM,
+		USB_CDC_SUBCLASS_NCM, USB_CDC_PROTO_NONE),
+	  .driver_info =3D (unsigned long)&wwan_info,
+	},
+
 	/* DisplayLink docking stations */
 	{ .match_flags =3D USB_DEVICE_ID_MATCH_INT_INFO
 		| USB_DEVICE_ID_MATCH_VENDOR,
--=20
2.50.1


