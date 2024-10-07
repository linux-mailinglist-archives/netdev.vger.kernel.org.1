Return-Path: <netdev+bounces-132576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539C3992281
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 02:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5E6BB21C29
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 00:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB776BA42;
	Mon,  7 Oct 2024 00:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="CgdrVYvz"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE78BBA3D;
	Mon,  7 Oct 2024 00:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728262023; cv=none; b=ZDspcwmzvndUalx1NE9Qm//5WFHH17NI+Fp1fBD8oHod7H4z0LweI7ITMBRVTHYYjQdQb8lnM/Bi2WNl68Qtx0voDAIlLq60VbIQP9njK5xmsZ9nqZ65pUr+SmHWrcUupWFKTFLXZheE++CYR/puyOfQLnFpJcFZfk1dVscJjIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728262023; c=relaxed/simple;
	bh=l4Y5hQwARAh5ZdOq6uOOMgjSLowOZAabGby9VNGDuIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L+l5wR8gjpVSKJFMTDvkDMBIH7mPc/hjbb34hIIUxMY90o9hGOzBDqIjTnrpjoN0feyVxKkm01JXdRX10Nv3u6daIrtMDDh1C4Pbz1+CfCkWTtPkQ1ALKaqdeUjn7xpWE9ghj1m9GuD8c/Pv8bMxErgeG6z/2kyWsHBqbae77Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=CgdrVYvz; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=PcHrlYUtwLPZXcDXRByLj8WF+hiEj2Pv5BGuslgucc0=; b=CgdrVYvzYbjOwPfS
	A6Hli9gt0fbRtuAc9PemwgR61x8JA9Dqm/ZrD69nkeycH3aMRfBSl445hHOYAw+zWLG1+xTX4dvRF
	YUeXkWyIamRBOYhcY8RF0qDB1e4X6OtZgSBhVzrg+1upRvQHhJP3ZTtuKXcJurL4RMgUe7PeaFGM6
	RIMa9ljTDeDj2MkuCiMd5H6Q0vMKLkM8nVrcj2bRVtG0pjF2/AZCnfrLguvwDBueupugcfESoT8ub
	P9Fm+CSTzCvozmkKJTjWHenBTYrjbHrUMSsoAao44dvsU0TlxSjEqIub2l3ro2bT4wevU7b/tbAPW
	dEiFhO7SQX1ESYhtqg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sxbtl-009M51-0q;
	Mon, 07 Oct 2024 00:46:53 +0000
From: linux@treblig.org
To: ayush.sawal@chelsio.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] chelsio/chtls: Remove unused chtls_set_tcb_tflag
Date: Mon,  7 Oct 2024 01:46:52 +0100
Message-ID: <20241007004652.150065-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

chtls_set_tcb_tflag() has been unused since 2021's commit
827d329105bf ("chtls: Remove invalid set_tcb call")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h | 1 -
 .../net/ethernet/chelsio/inline_crypto/chtls/chtls_hw.c  | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
index 7ff82b6778ba..21e0dfeff158 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
@@ -573,7 +573,6 @@ int send_tx_flowc_wr(struct sock *sk, int compl,
 		     u32 snd_nxt, u32 rcv_nxt);
 void chtls_tcp_push(struct sock *sk, int flags);
 int chtls_push_frames(struct chtls_sock *csk, int comp);
-int chtls_set_tcb_tflag(struct sock *sk, unsigned int bit_pos, int val);
 void chtls_set_tcb_field_rpl_skb(struct sock *sk, u16 word,
 				 u64 mask, u64 val, u8 cookie,
 				 int through_l2t);
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_hw.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_hw.c
index 1e67140b0f80..fab6df21f01c 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_hw.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_hw.c
@@ -106,15 +106,6 @@ void chtls_set_tcb_field_rpl_skb(struct sock *sk, u16 word,
 	send_or_defer(sk, tcp_sk(sk), skb, through_l2t);
 }
 
-/*
- * Set one of the t_flags bits in the TCB.
- */
-int chtls_set_tcb_tflag(struct sock *sk, unsigned int bit_pos, int val)
-{
-	return chtls_set_tcb_field(sk, 1, 1ULL << bit_pos,
-				   (u64)val << bit_pos);
-}
-
 static int chtls_set_tcb_keyid(struct sock *sk, int keyid)
 {
 	return chtls_set_tcb_field(sk, 31, 0xFFFFFFFFULL, keyid);
-- 
2.46.2


