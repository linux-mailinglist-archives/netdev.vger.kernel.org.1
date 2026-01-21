Return-Path: <netdev+bounces-251938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONm1C8P1cGmgbAAAu9opvQ
	(envelope-from <netdev+bounces-251938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:50:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7A55979E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DC23A2CF25
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBF04BCADA;
	Wed, 21 Jan 2026 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="pSBbPTQp"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2E14BCAD5;
	Wed, 21 Jan 2026 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006097; cv=none; b=bqtcMWYgZm5Z0nR2Rc+CbGCvTb6HHdD4H2dB8iIEAMvUdJzY86glbOpNhKz73FtyXUqAtPL3beH6vrHKoA4MEE5hPMSgq/lj9E92BdBDjiwhl71RfX5GwihnTaEY9NF+QnXCJz830OrPdYN8tj5MNWwUpVC1gTiZu8/9F2986n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006097; c=relaxed/simple;
	bh=zvY9YEG+wOzSsIgZFouqI4EOQZ2ONGmU/Ic/rZTtxy4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ydy/jLeJ01U08fK5R74d8x6lNU0oC9HVSSmYrvstRntaXO/dKYErJ3daHl8BSLlljGmxlTTxJxwHKebHwFo5S0Vwuhzo2uUwPLr7Mv2d4twsBiXGjzoQK6k4YL0Rkx8ND9qFT32HG/JYcyK7+G50vqEEa9u5ghFmAYfQTUNwHJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=pSBbPTQp; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769006096; x=1800542096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tnl6MqmXsFXKs7o7pIswHuCAMSMn0lU/0P5sxp57FXE=;
  b=pSBbPTQppXTfXcjlolhZu+vSL/cPMNe52lc+Vca8x6k2zycksfZd+kc5
   +XLn1eVyDjdFA//oQSH+67ZlmQQYFpeYZrMrFHkgyURp01foscO/Zj4Fo
   ff3pJJWWqtmF78RJ/9AkakACHvYRdNdVE8Xd7/8vBui/24Z1R7VHHmsj6
   n+AQIX7fZMyyIoRn1GUe09UMQbPRGawU2eqQtbB1ls4XH9z6j94QEisOk
   yqyUhUDsdAGWAIXn8pJNgWp5Fj9sM31I1TsxWBv0hOQojs3opPuAmuXdx
   Jbp5j7cguL3o6BNqA5SjdH2c5s01YQOBEPT/E+mUw4TU6nwhhkhePBRnU
   g==;
X-CSE-ConnectionGUID: muGqYszjRRueXSRfH2RDHw==
X-CSE-MsgGUID: RvVEGyqhSSCT3oMZS3n8eA==
X-IronPort-AV: E=Sophos;i="6.21,242,1763424000"; 
   d="scan'208";a="11186516"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 14:34:53 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:25276]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.221:2525] with esmtp (Farcaster)
 id eb4cb863-62b9-4ba4-84ae-0280611100c6; Wed, 21 Jan 2026 14:34:53 +0000 (UTC)
X-Farcaster-Flow-ID: eb4cb863-62b9-4ba4-84ae-0280611100c6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 21 Jan 2026 14:34:53 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 21 Jan 2026 14:34:50 +0000
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
Subject: [PATCH v6 6/7] ptp: ptp_vmclock: remove dependency on CONFIG_ACPI
Date: Wed, 21 Jan 2026 14:33:43 +0000
Message-ID: <20260121143402.3092-7-itazur@amazon.com>
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
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
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
	TAGGED_FROM(0.00)[bounces-251938-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,amazon.es:email,amazon.co.uk:email];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CA7A55979E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Woodhouse <dwmw@amazon.co.uk>

Now that we added device tree support we can remove dependency on
CONFIG_ACPI.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Babis Chalios <bchalios@amazon.es>
---
 drivers/ptp/Kconfig       |  2 +-
 drivers/ptp/ptp_vmclock.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index 5f8ea34d11d6..b93640ca08b7 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -134,7 +134,7 @@ config PTP_1588_CLOCK_KVM
 config PTP_1588_CLOCK_VMCLOCK
 	tristate "Virtual machine PTP clock"
 	depends on X86_TSC || ARM_ARCH_TIMER
-	depends on PTP_1588_CLOCK && ACPI && ARCH_SUPPORTS_INT128
+	depends on PTP_1588_CLOCK && ARCH_SUPPORTS_INT128
 	default PTP_1588_CLOCK_KVM
 	help
 	  This driver adds support for using a virtual precision clock
diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index b5e264264051..55ec3cda3995 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -501,6 +501,7 @@ static void vmclock_remove(void *data)
 		misc_deregister(&st->miscdev);
 }
 
+#if IS_ENABLED(CONFIG_ACPI)
 static acpi_status vmclock_acpi_resources(struct acpi_resource *ares, void *data)
 {
 	struct vmclock_state *st = data;
@@ -584,6 +585,7 @@ static int vmclock_probe_acpi(struct device *dev, struct vmclock_state *st)
 
 	return 0;
 }
+#endif /* CONFIG_ACPI */
 
 static irqreturn_t vmclock_of_irq_handler(int __always_unused irq, void *_st)
 {
@@ -627,11 +629,11 @@ static int vmclock_setup_notification(struct device *dev,
 	if (!(le64_to_cpu(st->clk->flags) & VMCLOCK_FLAG_NOTIFICATION_PRESENT))
 		return 0;
 
-	if (has_acpi_companion(dev)) {
+#if IS_ENABLED(CONFIG_ACPI)
+	if (has_acpi_companion(dev))
 		return vmclock_setup_acpi_notification(dev);
-	} else {
-		return vmclock_setup_of_notification(dev);
-	}
+#endif
+	return vmclock_setup_of_notification(dev);
 }
 
 static void vmclock_put_idx(void *data)
@@ -651,9 +653,11 @@ static int vmclock_probe(struct platform_device *pdev)
 	if (!st)
 		return -ENOMEM;
 
+#if IS_ENABLED(CONFIG_ACPI)
 	if (has_acpi_companion(dev))
 		ret = vmclock_probe_acpi(dev, st);
 	else
+#endif
 		ret = vmclock_probe_dt(dev, st);
 
 	if (ret) {
-- 
2.47.3


