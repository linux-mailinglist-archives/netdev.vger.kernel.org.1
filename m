Return-Path: <netdev+bounces-283003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJvGHJ7L82mL7AEAu9opvQ
	(envelope-from <netdev+bounces-283003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 23:37:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C839F4A8468
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 23:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D723D30417B0
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 21:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704CC39FCA8;
	Thu, 30 Apr 2026 21:34:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE4E39A7E5
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 21:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584846; cv=none; b=Q2kEib3sro3P0KJePv49+v1SNdzR9+J0oVSNXkvgGQlyx9ps91chpn9Csx3POaqqT7/wG/DjzMVkT6DDTIYiJ4KZRWvsV0LG7LXrcDP9gtajR6vawu0/f+vqjqiwHdynFZzeuDo85WlRqL43vcevQAGRkIXLNPk+NrIugGqHeAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584846; c=relaxed/simple;
	bh=32WahWZ999G99k3QX9u7NsKoOLp3p0y7p4khIBuo4vU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rmEQtxkqo2p4ZUezSpbNizaizD38yTwRNU4qQaOu158ia3x9s2Qt2BER+2P7t0al9vNZBRJuufp5moh7zsVzGPyqDNofUDpmYS3bWJpXqCnvteB7jB3BOdOwR1BGFPVBKT/QE/cJQsXgy3t4+mDcV8C3pOjvvtSPEFocI3mhC+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso12986765e9.2
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 14:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584843; x=1778189643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfmPhFElhLAwy6YMf8rD+Yyjnbfd1EzluOPK8WXa+TM=;
        b=NuCBAwFAF0LnphNJ4DLVpG9cWRLnIjYX2prC9SYPUe6ds6/ugB1ZX2/cR2LleLkD3z
         a7Hy2zHaN9d3V6YMr8SoK6rzaPAM3N9HXXLDEGABIq6dQnJHM0XtzoVYbE4gQ9vJkoUe
         wcfAQvKj0WiQg7CxnPwx0dPzdyw4SzN1fFD10E5g9NaOBTXWPJLpX/OnOmqLZLUc2pUm
         ZNy3wmCXeVPRZ7gRCNBvSj0AQ0JwYVVLNLHnpU8P6Gm96fEP8uAW+GsKi91WW6IeP8+v
         V8hCKhkT+hC8NZlHkRLAMAdtOwR2ZGABEGheYPCKekmIEQVuY8dHIsarv30SR6TMa/wr
         xctA==
X-Gm-Message-State: AOJu0YzGjwvh5V6Q/EerhFc6yN2MTz4H4s5j2dsxeAIoQFnulmJKNzvH
	vEenhR8FQvzXfH3NykBQ+N/3U5aHPHW7n/t1rMqQ5U+rIgXNHaJ3zF13jMep2nHkWRM=
X-Gm-Gg: AeBDiesx7ZVZAxwu3yk3NXFUcxaBYwWeEyJJcW2NhVFHcndxdo0FHzDDng0ivWJHiXt
	UOBb8xG8emdVfRyb04WLwA2voF9ow8q9VWkw1EV805uIJ6spsAZNE8LdqMyopmAa24An2qSteGi
	S27dPHAj1RY9BMLfQUXq/RCLr3jr1+0i16XRharwGIpFvyJz002Ay3Wasto735wPQmD8FNOhbRc
	nR96ctZj1FoxPKRB1ZT0tPZkAxaPUWGkNBdLCtS2af5OyfT69S8xU7BbqxqweEZlLpgu4tyXcoO
	4cK/tgo36PN8Ely8ffTwkwA+vH3aKreo6kF30Cz14i/cKSbXYVbmAR2tqSJJX5jG+kzDXzWPQft
	CDTvKWIrteLAbkHKhdCbFFnLt0Vr2j1+sOKX0PMlSGD1DRHLzqBP1t9C0Ko1oIunvXRgwIcBAmL
	cdNjHDtEtV2gtkeaTCpeCeWWUw1yJXN1rXtjqubYgq1KbIj/VgqazU0KAd9p54gjZoSIWphFLxZ
	izqoLey
X-Received: by 2002:a5d:5f82:0:b0:43d:c95b:c46f with SMTP id ffacd0b85a97d-44a88cdf06fmr572444f8f.38.1777584842576;
        Thu, 30 Apr 2026 14:34:02 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a986aa3a5sm360701f8f.26.2026.04.30.14.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:34:02 -0700 (PDT)
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
	Ilya Maximets <i.maximets@ovn.org>,
	Yuan Tan <tanyuan98@outlook.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Yang Yang <n05ec@lzu.edu.cn>
Subject: [PATCH net] openvswitch: vport: fix race between tunnel creation and linking
Date: Thu, 30 Apr 2026 23:32:50 +0200
Message-ID: <20260430213349.407991-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C839F4A8468
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,openvswitch.org,vger.kernel.org,ovn.org,outlook.com,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-283003-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,lzu.edu.cn:email]

