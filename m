Return-Path: <netdev+bounces-274747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLqCDHz5zmn7sAYAu9opvQ
	(envelope-from <netdev+bounces-274747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:19:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4369538F206
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB778306E012
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 23:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CF63F881E;
	Thu,  2 Apr 2026 23:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="OkF70cRO"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA693F7E90;
	Thu,  2 Apr 2026 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775171462; cv=none; b=gX2AAzjz+F81z7z5EZ+SDPB2ZHYmWao9ds6K7zXwwu+Yj5/dfPBVkvP1Vzp8KJWSdWlHiV/9XcbEo8tjoBOEJ/J6cxR+sjUyiQBNpvVnG7MPWXntcLMTkDdKxfEFPqFMSvQtaBKcj0yczE5HmKwwKqn7Ku/7xcVo0cBakIuWHyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775171462; c=relaxed/simple;
	bh=UpMdY1g1PfOKshR4NsIYaGtrMFgeqaGClyUlSFBlGhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZK5eRmuGIphx4y25YJTOXCb3SiruTCyNhIdB7ASuzuYSrrf7bAP7/4vt6adt9pSh98PiiFXebRt7r7wFUvF9WMmLsNrqkNXpRhiZSRfpPdzPMnKesmJnXGRGQzDWJVpaxETwwTVi6mxoZDJ02P0WIcAt7f5D2YKex62ugGMrZDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=OkF70cRO; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ntsEHhRS8sovuiOJdhvs+xFYj3ZMQ0+swZ5snRHTxsU=; b=OkF70cRORWbbNRSvnrnSpE2CXD
	evauTNYXduhZTgx/xhAORX802sDFtOsxSnY0Pa+28UWX422XfowZumISZE6+Zgt4WEc8fhIKqajUx
	2BdCm6DPa+kT5EX+/yCqhj9yJ21Utr/F9XBnEGQBdhtBcDfVOmQ841uqoM+eTRFU1Bm+F5Ru/iwSW
	LwyzBXDKN2R/smAU94T8lB4ErQI7AOrXuuxG5uZ5N2oK3D/STjUpNEsjhQQyTa7U2XvMxEpdLodvz
	cLT4hD9YAAAHgtM2QvJPDMXEFtqoJ7Frl0Sj1vlaiA/+El8zv5BDc3SXCsorXw2nSNYyRFU1Jq+b2
	boEMhmuQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w8RBO-0000mS-03;
	Fri, 03 Apr 2026 01:10:38 +0200
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
Subject: [PATCH net-next v11 04/14] net, ethtool: Disallow leased real rxqs to be resized
Date: Fri,  3 Apr 2026 01:10:21 +0200
Message-ID: <20260402231031.447597-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402231031.447597-1-daniel@iogearbox.net>
References: <20260402231031.447597-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27959/Thu Apr  2 08:25:45 2026)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274747-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,davidwei.uk:email,iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid]
X-Rspamd-Queue-Id: 4369538F206
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Similar to AF_XDP, do not allow queues in a physical netdev to be resized
by ethtool -L when they are leased. Cover channel resize paths (both
netlink and ioctl) to reject resizing when the queues would be affected.

Given we need to have different checks for RX vs TX, detangle the code into
a two-loop version rather than the range of new_combined + min(new_rx, new_tx)
to old_combined + max(old_rx, old_tx).

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/ethtool/channels.c | 28 +++++++++++++++++-----------
 net/ethtool/ioctl.c    | 21 ++++++++++++---------
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/net/ethtool/channels.c b/net/ethtool/channels.c
index 45232cf1c144..64ef8cff2005 100644
--- a/net/ethtool/channels.c
+++ b/net/ethtool/channels.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include <net/xdp_sock_drv.h>
+#include <net/netdev_queues.h>
 
 #include "common.h"
 #include "netlink.h"
