Return-Path: <netdev+bounces-288071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKGTG9IYBmrGegIAu9opvQ
	(envelope-from <netdev+bounces-288071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 20:47:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FD4546026
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 20:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC6EA302712B
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEAA3A6B95;
	Thu, 14 May 2026 18:47:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FD43A48C2
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778784431; cv=none; b=rbBJf5nuehaio6g/3twOApiuc/MVewkhbw2dGeNMyws7ST331OBi4P3ZGveu0wGbMqsZQ8qgcBCWKKMvr0NohCTGWTqYjNKhJIaXOxjL4BzUlPrdon9O2m4Ezp0ht8vQIvoOaZlPOeQlrJElaArLGW7Yo9kYn8n0fsTEoEKVETA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778784431; c=relaxed/simple;
	bh=ueUCl0EtJ8kWvVEv/1v3KaiqrbdukBjoCfFKdjqTu3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nMNozPHCNzA9ALzYGAu+wzhNWxbMKBXrdUWz6JXzZ5IDowGKD1CCKYGPvby2OWxHq0NDAJo+rHeIfzWLVQv6oL5HKrMU4QTeoX3hNDAVreyf+5OevEljK2jAGFQ548qMr11UWxNgmMitibIm0LI4JM1ztBKmCSh+sImrYms/Zj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-488ad135063so68735675e9.0
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 11:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778784427; x=1779389227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbyuYskHezDgvxCcvU19slfVinGu/cOvscyqTQLVYVU=;
        b=KkRwFb7EnTEm2Ke+pMrwyevakx+RuCt3BiB4vZQDQxl+kUku2wUWiZOWSEoUErSe++
         SvCHfiM7+t2kIztYkYSRe5AfvfJSTe4p938rru3nptnuXPktYQD9uzePvPhIp4F3+lEE
         d7JLqypQhEOjViMGigY0jRfyhSX5gqLjSXHQ7u71lyN5/lbFwkONdiyeDd5HKNXz8OSb
         obzK6JQ+8HEhtYRhme2kxRVw0OUDYn06gVOxb7Ecmm0GpgnjMrtPX2Se/Fgs5JRu6gZx
         549xHk7LOBmZvXpnk5d8BA7LT6O+L/ZvFur8a4Tm1QXgdfwcPTkEl5aDgSa95Hi7DO0x
         xQHA==
X-Gm-Message-State: AOJu0Yyir/Q1nkz7w9+JfmsDnga/cH0QG0D5hbyv/TnykD03WSFvjZ5Q
	h7ouDmVy2coxjUL5u2fGS6WONsC/OedMKoii7GzPuSJMla0d3eZXnZQr5kbmkdH/
X-Gm-Gg: Acq92OFyJ+5aqARzSDJSJwDb6zRQfg93dM+OKW3ybGE9tTQDCylOTiWV7d7Hd90irzz
	puH4pocNC8k7+I5NDKddvGURqGljpu7nI4AFnOm+pdqQPt6kZyzguAZDbOBKM/21KmrTBR48qwe
	LsHvRh9A0AC+yzcBVR68HrC7ADZ5CR/DmAgdoJq1CIkq0ryGf8NetRtxcW9R/6mmBqPrsRk+X8J
	DXKtSRCpBQujqAP+yGb0CLm2NPu4xSG0SbOLAivhne+Imgrfe6llDmQ+6lUg0fxwjTEQ97Mv46D
	qvLiDRw2jr/C4pflfb2Vn46mSWsY6EeV11x78pmDG2T4vztNe+6YQn3dHTOu15EgQfj3DbrHvur
	zGAD7eAmKYnumBKm+Y0kgvBdZkqApPYfY3i6GxjEW++r+mfgnVgR/UvIu2NRnl3em2978LNYMRr
	7PzVqpBffMW5h2Gi8PLzK8aIOULP6K1Rt5tP6zNTHQmVPVDMyUw2Hi62FMwffcm+9zw1B98uG0d
	a7AeKf2
X-Received: by 2002:a05:600c:34d4:b0:48f:e230:c3fa with SMTP id 5b1f17b1804b1-48fe6626a58mr7011795e9.32.1778784426674;
        Thu, 14 May 2026 11:47:06 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd62dad0esm24037965e9.6.2026.05.14.11.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:47:06 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net v2] openvswitch: vport: fix race between linking and the device notifier
Date: Thu, 14 May 2026 20:46:31 +0200
Message-ID: <20260514184702.2461435-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D5FD4546026
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-288071-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Sashiko reports that it is technically possible that we got the device
reference, but by the time we're linking it to the OVS datapath, it
may be already in the process of being deleted.  In this case if the
notifier wins the race for RTNL, it will see that the device is not
yet in the OVS datapath (ovs_netdev_get_vport() will fail in the
dp_device_event()) and will do nothing.  Then the ovs_netdev_link()
will take the RTNL and link the unregistering device to OVS datapath.

Eventually, netdev_wait_allrefs_any() will re-broadcast the event and
the device will be properly detached, but it will take at least a
second before that happens, so it's not something we should rely on.

Let's avoid linking the non-registered device in the first place.

Note: As per documentation, RTNL doesn't protect the reg_state, but
it actually does for all the state transitions we care about here,
so it should not be necessary to use READ_ONCE or taking the instance
lock.  We can still do that, but we have a few more places even in
this file where the reg_state is accessed without those while under
RTNL, and many more places like this across the kernel code, so it
might make more sense to change all of them in a more centralized
fashion in the future, if necessary.

Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---

Version 2:
 * Added a comment. [Aaron]

Version 1:
 * https://lore.kernel.org/netdev/20260513095541.2010516-1-i.maximets@ovn.org/

 net/openvswitch/vport-netdev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
index c42642075685d..e7e8490a53d80 100644
--- a/net/openvswitch/vport-netdev.c
+++ b/net/openvswitch/vport-netdev.c
@@ -83,6 +83,14 @@ struct vport *ovs_netdev_link(struct vport *vport, bool tunnel)
 	}
 
 	rtnl_lock();
+	/* Do not link devices that are not registered to avoid a potential
+	 * race with the NETDEV_UNREGISTER notification in dp_device_event().
+	 */
+	if (vport->dev->reg_state != NETREG_REGISTERED) {
+		err = -ENODEV;
+		goto error_put_unlock;
+	}
+
 	err = netdev_master_upper_dev_link(vport->dev,
 					   get_dpdev(vport->dp),
 					   NULL, NULL, NULL);
-- 
2.53.0


