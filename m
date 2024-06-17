Return-Path: <netdev+bounces-104255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797A190BC6A
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 22:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EAD11C23BA9
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 20:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B661991AC;
	Mon, 17 Jun 2024 20:54:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716C8EEDD
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718657661; cv=none; b=mfn5hQ65+yiwd2ecFcI1XqB42vauViI4ZaenRZmYN/WHZQO0nG3R/Fe+IYLSfydCDC00fgS1SflvI6zjs6ZiOX15AYuO3ITE8FgWaq4rayN3OJh1jTtq01bvkd3r7kDZBqaG2eHeC6w4Vrx88S79yM4uwomfKpWCz4jhuAluzpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718657661; c=relaxed/simple;
	bh=GKpg9IJjH78nB51uF4mTHZ1YxmUdjplj4h7OoAr7Aq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnVHsgJxzBp4lUiQ1E+2KuNMYBD/fwKOSI++7noGBWdjJ5E3tiUjOf5opGVuFIRR2eivStF8dRMFXecwfCjhyoiDm7Ori/+mH4XdUXJ0353Vek2az4lw4x/dlycDDcZVTQbGQ+7TXxjlST9CVIUuO/DfmN0Cg9ucFqVcSrgfI+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.big (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 90BE87D097;
	Mon, 17 Jun 2024 20:54:19 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v4 03/18] include: uapi: add IPPROTO_AGGFRAG for AGGFRAG in ESP
Date: Mon, 17 Jun 2024 16:53:01 -0400
Message-ID: <20240617205316.939774-4-chopps@chopps.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617205316.939774-1-chopps@chopps.org>
References: <20240617205316.939774-1-chopps@chopps.org>
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
2.45.2


