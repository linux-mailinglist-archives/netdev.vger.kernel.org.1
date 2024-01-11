Return-Path: <netdev+bounces-63134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D834082B537
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 20:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57812B22372
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 19:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96D455C1E;
	Thu, 11 Jan 2024 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1aP0hMS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCA155764
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 19:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE7BC433F1;
	Thu, 11 Jan 2024 19:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705001593;
	bh=TPky/PcSZlkF3gbLO8l4vK4XgpHWuAs6ZHhMyDw/XKw=;
	h=From:To:Cc:Subject:Date:From;
	b=A1aP0hMSyTAQTZpKjE6EFtrndVmjxsRogknS+mgDXUdlnetJ0LCnfxiqn+Z70KCip
	 CHvcOS+CJ8+lRQjbDIEPFm4RTZs5WoC65+PzG8fobZ1Lq6AcK60LmJqEnKvOv8Yn9x
	 PKZQey2nO23fPe0EZrsG2xaoePCi7xy/VaLxD2gED+TbnOXRJ0+85/L+74ej6er8Fz
	 +kup0MEPNNNJJU9Wq13vJaQBdMKgF+coDM8D8dndm+id+vsna1URsofkhu0AUsxDb2
	 Ah3q+9l5ECqi/KcviuV8FV9dvaDRhsa/RpX5YjkR+MYtA4XjzvxIskBvs403aWX0+L
	 bCPJJ2CtG/zAw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com
Subject: [PATCH net] net: fill in MODULE_DESCRIPTION()s for wx_lib
Date: Thu, 11 Jan 2024 11:33:11 -0800
Message-ID: <20240111193311.4152859-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add a description to Wangxun's common code lib.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jiawenwu@trustnetic.com
CC: mengyuanlou@net-swift.com
CC: duanqiangwen@net-swift.com
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 23355cc408fd..8706223a6e5a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -2769,4 +2769,5 @@ void wx_set_ring(struct wx *wx, u32 new_tx_count,
 }
 EXPORT_SYMBOL(wx_set_ring);
 
+MODULE_DESCRIPTION("Common library for Wangxun(R) Ethernet drivers.");
 MODULE_LICENSE("GPL");
-- 
2.43.0