When a tunnel vport is created it first creates the tunnel device, e.g.,
with geneve_dev_create_fb(), then it calls ovs_netdev_link() to take a
reference and link it to the device that represents openvswitch datapath.

The creation of the device is happening under RTNL, but then RTNL is
released and re-acquired to find the device by name.  It is technically
possible for the tunnel device to be re-named or deleted within that
window while RTNL is not held, and some other device created in its
place.  This will cause a non-tunnel device to be referenced in the
vport and tunnel-specific functions used on it, e.g. vxlan_get_options()
that directly casts the private netdev data into a struct vxlan_dev
causing an invalid memory access:

 BUG: KASAN: slab-use-after-free in vxlan_get_options+0x323/0x3a0
  vxlan_get_options+0x323/0x3a0
  ovs_vport_cmd_new+0x6e3/0xd30

Fix that by taking a reference to the just created device before
releasing RTNL.  This ensures that the device in the vport is always
the one that was just created.  The search by name is only needed
for a standard vport-netdev that links pre-existing devices, so that
functionality and device type checks are moved to netdev_create().

It is also awkward that ovs_netdev_link() takes ownership of the vport
and destroys it on failure.  It doesn't know the type of the port it is
dealing with, so we need to pass down the indicator that it's a tunnel,
so the link can be properly deleted on failure.

It's possible to refactor the logic to make the ovs_netdev_link() do
only the linking part and let the callers perform a proper destruction,
but it will be much more code for each legacy tunnel port type, so it
is not worth it for the bug fix.

Fixes: 614732eaa12d ("openvswitch: Use regular VXLAN net_device device")
Reported-by: Yuan Tan <tanyuan98@outlook.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Reported-by: Yang Yang <n05ec@lzu.edu.cn>
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/vport-geneve.c |  5 ++-
 net/openvswitch/vport-gre.c    |  5 ++-
 net/openvswitch/vport-netdev.c | 58 ++++++++++++++++++++--------------
 net/openvswitch/vport-netdev.h |  2 +-
 net/openvswitch/vport-vxlan.c  |  5 ++-
 5 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/net/openvswitch/vport-geneve.c b/net/openvswitch/vport-geneve.c
index b10e1602c6b14..cb5ea4424ffc8 100644
--- a/net/openvswitch/vport-geneve.c
+++ b/net/openvswitch/vport-geneve.c
@@ -97,6 +97,9 @@ static struct vport *geneve_tnl_create(const struct vport_parms *parms)
 		goto error;
 	}
 
+	vport->dev = dev;
+	netdev_hold(vport->dev, &vport->dev_tracker, GFP_KERNEL);
+
 	rtnl_unlock();
 	return vport;
 error:
@@ -111,7 +114,7 @@ static struct vport *geneve_create(const struct vport_parms *parms)
 	if (IS_ERR(vport))
 		return vport;
 
-	return ovs_netdev_link(vport, parms->name);
+	return ovs_netdev_link(vport, true);
 }
 
 static struct vport_ops ovs_geneve_vport_ops = {
diff --git a/net/openvswitch/vport-gre.c b/net/openvswitch/vport-gre.c
index 4014c9b5eb798..6cb5a697b396a 100644
--- a/net/openvswitch/vport-gre.c
+++ b/net/openvswitch/vport-gre.c
@@ -63,6 +63,9 @@ static struct vport *gre_tnl_create(const struct vport_parms *parms)
 		return ERR_PTR(err);
 	}
 
+	vport->dev = dev;
+	netdev_hold(vport->dev, &vport->dev_tracker, GFP_KERNEL);
+
 	rtnl_unlock();
 	return vport;
 }
@@ -75,7 +78,7 @@ static struct vport *gre_create(const struct vport_parms *parms)
 	if (IS_ERR(vport))
 		return vport;
 
-	return ovs_netdev_link(vport, parms->name);
+	return ovs_netdev_link(vport, true);
 }
 
 static struct vport_ops ovs_gre_vport_ops = {
diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
index 12055af832dc0..a92ca8b37f96a 100644
--- a/net/openvswitch/vport-netdev.c
+++ b/net/openvswitch/vport-netdev.c
@@ -73,37 +73,21 @@ static struct net_device *get_dpdev(const struct datapath *dp)
 	return local->dev;
 }
 
