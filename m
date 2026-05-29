Return-Path: <netdev+bounces-293085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHe+KH1sGWrGwQgAu9opvQ
	(envelope-from <netdev+bounces-293085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 12:37:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAB1600F16
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 12:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2422B311577C
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 10:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232873CC334;
	Fri, 29 May 2026 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEA5FYq5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A65A3CC7F8;
	Fri, 29 May 2026 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050709; cv=none; b=SpOtLsgEeRdOS3jWKp/MoYbU28t23YztvyexMvMaHScxpe9xe3x8YPJRi7negEMpl6mUyEkd5KCcaYvHwmIN3y9oVujAZaXU7KxRbG/ncAUC3RsgPvXN/uWAZf4aYn7nNcZfLlddp44uEmEKMxhYexLAKTAXzOU23uFVemDQtJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050709; c=relaxed/simple;
	bh=ugw3M+UGdOLpcJlOIYx2uYla5lSbmSNk0T33tbmMLJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rtyQli7X77OlG0oa6IB/p8Q0GXiCZDW3u0skVyow8M34PN/gRQsAb3Df+Ub7kX8woEuju8GXDI/V66p35pzDReEblBDQFL7n01EIYCms0QMiKyezRliCxIUeSxtcVinBK5TOig3QQ0PLXRnsoG7cBjrmCqBva2LkQ0jUqJCJo/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEA5FYq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5D7AC2BCFA;
	Fri, 29 May 2026 10:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780050708;
	bh=ugw3M+UGdOLpcJlOIYx2uYla5lSbmSNk0T33tbmMLJ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SEA5FYq5NHHo4Z4tcNPAVtIVTI2c3CrENmp61wA2G11LUFctGsc1aEVNxYa4pZgHD
	 C3TL3Sa4mk9UhTrnKL1trDOi2UvDSwCzjcEIsuwJ71zzq73Or4XFXolPwHSt75Qo5S
	 NWvpYaTu9nwm1legu7eDUm4u1AZLual54EQMkYPBIZ8qhrzAeERsWv0Y4/f6kHkW8p
	 IHkvsGWQBMIVlYL2rjkYW/v4V3nxFoZxwxxgNlxTu9RNSCqk0jzrCbS9oeg81YDm0n
	 WmP8QitiszqxQWoUmtncCoUr1o64bXboamVE2+QfEWP3080IYHqhf+swCpTUq2j9q6
	 RzXE7N1pwnRlA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF545CD6E4A;
	Fri, 29 May 2026 10:31:48 +0000 (UTC)
From: Jack Wu via B4 Relay <devnull+jackbb_wu.compal.com@kernel.org>
Date: Fri, 29 May 2026 18:31:50 +0800
Subject: [PATCH 11/11] net: wwan: t9xx: Add maintainers and documentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-t9xx_driver_v1-v1-11-bdbfe2c01e57@compal.com>
References: <20260529-t9xx_driver_v1-v1-0-bdbfe2c01e57@compal.com>
In-Reply-To: <20260529-t9xx_driver_v1-v1-0-bdbfe2c01e57@compal.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jack Wu <jackbb_wu@compal.com>, Wen-Zhi Huang <wen-zhi.huang@mediatek.com>, 
 Shi-Wei Yeh <shi-wei.yeh@mediatek.com>, 
 Minano Tseng <Minano.tseng@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780050705; l=3341;
 i=jackbb_wu@compal.com; s=20260526; h=from:subject:message-id;
 bh=gZ/Ej1LYBDfojFwAl08IAxUspPvBD4Ms/KxsQD2QGDY=;
 b=kngBuXKPlROTIHaDSxrYnkBefpd0CriRtU4rD4eRMfi6UiklYLZpHoraj7G+8IMsOfKLihMqZ
 mPsd53cbmeFCVJngDTeaMuDmGGGc8oKK6cEb/m/bez0EzQLL4rvhGgO
X-Developer-Key: i=jackbb_wu@compal.com; a=ed25519;
 pk=VH1prTWixNl8OEUPPSfII3p46MzJpQN8J3+ecE1tZXg=
X-Endpoint-Received: by B4 Relay for jackbb_wu@compal.com/20260526 with
 auth_id=793
X-Original-From: Jack Wu <jackbb_wu@compal.com>
Reply-To: jackbb_wu@compal.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293085-lists,netdev=lfdr.de,jackbb_wu.compal.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,compal.com,mediatek.com,collabora.com,lwn.net,linuxfoundation.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[jackbb_wu@compal.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[compal.com:replyto,compal.com:mid,compal.com:email,mediatek.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2AAB1600F16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jack Wu <jackbb_wu@compal.com>

Adds maintainers and documentation for MediaTek T9XX 5G WWAN modem
device driver.

Signed-off-by: Jack Wu <jackbb_wu@compal.com>
---
 .../networking/device_drivers/wwan/t9xx.rst        | 48 ++++++++++++++++++++++
 MAINTAINERS                                        | 10 +++++
 2 files changed, 58 insertions(+)

diff --git a/Documentation/networking/device_drivers/wwan/t9xx.rst b/Documentation/networking/device_drivers/wwan/t9xx.rst
new file mode 100644
index 000000000000..eaba82f18c1b
--- /dev/null
+++ b/Documentation/networking/device_drivers/wwan/t9xx.rst
@@ -0,0 +1,48 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+.. Copyright (c) 2025, MediaTek Inc.
+
+.. _t9xx_driver_doc:
+
+====================================================
+T9XX driver for MTK PCIe based T-series 5G Modem
+====================================================
+The T9XX driver is a WWAN PCIe host driver developed
+for data exchange over PCIe interface between Host platform and MediaTek's
+T-series 5G modem. The driver exposes control plane and data plane interfaces
+to applications. The control plane provides device node interfaces for control
+data transactions. The data plane provides network link interfaces for IP data
+transactions.
+
+Control channel userspace ABI
+=============================
+/dev/wwan0at0 character device
+------------------------------
+The driver exposes an AT port by implementing AT WWAN Port.
+The userspace end of the control channel pipe is a /dev/wwan0at0 character
+device. Application shall use this interface to issue AT commands.
+
+/dev/wwan0mbim0 character device
+--------------------------------
+The driver exposes an MBIM interface to the MBIM function by implementing
+MBIM WWAN Port. The userspace end of the control channel pipe is a
+/dev/wwan0mbim0 character device. Applications shall use this interface
+for MBIM protocol communication.
+
+Data channel userspace ABI
+==========================
+wwan0-X network device
+----------------------
+The T9XX driver exposes IP link interfaces "wwan0-X" of type "wwan" for IP
+traffic. Iproute network utility is used for creating "wwan0-X" network
+interfaces and for associating it with the MBIM IP session.
+
+The userspace management application is responsible for creating a new IP link
+prior to establishing an MBIM IP session where the SessionId is greater than 0.
+
+For example, creating a new IP link for an MBIM IP session with SessionId 1:
+
+  ip link add dev wwan0-1 parentdev wwan0 type wwan linkid 1
+
+The driver will automatically map the "wwan0-1" network device to MBIM IP
+session 1.
diff --git a/MAINTAINERS b/MAINTAINERS
index 461a3eed6129..3fab2b47f531 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16494,6 +16494,16 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/wwan/t7xx/
 
+MEDIATEK T9XX 5G WWAN MODEM DRIVER
+M:	Jack Wu <jackbb_wu@compal.com>
+R:	Wen-Zhi Huang <wen-zhi.huang@mediatek.com>
+R:	Shi-Wei Yeh <shi-wei.yeh@mediatek.com>
+R:	Minano Tseng <Minano.tseng@mediatek.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	Documentation/networking/device_drivers/wwan/t9xx.rst
+F:	drivers/net/wwan/t9xx/
+
 MEDIATEK USB3 DRD IP DRIVER
 M:	Chunfeng Yun <chunfeng.yun@mediatek.com>
 L:	linux-usb@vger.kernel.org

-- 
2.34.1



