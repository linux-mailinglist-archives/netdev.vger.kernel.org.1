Return-Path: <netdev+bounces-280566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDMgO6xs6WndZAIAu9opvQ
	(envelope-from <netdev+bounces-280566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 02:49:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2767B44BF37
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 02:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12106301BF73
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 00:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7C6223323;
	Thu, 23 Apr 2026 00:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="EgWGewa9"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241001A239A;
	Thu, 23 Apr 2026 00:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776905379; cv=none; b=Sh8xVbymJrUBrVt3tNckOEol4teUwymvk4rdkFoyZR4+RvhKFqowqkYNySOQwcMUGdaBJFQmEK3MA8tPjaXAvmGpqk1LX4fwCwesxU1S4FMDveuxRtBdVx9d72K7nDf+koiWQ6hspJtEycoogHq3GcmcRzJ75H1VgXwwSBnCPSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776905379; c=relaxed/simple;
	bh=uGFvtLAWamxcAKGzomzYdxJMOB56FEC0xZY1zIHrnAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLL/ZDg53L+hXkNB2w+8//uQnxYze6sfgaRt/VzYLqggeep9Q2xYpqRH2LJbzIcAzvMHtWdEKsjfnNMOy1NYzu1CIdQzOeJqn8V18q8aFqEcYNOKHl8eP1vOsnrHZfU8JI/5R2UUKbqZ9xZ18jd4a4q/ZBBjSw2jMfYdEwhyfD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=EgWGewa9; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1776905375;
	bh=Pzt9GPYqHlrWqMYF6Atgi6G7hlhArIM+lXCWpMBLm64=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=EgWGewa9shRNZrAc7N+YO1KERC0d2tRue7CLnfKrQzp06DpoNabdSrEScl5Jd/m4x
	 F7qwu22D5fXkr5ThFKFDinIServhK/zjg/72W3YAP3rXramLUBbEOEbjJhn+ZiwQjR
	 Ztj4g5DXu9Vzdc2zzYdLPq1p1cTVu+qZQU68d/L4=
X-QQ-mid: zesmtpgz3t1776905357t93035a83
X-QQ-Originating-IP: FHm+qjRyj8mRmsl7Wo7M7pe9j8S7PcRsmv7qgqLsA5M=
Received: from uos-PC ( [117.152.201.246])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Apr 2026 08:49:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9726520865553334205
EX-QQ-RecipientCnt: 14
From: Morduan Zang <zhangdandan@uniontech.com>
To: petkan@nucleusys.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	michal.pecio@gmail.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Zhan Jun <zhanjun@uniontech.com>,
	syzbot+3f46c095ac0ca048cb71@syzkaller.appspotmail.com
Subject: [PATCH net v2] net: usb: rtl8150: fix use-after-free in rtl8150_start_xmit()
Date: Thu, 23 Apr 2026 08:49:12 +0800
Message-ID: <809895186B866C10+20260423004913.136655-1-zhangdandan@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <73ACB7391A6DE033+20260421110412.14795-1-zhangdandan@uniontech.com>
References: <73ACB7391A6DE033+20260421110412.14795-1-zhangdandan@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M6Pq6l2cVyBBX1B1WY+sNOp5CuxnUtMxa7MnIrF4Dyah9S1gibxE4+I6
	2t10Xmmv56Av5IiOQ8Y8OlY9JcvaLyyLOdP5z5U7BwcBrR0W4WZPxEgsBHEj/dvqDhxayD7
	8IflSF4uvrh8Il1o+IhPwn6FhVEvAeFGsROLFwFjslA3jEwo+ngvKE7U40kHlSrXy8mVOqx
	VK4Pmo3iAVOibwM+1YwgV8tZTFfD4rlryRvBhcYac2+fXlyfLXhxFtTsOqA8N8ai9efjlZc
	l7y2X4XKEt4iOgj6pdeLdOSnRJ/w7AKRE93RNSsnDmhlszVF4HH7YnVBPDtRe2Lz8E7w/E3
	UhGDwykNSuRsAX5h/NPQiTn2CvjYnWURF/8pQDYWVFnrKP49HpaE8zPZqwK40PzXn27RZHS
	I0TLbWBQPNwBPqP2ANiEafptAyfLef36VF9o+uyEGNFy4/7zm7YWnUNqO7xdyIbR/GXaFr6
	0e781K6gPovN4h9SBiCrgUN20xtEdnQkxHu69/rDjOuLnZS1Ae3Dm3Bs30QX2lDLw+XQv+u
	6evOncpu/q+FftnUh8YHQ8F/rmAEyJiyNhSad5WGq61PfYs/hMok8zG3/HUHUJN4a4X4hwB
	rX2vodyNkk0zXHw7YOyF+byaJ+87YmETjCuYTrQo2Y5pHu/1MpVS1kULwysCtfKT7/QZ0bO
	+PaxP713pTQylQ5+uD3KIthqj7m1R/PGrCpkt1daxrkdvElsamI++qGY3bq1/mVmPHbS/gi
	d2e80Mpq9gOgAlYTiCYhUWPDR/KWeX0QwhhC14Vxaf63owcZjUurNKnUMDqTXrwHMTSl7Np
	DllT2ELKeCEGmNHy/tuRU1UkphVN5e5WSWSO7C2lcnV8wID1Q6pnJT+FfPvBqxvPIomm5ps
	90PVkXfpoHzQAvfmtXIjhd1x7MM4Hc7PUAJ5kH82frQH221ck9+LJ8Dr0sjeod/ZFnc57++
	QtQpoQeZYz2Kgzhm7uHinQkZ4wwh6P0EKdDX65bQuWErX5ZUEZnzgSsh+/wTjh2ySIu8DiG
	OS3CovTGyEUG7+Kt3Nbe68Dx0AtD5L5fR/ms4cVTkY2Yjb6agwSJ5pV1U74ueyRiTQsD8tP
	laZd0RJe7df00dFVGt6NHY=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280566-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com,vger.kernel.org,googlegroups.com,uniontech.com,syzkaller.appspotmail.com];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangdandan@uniontech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,3f46c095ac0ca048cb71];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:email,uniontech.com:dkim,uniontech.com:mid]
