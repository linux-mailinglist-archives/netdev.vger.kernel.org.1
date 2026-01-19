Return-Path: <netdev+bounces-250989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EA6D39F40
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 08:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D217F3028D55
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 07:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B4E280A5B;
	Mon, 19 Jan 2026 07:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OuOzs2Vl"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5BB248868;
	Mon, 19 Jan 2026 07:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768806106; cv=none; b=rMvGeIITUJeFcEbVw6zO1jGtfSs1Xs2k4rF9QNxaFM5WshCKcmzAVpPDeY+VQVmeuMd87q1Xyp0xiUeo2lurcAC6t9ZM4gHVNw9jgnVuTFVGDaN3PS29R27201kNJxxFntHNvyCKw7c17xGv3CNz+WU2a2Dvp5t4C/FJ2V6UU5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768806106; c=relaxed/simple;
	bh=/mPzcOFnR+DJ7sQbJe0/MhbXYRMVe7CaQUUrrTZtw5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CtKE5iJLvr9G6nXhTo2dW/56yKG8iJA+Pm8JF3rYgZIeaw74eSmBUA6BXpKZGuLqDp8PskdpLp4mD0Ou75RV291+dJLtn/lPwhaSWug+uJpTRnwEkLIduAIKsKJsV0dPFD47rMsg1Hs0NF/4tdwfnZgdIurbCIfjwucOfZ+5zVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OuOzs2Vl; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=5Z
	T4eOMOPEjuysxlu8qzlilHeXFFA5Hk46LzGu0qs7Q=; b=OuOzs2VlAFURVH8QZo
	TqWwwcPWawvvVWJokT1PzwNajmgycgj11FERnRhE32JCAXHCDUgMhN3U42i2yE9z
	7HkfdhGbSJo6Zk+5wzXf2boA50VrmPwJB35sDJGcetGP92Dk+lAoZLZJdI2Ka52P
	KKqtNpdEwbx9KKz3ZvdmkwbAM=
Received: from haiyue-pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBH2pqN1m1pYgxtGw--.2S2;
	Mon, 19 Jan 2026 15:00:31 +0800 (CST)
From: Haiyue Wang <haiyuewa@163.com>
To: netdev@vger.kernel.org
Cc: Haiyue Wang <haiyuewa@163.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v1] mctp i2c: align function parameter indentation
Date: Mon, 19 Jan 2026 15:00:06 +0800
Message-ID: <20260119070022.378216-1-haiyuewa@163.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBH2pqN1m1pYgxtGw--.2S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr4UWFWDXw4rGw47Zr13Jwb_yoW3trX_Cr
	1jyrWxGr4UKFnaq3y3Ca9xt348Kw1jvF4kGFySqF98A34qyF4DuF4kAr13Cry5Zw48Aasx
	CFnxJr17Aay7GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKgAw7UUUUU==
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/xtbCzQ+O+Wlt1o-8nAAA3I

Align parameters of mctp_i2c_header_create() to improve readability
and match kernel coding style. No functional change.

Signed-off-by: Haiyue Wang <haiyuewa@163.com>
---
 drivers/net/mctp/mctp-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index f782d93f826e..362eaebf7c5b 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -578,7 +578,7 @@ static void mctp_i2c_flow_release(struct mctp_i2c_dev *midev)
 
 static int mctp_i2c_header_create(struct sk_buff *skb, struct net_device *dev,
 				  unsigned short type, const void *daddr,
-	   const void *saddr, unsigned int len)
+				  const void *saddr, unsigned int len)
 {
 	struct mctp_i2c_hdr *hdr;
 	struct mctp_hdr *mhdr;
-- 
2.52.0


