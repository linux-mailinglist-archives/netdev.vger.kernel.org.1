Return-Path: <netdev+bounces-261542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIepNk+XoGnhkwQAu9opvQ
	(envelope-from <netdev+bounces-261542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:56:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4381AE106
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EC2032361A7
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F357238B7CF;
	Thu, 26 Feb 2026 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BMjhZwl+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3AD36215F
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772131627; cv=none; b=nfifCFY5K8eOrg6sT/9oSO5mvlLM34FqyOwRwwRH5+cZEgx+1C4YEhcp9wxKb9kGldKfBVNG5lHll2EOooLF3XGy5wzbMYw2hAjV0fKWxdxawa8N49uBVRuG5WPnpQW7JDbSl7shG6tqmR57ZML+nH4zoFp9gD3kL1icOOKamrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772131627; c=relaxed/simple;
	bh=W86nEt6NxrH/azDYUo8e8qcXbO9XW3P9ASHlOypQvuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYMhSbWiTjPZn9rsqibMmRS3Yw3SbLbvHLbZJXlTtmw4g0meQtSiQmg6RMdNstYtSIB8x39Yd7BG0WN/62KB/PCgSMN3Thpx6CxEKs8o8QueitkjRybDC7FEVtGmx7Wev/n6OBOl+WT4J/1fbQonB81JPXSIxgo7ZKYTj/QbgRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BMjhZwl+; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-358f3ef464bso649835a91.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772131626; x=1772736426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HBpIii1a6ci9G3XxJ980AkP2auUKLh+wfXsf/L+7o90=;
        b=XML52fck9iycuw8k+n0e/IrDT1kYuOwyFdyiwqTyZJb1WzFj9Rba59jLpct7zrAVWA
         uio3qjMhsnB5OdXyOc1qo7n9paITeks74kAwjLmaCMIdeZFGmtUZAwf2Pty4TtEkrHYV
         WbMN4iy3pvqMASrSA4z74Dm+11Jf9QAbwH87atjOTTqcbzl0zLWgynprml5+PaoHZolB
         zIe8LD4zqSH1a9/CgOKyfmtnW8OcPuxl04QQzXR5PMcKwKq56tKnKtxYq8JXwddIdwZj
         x98M8frThVgPgNxmi3iMEhqdIqR4akvVD10WTHf2E7g1Oz+b7xGrRgos9h5jkOHB1/4K
         oqhg==
X-Forwarded-Encrypted: i=1; AJvYcCVEXv6X2EH5KHssB5haM4WeaqUa4xbnk+Ar6ps9853OC0eodo+S2JKwz+sT2VrcRJ8Z+eXlTtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4go8wJUNTaueOTq0eOoYMs4WbUzoQCtJdLQWQPOAqJ8WGbR9B
	MAV3fyaao1R9YHR63z4/OG34BECFqTAZrreyX8apU1+7MQ4h9dlXoGAH4Zksb/JanUsFYdexOCw
	SXSda24B9dn9y44CjftgJSl0ul0CI8dNK60nkobvloznIJs0y47vevZ78yEX7QlywccZ3vCQ9X6
	zgmtaWM8SOz3sAfVxCF9VWoekjcGrlNWjmjHaJy1jgDHr2ue8hZ2TkRTY/Obvm+OFgSWDw8krhu
	zovpvwsRq5v
X-Gm-Gg: ATEYQzw9mmV/fWU9z/J/CfIGYeWKnFvlz5MJ3VjlOfCt51P1T82PEoh0fsOBnrahV6G
	YCh+5aSxkV7IpCu0DKonvvZWqYlsCK4wIBGHrafI0gRmnz3PsVpfNyTeNkwGzocDKWSR+vaiLHl
	2HJjrOncXeapSZmOJTEI+wLt1oraT5Kjm/oc/CGSNtQAZcEftbpqANMkd24QzEayg7wVwZ+2DGz
	WV9N0i3nk8YQYiXy7et5lKrnpekF97WRslhK4hSUz2w+AS2kg1pQhRGDhSDlRN2ljuEyAD4ON0f
	lN7cVHp2nfO6lVPIpfkg2U0sZt+aJHunPB/b69XTcYrZ9/YMm1gfCy7+4WETpl+wOBgMmoO+Uim
	98Xvn9tPngUa3AMrWtTIhe616GuhKi9/sI4EPr2Vui/zSGp9lsU1tzK6ZNx20HZ/bD5zH9P8Jw7
	OTTj+neEnozNKzqweObpqiJsik8IvrV+RFX3XpnBRxosSupwjGOJXNdmboOQ==
X-Received: by 2002:a17:90b:2584:b0:339:ec9c:b275 with SMTP id 98e67ed59e1d1-35965c3af48mr134460a91.6.1772131625729;
        Thu, 26 Feb 2026 10:47:05 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35912e0f4ddsm260659a91.0.2026.02.26.10.47.05
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2026 10:47:05 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb706313beso146301485a.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772131624; x=1772736424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBpIii1a6ci9G3XxJ980AkP2auUKLh+wfXsf/L+7o90=;
        b=BMjhZwl+v5s540crhK+DbKGFvgdHrEnRvb5G9cmDJgjnTnyIEZfbV3EuiMwSdvKMFU
         hasOfPLbTeCeBYUv5aaViH5ZF35IPwPZ83O1m9p+jIEfJn/2nt3WAyAKlWd78fBY4df4
         Stv0iwVGeQjkPVldaBeoWWCJSvWW7gM63k9Lg=
X-Forwarded-Encrypted: i=1; AJvYcCX+J1WUNUlZUL3pWDIGjWtXBtgM5WA9eCi3ZrDZM/Nil9v/9IPrklVmLmCtoZlnJa14wnTarpk=@vger.kernel.org
X-Received: by 2002:a05:620a:1a90:b0:8ca:55:ac60 with SMTP id af79cd13be357-8cbc12294fdmr421800985a.78.1772131624393;
        Thu, 26 Feb 2026 10:47:04 -0800 (PST)
X-Received: by 2002:a05:620a:1a90:b0:8ca:55:ac60 with SMTP id af79cd13be357-8cbc12294fdmr421794885a.78.1772131623840;
        Thu, 26 Feb 2026 10:47:03 -0800 (PST)
Received: from lvnvda4076.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6f5c41sm255721485a.24.2026.02.26.10.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 10:47:03 -0800 (PST)
From: Kiran Kella <kiran.kella@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	daniel.zahka@gmail.com,
	willemb@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jayakrishnan.udayavarma@broadcom.com,
	ajit.khaparde@broadcom.com,
	akhilesh.samineni@broadcom.com,
	Kiran Kella <kiran.kella@broadcom.com>
Subject: [net-next, v3 1/2] psp: Support for transmit on logical device when the underlying transport device supports PSP.
Date: Thu, 26 Feb 2026 10:46:53 -0800
Message-ID: <20260226184654.3180648-2-kiran.kella@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260226184654.3180648-1-kiran.kella@broadcom.com>
References: <20260226184654.3180648-1-kiran.kella@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,gmail.com,redhat.com,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261542-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kiran.kella@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim,broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3E4381AE106
X-Rspamd-Action: no action

This is achieved by propagating the psp_dev from the lower device
to the upper devices in the device stack via a netdevice notifier.
The lowest device owns the psp_dev pointer while the upper devices
just borrow the pointer. When the lower device is unlinked, the
borrowed pointer is cleared in the upper device.
Assumption being that psp_dev is set on the lowest device before
any upper devices are stacked on that lowest device.

Signed-off-by: Kiran Kella <kiran.kella@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
---
 net/psp/psp_main.c | 117 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 1 deletion(-)

diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index a8534124f626..303a3af3bdf2 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -3,6 +3,7 @@
 #include <linux/bitfield.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
 #include <linux/xarray.h>
 #include <net/net_namespace.h>
 #include <net/psp.h>
@@ -110,13 +111,45 @@ void psp_dev_free(struct psp_dev *psd)
 	kfree_rcu(psd, rcu);
 }
 
