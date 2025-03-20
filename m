Return-Path: <netdev+bounces-176436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5656BA6A4D1
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 12:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FA0D9816C4
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 11:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C8021D00E;
	Thu, 20 Mar 2025 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InC7p+BQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37AB21CC5C;
	Thu, 20 Mar 2025 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469565; cv=none; b=XgTWfeXgrsWwWenJPh2dIfJxxgUJsGPCSnPX7ALt/wlJIhYsI5az2bJGhTr2uyUe9MuBjMLVak/YvaERcw3YS0nRBws8NohcG/Sz6amw2+2b+heKqTxwpwK9EhlH6NBY+Y4J6yufW7aySFCizAs+rc2ZVK+brVHXCZwjiOuzpVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469565; c=relaxed/simple;
	bh=6PezswnH6Ezxp8GX6d3CdH+Rb46Wqcad1GKr2MVjZIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JiTgPDEt3GRIbKxCkBQNzEryccZM7jGr3wBlDQR4hRDq8NVhiIDpBTGyN/C42i0fT6w3pUAVddWgocqZIpNy4zfNwmxBg6JnHd/LvASQucipF1HvbLYPqqM2XbxdHwM9y2bucd9c0HeAEY365VGf+G2+sJA/yJ+NbUnvhRyg79Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InC7p+BQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB66C4CEEE;
	Thu, 20 Mar 2025 11:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742469565;
	bh=6PezswnH6Ezxp8GX6d3CdH+Rb46Wqcad1GKr2MVjZIM=;
	h=From:Date:Subject:To:Cc:From;
	b=InC7p+BQJvb/USbErKP9BUJh5E3LENw1oBVv4I5bnuMnqVytuCGvJIWGGreYqQqlv
	 rM0767Xy8xBHeg+f75F+4PjcMcqWTHF0aVal7iX10dap7bY0TbY2UjeqnWNUGGMqIE
	 Ibrcl0vLjUrOXwI7xnFdkpcprghgGQ7A9yHQzZQZkqq4uZjsTYAXlAKuLJ+lzFLABI
	 0qLWu4g2yscLcqQ695KonawwBi4g1b2dH/ipiak0Sxlhlykrfw/fOs18NzC5aeJqwB
	 0L7PN4H10WaLEVc09vsOYeWCljQfDts4v6yMgZCtfpiFh+8WmL/i0rWab+T2krFp1f
	 YU7ZK0d+iF1Jg==
From: Simon Horman <horms@kernel.org>
Date: Thu, 20 Mar 2025 11:19:20 +0000
Subject: [PATCH] tty: caif: removed unused function debugfs_tx()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-caif-debugfs-tx-v1-1-be5654770088@kernel.org>
X-B4-Tracking: v=1; b=H4sIALf522cC/x3MTQqAIBBA4avIrBswRfq5SrQwHWs2FVohSHdPW
 n6L9wokikwJRlEg0sOJj72ibQS4ze4rIftqUFIZqZVEZzmgp+VeQ8IrozVDION70+keanVGCpz
 /4zS/7wfy1dMMYQAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-serial@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
X-Mailer: b4 0.14.0

Remove debugfs_tx() which was added when the caif driver was added in
commit 9b27105b4a44 ("net-caif-driver: add CAIF serial driver (ldisc)")
but it has never been used.

Flagged by LLVM 19.1.7 W=1 builds.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/caif/caif_serial.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index ed3a589def6b..90ea3dc0fb10 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -126,15 +126,6 @@ static inline void debugfs_rx(struct ser_device *ser, const u8 *data, int size)
 	ser->rx_blob.data = ser->rx_data;
 	ser->rx_blob.size = size;
 }
-
-static inline void debugfs_tx(struct ser_device *ser, const u8 *data, int size)
-{
-	if (size > sizeof(ser->tx_data))
-		size = sizeof(ser->tx_data);
-	memcpy(ser->tx_data, data, size);
-	ser->tx_blob.data = ser->tx_data;
-	ser->tx_blob.size = size;
-}
 #else
 static inline void debugfs_init(struct ser_device *ser, struct tty_struct *tty)
 {
@@ -151,11 +142,6 @@ static inline void update_tty_status(struct ser_device *ser)
 static inline void debugfs_rx(struct ser_device *ser, const u8 *data, int size)
 {
 }
-
-static inline void debugfs_tx(struct ser_device *ser, const u8 *data, int size)
-{
-}
-
 #endif
 
 static void ldisc_receive(struct tty_struct *tty, const u8 *data,


