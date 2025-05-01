Return-Path: <netdev+bounces-187186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D936BAA58FD
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 02:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978DB984047
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 00:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B40DEEB2;
	Thu,  1 May 2025 00:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="e7ETvRk4"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE0F3D6F;
	Thu,  1 May 2025 00:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746059054; cv=none; b=qT1e8qQRdHxM0s/Fim91jryAQFxtMddTH/LRoAN2akaaLT+HOkTfkKsGQ5j5U2x5Y6KiKOSYtnXODQuh5+PfDTvyOeIWpO6kafMDki6tVnQ5jqy49aq9uIVSGFsHrfkv+51ARkovcYM7cUZy4Zk0NlkD0tb8AuVtQrwOw34OKRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746059054; c=relaxed/simple;
	bh=TpkNc50e0XbJDDfLg0F4mw9y1UW4rtfYYJv5YyX/wpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T+HtZv9hvrjYkxxBfBrP6M4CiLJjTKBmqHo3BE9WLde5oz1ReI4yqVv2QPVsDikwnY83C/Me5VUZ6iITLuARxdJ5CqkyWRZB4jSjPbbFyYMqWV0DnEFskvZqCDIJOThlpNavUnRaAZCtHSQywLSvApCbWin9o+joh2v+LEAE0Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=e7ETvRk4; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=+1CH4qBC7cTdhKvnr6NhhI/DKDeS5VFc40VH44HNgmc=; b=e7ETvRk4rEuyfbp6
	wQJovOWJfil+gglpz+h4hyKdurr3TCKwovBFYT5nqbeYjcXTX8HZ1wrHrQxRkrJBrmku+EkxyN7Bo
	9Tx/xCT17Trza275XGC2g4qXHcpugFuE4rJMSIf86KgtU8XELtefM3EaExmMtM7Kgo+v0ifdWTHdi
	7OHuQOH9O0l/yVgSkLkGNYLLS0frxgsJEn0x12jAl1hZ0V5PYwdIzNo3ZKBuJMn6tm52q9LsFiaAS
	LQPjAgi40wib/UIuW3w5psQ9KyEZfXah17qxWrCbdKbZ9F7/7UgcrSujv46bIW2qtkp7KfrjuSDbS
	i6MZt2RqMA9kuqkCfQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1uAHid-000oYV-0f;
	Thu, 01 May 2025 00:24:03 +0000
From: linux@treblig.org
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] strparser: Remove unused __strp_unpause
Date: Thu,  1 May 2025 01:24:02 +0100
Message-ID: <20250501002402.308843-1-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of __strp_unpause() was removed in 2022 by
commit 84c61fe1a75b ("tls: rx: do not use the standard strparser")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/net/strparser.h   |  2 --
 net/strparser/strparser.c | 13 -------------
 2 files changed, 15 deletions(-)

diff --git a/include/net/strparser.h b/include/net/strparser.h
index 0a83010b3a64..0ed73e364faa 100644
--- a/include/net/strparser.h
+++ b/include/net/strparser.h
@@ -114,8 +114,6 @@ static inline void strp_pause(struct strparser *strp)
 
 /* May be called without holding lock for attached socket */
 void strp_unpause(struct strparser *strp);
-/* Must be called with process lock held (lock_sock) */
-void __strp_unpause(struct strparser *strp);
 
 static inline void save_strp_stats(struct strparser *strp,
 				   struct strp_aggr_stats *agg_stats)
diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index 95696f42647e..d946bfb424c7 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -485,19 +485,6 @@ int strp_init(struct strparser *strp, struct sock *sk,
 }
 EXPORT_SYMBOL_GPL(strp_init);
 
-/* Sock process lock held (lock_sock) */
-void __strp_unpause(struct strparser *strp)
-{
-	strp->paused = 0;
-
-	if (strp->need_bytes) {
-		if (strp_peek_len(strp) < strp->need_bytes)
-			return;
-	}
-	strp_read_sock(strp);
-}
-EXPORT_SYMBOL_GPL(__strp_unpause);
-
 void strp_unpause(struct strparser *strp)
 {
 	strp->paused = 0;
-- 
2.49.0