+/**
+ * psp_clear_upper_dev_psp_dev() - Clear borrowed psp_dev pointer on upper
+ *				   device
+ * @upper_dev:	Upper device that may have borrowed psp_dev pointer
+ * @priv:	netdev_nested_priv containing the psp_dev being unregistered
+ *
+ * Callback for netdev_walk_all_upper_dev_rcu() to clear borrowed psp_dev
+ * pointers on upper devices when the underlying psp_dev is being unregistered.
+ *
+ * Return: 0 to continue walking, non-zero to stop.
+ */
+static int psp_clear_upper_dev_psp_dev(struct net_device *upper_dev,
+				       struct netdev_nested_priv *priv)
+{
+	struct psp_dev *psd = priv->data;
+	struct psp_dev *upper_psd;
+
+	upper_psd = rcu_dereference(upper_dev->psp_dev);
+	if (upper_psd == psd)
+		rcu_assign_pointer(upper_dev->psp_dev, NULL);
+
+	return 0;
+}
+
 /**
  * psp_dev_unregister() - unregister PSP device
  * @psd:	PSP device structure
+ *
+ * Unregisters a PSP device and clears all borrowed psp_dev pointers on
+ * upper devices (e.g., VLAN subinterfaces) that reference this device.
+ * This prevents use-after-free if upper devices still have borrowed
+ * pointers when the psp_dev structure is freed.
  */
 void psp_dev_unregister(struct psp_dev *psd)
 {
 	struct psp_assoc *pas, *next;
+	struct netdev_nested_priv priv = {
+		.data = psd,
+	};
 
 	mutex_lock(&psp_devs_lock);
 	mutex_lock(&psd->lock);
@@ -137,6 +170,12 @@ void psp_dev_unregister(struct psp_dev *psd)
 
 	rcu_assign_pointer(psd->main_netdev->psp_dev, NULL);
 
+	/* Clear borrowed psp_dev pointers on all upper devices */
+	rcu_read_lock();
+	netdev_walk_all_upper_dev_rcu(psd->main_netdev,
+				      psp_clear_upper_dev_psp_dev, &priv);
+	rcu_read_unlock();
+
 	psd->ops = NULL;
 	psd->drv_priv = NULL;
 
@@ -313,11 +352,87 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
 }
 EXPORT_SYMBOL(psp_dev_rcv);
 
