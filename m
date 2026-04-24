Return-Path: <netdev+bounces-280913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEkVHPTN6mkfEAAAu9opvQ
	(envelope-from <netdev+bounces-280913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:57:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3D8458EE4
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A2AB3014BED
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 01:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A833A1E2858;
	Fri, 24 Apr 2026 01:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="CqFWV5Y2"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D61876025;
	Fri, 24 Apr 2026 01:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776995824; cv=none; b=fLm/FoszpzG5Fp69jHgLtsaKdSh2XJorEocu+kCMlJDeKdiON9I5GlqkvjBrgkDlocQPz7HYnVOlprmWdCDEEYQPEnAIDGx9KtISCHI9tRtroWvfKJJJnuB4NXmA19xm9gNAO1dU68PUwimR+HxS/zsqAK5J0dQ56KXbl3PXk1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776995824; c=relaxed/simple;
	bh=HdOtbwdk9FpqvYfnRdX3mN0oIsQ5L+ZuvG2V0TIlPyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWDpCsyszMn4PRtEuOCBhf6DlH5m4QQygIOcIclxTbLrBhZKQRIIUbNX83Q4RRAx/DghVQGYJ3NRSYUgiRzGRhZAJVASunzEI7ET8Lh9iL6Ctunxd9Up05CMqdhPqgheTc9dwG4iYRYNMeQ3qC/u6AoQajxYYBso9kNjciDjfg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=CqFWV5Y2; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1776995739;
	bh=/WbhmryfbR5rTtIxz68wt1Q3jNDu5a6qDNLkLdm52qE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=CqFWV5Y22diwVcsdaCir4tuD+VmAIrzkTzw01PdL1jbg2ER4Maw9RFzCc0i3h5WPa
	 +xCPYOXqnZ6iOl5Ra1Orsh9kkzr/r6jhI6awo4EZlRlzpeoXNwTwXivKWFP2OHH8gX
	 F+OZTd7WwcKIhblVphw2ztsPslHZ/GccGdyd9iBY=
X-QQ-mid: zesmtpip2t1776995722t1f251fe9
X-QQ-Originating-IP: U4i7rVTqbazz0Zv0ycg9ZtpkPwmjJiTQyT/w9lb7LYE=
Received: from uos-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Apr 2026 09:55:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15541475564338445808
EX-QQ-RecipientCnt: 11
From: Morduan Zang <zhangdandan@uniontech.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Petko Manolov <petkan@nucleusys.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Morduan Zang <zhangdandan@uniontech.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net v2] net: usb: rtl8150: free skb on usb_submit_urb() failure in xmit
Date: Fri, 24 Apr 2026 09:55:17 +0800
Message-ID: <E7D3E1C013C5A859+20260424015517.9574-1-zhangdandan@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <678BC10BB9E39322+20260421111025.15833-1-zhangdandan@uniontech.com>
References: <678BC10BB9E39322+20260421111025.15833-1-zhangdandan@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MDGUoPnBmw7sPREF4YgrfPnyBu3MQcPuA2pnCLNq9yHGg1Ilh5cXONuO
	v2wjzIt+Jx7HqIOJNWrstpwJEwo87K9czI72fV4lXYMDoGVBnA1Cs/FBjoprIIMg3WD8/wR
	XfiHBHPRF5hRNARXksculVzd6W43pStWvtBvkdEqZQ9mAiYObl2EujjGE3g1W7b1j0Yb9GI
	crUXUxEhHAlwU8th96SFpliQzj68g1ku+wxGLLe3m/x2LTcLXRdrTiFrm4DaJF3oO+kmCQ/
	7d3xrl96eWD/3NhV5M0Dkyz170H/IZhaqjBI24WUDZQprbALw14njFpjEhByYWqkT9hddBh
	vASGk11V9gI9hiyAlarBCANTsY7Cve8aEvJGUGpPe+inxLLw32lyBdE6yxobPnbJ6tVjo/a
	VCpKmPrAuIeKWDlM+myeFIeQxB+FOJkwrlXBO8pzTPUcNO6ZdF1RQAVr0rcfCt5ykNRLDRp
	3bpydjRw6mpJAA4C/g9hJvawg00sKwccookIgadqqVZW1qX2Z9bY9MNhnfqINyguhoP27ii
	Hdqnr7xx2C8uhOH/N9/R7ra+YLFtHH7NqNhcd+BLqI7v9m8vUOmbDDgs2AmKTy+0GPGF+i+
	+ilESa9F2lLTCCzc/W/yS8t5reicxbcG+sYT2Q782nno3Nwq/UpyJqh1YlOXNk5M21jnrPM
	nN6QO8IHtiopp4IQb7t0vUZ0gDUIeDcBrtdu6A1xB1bpY8LncR8r1yAnkvTSs/4JQKDUET1
	hgLUTgup8qYRbLJRgX+7xa8Qpnj4g6umZDFZM+yRRKet4IDWvhGedBezSKFkgVVolfKLy9f
	EeXGSmiVzLevvLziCHwOFCJo/ujFO7sei1Dbv4WFPbqzcKGjKpXlA0kLEIK0DXB5UvZF0LT
	usXezy1zIfpyzjvxGr4sPKa8bPTmI6IXi4vul/ky6caxOwQhV+s/E9Xyh4eFLu8uJsXajkI
	6nphfoFtsZVTfuue8l0UjlNd5rNpy2Yeeioos5Y4XQ1pI12vCxNZ3PUO2i8VJjvv68hPwze
	5SGParR4Ax38oFsKTu/s121+qyXIqfH929CGBLnQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 4E3D8458EE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-280913-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangdandan@uniontech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniontech.com:email,uniontech.com:dkim,uniontech.com:mid]

