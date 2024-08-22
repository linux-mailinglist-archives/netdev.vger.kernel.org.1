Return-Path: <netdev+bounces-120824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2EC95AE5D
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 09:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71BBF1F236F4
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 07:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72B813B2B0;
	Thu, 22 Aug 2024 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="qa2XUw+h"
X-Original-To: netdev@vger.kernel.org
Received: from msa.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2882D17588;
	Thu, 22 Aug 2024 07:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310216; cv=none; b=A92OTalOY9zBOe/f4ZzPLCpcN+48hSxw0Q3AQR+jlHfv7vl6uPHuKJLeVJMNdkl9KFYkYwMUdHxio/zBIfbssPfgLvEg90HNScqo7DIAuuoAFO3MjAmBgWD3VU94k1LnUzQ21YuiJfQc7oZIDvnjlFoQFGOZtD+9qL7hfWtmV5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310216; c=relaxed/simple;
	bh=Vv+JFD2CzkTAfMbhy5w7mtzbTJmq3u64ky+VpulKiJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZP7DW23cGGnAlzIVHvH1u7C0fzmuWP9ofwHIom+IcPyuQN/m1zkww6d6TB/cZZRGxXPnxpddRVEgjK1Y3W0eFkB+VCRW282MPIlyed/86TQAQo4p/PhTM/GluzFoz0hwYUhvKiY+j+03jIsfjHYJ/D/bHA7wZnu+wwDpdcfsm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=qa2XUw+h; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id h1qusCYiPaOqrh1qusvPyJ; Thu, 22 Aug 2024 09:03:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724310205;
	bh=gZvRex1A2ur/vW3xkDlKJFyOKmg+Ssh3nUW61ACjodo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=qa2XUw+hB59f6aBnAOE7dhU+6z8YPgMBDhVlcrHfSDrWLignA2FykA27UFVEoSpDR
	 A01QotHlUfRwZzm7HUdTC7kMVuidHF4+hilRle7d9CE4yOuwlQ8CdiO240iSWp1Dzp
	 Xk5v9JU6CMSnsJZuinGO1hlMUoWE1VxAwoL7I8sf2FXGDuTTJo5XXdneX7J+5dYbli
	 r5c6y8c4qhZ+Gxip3l95Z8g/N/xAp0DZKJHuY/s2BIf4S3L/vVuap5BUfClUSjztjg
	 4Nj09kIF3yQuGdv3rseAYuFKZL8QjG7Vrml/C1z93GCcmbOXdxjs73twIyjoEIE57I
	 CWID5j5U929eQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 22 Aug 2024 09:03:25 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: netlink: Remove the dump_cb_mutex field from struct netlink_sock
Date: Thu, 22 Aug 2024 09:03:20 +0200
Message-ID: <c15ce0846e0aed6f342d85f36092c386c6148d00.1724309198.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5fbf57a937f4 ("net: netlink: remove the cb_mutex "injection" from
netlink core") has removed the usage of the 'dump_cb_mutex' field from the
struct netlink_sock.

Remove the field itself now. It saves a few bytes in the structure.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 net/netlink/af_netlink.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/netlink/af_netlink.h b/net/netlink/af_netlink.h
index 9751e29d4bbb..5b0e4e62ab8b 100644
--- a/net/netlink/af_netlink.h
+++ b/net/netlink/af_netlink.h
@@ -41,7 +41,6 @@ struct netlink_sock {
 	struct netlink_callback	cb;
 	struct mutex		nl_cb_mutex;
 
-	struct mutex		*dump_cb_mutex;
 	void			(*netlink_rcv)(struct sk_buff *skb);
 	int			(*netlink_bind)(struct net *net, int group);
 	void			(*netlink_unbind)(struct net *net, int group);
-- 
2.46.0


