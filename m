Return-Path: <netdev+bounces-185135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CEAA98A15
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 14:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D7517420E
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 12:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819962701B7;
	Wed, 23 Apr 2025 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="VsxM9+Zq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="nxS5gt55"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B38182
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745412382; cv=none; b=D8UaWeDJm+jLWnfmjamna+WovgHvbx7t8vJox/H1kZAzEdf6LaBrvvtxk1bUd17F7m+j77R6PBUImskq5QWxuBXks689qsRiYFSZHeQZlS7+/JUGqJNEstEyL+J6wv+DC8csexUuIxOouRi/LEN/9eT37W77wySvZDvTAwDmfbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745412382; c=relaxed/simple;
	bh=mLoNzO5ryL0WvKWQA8Y33R/f1dQns93JX0EW1zACqKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sclzj33504LdudaMqnzKW6ckjp8vQyvX2AamQ46DOHSQ9m+c/qG71z1axhTXY8JuAQnSyfqzdEpHSp+00BMRQMVK2W24hNIMWnbR45sRECgq2EJQA0hvrGNKP4xhDCuft7IjIjhiHS6sxQmJQE0j/C+QIyH9yjAPbACk4Nu4vN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=VsxM9+Zq; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=nxS5gt55; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:References
	:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=r2yCm93V994tEJAy0ItMvj0QYVOnPMcgF+UexH1h3TE=; b=VsxM9+ZqIrB2VRi
	yvkSP4aVoHWNQBp616suu679vfgL7XfYEUNSktaspBFPerRC42XkHRtlw32MLoGeYzzzvCw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	Autocrypt; bh=r2yCm93V994tEJAy0ItMvj0QYVOnPMcgF+UexH1h3TE=; b=nxS5gt55msdAU4y
	AeCkME5uPwWoGpoU83J2FSjhTEEI7iETsBpPTPElkKVPqxfx6CuOom23NfWZEq5L9AdwSUzV6+IqC
	5gyz66PuT2AbqqjICbFUJ++f4YuBRQJlBp3ILMhCw7itTFBqyMHbPEUERMJVyZNGbWNdwOm9ePeMr
	HyEzLMJxfgP2GhlQKoiRG38jGxeWuncX/NmJoImz3MyBBB1DSxWrkIHdtBEkNIhQugFd/46FMC5aX
	9fuV7Ou9mBj2IxfZpe1Q5kn+JAHvDnN+UJqi+/H2rjKDzl9flndZjd+byYBxa1mwFkf/SYDcEXH3K
	YEddvtpPumIEHZyPIDw==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by www.wizmail.org (Exim 4.98.115)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1u7ZUZ-00000001iXI-0QR3
	(return-path <jgh@exim.org>);
	Wed, 23 Apr 2025 12:46:19 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	Jeremy Harris <jgh@exim.org>
Subject: [PATCH 1/1] ss: tcp: observability of fastopen child creation
Date: Wed, 23 Apr 2025 13:46:00 +0100
Message-ID: <20250423124600.5038-2-jgh@exim.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423124600.5038-1-jgh@exim.org>
References: <20250423124600.5038-1-jgh@exim.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain) with esmtpsa

ss -oi can output "fastopen_child" attribute if the passive-open
socket was created as a fastopen child

Signed-off-by: Jeremy Harris <jgh@exim.org>
---
 include/uapi/linux/tcp.h | 1 +
 misc/ss.c                | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index cc5253a5..85b51e4c 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -184,6 +184,7 @@ enum tcp_fastopen_client_fail {
 #define TCPI_OPT_ECN_SEEN	16 /* we received at least one packet with ECT */
 #define TCPI_OPT_SYN_DATA	32 /* SYN-ACK acked data in SYN sent or rcvd */
 #define TCPI_OPT_USEC_TS	64 /* usec timestamps */
+#define TCPI_OPT_TFO_CHILD	128 /* child from a Fast Open option on SYN */
 
 /*
  * Sender's congestion state indicating normal or abnormal situations
diff --git a/misc/ss.c b/misc/ss.c
index 6d597650..0df88045 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -891,6 +891,7 @@ struct tcpstat {
 	bool		    has_ecn_opt;
 	bool		    has_ecnseen_opt;
 	bool		    has_fastopen_opt;
+	bool		    has_fastopen_child_opt;
 	bool		    has_wscale_opt;
 	bool		    app_limited;
 	struct dctcpstat    *dctcp;
@@ -2613,6 +2614,8 @@ static void tcp_stats_print(struct tcpstat *s)
 		out(" ecnseen");
 	if (s->has_fastopen_opt)
 		out(" fastopen");
+	if (s->has_fastopen_child_opt)
+		out(" fastopen_child");
 	if (s->cong_alg[0])
 		out(" %s", s->cong_alg);
 	if (s->has_wscale_opt)
@@ -3099,6 +3102,7 @@ static void tcp_show_info(const struct nlmsghdr *nlh, struct inet_diag_msg *r,
 			s.has_ecn_opt	   = TCPI_HAS_OPT(info, TCPI_OPT_ECN);
 			s.has_ecnseen_opt  = TCPI_HAS_OPT(info, TCPI_OPT_ECN_SEEN);
 			s.has_fastopen_opt = TCPI_HAS_OPT(info, TCPI_OPT_SYN_DATA);
+			s.has_fastopen_child_opt = TCPI_HAS_OPT(info, TCPI_OPT_TFO_CHILD);
 		}
 
 		if (tb[INET_DIAG_CONG])
-- 
2.49.0


