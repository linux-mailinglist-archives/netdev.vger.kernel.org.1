Return-Path: <netdev+bounces-136475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1009A1E68
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B1DB25EA7
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221851D9320;
	Thu, 17 Oct 2024 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="LPz78v5t"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FBD1D95A3;
	Thu, 17 Oct 2024 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729157407; cv=none; b=CeZsfwPGqzfVfL2QENEDBHKAvJB+r5hd1SqKGysSumqi6aO7M5PkbTwhTj0tqBx1uSMco01lu29agLtNe4wH407PkzWn0mjWrnO6sOn0W9QTn+FJ+CqstpuCg/PMYWHjSo8xVtxtRQspw1qU5BgGWNTSQVaRcJdRX/eCTUra/Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729157407; c=relaxed/simple;
	bh=CiKI26DyWW7yOyJWlbrQZ+gnYmg3VknZUz7iulNtGac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RCJXEtx0drZcq+wOY/RLZ0LIczhR5I3guqJzDfcOAZ5ctHPIaxAGzoZp+/rIjJSJvSxz0PSswFiyPBw6SaUFbX13cJL23aBI7MmAPf3TNUV0iUmR+DXditnVhBVRz5BQZ1QmECswW0iJNXr3GGsMk/mxsj7mBc7Pnv9kz8hFZ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=LPz78v5t; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1729157286;
	bh=jYTOHrj7aBtDItZ26HLq1w3w9vmtPKusjwSiZztpTr4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=LPz78v5tNtaLl10p5bTsljqc8qQ9PmSaRWg43Vc7+fg385rgqMJGiO2MGn89IRRLS
	 0iyKjdXz+ZwDzZY9/q5vUXB6o6mrav33ObEzuQSJHc60wtimAXg5ZC+26jXeuuINTK
	 gGkk7gtu7xf4YYNQy8UlLWDPffw6gOf8DCd53ZhA=
X-QQ-mid: bizesmtp88t1729157271t76k14au
X-QQ-Originating-IP: bDbm0qGdMtkGbRUmorBNBko1orLdgiAYxcE0c6ujLRQ=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 17 Oct 2024 17:27:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10282491274136237762
From: WangYuli <wangyuli@uniontech.com>
To: michael.chan@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH] eth: bnxt: Fix typo "accelaration"
Date: Thu, 17 Oct 2024 17:27:47 +0800
Message-ID: <68544638693B0D11+20241017092747.366918-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M4K5nIxZYv59tPOdUFgiRkjkEQ/prZtc3vE4dk/9nDswoSEi34cTFlFj
	EZAnwpJEzIZUEzaIg1yWhVUMYOpIIpoyQ72ji8ICrMRKKF162DeEqniIWd4JpMWLv+OthBw
	cbzrZlVoNGQJsFn1YN/iOugV7M/Qx7SVjJg/TSzPoUTUD22wh/r8aFCkxbCwgM/SJ93yrZW
	7OR2C8lwLNGX147/gAGAICTtsuMNlQftmy4g9INgJ0xOKKuJoCEgJ9J5Eyx5uRfv496QFXN
	vGmNsj3F8El++W0mXiaf9XOt81bN9VZ2tOtAoki+JZy3qF0JvXDnLHL+bADaUmAPvX9TgJW
	31ZG1gvUFN2ibXtH6PP5urr5kuKKZE9t2EpXwF5j2q4gHiJXVaZRZdLosc3Sov7jjxEfd7Z
	DYEIZCAJv3V1K3L8IgJyEgBtsaWsqYkatVQI8I7jVGsboIlqV+JE6rcHmmLwfhCvprdKPR5
	g/7Wr7Xo4gJ9jBOzozwgN/gdS0tO1Ig5s7VheGwj+JtcmPShCzIRcX4UioOukFT5iZ3Y/fu
	eri78VgSQsp6/Sy+gLPqnD8/cJnypF2Hj8/aiqjg+rV0Yvc4vlr0dqUBwBG8LTXyQcDV94X
	cd36VHOdC8j3nxBwzj35K2yrnyasSnybeOkhInWPqYLHTlVPRDc1IJgwt9uC7j9GzTFX+lu
	lwlW5kzNh5Ai5ct1qXIVRhcwAnuR81c6vb4GsPsrFCZtY0lFDzAeB+XfiDBZc2DKShsYAfK
	KTEFQMtC0yRgw2jxQtdKghHTZzPx2ifqpYYzzzyhw1LqNTj7Lsny8jPoVvGzqLNGjfmw+BS
	MosHIDwVStCiypa0yxQGq1/F1+YDQ5fs/A3BJQkP9tjYU6EDuPUCghU6w/VMElPcSJ3WJtT
	1AiNrlG3kcyRkLLnvTcpViPR4g9cWrzFioOIMfkpGF7piwQck/edvklJVmzO1GcCpD28Xhi
	W522EEDvxMfwK4P/REKpSNsEQi33o2ek5MkGSrofjX4R/+yq9Kec4dfsi
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

There is a spelling mistake of 'accelaration' in comments which
should be 'acceleration'.

Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f5da2dace982..0093f581088b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -12881,7 +12881,7 @@ static netdev_features_t bnxt_fix_features(struct net_device *dev,
 	if (features & NETIF_F_GRO_HW)
 		features &= ~NETIF_F_LRO;
 
-	/* Both CTAG and STAG VLAN accelaration on the RX side have to be
+	/* Both CTAG and STAG VLAN acceleration on the RX side have to be
 	 * turned on or off together.
 	 */
 	vlan_features = features & BNXT_HW_FEATURE_VLAN_ALL_RX;
-- 
2.45.2


