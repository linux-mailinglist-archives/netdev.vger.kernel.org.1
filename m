Return-Path: <netdev+bounces-280078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qH9MMdBZ52l87AEAu9opvQ
	(envelope-from <netdev+bounces-280078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:04:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F3F439E43
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1238E30054C6
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D513A63E6;
	Tue, 21 Apr 2026 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ibDJ1d/+"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB12E2DC32E
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776769485; cv=none; b=u6j8VSxrnO2lrFbBnrGo5QvXpWLtLQRB7gVgosbRjGURC5BRrsmyeUro0Sfey5Db6ldsW5HrH94aeiH+W9JjqBe5KoWzU+b6ztMp3gZMbTIFm0+gepNkBUh2qN3N9MX+K4Pxay2OaJFkAcRyRc4xSP7hk0HZGCQ3TghLbGn/NCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776769485; c=relaxed/simple;
	bh=8KEzgBfJPk+HdBFZv03fj4yzHf8LTSmc9knCLBlbz84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bo9bOqvWjd6uSH3gdLkfpuyCeE1khn14AO35sRb0DZoQZ/cKXelsnoM8ql2MQqTxoQd7peucKDmGVytSHX+yxRAGgsEfTdFYG1+MAR/zX0fyr4lTlzIBtPrd0wQSrmBsAmI5yc4qFJBICkErpZy9czGDeX92nlipKOGWugt/ovM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ibDJ1d/+; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1776769471;
	bh=/ynnzt909O28YlGBTKFxGJ7g+e9fS69e68tbjlMPoTQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ibDJ1d/+Q2hd7ZJHcJKE6vlikZg6WZubmqctg6xb1iIP1b5bOu/12tHUOurBEj+7S
	 yUGSkcTZcphEM2JaZwg0SlbHQdxqe6JEVQhN1lkTGPqVIcP5hmUIVzOygZMto1dQb1
	 HuGO6+GEQ8NjzEaUW45gZy2TN2Oa2tZL0HtCzDsQ=
X-QQ-mid: zesmtpgz7t1776769456t6da3a5d4
X-QQ-Originating-IP: bj0CFm39qn93aOtJfsj2zpKiKagqBcLRDYCe0AmeJ/4=
Received: from uos-PC ( [117.152.201.246])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 21 Apr 2026 19:04:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11467599837711659355
EX-QQ-RecipientCnt: 12
From: Morduan Zang <zhangdandan@uniontech.com>
To: petkan@nucleusys.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Zhan Jun <zhanjun@uniontech.com>,
	syzbot+3f46c095ac0ca048cb71@syzkaller.appspotmail.com
Subject: [PATCH] net: usb: rtl8150: fix use-after-free in rtl8150_start_xmit()
Date: Tue, 21 Apr 2026 19:04:12 +0800
Message-ID: <73ACB7391A6DE033+20260421110412.14795-1-zhangdandan@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OWtQnHCUpsEzAqoVxAmvA/6tG5UERKjqMzxgr4de/LCu25YKdC5mXfXX
	ooihpBqYkJNmxtb1v1FujqX6W5UQBWX4pm/Gu5e19S6wNFgNHzbxMWh/pLm6Jsy/sQmAKFX
	JFonflKs9EIex+J+nJ5mStSP2DGYmKrSZkFcka1STGv/NuGO7ZTkkTLNPczqr7gbDaRIipJ
	UmftTDd37IapuPB87ombIOVoj+Vd8f2Tu73EJfEVqu+ZgbeeqIN2reR84LZAPR320YZK/vF
	L7ZXYT5+6UiXOrjhHkRKweUa9JFaYBc65mA60U7Bc6qKQPwOn1csybn1W/jRMNr/1aHdxfD
	Yaynbo+gjBiqaMbflojjk6Nlimu4nMBe/UflVaJMLpVxBj3NLv2jesfaTzUagxwPoubSal3
	mMHULfLqGzGVwH19HN2KDeed/9Q714UpP5Yd3TpXAI1CFyUim7Gufs1aBLvtQ1ozfDAH0W1
	fgEKssvPh78B8fSRCGzp2PsYbvTjzQm6f+sodnl/m7SoQgp3q9KBX0zXGTkdfx7i+CMAO0/
	ZLGwkAGrnfuKy63oKGnVF4xqd37yq+2/yif3l8iKkDzRgWOQ34ZW4DrNar9rb6fqYpPe9l/
	LKQnvZZd1i+v2JRyktDSbeKWXZecNy2/bGGFJiMAV1N79QnacBuTIYLcGlx82tZSX2BXml1
	uT6jjARjtuyXbWnwXr3yXiQ3mg+6MWTDhhd9rtYaRllpXh2wtzCj0Pfb6do8B5CCDpB60Ic
	Oh9NJN9H/Pnk8U5hOMkAzP3/H5VUwSuq0Ob9EMyPCI3KhgMVG5o48UO82efiYGzJ8Hkh0Ne
	hMcNbFT06vk6Ju6EAXSSIPqgxuJgzDA9Cts/FQxhSQx37Skg/wuffVXy8KgzHGuw0ZGE770
	a6XOENmRKMDegqIPuiCVnt1g3+mk6Dr/G7q14wM52OXRZQQYmF3ic0+evxI/NMcgLVwV/TS
	Axc49dSXvn4RkejpwyZphcdY5absy+MjipnWoiVU1292OxxjAI/wk5JhBzVyPXITTPwBtNi
	kieGxthw5DCVuBUDDWn9eJfkznJLAcHRqey9CRRysaLToglHci38N4gbpBXbfYrvOBrRZ4t
	t05Lv8uOF+Cbz8Q2/QrFug=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-280078-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangdandan@uniontech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,3f46c095ac0ca048cb71];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,uniontech.com:email,uniontech.com:dkim,uniontech.com:mid,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 07F3F439E43
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
cached value when updating the tx_bytes counter. This mirrors the
fix pattern used by other USB network drivers.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+3f46c095ac0ca048cb71@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69e69ee7.050a0220.24bfd3.002b.GAE@google.com/
Closes: https://syzkaller.appspot.com/bug?extid=3f46c095ac0ca048cb71
Signed-off-by: Zhan Jun <zhanjun@uniontech.com>
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


