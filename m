Return-Path: <netdev+bounces-91642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D738B350F
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 12:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8D8DB21D3E
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 10:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5F5142E71;
	Fri, 26 Apr 2024 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="iFWZQcHu"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFC613D53C
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126521; cv=none; b=hKZWEw1VreEKw98+r2d+nCH8nt6gFFBilgYdkzVOCtXmTodEXAJj/3NEYDBfgkzJLYhtU6EVeEOZJwnsGK4eGqGiwet6d6tP8OSkCUVuSUBQZ68Kq2NNbbCeMcrO19oCU1PmxAWEGFmhcM5qhYwP39LrrbA5U1SVNV0q7ODwD40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126521; c=relaxed/simple;
	bh=vRX0xrQUTEOkPzWuB/UKZy+otT8bSpy+R4FljIsqLGg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i1HVU31/PUYLKfhO5F5SvLUY47LdrU36tzn0F8anuYYJvZktXcXHN4vEkhra/QkQ6kYLZAzeV4pGFMZ/ZWjFVk6ANYwkc97wVF7slIxC6CKtRUb+mIV56Mk5OMZfSE4viCd01rv1BFg7hcfx4FO/K4e+OFOTAZBlKJRmTtTynPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=iFWZQcHu; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: df3f35a8-03b5-11ef-93a7-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id df3f35a8-03b5-11ef-93a7-005056abbe64;
	Fri, 26 Apr 2024 12:15:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=UuRO8/U+TWVffrha6n59wfveKAbRU97I0Dr+5H03hlI=;
	b=iFWZQcHu9/vR7R5fbS6pBdPAOOjobb/R6qn9xqdsqFaCjiKO0wAYH7ARglaZjLvu67v3Ew/A4g2tQ
	 zrRaIC8vNbvLXflbdTaPAGqDuPRt7TE4snFXCUNzZhtpOInDHHZ0BLCc2OYT1QOWH/yRIIYWvPnhyd
	 FFUL3AmfOQMYwVQo=
X-KPN-MID: 33|LeLy5JY5Ae5thmB9N+vdGzH+7patoZVK6+SrKoEY5luh4VDPGcEpyipwXjhcHIj
 MoIn2atKKu5yh1XeQtJK6LBChppD1dBPUlNXVxUKCpCw=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|wtofzwZVVItXLiRbKiv9Qb+beLw8xo1B+f6ZLsos7gd+fw8F1dXeglAiWGJw2XQ
 zT7TDr3RYnHiVwyjVOWDgLQ==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id dee4c034-03b5-11ef-a4a2-005056abf0db;
	Fri, 26 Apr 2024 12:15:14 +0200 (CEST)
Date: Fri, 26 Apr 2024 12:15:13 +0200
From: Antony Antony <antony@phenome.org>
To: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH ipsec] xfrm: Correct spelling mistake in xfrm.h comment
Message-ID: <Zit-sTZoYp_JnQfd@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Antony Antony <antony.antony@secunet.com>

A spelling error was found in the comment section of
include/uapi/linux/xfrm.h. Since this header file is copied to many
userspace programs and undergoes Debian spellcheck, it's preferable to
fix it in upstream rather than downstream having exceptions.

This commit fixes the spelling mistake.

Fixes: df71837d5024 ("[LSM-IPSec]: Security association restriction.")
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 include/uapi/linux/xfrm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
index 6a77328be114..594b66e16395 100644
--- a/include/uapi/linux/xfrm.h
+++ b/include/uapi/linux/xfrm.h
@@ -228,7 +228,7 @@ enum {
 #define XFRM_NR_MSGTYPES (XFRM_MSG_MAX + 1 - XFRM_MSG_BASE)
 
 /*
- * Generic LSM security context for comunicating to user space
+ * Generic LSM security context for communicating to user space
  * NOTE: Same format as sadb_x_sec_ctx
  */
 struct xfrm_user_sec_ctx {
-- 
2.43.0


