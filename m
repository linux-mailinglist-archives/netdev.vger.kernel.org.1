Return-Path: <netdev+bounces-159666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E01A164BD
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 01:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80A5188572A
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 00:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50FE10957;
	Mon, 20 Jan 2025 00:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="KwV88P+C"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F62BAD51
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 00:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737334185; cv=none; b=Lqxrgh/DkQTrxI3fh4qIDeC3PjjWVsOw7CyjUJzJ2sMYZJi/0itFAwT9zcytEWSgTin2Ptv3VGR+LvR9R3ILlG429raSuyDo6cRszmHeCnJfcli+venpZdclxdv6zPezosgX/lNz28Pew4EkFyNxX87rTmC+8AeaTxnWmiq2EXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737334185; c=relaxed/simple;
	bh=61ItVcu3Z+mpVJ0kWGkVbw2XvWGB49Gd+pqvECLY8r4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGAUpOZGGMb6Jwn/Lwl9Agb2OY7rT9rvJB1BYuWvyhbnD4lg/Hb7dr4dchRJk/NY4VNCkuXK2dngQqf1iuMQJ9mPvh+CTow3xGpIaRqy+ExEpJpydzVBTviQPUMxFJkS+sOa78ofMdWbJOMEHE5HlHfXkMSPMJAdie0tn/5eyXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=KwV88P+C; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9AADD2C0692;
	Mon, 20 Jan 2025 13:49:42 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1737334182;
	bh=mo4Lr0O9DdbDCn6eylNMbQRpNiyEtj/zPpgjr7LMFkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KwV88P+Ck1rWKT7RP4kYJGiAIubPjUq9LbjCOdj7SBdM/JdRy51VPByHpT1zHGlDT
	 tu6S0X0PBtSCX3QbgxhVFday/868Yz/fqr+0TVPxasc7XdPwZWHD2H18RYcOjkcYpR
	 WmloKANoBeUNHZ7N+QOm3wv2raJdF9Z2O5Mm3Mn85gohwAW17/GeqE4HzV1TeSMTuL
	 HQ6QQvWLJUHK4LSWaJw0Oype3ZDrCDvrtGDT3N+pZPjFQ6SHXpAlFruUsmvUq3sJ1z
	 9s0vMb3NnBZjFu92g5iEUDPTNlBlyDxr0ANt4bCOKHd4gSrvaXtxJQq7l5Erd0zyFw
	 BYAInrS5xxe+w==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B678d9da50000>; Mon, 20 Jan 2025 13:49:41 +1300
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.22.38])
	by pat.atlnz.lc (Postfix) with ESMTP id D123D13ED5A;
	Mon, 20 Jan 2025 13:49:41 +1300 (NZDT)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
	id CEDA62A1696; Mon, 20 Jan 2025 13:49:41 +1300 (NZDT)
From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [RFC net-next v1 2/2] net: dsa: add option for bridge port HW offload
Date: Mon, 20 Jan 2025 13:49:12 +1300
Message-ID: <20250120004913.2154398-3-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250120004913.2154398-1-aryan.srivastava@alliedtelesis.co.nz>
References: <20250120004913.2154398-1-aryan.srivastava@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BNQQr0QG c=1 sm=1 tr=0 ts=678d9da6 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=VdSt8ZQiCzkA:10 a=sVghOlvp1KO_yCYPZfwA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Currently the DSA framework will HW offload any bridge port if there is
a driver available to support HW offloading. This may not always be the
preferred case. In cases where it is preferred that all traffic still
hit the CPU, do software bridging instead.

To prevent HW bridging (and potential CPU bypass), make the DSA
framework aware of the devlink port function attr, bridge_offload, and
add a matching field to the port struct. Add get/set functions to
configure the field, and use this field to condition HW config for
offloading a bridge port.

Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
---
 include/net/dsa.h |  1 +
 net/dsa/devlink.c | 27 ++++++++++++++++++++++++++-
 net/dsa/dsa.c     |  1 +
 net/dsa/port.c    |  3 ++-
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index a0a9481c52c2..9ee2d7ccfff8 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -291,6 +291,7 @@ struct dsa_port {
=20
 	struct device_node	*dn;
 	unsigned int		ageing_time;
+	bool bridge_offloading;
=20
 	struct dsa_bridge	*bridge;
 	struct devlink_port	devlink_port;
diff --git a/net/dsa/devlink.c b/net/dsa/devlink.c
index f41f9fc2194e..dc98e5311921 100644
--- a/net/dsa/devlink.c
+++ b/net/dsa/devlink.c
@@ -298,6 +298,31 @@ void dsa_devlink_region_destroy(struct devlink_regio=
n *region)
 }
 EXPORT_SYMBOL_GPL(dsa_devlink_region_destroy);
=20
+static void
+dsa_devlink_port_bridge_offload_get(struct devlink_port *dlp,
+				    bool *is_enable)
+{
+	struct dsa_port *dp =3D dsa_to_port(dsa_devlink_port_to_ds(dlp),
+					  dsa_devlink_port_to_port(dlp));
+
+	*is_enable =3D dp->bridge_offloading;
+}
+
+static void
+dsa_devlink_port_bridge_offload_set(struct devlink_port *dlp,
+				    bool enable)
+{
+	struct dsa_port *dp =3D dsa_to_port(dsa_devlink_port_to_ds(dlp),
+					  dsa_devlink_port_to_port(dlp));
+
+	dp->bridge_offloading =3D enable;
+}
+
+static const struct devlink_port_ops dsa_devlink_port_ops =3D {
+	.port_fn_bridge_offload_get =3D dsa_devlink_port_bridge_offload_get,
+	.port_fn_bridge_offload_set =3D dsa_devlink_port_bridge_offload_set,
+};
+
 int dsa_port_devlink_setup(struct dsa_port *dp)
 {
 	struct devlink_port *dlp =3D &dp->devlink_port;
@@ -341,7 +366,7 @@ int dsa_port_devlink_setup(struct dsa_port *dp)
 	}
=20
 	devlink_port_attrs_set(dlp, &attrs);
-	err =3D devlink_port_register(dl, dlp, dp->index);
+	err =3D devlink_port_register_with_ops(dl, dlp, dp->index, &dsa_devlink=
_port_ops);
 	if (err) {
 		if (ds->ops->port_teardown)
 			ds->ops->port_teardown(ds, dp->index);
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 5a7c0e565a89..20cf55bd42db 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -529,6 +529,7 @@ static int dsa_port_setup(struct dsa_port *dp)
 		return err;
 	}
=20
+	dp->bridge_offloading =3D true;
 	dp->setup =3D true;
=20
 	return 0;
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 5c9d1798e830..de176f7993d0 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -493,7 +493,8 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct =
net_device *br,
 	struct net_device *brport_dev;
 	int err;
=20
-	if (br_mst_enabled(br) && !dsa_port_supports_mst(dp))
+	if ((br_mst_enabled(br) && !dsa_port_supports_mst(dp)) ||
+	    !dp->bridge_offloading)
 		return -EOPNOTSUPP;
=20
 	/* Here the interface is already bridged. Reflect the current
--=20
2.47.1


