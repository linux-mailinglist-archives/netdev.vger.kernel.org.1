Return-Path: <netdev+bounces-129245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CA597E73B
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 10:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365C81F2165E
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 08:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0074F7DA7D;
	Mon, 23 Sep 2024 08:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qENTfuPf"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69FC5FB95;
	Mon, 23 Sep 2024 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727078888; cv=none; b=QrV4JSCE4ljiARxOd8NzBns+MTpm0JWTyHlu7SBDzjK/qznBReIqz5Z3i0rhwd4/bpr8nIrOQ4mHMPyBKLXfzrkrZXorTxugTEmxt8f0dyYS+i9HuJQC2sKZk4P8S8bJKbhtGNmFLljuAP2ObTNugXRySRayYYPOnpVXii6sjvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727078888; c=relaxed/simple;
	bh=GYTKW8AR6kJETWDLmU3RwLAkZzS9wj4woVPeGpF5vr4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RvvAhA7hC3Db7b5adE6cI6dRz/NKJz8alg46wBqlNUNEwA3logS7kZRlcMbOzT2OZOHnNOvxerVPeEnsBOx109af13OWHyceiOCxXmnC6b5XBa21XoOKayHoWPkzHOTM7sF2VQvpbDDMA6UCpIDjXUmicYF1ArfpkD4WrffpMOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qENTfuPf; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727078882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6BJIqE0qSpciuGWzdnF6o/Z2xAKQwtHlYnbvWaPa6KI=;
	b=qENTfuPfMJurs6xmfNTYf9DqN8OvWg1BSUf9tlI3s1Lj3Od1DdPP2K4ZbDGalt3wuXhdse
	7U6a57+ltXbAnqj4B2ub2V9dZhG3qZwDuvragkvmQOCMqMFlV/VxXvD9cCWUfrj5+DupZy
	Y1aUVe0134iZnn5edYjyYQEMrgO4mZs=
From: George Guo <dongtai.guo@linux.dev>
To: paul@paul-moore.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 1/1] netlabel: Add missing comment to struct field
Date: Mon, 23 Sep 2024 16:07:33 +0800
Message-Id: <20240923080733.2914087-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

add a comment to doi_remove in struct netlbl_calipso_ops.

Flagged by ./scripts/kernel-doc -none.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 include/net/netlabel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index 529160f76cac..4afd934b1238 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -208,6 +208,7 @@ struct netlbl_lsm_secattr {
  * struct netlbl_calipso_ops - NetLabel CALIPSO operations
  * @doi_add: add a CALIPSO DOI
  * @doi_free: free a CALIPSO DOI
+ * @doi_remove: remove a CALIPSO DOI
  * @doi_getdef: returns a reference to a DOI
  * @doi_putdef: releases a reference of a DOI
  * @doi_walk: enumerate the DOI list
-- 
2.34.1


