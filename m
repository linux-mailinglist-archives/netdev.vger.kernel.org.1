Return-Path: <netdev+bounces-299581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WdlEMZ9WMGpBRwUAu9opvQ
	(envelope-from <netdev+bounces-299581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:46:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C84C689896
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:46:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Lj8ezV/i";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299581-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299581-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 040BA3116C69
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B903A3B3C19;
	Mon, 15 Jun 2026 19:44:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EE53B47D9
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 19:44:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552663; cv=none; b=igB70BBhc0cYWBNxZSFmtrWDmeUkVNraaWdh+nNK9IfofhdWq+ULnED8pV9n7C5ZsLfQOu6EYtursJURo0LiA92MiGOkqLBMqNRqKDGzfFKIJ5wO38oPl2NPY+/M9DOVO9gAxAXfl2eaLh5z33qrapIRPdctq8+sMIATgo5r4/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552663; c=relaxed/simple;
	bh=n2PZOOjlhkTwTFi1lGfyCLQenIRcbcqkMMlBuvpnnu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Shdpa3549/HzzQrCU9ystPnx5xdouqzXD9zKDbd2RtAi+ESRoMyTMi6rtKC9dtPBSsf9OKsRc6FpOC3KsNuKSqnFPgS91Ci6c0VpwGMhriLwg3IpxZXSOtMTqIKS7UCEF4W4Lnf9XH6EyI91E2li/QNT1kMOGZBBj+8NUkgvRrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lj8ezV/i; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A831F00A3A;
	Mon, 15 Jun 2026 19:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781552662;
	bh=aVvSSi7kJh3oFw2k0e7utBM4uIs/2zLy2qt2Syn+ifI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lj8ezV/iLa0CBNLNxigdlgO5DoArBlkr4Jq46U4jKxZeNWlZrQllkdRcoRUO13apz
	 Gqpgg9y6asLq/1/XZxTZOMVewfEZ6CsWIwX6KA/uz+YEDaM91VQxBjfKIy1UKHHUo9
	 LGocIHiG3o53YwQL93MQz6Hz2sSeNnpTnB5f4yGkodrxb4d4l7VSIFPiWmOaiH6OBG
	 R+EW/MO2t7T6j9l6erD1qyuPjQ41r50V5q7mPp37QHtYKBHYeKiBeetsBxyUVg+qel
	 2wsv58NACnWUNaCtwlxd9IGZ/maGmxGJWWDlhVCmF0U5aKq3rj3vXXLlnvbbzpr9IA
	 wED9p1ByOQnEw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	3chas3@gmail.com,
	mitch@sfgoth.com,
	linux-atm-general@lists.sourceforge.net,
	dwmw2@infradead.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 4/9] atm: remove the local ATM (NSAP) address registry
