Return-Path: <netdev+bounces-160698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3883BA1AE51
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 02:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B197166734
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 01:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2F81D516A;
	Fri, 24 Jan 2025 01:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TLzIDBR7"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B5C13AC1;
	Fri, 24 Jan 2025 01:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737683539; cv=none; b=mGqhR50WRquFwgLti+V2JeqSJCErSj+ZJr2sV3Wmu0fPGJm7BZDwj281vn00/cKMFCkhJHEmNxMtMqiAPRUUqGBlAB9thwq1jxasKZ5lwTrOhczVdQMmZv2TtELY51yluQcNEj8TI5gOWPed7kfFPAHFvYooC19sqAz2dbItgKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737683539; c=relaxed/simple;
	bh=rv9I69avJ8YzBGmOEjrj84dDL/AG6qp0BUjeWg9EZic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s0El58NC0WAyxB4Zp5rW+P3U1gyyH7AbI6CnobRSto6/tpSepsC2TRSf7NENWbFmgGrF6oPMn5xkg5XWIZ7y3cB1lb4fO6lcdO996pA50gscxF4ruwGNUjKNZmYCoinNChzRJHqW3a2u30MDav9sl+yMjMc081mXwWzzuAksXjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TLzIDBR7; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=TYv5p
	FiqY0mMlrgwppjPDujsvoDO3YqxRX3WZiF+Kfk=; b=TLzIDBR7nAM65WtTmCPRi
	9choMMwONyndFS1jG/qnOefVyfDbFV176AYmnI94PxHdIZ8XIvItH4xqutdcbAeU
	SAjuGs7tpagiZar5QafFJkOBfFKSzu0A26d6+8TQbAjVAvEeHoAEAaGInMEoOtvH
	u33ewKFLAkDWzuPa0MCC0Q=
Received: from hello.company.local (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDXf9oe8pJndhVGIA--.2883S2;
	Fri, 24 Jan 2025 09:51:27 +0800 (CST)
From: Liang Jie <buaajxlj@163.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liang Jie <liangjie@lixiang.com>
Subject: [PATCH net] af_unix: Correct comment to reference kfree_skb_reason hook
Date: Fri, 24 Jan 2025 09:51:06 +0800
Message-Id: <20250124015106.2226585-1-buaajxlj@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXf9oe8pJndhVGIA--.2883S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw4fKrW7JFW7Zr1kXr1UZFb_yoWfurg_Wr
	nFgr4UCw1UJan8Z39Fkr43XrZa93Z5Wr95Ww17CFy7W348XF45J34vkrZ8Gr1UWrWUtF98
	Gr1kWr9xWw17XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU85UUUUUUUU==
X-CM-SenderInfo: pexdtyx0omqiywtou0bp/1tbiNgfeIGeS6qR1JAAAsl

From: Liang Jie <liangjie@lixiang.com>

The comment in unix_release_sock has been updated to correctly reference
kfree_skb_reason instead of kfree_skb, for clarity on how passed file
descriptors are handled during socket closure.

Fixes: c32f0bd7d483 ("af_unix: Set drop reason in unix_release_sock().")
Signed-off-by: Liang Jie <liangjie@lixiang.com>
---
 net/unix/af_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 34945de1fb1f..47dd3749ce32 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -717,7 +717,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 		if (state == TCP_LISTEN)
 			unix_release_sock(skb->sk, 1);
 
-		/* passed fds are erased in the kfree_skb hook */
+		/* passed fds are erased in the kfree_skb_reason hook */
 		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
 	}
 
-- 
2.25.1


