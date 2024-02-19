Return-Path: <netdev+bounces-72844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31785859EF3
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1EDE2833A7
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 08:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D952224DD;
	Mon, 19 Feb 2024 08:59:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F5D2233E
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333164; cv=none; b=XfFlZoKfNcwDRYr1z/sAyGpRI8RqHDW+jceSJw/QaFDYUE8AnTxj1HUfOtIj9508szy6//7uzzgSf6j2+uWn0WtEnAbu9l+zT+QbV3+kTZbIXQbLSuy2EkcjCzI3qSbfDjniQ5MRofxaWXGndy5mTSxRbbuJb9NLcVu1TsaMhcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333164; c=relaxed/simple;
	bh=HE/V9kS7WgFzXdXjHTF7W8GsayFmTpWUz2+H4+Z5tA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdF/UaQUyF0Ev6oMUcsCFbUFAaPXkJhEEu2zyzlrT2O31JNR0euk++pZoXzaAgwSyddhH/YmBXJvHg4XpNbJuEQXQsQiau5GQL0Rj2W8pUZLsoqoANPd2UkWs5mYD4dPSWu/SI3fsdFrVxqylEaivUz/DmBUbci9fI8seITSrBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.int.chopps.org (172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 0A08E7D11A;
	Mon, 19 Feb 2024 08:59:21 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v1 3/8] iptfs: uapi: IPPROTO_AGGFRAG AGGFRAG in ESP
Date: Mon, 19 Feb 2024 03:57:30 -0500
Message-ID: <20240219085735.1220113-4-chopps@chopps.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219085735.1220113-1-chopps@chopps.org>
References: <20240219085735.1220113-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hopps <chopps@labn.net>

Add the RFC assigned IP protocol number for AGGFRAG.

Signed-off-by: Christian Hopps <chopps@labn.net>
---
 include/uapi/linux/in.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
index e682ab628dfa..e6a1f3e4c58c 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -79,6 +79,8 @@ enum {
 #define IPPROTO_MPLS		IPPROTO_MPLS
   IPPROTO_ETHERNET = 143,	/* Ethernet-within-IPv6 Encapsulation	*/
 #define IPPROTO_ETHERNET	IPPROTO_ETHERNET
+  IPPROTO_AGGFRAG = 144,	/* AGGFRAG in ESP (RFC 9347)		*/
+#define IPPROTO_AGGFRAG		IPPROTO_AGGFRAG
   IPPROTO_RAW = 255,		/* Raw IP packets			*/
 #define IPPROTO_RAW		IPPROTO_RAW
   IPPROTO_MPTCP = 262,		/* Multipath TCP connection		*/
-- 
2.43.0


