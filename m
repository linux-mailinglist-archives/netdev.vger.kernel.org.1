Return-Path: <netdev+bounces-238203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E86C55E49
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 07:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF033B8869
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 06:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6410530BBB9;
	Thu, 13 Nov 2025 06:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nVxJNsxt"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E6526FA6E;
	Thu, 13 Nov 2025 06:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763014260; cv=none; b=jGvHrf4mCOpcnvHkc15y4UGgh2yNvxiw2OY8rrhCHyBele2qn6hJolpiWRnHAoehm6asTmz2bJ4Rzn0qDVGhOTSC+k6THZr34Xx3u2ArpkN1dz5xgLeirSvzv9ZR+GP9+zMQQJBu2mlw9yAXV4TxRj4QHpUBwM4Qd0gBm3GfM28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763014260; c=relaxed/simple;
	bh=qwxMZIZROPDSPUh1Pw+6DrDW5f7e8Nyi9qHsTlt2vic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f05hvjaSZ270Ttf7MOHu/HKjAYIv3A1dZAJ02uvhueL4dDBe4x6OqDuG8aURxJxRtVe31j/ytNImK6pR7ZSCY3QZ3Hk5hl2gA9cHpbSqIiWSMYztl8FR1TmOUYGh2nhImg4OSrJ4awEhLjsdpS4hYNSheXR6MFX9Ad1jWTaceMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nVxJNsxt; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Bo
	UTeBHcroRJmewLYRuoJb60IWyDYcyDdxrdqYUh0RA=; b=nVxJNsxt6zjDegxgxv
	y6u1vgZuKQaqMaBjBRXb2qM7GTEHUsBIfZnhQRqLtCmdGIbXlwm77G4iJQyAE+e/
	RAfLIpnwCvKcf08mY4Eg5yN4k71+jIsQSe1KZDaoE7lOd6B5zlFuVgyY4ISDq6Ic
	o7DEuresYzSUd/tNi0GemaXAY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCXdtVWdhVp8ayOCw--.129S2;
	Thu, 13 Nov 2025 14:10:31 +0800 (CST)
From: Gongwei Li <13875017792@163.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gongwei Li <ligongwei@kylinos.cn>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v2 1/2] Bluetooth: Remove unused hcon->remote_id
Date: Thu, 13 Nov 2025 14:10:28 +0800
Message-Id: <20251113061028.114218-1-13875017792@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251112094843.173238-1-13875017792@163.com>
References: <20251112094843.173238-1-13875017792@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXdtVWdhVp8ayOCw--.129S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF1fWF4rXr1UJFykAFyDGFg_yoW3XFXEyw
	1IvrWfur4UXrW7Ar12qFWjvw4Fqwn3GFn29Fs3XrWYq34DursxtryxXr1qqr1fW3srZr17
	AayDXFWDXw1FyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnxnY7UUUUU==
X-CM-SenderInfo: rprtmlyvqrllizs6il2tof0z/1tbiXQoFumkVcEGTEAAAsm

From: Gongwei Li <ligongwei@kylinos.cn>

hcon->remote_id last use was removed in 2024 by
commit e7b02296fb40 ("Bluetooth: Remove BT_HS").

Remove it.

Fixes: e7b02296fb40 ("Bluetooth: Remove BT_HS")
Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v1->v2: Add Fixes tags
 include/net/bluetooth/hci_core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 18396e369..9efdefed3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -750,7 +750,6 @@ struct hci_conn {
 
 	__u8		remote_cap;
 	__u8		remote_auth;
-	__u8		remote_id;
 
 	unsigned int	sent;
 
-- 
2.25.1


