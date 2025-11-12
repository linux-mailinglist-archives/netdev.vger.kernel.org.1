Return-Path: <netdev+bounces-237945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2621EC51EFD
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 12:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7523A28D3
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2909E2BE7CD;
	Wed, 12 Nov 2025 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="SZ82cxxu"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tkos.co.il (hours.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6151B2E8B83
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 11:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946247; cv=none; b=JE2AVKxetO+EYXfaaDxucWV8ET2al6rrg+w7237OLWVxtmacirOJT1NygSgA1OC6Z6SugSBK9Cv3NtyYmNV/eKHbAf01fLnsPtpmhH84dPcT6mJTzrd1R75BPCPYFnuWm7SgO5DWBU6N6TJpIs/2OSzJdXUqo0KiI72+LtrOM+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946247; c=relaxed/simple;
	bh=5LFo/MPV5qIXlFzvyYlpX+RzaHRnyvm9DLr7lV1nwws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UNZBW/sMD7LbcNCjFVV508AU6xe9ylXv4ueNocXmbk4ysadEmE7w0vcXCLuV/YipTuxGNBGBs/aRI5L0i66V27WZmYpbnlYMGKqAIw/0rNqtVU1RLNd2cwMMnu3Qeq37syv4vOT0A6TShOZYOqb7Rt8ycO1igOC2xdKtxJ4F8OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=SZ82cxxu; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 55961440A92;
	Wed, 12 Nov 2025 13:15:32 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1762946132;
	bh=5LFo/MPV5qIXlFzvyYlpX+RzaHRnyvm9DLr7lV1nwws=;
	h=From:To:Cc:Subject:Date:From;
	b=SZ82cxxuN5DTfh6QET1/KVYGq6ErKntjbDHDnPhvxQNm6alRsnVwWAD4MXN0DLUX1
	 vaT/AFJgvoh1kWuyVWbv0SmVztV/I5CktiFXtyVEkGchAkh3NhqakcZWUGzZqL5Zzq
	 7kXU3aIjvsaQXNM3GZYKHIEgkqLle5qmxmD4UZDqpMe2B8TwV8BPInKfzlr7dWkX88
	 V+kZ7We/+U7uMe+zjWsB32g8Kez1rSLHULMvFU7ZKqtNQNloqAqLJIujsgFgqlHIR9
	 UUq48y+J2sZqVVWY7EjRrSxFV8APFzClsD3c2DT65nrSXQuPbEhDV5Gzd93bXb7f1Q
	 oiy8OcRMJCkag==
From: Baruch Siach <baruch@tkos.co.il>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] MAINTAINERS: Remove eth bridge website
Date: Wed, 12 Nov 2025 13:17:03 +0200
Message-ID: <0a32aaf7fa4473e7574f7327480e8fbc4fef2741.1762946223.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Ethernet bridge website URL shows "This page isn’t available".

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f0c8b85baa6b..c79c182aab41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9264,7 +9264,6 @@ M:	Ido Schimmel <idosch@nvidia.com>
 L:	bridge@lists.linux.dev
 L:	netdev@vger.kernel.org
 S:	Maintained
-W:	http://www.linuxfoundation.org/en/Net:Bridge
 F:	include/linux/if_bridge.h
 F:	include/uapi/linux/if_bridge.h
 F:	include/linux/netfilter_bridge/
-- 
2.51.0


