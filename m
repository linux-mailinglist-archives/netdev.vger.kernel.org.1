Return-Path: <netdev+bounces-143622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3B19C361F
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 02:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD71B1C22884
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 01:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8556338F83;
	Mon, 11 Nov 2024 01:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="1ROS159w"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8AB3B1A2
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 01:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288759; cv=none; b=Oq1Kg9cdtZyUsBW5yEGHiPROU8nea/mXUQ7Itkbb9Od6MK10idF4DTSjpbRSv2ej1MsnDHG8injwxxO92vATDOvG0ZAtfRRF6K4c9BoaQgryp/IGM32SAloAoy2PdE0neWm1QW3wQSMoZeeiJGMUZjAO11uJkK9qPXrCogPCV/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288759; c=relaxed/simple;
	bh=23UbsY/mqifYQJgheubCjtQcn8SrYehlQFTgvQMQAE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNLhD08QwAFzHiJZrXvAXD6Hn9ZF1L6n/xPFY2WdOfpJ78IgffBSEGfeEDqXXLnWCij9IMHXqxiX7yzYxKBDpWOuyu6viyNDL+cED5u4m1HKGM58tJnicinXXOEccshU8ZN4wBCflqHwJ6CzDJosI4pI9M5WmhNIeQhhrrv0sbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=1ROS159w; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5DAF62C05C6;
	Mon, 11 Nov 2024 14:32:29 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1731288749;
	bh=ha6guitHYpw7NDAj6XwH3gG4Gb/JxOADQzIg+ZXDLVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1ROS159womHmvSfOnxwXuonITWp3kQsN2tGPvbVZDAI6zhex7LzqQbFzucxi6gvzH
	 Wjdwg4qrmg+KJR7dJWOuvBAaGpuX/h4bHRIuoXOMTu+bhyeSAJrBSBmRH5qBIdAPsM
	 jDg5v6ah5DGPDIwlQzwAmFM2wtokDQgFkTFr7bS+TVxJL3UfxWpqTUvMKTXuK47yiM
	 F0Dbr9IY8QniL7XQPossxuZAH/l5gRmUjESkZyRdaei/FM7E+fS8pBfSRnfbsYCl5S
	 noo0KoyfVSp5tCD12wwuwPzXvjMurJGsacReOYAEdm8GwgTQ7UY8TNJGS0l+RgBYHr
	 WzcYZCR8N+Z/w==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67315ead0000>; Mon, 11 Nov 2024 14:32:29 +1300
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.22.38])
	by pat.atlnz.lc (Postfix) with ESMTP id 322DC13ECD2;
	Mon, 11 Nov 2024 14:32:29 +1300 (NZDT)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
	id 324CC2A151C; Mon, 11 Nov 2024 14:32:29 +1300 (NZDT)
From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [RFC net-next v0 1/2] net: devlink: Add port function for bridge offload
Date: Mon, 11 Nov 2024 14:32:16 +1300
Message-ID: <20241111013218.1491641-2-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111013218.1491641-1-aryan.srivastava@alliedtelesis.co.nz>
References: <20241111013218.1491641-1-aryan.srivastava@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=67315ead a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=VlfZXiiP6vEA:10 a=Rn-rybJDi6Mx2ZrNRmMA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add configurable devlink port attr for HW offloading. Most drivers (and
DSA framework) will offload a bridge port to HW if there is mechanism
available to do so. Adding a configurable devlink attr allows users to
change this default setting, in cases where HW offload of a bridge port
is not desired.

Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
---
 include/net/devlink.h        | 13 ++++++++++++
 include/uapi/linux/devlink.h |  2 ++
 net/devlink/port.c           | 41 ++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index fbb9a2668e24..64dc3e292c2c 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1613,6 +1613,15 @@ void devlink_free(struct devlink *devlink);
  *			    of event queues. Should be used by device drivers to
  *			    configure maximum number of event queues
  *			    of a function managed by the devlink port.
+ * @port_fn_bridge_offload_get: Callback used to get port function's bri=
dge
+ *				 offload capability. Should be used by device drivers
+ *				 to report the current state of offload
+ *				 capability of a function managed by the devlink
+ *				 port.
+ * @port_fn_bridge_offload_get: Callback used to set port function's bri=
dge
+ *				 offload capability. Should be used by device drivers to
+ *				 enable/disable offload capability of a
+ *				 function managed by the devlink port.
  *
  * Note: Driver should return -EOPNOTSUPP if it doesn't support
  * port function (@port_fn_*) handling for a particular port.
@@ -1668,6 +1677,10 @@ struct devlink_port_ops {
 	int (*port_fn_max_io_eqs_set)(struct devlink_port *devlink_port,
 				      u32 max_eqs,
 				      struct netlink_ext_ack *extack);
+	void (*port_fn_bridge_offload_get)(struct devlink_port *devlink_port,
+					   bool *is_enable);
+	void (*port_fn_bridge_offload_set)(struct devlink_port *devlink_port,
+					   bool enable);
 };
