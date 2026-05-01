Return-Path: <netdev+bounces-283263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEW4Olfp9GnpFgIAu9opvQ
	(envelope-from <netdev+bounces-283263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 19:56:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC434AEA9A
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 19:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B483302593A
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 17:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6DE324B32;
	Fri,  1 May 2026 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XC1yYYjh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233259463
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 17:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777658151; cv=none; b=iH66qRjTMhkC7IFH7WWH8Tr4MO8Y9xgPv+IPZvYxkAgul81ucAQd9OKhcqv2wqvx0Va0jj3gOIoRt8giORNa3zPpYadYkjZ3gtXq01cmHEbQT8EWzSjMqy0D28d9Cb7v37gqdOKSgB4CBG8oOBJXSTSEIGl1WNzlWsO/NzbkCRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777658151; c=relaxed/simple;
	bh=gR2UDVXdFvwT90T7cEYaCcDx6H8+kK4noONaQHM0HuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hkkp9ZXDJsEfWRPU6V4+XG93M/GGXBd7CCaKGuYbaB7uICniRhKnsaKqhIx/9Wsels00uXhkHOrWAuRWkfcQxWm2urZI1BGI38Mq0uc4ns2Pi02Ujt3wbbzimUyeqsBp+6aszWNYpm3W2GFrrcUM7MXtnSsFAHFmA6vnkY1hBwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XC1yYYjh; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-65c2428c49eso228288d50.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 10:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777658149; x=1778262949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQHRzJtdltADhFy/YPkxA3h28/C2ltHhcNOSyvxGRfc=;
        b=XC1yYYjhjRSaBL20yg3aJu7ugBG+2/+3xqhdks4Oz8FH0/OV4F3wqkVV8nSC2T+3PZ
         n5D0vzZCebz3ItVFw9n+Tcmv56khKnN04RJqF8kXWyo5jtY4uzW4SwCVtqL2sadX+lH9
         R+HREnCCELuBIW01fuYfR+r28ouy/VXtpkoUXj9/7LZII7bGmSbuaUz5u8UxA/pqjR9s
         g7kO7rmT6E/ZgjKu/TASwZgQflsgBoDagRf6/6lIUViYM/xB4/1bfvwFSSg04iRkPAKB
         0aDGpkYY96eNgrICDh2AFwbMQ7JbAPuKxM/PIdd8jCoFZ4EiSD4fErcEEH3gzgcCXMGV
         3IcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777658149; x=1778262949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MQHRzJtdltADhFy/YPkxA3h28/C2ltHhcNOSyvxGRfc=;
        b=A2VgGQ4nc8fV+ClMrGrrF/dj2zBwlNc8mgFCFs+4D4aKhka7HDnJaLyf0ucxmurj+G
         lqPva+oZCr7y+cPdolRA2CiyhUMcr4wH2bvA6JQAu4cvrPYsnptSMphJfLcNH8rfg72k
         M7EoCMGDisHyV4/MvAhGxwjrA7BM3hTY0PPKnWMQ29xoG0+McAB77hywEglo8hqMGMrA
         McPem70xgo7Bduo6NLPv0n6FpSA3lDQGg7hLrru19HmsDN4aVhqtKGxZxnW3NNUZC44T
         Fm6zxUQDH/SrpR9ptwyld/uZZ4hYF5A3VLxsqfdTPEqyHIx1CKYaPz3HrdLQiLeQZ2RJ
         SrZA==
X-Gm-Message-State: AOJu0YyIQUkYlK9xyWwISBV0Qd/OJ12aTNG/lvSLzMrfBLWD8x9xiLJk
	ZvsMWStLLmGcdx/nw4spLrYlQZ4ydNE+dgcrZfz25iNvlNU6S22ykT3X8+a18g==
X-Gm-Gg: AeBDietMAY/PxzlgG8OVck7BMdV+VEQZ9bDHYhmKOWp1SqhuWKIyToNKG+gew9RGHve
	KE9FJBPEi5Zt30ODw2zRzLoLblb2MZjw71ApLGj11zHR9WJ43hhyQmSexH8dt9JpUvRA6C9wwJb
	ukOY8pKZMMjJ/099DIAne+RIRRFEAS3E9SDNYRjMod4oZ/wEvLtE+kE6bOPgid/bxUDYQ1FVp5U
	3zQeKWOV5SDY97WNm862s0wM6LjsPRCFd0SJAjJCcuc1VeFGU31CS8UVpVmaIjWjK4FcDKtmUXU
	h83je8iecPaUiJ6KHH8uCKTMu+2qb3EoJ6UX8NBKS3oj0zwJwMqRDpiQjFYSVeMD2JiK9axOupS
	oKh006zgj0suZQIGzDIQmJK/kMfhVBKC1MES3xvlZl2SiD8cZEF7lBwvLQHGc7HWER6EGbbpVRe
	pHpmsq49LN2v7dDonBbgYRkjNsEFzoKdc/9Sc=
X-Received: by 2002:a05:690c:6e04:b0:79a:46eb:d1cf with SMTP id 00721157ae682-7bd7713e381mr2493497b3.8.1777658148935;
        Fri, 01 May 2026 10:55:48 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:48::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd665298b4sm14046457b3.7.2026.05.01.10.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:55:48 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Wei Wang <weibunny@fb.com>
Subject: [PATCH v12 net-next 3/5] psp: add a new netdev event for dev unregister
Date: Fri,  1 May 2026 10:55:25 -0700
Message-ID: <20260501175528.2130551-4-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260501175528.2130551-1-weibunny.kernel@gmail.com>
References: <20260501175528.2130551-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3CC434AEA9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283263-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fb.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Wei Wang <weibunny@fb.com>

Add a new netdev event for dev unregister and handle the removal of this
dev from psp->assoc_dev_list, upon the first dev-assoc operation.

Signed-off-by: Wei Wang <weibunny@fb.com>
Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 Documentation/netlink/specs/psp.yaml |  2 +-
 net/psp/psp-nl-gen.c                 |  2 +-
 net/psp/psp-nl-gen.h                 |  3 ++
 net/psp/psp.h                        |  1 +
 net/psp/psp_main.c                   | 76 ++++++++++++++++++++++++++++
 net/psp/psp_nl.c                     | 29 +++++++++++
 6 files changed, 111 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
index 3d1b7223e084..538ed9184965 100644
--- a/Documentation/netlink/specs/psp.yaml
+++ b/Documentation/netlink/specs/psp.yaml
@@ -328,7 +328,7 @@ operations:
             - nsid
         reply:
           attributes: []
-        pre: psp-device-get-locked
+        pre: psp-device-get-locked-dev-assoc
         post: psp-device-unlock
     -
       name: dev-disassoc
diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
index 114299c64423..389a8480cc3d 100644
--- a/net/psp/psp-nl-gen.c
+++ b/net/psp/psp-nl-gen.c
@@ -135,7 +135,7 @@ static const struct genl_split_ops psp_nl_ops[] = {
 	},
 	{
 		.cmd		= PSP_CMD_DEV_ASSOC,
-		.pre_doit	= psp_device_get_locked,
+		.pre_doit	= psp_device_get_locked_dev_assoc,
 		.doit		= psp_nl_dev_assoc_doit,
 		.post_doit	= psp_device_unlock,
 		.policy		= psp_dev_assoc_nl_policy,
diff --git a/net/psp/psp-nl-gen.h b/net/psp/psp-nl-gen.h
index 4dd0f0f23053..24d51bff997f 100644
--- a/net/psp/psp-nl-gen.h
+++ b/net/psp/psp-nl-gen.h
@@ -21,6 +21,9 @@ int psp_device_get_locked_admin(const struct genl_split_ops *ops,
 				struct sk_buff *skb, struct genl_info *info);
 int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
 				struct sk_buff *skb, struct genl_info *info);
+int psp_device_get_locked_dev_assoc(const struct genl_split_ops *ops,
+				    struct sk_buff *skb,
+				    struct genl_info *info);
 void
 psp_device_unlock(const struct genl_split_ops *ops, struct sk_buff *skb,
 		  struct genl_info *info);
diff --git a/net/psp/psp.h b/net/psp/psp.h
index 0f9c4e4e52cb..c82b21bae240 100644
--- a/net/psp/psp.h
+++ b/net/psp/psp.h
@@ -15,6 +15,7 @@ extern struct mutex psp_devs_lock;
 
 void psp_dev_free(struct psp_dev *psd);
 int psp_dev_check_access(struct psp_dev *psd, struct net *net, bool admin);
+int psp_attach_netdev_notifier(void);
 
 void psp_nl_notify_dev(struct psp_dev *psd, u32 cmd);
 
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 792a47105a6c..a57d30db22be 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -391,6 +391,82 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
 }
 EXPORT_SYMBOL(psp_dev_rcv);
 
