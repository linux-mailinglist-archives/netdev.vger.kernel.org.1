Return-Path: <netdev+bounces-238935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F46C61664
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 14:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A685F342FC8
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 13:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E922F30BBB8;
	Sun, 16 Nov 2025 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LyrSnY0u"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8512FB97B
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763301427; cv=none; b=oHtNMJeE8pFymFJn93JaYFkhlFi7Ao2iDP46PROSOS4kUSzBo+k9lJw0vk9mCPm68lO95yvE64lQToKHYhU4uyNYUPCOtq0TGyo+d5yIUb5q6Lnw2/vvDa9BY+GExGXFgeD06Q4VCzDJd7aza1cEpWH6yDFhOowvWEI4oWbiokI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763301427; c=relaxed/simple;
	bh=Ce3r/sNkmvQEXMVs80OF8wek+rz/HV9/6yMbSqdRpwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sd3iB2lHdBMkRVHzgsddknIWR1Jkb8ttacxkLuweiDCGKuB+VX0VUSAO0dzk3UjurWCfbF+ntBWesY088c7hT7MzbJfWqWU7B1J8ncKt00OWVpBfxv/8oOCHEniGYDqypoqdiOmv6JRLUIwMmFd1zQeAH27ZQeWLOXnmnYnTnzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LyrSnY0u; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763301413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UK4KkZMi52vFpPVQH9xJ9cPLLWOqmeTLtnULXZYL35Y=;
	b=LyrSnY0uxc3uNpRAlmynVfQHHt8YsYseGqF+byazFB6YYPaakb00NjK82y6rPSa4Gun9Ll
	xi75TrZRpDmflTipuiKrfTXQLB/e+fBEVGXb1d+BBd/r9ockW3Qnf6PRTsdYRjP6xXIaal
	3J2Bkn3n5cdnfZU6FC1bmdlYEbjuDnU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] kcm: Fix typo and add hyphen in Kconfig help text
Date: Sun, 16 Nov 2025 14:56:14 +0100
Message-ID: <20251116135616.106079-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

s/connectons/connections/ and s/message based/message-based/

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 net/kcm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/kcm/Kconfig b/net/kcm/Kconfig
index 16f39f2565d9..66660a06cacf 100644
--- a/net/kcm/Kconfig
+++ b/net/kcm/Kconfig
@@ -7,5 +7,5 @@ config AF_KCM
 	select STREAM_PARSER
 	help
 	  KCM (Kernel Connection Multiplexor) sockets provide a method
-	  for multiplexing messages of a message based application
-	  protocol over kernel connectons (e.g. TCP connections).
+	  for multiplexing messages of a message-based application
+	  protocol over kernel connections (e.g. TCP connections).
-- 
2.51.1


