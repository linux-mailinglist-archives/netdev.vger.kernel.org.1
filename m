Return-Path: <netdev+bounces-120820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD5B95ADF3
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 08:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4102840B8
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 06:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1FF12B143;
	Thu, 22 Aug 2024 06:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="pIBOMqcw"
X-Original-To: netdev@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-81.smtpout.orange.fr [80.12.242.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B1881727;
	Thu, 22 Aug 2024 06:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309306; cv=none; b=dd6j4aOYJT4DF+ZnMKAqtwvx66DQZ3gGMp8YZJ1pXhPiJ66Wl4wUDhS+SnyxLphSIGelr9F1TKeu9BOHSjS1Nu4UNKKHpSG+VTgh/WtCnNhlKnTMtY2XM2FB/mzVtPZwoGdUTl6kUnf2ySrchv+kP+1u0isjrnY52F1bjGj4Auo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309306; c=relaxed/simple;
	bh=Vv+JFD2CzkTAfMbhy5w7mtzbTJmq3u64ky+VpulKiJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mLr9b1NA7yzQhg2GrQ3UE3uKqYGkjXYEDO+z1G/2eN17o3suB1mRjlwlkr0FPeOLeTSiFXvt4voAzdmio2Rq5wrTt98lu+TAojQ7zFybgj7xz4bVy68lyoguxa8mRfp0OfUCKkhVbnkegWOFNGVfoDERsiwN6/J3eQd/Ys35LdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=pIBOMqcw; arc=none smtp.client-ip=80.12.242.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id h1cJsOmCubNNsh1cKsvK1R; Thu, 22 Aug 2024 08:48:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724309301;
	bh=gZvRex1A2ur/vW3xkDlKJFyOKmg+Ssh3nUW61ACjodo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=pIBOMqcwXP0nUBUNua+0sxM4VSHBxoTg7p6ZZJhLl4ThgGCnhyueJmg+Pc/E8hol5
	 4RjAd97yCultEiBCQAkUl6J16ZpvSd7epGKJVE5QVQWhrHH2eIWnTPXqpsGGMPAaSg
	 gemmynbBiz5lQTHN5AZdHnavWolp+FcwEBXLHax0smFq3QgG/C2OjUcK3musLpTC8+
	 bbUIfU1jPTAHlEY1qrODHs1oYb3WohRki2ARzeN7SJC/vHp6Edb9zoNPvUgNAsWkdZ
	 XCdIIhu4PoRFtr2we1woMVeopZq6iF8caWKDmSVK0fkgyQLYmfpJsKagNn+95gz4ik
	 vcVoE5MUUiKCg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 22 Aug 2024 08:48:21 +0200
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
Subject: [PATCH ne]t-next net: netlink: Remove the dump_cb_mutex field from struct netlink_sock
Date: Thu, 22 Aug 2024 08:48:15 +0200
Message-ID: <c15ce0806e0bed66342d80f36092c386c6148d00.1724309198.git.christophe.jaillet@wanadoo.fr>
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