Date: Mon, 15 Jun 2026 12:44:11 -0700
Message-ID: <20260615194416.752559-5-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615194416.752559-1-kuba@kernel.org>
References: <20260615194416.752559-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,sfgoth.com,lists.sourceforge.net,infradead.org];
	TAGGED_FROM(0.00)[bounces-299581-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:3chas3@gmail.com,m:mitch@sfgoth.com,m:linux-atm-general@lists.sourceforge.net,m:dwmw2@infradead.org,m:kuba@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C84C689896

net/atm/addr.c maintained the per-device lists of local NSAP addresses
(dev->local) and ILMI-learned LECS addresses (dev->lecs). These exist
solely to serve SVC signaling: the lists are populated through the
ATM_{ADD,DEL,RST}ADDR / ATM_{ADD,DEL,GET}LECSADDR ioctls used by the
atmsigd / ILMI daemons, and consumed when registering addresses with the
signaling daemon. The LECS list belonged to LAN Emulation, which has
been removed.

With no SVC users in a DSL-only configuration these lists are always
empty, so drop the registry entirely:

 - remove the ADDR/LECSADDR/RSTADDR ioctls
 - drop the now-always-empty "atmaddress" sysfs attribute
 - remove the dev->local / dev->lecs lists, structs and enums
 - delete net/atm/addr.c and net/atm/addr.h

The device ESI ("MAC" address) and its ATM_{G,S}ETESI ioctls and
"address" sysfs attribute are retained - the USB DSL modems populate
the ESI.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - delete the get_user(sioc_len), technically this is a behavior change
   since we no longer validate the access to sioc_len before executing
   the ioctl, but I suspect this level of bug-wards compatibility is
   theoretical
v1: https://lore.kernel.org/20260613201032.77274-5-kuba@kernel.org
---
 net/atm/Makefile       |   2 +-
 include/linux/atmdev.h |   9 ---
 net/atm/addr.h         |  21 ------
 net/atm/addr.c         | 162 -----------------------------------------
 net/atm/atm_sysfs.c    |  25 -------
 net/atm/common.c       |   1 -
 net/atm/ioctl.c        |  12 ---
 net/atm/resources.c    |  53 +-------------
 net/atm/svc.c          |   1 -
 9 files changed, 2 insertions(+), 284 deletions(-)
 delete mode 100644 net/atm/addr.h
 delete mode 100644 net/atm/addr.c

diff --git a/net/atm/Makefile b/net/atm/Makefile
index 484a1b1552cc..5ed48d50df35 100644
--- a/net/atm/Makefile
+++ b/net/atm/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the ATM Protocol Families.
 #
 
-atm-y		:= addr.o pvc.o signaling.o svc.o ioctl.o common.o atm_misc.o raw.o resources.o atm_sysfs.o
+atm-y		:= pvc.o signaling.o svc.o ioctl.o common.o atm_misc.o raw.o resources.o atm_sysfs.o
 
 obj-$(CONFIG_ATM) += atm.o
 obj-$(CONFIG_ATM_BR2684) += br2684.o
diff --git a/include/linux/atmdev.h b/include/linux/atmdev.h
index 71c5bf6950e3..7abbd23fada6 100644
--- a/include/linux/atmdev.h
+++ b/include/linux/atmdev.h
@@ -136,13 +136,6 @@ static inline struct sock *sk_atm(struct atm_vcc *vcc)
 	return (struct sock *)vcc;
 }
 
