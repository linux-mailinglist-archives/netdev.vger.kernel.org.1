Return-Path: <netdev+bounces-217659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18919B3974E
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD203AC960
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 08:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECF22E2DDA;
	Thu, 28 Aug 2025 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OrrvAfUO"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8BD2D29B7;
	Thu, 28 Aug 2025 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370630; cv=none; b=MIb+UzM3SQxXHFKhtDcn9EImquZpNUeBEOmwzoPVPms1daHbJSuVEE7KSCeE6UQrh5HyuRA1hiYVPU0SWE7UwMfFLG+m99h8f2Up7ByRYMaXqlZFsUzEegAb02iekUTI8MP/JjIc+PXN7OdE0t2zNvsgBgpvaOfl4/UwzWnHCXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370630; c=relaxed/simple;
	bh=X22tP2xrHHQH3BgnvnFMMAmrnrQd+pu9zV0D74s9PQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bVu4CBEvsvwsOyMoGj8xx9J1xFojOpFY6nDUbgtuQaKLuE3JKtczJLv/cMAJe8T/98ac9ySfcaTM+myDC6mvPVN83/vvpRPMEsHN90RbBPf/lrao8tIBvxIyFpH+a6iY8zhiWZai4uxKoF3yL5C68hn7VilMYCtFEjQg/yCO+E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OrrvAfUO; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=5QUT1rRrDEqaGKjsjtG+yKi8H+rE0/kJmqm+8X6M2jc=;
	b=OrrvAfUObnucCGZ0eMIZmxQ41wivUjTqo8HlfFN18dqVXEuO/ZbkMPTkLmEL+l
	DCBN0hygKpi3kGkPh2s/NhLogfnWc3N+rLR5u3pfrU5TYUFByPUqIfI65bw+1T7D
	gMV+rPtr+jIFmpUSE9vKtL1A/kY9W3uQsouT/hPtgN6Jc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wCHmLKQFrBommakEw--.52130S2;
	Thu, 28 Aug 2025 16:42:59 +0800 (CST)
From: mysteryli <m13940358460@163.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Michal Luczaj <mhal@rbox.co>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Biggers <ebiggers@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=E2=80=9Cmystery=E2=80=9D?= <929916200@qq.com>
Subject: [PATCH] net/core: Replace offensive comment in skbuff.c
Date: Thu, 28 Aug 2025 16:42:53 +0800
Message-Id: <20250828084253.1719646-1-m13940358460@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHmLKQFrBommakEw--.52130S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw1DCF4xXrWxGr1rZF17GFg_yoWDKFc_Za
	y0vFWxCw4xJFy2kw43Aws3GrZ0v3y8ur1vkayvqrWUta4kJan5Ca4kAFy3ur93WFyUtwn8
	WasIgrykurnI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0jLvtUUUUU==
X-CM-SenderInfo: jprtmkaqtvmkiwq6il2tof0z/1tbiXxi3OmiwFKM4uAAAsl

From: “mystery” <929916200@qq.com>

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