When rtl8150_start_xmit() fails to submit the tx URB, the URB is never
handed to the USB core and write_bulk_callback() will not run.  The
driver returns NETDEV_TX_OK, which tells the networking stack that the
skb has been consumed, but nothing actually frees the skb on this
error path:

  dev->tx_skb = skb;
  ...
  if ((res = usb_submit_urb(dev->tx_urb, GFP_ATOMIC))) {
          ...
          /* no kfree_skb here */
  }
  return NETDEV_TX_OK;

This leaks the skb on every submit failure and also leaves dev->tx_skb
pointing at memory that the driver itself may later free, which is
fragile.

Free the skb with dev_kfree_skb_any() in the error path and clear
dev->tx_skb so no stale pointer is left behind.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Morduan Zang <zhangdandan@uniontech.com>
---
Changes in v2:
 - Rebase on net/main as requested (Jakub Kicinski).  v1 was based on
   a tree that also carried the pending UAF fix ("net: usb: rtl8150:
   fix use-after-free in rtl8150_start_xmit()"), so v1 did not apply
   on net/main.  v2 is an independent fix that applies cleanly to
   net/main on its own; it does not depend on the UAF fix being
   applied first.
 - No code change besides the rebase context.

v1: https://lore.kernel.org/all/678BC10BB9E39322+20260421111025.15833-1-zhangdandan@uniontech.com/
---
 drivers/net/usb/rtl8150.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index 4cda0643afb6..9999484d2c5e 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -707,6 +707,13 @@ static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
 			netdev->stats.tx_errors++;
 			netif_start_queue(netdev);
 		}
+		/*
+		 * The URB was not submitted, so write_bulk_callback() will
+		 * never run to free dev->tx_skb.  Drop the skb here and
+		 * clear tx_skb to avoid leaving a stale pointer.
+		 */
+		dev->tx_skb = NULL;
+		dev_kfree_skb_any(skb);
 	} else {
 		netdev->stats.tx_packets++;
 		netdev->stats.tx_bytes += skb->len;
-- 
2.50.1


