Return-Path: <netdev+bounces-274703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOmXBoDczmmGqgYAu9opvQ
	(envelope-from <netdev+bounces-274703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 23:15:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 415EC38E498
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 23:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 960E9301E210
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 21:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BA93A6EE8;
	Thu,  2 Apr 2026 21:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="RFna+KE+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m83187.xmail.ntesmail.com (mail-m83187.xmail.ntesmail.com [156.224.83.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1413A5431;
	Thu,  2 Apr 2026 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.83.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775164425; cv=none; b=CHCPmjGX6kFZ34O5vq9/dJ10oLR/Juu1pNN6xevDSPqbnTih/Z+Qb1WDpsHbRhTao+9YabJMJGRfTtoGz+Ar2qowCsB5cBTgp3FHunkyOAOyGxUd0A1MvhplhCJ04eWX61GynsU4NGddZMD1XJzlT26DgZCVEqmWOCSVoB7yStw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775164425; c=relaxed/simple;
	bh=mq1qNMND5KoaoFkHmrroSqLwyeymKan5QEYrdceyQKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XmwxfICWFj6v/cForY5ErEmp//6XA1PJ51NoXCidbhQd+WcSMQd2YKJyIKvD+V/Mbaj+4t7DJ/63SH5x+fS3gyv+gO00LS1NVTwiSwBE6M0JOofbeuiP4sEYiR+pmLeqMMyWvPS+La2PdiIaBO1cnGDgNiGKaVZDNx3YhpDGAI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=RFna+KE+; arc=none smtp.client-ip=156.224.83.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Received: from lwz.tail698a0e.ts.net (gy-adaptive-ssl-proxy-4-entmail-virt151.gy.ntes [36.112.3.244])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3956a559d;
	Fri, 3 Apr 2026 00:37:28 +0800 (GMT+08:00)
From: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
To: rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC PATCH 6/6] MAINTAINERS: add Rust net and nlmon entries
Date: Thu,  2 Apr 2026 12:36:40 -0400
Message-Id: <20260402163640.1079056-7-wenzhaoliao@ruc.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402163640.1079056-1-wenzhaoliao@ruc.edu.cn>
References: <20260402163640.1079056-1-wenzhaoliao@ruc.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d4f0e93eb03a2kunm6754def456bf74
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTR1JVhgeSkhDThgeHRhJQ1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlITVVKSklVSFVJT09ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVUpCS0
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=RFna+KE+V472iTrrDSAC/I/BvoC/Z3mD4LVKkw/c/WUSrdG8vy7sKm+S7aOF/Mje+ldx4jb00cKodLuruv6tkQLRpp8zeb1m3nbBsh0ZNyK9EkolV9OeChsFPw+njE/xQ/TsjArlYVH9FTNgAdsPlykRVnF9vZvAvc2A/oj4cNQ=; c=relaxed/relaxed; s=default; d=ruc.edu.cn; v=1;
	bh=0RXe8FftK9+WQ4CtVqc+7/yKc01o6MTUrQjVs8zTSg4=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ruc.edu.cn,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ruc.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,lunn.ch,davemloft.net,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274703-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wenzhaoliao@ruc.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ruc.edu.cn:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ruc.edu.cn:dkim,ruc.edu.cn:email,ruc.edu.cn:mid,sipsolutions.net:email]
X-Rspamd-Queue-Id: 415EC38E498
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add scoped maintainer entries for the new Rust networking abstraction
files and for the Rust nlmon reference driver.

This keeps future changes routed to the networking and Rust mailing
lists while also giving the new code paths a direct maintainer contact.

Signed-off-by: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
---
 MAINTAINERS | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 77fdfcb55f06..d1c3eb61ea46 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18335,6 +18335,25 @@ X:	Documentation/devicetree/bindings/net/wireless/
 X:	drivers/net/can/
 X:	drivers/net/wireless/
 
+NETWORKING LINK-TYPE ABSTRACTIONS [RUST]
+M:	Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
+L:	netdev@vger.kernel.org
+L:	rust-for-linux@vger.kernel.org
+S:	Maintained
+F:	rust/kernel/net.rs
+F:	rust/kernel/net/netdevice.rs
+F:	rust/kernel/net/netlink_tap.rs
+F:	rust/kernel/net/rtnl.rs
+F:	rust/kernel/net/skbuff.rs
+F:	rust/kernel/net/stats.rs
+
+NLMON DRIVER [RUST]
+M:	Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
+L:	netdev@vger.kernel.org
+L:	rust-for-linux@vger.kernel.org
+S:	Maintained
+F:	drivers/net/nlmon_rust.rs
+
 NETWORKING DRIVERS (WIRELESS)
 M:	Johannes Berg <johannes@sipsolutions.net>
 L:	linux-wireless@vger.kernel.org
-- 
2.34.1


