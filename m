Return-Path: <netdev+bounces-132575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A56B99227F
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 02:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0197B1C21829
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 00:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A59FC0E;
	Mon,  7 Oct 2024 00:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Bap22FJS"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA90FB673;
	Mon,  7 Oct 2024 00:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728261915; cv=none; b=GwtwK2B9aJ3sarnDETyU+QMTL/O8KRhktiwiog6jmQE2OF2wFRvwJ4XWWopSa3Px9eBau0LuibJn5SUxG/dGgVR/kFHYEBtTi+wFugeYgPUak7wC6heoY5UX9l/Z1XJY3qR8ftHOdGeejomNo9QAUyLqLj3/vaS1/2GXVP9zRHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728261915; c=relaxed/simple;
	bh=H8OqcV6KRxOu+7D1RJFjqu6lPmk2W4BOLPu9fOpbKvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IVVIB4sTGXLlTeRCrWijze3kH3ZVpFPeO3dCMW423Dj3j0i4+MHdJEdZodqQiguZQ2yk0kWpxirZikpUBQVL+AqCaFCppr1+qEy6vBRWvLp6Dv2xvEwGPRdulbAf0kNsPSwVF/AmMwPkoZQCIKpOz+aV2FoWi5U5rtEsQL7KluY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Bap22FJS; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=9jWJ1UZITc9bWOf0H9Npf3l2Uylq93cTGCdkxH0jE5w=; b=Bap22FJS0cpn45Xo
	tsJSmeVwJLF+csvU9j+OQ5Q8fwUiO1LXlrW3O60/e2AlMb7cHnI4GB0ocjMA5kQT3bB0W6Z94g0IK
	7mk6qdSQouMmsKpEFMRcfn+kRc3u5xe3/KTAx0UpUZ4ngOwSu5FjQVp3XnAiKhVxMzRzY8cLRPsVC
	kIp0bIhhDygCf+UitK2zNWLfqjS46QYE7Sv2iK5KLn0YuNNzlpLZn92uVVacDfb+NBhSGKvE11M1R
	woMZ9D+33q1qaNHzCCF8914H0a7B0V06E5o2i3qkJj1qAPz74I24TyKFuF1ZRzHO5q+juMtnHecoY
	v288HEKap44DSRRLVw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sxbrt-009M2w-35;
	Mon, 07 Oct 2024 00:44:57 +0000
From: linux@treblig.org
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] caif: Remove unused cfsrvl_getphyid
Date: Mon,  7 Oct 2024 01:44:56 +0100
Message-ID: <20241007004456.149899-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

cfsrvl_getphyid() has been unused since 2011's commit
f36214408470 ("caif: Use RCU and lists in cfcnfg.c for managing caif link layers")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/net/caif/cfsrvl.h | 1 -
 net/caif/cfsrvl.c         | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/net/caif/cfsrvl.h b/include/net/caif/cfsrvl.h
index 5ee7b322e18b..a000dc45f966 100644
--- a/include/net/caif/cfsrvl.h
+++ b/include/net/caif/cfsrvl.h
@@ -40,7 +40,6 @@ void cfsrvl_init(struct cfsrvl *service,
 			struct dev_info *dev_info,
 			bool supports_flowctrl);
 bool cfsrvl_ready(struct cfsrvl *service, int *err);
-u8 cfsrvl_getphyid(struct cflayer *layer);
 
 static inline void cfsrvl_get(struct cflayer *layr)
 {
diff --git a/net/caif/cfsrvl.c b/net/caif/cfsrvl.c
index 9cef9496a707..171fa32ada85 100644
--- a/net/caif/cfsrvl.c
+++ b/net/caif/cfsrvl.c
@@ -183,12 +183,6 @@ bool cfsrvl_ready(struct cfsrvl *service, int *err)
 	return true;
 }
 
-u8 cfsrvl_getphyid(struct cflayer *layer)
-{
-	struct cfsrvl *servl = container_obj(layer);
-	return servl->dev_info.id;
-}
-
 bool cfsrvl_phyid_match(struct cflayer *layer, int phyid)
 {
 	struct cfsrvl *servl = container_obj(layer);
-- 
2.46.2