+/**
+ * psp_netdevice_event() - Handle netdevice events for PSP device propagation
+ * @nb:		notifier block
+ * @event:	netdevice event
+ * @ptr:	netdevice notifier info
+ *
+ * Propagates psp_dev pointer from lower devices to upper devices when
+ * upper devices are created (e.g., VLAN subinterfaces).
+ * Excluding from this logic, the upper devices that have multiple lower
+ * devices eg., bond devices.
+ *
+ * Return: NOTIFY_DONE
+ */
+static int psp_netdevice_event(struct notifier_block *nb,
+			       unsigned long event, void *ptr)
+{
+	struct netdev_notifier_changeupper_info *info;
+	struct net_device *dev, *upper_dev;
+	struct psp_dev *psd;
+
+	if (event != NETDEV_CHANGEUPPER)
+		return NOTIFY_DONE;
+
+	info = ptr;
+	dev = netdev_notifier_info_to_dev(ptr);
+	upper_dev = info->upper_dev;
+
+	if (netif_is_lag_master(upper_dev))
+		return NOTIFY_DONE;
+
+	if (info->linking) {
+		/* Lower device is being linked to an upper device.
+		 * Propagate psp_dev from the immediate lower device to the
+		 * upper device. The immediate lower device would have already
+		 * got the psp_dev pointer set in a previous notification (or
+		 * owns it if it's the lowest device).
+		 * Upper devices just borrow the pointer.
+		 *
+		 * Use psp_dev_tryget/put to guard against a concurrent
+		 * psp_dev_unregister that may have already cleared the
+		 * lower device's pointer and started freeing the psp_dev.
+		 */
+		psd = rtnl_dereference(dev->psp_dev);
+		if (psd && psp_dev_tryget(psd)) {
+			rcu_assign_pointer(upper_dev->psp_dev, psd);
+			psp_dev_put(psd);
+		}
+	} else {
+		/* Lower device is being unlinked from an upper device.
+		 * Clear the borrowed psp_dev pointer on the upper device.
+		 * Any devices stacked above upper_dev will get their own
+		 * NETDEV_CHANGEUPPER notifications as the stack unwinds.
+		 */
+		psd = rtnl_dereference(upper_dev->psp_dev);
+		if (psd)
+			rcu_assign_pointer(upper_dev->psp_dev, NULL);
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block psp_netdevice_notifier = {
+	.notifier_call = psp_netdevice_event,
+};
+
 static int __init psp_init(void)
 {
+	int err;
+
 	mutex_init(&psp_devs_lock);
 
-	return genl_register_family(&psp_nl_family);
+	err = register_netdevice_notifier(&psp_netdevice_notifier);
+	if (err)
+		return err;
+
+	err = genl_register_family(&psp_nl_family);
+	if (err) {
+		unregister_netdevice_notifier(&psp_netdevice_notifier);
+		return err;
+	}
+	return 0;
 }
 
 subsys_initcall(psp_init);
-- 
2.45.4


