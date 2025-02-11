Return-Path: <netdev+bounces-165118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0640BA30863
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 11:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E533A16E3
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 10:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEC41F4739;
	Tue, 11 Feb 2025 10:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rE/utMIO"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59D51F4285
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 10:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739269299; cv=none; b=KGYMUcXVvS5NDKq22KuGEi3XrQBYoqdSmq8ryxxUHp8+suTW9sk3CxNqXjNsDlusdiN+Yi2g90JDBsZZqwbvW8DKFhxjNxHNS0yqAq8ToaaD7bFbmmcXq43i4gYcezeukAKVdqe4kiSFuXLSefgtA+OVfXzHx1tjG5culPLDTcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739269299; c=relaxed/simple;
	bh=NHnejRiD4F+bD2f1fFm4I4nrdOgw35XCjt6JvGxyuYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q6IKL0rIr52tWOj73LXfez7PuJAHsm/AHTs6Oi1Zlb+SI4aZ/4P7jfPDOlwRMlhPEj/yj4J9RwwxOWXWV4l9C6kNJgpaHrBMzztqbaIadOHhGnSccvybbUiyYQtEgwBiNYFy7u7Vb1uXkh8PL54qFpFXUhkE+QM2+Z7JMsF/7a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rE/utMIO; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739269285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qIkHZdlJgBI8XSQLEeTxcPGCocchQWHaTTHt7yTbJBA=;
	b=rE/utMIO7b9owZb9QOZwh7pufDBBrE3qOSRPfoEosHyZhr0IDm4F8Qunl7KZs/GalQOOYl
	scLJyj099CN+VtLjjrPdbmRM/CusfJPfYAxfpbPFNBh5y66N57I0xulmBsjN6qYCzVLx8g
	EGwKAcqgPONLzq7diegTlGua3ehpAAE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] sctp: Remove commented out code
Date: Tue, 11 Feb 2025 11:20:56 +0100
Message-ID: <20250211102057.587182-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove commented out code.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/sctp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/sctp.h b/include/linux/sctp.h
index 836a7e200f39..812011d8b67e 100644
--- a/include/linux/sctp.h
+++ b/include/linux/sctp.h
@@ -222,7 +222,6 @@ struct sctp_datahdr {
 	__be16 stream;
 	__be16 ssn;
 	__u32 ppid;
-	/* __u8  payload[]; */
 };
 
 struct sctp_data_chunk {
-- 
2.48.1


