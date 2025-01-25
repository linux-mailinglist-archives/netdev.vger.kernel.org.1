Return-Path: <netdev+bounces-160909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AC0A1C291
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 10:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FDDE18888F8
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 09:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8021DB375;
	Sat, 25 Jan 2025 09:44:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.on2.de (mailgw.on2.de [213.61.158.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0051DC19F;
	Sat, 25 Jan 2025 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.61.158.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737798265; cv=none; b=kRVI2rfcnq4uVhMix4hA09U0sxqxy0Tt8yFa2fE4JFl+zxhAO/Q3HqC24O1zHM3GU10Mg8H7mV77fAeQ1/o6+jWy2SKX+iHwpN3X84MHGkR8nUWPcD0Ra6LxLoam3NEB6xhfib9X9RdM/jG4AsRFVunI6iHk0o8n7SaKZ6+jwns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737798265; c=relaxed/simple;
	bh=f6Wq5DgE2EHdnsEj/qySMpcnqtVb8dF9XrLKFf16imM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cQ6T44JQzw6sl/Q1QdKy9su9DKLUD9FfHnCAr+Iz4i4gWPl/+Nsei43j2Chwxt4TZp/Roe3v+JuAHOEvzDtpCGtUqZcJUnuEMiIEU4tft8UxGx1u4kngqUx2GHikpHo9SwPyG/Grfl4VTMbDS6TkGoSy/1sKBhJlUFsGwOih7ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=on2.de; spf=pass smtp.mailfrom=on2.de; arc=none smtp.client-ip=213.61.158.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=on2.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=on2.de
Received: from phoebe.cuh.hg.on2.de (phoebe.cuh.hg.on2.de [10.101.9.217])
	by mailgw.on2.de (Postfix) with ESMTP id E9A45FFDF0;
	Sat, 25 Jan 2025 10:38:08 +0100 (CET)
From: U Michel <ulv@on2.de>
To: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	U M <ulv@on2.de>
Subject: [PATCH 1/2] net: usb: qmi_wwan: fix init for Wistron NeWeb M18QW
Date: Sat, 25 Jan 2025 10:37:45 +0100
Message-Id: <20250125093745.1132009-1-ulv@on2.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: U M <ulv@on2.de>

fixed the initialization of the Wistron NeWeb M18QW. Successfully tested 
on a ZyXEL LTE3302 containing this modem.

Signed-off-by: U M <ulv@on2.de>
---
 drivers/net/usb/qmi_wwan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index e9208a8d2bfa..6c90685af771 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1227,7 +1227,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x1435, 0x0918, 3)},	/* Wistron NeWeb D16Q1 */
 	{QMI_FIXED_INTF(0x1435, 0x0918, 4)},	/* Wistron NeWeb D16Q1 */
 	{QMI_FIXED_INTF(0x1435, 0x0918, 5)},	/* Wistron NeWeb D16Q1 */
-	{QMI_FIXED_INTF(0x1435, 0x3185, 4)},	/* Wistron NeWeb M18Q5 */
+	{QMI_QUIRK_SET_DTR(0x1435, 0x3185, 4)},	/* Wistron NeWeb M18Q5 */
 	{QMI_FIXED_INTF(0x1435, 0xd111, 4)},	/* M9615A DM11-1 D51QC */
 	{QMI_FIXED_INTF(0x1435, 0xd181, 3)},	/* Wistron NeWeb D18Q1 */
 	{QMI_FIXED_INTF(0x1435, 0xd181, 4)},	/* Wistron NeWeb D18Q1 */
-- 
2.34.1