-struct atm_dev_addr {
-	struct sockaddr_atmsvc addr;	/* ATM address */
-	struct list_head entry;		/* next address */
-};
-
-enum atm_addr_type_t { ATM_ADDR_LOCAL, ATM_ADDR_LECS };
-
 struct atm_dev {
 	const struct atmdev_ops *ops;	/* device operations; NULL if unused */
 	const struct atmphy_ops *phy;	/* PHY operations, may be undefined */
@@ -152,8 +145,6 @@ struct atm_dev {
 	void		*dev_data;	/* per-device data */
 	void		*phy_data;	/* private PHY data */
 	unsigned long	flags;		/* device flags (ATM_DF_*) */
-	struct list_head local;		/* local ATM addresses */
-	struct list_head lecs;		/* LECS ATM addresses learned via ILMI */
 	unsigned char	esi[ESI_LEN];	/* ESI ("MAC" addr) */
 	struct atm_cirange ci_range;	/* VPI/VCI range */
 	struct k_atm_dev_stats stats;	/* statistics */
diff --git a/net/atm/addr.h b/net/atm/addr.h
deleted file mode 100644
index da3f848411a0..000000000000
--- a/net/atm/addr.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* net/atm/addr.h - Local ATM address registry */
-
-/* Written 1995-2000 by Werner Almesberger, EPFL LRC/ICA */
-
-
-#ifndef NET_ATM_ADDR_H
-#define NET_ATM_ADDR_H
-
-#include <linux/atm.h>
-#include <linux/atmdev.h>
-
-void atm_reset_addr(struct atm_dev *dev, enum atm_addr_type_t type);
-int atm_add_addr(struct atm_dev *dev, const struct sockaddr_atmsvc *addr,
-		 enum atm_addr_type_t type);
-int atm_del_addr(struct atm_dev *dev, const struct sockaddr_atmsvc *addr,
-		 enum atm_addr_type_t type);
-int atm_get_addr(struct atm_dev *dev, struct sockaddr_atmsvc __user *buf,
-		 size_t size, enum atm_addr_type_t type);
-
-#endif
diff --git a/net/atm/addr.c b/net/atm/addr.c
deleted file mode 100644
index 938f360ae230..000000000000
--- a/net/atm/addr.c
+++ /dev/null
@@ -1,162 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* net/atm/addr.c - Local ATM address registry */
-
-/* Written 1995-2000 by Werner Almesberger, EPFL LRC/ICA */
-
-#include <linux/atm.h>
-#include <linux/atmdev.h>
-#include <linux/slab.h>
-#include <linux/uaccess.h>
-
-#include "signaling.h"
-#include "addr.h"
-
-static int check_addr(const struct sockaddr_atmsvc *addr)
-{
-	int i;
-
-	if (addr->sas_family != AF_ATMSVC)
-		return -EAFNOSUPPORT;
-	if (!*addr->sas_addr.pub)
-		return *addr->sas_addr.prv ? 0 : -EINVAL;
-	for (i = 1; i < ATM_E164_LEN + 1; i++)	/* make sure it's \0-terminated */
-		if (!addr->sas_addr.pub[i])
-			return 0;
-	return -EINVAL;
-}
-
-static int identical(const struct sockaddr_atmsvc *a, const struct sockaddr_atmsvc *b)
-{
-	if (*a->sas_addr.prv)
-		if (memcmp(a->sas_addr.prv, b->sas_addr.prv, ATM_ESA_LEN))
-			return 0;
-	if (!*a->sas_addr.pub)
-		return !*b->sas_addr.pub;
-	if (!*b->sas_addr.pub)
-		return 0;
-	return !strcmp(a->sas_addr.pub, b->sas_addr.pub);
-}
-
-static void notify_sigd(const struct atm_dev *dev)
-{
-	struct sockaddr_atmpvc pvc;
-
-	pvc.sap_addr.itf = dev->number;
-	sigd_enq(NULL, as_itf_notify, NULL, &pvc, NULL);
-}
-
-void atm_reset_addr(struct atm_dev *dev, enum atm_addr_type_t atype)
-{
-	unsigned long flags;
-	struct atm_dev_addr *this, *p;
-	struct list_head *head;
-
-	spin_lock_irqsave(&dev->lock, flags);
-	if (atype == ATM_ADDR_LECS)
-		head = &dev->lecs;
-	else
-		head = &dev->local;
-	list_for_each_entry_safe(this, p, head, entry) {
-		list_del(&this->entry);
-		kfree(this);
-	}
-	spin_unlock_irqrestore(&dev->lock, flags);
-	if (head == &dev->local)
-		notify_sigd(dev);
-}
-
-int atm_add_addr(struct atm_dev *dev, const struct sockaddr_atmsvc *addr,
-		 enum atm_addr_type_t atype)
-{
-	unsigned long flags;
-	struct atm_dev_addr *this;
-	struct list_head *head;
-	int error;
-
-	error = check_addr(addr);
-	if (error)
-		return error;
-	spin_lock_irqsave(&dev->lock, flags);
-	if (atype == ATM_ADDR_LECS)
-		head = &dev->lecs;
-	else
-		head = &dev->local;
-	list_for_each_entry(this, head, entry) {
-		if (identical(&this->addr, addr)) {
-			spin_unlock_irqrestore(&dev->lock, flags);
-			return -EEXIST;
-		}
-	}
-	this = kmalloc_obj(struct atm_dev_addr, GFP_ATOMIC);
-	if (!this) {
-		spin_unlock_irqrestore(&dev->lock, flags);
-		return -ENOMEM;
-	}
-	this->addr = *addr;
-	list_add(&this->entry, head);
-	spin_unlock_irqrestore(&dev->lock, flags);
-	if (head == &dev->local)
-		notify_sigd(dev);
-	return 0;
-}
-
-int atm_del_addr(struct atm_dev *dev, const struct sockaddr_atmsvc *addr,
-		 enum atm_addr_type_t atype)
-{
-	unsigned long flags;
-	struct atm_dev_addr *this;
-	struct list_head *head;
-	int error;
-
-	error = check_addr(addr);
-	if (error)
-		return error;
-	spin_lock_irqsave(&dev->lock, flags);
-	if (atype == ATM_ADDR_LECS)
-		head = &dev->lecs;
-	else
-		head = &dev->local;
-	list_for_each_entry(this, head, entry) {
-		if (identical(&this->addr, addr)) {
-			list_del(&this->entry);
-			spin_unlock_irqrestore(&dev->lock, flags);
-			kfree(this);
-			if (head == &dev->local)
-				notify_sigd(dev);
-			return 0;
-		}
-	}
-	spin_unlock_irqrestore(&dev->lock, flags);
-	return -ENOENT;
-}
-
-int atm_get_addr(struct atm_dev *dev, struct sockaddr_atmsvc __user * buf,
-		 size_t size, enum atm_addr_type_t atype)
-{
-	unsigned long flags;
-	struct atm_dev_addr *this;
-	struct list_head *head;
-	int total = 0, error;
-	struct sockaddr_atmsvc *tmp_buf, *tmp_bufp;
-
-	spin_lock_irqsave(&dev->lock, flags);
-	if (atype == ATM_ADDR_LECS)
-		head = &dev->lecs;
-	else
-		head = &dev->local;
-	list_for_each_entry(this, head, entry)
-	    total += sizeof(struct sockaddr_atmsvc);
-	tmp_buf = tmp_bufp = kmalloc(total, GFP_ATOMIC);
-	if (!tmp_buf) {
-		spin_unlock_irqrestore(&dev->lock, flags);
-		return -ENOMEM;
-	}
-	list_for_each_entry(this, head, entry)
-	    memcpy(tmp_bufp++, &this->addr, sizeof(struct sockaddr_atmsvc));
-	spin_unlock_irqrestore(&dev->lock, flags);
-	error = total > size ? -E2BIG : total;
-	if (copy_to_user(buf, tmp_buf, total < size ? total : size))
-		error = -EFAULT;
-	kfree(tmp_buf);
-	return error;
-}
diff --git a/net/atm/atm_sysfs.c b/net/atm/atm_sysfs.c
index 54e7fb1a4ee5..0676a9c333ff 100644
--- a/net/atm/atm_sysfs.c
+++ b/net/atm/atm_sysfs.c
@@ -27,29 +27,6 @@ static ssize_t address_show(struct device *cdev,
 	return scnprintf(buf, PAGE_SIZE, "%pM\n", adev->esi);
 }
 
-static ssize_t atmaddress_show(struct device *cdev,
-			       struct device_attribute *attr, char *buf)
-{
-	unsigned long flags;
-	struct atm_dev *adev = to_atm_dev(cdev);
-	struct atm_dev_addr *aaddr;
-	int count = 0;
-
-	spin_lock_irqsave(&adev->lock, flags);
-	list_for_each_entry(aaddr, &adev->local, entry) {
-		count += scnprintf(buf + count, PAGE_SIZE - count,
-				   "%1phN.%2phN.%10phN.%6phN.%1phN\n",
-				   &aaddr->addr.sas_addr.prv[0],
-				   &aaddr->addr.sas_addr.prv[1],
-				   &aaddr->addr.sas_addr.prv[3],
-				   &aaddr->addr.sas_addr.prv[13],
-				   &aaddr->addr.sas_addr.prv[19]);
-	}
-	spin_unlock_irqrestore(&adev->lock, flags);
-
-	return count;
-}
-
 static ssize_t atmindex_show(struct device *cdev,
 			     struct device_attribute *attr, char *buf)
 {
@@ -91,14 +68,12 @@ static ssize_t link_rate_show(struct device *cdev,
 }
 
 static DEVICE_ATTR_RO(address);
-static DEVICE_ATTR_RO(atmaddress);
 static DEVICE_ATTR_RO(atmindex);
 static DEVICE_ATTR_RO(carrier);
 static DEVICE_ATTR_RO(type);
 static DEVICE_ATTR_RO(link_rate);
 
 static struct device_attribute *atm_attrs[] = {
-	&dev_attr_atmaddress,
 	&dev_attr_address,
 	&dev_attr_atmindex,
 	&dev_attr_carrier,
diff --git a/net/atm/common.c b/net/atm/common.c
index c6e87fc9bbfc..7d5b7c39b80b 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -30,7 +30,6 @@
 #include "resources.h"		/* atm_find_dev */
 #include "common.h"		/* prototypes */
 #include "protocols.h"		/* atm_init_<transport> */
-#include "addr.h"		/* address registry */
 #include "signaling.h"		/* for WAITING and sigd_attach */
 
 struct hlist_head vcc_hash[VCC_HTABLE_SIZE];
diff --git a/net/atm/ioctl.c b/net/atm/ioctl.c
index 4f2d185bf2f0..97f20cd051ed 100644
--- a/net/atm/ioctl.c
+++ b/net/atm/ioctl.c
@@ -220,10 +220,6 @@ int vcc_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 #define ATM_GETNAMES32    _IOW('a', ATMIOC_ITF+3, struct compat_atm_iobuf)
 #define ATM_GETTYPE32     _IOW('a', ATMIOC_ITF+4, struct compat_atmif_sioc)
 #define ATM_GETESI32	  _IOW('a', ATMIOC_ITF+5, struct compat_atmif_sioc)
-#define ATM_GETADDR32	  _IOW('a', ATMIOC_ITF+6, struct compat_atmif_sioc)
-#define ATM_RSTADDR32	  _IOW('a', ATMIOC_ITF+7, struct compat_atmif_sioc)
-#define ATM_ADDADDR32	  _IOW('a', ATMIOC_ITF+8, struct compat_atmif_sioc)
-#define ATM_DELADDR32	  _IOW('a', ATMIOC_ITF+9, struct compat_atmif_sioc)
 #define ATM_GETCIRANGE32  _IOW('a', ATMIOC_ITF+10, struct compat_atmif_sioc)
 #define ATM_SETCIRANGE32  _IOW('a', ATMIOC_ITF+11, struct compat_atmif_sioc)
 #define ATM_SETESI32      _IOW('a', ATMIOC_ITF+12, struct compat_atmif_sioc)
@@ -242,10 +238,6 @@ static struct {
 	{ ATM_GETNAMES32,    ATM_GETNAMES },
 	{ ATM_GETTYPE32,     ATM_GETTYPE },
 	{ ATM_GETESI32,	     ATM_GETESI },
-	{ ATM_GETADDR32,     ATM_GETADDR },
-	{ ATM_RSTADDR32,     ATM_RSTADDR },
-	{ ATM_ADDADDR32,     ATM_ADDADDR },
-	{ ATM_DELADDR32,     ATM_DELADDR },
 	{ ATM_GETCIRANGE32,  ATM_GETCIRANGE },
 	{ ATM_SETCIRANGE32,  ATM_SETCIRANGE },
 	{ ATM_SETESI32,	     ATM_SETESI },
@@ -305,10 +297,6 @@ static int do_atm_ioctl(struct socket *sock, unsigned int cmd32,
 	case ATM_GETLINKRATE:
 	case ATM_GETTYPE:
 	case ATM_GETESI:
-	case ATM_GETADDR:
-	case ATM_RSTADDR:
-	case ATM_ADDADDR:
-	case ATM_DELADDR:
 	case ATM_GETCIRANGE:
 	case ATM_SETCIRANGE:
 	case ATM_SETESI:
diff --git a/net/atm/resources.c b/net/atm/resources.c
index 7aac25e917b4..12aef5542263 100644
--- a/net/atm/resources.c
+++ b/net/atm/resources.c
@@ -25,7 +25,6 @@
 
 #include "common.h"
 #include "resources.h"
-#include "addr.h"
 
 
 LIST_HEAD(atm_devs);
@@ -42,8 +41,6 @@ static struct atm_dev *__alloc_atm_dev(const char *type)
 	dev->signal = ATM_PHY_SIG_UNKNOWN;
 	dev->link_rate = ATM_OC3_PCR;
 	spin_lock_init(&dev->lock);
-	INIT_LIST_HEAD(&dev->local);
-	INIT_LIST_HEAD(&dev->lecs);
 
 	return dev;
 }
@@ -227,11 +224,8 @@ int atm_getnames(void __user *buf, int __user *iobuf_len)
 int atm_dev_ioctl(unsigned int cmd, void __user *buf, int __user *sioc_len,
 		  int number, int compat)
 {
-	int error, len, size = 0;
 	struct atm_dev *dev;
-
-	if (get_user(len, sioc_len))
-		return -EFAULT;
+	int error, size = 0;
 
 	dev = try_then_request_module(atm_dev_lookup(number), "atm-device-%d",
 				      number);
@@ -306,51 +300,6 @@ int atm_dev_ioctl(unsigned int cmd, void __user *buf, int __user *sioc_len,
 			goto done;
 		}
 		break;
-	case ATM_RSTADDR:
-		if (!capable(CAP_NET_ADMIN)) {
-			error = -EPERM;
-			goto done;
-		}
-		atm_reset_addr(dev, ATM_ADDR_LOCAL);
-		break;
-	case ATM_ADDADDR:
-	case ATM_DELADDR:
-	case ATM_ADDLECSADDR:
-	case ATM_DELLECSADDR:
-	{
-		struct sockaddr_atmsvc addr;
-
-		if (!capable(CAP_NET_ADMIN)) {
-			error = -EPERM;
-			goto done;
-		}
-
-		if (copy_from_user(&addr, buf, sizeof(addr))) {
-			error = -EFAULT;
-			goto done;
-		}
-		if (cmd == ATM_ADDADDR || cmd == ATM_ADDLECSADDR)
-			error = atm_add_addr(dev, &addr,
-					     (cmd == ATM_ADDADDR ?
-					      ATM_ADDR_LOCAL : ATM_ADDR_LECS));
-		else
-			error = atm_del_addr(dev, &addr,
-					     (cmd == ATM_DELADDR ?
-					      ATM_ADDR_LOCAL : ATM_ADDR_LECS));
-		goto done;
-	}
-	case ATM_GETADDR:
-	case ATM_GETLECSADDR:
-		error = atm_get_addr(dev, buf, len,
-				     (cmd == ATM_GETADDR ?
-				      ATM_ADDR_LOCAL : ATM_ADDR_LECS));
-		if (error < 0)
-			goto done;
-		size = error;
-		/* may return 0, but later on size == 0 means "don't
-		   write the length" */
-		error = put_user(size, sioc_len) ? -EFAULT : 0;
-		goto done;
 	case ATM_SETLOOP:
 		if (__ATM_LM_XTRMT((int) (unsigned long) buf) &&
 		    __ATM_LM_XTLOC((int) (unsigned long) buf) >
diff --git a/net/atm/svc.c b/net/atm/svc.c
index 7c5559f50a99..270e95154a2b 100644
--- a/net/atm/svc.c
+++ b/net/atm/svc.c
@@ -27,7 +27,6 @@
 #include "resources.h"
 #include "common.h"		/* common for PVCs and SVCs */
 #include "signaling.h"
-#include "addr.h"
 
 #ifdef CONFIG_COMPAT
 /* It actually takes struct sockaddr_atmsvc, not struct atm_iobuf */
-- 
2.54.0


