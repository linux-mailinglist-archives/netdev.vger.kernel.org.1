Return-Path: <netdev+bounces-152081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE79A9F2A38
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 07:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02BF6165667
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 06:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCD21C4A3D;
	Mon, 16 Dec 2024 06:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="YTtVwuZf"
X-Original-To: netdev@vger.kernel.org
Received: from cvsmtppost23.nm.naver.com (cvsmtppost23.nm.naver.com [114.111.35.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2662F9D6
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 06:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734331011; cv=none; b=nhYfeXdl+0cGfscSCQOiYvnOKdk3tIi6UMjFHzsSC2SjOr1fzwl7cxEMxElKPqqFKW2kk7PCeW8fb/TH4wJM1WHr2+dFxn5VaxSNzJjDsJeXffg76ZGaAzWdQs09GrddMsvIJQCmmc/BcQ8NXykfsqNDwSt9I8DIBtZxFe4f6YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734331011; c=relaxed/simple;
	bh=ayZS94VE5tZVTwJ9DpvjUG9tb4ws5zhFpr6/AsctdA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ghzYbFqFuOFxXD707tKhjvBt9FbCyoRgaeHhdgWMnAWmxrhuenIHArOyAV8ynRdxIMRwcPVaDyq2tN9q6d6ZObooP1nXYAzino8W8dxYEPnfiGvMeNr/5+pFHK/TP+w8cd6XpkR1iJpN182bdhuE19LFBw3QRgdrw4lNPTvdGOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=YTtVwuZf; arc=none smtp.client-ip=114.111.35.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Received: from cvsendbo011.nm ([10.112.22.32])
  by cvsmtppost23.nm.naver.com with ESMTP id Kc2WQyJwQJ6CnbuBOBbz7A
  for <netdev@vger.kernel.org>;
  Mon, 16 Dec 2024 06:16:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1734329793; bh=ayZS94VE5tZVTwJ9DpvjUG9tb4ws5zhFpr6/AsctdA0=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=YTtVwuZfTzfvUI7EdrIeBuQZSdn3hD0hvhNWwihmv7Zk4pIwvz3SiA6PiTaEWYd08
	 wjn6lh+hwZPJu45uP7zE924KboUrZc7AycGhZVVx/HGn77S7LVZmUvlJ28gGEsR/ed
	 rLirSWnZJWPiemUIdH+XKPBMdWxSnHCAnySq9Gk+21lqpLKgK3Lt6qxgqGYxs65XPs
	 oMXHiIvSQLlCVJrn5C+t8lD3rzPZpCnCfgyJY6RXXLZyxfmr4nil76cQ+Q/SKeKJlb
	 jxGGKEusroad4JWuJLUugHT21M3THbD2kGnvMLeZnSEDP0+SKzUAuWqgZk39llseMR
	 owCR1bWhH6QJg==
X-Session-ID: nez-X4wiQqaQCni22iXOzQ
X-Works-Send-Opt: pYb/jAJYjHmdFxb/FxJYFoKwaBwkx0eFjAJYKg==
X-Works-Smtp-Source: PdblKotqFqJZ+HmZaxKX+6E=
Received: from junoshon.. ([59.10.11.192])
  by cvnsmtp009.nm.naver.com with ESMTP id nez-X4wiQqaQCni22iXOzQ
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Mon, 16 Dec 2024 06:16:32 -0000
From: Junho Shon <sanoldfox@naver.com>
To: edumazet@google.com,
	davem@davemloft.net
Cc: dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	junoshon <sanoldfox@naver.com>
Subject: [PATCH] Staging: rtl8723bs: Remove unnecessary static variable initialization
Date: Mon, 16 Dec 2024 15:16:25 +0900
Message-Id: <20241216061625.2118125-1-sanoldfox@naver.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: junoshon <sanoldfox@naver.com>

Fixed a coding style issue where the static variable '__tcp_tx_delay_enabled'
was explicitly initialized to 0. Static variables are automatically zero-initialized
by the compiler, so the explicit initialization is redundant.

Signed-off-by: Junho Shon <sanoldfox@naver.com>
---
 net/ipv4/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d704bda6..b67887a69 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3498,7 +3498,7 @@ EXPORT_SYMBOL(tcp_tx_delay_enabled);
 static void tcp_enable_tx_delay(void)
 {
 	if (!static_branch_unlikely(&tcp_tx_delay_enabled)) {
-		static int __tcp_tx_delay_enabled = 0;
+		static int __tcp_tx_delay_enabled;
 
 		if (cmpxchg(&__tcp_tx_delay_enabled, 0, 1) == 0) {
 			static_branch_enable(&tcp_tx_delay_enabled);
-- 
2.34.1


