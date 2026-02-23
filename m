Return-Path: <netdev+bounces-260170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC7VDqionGklJwQAu9opvQ
	(envelope-from <netdev+bounces-260170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:21:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC1F17C4AD
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59DC1310EEA5
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F14336E494;
	Mon, 23 Feb 2026 19:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="acfXjAFp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f99.google.com (mail-oo1-f99.google.com [209.85.161.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70CA36BCF0
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873933; cv=none; b=FPQXgLO5k31b8Beh+yfG8+OxUJsoT3GJr5XG1kFK5CrIsxLEw7HZNxdNqdguEK+7jbhLycIXd4q5WF2h7IK6grnVCYcqHb8c8E/TuVCTnzpBDTBBQvWfLfzzg9Mba9veZGR9V/xVelabjW25s7fE4VnEXdY7vYq6peeykpDBR0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873933; c=relaxed/simple;
	bh=WutPYL4cG/EXST+jBmz13oiyimF6V23PC8A+85qvxYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOd+nSMr80UwyqkGyQLc4kG6iv+a8PVqmDOamReNAjyKntLxFURYcYK8XjYuV0bIiqL4sGtbJSJ0S2fLJGWyyoAw33n4DLtyGpcOcJEigqAaWBZalCnrmPgZfMz3klMWa7NyK1FLuyrbUm4VxbPremOlW+xRY4qMrUTJ9l8uyuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=acfXjAFp; arc=none smtp.client-ip=209.85.161.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f99.google.com with SMTP id 006d021491bc7-673f0b73dd3so2549325eaf.2
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 11:12:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771873931; x=1772478731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v49c/0FsrhD7zmHG67B+ZI0NaJwp1KpfxbdYTpU5cag=;
        b=av18gbN8DTPYWxuG9h4/L9k9jDao95ehR6HDtVipW8WtTlIZy7Rj8IFPK2FH9sB4vp
         aKcQw2oHYdMBtDCjK3kHkvTGJUqCJx42dpQNc5FL9dgTYm2nwKbVDFijiN+6LDKh5vVL
         IDcqYgpKodCWnjejwJ2JxAhv+uRwmapJ7Pv2xWKidD3duU6Aw6lK4b9tkZHBTS0jDjKe
         +K73ZS+iNe+RynrtQdtx1UVPhzKBAx292XKI1VgQ3d6NZzsieWwZWj9TKQMlBF2O9VFo
         aVHl2jmh6oyMt/i0pvgItoyQiYmE08JOCMCBSy/2nrKgsHmuj0GqoWC5aBBUsCin3T/G
         YtKw==
X-Gm-Message-State: AOJu0YzMvswchU7ZZG5fqDsa8i3EYZ9Tyacz2wFXsdtrfh3paHAcbtrM
	WqEudS/l0gRt5vCJ7oxbayDq0VzxNlGJvf6jHJyHBpH7+c1Kfa9luiHVCb1CTy3s3+bGexr/3Vk
	6ar+FG0khSynodRva6t7jtzzG8OAXX1LeE0CrA2efN/4AqVmX8PzGPkGwqSd7+5I6okqhWtBCoo
	sYYCygyzhF5wU2Qd96tbNpvWlx38/0hVqkJ5WqNKdF9zF+yQG/KMdm5pLVQlhjBVFtllJnvX31c
	3ev+i0ZGgOZ
X-Gm-Gg: AZuq6aIGEt1yx2dav1rPN3nIiualLJzjODJR+zJ/BinBOrDwc/0gN4GfaVGeH+F6OdZ
	fX6IWVyU5uXibpEQ0mzo4pqIaDb3SnA3bsES5X2EBUWooNhTecMWBbZbATs7RJk9B89UVMhq5Tt
	45SwwC1j1lTvhXmUArz83aeODCqz0B5FKQnPQIq1FGn1ClYIl2QWlFEKmyuiUAkVmw91AfPnjbU
	L1fWnDQ/ZOhC9i9FE6CW14yZb2Y3FLcauRACAYlQX7QTtZyhyq+87zcyYCOR/M8EV1961Sk8BDI
	clKq+2rwngeE6SYhn0krlmb33C++XqtGk5o2w4qWJd2qe8TiJJp8G/lKszpL13L7+OYjPeaDk/N
	QUUOLVSLjO+33Sv1h5Fcb4Emh8fdhL5KBh4JCGSiZUkR9sSpfOzacHrXduTX8gZFgVlZrTnsdpX
	5EOnCNL+a5Iu9gZFffPecDQWL2H4C9TqPjHZ+eRxOlm4y95kBU65qrETmk8A==
X-Received: by 2002:a05:6820:468a:b0:679:a560:cac5 with SMTP id 006d021491bc7-679c45082ccmr4129009eaf.46.1771873930641;
        Mon, 23 Feb 2026 11:12:10 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-679c56431cbsm894619eaf.2.2026.02.23.11.12.10
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2026 11:12:10 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2baad797d0cso22226162eec.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 11:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771873929; x=1772478729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v49c/0FsrhD7zmHG67B+ZI0NaJwp1KpfxbdYTpU5cag=;
        b=acfXjAFpsNi9FJIrVO3kZ6P80IFlS8Q1QNlkavqBSK1w05O0yW7c+2hrIf9P7PF0T/
         YG2udLj3Z7JcD/UV6KoFTOjoEdYWD68hsS24tAwxLvv8ZJelwFVopm4VGF43Ga1SkJsZ
         ySJXDUItGladoUmBKU4r6HZ0oBOGtrfDgA0Ek=
X-Received: by 2002:a05:7300:d505:b0:2b7:32a6:82d1 with SMTP id 5a478bee46e88-2bd7bae915dmr4336138eec.13.1771873928885;
        Mon, 23 Feb 2026 11:12:08 -0800 (PST)
X-Received: by 2002:a05:7300:d505:b0:2b7:32a6:82d1 with SMTP id 5a478bee46e88-2bd7bae915dmr4336120eec.13.1771873928176;
        Mon, 23 Feb 2026 11:12:08 -0800 (PST)
Received: from lvnvda4076.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7da3eec5sm5332734eec.4.2026.02.23.11.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:12:07 -0800 (PST)
From: Kiran Kella <kiran.kella@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	daniel.zahka@gmail.com,
	willemb@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jayakrishnan.udayavarma@broadcom.com,
	ajit.khaparde@broadcom.com,
	akhilesh.samineni@broadcom.com,
	Kiran Kella <kiran.kella@broadcom.com>
Subject: [net-next, v2 1/2] psp: Support for transmit on logical device when the underlying transport device supports PSP.
Date: Mon, 23 Feb 2026 11:11:53 -0800
Message-ID: <20260223191154.2800616-2-kiran.kella@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260223191154.2800616-1-kiran.kella@broadcom.com>
References: <20260223191154.2800616-1-kiran.kella@broadcom.com>
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
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260170-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kiran.kella@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim,broadcom.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: ACC1F17C4AD
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
 net/psp/psp_main.c | 109 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 1 deletion(-)

diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index a8534124f626..fac785dcfa0f 100644
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
 
@@ -313,11 +352,79 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
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
+		 */
+		psd = rtnl_dereference(dev->psp_dev);
+		if (psd)
+			rcu_assign_pointer(upper_dev->psp_dev, psd);
+	} else {
+		/* Lower device is being unlinked from an upper device.
+		 * Clear the borrowed psp_dev pointer.
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


