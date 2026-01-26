Return-Path: <netdev+bounces-253330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOIzDWIId2lGawEAu9opvQ
	(envelope-from <netdev+bounces-253330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:23:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C65E78477C
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7580D3013B54
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 06:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7186C271468;
	Mon, 26 Jan 2026 06:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ji2tFrz1"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387F626E6F2;
	Mon, 26 Jan 2026 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769408586; cv=none; b=RzhSZupRylQgqkWmKSswDQPK/EF7M9o4T2lXqes7jvBgUbzIaiFsUSq9iKeSxmCcdtf+mseGk0tnoeLkXbx/k/i4ApJgCiRDmGdyCWZMUXEYMo5XvemcQZvjoRYJGmAJA0bUoAKJMQ6lbA6cn2PpNSPXrVU2981Ba5LP+Pqb154=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769408586; c=relaxed/simple;
	bh=DOndyKOPHC+XjWwo8IQmKVVgE+2YxR9PrmL7vaEb2Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HW0GIiV73V9CQ2LAzJsdK+diQ2kZBsDC4XTPi3JoQJrnhsy7PVmv38r2TWLHCs8p8g10fms214ZNxOxoreH19xk3Zc2kUYRKde86aUOs+CJMo5eb5xvGA4enWs3jDf6GR0zUUfSpwUNxVmcFd1oW2GgZQBmBbhIk21RDoMTwFMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ji2tFrz1; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vk
	5iutERJA27zH/tcNhHf5mNR2d/fQros4GcMViC0s4=; b=Ji2tFrz1EA8pOyJjs6
	iKbcZTSel/AiuYNzdL/Vb1/JCJvNzKpw1vGB10JjfRpZn3L276sJoJdk7a6D5Fh8
	71N4+JNFjV4ejcfWl+gD0t0bMVkj0dxUNZk319Zy224t8XuAzcP8WE+rRMiGnXpC
	zsjpt+EGrJmY7pNfv6evpQh/s=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCHzzkJCHdpL7kRIg--.5216S3;
	Mon, 26 Jan 2026 14:22:07 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mani@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slark_xiao@163.com
Subject: [net-next v8 1/8] net: wwan: core: remove unused port_id field
Date: Mon, 26 Jan 2026 14:21:51 +0800
Message-Id: <20260126062158.308598-2-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260126062158.308598-1-slark_xiao@163.com>
References: <20260126062158.308598-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHzzkJCHdpL7kRIg--.5216S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw15Jr48Kw1DZF1fKw17ZFb_yoWkGwbEkr
	nYvrZ5Z348CFyvvr42gF43ZFWFvF4IqF4kuwnaqrZ3AFWDXrWrW3Z8XFnrWrn8ur18ZrZr
	WrZrXFs2vr1fKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_pVbDUUUUU==
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbC5w89oWl3CA-oWwAA3e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253330-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slark_xiao@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C65E78477C
X-Rspamd-Action: no action

From: Sergey Ryazanov <ryazanov.s.a@gmail.com>

It was used initially for a port id allocation, then removed, and then
accidently introduced again, but it is still unused. Drop it again to
keep code clean.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/net/wwan/wwan_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 63a47d420bc5..ade8bbffc93e 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -43,7 +43,6 @@ static struct dentry *wwan_debugfs_dir;
  *
  * @id: WWAN device unique ID.
  * @dev: Underlying device.
- * @port_id: Current available port ID to pick.
  * @ops: wwan device ops
  * @ops_ctxt: context to pass to ops
  * @debugfs_dir:  WWAN device debugfs dir
@@ -51,7 +50,6 @@ static struct dentry *wwan_debugfs_dir;
 struct wwan_device {
 	unsigned int id;
 	struct device dev;
-	atomic_t port_id;
 	const struct wwan_ops *ops;
 	void *ops_ctxt;
 #ifdef CONFIG_WWAN_DEBUGFS
-- 
2.25.1


