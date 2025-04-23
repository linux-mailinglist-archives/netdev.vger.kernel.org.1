Return-Path: <netdev+bounces-185132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A81A98A0E
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 14:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F8F188FACD
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 12:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0018B26C39E;
	Wed, 23 Apr 2025 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="ZVsl50os";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="fgUw/isL"
X-Original-To: netdev@vger.kernel.org
Received: from mx.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8755826D4C4
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 12:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745412241; cv=none; b=TxZuG716Ob7iGSVGf+G70MsOFh0DM1RG6rg71IrmPF3F4NKLOYExzON3a0wnVL+DOGt3kVh+hBFMAL8H7TlxoTXjuZqbQuE7e0y1bzByfvxciJ9zsvhZiviRrhMu/TUJglyeMef1Ubp31ife3se33gIrvpuZGuC1vC5gkjrYgiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745412241; c=relaxed/simple;
	bh=1xTan75B2vJ/+EJpiU+NntOnS+CgIfFg8WynmoKEMaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vy6vXgsXVMnoCY4/vVkx61EcIhgO9q1ZEfpjLFKuhlM3d+RnyzBKv7S1FhdoToZ1HV66E7PM1GCBvcBN2OXSZk6/ECx85c5G5cpnSwsUqTmUM3CEbw/z06EbIDYOOex0KQ3gzUAKLvuswdi1zXDNjeAbaKDIuPg71ujSyKG+mBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=ZVsl50os; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=fgUw/isL; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:References
	:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=UYQZDX0pNzsDq2sk9jyCdmBPWcyEqgvvE3ihU9im/90=; b=ZVsl50os5upCMfq
	IY9fKuNXrjnH4Gqfqi/p4PfuMvkPyCywjZ2TL9q9C9z9QttMFwRPUR+0RMSysTBCnZzkUBQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=UYQZDX0pNzsDq2sk9jyCdmBPWcyEqgvvE3ihU9im/90=; b=fgUw/isLWRYPkNH
	Q6qPBlwVNVNVw/cFuuvR95B1cT53aZbPRpwyam/3ZjaeNnJVooMc0cyprcZ+XeIamxoQfv9fgsOk3
	hCYe5yty1egz2FFhr/LH80FdsvSY2MwlbE+ZKt5VGcU7yrVkg1a62qjqtETs2XkYSkCjOLw5Jma4D
	2dCXhcih1d+REBxFRnu8FpPTj4LhaelYNUmNdPGpuEKi98T811b4qK7MDpo5xJMdHAMkYZp7c3nU8
	B93fZwzkNeuJMCFxKc5tJu13o9CRSkFPrvoSMz95Dhq3LHI1PoM7KQLDoJfu5NS6LGs016exrosJ7
	hY/mZ8H8dR3xiRJ9BUg==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by www.wizmail.org (Exim 4.98.115)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1u7ZSG-00000001iTg-1weZ
	(return-path <jgh@exim.org>);
	Wed, 23 Apr 2025 12:43:56 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	Jeremy Harris <jgh@exim.org>
Subject: [PATCH v2 1/2] tcp: fastopen: note that a child socket was created
Date: Wed, 23 Apr 2025 13:43:33 +0100
Message-ID: <20250423124334.4916-2-jgh@exim.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423124334.4916-1-jgh@exim.org>
References: <20250423124334.4916-1-jgh@exim.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain) with esmtpsa

tcp: fastopen: note that a child socket was created

This uses up the last bit in a field of tcp_sock.

Signed-off-by: Jeremy Harris <jgh@exim.org>
---
 include/linux/tcp.h     | 3 ++-
 net/ipv4/tcp.c          | 1 +
 net/ipv4/tcp_fastopen.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 1669d95bb0f9..a8af71623ba7 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -385,7 +385,8 @@ struct tcp_sock {
 		syn_fastopen:1,	/* SYN includes Fast Open option */
 		syn_fastopen_exp:1,/* SYN includes Fast Open exp. option */
 		syn_fastopen_ch:1, /* Active TFO re-enabling probe */
-		syn_data_acked:1;/* data in SYN is acked by SYN-ACK */
+		syn_data_acked:1,/* data in SYN is acked by SYN-ACK */
+		syn_fastopen_child:1; /* created TFO passive child socket */
 
 	u8	keepalive_probes; /* num of allowed keep alive probes	*/
 	u32	tcp_tx_delay;	/* delay (in usec) added to TX packets */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e0e96f8fd47c..df3eb0fb7cb3 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3409,6 +3409,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->rack.reo_wnd_persist = 0;
 	tp->rack.dsack_seen = 0;
 	tp->syn_data_acked = 0;
+	tp->syn_fastopen_child = 0;
 	tp->rx_opt.saw_tstamp = 0;
 	tp->rx_opt.dsack = 0;
 	tp->rx_opt.num_sacks = 0;
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 1a6b1bc54245..9b83d639b5ac 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -401,6 +401,7 @@ struct sock *tcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
 				}
 				NET_INC_STATS(sock_net(sk),
 					      LINUX_MIB_TCPFASTOPENPASSIVE);
+				tcp_sk(child)->syn_fastopen_child = 1;
 				return child;
 			}
 			NET_INC_STATS(sock_net(sk),
-- 
2.49.0


