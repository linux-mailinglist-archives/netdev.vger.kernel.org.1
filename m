Return-Path: <netdev+bounces-186317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65679A9E396
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 16:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D123B3617
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 14:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8714218C937;
	Sun, 27 Apr 2025 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJfI1nq7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CE61A26B;
	Sun, 27 Apr 2025 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745764624; cv=none; b=GALkU2DXqJ2FB1zfIj5iH8d+U/SB6/FmRSnzZJzurNVsa46jA3RNKxEYkO+mjgXmredW7j9+sd9z8quRzUIPXIUa1ooI/3hwOq12aKUq3z8xUP5WMXsGx7Y9abrnJ4S8/zr9KibztVlc7IBKmjEkJzh4Q03weXU1NyygDYVinbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745764624; c=relaxed/simple;
	bh=AMdLYG3+WT6NBLQbhEHdi3IVWXd1ydQkS0B2yNrUsqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hbbG4PKAZutyfXvuy4Ye8iy4sI3X1YRNX4f0YIqxuQark/ZR/UwdQCJQrkEXIB615h5juPABB8iXHQ1Iiawq6zpmWacUxiZcigOBZeLvNdw8MgUQl5+g/j18cNgRZxb8QbxIWQqZFrML1SH4Lz8pQsCQkJYjoTHQv6cp0hPJej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJfI1nq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C833AC4CEE3;
	Sun, 27 Apr 2025 14:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745764623;
	bh=AMdLYG3+WT6NBLQbhEHdi3IVWXd1ydQkS0B2yNrUsqE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=pJfI1nq7bGzPxvntNyepy15lbzZ9Mn2WgORpkQxHBSWFATuZc5F7OE1yp3GL6rB+i
	 wjJPLdrb9JzQCP8WffIGn/zl3GoCNqWYfJWW2RToZRsoFHz3zvB2a9MH0UkrtcZYH6
	 dpce3hIdojox8weJEtYnuqYW6MgVzaRlAj5X9zcCogb54hPY8WsQdCZjgdnVsONzhY
	 sPNg4R5z7BHHyqKAIu5RP1OE5D2TwEVgtLeYERsfM67qhTyKZN14FA3M4dDnEFidRc
	 DnIjs3HDN7dxMjVY9YTfsIKxFnhrrEkuypfnEckgDF9RImRXzFCgHZg+pz9wzAbk1Y
	 7dFXV0zFLoLNw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFEDC369D1;
	Sun, 27 Apr 2025 14:37:03 +0000 (UTC)
From: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>
Date: Sun, 27 Apr 2025 22:36:59 +0800
Subject: [PATCH net] docs: tproxy: fix code block style
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250427-tproxy-docs-fix-v1-1-988e94844ccb@outlook.com>
X-B4-Tracking: v=1; b=H4sIAAtBDmgC/x2MQQqAIBAAvyJ7bqHEiPpKdEhbay8qKmGEf086z
 sDMC4kiU4JFvBDp5sTeNRg6Aeba3UnIR2OQvRx7JSfMIfry4OFNQssFjdFaWyVHNVtoVYjU9H9
 cwVGGrdYPkk9mnmYAAAA=
X-Change-ID: 20250427-tproxy-docs-fix-ccbbbf42549f
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Levi Zim <rsworktech@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1174;
 i=rsworktech@outlook.com; s=not_default; h=from:subject:message-id;
 bh=cby+1jVkm77u6wkNVFnwY7Zel5ns9SwCbUFjdQo23d8=;
 b=owEBbQKS/ZANAwAIAW87mNQvxsnYAcsmYgBoDkEMC9YQa4pYiRQ4m8eDAv3pFcvx3SdQvUtxA
 t5FkHu8dVyJAjMEAAEIAB0WIQQolnD5HDY18KF0JEVvO5jUL8bJ2AUCaA5BDAAKCRBvO5jUL8bJ
 2KgHEADOuGO9cGsSUh1JGInQtQK/Nj56a2IhHlhvZbMELaEFp7sz389+1psGnMqwmAtijjz311F
 ScH6yNQ01ox8XzUj/zHbhP7+5d3yXT1KMuyArrVWYwWkQ/3rPfOqtNxNNBTNCWVdqaW5RzT9Y+f
 u2BdaEPreaXeVkTsu5ze6vTout+y31EDzPihMqgKu5NZL6XsHt9QDSCSi9MeBCCFDpSZKzKGjrP
 9zwR17lLhc37Z92qsSKVl+p5LOdXwAzFM/XqTTFHji1p6HUME/ygaR2RyeAfU8D1tq0Q5bSsXfm
 av6DyFc+rLqnlFAiEYA3gmjS6yndiWJOkMLPYv91+qPYAJr0pa47DCtJeH9VpXOrZhRJXlZVpNI
 4aTZsHYqPLYPYHxecSGDJlE1v7m4jq/X2wrogJRqr/9AOES0OyRkWbtW22XPYKvW250yW+LrNB/
 Z/sY7utlfFRSLxPBVBHBMB24bxoeornVdZUwYV75RrtiSHCspMbgq/T3phsT2lj5+t8s2Ti0wRA
 2XBXggkU5sPTaJDdqeei6a9GoAYNWlykcG+9/wU6LFx/CDDKFJS7t3pbPoW2oFINQMHjucyAsIY
 A2HVmOQ5+2x/jKEpgyjIG10C28uZDKp0YWCp1McjMBHaQahP2kXS0PQE2t+Q7GxTfLR/09LvjfQ
 IchJaG0Q92+xFyQ==
X-Developer-Key: i=rsworktech@outlook.com; a=openpgp;
 fpr=17AADD6726DDC58B8EE5881757670CCFA42CCF0A
X-Endpoint-Received: by B4 Relay for rsworktech@outlook.com/not_default
 with auth_id=390
X-Original-From: Levi Zim <rsworktech@outlook.com>
Reply-To: rsworktech@outlook.com

From: Levi Zim <rsworktech@outlook.com>

The last command is not indented thus does not show as code block when
rendered. This patch fixes it.

Fixes: 4ac0b122ee63 ("docs: networking: convert tproxy.txt to ReST")
Signed-off-by: Levi Zim <rsworktech@outlook.com>
---
 Documentation/networking/tproxy.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/tproxy.rst b/Documentation/networking/tproxy.rst
index 7f7c1ff6f159ed98d96c63d99c98ddbaefd47124..102c030e3cf06d6e9607f7668b417b99a3a62300 100644
--- a/Documentation/networking/tproxy.rst
+++ b/Documentation/networking/tproxy.rst
@@ -71,7 +71,7 @@ add rules like this to the iptables ruleset above::
 
 Or the following rule to nft:
 
-# nft add rule filter divert tcp dport 80 tproxy to :50080 meta mark set 1 accept
+    # nft add rule filter divert tcp dport 80 tproxy to :50080 meta mark set 1 accept
 
 Note that for this to work you'll have to modify the proxy to enable (SOL_IP,
 IP_TRANSPARENT) for the listening socket.

---
base-commit: f73f05c6f711fd1628c7565441b9febc0c4d6c58
change-id: 20250427-tproxy-docs-fix-ccbbbf42549f

Best regards,
-- 
Levi Zim <rsworktech@outlook.com>



