Return-Path: <netdev+bounces-256738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAb1HEJpg2kbmgMAu9opvQ
	(envelope-from <netdev+bounces-256738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:44:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C80DE93D0
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D8DD0311AC60
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 15:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE99425CFD;
	Wed,  4 Feb 2026 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1DO1ajT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C8D425CE5
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218415; cv=none; b=R+q65ZGdees6bhmbLgXynuPL0oPoz5i1BPdpZ7jYRl1GdXNSxU62ESyvdIqRzzl3/GRpb/xHX/nDgHhwTTeE5sM9w8qS1Ygj5/5HNfS9duvIkMw1Hm1A/gTrv0pf2K34t1jE5iETiNLC7qvlHYXEZ99+wASfvgcbTx5ThuRvoOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218415; c=relaxed/simple;
	bh=+R5voXuQnEBX8+p5l7a0pUX07F4bMFsDu15P/f+RDe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p3Psy+Ew5Nsp40aVopEyUMAkEHHWbi8OJCqg7aan53EJHxyoIQxU9Jm2nzN2Y0rD7T1CO0O01CcPO0mEf5ijUH+NQ/O9vSnoDgLezR15I+xxT2a21TgdNllnYQgQcrK0zjJldhvNLVA2P/Ys4lzNgUA5pYINITLEEjzOnNT684Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1DO1ajT; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-794e0e933ccso33571497b3.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 07:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770218415; x=1770823215; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iIuhi4GGL+4aZmNOIWvGI/sDSV9rn1npcZ0exHynTsg=;
        b=F1DO1ajTMUBWIobA/cWik+0B7J6EByBMnBnSdcrCyjXbhO//ck6kIMkNDxawkN9Lbp
         CXyJqiIS6cFmOrLxWHVo9bQoXBL26tE106oNi4/ACboZTSULIhGcQONtXL0iZBfI5qUN
         3/WPOn9jSUfRDt4a4qEpTfvplfIhTHjxG0TUDoFqtJl/77ZnErYXaaOJyBiI831X1IIL
         H8pnQpuIqj+C61TQXu/CMWOStMn1sJfRUhS1X2VdV0v4TI26AZTTg5lAEqXTruHjafRE
         Ex/lldCy6x694KDourhZRTxt7NkmKtwB+VUA7HznfKnZFwWGm3+79WW30p73m0QaTwiz
         QgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770218415; x=1770823215;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iIuhi4GGL+4aZmNOIWvGI/sDSV9rn1npcZ0exHynTsg=;
        b=a81pPIP94046GKSriNdmdwi8GjH/aB+cfqMfghNuHXYe/i6fJEbIRzdYlGRP5pLpUv
         YjhYNoWOD3B/C57RStOh3M8c8VJmFIMa+Fw13QBgN35KscsRhjtcyUGvOsc9RsWy5FjS
         blIVn30r30nqbrxZjx6HrFcpFMh10dbGKxqrmSzFwDCUM/Ps3TuNEZn6uZZOeJF4AiLK
         IiIJHEZsTRBycbjWR8m4pqWPSybjYefdtwoncjDc0JiGfJMJNsLMBvL5BLpX08A3d+ZH
         I51JqjjiMsJbvC9aQhDyjLUmQE3bplJAW4qFW2V0J8gihdGuKJDss9g5hx1zEuoO9RPi
         67Cg==
X-Gm-Message-State: AOJu0YzFzA3nxfH2bEwyK8YjA/Haf7RIF9PDduCRGmiy9aqc0LxJaWpn
	ObM98ScGoShc7j7thMFkQsZ8pCAmTqPw3o9FrLbazEql2uDKuNK1i2Om
X-Gm-Gg: AZuq6aIrHng0GTk8P1STI515361zuUnEZcI1vKy26x1L7s65U09Ui8Cp6KAVf78JBdm
	g3rwPXxgDPTKLFUHM6RbKWFFp+aXzESU9UTuOrKyQW6DLhRU4amfAg/XDkMi8CIU6zehpuVucG8
	uY9VyOoomwkNoaqfj/0Nx+OfBcWAZcbr3XRMHZYJqXXbWfIbgCok8fYOePaH7myZKrnt5f/uY0q
	2NZG4odcgDm28WiI45jdbYzPyhXml1a+kfH0pEPbdGfzyU6f9YJKhx0K9I2ix5wFGzgip04Rs2j
	y2HSuddEnb9KyWjkOJ1remzYV+jg1cM/VgeGSaX6bd5vKyWY+82GyEeMshQhRN1DVe7FLV8x6f6
	YJjWWAoKndjnNfKR0ExifzkIArpsPGS1RyYid/+98KKaoOr4ipZ62IsI1PjmgkjhzG2rP5KARGf
	bEDdn7wNP/
X-Received: by 2002:a05:690c:6d82:b0:794:b36f:7a6e with SMTP id 00721157ae682-794fe62cac4mr29521157b3.9.1770218414446;
        Wed, 04 Feb 2026 07:20:14 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:57::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794feeb1937sm23269477b3.21.2026.02.04.07.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 07:20:13 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Wed, 04 Feb 2026 07:20:09 -0800
Subject: [PATCH net-next 5/9] psp: add driver api for deferred tx key
 deletion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-psp-v1-5-5f034e2dfa36@gmail.com>
References: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
In-Reply-To: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, Boris Pismenny <borisp@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Daniel Zahka <daniel.zahka@gmail.com>
X-Mailer: b4 0.13.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256738-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,nvidia.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C80DE93D0
X-Rspamd-Action: no action

There is a race condition during tx key deletion on devices that use
key identifiers in tx metadata, as opposed to inlining keys
directly. When a key is requested to be deleted, there may be skb's in
the tx ring, whose metadata descriptors contain unaccounted references
to a tx key. Under these conditions, the skb sitting in the tx ring
can race against the request to fw to delete the tx key handle.

The solution implemented here is to provide an api for core to defer
tx key deletion operations until after the driver signals that it is
safe to do so.

Core informs the driver that a key deletion grace period is starting
via psp_dev::tx_grace_begin(). While a grace period is active, core
will queue keys to be deleted to the psp_dev::tx_del_next queue.

Core will then periodically query the driver with
psp_dev::tx_grace_end() to determine if it is safe to delete the
keys it has queued. If it is, core will then move the queued keys into
a new list and begin deleting them, allowing the psp_dev::tx_del_next
queue to begin filling for the next grace period.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 include/net/psp/types.h | 32 +++++++++++++++++
 net/psp/psp.h           |  1 +
 net/psp/psp_main.c      | 93 +++++++++++++++++++++++++++++++++++++++++++++++++
 net/psp/psp_sock.c      | 13 ++++++-
 4 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/include/net/psp/types.h b/include/net/psp/types.h
index 52844ac6f870..280c7fdc713c 100644
--- a/include/net/psp/types.h
+++ b/include/net/psp/types.h
@@ -5,6 +5,7 @@
 
 #include <linux/mutex.h>
 #include <linux/refcount.h>
+#include <linux/workqueue.h>
 
 struct netlink_ext_ack;
 
@@ -58,6 +59,10 @@ struct psp_dev_config {
  * @prev_assocs:	associations which use old (but still usable)
  *			device key
  * @stale_assocs:	associations which use a rotated out key
+ * @tx_del_active:	TX keys to be deleted after the current grace period
+ * @tx_del_next:	TX keys queued for deletion during current grace period
+ * @tx_del_work:	workqueue for periodic grace period checking
+ * @tx_grace_active:	true if a grace period is in progress
  *
  * @stats:	statistics maintained by the core
  * @stats.rotations:	See stats attr key-rotations
@@ -85,6 +90,11 @@ struct psp_dev {
 	struct list_head prev_assocs;
 	struct list_head stale_assocs;
 
+	struct list_head tx_del_active;
+	struct list_head tx_del_next;
+	struct delayed_work tx_del_work;
+	bool tx_grace_active;
+
 	struct {
 		unsigned long rotations;
 		unsigned long stales;
@@ -208,6 +218,28 @@ struct psp_dev_ops {
 	 */
 	void (*tx_key_del)(struct psp_dev *psd, struct psp_assoc *pas);
 
+	/**
+	 * @tx_grace_begin: begin TX grace period tracking
+	 * Begin a new TX grace period. Core will queue tx keys for deletion
+	 * and not delete them until the grace period has elapsed.
+	 *
+	 * Return: 0 on success, error code otherwise. If the operation fails,
+	 * core will try again later and a grace period is not activated.
+	 */
+	int (*tx_grace_begin)(struct psp_dev *psd);
+
+	/**
+	 * @tx_grace_end: check if TX grace period has ended
+	 * Check if the current TX grace period has ended.
+	 *
+	 * Return:
+	 *   0: grace period has ended, core will delete queued tx keys
+	 *   -EAGAIN: grace period has not ended, core will requery later
+	 *   other error: internal error (e.g., device reconfigured), core
+	 *                should return to the tx_grace_begin() phase
+	 */
+	int (*tx_grace_end)(struct psp_dev *psd);
+
 	/**
 	 * @get_stats: get statistics from the device
 	 * Stats required by the spec must be maintained and filled in.
diff --git a/net/psp/psp.h b/net/psp/psp.h
index b86539d5137a..d09fdd956fcb 100644
--- a/net/psp/psp.h
+++ b/net/psp/psp.h
@@ -15,6 +15,7 @@ extern struct mutex psp_devs_lock;
 
 void psp_dev_free(struct psp_dev *psd);
 int psp_dev_check_access(struct psp_dev *psd, struct net *net);
+void psp_tx_key_queue_del(struct psp_dev *psd, struct psp_assoc *pas);
 
 void psp_nl_notify_dev(struct psp_dev *psd, u32 cmd);
 
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 982c96f74ae3..2fb886edc384 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -14,6 +14,10 @@
 DEFINE_XARRAY_ALLOC1(psp_devs);
 struct mutex psp_devs_lock;
 
+#define PSP_TX_DEL_INTERVAL_MS  100
+
+static void psp_tx_del_work_fn(struct work_struct *work);
+
 /**
  * DOC: PSP locking
  *
@@ -64,6 +68,9 @@ psp_dev_create(struct net_device *netdev,
 		    !psd_ops->get_stats))
 		return ERR_PTR(-EINVAL);
 
+	if (WARN_ON(!!psd_ops->tx_grace_begin != !!psd_ops->tx_grace_end))
+		return ERR_PTR(-EINVAL);
+
 	psd = kzalloc(sizeof(*psd), GFP_KERNEL);
 	if (!psd)
 		return ERR_PTR(-ENOMEM);
@@ -77,6 +84,9 @@ psp_dev_create(struct net_device *netdev,
 	INIT_LIST_HEAD(&psd->active_assocs);
 	INIT_LIST_HEAD(&psd->prev_assocs);
 	INIT_LIST_HEAD(&psd->stale_assocs);
+	INIT_LIST_HEAD(&psd->tx_del_active);
+	INIT_LIST_HEAD(&psd->tx_del_next);
+	INIT_DELAYED_WORK(&psd->tx_del_work, psp_tx_del_work_fn);
 	refcount_set(&psd->refcnt, 1);
 
 	mutex_lock(&psp_devs_lock);
@@ -118,6 +128,8 @@ void psp_dev_unregister(struct psp_dev *psd)
 {
 	struct psp_assoc *pas, *next;
 
+	cancel_delayed_work_sync(&psd->tx_del_work);
+
 	mutex_lock(&psp_devs_lock);
 	mutex_lock(&psd->lock);
 
@@ -130,6 +142,15 @@ void psp_dev_unregister(struct psp_dev *psd)
 	xa_store(&psp_devs, psd->id, NULL, GFP_KERNEL);
 	mutex_unlock(&psp_devs_lock);
 
+	list_splice_init(&psd->tx_del_active, &psd->tx_del_next);
+	list_for_each_entry_safe(pas, next, &psd->tx_del_next, assocs_list) {
+		list_del(&pas->assocs_list);
+		psp_dev_tx_key_del(psd, pas);
+		psp_assoc_put(pas->prev);
+		psp_dev_put(psd);
+		kfree(pas);
+	}
+
 	list_splice_init(&psd->active_assocs, &psd->prev_assocs);
 	list_splice_init(&psd->prev_assocs, &psd->stale_assocs);
 	list_for_each_entry_safe(pas, next, &psd->stale_assocs, assocs_list) {
@@ -149,6 +170,78 @@ void psp_dev_unregister(struct psp_dev *psd)
 }
 EXPORT_SYMBOL(psp_dev_unregister);
 
+void psp_tx_key_queue_del(struct psp_dev *psd, struct psp_assoc *pas)
+{
+	lockdep_assert_held(&psd->lock);
+
+	list_add_tail(&pas->assocs_list, &psd->tx_del_next);
+	if (!delayed_work_pending(&psd->tx_del_work))
+		schedule_delayed_work(&psd->tx_del_work,
+				      msecs_to_jiffies(PSP_TX_DEL_INTERVAL_MS));
+}
+
+static void psp_tx_del_work_fn(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct psp_dev *psd = container_of(dwork, struct psp_dev, tx_del_work);
+	struct psp_assoc *pas, *tmp;
+	bool need_reschedule = false;
+	LIST_HEAD(to_free);
+	int err;
+
+	mutex_lock(&psd->lock);
+
+	if (!psp_dev_is_registered(psd))
+		goto out_unlock;
+
+	if (psd->tx_grace_active) {
+		err = psd->ops->tx_grace_end(psd);
+		if (err == -EAGAIN) {
+			need_reschedule = true;
+			goto out_unlock;
+		}
+		if (err) {
+			/* Driver error, restart grace period */
+			psd->tx_grace_active = false;
+			list_splice_init(&psd->tx_del_active, &psd->tx_del_next);
+			goto start_grace;
+		}
+
+		list_for_each_entry_safe(pas, tmp, &psd->tx_del_active,
+					 assocs_list) {
+			list_del(&pas->assocs_list);
+			psp_dev_tx_key_del(psd, pas);
+			list_add_tail(&pas->assocs_list, &to_free);
+		}
+
+		psd->tx_grace_active = false;
+	}
+
+start_grace:
+	if (!list_empty(&psd->tx_del_next)) {
+		err = psd->ops->tx_grace_begin(psd);
+		if (!err) {
+			list_splice_init(&psd->tx_del_next, &psd->tx_del_active);
+			psd->tx_grace_active = true;
+		}
+		need_reschedule = true;
+	}
+
+out_unlock:
+	mutex_unlock(&psd->lock);
+
+	list_for_each_entry_safe(pas, tmp, &to_free, assocs_list) {
+		list_del(&pas->assocs_list);
+		psp_assoc_put(pas->prev);
+		psp_dev_put(psd);
+		kfree(pas);
+	}
+
+	if (need_reschedule)
+		schedule_delayed_work(&psd->tx_del_work,
+				      msecs_to_jiffies(PSP_TX_DEL_INTERVAL_MS));
+}
+
 unsigned int psp_key_size(u32 version)
 {
 	switch (version) {
diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index 1a97609564e7..d038da122ebb 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -88,6 +88,11 @@ void psp_dev_tx_key_del(struct psp_dev *psd, struct psp_assoc *pas)
 	psd->ops->tx_key_del(psd, pas);
 }
 
+static bool psp_dev_needs_defer(struct psp_dev *psd)
+{
+	return !!psd->ops->tx_grace_begin;
+}
+
 static void psp_assoc_free(struct work_struct *work)
 {
 	struct psp_assoc *pas = container_of(work, struct psp_assoc, work);
@@ -96,8 +101,14 @@ static void psp_assoc_free(struct work_struct *work)
 	mutex_lock(&psd->lock);
 	if (psd->ops) {
 		list_del(&pas->assocs_list);
-		if (pas->tx.spi && !pas->tx_moved)
+		if (pas->tx.spi && !pas->tx_moved) {
+			if (psp_dev_needs_defer(psd)) {
+				psp_tx_key_queue_del(psd, pas);
+				mutex_unlock(&psd->lock);
+				return;
+			}
 			psp_dev_tx_key_del(psd, pas);
+		}
 	}
 	mutex_unlock(&psd->lock);
 	psp_assoc_put(pas->prev);

-- 
2.47.3


