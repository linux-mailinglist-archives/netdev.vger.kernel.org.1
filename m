Return-Path: <netdev+bounces-116596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBE394B1DE
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 23:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBFA51F20FFE
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 21:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04270154C17;
	Wed,  7 Aug 2024 21:14:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693D014D29C
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065262; cv=none; b=Ef9qi5O5l46ebWBVxTHWk9vsLdV7FGEJHQU7KGde1b+0W6GhTDxd+kj9hWwtXLFhf6sJHJ3fQHgG2D2MHGVapfJnWyqM/y3of39736DPDGwGWBw1nRf1v6KWX+YwYp7QcOG0giQ/t8j3Lif511i5hTL1m9fa3p97AGyWQxoERkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065262; c=relaxed/simple;
	bh=fo/aAzTagPQ5AORcwTWW6iTD0jvWkAaUARPvfgT2GWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5MHVIFlA4rZO4sTJXFEBKYdayKeAAWJiOyNPkQbItyRthgmMdU6rrg+TaCkUgUudp5AQRm5JaOl8kBEnYyDJvqntZR/jjLpNacjQ/G3/kxniDIQNLDFoYVyoyhOS95uB0rxQjEL2SmJ/dR2M1RfgJtDZg6Hf/HLxeoDN+IEXKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.int.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 93A0A7D125;
	Wed,  7 Aug 2024 21:14:20 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v9 04/17] include: uapi: add IPPROTO_AGGFRAG for AGGFRAG in ESP
Date: Wed,  7 Aug 2024 17:13:18 -0400
Message-ID: <20240807211331.1081038-5-chopps@chopps.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807211331.1081038-1-chopps@chopps.org>
References: <20240807211331.1081038-1-chopps@chopps.org>
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
index d358add1611c..268086e85d04 100644
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
   IPPROTO_SMC = 256,		/* Shared Memory Communications		*/
-- 
2.46.0