=20
 void devlink_port_init(struct devlink *devlink,
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 9401aa343673..e2682bc9ecb1 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -668,6 +668,7 @@ enum devlink_port_fn_attr_cap {
 	DEVLINK_PORT_FN_ATTR_CAP_MIGRATABLE_BIT,
 	DEVLINK_PORT_FN_ATTR_CAP_IPSEC_CRYPTO_BIT,
 	DEVLINK_PORT_FN_ATTR_CAP_IPSEC_PACKET_BIT,
+	DEVLINK_PORT_FN_ATTR_CAP_BRIDGE_OFFLOAD_BIT,
=20
 	/* Add new caps above */
 	__DEVLINK_PORT_FN_ATTR_CAPS_MAX,
@@ -678,6 +679,7 @@ enum devlink_port_fn_attr_cap {
 	_BITUL(DEVLINK_PORT_FN_ATTR_CAP_MIGRATABLE_BIT)
 #define DEVLINK_PORT_FN_CAP_IPSEC_CRYPTO _BITUL(DEVLINK_PORT_FN_ATTR_CAP=
_IPSEC_CRYPTO_BIT)
 #define DEVLINK_PORT_FN_CAP_IPSEC_PACKET _BITUL(DEVLINK_PORT_FN_ATTR_CAP=
_IPSEC_PACKET_BIT)
+#define DEVLINK_PORT_FN_CAP_BRIDGE_OFFLOAD _BITUL(DEVLINK_PORT_FN_ATTR_C=
AP_BRIDGE_OFFLOAD_BIT)
=20
 enum devlink_port_function_attr {
 	DEVLINK_PORT_FUNCTION_ATTR_UNSPEC,
diff --git a/net/devlink/port.c b/net/devlink/port.c
index be9158b4453c..d7f9276c3601 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -148,6 +148,21 @@ static int devlink_port_fn_ipsec_packet_fill(struct =
devlink_port *devlink_port,
 	return 0;
 }
=20
+static int devlink_port_bridge_offload_fill(struct devlink_port *devlink=
_port,
+					    struct nla_bitfield32 *caps)
+{
+	bool is_enable;
+
+	if (!devlink_port->ops->port_fn_bridge_offload_get ||
+	    devlink_port->attrs.flavour !=3D DEVLINK_PORT_FLAVOUR_PHYSICAL)
+		return 0;
+
+	devlink_port->ops->port_fn_bridge_offload_get(devlink_port, &is_enable)=
;
+
+	devlink_port_fn_cap_fill(caps, DEVLINK_PORT_FN_CAP_BRIDGE_OFFLOAD, is_e=
nable);
+	return 0;
+}
+
 static int devlink_port_fn_caps_fill(struct devlink_port *devlink_port,
 				     struct sk_buff *msg,
 				     struct netlink_ext_ack *extack,
@@ -172,6 +187,10 @@ static int devlink_port_fn_caps_fill(struct devlink_=
port *devlink_port,
 	if (err)
 		return err;
=20
+	err =3D devlink_port_bridge_offload_fill(devlink_port, &caps);
+	if (err)
+		return err;
+
 	if (!caps.selector)
 		return 0;
 	err =3D nla_put_bitfield32(msg, DEVLINK_PORT_FN_ATTR_CAPS, caps.value,
@@ -393,6 +412,12 @@ devlink_port_fn_ipsec_packet_set(struct devlink_port=
 *devlink_port, bool enable,
 	return devlink_port->ops->port_fn_ipsec_packet_set(devlink_port, enable=
, extack);
 }
=20
+static void
+devlink_port_fn_bridge_offload_set(struct devlink_port *devlink_port, bo=
ol enable)
+{
+	return devlink_port->ops->port_fn_bridge_offload_set(devlink_port, enab=
le);
+}
+
 static int devlink_port_fn_caps_set(struct devlink_port *devlink_port,
 				    const struct nlattr *attr,
 				    struct netlink_ext_ack *extack)
@@ -431,6 +456,10 @@ static int devlink_port_fn_caps_set(struct devlink_p=
ort *devlink_port,
 		if (err)
 			return err;
 	}
+	if (caps.selector & DEVLINK_PORT_FN_CAP_BRIDGE_OFFLOAD) {
+		devlink_port_fn_bridge_offload_set(devlink_port, caps_value &
+							 DEVLINK_PORT_FN_CAP_BRIDGE_OFFLOAD);
+	}
 	return 0;
 }
=20
@@ -765,6 +794,18 @@ static int devlink_port_function_validate(struct dev=
link_port *devlink_port,
 				return -EOPNOTSUPP;
 			}
 		}
+		if (caps.selector & DEVLINK_PORT_FN_CAP_BRIDGE_OFFLOAD) {
+			if (!ops->port_fn_bridge_offload_set) {
+				NL_SET_ERR_MSG_ATTR(extack, attr,
+						    "Port doesn't support bridge offload function attribute");
+				return -EOPNOTSUPP;
+			}
+			if (devlink_port->attrs.flavour !=3D DEVLINK_PORT_FLAVOUR_PHYSICAL) {
+				NL_SET_ERR_MSG_ATTR(extack, attr,
+						    "bridge offload function attribute supported for physical port=
s only");
+				return -EOPNOTSUPP;
+			}
+		}
 	}
 	if (tb[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS] &&
 	    !ops->port_fn_max_io_eqs_set) {
--=20
2.47.0


