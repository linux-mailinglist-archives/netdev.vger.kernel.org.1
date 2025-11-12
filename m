Return-Path: <netdev+bounces-237921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716C4C51818
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 10:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB733A3248
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 09:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922982FC873;
	Wed, 12 Nov 2025 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TGi4yLAh"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C841FDDC3;
	Wed, 12 Nov 2025 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940940; cv=none; b=Rw1lBetOBFE7xFJ0BdMHMZMtQVVgfoI6iiOecqXkYG3SXy7NHg9VMrJ+Q46Mf9KZmAFNAGO2igV/dbpfmlrsz544tNIMfqA3PbmT04sbH4nthzQHQ666O7k3l3OuGqG1PHWt+rbJDYwL328x35sgT7mMZWcvprOeE92VT2UYQ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940940; c=relaxed/simple;
	bh=2WSQWNHhM0Gl922+NlXasN4YOwZzWZMNz8Hbgrk2yU4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SU/tJoa74ClbhOFgrz2TAVCROBSCM1Uumw0HqilDISKsYod4oi8yIcSwvp6Ift/uO6j4B8QyS6/SDeQlnhwzQtUwGze6YJXuypDh3wDBiPC78viH1vjANKug3D4s52kqy5ZiW3slms/HwRdTnGKR6VJ8oYp9o8lFByO9HoXgYI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TGi4yLAh; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=X8
	0gXGAGrGHUuwVP5+P52L1ae3AXnP1NtlQlw6DY/To=; b=TGi4yLAhkGLw2FQmxU
	AGCGuqnx3cHl+plVruIpMYwHwv0nsF7e4HBFip4lNyqGLlSAQZd+PCu2mwOfqRFh
	pRt76/F3OYoIvzZ4G4qg0JrzmNE2muq9jo71WSmDX/HDVRsjwc7bN0p2XgxdG/r0
	iCrxiSKarYK7p8wmKw8aoD5i0=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgA32a_8VxRpCkthDg--.4901S2;
	Wed, 12 Nov 2025 17:48:45 +0800 (CST)
From: Gongwei Li <13875017792@163.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gongwei Li <ligongwei@kylinos.cn>
Subject: [PATCH 1/2] Bluetooth: Remove unused hcon->remote_id
Date: Wed, 12 Nov 2025 17:48:42 +0800
Message-Id: <20251112094843.173238-1-13875017792@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgA32a_8VxRpCkthDg--.4901S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrXFW7Xr1UZrWrKw47Xr17GFg_yoWxXFgEyw
	1IvrZ3ur48Xry3Ar12gF4jvw1jqwn3CF97CFs5XrWYq3srWr4DtryxZr1qvF1fW3srXr13
	AayDXrykXw18AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUe7CztUUUUU==
X-CM-SenderInfo: rprtmlyvqrllizs6il2tof0z/1tbiXA8EumkUUXeHwAAAsx

From: Gongwei Li <ligongwei@kylinos.cn>

hcon->remote_id last use was removed in 2024 by
commit e7b02296fb40 ("Bluetooth: Remove BT_HS").

Remove it.

Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
---
 include/net/bluetooth/hci_core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b8100dbfe5d7..32b1c08c8bba 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -749,7 +749,6 @@ struct hci_conn {
 
 	__u8		remote_cap;
 	__u8		remote_auth;
-	__u8		remote_id;
 
 	unsigned int	sent;
 
-- 
2.25.1


