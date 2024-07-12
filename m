Return-Path: <netdev+bounces-111046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AB492F840
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 11:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1ECFB20C8F
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 09:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20F316C853;
	Fri, 12 Jul 2024 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b5/sHhyU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAC116191E;
	Fri, 12 Jul 2024 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720777500; cv=none; b=YCWOMAiLQTIOtqfDWaIhm3xyoxS22MuEoic46ezGv9u3fG/CviRr6DmwAMUSeG0C4onzpWv6hxDNnBLnAJtK4yTRqj8dWQwosMzhiRwgM6ITQ8Oeod6PnGbiDw7DYxdwm4LacgJwI7kTOQLFoZsV5w9sgYhf3XrURt2BHCrqEj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720777500; c=relaxed/simple;
	bh=tX/q0fTw9m6ieC+UmmbGKmEl0FvW8c1JEqZGZzmtFOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IjYYEeBBajSn8tfEhAzPWSEUbQe/AZ1Sz0OvYcmG+9dVn9Qu0XQtf5qnM5Qu8dNwu+8x0R8iZLH189/YiXcJpsuqL8FmN/ud4kP9J8nnqO0KZC8kfs+ZUSveYbbGG0V5J5d8Dwx0nrcz3aNgV7wrMtwf+IJA/yR2cD/Eax0HTLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b5/sHhyU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720777499; x=1752313499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tX/q0fTw9m6ieC+UmmbGKmEl0FvW8c1JEqZGZzmtFOA=;
  b=b5/sHhyUrhESsfcomLQC56tQLMGJq4RRceCGV2rTD9zLmxRotJd14/BN
   4px/cxyfr5a3r40RbKK3OAH0O/wFUev1Pvr/oIiF2vEzrgMw5ipIwp8QG
   aLtz7gjyXylDkxreQrm+rObqBbNkFke5HRWRUW2ut3Jo4mMBgEzb6orz2
   SpzvCNWqXaVCjhxxHV4X91prJbIk+/wmkxdLysmTF/vjXT2ATzdcOgLdQ
   j3XRT72KJJcwaJuo6t2WZj/cgT3LQ3l0wvZQ5ZKqKxuXOvQijp8o9gWQJ
   t86wwAfhHQLXEKQZM04kgXV4oRqr4Cww3mYFEMD4vEfOKUmbHym73NxUU
   Q==;
X-CSE-ConnectionGUID: ttctN885Taehj9hW95hkjQ==
X-CSE-MsgGUID: aGDzZNUwTEenm8PY8rmRfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18076995"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="18076995"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 02:44:57 -0700
X-CSE-ConnectionGUID: yf2VA5M8TxOUkSwkTLeh5g==
X-CSE-MsgGUID: hMFeL0atSW+qflhmHc0qTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="49524319"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa007.jf.intel.com with ESMTP; 12 Jul 2024 02:44:53 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 378DF72;
	Fri, 12 Jul 2024 10:44:52 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com,
	akpm@linux-foundation.org,
	willemb@google.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v2 6/6] ice: devlink health: dump also skb on Tx hang
Date: Fri, 12 Jul 2024 05:32:51 -0400
Message-Id: <20240712093251.18683-7-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240712093251.18683-1-mateusz.polchlopek@intel.com>
References: <20240712093251.18683-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Extend Tx hang devlink health reporter dump by skb content.

This commit includes much code copy-pasted from:
- net/core/skbuff.c (function skb_dump() - modified to dump into buffer)
- lib/hexdump.c (function print_hex_dump())

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 .../intel/ice/devlink/devlink_health.c        | 197 ++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_health.c b/drivers/net/ethernet/intel/ice/devlink/devlink_health.c
index f9edfabc9be8..1a9b19a7e7e1 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_health.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_health.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2024, Intel Corporation. */
 
+#include <net/genetlink.h>
 #include "devlink_health.h"
 #include "ice.h"
 #include "ice_ethtool_common.h"
@@ -136,6 +137,188 @@ static void ice_dump_ethtool_stats_to_fmsg(struct devlink_fmsg *fmsg,
 	kfree(stats);
 }
 