X-Rspamd-Queue-Id: 2767B44BF37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zhan Jun <zhanjun@uniontech.com>

syzbot reported a KASAN slab-use-after-free read in rtl8150_start_xmit()
when accessing skb->len for tx statistics after usb_submit_urb() has
been called:

  BUG: KASAN: slab-use-after-free in rtl8150_start_xmit+0x71f/0x760
    drivers/net/usb/rtl8150.c:712
  Read of size 4 at addr ffff88810eb7a930 by task kworker/0:4/5226

The URB completion handler write_bulk_callback() frees the skb via
dev_kfree_skb_irq(dev->tx_skb). The URB may complete on another CPU
in softirq context before usb_submit_urb() returns in the submitter,
so by the time the submitter reads skb->len the skb has already been
queued to the per-CPU completion_queue and freed by net_tx_action():

  CPU A (xmit)                      CPU B (USB completion softirq)
  ------------                      ------------------------------
  dev->tx_skb = skb;
  usb_submit_urb()      --+
                          |-------> write_bulk_callback()
                          |           dev_kfree_skb_irq(dev->tx_skb)
                          |         net_tx_action()
                          |           napi_skb_cache_put()   <-- free
  netdev->stats.tx_bytes  |
    += skb->len;          <-- UAF read

Fix it by caching skb->len before submitting the URB and using the
cached value when updating the tx_bytes counter.

The pre-existing tx_bytes semantics are preserved: the counter tracks
the original frame length (skb->len), not the ETH_ZLEN/USB-alignment
padded "count" value that is handed to the device.  Changing that
would be a user-visible accounting change and is out of scope for
this UAF fix.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+3f46c095ac0ca048cb71@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69e69ee7.050a0220.24bfd3.002b.GAE@google.com/
Closes: https://syzkaller.appspot.com/bug?extid=3f46c095ac0ca048cb71
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Zhan Jun <zhanjun@uniontech.com>
---
Changes in v2:
 - Drop the vague "This mirrors the fix pattern used by other USB
   network drivers." claim from the changelog (Michal Pecio).
 - Clarify that the patch intentionally preserves the existing
   tx_bytes semantics (no ETH_ZLEN/USB padding accounted), and that
   adjusting that is out of scope for this UAF fix (Michal Pecio).
 - Use the correct "[PATCH net]" subject prefix per
   Documentation/process/maintainer-netdev.rst (Andrew Lunn).
 - Add Reviewed-by: Andrew Lunn.
 - No functional changes; code diff is identical to v1.

v1: https://lore.kernel.org/all/73ACB7391A6DE033+20260421110412.14795-1-zhangdandan@uniontech.com/
---
 drivers/net/usb/rtl8150.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index 4cda0643afb6..6fc6be0cced6 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -683,6 +683,7 @@ static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
 					    struct net_device *netdev)
 {
 	rtl8150_t *dev = netdev_priv(netdev);
+	unsigned int skb_len;
 	int count, res;
 
 	/* pad the frame and ensure terminating USB packet, datasheet 9.2.3 */
@@ -694,6 +695,14 @@ static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
 		return NETDEV_TX_OK;
 	}
 
+	/*
+	 * Cache skb->len before submitting the URB: the URB completion
+	 * handler (write_bulk_callback) frees the skb, and it may run
+	 * on another CPU before usb_submit_urb() returns, which would
+	 * leave skb dangling here.
+	 */
+	skb_len = skb->len;
+
 	netif_stop_queue(netdev);
 	dev->tx_skb = skb;
 	usb_fill_bulk_urb(dev->tx_urb, dev->udev, usb_sndbulkpipe(dev->udev, 2),
@@ -709,7 +718,7 @@ static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
 		}
 	} else {
 		netdev->stats.tx_packets++;
-		netdev->stats.tx_bytes += skb->len;
+		netdev->stats.tx_bytes += skb_len;
 		netif_trans_update(netdev);
 	}
 
-- 
2.51.0



