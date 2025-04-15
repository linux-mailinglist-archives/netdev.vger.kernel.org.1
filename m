Return-Path: <netdev+bounces-182810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A82ABA89F51
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444BC3B5859
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841D82951DD;
	Tue, 15 Apr 2025 13:23:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D135336D;
	Tue, 15 Apr 2025 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744723404; cv=none; b=oqFXeXMK7hquQGiEjJZC6MC/L10Hh3NFMF3XO1EvENUsiFTqj7SLJBFfVGc48kdNyliK73YCgzfmRWSzZiQ/1hEeG/F/PiOQNvIbR1mwbQR+oBu64xRXdVOrh9Ek6vIVdNC5WL8q8vAPwbk0HACem/gasBaJE1dX+cA2MDTnW64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744723404; c=relaxed/simple;
	bh=tGhV1+X+h+9xmi8FQ1Hg9Ap2MDTPanUK8M9CHefKtMw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nQPmlz/YsCRTIcxVkhXYYU0vQ5hj+LH43C6T7yNdWCZaIIaEWYkz0lH7B9DMb8L/ZR5mJzriS+LXtp7lzXllnpVqVOfISjw+975601XqQ+/foFwC4/qJtpos9w01d9rMGd34dIfpQjpj8N3f0d7nYMgVNvKxtMRFST4XgNV6LkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=none smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: zesmtpsz4t1744723266td17108ae
X-QQ-Originating-IP: gJ58oqPD7nr+sDT0pA7ndfED1kWY/XOLCuHIBbtbgNw=
Received: from localhost.localdomain ( [175.9.43.233])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Apr 2025 21:21:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6911282797750824797
From: zhoubowen <zhoubowen@kylinsec.com.cn>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] amd-xgbe: Add device IDs for Hygon 10Gb ethernet controller
Date: Tue, 15 Apr 2025 21:20:06 +0800
Message-Id: <20250415132006.11268-1-zhoubowen@kylinsec.com.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OQWRW3+3Aar3mhOYzJoo0Ygmexa+2vZZlgm4qFeLztENtD1zbzQ4zWY5
	K9I99Br6gaC+0UJS6120/jgIAWFwqSU2kSXgdZAdde+1i//DDEYsozy+7z0dHHXM4UFj+D9
	I8ozPyfKlXjGUIsvQ4OkIx6kaaZAq+FVo03ec6wcxhAHYXQsvrftHdVFLCKsBrn0rzxEeUm
	UIPxg0qcznoZw95O4Y5KdyGWeFCtnoSND08ZIGY1wuztRxWHERHXtQK8F0w43oliH+UsmBr
	OCH62+jSenCNKYY7E2LvrP3wUFJ1eLGI98s0VCr5NBE/DxCQOAdnNQ8w6l4SlPTEq4NPQ5x
	luXUTIRsjUKTKcd17lDhkeeXDFpQ3MzhJl7N4iMEZLCteAVClFKjdpv/3SBKoGecDPXnD9p
	jAtUYksTPzvO3JGfBhUHT5PM8H9/EWotR+v3V0dv+1imXAdwazRO9N9gGtAEjsR6Cj3K4es
	eOv7VcQqQqfIJmlOQlecrDm5VktzM4eo7pVpu8+LVGBpLjGBWweNZrK1UnzsUAyW78vNQBx
	2Gy6NZ7j9B8DCf9mEDWWqsxiIbTFJe/9TB0U7rsEVV1z9tNmtNdomkrHfPnTBEDhEXdcwj1
	zwXUUnc6uFTV65rUVHhvmhvMWBXdW2YG3oLsiEKStqR3+TJKqKnxuJIWHCemzzPCButsTL3
	nsC3jgcFMSzm4pUbEb24vEhR9r+sPmRPSA4RtSIDMbw/xpzq+woajJcMIzOr6UPfTo5B/94
	B+FUbGGf58wuy4yiSBIvFgjuH6qxRXzunUvPnfJZ7Nus3s6QrWUI9EbvqKNEwnNeHLbo7rD
	k7F3PLPxExSoBntSlc3zUml5Em2zoNkLa+3v9jv7kwitfqKjmwdRgOlFRqyt3jjiNSf5d5B
	iuS7BLJ1Po+/asBQ26OA4WWvRoooM3HmVjrNThIewHZo5DUcry5zIPZfA+WKMLvv0RH5i0C
	IwTXw5MYl7Wa0mxRfxm79qB31xjDyRo8e3+gtnutkK2t4pUQkLqNmtk9FxOB6SVTUPKioN/
	KTOicIeJ+H2Jx/z3ZID0mUn+6XAxGiEOYx0XGmNRfCvxfBO4/m
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Add device IDs for Hygon 10Gb Ethernet controller.

Signed-off-by: zhoubowen <zhoubowen@kylinsec.com.cn>
---
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index f409d7bd1f1e..206ff2e9e3cb 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -510,6 +510,10 @@ static const struct pci_device_id xgbe_pci_table[] = {
 	  .driver_data = (kernel_ulong_t)&xgbe_v2a },
 	{ PCI_VDEVICE(AMD, 0x1459),
 	  .driver_data = (kernel_ulong_t)&xgbe_v2b },
+	{ PCI_VDEVICE(HYGON, 0x1458),
+	  .driver_data = (kernel_ulong_t)&xgbe_v2a },
+	{ PCI_VDEVICE(HYGON, 0x1459),
+	  .driver_data = (kernel_ulong_t)&xgbe_v2b },
 	/* Last entry must be zero */
 	{ 0, }
 };
-- 
2.27.0


