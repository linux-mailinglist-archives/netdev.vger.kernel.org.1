Return-Path: <netdev+bounces-98105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F728CF60C
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 22:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B88528107D
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 20:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376FA139D1A;
	Sun, 26 May 2024 20:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="dyb3hzOe"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F075139D12;
	Sun, 26 May 2024 20:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716757178; cv=none; b=WbkSu79AjjN8Xl4EYUICfI60VGxvyLnIyCNC+z0aAxr0zdi0BHJaQ3K1IY5VFJnUBCo0tJL6agkl6yGi8FEv3bTbePJ2pezyxN7cBOluusgNhyy6WxDbrgQMSqAr6EhpwDteoDuUoYr5OXL7iUH/hXc3L0Q1r/UUhg7dJq5Zpbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716757178; c=relaxed/simple;
	bh=0NV0NiIU/HwJhgiikDfkIFbTT3lXlGerI9bUAof39b8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aouNcIs6rCznaJ6ia2sEhEpiJ0yhnJFBMQdJ8gnkuYFiAxrorYQ5FJKkpiY7w523Yp9N1WTJ2/Fro7nvsUghz6gO45WKGGInBkluMtA2IGMiph4QqBzQClrp30o/KkGsR6OBVi6BgPTpJ55fKLUgdUsPChNk0NKbZ+5L7C2pcPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=dyb3hzOe; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=W9PU7BCcJXDnlcu7PSCv78S1l1Ocn4NX2Nr+M4p6vgA=; b=dyb3hzOecrWOsx12
	71czfo3kbJbegJc/DBKyknQ44vBrmhkU5VluU7whtYA3J9s9p6AN0NB3LHq3fqZTiD0sZwlXpY5k8
	7bLfI/TKpYOFzp+3ZnmBR1Iw80VxELwezsi+e7odRpEUV8WdBpRi8UrXtDjyrchx+23BsrjXcMpwX
	+ICj7RmK7xh3QSNcRoInEy5O0JSIAzIKpZmUbGrOF5oSw2+ZOwORFeX7/HHx7w4t9G0Nybm0UK+q0
	3xQ9L7VsmWzLpWQAA4EmbY8cAUpKs+bPSNNk9ruZZcFxxdGVb/izQdJhR5upAr3KWqoY2eZlOU9yt
	J5a6NTALd2+y+dAQIA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sBKxg-002bNb-12;
	Sun, 26 May 2024 20:59:24 +0000
From: linux@treblig.org
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	steve.glendinning@shawell.net
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] net: usb: remove unused structs 'usb_context'
Date: Sun, 26 May 2024 21:59:22 +0100
Message-ID: <20240526205922.176578-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Both lan78xx and smsc75xx have a 'usb_context'
struct which is unused, since their original commits.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/usb/lan78xx.c  | 5 -----
 drivers/net/usb/smsc75xx.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 5a2c38b63012..7a5cc49ebec6 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -380,11 +380,6 @@ struct skb_data {		/* skb->cb is one of these */
 	int num_of_packet;
 };
 
-struct usb_context {
-	struct usb_ctrlrequest req;
-	struct lan78xx_net *dev;
-};
-
 #define EVENT_TX_HALT			0
 #define EVENT_RX_HALT			1
 #define EVENT_RX_MEMORY			2
diff --git a/drivers/net/usb/smsc75xx.c b/drivers/net/usb/smsc75xx.c
index 0726e18bee6f..78c821349f48 100644
--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -61,11 +61,6 @@ struct smsc75xx_priv {
 	u8 suspend_flags;
 };
 
-struct usb_context {
-	struct usb_ctrlrequest req;
-	struct usbnet *dev;
-};
-
 static bool turbo_mode = true;
 module_param(turbo_mode, bool, 0644);
 MODULE_PARM_DESC(turbo_mode, "Enable multiple frames per Rx transaction");
-- 
2.45.1


