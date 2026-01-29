Return-Path: <netdev+bounces-254921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PwO0CC/fe2ljJAIAu9opvQ
	(envelope-from <netdev+bounces-254921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:29:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4C9B54AF
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2DEF63004F2B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 22:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDF936AB5B;
	Thu, 29 Jan 2026 22:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="neWQO8yD"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA9135DD19;
	Thu, 29 Jan 2026 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769725734; cv=none; b=qqYJvVwqL/9QGm5pbo6O8hrkXOKb+b8aDqvHjWbcKfwZnc+RzNrE7fVvgncTVbajLKTFGl0lHXL5mtT3H1d8S4kcCIFs524jHXzGVGVURP0K47D+f1jdN9GuD5APullQ/NUV27f/AuG82QKluPw+Y90OtWhHdEug3NMwC6YPSP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769725734; c=relaxed/simple;
	bh=WxGCo4B+xs44ufdHDtaWTvOdcwdcEiP2MpOJ88nLfLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQGRKUYxai4ZBtMeAAW1LoqH9EOVYwqyBcunnnwHqNZcBXU8dd9wWboNYU5zws8qSvhby1+Pl0AzgCBaPIBbhecp5NxAABr14T9F1MtcDIKaF5+TpA7a2OZDh9Z1K4uJ9EGaYfhDyuAyIZ05R7+BmzW+y1tqM0tZdl/tpCiLNdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=neWQO8yD; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=IB6/fGkfZ6cuSpfm5KIQwKbKvYk0Q6eMLp+G0krjZi0=; b=neWQO8yDAb6o6sD3i9MVAEHZoQ
	DmnMvT3U25V8NT20zAVbJJ1ptY8y1JQwG+iKCARnohBEnNXK52+Q3sI8zDtsJmm0/hmqHEf9YsK0J
	dxeboFQDwlbNOZ2tKRKr9gMGyfrJUJtjG4lbda3FwWp8wV1UZ9h6o2eRWXJ27U4AHXazTv7Y7pSgY
	kUbxMJt3IfWMxEwW7pdcFNIFtNvm0152HsZ77LUJvAni2H6LT/0QV3WXMau40U9pUlWIJPc//741A
	F/sLWHJ105GvvPURm47Nki+HsaqMzJKZLeEZbcZRpWa9NEGWHYUud+iAaLUw76rmbdb7183cYVR7J
	f0vRxaKw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vlaVA-0008oo-2O;
	Thu, 29 Jan 2026 23:28:36 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	pabeni@redhat.com,
	willemb@google.com,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	dw@davidwei.uk,
	toke@redhat.com,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: [PATCH net-next v8 04/16] net, ethtool: Disallow leased real rxqs to be resized
Date: Thu, 29 Jan 2026 23:28:18 +0100
Message-ID: <20260129222830.439687-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129222830.439687-1-daniel@iogearbox.net>
References: <20260129222830.439687-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27896/Thu Jan 29 08:24:11 2026)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254921-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,davidwei.uk:email,blackwall.org:email]
X-Rspamd-Queue-Id: 1F4C9B54AF
X-Rspamd-Action: no action

Similar to AF_XDP, do not allow queues in a physical netdev to be
resized by ethtool -L when they are leased.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/ethtool/channels.c | 12 +++++++-----
 net/ethtool/ioctl.c    |  9 +++++----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/ethtool/channels.c b/net/ethtool/channels.c
index ca4f80282448..797d2a08c515 100644
--- a/net/ethtool/channels.c
+++ b/net/ethtool/channels.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include <net/xdp_sock_drv.h>
+#include <net/netdev_queues.h>
 
 #include "netlink.h"
 #include "common.h"
@@ -169,14 +169,16 @@ ethnl_set_channels(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (ret)
 		return ret;
 
-	/* Disabling channels, query zero-copy AF_XDP sockets */
+	/* ensure channels are not busy at the moment */
 	from_channel = channels.combined_count +
 		       min(channels.rx_count, channels.tx_count);
-	for (i = from_channel; i < old_total; i++)
-		if (xsk_get_pool_from_qid(dev, i)) {
-			GENL_SET_ERR_MSG(info, "requested channel counts are too low for existing zerocopy AF_XDP sockets");
+	for (i = from_channel; i < old_total; i++) {
+		if (netdev_queue_busy(dev, i, NULL)) {
+			GENL_SET_ERR_MSG(info,
+					 "requested channel counts are too low due to busy queues (AF_XDP or queue leasing)");
 			return -EINVAL;
 		}
+	}
 
 	ret = dev->ethtool_ops->set_channels(dev, &channels);
 	return ret < 0 ? ret : 1;
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 9431e305b233..02a3454234d6 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -27,12 +27,13 @@
 #include <linux/net.h>
 #include <linux/pm_runtime.h>
 #include <linux/utsname.h>
+#include <linux/ethtool_netlink.h>
 #include <net/devlink.h>
 #include <net/ipv6.h>
-#include <net/xdp_sock_drv.h>
 #include <net/flow_offload.h>
 #include <net/netdev_lock.h>
-#include <linux/ethtool_netlink.h>
+#include <net/netdev_queues.h>
+
 #include "common.h"
 
 /* State held across locks and calls for commands which have devlink fallback */
@@ -2282,12 +2283,12 @@ static noinline_for_stack int ethtool_set_channels(struct net_device *dev,
 	if (ret)
 		return ret;
 
-	/* Disabling channels, query zero-copy AF_XDP sockets */
+	/* Disabling channels, query busy queues (AF_XDP, queue leasing) */
 	from_channel = channels.combined_count +
 		min(channels.rx_count, channels.tx_count);
 	to_channel = curr.combined_count + max(curr.rx_count, curr.tx_count);
 	for (i = from_channel; i < to_channel; i++)
-		if (xsk_get_pool_from_qid(dev, i))
+		if (netdev_queue_busy(dev, i, NULL))
 			return -EINVAL;
 
 	ret = dev->ethtool_ops->set_channels(dev, &channels);
-- 
2.43.0


