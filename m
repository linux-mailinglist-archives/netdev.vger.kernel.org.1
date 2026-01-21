Return-Path: <netdev+bounces-251935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCzgI270cGmgbAAAu9opvQ
	(envelope-from <netdev+bounces-251935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:44:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 338CA59679
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 075AA744A2B
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297A84BC029;
	Wed, 21 Jan 2026 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="P+wPNkDh"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D12A449ED0;
	Wed, 21 Jan 2026 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006077; cv=none; b=D/ikCnJxrO4n5sJRE2QB0mAxCpthpa9t4IVnLJdHHSg1TI6grs//Dt4SGJhWFu3rAy0PLKGNQF94nl633IorrPgUYcJnabNaVkSbqlWu8u5PZEZNtGTZ2elirt/1y0MUIL6vsjWlEAFlNuy1qbujEpr/k0UTKI3Q7comy6hhrOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006077; c=relaxed/simple;
	bh=V+qFlUU26dtxhI42O1LyyPXxUUYrP0KuA+/fr8CCTWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fFbkZUKoBHlrfVtQVVPnDNfHvU5v1q+ziOGhvVOzQ6jONx4nc7XB4z4H/UR9lLONfw8Ka0tnHclBIArx8DdzM9x5+hr9tmDlDn3584ffM4nW8yBT7tNySk3XNxGYZjqmmDof3UTGFK+Ru6D4o46fHzBL5ozfzuqv+d/aGsha9Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=P+wPNkDh; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769006074; x=1800542074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GnB0Zjrn1rkk2yBuHfgwsZRUTblWJqAEa2P5e7SgUS8=;
  b=P+wPNkDh/jpDeVbAm/57wdJv6KeFS1owp8F5uQpRRtq9Iq/td6A728Ry
   CsFzQlLGsluSbdnxLRsbr1S+f75m/5lqQM73w/nyMvTeXmih8y6JV1KvP
   Dy8KXqUWc+wK3TI6CmehDRGob32T/K4olsx/SedsHgM6v4aSJV1J2aDtk
   7T1kBHLZHUv+WKKo4Whu+ARk0RXd+WhJixId/5uGj+/s+HfD+yRjHa1JF
   xCtCDaZ6soSWkw096L5ig+FCo4Hrxou+JbqyT2HgDEauVxbbh+pul64BY
   IJ7/jrKH9qvBi+AwxdYv/HmM5zqHI35sIe+YHKQcROQmb45QWnFmwl/b/
   w==;
X-CSE-ConnectionGUID: C4fGUt72Qdixu8U/aQwc9g==
X-CSE-MsgGUID: Cu5NmpH2RCqP8y3vkUNV9g==
X-IronPort-AV: E=Sophos;i="6.21,242,1763424000"; 
   d="scan'208";a="11311079"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 14:34:32 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:6551]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.220:2525] with esmtp (Farcaster)
 id 78ead78d-5660-4e66-8e07-c138e99f30b6; Wed, 21 Jan 2026 14:34:32 +0000 (UTC)
X-Farcaster-Flow-ID: 78ead78d-5660-4e66-8e07-c138e99f30b6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 21 Jan 2026 14:34:31 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 21 Jan 2026 14:34:28 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<richardcochran@gmail.com>, <dwmw2@infradead.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Babis Chalios <mail@bchalios.io>, "Alexander
 Graf" <graf@amazon.de>, <mzxreary@0pointer.de>, Marco Cali
	<xmarcalx@amazon.co.uk>, David Woodhouse <dwmw@amazon.co.uk>, "Takahiro
 Itazuri" <itazur@amazon.co.uk>
Subject: [PATCH v6 3/7] dt-bindings: ptp: Add amazon,vmclock
Date: Wed, 21 Jan 2026 14:33:40 +0000
Message-ID: <20260121143402.3092-4-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260121143402.3092-1-itazur@amazon.com>
References: <20260121143402.3092-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-5.96 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251935-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,infradead.org,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_NEQ_ENVFROM(0.00)[itazur@amazon.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[amazon.com,quarantine];
	DKIM_TRACE(0.00)[amazon.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,devicetree.org:url,amazon.es:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,amazon.co.uk:email,4.196.180.0:email];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 338CA59679
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Woodhouse <dwmw@amazon.co.uk>

The vmclock device provides a PTP clock source and precise timekeeping
across live migration and snapshot/restore operations.

The binding has a required memory region containing the vmclock_abi
structure and an optional interrupt for clock disruption notifications.

The full spec is at https://uapi-group.org/specifications/specs/vmclock/

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Babis Chalios <bchalios@amazon.es>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/ptp/amazon,vmclock.yaml          | 46 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ptp/amazon,vmclock.yaml

diff --git a/Documentation/devicetree/bindings/ptp/amazon,vmclock.yaml b/Documentation/devicetree/bindings/ptp/amazon,vmclock.yaml
new file mode 100644
index 000000000000..357790df876f
--- /dev/null
+++ b/Documentation/devicetree/bindings/ptp/amazon,vmclock.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ptp/amazon,vmclock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtual Machine Clock
+
+maintainers:
+  - David Woodhouse <dwmw2@infradead.org>
+
+description:
+  The vmclock device provides a precise clock source and allows for
+  accurate timekeeping across live migration and snapshot/restore
+  operations. The full specification of the shared data structure is
+  available at https://uapi-group.org/specifications/specs/vmclock/
+
+properties:
+  compatible:
+    const: amazon,vmclock
+
+  reg:
+    description:
+      Specifies the shared memory region containing the vmclock_abi structure.
+    maxItems: 1
+
+  interrupts:
+    description:
+      Interrupt used to notify when the contents of the vmclock_abi structure
+      have been updated.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    ptp@80000000 {
+      compatible = "amazon,vmclock";
+      reg = <0x80000000 0x1000>;
+      interrupts = <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index da9dbc1a4019..0dd35070fe9b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21025,6 +21025,7 @@ PTP VMCLOCK SUPPORT
 M:	David Woodhouse <dwmw2@infradead.org>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/ptp/amazon,vmclock.yaml
 F:	drivers/ptp/ptp_vmclock.c
 F:	include/uapi/linux/vmclock-abi.h
 
-- 
2.47.3