@@ -109,7 +109,7 @@ ethnl_set_channels_validate(struct ethnl_req_info *req_info,
 static int
 ethnl_set_channels(struct ethnl_req_info *req_info, struct genl_info *info)
 {
-	unsigned int from_channel, old_total, i;
+	unsigned int old_combined, old_rx, old_tx, i;
 	bool mod = false, mod_combined = false;
 	struct net_device *dev = req_info->dev;
 	struct ethtool_channels channels = {};
@@ -118,8 +118,9 @@ ethnl_set_channels(struct ethnl_req_info *req_info, struct genl_info *info)
 	int ret;
 
 	dev->ethtool_ops->get_channels(dev, &channels);
-	old_total = channels.combined_count +
-		    max(channels.rx_count, channels.tx_count);
+	old_combined = channels.combined_count;
+	old_rx = channels.rx_count;
+	old_tx = channels.tx_count;
 
 	ethnl_update_u32(&channels.rx_count, tb[ETHTOOL_A_CHANNELS_RX_COUNT],
 			 &mod);
@@ -169,14 +170,19 @@ ethnl_set_channels(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (ret)
 		return ret;
 
-	/* Disabling channels, query zero-copy AF_XDP sockets */
-	from_channel = channels.combined_count +
-		       min(channels.rx_count, channels.tx_count);
-	for (i = from_channel; i < old_total; i++)
-		if (xsk_get_pool_from_qid(dev, i)) {
-			GENL_SET_ERR_MSG(info, "requested channel counts are too low for existing zerocopy AF_XDP sockets");
+	/* ensure channels are not busy at the moment */
+	for (i = channels.combined_count + channels.rx_count;
+	     i < old_combined + old_rx; i++) {
+		if (netdev_queue_busy(dev, i, NETDEV_QUEUE_TYPE_RX,
+				      info->extack))
 			return -EINVAL;
-		}
+	}
+	for (i = channels.combined_count + channels.tx_count;
+	     i < old_combined + old_tx; i++) {
+		if (netdev_queue_busy(dev, i, NETDEV_QUEUE_TYPE_TX,
+				      info->extack))
+			return -EINVAL;
+	}
 
 	ret = dev->ethtool_ops->set_channels(dev, &channels);
 	return ret < 0 ? ret : 1;
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 3c713a91ad0d..bd97f9b9bf18 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -27,12 +27,12 @@
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
 
 #include "common.h"
 
@@ -2250,7 +2250,6 @@ static noinline_for_stack int ethtool_set_channels(struct net_device *dev,
 						   void __user *useraddr)
 {
 	struct ethtool_channels channels, curr = { .cmd = ETHTOOL_GCHANNELS };
-	u16 from_channel, to_channel;
 	unsigned int i;
 	int ret;
 
@@ -2284,13 +2283,17 @@ static noinline_for_stack int ethtool_set_channels(struct net_device *dev,
 	if (ret)
 		return ret;
 
-	/* Disabling channels, query zero-copy AF_XDP sockets */
-	from_channel = channels.combined_count +
-		min(channels.rx_count, channels.tx_count);
-	to_channel = curr.combined_count + max(curr.rx_count, curr.tx_count);
-	for (i = from_channel; i < to_channel; i++)
-		if (xsk_get_pool_from_qid(dev, i))
+	/* Disabling channels, query busy queues (AF_XDP, queue leasing) */
+	for (i = channels.combined_count + channels.rx_count;
+	     i < curr.combined_count + curr.rx_count; i++) {
+		if (netdev_queue_busy(dev, i, NETDEV_QUEUE_TYPE_RX, NULL))
 			return -EINVAL;
+	}
+	for (i = channels.combined_count + channels.tx_count;
+	     i < curr.combined_count + curr.tx_count; i++) {
+		if (netdev_queue_busy(dev, i, NETDEV_QUEUE_TYPE_TX, NULL))
+			return -EINVAL;
+	}
 
 	ret = dev->ethtool_ops->set_channels(dev, &channels);
 	if (!ret)
-- 
2.43.0


