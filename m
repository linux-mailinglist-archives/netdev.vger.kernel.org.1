Return-Path: <netdev+bounces-218610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E496B3D921
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 07:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48ABB3A8A94
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 05:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE66242930;
	Mon,  1 Sep 2025 05:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IVZUhPAc"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8CB239E8A;
	Mon,  1 Sep 2025 05:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706332; cv=none; b=sIFK+GKxKoxg5er+Z07lDWkMWRgmCQiU8IrMudsfXag60WlS4DOfutllw4vinH8itEDESzbzL/MqS7r01M7sI16FOwV8ccIwJabYh5cBJpHyoREP+lxaBDMYF6G1hlR73MLSI/4/aIq3NF8tpT5ZkIltYxerf1m/jr878HWE/H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706332; c=relaxed/simple;
	bh=l7TYveTQiAGcaWLaoAz3d4DyCiFfthjfGnGuYoioYg0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GFJc1rwi/51aRiNQv885cxjzoTN48i9/+syS/klaOJlC/Z0MUmyJMarvLUmjSfzYn7EXWjoVIHkKgc6+2mvUY64COd00WMaiaasw2PunV8CyCS6/rXHfy54Bkbxco/WFzt6fYicgMFtS5N7N+w6fsO6Htl102AdV5FhTEgL3fUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IVZUhPAc; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=3Mq98t2htBIwnw6/bYZGfhhwwQsQntgsCLuT01Wv9DE=;
	b=IVZUhPAcEl+85CHQbjc+c//jj2tj3mIenkGF0S663XlOFXUaQYJeymX24Y1/dH
	GXabl1X0vrN0YuPIVMACaKPc2GKSoCFjjQ61VwqOnx3YAupQLTQFFU+Wr4u1cYpc
	Swj4k5Xlc4MFEMFyxIOEnXrAQhURuZA9kx/rnW8CuDGcU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wC3VU3uNbVo9KMEFg--.9191S2;
	Mon, 01 Sep 2025 13:58:07 +0800 (CST)
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
	Mystery Li <929916200@qq.com>
Subject: [PATCH v2] net/core: Replace offensive comment in skbuff.c
Date: Mon,  1 Sep 2025 13:58:02 +0800
Message-Id: <20250901055802.727743-1-m13940358460@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3VU3uNbVo9KMEFg--.9191S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur4ktryrJr4xZr45Zw17trb_yoWDKrX_Za
	y0vFZ7Cw4xJFy2kw43Aws3WrZ0v3y8CFyvkayvqrWUta4kJan5Ca4kAFy3ur9xWFyjqwn8
	WasIgrykurnI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0jLvtUUUUU==
X-CM-SenderInfo: jprtmkaqtvmkiwq6il2tof0z/1tbisgq7Omi1LcjBkQAAsR

From: Mystery Li <929916200@qq.com>

The original comment contained profanity to express the frustration of
dealing with a complex and resource-constrained code path. While the
sentiment is understandable, the language is unprofessional and
unnecessary.
Replace it with a more neutral and descriptive comment that maintains
the original technical context and conveys the difficulty of the
situation without the use of offensive language.

Signed-off-by: “mystery” <929916200@qq.com>
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