+/**
+ * ice_emit_to_buf - print to @size sized buffer
+ *
+ * @buf: buffer to print into
+ * @at: current pos to write in @buf
+ * @size: total space in @buf (incl. prior to @at)
+ * @fmt: format of the message to print
+ *
+ * Return: position in the @buf for next write, @size at most, to ease out
+ * error handling.
+ */
+static __printf(4, 5)
+int ice_emit_to_buf(char *buf, int size, int at, const char *fmt, ...)
+{
+	va_list args;
+	int len;
+
+	va_start(args, fmt);
+	len = vscnprintf(buf + at, size - at, fmt, args);
+	va_end(args);
+
+	return min(at + len, size);
+}
+
+/**
+ * ice_emit_hex_to_buf - copy of print_hex_dump() from lib/hexdump.c modified to
+ * dump into buffer
+ *
+ * @out: buffer to print to
+ * @out_size: total size of @out
+ * @out_pos: position in @out to write at
+ * @prefix: string to prefix each line with;
+ *  caller supplies trailing spaces for alignment if desired
+ * @buf: data blob to dump
+ * @buf_len: number of bytes in the @buf
+ *
+ * Return: position in the buf for next write, buf_len at most, to ease out
+ * error handling.
+ */
+static int ice_emit_hex_to_buf(char *out, int out_size, int out_pos,
+			       const char *prefix, const void *buf,
+			       size_t buf_len)
+{
+	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
+	const int rowsize = 16, groupsize = 1;
+	int i, linelen, remaining = buf_len;
+	const u8 *ptr = buf;
+
+	for (i = 0; i < buf_len; i += rowsize) {
+		linelen = min(remaining, rowsize);
+		remaining -= rowsize;
+
+		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
+				   linebuf, sizeof(linebuf), false);
+		out_pos = ice_emit_to_buf(out, out_size, out_pos,
+					  "%s%.8x: %s\n", prefix, i, linebuf);
+
+		if (out_pos == out_size)
+			break;
+	}
+
+	return out_pos;
+}
+
+/**
+ * ice_skb_dump_buf - Dump skb information and contents.
+ *
+ * copy of skb_dump() from net/core/skbuff.c, modified to dump into buffer
+ *
+ * @skb: skb to dump
+ * @buf: buffer to dump into
+ * @buf_size: size of @buf
+ * @buf_pos: current position to write in @buf
+ *
+ * Return: position in the buf for next write.
+ */
+static int ice_skb_dump_buf(char *buf, int buf_size, int buf_pos,
+			    const struct sk_buff *skb)
+{
+	struct skb_shared_info *sh = skb_shinfo(skb);
+	struct net_device *dev = skb->dev;
+	const bool toplvl = !buf_pos;
+	struct sock *sk = skb->sk;
+	struct sk_buff *list_skb;
+	bool has_mac, has_trans;
+	int headroom, tailroom;
+	int i, len, seg_len;
+
+	len = skb->len;
+
+	headroom = skb_headroom(skb);
+	tailroom = skb_tailroom(skb);
+
+	has_mac = skb_mac_header_was_set(skb);
+	has_trans = skb_transport_header_was_set(skb);
+
+	buf_pos = ice_emit_to_buf(buf, buf_size, buf_pos,
+		"skb len=%u headroom=%u headlen=%u tailroom=%u\n"
+		"mac=(%d,%d) net=(%d,%d) trans=%d\n"
+		"shinfo(txflags=%u nr_frags=%u gso(size=%hu type=%u segs=%hu))\n"
+		"csum(0x%x ip_summed=%u complete_sw=%u valid=%u level=%u)\n"
+		"hash(0x%x sw=%u l4=%u) proto=0x%04x pkttype=%u iif=%d\n",
+		skb->len, headroom, skb_headlen(skb), tailroom,
+		has_mac ? skb->mac_header : -1,
+		has_mac ? skb_mac_header_len(skb) : -1,
+		skb->network_header,
+		has_trans ? skb_network_header_len(skb) : -1,
+		has_trans ? skb->transport_header : -1,
+		sh->tx_flags, sh->nr_frags,
+		sh->gso_size, sh->gso_type, sh->gso_segs,
+		skb->csum, skb->ip_summed, skb->csum_complete_sw,
+		skb->csum_valid, skb->csum_level,
+		skb->hash, skb->sw_hash, skb->l4_hash,
+		ntohs(skb->protocol), skb->pkt_type, skb->skb_iif);
+
+	if (dev)
+		buf_pos = ice_emit_to_buf(buf, buf_size, buf_pos,
+					  "dev name=%s feat=%pNF\n", dev->name,
+					  &dev->features);
+	if (sk)
+		buf_pos = ice_emit_to_buf(buf, buf_size, buf_pos,
+					  "sk family=%hu type=%u proto=%u\n",
+					  sk->sk_family, sk->sk_type,
+					  sk->sk_protocol);
+
+	if (headroom)
+		buf_pos = ice_emit_hex_to_buf(buf, buf_size, buf_pos,
+					      "skb headroom: ", skb->head,
+					      headroom);
+
+	seg_len = min_t(int, skb_headlen(skb), len);
+	if (seg_len)
+		buf_pos = ice_emit_hex_to_buf(buf, buf_size, buf_pos,
+					      "skb linear:   ", skb->data,
+					      seg_len);
+	len -= seg_len;
+
+	if (tailroom)
+		buf_pos = ice_emit_hex_to_buf(buf, buf_size, buf_pos,
+					      "skb tailroom: ",
+					      skb_tail_pointer(skb), tailroom);
+
+	for (i = 0; len && i < skb_shinfo(skb)->nr_frags; i++) {
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+		u32 p_off, p_len, copied;
+		struct page *p;
+		u8 *vaddr;
+
+		skb_frag_foreach_page(frag, skb_frag_off(frag),
+				      skb_frag_size(frag), p, p_off, p_len,
+				      copied) {
+			seg_len = min_t(int, p_len, len);
+			vaddr = kmap_local_page(p);
+			buf_pos = ice_emit_hex_to_buf(buf, buf_size, buf_pos,
+						      "skb frag:     ",
+						      vaddr + p_off, seg_len);
+			kunmap_local(vaddr);
+			len -= seg_len;
+
+			if (!len || buf_pos == buf_size)
+				break;
+		}
+	}
+
+	if (skb_has_frag_list(skb)) {
+		buf_pos = ice_emit_to_buf(buf, buf_size, buf_pos,
+					  "skb fraglist:\n");
+		skb_walk_frags(skb, list_skb) {
+			buf_pos = ice_skb_dump_buf(buf, buf_size, buf_pos,
+						   list_skb);
+
+			if (buf_pos == buf_size)
+				break;
+		}
+	}
+
+	if (toplvl)
+		buf_pos = ice_emit_to_buf(buf, buf_size, buf_pos, ".");
+
+	return buf_pos;
+}
+
 /**
  * ice_fmsg_put_ptr - put hex value of pointer into fmsg
  *
@@ -167,6 +350,10 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
 				     struct netlink_ext_ack *extack)
 {
 	struct ice_tx_hang_event *event = priv_ctx;
+	char *skb_txt = NULL;
+	struct sk_buff *skb;
+
+	skb = event->tx_ring->tx_buf->skb;
 
 	devlink_fmsg_obj_nest_start(fmsg);
 	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, head);
@@ -178,8 +365,18 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
 	devlink_fmsg_put(fmsg, "irq-mapping", event->tx_ring->q_vector->name);
 	ice_fmsg_put_ptr(fmsg, "desc-ptr", event->tx_ring->desc);
 	ice_fmsg_put_ptr(fmsg, "dma-ptr", (void *)(long)event->tx_ring->dma);
+	ice_fmsg_put_ptr(fmsg, "skb-ptr", skb);
 	devlink_fmsg_binary_pair_put(fmsg, "desc", event->tx_ring->desc,
 				     (event->tx_ring->count * sizeof(struct ice_tx_desc)));
+	if (skb)
+		skb_txt = kvmalloc(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+
+	if (skb_txt) {
+		ice_skb_dump_buf(skb_txt, GENLMSG_DEFAULT_SIZE, 0, skb);
+		devlink_fmsg_put(fmsg, "skb", skb_txt);
+		kvfree(skb_txt);
+	}
+
 	ice_dump_ethtool_stats_to_fmsg(fmsg, event->tx_ring->vsi->netdev);
 	devlink_fmsg_obj_nest_end(fmsg);
 
-- 
2.38.1


