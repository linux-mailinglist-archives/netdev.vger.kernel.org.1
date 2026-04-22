Return-Path: <netdev+bounces-280435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F+JM3HW6GklQQIAu9opvQ
	(envelope-from <netdev+bounces-280435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:08:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C4F44713B
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8689B304A222
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597B43ED12B;
	Wed, 22 Apr 2026 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="PTz2utpP"
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339D9332634;
	Wed, 22 Apr 2026 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776866871; cv=none; b=aC6LACKB6XbZcePP8sCqVRaLGRHPhCuC1dsYbwne5b/j4l2WAH84RTllguMkHqBcl8F5f95aAyodPmZzBfoYl9lThKBEKjDvLZgMPIH8ARNrf72K8zOkh6OJneMXvMN8Z2Isf0vAO7kCEGSo2C4bnyeglqQfojm9bjT/igKM8Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776866871; c=relaxed/simple;
	bh=uGFvtLAWamxcAKGzomzYdxJMOB56FEC0xZY1zIHrnAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsGemtbHDUA9KmN9hENBUUSyaNc6IcpVDwSfgPS4WOSDZpSmFkhMu7at6HfBmPYDHya8TQC7U0r6NBnuedS4Q5ib9omBwjbhrmHSgACzCYS40gmQYdMzRLYszJSu6FrBmK5lkhMfwXwKM5trOLdh6PIUzn+vt7rGivk7dkw5Vz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=PTz2utpP; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1776866853;
	bh=Pzt9GPYqHlrWqMYF6Atgi6G7hlhArIM+lXCWpMBLm64=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=PTz2utpPHnseddN8RO57oT43bhQnRj1D9ged1D5L4rej6fPZh8s+aVo9uQLi6jV6c
	 wpwP7yne1wvnYBOwnj2Nrb2gjm+miV1j5csyzD3sjfIC0fkUp0PAGheTiHiB0I/SsM
	 2EAwSJc0IjoWjtSpVOitQiUPoxO17SfW+s9N44Xs=
X-QQ-mid: esmtpsz20t1776866828tcbf70014
X-QQ-Originating-IP: D89ux7nbIrZe8FgffEeW4vPH0ULFL2ShFsaUTkYnHy8=
Received: from uos-PC ( [117.152.201.246])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 22 Apr 2026 22:07:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8588048875818352576
EX-QQ-RecipientCnt: 15
From: Morduan Zang <zhangdandan@uniontech.com>
To: michal.pecio@gmail.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	petkan@nucleusys.com,
	syzbot+3f46c095ac0ca048cb71@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	zhangdandan@uniontech.com,
	zhanjun@uniontech.com,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net v2] net: usb: rtl8150: fix use-after-free in rtl8150_start_xmit()
Date: Wed, 22 Apr 2026 22:07:02 +0800
Message-ID: <EAE04AB0AE928B9F+20260422140703.103227-1-zhangdandan@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260421220547.2f7f9d85.michal.pecio@gmail.com>
References: <20260421220547.2f7f9d85.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NoAfPw89eVWhelEs7weV/9IGsjQ/pECZvVQlLIdKw+uy9HbpaGmUzXI5
	RYeOyc4trlylqWYn0S/FrmWmL3+dZhX1gIJBBTifYkaKGokDxrrKyvliDO40AlRuIs+L/y8
	FI4d+y16HrShDk2lBzl7Gtj43pD8rlDxy/gYd2y84xEhtObwoGytKeQ9OuEWNIl4cm+UIgn
	w6L8DqPtKY+Dnl1umf5J2xyp0qbV97Kha4XbZp983IclYNfugHtg+9QhlQDLblpmOrUmbEF
	lMpHd3AeVrJ89e+dGpvgsoBAjdL37ExroM5wMr0fbIjvVU1Oby52f+FVn5nGpciWsNBxJoC
	gnLNwOkSG59LpnCrgfFXxQKFQ4dQ+ibAvzQ4K3RtCvZKT3kxiloYP7U3cn6fEthskFZcyDL
	aVW+e+ZOHNfES1GzNRSeevSoenD+drSRisjI7p4dwzPtS+5sJk3vKLiWgM4dDn5DIv0bP/s
	keDuzT/KjhWgfKZ0RckWgktg8j2vfn3QHGbEoxYsQADEZ1HZlFfkIjjn292qQKcUGs15j0p
	aUHjrffYLe0CiFqVTE3i1G6NJn0IaCe1Iiyi3+sEiAwPwerfTJBFcFW/Xbo5hSZXqoRKOs0
	K84FrViBYpkhqkbdHgW3urzxFky7/VAzxNYwgyOMPwuDeXbkv8kY9P1EY6lxZ4krXyqmVZL
	7FFGxpCZjefmtw3fXbvqiZZ8w9rbVrrA9Hxk/hVkzYr+FU5UWRCWQH9Gd8kHkLcRc+nXXk/
	dpuX5nGTxg33saRKCKXV6MaGsNf9yVHcJc/poq53vyNVtbm2vsyL88lJSXcXzEEZz1Pru9e
	oDtWA6t22tYSw3iDIzSELXaYoGFtQoE3zemZfPfQFip0SxGbNSGrqoV3FpgoDb4A9q79EAf
	rZMNnjOylhX2Q/emTA3JlyaSbGBjg6nOivx5y49IH8AYl3q1Eb1i0AQzSKBbvVuHGSh4Wbb
	xGWUGM26z6/UpRi8XfgZNMdBzDAyaVOG5k1TftYLCXDIKb99FpQVws4StWy6XnX68zRbBrv
	HYMf8PPoqs5a2+4BHoX9D2CkvmcifbMWZ4SX/89UXYHjr5KsUWIy7CYDV569RNwCV3Sk0WD
	utMlSS3tAIxKL9EuCYrYudkDcsp6T+Yrw==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280435-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangdandan@uniontech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	MAILSPIKE_FAIL(0.00)[172.105.105.114:query timed out];
	TAGGED_RCPT(0.00)[netdev,3f46c095ac0ca048cb71];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,lunn.ch:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url,uniontech.com:email,uniontech.com:dkim,uniontech.com:mid]
X-Rspamd-Queue-Id: 57C4F44713B
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


