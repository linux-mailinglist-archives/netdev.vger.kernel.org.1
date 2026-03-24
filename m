Return-Path: <netdev+bounces-271112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mH8TLyalwmkyggQAu9opvQ
	(envelope-from <netdev+bounces-271112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:52:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6DF30A802
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C025730411CE
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751D5401A01;
	Tue, 24 Mar 2026 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J3aDI28f"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB23FFABC
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363627; cv=none; b=fmCMBfo4WQBp8tISwzDhcZp06efMwkwMa2KQkhTW3nKLaW9lutGoRczlG6NDb1+kkPjdeXHxIoZ+Ea3xIco0kJ4oAcfSqZ7mIe1yfWSP4J8JIaAyoTKZBhK0CAExPTLvbLzGRQTy7V1G2JaifkmgtfqubO+svGIXqDRfgVcKzgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363627; c=relaxed/simple;
	bh=T4a4e5KJlGe26Sd5S7YRg6XR4vrwYYgciWiIF7kRS/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJ/EJQnLHmudwywk6G9sZegkSRvp1sHWegZMakVysNq+VKAk5DuUTVt/SXO56ySex67wdANkhSiyX8HJM/IsC28hhe/kwcGwtU9XvjdzWF6qrecPmQWNr0Fpkzt6G3s2EZa0bzBiUAfDA9ZDa/SFlTCzfsUQhg/kEZ1Sq9t+n+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J3aDI28f; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774363621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ueHmI5mgTDR5odOSYCRBX4DGBx1jlplYYGZFbMOOnE=;
	b=J3aDI28fJVnCH9KMA6XgE+JA8vUQnjwK7xGxLjOJ4xObeBKRb+6BWwhwuRdex1D3BW7VC0
	mHRCXKq2H6w0s0AITyVHLasC/iLM78DqybL7D/ewu8JBYhtOp3cwezYk1xQ53vir9ZlAvR
	iHUR5nt3rdnJ2RNrSXYZKdxQR13Mlcw=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	fmaurer@redhat.com,
	liuhangbin@gmail.com,
	linux-kernel@vger.kernel.org,
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH net-next v1 7/7] net: hsr: use BIT() macro for bit shift constant
Date: Tue, 24 Mar 2026 15:46:30 +0100
Message-ID: <20260324144630.189094-8-luka.gejak@linux.dev>
In-Reply-To: <20260324144630.189094-1-luka.gejak@linux.dev>
References: <20260324144630.189094-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,vger.kernel.org,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271112-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB6DF30A802
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luka Gejak <luka.gejak@linux.dev>

Replace the explicit bit shift (1 << HSR_SEQ_BLOCK_SHIFT) with the
standardized BIT() macro for defining HSR_SEQ_BLOCK_SIZE. This improves
readability and aligns with kernel coding conventions.

Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 net/hsr/hsr_framereg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
index c65ecb925734..cb731ee0ce5c 100644
--- a/net/hsr/hsr_framereg.h
+++ b/net/hsr/hsr_framereg.h
@@ -79,7 +79,7 @@ struct hsr_seq_block *hsr_get_seq_block(struct hsr_node *node, u16 block_idx);
 #endif
 
 #define HSR_SEQ_BLOCK_SHIFT 7 /* 128 bits */
-#define HSR_SEQ_BLOCK_SIZE (1 << HSR_SEQ_BLOCK_SHIFT)
+#define HSR_SEQ_BLOCK_SIZE BIT(HSR_SEQ_BLOCK_SHIFT)
 #define HSR_SEQ_BLOCK_MASK (HSR_SEQ_BLOCK_SIZE - 1)
 #define HSR_MAX_SEQ_BLOCKS 64
 
-- 
2.53.0


