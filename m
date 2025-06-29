Return-Path: <netdev+bounces-202256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE9CAECF3D
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 19:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031EC3B2068
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 17:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB30A238C1F;
	Sun, 29 Jun 2025 17:32:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71FC23644F;
	Sun, 29 Jun 2025 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751218369; cv=none; b=IlNdG9/6OfUH4wVxtSKVuMHqZbi5+MYBOLxsgblT2/fm/lM6Svc2hucXtKywZxiN3eIjXwtzPdOs57qAHan33W3wQqeRtRn9K5KYo40UAkhWbi3es1nh1SeWYQiPTIUyRS40Ta+ed8hN4GzIpKDOem6UmbI2R4qUmB7lD6MKRnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751218369; c=relaxed/simple;
	bh=cIg8W5VRbdSoa02zEehBGrMAUAxzldtjxXTbyZolGWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DSU2DUwQcnP6PoLli+CxsrL7EZjFIUzAgREB2U3ll0dNtYq+zYcp1JWAAzpxUg6EXKNhex6JNmapyurUua/wWM5L3IgST7Rv6mM8wPnYG/OG+8gDBNmRL4lV3qbQLAIP+35JFvm+bCyPhQp0o+LmFcE7rXgncgyxqWmAFUzom4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 55THDW59007121
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 29 Jun 2025 19:13:51 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
        Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [PATCH net-next 1/2] seg6: fix lenghts typo in a comment
Date: Sun, 29 Jun 2025 19:12:25 +0200
Message-Id: <20250629171226.4988-2-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250629171226.4988-1-andrea.mayer@uniroma2.it>
References: <20250629171226.4988-1-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

Fix a typo:
  lenghts -> length

The typo has been identified using codespell, and the tool currently
does not report any additional issues in comments.

Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 net/ipv6/seg6_local.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index dfa825ee870e..4834d72624cf 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -2087,7 +2087,7 @@ struct nla_policy seg6_local_flavors_policy[SEG6_LOCAL_FLV_MAX + 1] = {
 static int seg6_chk_next_csid_cfg(__u8 block_len, __u8 func_len)
 {
 	/* Locator-Block and Locator-Node Function cannot exceed 128 bits
-	 * (i.e. C-SID container lenghts).
+	 * (i.e. C-SID container length).
 	 */
 	if (next_csid_chk_cntr_bits(block_len, func_len))
 		return -EINVAL;
-- 
2.20.1


