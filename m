Return-Path: <netdev+bounces-139337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5F69B188D
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 16:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615082824BC
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 14:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA29BA947;
	Sat, 26 Oct 2024 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="dsVoWrTd"
X-Original-To: netdev@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-80.smtpout.orange.fr [80.12.242.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547911CD02;
	Sat, 26 Oct 2024 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729952285; cv=none; b=JG+ACACrCL3IV+478/n/E7cgYzTS2KkOLC8O+s171HbSNFcCpDePsPxbf951Ws0jTLu8v0GyoChZMmIzJbso88rbA4Q/VZVA7+w/LenpW2gxeRPbHUOxQlzN1Y+WVwvcjREwsT/NV2DjqAuCsnV24VZYiuNFvjR0q3Yj5J05hbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729952285; c=relaxed/simple;
	bh=jtWRxub02rdof1ec5Ogg81M3zByqJ57Q0EX9sND/TsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rH88QZUuyhzpgTkzWXe2NjcR34Lap0Ho7pPuFm8PEXHUx4/Hv357JZh+pDN5SspR1bh4VgmSiddIlIYV1kMVf4j0e7ujEDF58HsX+/c0s1gF8lm0WSET6u72/V0RznCe91dbOajrPz1tIuOlPVKIDniDvzBR0DaeWFwK0nCY87c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=dsVoWrTd; arc=none smtp.client-ip=80.12.242.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 4hc0tVIwCjP4T4hc1tRohz; Sat, 26 Oct 2024 16:17:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1729952274;
	bh=FfHm9nyVFxciJ4tCIjF7CcDaV35P+oGeXqN4ax4+YEs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=dsVoWrTdpJFaKRccvNFr4mvq07bOikx2VohX5J2zEGwa8IdsGn8HOhyDBHh9r4oGK
	 4cTwhm/xkqS9LxmdTYDn3axB8UXT9gjcNHNqF6OyeG81vMytHenm5W22fwBbmLa5N+
	 SOX2YQMuWJI9U0h6O7w4e0s0T6T69VDvqw46Pp1HxmlDDXByx/0vy24fr25fPMtPgZ
	 QecGK7SDAa3dm07DqLAamBrx0TDnJ+I2KP7i4T5IScGPbhJ7wb9WPik6kXPvwom6AW
	 y6hd5baehF6dJnb86qRK2+/uuvETBGY6c5ujg1ToCshT5e6zdCxlVobDerD1Zn5UOh
	 bfFRU1inqJ7Ew==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 26 Oct 2024 16:17:54 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH] rtnetlink: Fix an error handling path in rtnl_newlink()
Date: Sat, 26 Oct 2024 16:17:44 +0200
Message-ID: <eca90eeb4d9e9a0545772b68aeaab883d9fe2279.1729952228.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When some code has been moved in the commit in Fixes, some "return err;"
have correctly been changed in goto <some_where_in_the_error_handling_path>
but this one was missed.

Should "ops->maxtype > RTNL_MAX_TYPE" happen, then some resources would
leak.

Go through the error handling path to fix these leaks.

Fixes: 0d3008d1a9ae ("rtnetlink: Move ops->validate to rtnl_newlink().")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 net/core/rtnetlink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 194a81e5f608..e269fae2b579 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3829,8 +3829,10 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	if (ops) {
-		if (ops->maxtype > RTNL_MAX_TYPE)
-			return -EINVAL;
+		if (ops->maxtype > RTNL_MAX_TYPE) {
+			ret = -EINVAL;
+			goto put_ops;
+		}
 
 		if (ops->maxtype && linkinfo[IFLA_INFO_DATA]) {
 			ret = nla_parse_nested_deprecated(tbs->attr, ops->maxtype,
-- 
2.47.0


