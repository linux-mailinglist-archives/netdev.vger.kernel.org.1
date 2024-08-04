Return-Path: <netdev+bounces-115574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C8394706C
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 22:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0EE281172
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 20:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D695813AA3F;
	Sun,  4 Aug 2024 20:34:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B44422095
	for <netdev@vger.kernel.org>; Sun,  4 Aug 2024 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722803657; cv=none; b=QLtfz7tBRBHkTTcYif0yRv8bZWS4W4/KjeO5Umld/okhltPz2Fl2izBl+Pl93qFsgIH8dfyhG04e/9bMavhE5E8dK8svrCuSB9dHm8yLuEUX1YQpw4XvRbChXy5Kxz4jr0qfke4EG8M1M8+iTLG/KhlqD9BHpNXy4qWuFqqlKb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722803657; c=relaxed/simple;
	bh=fo/aAzTagPQ5AORcwTWW6iTD0jvWkAaUARPvfgT2GWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fypf1pPYawqwN1X59vs8F49M2sWSpWvEtplYtZkf3TjeInVLzDs5Y+gdihL6+hjeEBFj6vUHFhQalSaYYy1uJnbhVyqW8gE9gLzO2ky8u07Tym2DAco9HwA3BWB2IUFdt76OiGLmFaVZaOlCTD0l6fdqyN3ScnVkaf1/sVgoX04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.big (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 25BBB7D120;
	Sun,  4 Aug 2024 20:34:09 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v8 03/16] include: uapi: add IPPROTO_AGGFRAG for AGGFRAG in ESP
Date: Sun,  4 Aug 2024 16:33:32 -0400
Message-ID: <20240804203346.3654426-4-chopps@chopps.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240804203346.3654426-1-chopps@chopps.org>
References: <20240804203346.3654426-1-chopps@chopps.org>
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


