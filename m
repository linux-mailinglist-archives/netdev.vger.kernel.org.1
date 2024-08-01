Return-Path: <netdev+bounces-114843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8AE944619
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 10:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15439281ED0
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 08:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94F316C854;
	Thu,  1 Aug 2024 08:03:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEE11EB490
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722499414; cv=none; b=oo0l7We8OpsMS/sOtxwL22GkpRg0OMWzMqEuSSqM3veNKgwuyXgifMrzReI2lbRLduItRRBZ+XQY6RM+MM6PpQnooL90v/6Za4vzvvVIrTJQGUj734iEaH19IyhLDwFH3xnmqUUQAtcw54UwdWU892EgsS/rb/WyxC3MfrtD2Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722499414; c=relaxed/simple;
	bh=fo/aAzTagPQ5AORcwTWW6iTD0jvWkAaUARPvfgT2GWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIljtfPMmR3y/UKf78mnSJo0eafrc2y0h6d8WJrENdbw0lcGm7G1xgRKjrAAL3UZBcbEaomXyoin3ZsHXmrQkwfVw3jItKwA5W1JLKQOXhtldYn/6So0SXmXx3h8HdnAaqvFYOhssXVtnIst3e1M/t1++qzxjoJSlY7jvc/L66g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.big (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 636AF7D122;
	Thu,  1 Aug 2024 08:03:32 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v7 03/16] include: uapi: add IPPROTO_AGGFRAG for AGGFRAG in ESP
Date: Thu,  1 Aug 2024 04:03:01 -0400
Message-ID: <20240801080314.169715-4-chopps@chopps.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240801080314.169715-1-chopps@chopps.org>
References: <20240801080314.169715-1-chopps@chopps.org>
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


