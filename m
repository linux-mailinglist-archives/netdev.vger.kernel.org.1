Return-Path: <netdev+bounces-270299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id e6m/M36hv2nX6wMAu9opvQ
	(envelope-from <netdev+bounces-270299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 08:59:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 226182E88F3
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 08:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9186D300FEF7
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 07:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8FF3290D8;
	Sun, 22 Mar 2026 07:59:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1334F3090CD
	for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 07:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774166395; cv=none; b=IgXP3cp2kLfCObmdTCQm/snzOydHVuoMb/eIQgQV2cyRgWRdFIhn6Iu2a81WHguSPPxyF3WojwGr8ZFh6sG24njq0nttLhymL0lZ+Epjrol40GRlUvlaus1Qb5FMdt6kfkCWEw2MtPCg36ggken8SPUJRkKrGttT6b/BQAC7lrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774166395; c=relaxed/simple;
	bh=BD7bms+Hzvy8wuKEAuDav0KFq5A+rpA5hIlA0ooPYCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HuhTPdPEWgg2slyr3VT367694ix9eohQr8iUf3oQDwSn512T1uPdNyjO4IszORcai5fczZRe7Ufx4ldeizlUPMxYEDAQBW0o27/5iu6zKF6a3JMpPjiuu7ja8rk0fbTROzZS9pS/Ue+tuNyzJPdVcaR4fHhgabaxFvcd//1hg2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59dcdf60427so3544513e87.3
        for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 00:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774166392; x=1774771192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwUa87/6nNV3BAxMOJ2odF4NoyI5ya2/Ap5luWyyXEk=;
        b=Ztitz0rBo28nc6pg1sdAJQxEHHZeXwuKCkMnMuJuzEm0GTixs+IEBz99ZBcnTP7BFZ
         YFnQ0ZEN4d6b6FyvSFLsIpbktRGPkRVWYoLqWjVcSjbWvo7RZm1LFkOQ09uc7Me1GE/H
         lK/b417QlnH3jFVaaCN5RBzSTMIE6iKnR5fpwCLp6RXJL5jr3b1GxBqFSo4+cEhfDVKh
         WGJ/F+UCIMlc5kmzwykkMJ7YQQ6rskFIVGziUBnBoRHP6lF9qdPeFO0g8gxu9ks6K1eZ
         K77q8ULc35tgrjv5MgijvmsIFoKuStix0C6hGFm9Dqy7y5THEM0gkxplc3YQsdnkFX7p
         Vvmw==
X-Forwarded-Encrypted: i=1; AJvYcCV8PZ79meBrbF93m0F6lNsn/0/naCGsGNgE/wCtcvGH+2FcZf8C2XkT9PzMjC48xDi5xFp58Vo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1vHq7Bc+KyC7bL3I32wPVrf02xv38GOyxaMYVU7OuTep73pJx
	NldsJpG8funRZZ6JHVMQZlJQOWyziF8EWV3pccJFtFLQ91H8q4uK0WhO
X-Gm-Gg: ATEYQzy+s6/Buv3dvXXURzN0vVLBMrxUPGtVMWtWye4qxgL4JfRNetJAAC/EZrhJSzw
	sBBRsBKu3oIJvu4rGb9SVpkDbKSY4iW6IUfkyvJONrZmfGLZDSHGIcO+iXmPSwAFskprYj5I+IY
	gNODlMQoYpFkpKpzvlstpCkh2s80tIBp9fMpqZg9EMqmYMpZepPmd9l0bpTJkkSzafZGZ9MnlNJ
	p7jizqaDYqqzaOBxtYF4ZW0o4WnwoAx7r5qcu+q3WSP5x2KlHrUqE6nsxuZfboQn3DA63KougPO
	sgnoV4ndQPBJnmF3B99RmV8twzIb0UGcq552QO0VH+jnyAKnJt61PRjxmKmI84uGP1uGc0xo5ka
	hxhfGzSSSnXKFyn0vUhGSpXp/6e1H20ztot+0d0rcmiWY3HDQsHlR3fsHCDuncKvGQLuevN70kk
	eUzO3sgbmTeOnM4a0IRkcn
X-Received: by 2002:a05:6512:224e:b0:5a1:3207:694c with SMTP id 2adb3069b0e04-5a285b80c25mr3534878e87.29.1774166391898;
        Sun, 22 Mar 2026 00:59:51 -0700 (PDT)
Received: from hackbase ([213.87.137.203])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a285305e31sm1591206e87.64.2026.03.22.00.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 00:59:51 -0700 (PDT)
From: Alexander Popov <alex.popov@linux.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Michal Kubecek <mkubecek@suse.cz>,
	Gal Pressman <gal@nvidia.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Ido Schimmel <idosch@nvidia.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Popov <alex.popov@linux.com>
Cc: security@kernel.org,
	notify@kernel.org
Subject: [PATCH] ethtool: don't touch the parent device of a net device being unregistered
Date: Sun, 22 Mar 2026 10:59:15 +0300
Message-ID: <20260322075917.254874-1-alex.popov@linux.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[linux.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270299-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,bootlin.com,suse.cz,nvidia.com,pengutronix.de,gmail.com,linuxfoundation.org,vger.kernel.org,linux.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex.popov@linux.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 226182E88F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ethtool operations may be performed on a net device that is currently
being unregistered. This is also described in the commit dde91ccfa25fd58f
("ethtool: do not perform operations on net devices being unregistered").
Moreover, such a device may have a parent that has already been freed.

Let's check the net device reg_state in ethnl_ops_begin() before calling
pm_runtime_get_sync() for its parent device to avoid use-after-free
like this:

 ==================================================================
 BUG: KASAN: slab-use-after-free in __pm_runtime_resume+0xe2/0xf0
 Read of size 2 at addr ffff88810cfc46f8 by task pm/606

 Call Trace:
  <TASK>
  dump_stack_lvl+0x4d/0x70
  print_report+0x170/0x4f3
  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
  kasan_report+0xda/0x110
  ? __pm_runtime_resume+0xe2/0xf0
  ? __pm_runtime_resume+0xe2/0xf0
  __pm_runtime_resume+0xe2/0xf0
  ethnl_ops_begin+0x49/0x270
  ethnl_set_features+0x23c/0xab0
  ? __pfx_ethnl_set_features+0x10/0x10
  ? kvm_sched_clock_read+0x11/0x20
  ? local_clock_noinstr+0xf/0xf0
  ? local_clock+0x10/0x30
  ? kasan_save_track+0x25/0x60
  ? __kasan_kmalloc+0x7f/0x90
  ? genl_family_rcv_msg_attrs_parse.isra.0+0x150/0x2c0
  genl_family_rcv_msg_doit+0x1e7/0x2c0
  ? __pfx_genl_family_rcv_msg_doit+0x10/0x10
  ? __pfx_cred_has_capability.isra.0+0x10/0x10
  ? stack_trace_save+0x8e/0xc0
  genl_rcv_msg+0x411/0x660
  ? __pfx_genl_rcv_msg+0x10/0x10
  ? __pfx_ethnl_set_features+0x10/0x10
  netlink_rcv_skb+0x121/0x380
  ? __pfx_genl_rcv_msg+0x10/0x10
  ? __pfx_netlink_rcv_skb+0x10/0x10
  ? __pfx_down_read+0x10/0x10
  genl_rcv+0x23/0x30
  netlink_unicast+0x60f/0x830
  ? __pfx_netlink_unicast+0x10/0x10
  ? __pfx___alloc_skb+0x10/0x10
  netlink_sendmsg+0x6ea/0xbc0
  ? __pfx_netlink_sendmsg+0x10/0x10
  ? __futex_queue+0x10b/0x1f0
  ____sys_sendmsg+0x7a2/0x950
  ? copy_msghdr_from_user+0x26b/0x430
  ? __pfx_____sys_sendmsg+0x10/0x10
  ? __pfx_copy_msghdr_from_user+0x10/0x10
  ___sys_sendmsg+0xf8/0x180
  ? __pfx____sys_sendmsg+0x10/0x10
  ? __pfx_futex_wait+0x10/0x10
  ? fdget+0x2e4/0x4a0
  __sys_sendmsg+0x11f/0x1c0
  ? __pfx___sys_sendmsg+0x10/0x10
  do_syscall_64+0xe2/0x570
  ? exc_page_fault+0x66/0xb0
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  </TASK>

Fixes: d43c65b05b848e0b ("ethtool: runtime-resume netdev parent in ethnl_ops_begin")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 net/ethtool/netlink.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 6e5f0f4f815a..1cdedd1af24d 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -94,17 +94,16 @@ int ethnl_ops_begin(struct net_device *dev)
 	if (!dev)
 		return -ENODEV;
 
-	if (dev->dev.parent)
-		pm_runtime_get_sync(dev->dev.parent);
-
 	netdev_ops_assert_locked(dev);
 
 	if (!netif_device_present(dev) ||
 	    dev->reg_state >= NETREG_UNREGISTERING) {
-		ret = -ENODEV;
-		goto err;
+		return -ENODEV;
 	}
 
+	if (dev->dev.parent)
+		pm_runtime_get_sync(dev->dev.parent);
+
 	if (dev->ethtool_ops->begin) {
 		ret = dev->ethtool_ops->begin(dev);
 		if (ret)
-- 
2.53.0


