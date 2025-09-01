Return-Path: <netdev+bounces-218611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F5EB3D977
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66EDD7AACEA
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 06:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0281418FC80;
	Mon,  1 Sep 2025 06:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GRQ4AGcC"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7118014C5B0;
	Mon,  1 Sep 2025 06:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706851; cv=none; b=jPhHG9ptdahNecwNraa4GvMlSejhOO26/O8My8Bz8IFcLVoBrJP4aMEvXzTJcEabFSDHhxpsqxAEhrawnzRkqs4bFxXh4K8BoZiB7zb4PdwRa7jRetu/Jh0zRruRX/0ppyfglxQsNa9d/nyxTCuTHXuGBPzcq6kzazOS+5onrFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706851; c=relaxed/simple;
	bh=Fiqf2OV+w04RoAqL3Hknz8jueYrThcYmF32Z35QGv8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XXlec5LzQLQvhfwJm3f4aRm2LpALZf4P6wR4g/6mnNF1LVjP1cdKaMp6Pe3QEf3mrCOT8YKMA5J/FbouDC04tX6TLc0upJ9Ll+0Wwbzmz4BZROGBHNcSw9Z9pmXVOZbJFgzlH/3DlFoj1HlCsgnhnXPN9Bc4/f3dKzEssqRorfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GRQ4AGcC; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=KD
	NujxQhZ4dZPsrf39XnQIMTiyfKtPoWMNjlft/OYgg=; b=GRQ4AGcCq65NRE94Bb
	y+qvzCyikUeWJJ0Z30t9eeEX4gDRoDPQjIwZoln2hUpdeH5gv3uGr+Jsn3PR1lpP
	DCybtzpH7dknMRxNMp+MQSQok9hrjMsGvClTmqevXOAljWqV3oXvsbD1rOgLqRqf
	aX7Ik4gv3cUlcAbdDXY1iVrW0=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAXPbjtN7VosBAMBQ--.8409S2;
	Mon, 01 Sep 2025 14:06:38 +0800 (CST)
From: mysteryli <m13940358460@163.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Michal Luczaj <mhal@rbox.co>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Biggers <ebiggers@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mystery Li <929916200@qq.com>,
	"Mystery Li" <m13940358460@163.com>
Subject: [PATCH v4] net/core: Replace offensive comment in skbuff.c
Date: Mon,  1 Sep 2025 14:06:35 +0800
Message-Id: <20250901060635.735038-1-m13940358460@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgAXPbjtN7VosBAMBQ--.8409S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrur4ktryrJr4xZr45Zw17trb_yoW8JrWfpr
	yxG34fCF4Dur17Aw4kAFn7ur4Fv3s5GF1UKrsxt34rJwn8Grn2gFs8KFs3ZFWYv3y3tryj
	qrZIv3y5KFWUAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pETa03UUUUU=
X-CM-SenderInfo: jprtmkaqtvmkiwq6il2tof0z/xtbBNQO7Omi1M1JlLQABsC

From: Mystery Li <929916200@qq.com>

The original comment contained profanity to express the frustration of
dealing with a complex and resource-constrained code path. While the
sentiment is understandable, the language is unprofessional and
unnecessary.
Replace it with a more neutral and descriptive comment that maintains
the original technical context and conveys the difficulty of the
situation without the use of offensive language.
Indeed, I do not believe this will offend any particular individual or group.
Nonetheless, it is advisable to revise any commit that appears overly emotional or rude.

Signed-off-by: "Mystery Li" <m13940358460@163.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ee0274417948..202c25a01f22 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5333,7 +5333,7 @@ int skb_cow_data(struct sk_buff *skb, int tailbits, struct sk_buff **trailer)
 		    skb_has_frag_list(skb1)) {
 			struct sk_buff *skb2;
 
-			/* Fuck, we are miserable poor guys... */
+			/* This is a painfully difficult situation with limited resources... */
 			if (ntail == 0)
 				skb2 = skb_copy(skb1, GFP_ATOMIC);
 			else
-- 
2.25.1


