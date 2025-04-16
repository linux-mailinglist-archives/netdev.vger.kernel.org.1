Return-Path: <netdev+bounces-183185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B83A8B4F8
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5FE1903394
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C532822B8CC;
	Wed, 16 Apr 2025 09:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="JloMLQRK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="OH5Ks1Xc"
X-Original-To: netdev@vger.kernel.org
Received: from mx.wizmail.org (mx.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87572343AE
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794929; cv=none; b=E2Ttl+i0sYHIui8CaeRcRXomvPwgUHPgtLVVG4E3Igo+U7OubryRlvw0Z9/S0A3Mw6EUs9A3M1v87Ex6zybSSwDTcGghB8sPZmf/XAXWdtDf4BvbEymf/lzv8QIGSw6GqDgVRcMgE4FwmyajilIfzbvp9pj9Pqyf+98cEdKb9zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794929; c=relaxed/simple;
	bh=e1kGme04fjYTT1rNU07Od94ybjOWJE/2CRbtUQWimlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMJipTvtSzNQHpZGjuqfKtWctq0O1y8K3zdiVWapggSw6rrAAWYdGMU+lDTBmpDdT+97S+bElJsTMQq5sfNTvohNQKjbsJFtT9eHD1W9SqcYcqc8VgHj/+hCspW/qzXVLCRcHdlciD14jdn74psXDnQ5Pr6rbFnzJ0+jQAE5xBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=JloMLQRK; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=OH5Ks1Xc; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:References
	:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=qNzaVqcVtXirrY+7TYF8guTvKnQI5PGfhGZldiD9I90=; b=JloMLQRK7o4vnLu
	PdiKxyIkSuDZTSo438zpYCZxNqu22Jm08G3grGJR3IU9DNVWW45EY0Dn68Yjx05o9vXzMBQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=qNzaVqcVtXirrY+7TYF8guTvKnQI5PGfhGZldiD9I90=; b=OH5Ks1XcY1Mm7k5
	H9RHBJBbCQP0rshFZ9KbbfSVj2VPZFaDtp5grDyetU4/BbeuQn33GR0sc7nrmbXSjAX7ms1/TdTKp
	HUk8uNi+TKsWaDE1SC9zYRWrOhLDTV8S0Z/D+sKYv5MLfn9Ei3H8yUmp5ME0Wu7Fz53OtG55ixeOi
	GL0++HHUoW4uhrQVuJKrsJIhTu/nWx6SXxj0V1Vr3RmHT28HOJfwZuZwuwe7hO33Ekih5b+Ov4CLF
	7iZybElBbfJYB++2fwa8c2noxjnqYGoUo9dy1MFa5ygzoDEWGhLtSxPY0w8fALu1ToQytbb62OSh5
	uzgBca1CGxPoOqQf1hA==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by www.wizmail.org (Exim 4.98.114)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1u4yrb-00000001gvL-3ztT
	(return-path <jgh@exim.org>);
	Wed, 16 Apr 2025 09:15:24 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	Jeremy Harris <jgh@exim.org>
Subject: [RESEND PATCH 1/2] TCP: note received valid-cookie Fast Open option
Date: Wed, 16 Apr 2025 10:15:13 +0100
Message-ID: <20250416091513.7875-1-jgh@exim.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416090836.7656-1-jgh@exim.org>
References: <20250416090836.7656-1-jgh@exim.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain) with esmtpsa

Signed-off-by: Jeremy Harris <jgh@exim.org>
---
 include/linux/tcp.h     | 3 ++-
 net/ipv4/tcp_fastopen.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 1669d95bb0f9..a96c38574bce 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -385,7 +385,8 @@ struct tcp_sock {
 		syn_fastopen:1,	/* SYN includes Fast Open option */
 		syn_fastopen_exp:1,/* SYN includes Fast Open exp. option */
 		syn_fastopen_ch:1, /* Active TFO re-enabling probe */
-		syn_data_acked:1;/* data in SYN is acked by SYN-ACK */
+		syn_data_acked:1,/* data in SYN is acked by SYN-ACK */
+		syn_fastopen_in:1; /* Received SYN includes Fast Open option */
 
 	u8	keepalive_probes; /* num of allowed keep alive probes	*/
 	u32	tcp_tx_delay;	/* delay (in usec) added to TX packets */
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 1a6b1bc54245..004d0024cd98 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -401,6 +401,7 @@ struct sock *tcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
 				}
 				NET_INC_STATS(sock_net(sk),
 					      LINUX_MIB_TCPFASTOPENPASSIVE);
+				tcp_sk(child)->syn_fastopen_in = 1;
 				return child;
 			}
 			NET_INC_STATS(sock_net(sk),
-- 
2.49.0


