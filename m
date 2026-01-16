Return-Path: <netdev+bounces-250489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 475A3D2E684
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 10:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED8C530319E0
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 09:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F1B3195E6;
	Fri, 16 Jan 2026 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RmGekOLv"
X-Original-To: netdev@vger.kernel.org
Received: from sg-1-100.ptr.blmpb.com (sg-1-100.ptr.blmpb.com [118.26.132.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ABF315D5E
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768554061; cv=none; b=LvPPb0gojWMMM+FbFx0uRXO3ok7d85lYagehncJemc5ETeSwTUaw1lE989txwxoZyy8tVgasSlBoZi0BK17Mj+onsalmgyA00zYc5pM7c+jwrTxh/WlU3LdrX0R3RSM1LV2zfDsnY4q9GH60PWGlFV4N1z8O65QZtGtfwx/uzNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768554061; c=relaxed/simple;
	bh=IBmjbagocmJ9iGW7lk723ZSZSjFnJHaMo4tb0blUCpY=;
	h=Cc:Message-Id:Mime-Version:From:Date:Content-Type:To:Subject; b=py1sWzaCjmcbyczOAgw5S0LeXa6BoVxI4unk4nGy9qG1R+agOIDzDhxEx5L0QVJRm3FCwGcgmW4MKrS1swmLQilyXy1RjD/F7Xmf1dAG9axvbJnvsBPXxRAmTc/4GZxe9cZ/VQ4XV/RCw5+5u2e2PkfrLiU0iLazfddztHUsEAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RmGekOLv; arc=none smtp.client-ip=118.26.132.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1768554047; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=gEAbDEshLLvI/0G0NT/5J/9UIZkAr/WLQxSLTPcAsoU=;
 b=RmGekOLvMAwAQpZBL1mbX3kidN2xrgvYR02q+JOZYTVzC+WKJyn8MTThCJb/FUkDMAvTnn
 +w298o/T0eseEfyMz9yMUeNhFYFdeNynONyVeLNwGtSyhAbrT//EJgOTRzMrB6rKF/NStR
 VU1okpREA3kyO4Ro53DCZYG1E6gZ5noaEBK9KoeWMD2Ids87o1J+Jns/wp7+znPflzs2V2
 WDQaNNYZGIvN01ZquzzyYu0rOWfzOqxlgRyc6pLC5+WIBcV9VNARFfhl1X7FVJJlyFihjC
 QoaMPF99fJKGgfNxR60yK3ZdgFLrjeHMwJuQPnL/Pba6CmPnPbj1ehDw0/NLsg==
Cc: "Simon Horman" <horms@kernel.org>
Message-Id: <20260116090032.1952063-1-zhangjian.3032@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: "Jian Zhang" <zhangjian.3032@bytedance.com>
Date: Fri, 16 Jan 2026 17:00:32 +0800
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26969fe3d+1427d7+vger.kernel.org+zhangjian.3032@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: "Jeremy Kerr" <jk@codeconstruct.com.au>, 
	"Matt Johnston" <matt@codeconstruct.com.au>, 
	"Andrew Lunn" <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <mkl@pengutronix.de>
Subject: [PATCH net-next v2 v2 2/2] net: mctp: support MSG_ERRQUEUE in recvmsg()
X-Original-From: Jian Zhang <zhangjian.3032@bytedance.com>

This enables userspace to retrieve struct sock_extended_err for
locally detected transmit failures, using the standard socket
error queue mechanism.

At this point, only the generic errno information is reported.
No MCTP-specific control messages or extended error details are
provided.

Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>
---
 net/mctp/af_mctp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 209a963112e3..353599812a0a 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -291,9 +291,12 @@ static int mctp_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	u8 type;
 	int rc;
 
-	if (flags & ~(MSG_DONTWAIT | MSG_TRUNC | MSG_PEEK))
+	if (flags & ~(MSG_DONTWAIT | MSG_TRUNC | MSG_PEEK | MSG_ERRQUEUE))
 		return -EOPNOTSUPP;
 
+	if (flags & MSG_ERRQUEUE)
+		return sock_recv_errqueue(sk, msg, len, SOL_MCTP, 0);
+
 	skb = skb_recv_datagram(sk, flags, &rc);
 	if (!skb)
 		return rc;
-- 
2.20.1

