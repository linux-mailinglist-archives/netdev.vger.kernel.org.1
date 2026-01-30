Return-Path: <netdev+bounces-255205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCnDMsfsfGnEPQIAu9opvQ
	(envelope-from <netdev+bounces-255205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:39:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 483E5BD5AE
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45908305D626
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 17:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA5237F728;
	Fri, 30 Jan 2026 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="MIDdEcBo"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A9737F72F;
	Fri, 30 Jan 2026 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794653; cv=none; b=c8DSWIturC7cXbd4nlFAI85fbew4IsPYFTAPs5dG7+eeL6JScn0jeF+ewgYvWAtJRRJKcvDmAn4Dac2vDQCrUyA7Fbtqt98Pm1E62iuGV9I47eKn9R/YzSgaknkdwtWkbOp0Gv4Ap/nM0IdpKhd5rZEDqWXTCMhxWuT4xQ8jeJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794653; c=relaxed/simple;
	bh=9Cm5DNZkq/Hgwzh/+IlRF0qOER2Rk8tXyZwzLLKv5+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJgIQIQKyTVZ9EaiIX3Io10UqGJYqjKeZQi20YtUmsfneM+9vSQhBxH9fBXfajM29H4MAEh4OvhTJRyjPvKW45EaoUUwXNWNn1ZBa4f/CLPKqlvSZOZGt0/VAwU6247O0QRHM2kA4ewS63jFEGe6i+iHkQM6BKVz+cqZOLeGzO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=MIDdEcBo; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769794651; x=1801330651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PQNMcCbACGtxtiD5RQHIFZIrQp3M1GtcZTN/Ac/UvXg=;
  b=MIDdEcBo6jdJT76e3QsiYdBDHObhsVdNcF8U2XslAyb3OYTpPM7smK7t
   JFPlvEUMR2odKKaMEN1VrganVtIrLBHbqZ+UaA2RJXo+RZtcRVLHGyjSl
   KkAzwBNy/2xuEYbAAAcAlvOPuWN2Vdo3+5eqMZuyUcmc9+CvZuQvSVd0Q
   6tAfUavFz46lUERwQrq7IHCK+gabQRRsfwtjq+/ADWO3s12h7YfA1sBWy
   p/2M3Gu4XRzdNh4hClOTGyQlZ9zt5G4TmdHmabg5Y9pKxn+76ipZQFwl1
   PC9YuMvi3p2RB3s4ADh4bUHnl97toeEXUuzcabZ0d4ONpytl2qk1bS8TN
   w==;
X-CSE-ConnectionGUID: pJbuojeBSc2hceduTda92Q==
X-CSE-MsgGUID: Tu16s7ifSwumyFqID0J4Hg==
X-IronPort-AV: E=Sophos;i="6.21,263,1763424000"; 
   d="scan'208";a="11938887"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 17:37:31 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:26086]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.174:2525] with esmtp (Farcaster)
 id 938ed664-37c9-4d78-8796-a787e8c1e99a; Fri, 30 Jan 2026 17:37:31 +0000 (UTC)
X-Farcaster-Flow-ID: 938ed664-37c9-4d78-8796-a787e8c1e99a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 30 Jan 2026 17:37:30 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 30 Jan 2026 17:37:27 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Babis Chalios <mail@bchalios.io>, "Alexander
 Graf" <graf@amazon.de>, <mzxreary@0pointer.de>, Marco Cali
	<xmarcalx@amazon.co.uk>, David Woodhouse <dwmw@amazon.co.uk>, "Takahiro
 Itazuri" <itazur@amazon.com>
Subject: [PATCH v7 3/7] dt-bindings: ptp: Add amazon,vmclock
Date: Fri, 30 Jan 2026 17:36:02 +0000
Message-ID: <20260130173704.12575-4-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260130173704.12575-1-itazur@amazon.com>
References: <20260130173704.12575-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA002.ant.amazon.com (10.13.139.17) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-255205-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[itazur@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amazon.es:email,qualcomm.com:email,4.196.180.0:email,amazon.co.uk:email,uapi-group.org:url];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 483E5BD5AE
X-Rspamd-Action: no action

From: David Woodhouse <dwmw@amazon.co.uk>

The vmclock device provides a PTP clock source and precise timekeeping
across live migration and snapshot/restore operations.

The binding has a required memory region containing the vmclock_abi
structure and an optional interrupt for clock disruption notifications.

The full spec is at https://uapi-group.org/specifications/specs/vmclock/

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Babis Chalios <bchalios@amazon.es>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Tested-by: Takahiro Itazuri <itazur@amazon.com>
---
 .../bindings/ptp/amazon,vmclock.yaml          | 46 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ptp/amazon,vmclock.yaml

diff --git a/Documentation/devicetree/bindings/ptp/amazon,vmclock.yaml b/Documentation/devicetree/bindings/ptp/amazon,vmclock.yaml
new file mode 100644
index 000000000..357790df8
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
index e8f06145f..171813ea7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20728,6 +20728,7 @@ PTP VMCLOCK SUPPORT
 M:	David Woodhouse <dwmw2@infradead.org>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/ptp/amazon,vmclock.yaml
 F:	drivers/ptp/ptp_vmclock.c
 F:	include/uapi/linux/vmclock-abi.h
 
-- 
2.50.1


