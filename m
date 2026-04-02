Return-Path: <netdev+bounces-274646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Gz+JRytzml+pQYAu9opvQ
	(envelope-from <netdev+bounces-274646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:53:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE83D38CC71
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7C7F30276A6
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 17:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE9B3CF690;
	Thu,  2 Apr 2026 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="lhuT3Ia0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m128153.netease.com (mail-m128153.netease.com [103.209.128.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49479304BDC;
	Thu,  2 Apr 2026 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.209.128.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775152370; cv=none; b=iI8UjXvwBgTVu/HIayl6vjPZ3gOLcsgpq0vnF3NdMh4p8NEH4vFvWu4n1XPHQiVKB009tgfWZRC/cVSDRq8+HjJkyXiJ+YE3or0oSroj8DkwN6Xca87bRG7myHH6EnqNOzS8nZLEx/FIxnVsrPeBUqma8UMEOJCcEaYQVxvCmdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775152370; c=relaxed/simple;
	bh=56UAlDrw2MVJbfQhHM8iVveF06uJGnsbg6eCsCsjn2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u4LbWamH/ZwOM21BkTKoVpHXXKWZJeTLmFy/yja8RI4LLCA8KvEMf9oQtrj9dICi8/AU64IQbfwpmIg7IEfToRy88sfq+vlhd26snO0tVm93cZQ31bT87w6IfCHAB/+pzYwyPoPO0qpq3BNpv+BvSlS+p9a55RLrCTvmrOmLGqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=lhuT3Ia0; arc=none smtp.client-ip=103.209.128.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Received: from lwz.tail698a0e.ts.net (gy-adaptive-ssl-proxy-4-entmail-virt151.gy.ntes [36.112.3.244])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3956a5591;
	Fri, 3 Apr 2026 00:36:57 +0800 (GMT+08:00)
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
Subject: [RFC PATCH 1/6] rust: bindings: expose networking headers needed by nlmon
Date: Thu,  2 Apr 2026 12:36:35 -0400
Message-Id: <20260402163640.1079056-2-wenzhaoliao@ruc.edu.cn>
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
X-HM-Tid: 0a9d4f0e189103a2kunm6754def456bf19
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCS0pKVkkZTxpISB0ZShpPHVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlITVVKSklVSFVJT09ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVUpCS0
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=lhuT3Ia02h5qaCmBbzBmWtwx9H8A2NQvan9sQMTJ3JPO0C2UHjF2m1boDz0zPPOm4tSU7uei3V0xjk30b6JSbqlOfQQEutv75FHzTZQFxPTUO6DgVJyV6SWdk8sqPbaoawJ1yI0PU0B7ut0SMjP4FXMgaAZcHxJmtBn2k4f2qrQ=; c=relaxed/relaxed; s=default; d=ruc.edu.cn; v=1;
	bh=EtrAAqKgIFaObfmYMvH+CIpV3k5p6IY+gei6OvVIHxo=;
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
	TAGGED_FROM(0.00)[bounces-274646-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ruc.edu.cn:dkim,ruc.edu.cn:email,ruc.edu.cn:mid]
X-Rspamd-Queue-Id: EE83D38CC71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Expose the networking declarations consumed by the minimal Rust nlmon
reference driver before higher level wrappers are introduced.

This includes the core net_device, rtnl_link_ops, statistics, sk_buff,
and netlink tap declarations needed by the planned abstractions.

Signed-off-by: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
---
 rust/bindings/bindings_helper.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 083cc44aa952..ee56505e03f9 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -57,6 +57,7 @@
 #include <linux/file.h>
 #include <linux/firmware.h>
 #include <linux/fs.h>
+#include <linux/if_arp.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/io-pgtable.h>
@@ -66,6 +67,8 @@
 #include <linux/mdio.h>
 #include <linux/mm.h>
 #include <linux/miscdevice.h>
+#include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/of_device.h>
 #include <linux/pci.h>
 #include <linux/phy.h>
@@ -88,6 +91,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/xarray.h>
+#include <net/rtnetlink.h>
 #include <trace/events/rust_sample.h>
 
 /*
-- 
2.34.1


