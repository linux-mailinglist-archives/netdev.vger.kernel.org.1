Return-Path: <netdev+bounces-287709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHbyF9jIBGqnOgIAu9opvQ
	(envelope-from <netdev+bounces-287709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:54:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9405395C5
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 013843095005
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9313B389A;
	Wed, 13 May 2026 18:36:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844DA3AC0C3
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 18:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697385; cv=none; b=qGbTdjmoGwTfFL2aLAKQCt8F70QNeDnXr4mJHrUsRCHP5dHadQI6rgNFnOg+e1EH82CPFJe7ZYOx2WjX75aWN0tkt0iAljfQX0q2N6Gha4HQ/6P+NXrpWblN/agTapfG+Dcp/cdAcdZCtZDRYhShpBfa8d4uVckOuYbeGoMZop8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697385; c=relaxed/simple;
	bh=wWa1JBSE3nhXt0Rji3VN7q4eeVvPHVU0QnbEnwlLuzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9DCSbXyPLeJrNl4UbTzc6uZeVYiDhJK8sPphrBRYVWgID22lV1mG2aImxENVfXIVHxeRJvgGN7K1MBH9s3ULaJt3gNyJZahSFhUvBoLThu7X6whHoIDLT5z/JIIvAJVmLauMc2QayqvgJlABukSfB16taVoeht6cG6+3GHPpBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-48e56c1bf5dso43100245e9.3
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 11:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697380; x=1779302180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G7xkY4psIDuneV/U6xl1v5+LWyryeqTzrgr/KXeFrns=;
        b=dGJ1RIkIGssx7cDZGbpe9Q58KIBlIECL7NxkZUVKajxVRKra0cKnAusanvV+5pyJlR
         nBWHzioVCEAGSAEEGuVmBDj9Oj4Fzr9SVgN//oa5+GXAT+qi2piPQ3mJ9nQ/St/xbZ4j
         oyqUC0rNpKtPcTjvdQtQTyEaH+iPMR69Uikw3U7OtAMQfHvSGf1n//s1UUpAAUMIQusZ
         e4nFqldzfeujfPJ9hY/gTOFbJx+ACX/m0Zywck/asjNvogp8bmu7NImqWEpmjiGI2YCi
         kCJqaC3+hCQkVvMlSOwUMTlFJxzV3f3QGuWNSvSFHna+YUT9wGkpA1xZsxaBBMaTMZe/
         3XKg==
X-Gm-Message-State: AOJu0YyCzZfoP/05mHUzbCMmJ3ouMmvWSFUhHlYn+zYHdoFpYbZwk8ga
	6/8qas/3FmJ11dTtXXRrlnjsOQlkdwAmz6pVxNpxZUBqEMxYazL/97Y4u/HfiHch
X-Gm-Gg: Acq92OF3ImMhr3qBFCc9mQ/b/ppFkElCcMRvMy+aAWUX8dArmGH6DYoGm/wDdRDClOV
	V7WgQD+wwoJLy+Nv00Y/FrhfV7Wd4Td1kXIMBSkv6WKyWPLXk7lHTllxc3qIQP9braXFlU3GXb9
	q9BCuZeqqOZvgesvdvnB4ef9efjWC0xj9T5+1KUcUijlJsqPFZ8HOPf0HaAZC/zwwacFx4eizny
	e+yfTSpzJ/c8yIMCpcBVYz1OjylshPo39xbPygx7kxZDpPkqaQXhO+X4myHm4VDLF8HpXoTGUdI
	trMmFMr10KYKTn8JJnkyiXbEaxbRQZAH+5g9wclqu/R6MXQTyqseAZp+hTFZO2XOBv49ZKigGl4
	cRBjcjhEUl7JFsgT2MB0RyxK8w20QiL0QOCyX18gzJEY4Oji5ixQJtQaIlu75t8U1UrDuOWW7Gd
	XoZ2xMhvdOdAJ2T8ze3CTodySC2AWWqOjFBCt2sbihvet9IJePkeMx+pG6UMjF8zUzOcLJjA==
X-Received: by 2002:a05:600c:4c29:b0:48f:d1b8:9aa4 with SMTP id 5b1f17b1804b1-48fd1b8a058mr27450615e9.7.1778697379653;
        Wed, 13 May 2026 11:36:19 -0700 (PDT)
Received: from im-t490s.redhat.com (37-48-40-237.nat.epc.tmcz.cz. [37.48.40.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6454sm720609f8f.34.2026.05.13.11.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:36:19 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Petr Machata <petrm@nvidia.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Antoine Tenart <atenart@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [RFC net-next 1/6] openvswitch: remove support for legacy tunnel types
Date: Wed, 13 May 2026 20:35:21 +0200
Message-ID: <20260513183559.2141010-2-i.maximets@ovn.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513183559.2141010-1-i.maximets@ovn.org>
References: <20260513183559.2141010-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5C9405395C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287709-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[ovn.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.915];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ovn.org:email,ovn.org:mid]
X-Rspamd-Action: no action

ovs-vswitchd doesn't use OVS_VPORT_TYPE_GRE/VXLAN/GENEVE with upstream
Linux kernel module since adding support for standard tunnel devices
with COLLECT_METADATA back in 2017.  The code to use them is still
present, but it is only activated as a fallback for old kernels, so
not used in practice.  And it is marked for removal in the next OVS
release this summer.

Device reference management and the netlink options parsing for these
port types is complicated and was a CVE magnet recently.  Since there
are no actual users for these port types for a very long time, let's
just remove the support entirely.

A comment is added to the uAPI header noting that standard RTM_NEWLINK
with COLLECT_METADATA followed by OVS_VPORT_CMD_NEW with the simple
OVS_VPORT_TYPE_NETDEV should be used instead.

Modules responsible for these tunnel ports are removed as well as
selftests covering this functionality.  Further cleanups will follow.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 include/uapi/linux/openvswitch.h              |  31 +++-
 net/openvswitch/Kconfig                       |  35 ----
 net/openvswitch/Makefile                      |   4 -
 net/openvswitch/datapath.c                    |   6 +-
 net/openvswitch/vport-geneve.c                | 143 ---------------
 net/openvswitch/vport-gre.c                   | 106 -----------
 net/openvswitch/vport-netdev.c                |  28 +--
 net/openvswitch/vport-netdev.h                |   3 +-
 net/openvswitch/vport-vxlan.c                 | 172 ------------------
 tools/testing/selftests/net/config            |   3 -
 .../selftests/net/openvswitch/openvswitch.sh  |  37 ----
 .../selftests/net/openvswitch/ovs-dpctl.py    |  93 +++-------
 12 files changed, 53 insertions(+), 608 deletions(-)
 delete mode 100644 net/openvswitch/vport-geneve.c
 delete mode 100644 net/openvswitch/vport-gre.c
 delete mode 100644 net/openvswitch/vport-vxlan.c

diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
index aa2acdbda8f89..440825e658371 100644
--- a/include/uapi/linux/openvswitch.h
+++ b/include/uapi/linux/openvswitch.h
@@ -244,13 +244,33 @@ enum ovs_vport_cmd {
 	OVS_VPORT_CMD_SET
 };
 
+/**
+ * enum ovs_vport_type - OVS vport types for %OVS_VPORT_ATTR_TYPE.
+ * @OVS_VPORT_TYPE_NETDEV: Existing network device attached as a vport.
+ * @OVS_VPORT_TYPE_INTERNAL: Network device implemented by the OVS datapath.
+ * @OVS_VPORT_TYPE_GRE: Legacy GRE tunnel.  Not supported, see below.
+ * @OVS_VPORT_TYPE_VXLAN: Legacy VXLAN tunnel.  Not supported, see below.
+ * @OVS_VPORT_TYPE_GENEVE: Legacy Geneve tunnel.  Not supported, see below.
+ *
+ * The tunnel vport types are not supported.  Instead, create the tunnel device
+ * using %RTM_NEWLINK with the appropriate %IFLA_INFO_KIND (e.g. ``gre``,
+ * ``gretap``, ``vxlan``, ``geneve``, or other tunnel types) and add it as
+ * %OVS_VPORT_TYPE_NETDEV.  To match and set tunnel parameters on a per-flow
+ * basis, the tunnel device should collect metadata.  To do that, some tunnel
+ * types require an explicit flag such as %IFLA_VXLAN_COLLECT_METADATA for
+ * ``vxlan``, while others such as ``bareudp`` collect metadata
+ * unconditionally.
+ */
 enum ovs_vport_type {
+	/* private: */
 	OVS_VPORT_TYPE_UNSPEC,
+	/* public: */
 	OVS_VPORT_TYPE_NETDEV,   /* network device */
 	OVS_VPORT_TYPE_INTERNAL, /* network device implemented by datapath */
-	OVS_VPORT_TYPE_GRE,      /* GRE tunnel. */
-	OVS_VPORT_TYPE_VXLAN,	 /* VXLAN tunnel. */
-	OVS_VPORT_TYPE_GENEVE,	 /* Geneve tunnel. */
+	OVS_VPORT_TYPE_GRE,      /* GRE tunnel (legacy, not supported). */
+	OVS_VPORT_TYPE_VXLAN,	 /* VXLAN tunnel (legacy, not supported). */
+	OVS_VPORT_TYPE_GENEVE,	 /* Geneve tunnel (legacy, not supported). */
+	/* private: */
 	__OVS_VPORT_TYPE_MAX
 };
 
@@ -284,7 +304,7 @@ enum ovs_vport_type {
  * %OVS_VPORT_ATTR_NAME attributes are required.  %OVS_VPORT_ATTR_PORT_NO is
  * optional; if not specified a free port number is automatically selected.
  * Whether %OVS_VPORT_ATTR_OPTIONS is required or optional depends on the type
- * of vport.
+ * of vport.  None of currently supported vport types support options.
  *
  * For other requests, if %OVS_VPORT_ATTR_NAME is specified then it is used to
  * look up the vport to operate on; otherwise dp_idx from the &struct
@@ -336,7 +356,8 @@ enum {
 #define OVS_VXLAN_EXT_MAX (__OVS_VXLAN_EXT_MAX - 1)
 
 
-/* OVS_VPORT_ATTR_OPTIONS attributes for tunnels.
+/* OVS_VPORT_ATTR_OPTIONS attributes for legacy tunnel vports.
+ * Not supported, see the note for enum ovs_vport_type.
  */
 enum {
 	OVS_TUNNEL_ATTR_UNSPEC,
diff --git a/net/openvswitch/Kconfig b/net/openvswitch/Kconfig
index e6aaee92dba48..19ac9ae18f1e7 100644
--- a/net/openvswitch/Kconfig
+++ b/net/openvswitch/Kconfig
@@ -40,38 +40,3 @@ config OPENVSWITCH
 	  called openvswitch.
 
 	  If unsure, say N.
-
-config OPENVSWITCH_GRE
-	tristate "Open vSwitch GRE tunneling support"
-	depends on OPENVSWITCH
-	depends on NET_IPGRE
-	default OPENVSWITCH
-	help
-	  If you say Y here, then the Open vSwitch will be able create GRE
-	  vport.
-
-	  Say N to exclude this support and reduce the binary size.
-
-	  If unsure, say Y.
-
-config OPENVSWITCH_VXLAN
-	tristate "Open vSwitch VXLAN tunneling support"
-	depends on OPENVSWITCH
-	depends on VXLAN
-	default OPENVSWITCH
-	help
-	  If you say Y here, then the Open vSwitch will be able create vxlan vport.
-
-	  Say N to exclude this support and reduce the binary size.
-
-	  If unsure, say Y.
-
-config OPENVSWITCH_GENEVE
-	tristate "Open vSwitch Geneve tunneling support"
-	depends on OPENVSWITCH
-	depends on GENEVE
-	default OPENVSWITCH
-	help
-	  If you say Y here, then the Open vSwitch will be able create geneve vport.
-
-	  Say N to exclude this support and reduce the binary size.
diff --git a/net/openvswitch/Makefile b/net/openvswitch/Makefile
index 28982630bef32..46a27ab369f90 100644
--- a/net/openvswitch/Makefile
+++ b/net/openvswitch/Makefile
@@ -22,8 +22,4 @@ ifneq ($(CONFIG_NF_CONNTRACK),)
 openvswitch-y += conntrack.o
 endif
 
-obj-$(CONFIG_OPENVSWITCH_VXLAN)+= vport-vxlan.o
-obj-$(CONFIG_OPENVSWITCH_GENEVE)+= vport-geneve.o
-obj-$(CONFIG_OPENVSWITCH_GRE)	+= vport-gre.o
-
 CFLAGS_openvswitch_trace.o = -I$(src)
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index bbbde50fc6498..d86c53fedc1e1 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -2206,11 +2206,9 @@ static size_t ovs_vport_cmd_msg_size(void)
 	/* OVS_VPORT_ATTR_UPCALL_PID */
 	msgsize += nla_total_size(nr_cpu_ids * sizeof(u32));
 
-	/* OVS_VPORT_ATTR_OPTIONS(OVS_TUNNEL_ATTR_DST_PORT +
-	 *                        OVS_TUNNEL_ATTR_EXTENSION(OVS_VXLAN_EXT_GBP))
+	/* There are no vports supporting OVS_VPORT_ATTR_OPTIONS, so it is
+	 * not included in the message size calculation.
 	 */
-	msgsize += nla_total_size(nla_total_size(sizeof(u16)) +
-				  nla_total_size(nla_total_size(0)));
 
 	return msgsize;
 }
diff --git a/net/openvswitch/vport-geneve.c b/net/openvswitch/vport-geneve.c
deleted file mode 100644
index cb5ea4424ffc8..0000000000000
--- a/net/openvswitch/vport-geneve.c
+++ /dev/null
@@ -1,143 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2014 Nicira, Inc.
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/in.h>
-#include <linux/ip.h>
-#include <linux/net.h>
-#include <linux/rculist.h>
-#include <linux/udp.h>
-#include <linux/if_vlan.h>
-#include <linux/module.h>
-
-#include <net/geneve.h>
-#include <net/icmp.h>
-#include <net/ip.h>
-#include <net/route.h>
-#include <net/udp.h>
-#include <net/xfrm.h>
-
-#include "datapath.h"
-#include "vport.h"
-#include "vport-netdev.h"
-
-static struct vport_ops ovs_geneve_vport_ops;
-/**
- * struct geneve_port - Keeps track of open UDP ports
- * @dst_port: destination port.
- */
-struct geneve_port {
-	u16 dst_port;
-};
-
-static inline struct geneve_port *geneve_vport(const struct vport *vport)
-{
-	return vport_priv(vport);
-}
-
-static int geneve_get_options(const struct vport *vport,
-			      struct sk_buff *skb)
-{
-	struct geneve_port *geneve_port = geneve_vport(vport);
-
-	if (nla_put_u16(skb, OVS_TUNNEL_ATTR_DST_PORT, geneve_port->dst_port))
-		return -EMSGSIZE;
-	return 0;
-}
-
-static struct vport *geneve_tnl_create(const struct vport_parms *parms)
-{
-	struct net *net = ovs_dp_get_net(parms->dp);
-	struct nlattr *options = parms->options;
-	struct geneve_port *geneve_port;
-	struct net_device *dev;
-	struct vport *vport;
-	struct nlattr *a;
-	u16 dst_port;
-	int err;
-
-	if (!options) {
-		err = -EINVAL;
-		goto error;
-	}
-
-	a = nla_find_nested(options, OVS_TUNNEL_ATTR_DST_PORT);
-	if (a && nla_len(a) == sizeof(u16)) {
-		dst_port = nla_get_u16(a);
-	} else {
-		/* Require destination port from userspace. */
-		err = -EINVAL;
-		goto error;
-	}
-
-	vport = ovs_vport_alloc(sizeof(struct geneve_port),
-				&ovs_geneve_vport_ops, parms);
-	if (IS_ERR(vport))
-		return vport;
-
-	geneve_port = geneve_vport(vport);
-	geneve_port->dst_port = dst_port;
-
-	rtnl_lock();
-	dev = geneve_dev_create_fb(net, parms->name, NET_NAME_USER, dst_port);
-	if (IS_ERR(dev)) {
-		rtnl_unlock();
-		ovs_vport_free(vport);
-		return ERR_CAST(dev);
-	}
-
-	err = dev_change_flags(dev, dev->flags | IFF_UP, NULL);
-	if (err < 0) {
-		rtnl_delete_link(dev, 0, NULL);
-		rtnl_unlock();
-		ovs_vport_free(vport);
-		goto error;
-	}
-
-	vport->dev = dev;
-	netdev_hold(vport->dev, &vport->dev_tracker, GFP_KERNEL);
-
-	rtnl_unlock();
-	return vport;
-error:
-	return ERR_PTR(err);
-}
-
-static struct vport *geneve_create(const struct vport_parms *parms)
-{
-	struct vport *vport;
-
-	vport = geneve_tnl_create(parms);
-	if (IS_ERR(vport))
-		return vport;
-
-	return ovs_netdev_link(vport, true);
-}
-
-static struct vport_ops ovs_geneve_vport_ops = {
-	.type		= OVS_VPORT_TYPE_GENEVE,
-	.create		= geneve_create,
-	.destroy	= ovs_netdev_tunnel_destroy,
-	.get_options	= geneve_get_options,
-	.send		= dev_queue_xmit,
-};
-
-static int __init ovs_geneve_tnl_init(void)
-{
-	return ovs_vport_ops_register(&ovs_geneve_vport_ops);
-}
-
-static void __exit ovs_geneve_tnl_exit(void)
-{
-	ovs_vport_ops_unregister(&ovs_geneve_vport_ops);
-}
-
-module_init(ovs_geneve_tnl_init);
-module_exit(ovs_geneve_tnl_exit);
-
-MODULE_DESCRIPTION("OVS: Geneve switching port");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("vport-type-5");
diff --git a/net/openvswitch/vport-gre.c b/net/openvswitch/vport-gre.c
deleted file mode 100644
index 6cb5a697b396a..0000000000000
--- a/net/openvswitch/vport-gre.c
+++ /dev/null
@@ -1,106 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2007-2014 Nicira, Inc.
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/if.h>
-#include <linux/skbuff.h>
-#include <linux/ip.h>
-#include <linux/if_tunnel.h>
-#include <linux/if_vlan.h>
-#include <linux/in.h>
-#include <linux/in_route.h>
-#include <linux/inetdevice.h>
-#include <linux/jhash.h>
-#include <linux/list.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/workqueue.h>
-#include <linux/rculist.h>
-#include <net/route.h>
-#include <net/xfrm.h>
-
-#include <net/icmp.h>
-#include <net/ip.h>
-#include <net/ip_tunnels.h>
-#include <net/gre.h>
-#include <net/net_namespace.h>
-#include <net/netns/generic.h>
-#include <net/protocol.h>
-
-#include "datapath.h"
-#include "vport.h"
-#include "vport-netdev.h"
-
-static struct vport_ops ovs_gre_vport_ops;
-
-static struct vport *gre_tnl_create(const struct vport_parms *parms)
-{
-	struct net *net = ovs_dp_get_net(parms->dp);
-	struct net_device *dev;
-	struct vport *vport;
-	int err;
-
-	vport = ovs_vport_alloc(0, &ovs_gre_vport_ops, parms);
-	if (IS_ERR(vport))
-		return vport;
-
-	rtnl_lock();
-	dev = gretap_fb_dev_create(net, parms->name, NET_NAME_USER);
-	if (IS_ERR(dev)) {
-		rtnl_unlock();
-		ovs_vport_free(vport);
-		return ERR_CAST(dev);
-	}
-
-	err = dev_change_flags(dev, dev->flags | IFF_UP, NULL);
-	if (err < 0) {
-		rtnl_delete_link(dev, 0, NULL);
-		rtnl_unlock();
-		ovs_vport_free(vport);
-		return ERR_PTR(err);
-	}
-
-	vport->dev = dev;
-	netdev_hold(vport->dev, &vport->dev_tracker, GFP_KERNEL);
-
-	rtnl_unlock();
-	return vport;
-}
-
-static struct vport *gre_create(const struct vport_parms *parms)
-{
-	struct vport *vport;
-
-	vport = gre_tnl_create(parms);
-	if (IS_ERR(vport))
-		return vport;
-
-	return ovs_netdev_link(vport, true);
-}
-
-static struct vport_ops ovs_gre_vport_ops = {
-	.type		= OVS_VPORT_TYPE_GRE,
-	.create		= gre_create,
-	.send		= dev_queue_xmit,
-	.destroy	= ovs_netdev_tunnel_destroy,
-};
-
-static int __init ovs_gre_tnl_init(void)
-{
-	return ovs_vport_ops_register(&ovs_gre_vport_ops);
-}
-
-static void __exit ovs_gre_tnl_exit(void)
-{
-	ovs_vport_ops_unregister(&ovs_gre_vport_ops);
-}
-
-module_init(ovs_gre_tnl_init);
-module_exit(ovs_gre_tnl_exit);
-
-MODULE_DESCRIPTION("OVS: GRE switching port");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("vport-type-3");
diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
index c42642075685d..ebfee309e6dbb 100644
--- a/net/openvswitch/vport-netdev.c
+++ b/net/openvswitch/vport-netdev.c
@@ -73,7 +73,7 @@ static struct net_device *get_dpdev(const struct datapath *dp)
 	return local->dev;
 }
 
-struct vport *ovs_netdev_link(struct vport *vport, bool tunnel)
+struct vport *ovs_netdev_link(struct vport *vport)
 {
 	int err;
 
@@ -104,8 +104,6 @@ struct vport *ovs_netdev_link(struct vport *vport, bool tunnel)
 error_master_upper_dev_unlink:
 	netdev_upper_dev_unlink(vport->dev, get_dpdev(vport->dp));
 error_put_unlock:
-	if (tunnel && vport->dev->reg_state == NETREG_REGISTERED)
-		rtnl_delete_link(vport->dev, 0, NULL);
 	netdev_put(vport->dev, &vport->dev_tracker);
 	rtnl_unlock();
 error_free_vport:
@@ -144,7 +142,7 @@ static struct vport *netdev_create(const struct vport_parms *parms)
 		goto error_put;
 	}
 
-	return ovs_netdev_link(vport, false);
+	return ovs_netdev_link(vport);
 error_put:
 	netdev_put(vport->dev, &vport->dev_tracker);
 error_free_vport:
@@ -196,28 +194,6 @@ static void netdev_destroy(struct vport *vport)
 	call_rcu(&vport->rcu, vport_netdev_free);
 }
 
-void ovs_netdev_tunnel_destroy(struct vport *vport)
-{
-	rtnl_lock();
-	if (netif_is_ovs_port(vport->dev))
-		ovs_netdev_detach_dev(vport);
-
-	/* We can be invoked by both explicit vport deletion and
-	 * underlying netdev deregistration; delete the link only
-	 * if it's not already shutting down.
-	 */
-	if (vport->dev->reg_state == NETREG_REGISTERED)
-		rtnl_delete_link(vport->dev, 0, NULL);
-
-	/* We can't put the device reference yet, since it can still be in
-	 * use, but rtnl_unlock()->netdev_run_todo() will block until all
-	 * the references are released, so the RCU call must be before it.
-	 */
-	call_rcu(&vport->rcu, vport_netdev_free);
-	rtnl_unlock();
-}
-EXPORT_SYMBOL_GPL(ovs_netdev_tunnel_destroy);
-
 /* Returns null if this device is not attached to a datapath. */
 struct vport *ovs_netdev_get_vport(struct net_device *dev)
 {
diff --git a/net/openvswitch/vport-netdev.h b/net/openvswitch/vport-netdev.h
index 6c0d7366f9862..15fa27054b505 100644
--- a/net/openvswitch/vport-netdev.h
+++ b/net/openvswitch/vport-netdev.h
@@ -13,11 +13,10 @@
 
 struct vport *ovs_netdev_get_vport(struct net_device *dev);
 
-struct vport *ovs_netdev_link(struct vport *vport, bool tunnel);
+struct vport *ovs_netdev_link(struct vport *vport);
 void ovs_netdev_detach_dev(struct vport *);
 
 int __init ovs_netdev_init(void);
 void ovs_netdev_exit(void);
 
-void ovs_netdev_tunnel_destroy(struct vport *vport);
 #endif /* vport_netdev.h */
diff --git a/net/openvswitch/vport-vxlan.c b/net/openvswitch/vport-vxlan.c
deleted file mode 100644
index c1b37b50d29e1..0000000000000
--- a/net/openvswitch/vport-vxlan.c
+++ /dev/null
@@ -1,172 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2014 Nicira, Inc.
- * Copyright (c) 2013 Cisco Systems, Inc.
- */
-
-#include <linux/kernel.h>
-#include <linux/skbuff.h>
-#include <linux/openvswitch.h>
-#include <linux/module.h>
-#include <net/udp.h>
-#include <net/ip_tunnels.h>
-#include <net/rtnetlink.h>
-#include <net/vxlan.h>
-
-#include "datapath.h"
-#include "vport.h"
-#include "vport-netdev.h"
-
-static struct vport_ops ovs_vxlan_netdev_vport_ops;
-
-static int vxlan_get_options(const struct vport *vport, struct sk_buff *skb)
-{
-	struct vxlan_dev *vxlan = netdev_priv(vport->dev);
-	__be16 dst_port = vxlan->cfg.dst_port;
-
-	if (nla_put_u16(skb, OVS_TUNNEL_ATTR_DST_PORT, ntohs(dst_port)))
-		return -EMSGSIZE;
-
-	if (vxlan->cfg.flags & VXLAN_F_GBP) {
-		struct nlattr *exts;
-
-		exts = nla_nest_start_noflag(skb, OVS_TUNNEL_ATTR_EXTENSION);
-		if (!exts)
-			return -EMSGSIZE;
-
-		if (vxlan->cfg.flags & VXLAN_F_GBP &&
-		    nla_put_flag(skb, OVS_VXLAN_EXT_GBP))
-			return -EMSGSIZE;
-
-		nla_nest_end(skb, exts);
-	}
-
-	return 0;
-}
-
-static const struct nla_policy exts_policy[OVS_VXLAN_EXT_MAX + 1] = {
-	[OVS_VXLAN_EXT_GBP]	= { .type = NLA_FLAG, },
-};
-
-static int vxlan_configure_exts(struct vport *vport, struct nlattr *attr,
-				struct vxlan_config *conf)
-{
-	struct nlattr *exts[OVS_VXLAN_EXT_MAX + 1];
-	int err;
-
-	if (nla_len(attr) < sizeof(struct nlattr))
-		return -EINVAL;
-
-	err = nla_parse_nested_deprecated(exts, OVS_VXLAN_EXT_MAX, attr,
-					  exts_policy, NULL);
-	if (err < 0)
-		return err;
-
-	if (exts[OVS_VXLAN_EXT_GBP])
-		conf->flags |= VXLAN_F_GBP;
-
-	return 0;
-}
-
-static struct vport *vxlan_tnl_create(const struct vport_parms *parms)
-{
-	struct net *net = ovs_dp_get_net(parms->dp);
-	struct nlattr *options = parms->options;
-	struct net_device *dev;
-	struct vport *vport;
-	struct nlattr *a;
-	int err;
-	struct vxlan_config conf = {
-		.no_share = true,
-		.flags = VXLAN_F_COLLECT_METADATA | VXLAN_F_UDP_ZERO_CSUM6_RX,
-		/* Don't restrict the packets that can be sent by MTU */
-		.mtu = IP_MAX_MTU,
-	};
-
-	if (!options) {
-		err = -EINVAL;
-		goto error;
-	}
-
-	a = nla_find_nested(options, OVS_TUNNEL_ATTR_DST_PORT);
-	if (a && nla_len(a) == sizeof(u16)) {
-		conf.dst_port = htons(nla_get_u16(a));
-	} else {
-		/* Require destination port from userspace. */
-		err = -EINVAL;
-		goto error;
-	}
-
-	vport = ovs_vport_alloc(0, &ovs_vxlan_netdev_vport_ops, parms);
-	if (IS_ERR(vport))
-		return vport;
-
-	a = nla_find_nested(options, OVS_TUNNEL_ATTR_EXTENSION);
-	if (a) {
-		err = vxlan_configure_exts(vport, a, &conf);
-		if (err) {
-			ovs_vport_free(vport);
-			goto error;
-		}
-	}
-
-	rtnl_lock();
-	dev = vxlan_dev_create(net, parms->name, NET_NAME_USER, &conf);
-	if (IS_ERR(dev)) {
-		rtnl_unlock();
-		ovs_vport_free(vport);
-		return ERR_CAST(dev);
-	}
-
-	err = dev_change_flags(dev, dev->flags | IFF_UP, NULL);
-	if (err < 0) {
-		rtnl_delete_link(dev, 0, NULL);
-		rtnl_unlock();
-		ovs_vport_free(vport);
-		goto error;
-	}
-
-	vport->dev = dev;
-	netdev_hold(vport->dev, &vport->dev_tracker, GFP_KERNEL);
-
-	rtnl_unlock();
-	return vport;
-error:
-	return ERR_PTR(err);
-}
-
-static struct vport *vxlan_create(const struct vport_parms *parms)
-{
-	struct vport *vport;
-
-	vport = vxlan_tnl_create(parms);
-	if (IS_ERR(vport))
-		return vport;
-
-	return ovs_netdev_link(vport, true);
-}
-
-static struct vport_ops ovs_vxlan_netdev_vport_ops = {
-	.type			= OVS_VPORT_TYPE_VXLAN,
-	.create			= vxlan_create,
-	.destroy		= ovs_netdev_tunnel_destroy,
-	.get_options		= vxlan_get_options,
-	.send			= dev_queue_xmit,
-};
-
-static int __init ovs_vxlan_tnl_init(void)
-{
-	return ovs_vport_ops_register(&ovs_vxlan_netdev_vport_ops);
-}
-
-static void __exit ovs_vxlan_tnl_exit(void)
-{
-	ovs_vport_ops_unregister(&ovs_vxlan_netdev_vport_ops);
-}
-
-module_init(ovs_vxlan_tnl_init);
-module_exit(ovs_vxlan_tnl_exit);
-
-MODULE_DESCRIPTION("OVS: VXLAN switching port");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("vport-type-4");
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index d07c5ac5cab7b..5e9ccc897a360 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -114,9 +114,6 @@ CONFIG_NFT_COMPAT=m
 CONFIG_NFT_NAT=m
 CONFIG_NUMA=y
 CONFIG_OPENVSWITCH=m
-CONFIG_OPENVSWITCH_GENEVE=m
-CONFIG_OPENVSWITCH_GRE=m
-CONFIG_OPENVSWITCH_VXLAN=m
 CONFIG_PAGE_POOL_STATS=y
 CONFIG_PROC_SYSCTL=y
 CONFIG_PSAMPLE=m
diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 3cdd953f68132..b327d3061ed53 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -26,7 +26,6 @@ tests="
 	netlink_checks				ovsnl: validate netlink attrs and settings
 	upcall_interfaces			ovs: test the upcall interfaces
 	tunnel_metadata				ovs: test extraction of tunnel metadata
-	tunnel_refcount				ovs: test tunnel vport reference cleanup
 	drop_reason				drop: test drop reasons are emitted
 	psample					psample: Sampling packets with psample"
 
@@ -831,42 +830,6 @@ test_tunnel_metadata() {
 	return 0
 }
 
-test_tunnel_refcount() {
-	sbxname="test_tunnel_refcount"
-	sbx_add "${sbxname}" || return 1
-
-	ovs_sbx "${sbxname}" ip netns add trefns || return 1
-	on_exit "ovs_sbx ${sbxname} ip netns del trefns"
-
-	for tun_type in gre vxlan geneve; do
-		info "testing ${tun_type} tunnel vport refcount"
-
-		ovs_sbx "${sbxname}" ip netns exec trefns \
-			python3 $ovs_base/ovs-dpctl.py \
-			add-dp dp-${tun_type} || return 1
-
-		ovs_sbx "${sbxname}" ip netns exec trefns \
-			python3 $ovs_base/ovs-dpctl.py \
-			add-if --no-lwt -t ${tun_type} \
-			dp-${tun_type} ovs-${tun_type}0 || return 1
-
-		ovs_wait ip -netns trefns link show \
-			ovs-${tun_type}0 >/dev/null 2>&1 || return 1
-
-		info "deleting dp - may hang if reference counting is broken"
-		ovs_sbx "${sbxname}" ip netns exec trefns \
-			python3 $ovs_base/ovs-dpctl.py \
-			del-dp dp-${tun_type} &
-
-		dev_removed() {
-			! ip -netns trefns link show "$1" >/dev/null 2>&1
-		}
-		ovs_wait dev_removed dp-${tun_type} || return 1
-		ovs_wait dev_removed ovs-${tun_type}0 || return 1
-	done
-	return 0
-}
-
 run_test() {
 	(
 	tname="$1"
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index bbe35e2718d26..ad8c47a482351 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -2012,9 +2012,6 @@ class OvsDatapath(GenericNetlinkSocket):
 class OvsVport(GenericNetlinkSocket):
     OVS_VPORT_TYPE_NETDEV = 1
     OVS_VPORT_TYPE_INTERNAL = 2
-    OVS_VPORT_TYPE_GRE = 3
-    OVS_VPORT_TYPE_VXLAN = 4
-    OVS_VPORT_TYPE_GENEVE = 5
 
     class ovs_vport_msg(ovs_dp_msg):
         nla_map = (
@@ -2022,7 +2019,7 @@ class OvsVport(GenericNetlinkSocket):
             ("OVS_VPORT_ATTR_PORT_NO", "uint32"),
             ("OVS_VPORT_ATTR_TYPE", "uint32"),
             ("OVS_VPORT_ATTR_NAME", "asciiz"),
-            ("OVS_VPORT_ATTR_OPTIONS", "vportopts"),
+            ("OVS_VPORT_ATTR_OPTIONS", "none"),
             ("OVS_VPORT_ATTR_UPCALL_PID", "array(uint32)"),
             ("OVS_VPORT_ATTR_STATS", "vportstats"),
             ("OVS_VPORT_ATTR_PAD", "none"),
@@ -2030,13 +2027,6 @@ class OvsVport(GenericNetlinkSocket):
             ("OVS_VPORT_ATTR_NETNSID", "uint32"),
         )
 
-        class vportopts(nla):
-            nla_map = (
-                ("OVS_TUNNEL_ATTR_UNSPEC", "none"),
-                ("OVS_TUNNEL_ATTR_DST_PORT", "uint16"),
-                ("OVS_TUNNEL_ATTR_EXTENSION", "none"),
-            )
-
         class vportstats(nla):
             fields = (
                 ("rx_packets", "=Q"),
@@ -2054,25 +2044,13 @@ class OvsVport(GenericNetlinkSocket):
             return "netdev"
         elif vport_type == OvsVport.OVS_VPORT_TYPE_INTERNAL:
             return "internal"
-        elif vport_type == OvsVport.OVS_VPORT_TYPE_GRE:
-            return "gre"
-        elif vport_type == OvsVport.OVS_VPORT_TYPE_VXLAN:
-            return "vxlan"
-        elif vport_type == OvsVport.OVS_VPORT_TYPE_GENEVE:
-            return "geneve"
         raise ValueError("Unknown vport type:%d" % vport_type)
 
     def str_to_type(vport_type):
-        if vport_type == "netdev":
+        if vport_type in ["netdev", "gre", "vxlan", "geneve"]:
             return OvsVport.OVS_VPORT_TYPE_NETDEV
         elif vport_type == "internal":
             return OvsVport.OVS_VPORT_TYPE_INTERNAL
-        elif vport_type == "gre":
-            return OvsVport.OVS_VPORT_TYPE_GRE
-        elif vport_type == "vxlan":
-            return OvsVport.OVS_VPORT_TYPE_VXLAN
-        elif vport_type == "geneve":
-            return OvsVport.OVS_VPORT_TYPE_GENEVE
         raise ValueError("Unknown vport type: '%s'" % vport_type)
 
     def __init__(self, packet=OvsPacket()):
@@ -2105,16 +2083,18 @@ class OvsVport(GenericNetlinkSocket):
                 raise ne
         return reply
 
-    def attach(self, dpindex, vport_ifname, ptype, dport, lwt):
+    def attach(self, dpindex, vport_ifname, ptype, dport):
         msg = OvsVport.ovs_vport_msg()
 
         msg["cmd"] = OVS_VPORT_CMD_NEW
         msg["version"] = OVS_DATAPATH_VERSION
         msg["reserved"] = 0
         msg["dpifindex"] = dpindex
-        port_type = OvsVport.str_to_type(ptype)
 
         msg["attrs"].append(["OVS_VPORT_ATTR_NAME", vport_ifname])
+        msg["attrs"].append(
+            ["OVS_VPORT_ATTR_TYPE", OvsVport.str_to_type(ptype)]
+        )
         msg["attrs"].append(
             ["OVS_VPORT_ATTR_UPCALL_PID", [self.upcall_packet.epid]]
         )
@@ -2128,36 +2108,21 @@ class OvsVport(GenericNetlinkSocket):
                 if not dport:
                     dport = tnl[1]
 
-                if not lwt:
-                    if tnl[0] == "gre":
-                        # GRE tunnels have no options.
-                        break
-
-                    vportopt = OvsVport.ovs_vport_msg.vportopts()
-                    vportopt["attrs"].append(
-                        ["OVS_TUNNEL_ATTR_DST_PORT", dport]
-                    )
-                    msg["attrs"].append(
-                        ["OVS_VPORT_ATTR_OPTIONS", vportopt]
-                    )
-                else:
-                    port_type = OvsVport.OVS_VPORT_TYPE_NETDEV
-                    ipr = pyroute2.iproute.IPRoute()
-
-                    if tnl[0] == "geneve":
-                        ipr.link("add", ifname=vport_ifname, kind=tnl[0],
-                                 geneve_port=dport,
-                                 geneve_collect_metadata=True,
-                                 geneve_udp_zero_csum6_rx=1)
-                    elif tnl[0] == "gre":
-                        ipr.link("add", ifname=vport_ifname, kind="gretap",
-                                 gre_collect_metadata=True)
-                    elif tnl[0] == "vxlan":
-                        ipr.link("add", ifname=vport_ifname, kind=tnl[0],
-                                 vxlan_learning=0, vxlan_collect_metadata=1,
-                                 vxlan_udp_zero_csum6_rx=1, vxlan_port=dport)
+                ipr = pyroute2.iproute.IPRoute()
+
+                if tnl[0] == "geneve":
+                    ipr.link("add", ifname=vport_ifname, kind=tnl[0],
+                             geneve_port=dport,
+                             geneve_collect_metadata=True,
+                             geneve_udp_zero_csum6_rx=1)
+                elif tnl[0] == "gre":
+                    ipr.link("add", ifname=vport_ifname, kind="gretap",
+                             gre_collect_metadata=True)
+                elif tnl[0] == "vxlan":
+                    ipr.link("add", ifname=vport_ifname, kind=tnl[0],
+                             vxlan_learning=0, vxlan_collect_metadata=1,
+                             vxlan_udp_zero_csum6_rx=1, vxlan_port=dport)
                 break
-        msg["attrs"].append(["OVS_VPORT_ATTR_TYPE", port_type])
 
         try:
             reply = self.nlm_request(
@@ -2565,19 +2530,12 @@ def print_ovsdp_full(dp_lookup_rep, ifindex, ndb=NDB(), vpl=OvsVport()):
     for iface in ndb.interfaces:
         rep = vpl.info(iface.ifname, ifindex)
         if rep is not None:
-            opts = ""
-            vpo = rep.get_attr("OVS_VPORT_ATTR_OPTIONS")
-            if vpo:
-                dpo = vpo.get_attr("OVS_TUNNEL_ATTR_DST_PORT")
-                if dpo:
-                    opts += " tnl-dport:%s" % dpo
             print(
-                "  port %d: %s (%s%s)"
+                "  port %d: %s (%s)"
                 % (
                     rep.get_attr("OVS_VPORT_ATTR_PORT_NO"),
                     rep.get_attr("OVS_VPORT_ATTR_NAME"),
                     OvsVport.type_to_str(rep.get_attr("OVS_VPORT_ATTR_TYPE")),
-                    opts,
                 )
             )
 
@@ -2649,13 +2607,6 @@ def main(argv):
         default=0,
         help="Destination port (0 for default)"
     )
-    addifcmd.add_argument(
-        "-l",
-        "--lwt",
-        action=argparse.BooleanOptionalAction,
-        default=True,
-        help="Use LWT infrastructure instead of vport (default true)."
-    )
     delifcmd = subparsers.add_parser("del-if")
     delifcmd.add_argument("dpname", help="Datapath Name")
     delifcmd.add_argument("delif", help="Interface name for adding")
@@ -2729,7 +2680,7 @@ def main(argv):
             return 1
         dpindex = rep["dpifindex"]
         rep = ovsvp.attach(rep["dpifindex"], args.addif, args.ptype,
-                           args.dport, args.lwt)
+                           args.dport)
         msg = "vport '%s'" % args.addif
         if rep and rep["header"]["error"] is None:
             msg += " added."
-- 
2.53.0