-struct vport *ovs_netdev_link(struct vport *vport, const char *name)
+struct vport *ovs_netdev_link(struct vport *vport, bool tunnel)
 {
 	int err;
 
-	vport->dev = dev_get_by_name(ovs_dp_get_net(vport->dp), name);
-	if (!vport->dev) {
+	if (WARN_ON_ONCE(!vport->dev)) {
 		err = -ENODEV;
 		goto error_free_vport;
 	}
-	/* Ensure that the device exists and that the provided
-	 * name is not one of its aliases.
-	 */
-	if (strcmp(name, ovs_vport_name(vport))) {
-		err = -ENODEV;
-		goto error_put;
-	}
-	netdev_tracker_alloc(vport->dev, &vport->dev_tracker, GFP_KERNEL);
-	if (vport->dev->flags & IFF_LOOPBACK ||
-	    (vport->dev->type != ARPHRD_ETHER &&
-	     vport->dev->type != ARPHRD_NONE) ||
-	    ovs_is_internal_dev(vport->dev)) {
-		err = -EINVAL;
-		goto error_put;
-	}
 
 	rtnl_lock();
 	err = netdev_master_upper_dev_link(vport->dev,
 					   get_dpdev(vport->dp),
 					   NULL, NULL, NULL);
 	if (err)
-		goto error_unlock;
+		goto error_put_unlock;
 
 	err = netdev_rx_handler_register(vport->dev, netdev_frame_hook,
 					 vport);
@@ -119,10 +103,11 @@ struct vport *ovs_netdev_link(struct vport *vport, const char *name)
 
 error_master_upper_dev_unlink:
 	netdev_upper_dev_unlink(vport->dev, get_dpdev(vport->dp));
-error_unlock:
-	rtnl_unlock();
-error_put:
+error_put_unlock:
+	if (tunnel && vport->dev->reg_state == NETREG_REGISTERED)
+		rtnl_delete_link(vport->dev, 0, NULL);
 	netdev_put(vport->dev, &vport->dev_tracker);
+	rtnl_unlock();
 error_free_vport:
 	ovs_vport_free(vport);
 	return ERR_PTR(err);
@@ -132,12 +117,39 @@ EXPORT_SYMBOL_GPL(ovs_netdev_link);
 static struct vport *netdev_create(const struct vport_parms *parms)
 {
 	struct vport *vport;
+	int err;
 
 	vport = ovs_vport_alloc(0, &ovs_netdev_vport_ops, parms);
 	if (IS_ERR(vport))
 		return vport;
 
-	return ovs_netdev_link(vport, parms->name);
+	vport->dev = dev_get_by_name(ovs_dp_get_net(vport->dp), parms->name);
+	if (!vport->dev) {
+		err = -ENODEV;
+		goto error_free_vport;
+	}
+	netdev_tracker_alloc(vport->dev, &vport->dev_tracker, GFP_KERNEL);
+
+	/* Ensure that the provided name is not an alias. */
+	if (strcmp(parms->name, ovs_vport_name(vport))) {
+		err = -ENODEV;
+		goto error_put;
+	}
+
+	if (vport->dev->flags & IFF_LOOPBACK ||
+	    (vport->dev->type != ARPHRD_ETHER &&
+	     vport->dev->type != ARPHRD_NONE) ||
+	    ovs_is_internal_dev(vport->dev)) {
+		err = -EINVAL;
+		goto error_put;
+	}
+
+	return ovs_netdev_link(vport, false);
+error_put:
+	netdev_put(vport->dev, &vport->dev_tracker);
+error_free_vport:
+	ovs_vport_free(vport);
+	return ERR_PTR(err);
 }
 
 static void vport_netdev_free(struct rcu_head *rcu)
diff --git a/net/openvswitch/vport-netdev.h b/net/openvswitch/vport-netdev.h
index c5d83a43bfc49..6c0d7366f9862 100644
--- a/net/openvswitch/vport-netdev.h
+++ b/net/openvswitch/vport-netdev.h
@@ -13,7 +13,7 @@
 
 struct vport *ovs_netdev_get_vport(struct net_device *dev);
 
-struct vport *ovs_netdev_link(struct vport *vport, const char *name);
+struct vport *ovs_netdev_link(struct vport *vport, bool tunnel);
 void ovs_netdev_detach_dev(struct vport *);
 
 int __init ovs_netdev_init(void);
diff --git a/net/openvswitch/vport-vxlan.c b/net/openvswitch/vport-vxlan.c
index 0b881b043bcf4..c1b37b50d29e1 100644
--- a/net/openvswitch/vport-vxlan.c
+++ b/net/openvswitch/vport-vxlan.c
@@ -126,6 +126,9 @@ static struct vport *vxlan_tnl_create(const struct vport_parms *parms)
 		goto error;
 	}
 
+	vport->dev = dev;
+	netdev_hold(vport->dev, &vport->dev_tracker, GFP_KERNEL);
+
 	rtnl_unlock();
 	return vport;
 error:
@@ -140,7 +143,7 @@ static struct vport *vxlan_create(const struct vport_parms *parms)
 	if (IS_ERR(vport))
 		return vport;
 
-	return ovs_netdev_link(vport, parms->name);
+	return ovs_netdev_link(vport, true);
 }
 
 static struct vport_ops ovs_vxlan_netdev_vport_ops = {
-- 
2.53.0