+static void psp_dev_disassoc_one(struct psp_dev *psd, struct net_device *dev)
+{
+	struct psp_assoc_dev *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &psd->assoc_dev_list, dev_list) {
+		if (entry->assoc_dev == dev) {
+			list_del(&entry->dev_list);
+			psd->assoc_dev_cnt--;
+			rcu_assign_pointer(entry->assoc_dev->psp_dev, NULL);
+			netdev_put(entry->assoc_dev, &entry->dev_tracker);
+			kfree(entry);
+			return;
+		}
+	}
+}
+
+static int psp_netdev_event(struct notifier_block *nb, unsigned long event,
+			    void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct psp_dev *psd;
+
+	if (event != NETDEV_UNREGISTER)
+		return NOTIFY_DONE;
+
+	rcu_read_lock();
+	psd = rcu_dereference(dev->psp_dev);
+	if (psd && psp_dev_tryget(psd)) {
+		rcu_read_unlock();
+		mutex_lock(&psd->lock);
+		psp_dev_disassoc_one(psd, dev);
+		mutex_unlock(&psd->lock);
+		psp_dev_put(psd);
+	} else {
+		rcu_read_unlock();
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block psp_netdev_notifier = {
+	.notifier_call = psp_netdev_event,
+};
+
+static DEFINE_MUTEX(psp_notifier_lock);
+static bool psp_notifier_registered;
+
+/**
+ * psp_attach_netdev_notifier() - register netdev notifier on first use
+ *
+ * Register the netdevice notifier when the first device association
+ * is created. In many installations no associations will be created and
+ * the notifier won't be needed.
+ *
+ * Must be called without psd->lock held, due to lock ordering:
+ * rtnl_lock -> psd->lock (the notifier callback runs under rtnl_lock
+ * and takes psd->lock).
+ */
+int psp_attach_netdev_notifier(void)
+{
+	int err = 0;
+
+	if (READ_ONCE(psp_notifier_registered))
+		return 0;
+
+	mutex_lock(&psp_notifier_lock);
+	if (!psp_notifier_registered) {
+		err = register_netdevice_notifier(&psp_netdev_notifier);
+		if (!err)
+			WRITE_ONCE(psp_notifier_registered, true);
+	}
+	mutex_unlock(&psp_notifier_lock);
+
+	return err;
+}
+
 static int __init psp_init(void)
 {
 	mutex_init(&psp_devs_lock);
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index 75ca32821d28..d622f91a979e 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -167,6 +167,22 @@ int psp_device_get_locked(const struct genl_split_ops *ops,
 	return __psp_device_get_locked(ops, skb, info, false);
 }
 
+/*
+ * Non-admin version of psp_device_get_locked() + psp_attach_netdev_notifier()
+ * only used for dev-assoc.
+ */
+int psp_device_get_locked_dev_assoc(const struct genl_split_ops *ops,
+				    struct sk_buff *skb, struct genl_info *info)
+{
+	int err;
+
+	err = psp_attach_netdev_notifier();
+	if (err)
+		return err;
+
+	return __psp_device_get_locked(ops, skb, info, false);
+}
+
 static struct net *psp_nl_resolve_assoc_dev_ns(struct psp_dev *psd,
 					       struct genl_info *info)
 {
@@ -532,6 +548,19 @@ int psp_nl_dev_assoc_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	psp_assoc_dev->assoc_dev = assoc_dev;
+
+	/* Check for race with NETDEV_UNREGISTER. The cmpxchg above is a
+	 * full barrier, and the unregister path has synchronize_net()
+	 * between setting NETREG_UNREGISTERING and reading psp_dev in the
+	 * notifier. So at least one side would do the clean-up if we are in
+	 * the middle of unregitering assoc_dev.
+	 * And the clean-up is serialized by psd->lock.
+	 */
+	if (READ_ONCE(assoc_dev->reg_state) != NETREG_REGISTERED) {
+		err = -ENODEV;
+		goto rsp_err;
+	}
+
 	rsp = psp_nl_reply_new(info);
 	if (!rsp) {
 		err = -ENOMEM;
-- 
2.52.0


