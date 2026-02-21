Return-Path: <netdev+bounces-259832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IxRtIer2mWl/XgMAu9opvQ
	(envelope-from <netdev+bounces-259832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 19:18:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E44E616D797
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 19:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5528A302C351
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 18:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B865309EFF;
	Sat, 21 Feb 2026 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFYmr/V0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E262DCF74;
	Sat, 21 Feb 2026 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771697894; cv=none; b=iSRr21mzFIcHRVl4ijWh3C8wvg+rkKZwwVaM3dYJlhy2k9Ev2rWib8sT+w0j1jP4f8fMtojQJkYqQpqgFVtmuQ5KK8d+7v+rALRO7wKKp+iMmlScKvcnCO996sZLbLA4clpAzxyGTPBrqbr8LhPNwi4hxBF/9a4EDCtrJgbDWoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771697894; c=relaxed/simple;
	bh=BhJ48uuWboluACMnIhJ5XbzlO5XIOLObwV7qKhTfYmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GLTobwy8OGez0LT/kbhw5BIWRl3Wt9mGso5rZemBC7ME24/USSKXbmPD3NOKLTi4tKvlmmvEIUXRIrQevQlA5jbLFC3ZfcStX8FKwFlKqr2nNfYMBp8DYfqsegrVApmPwgCwky6OWXBibX88IQ/mLB+KBcgrJGg0eGliP/JosNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFYmr/V0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23E89C19424;
	Sat, 21 Feb 2026 18:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771697894;
	bh=BhJ48uuWboluACMnIhJ5XbzlO5XIOLObwV7qKhTfYmQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vFYmr/V05rqQHarjB9dzVBC8yPc/eX0kL7c7amQ2xLLeQppwGnzTvs6N0DjEPiiHM
	 oJooI0UwJKy96ZVtoIzIRXs0cUXZlg5ZkYYujrRlkF60KbO2Rem5KpGkufBuWxMmIn
	 4g1PLZbfNntf7rcvG+Ocw+hcPCMpdwSs915ULnsDof894btPa6Dh4XOzXahfj67EcK
	 /ZiAhXwj+txmWG+saAMMt3vbTSaLXl6lDKRNv2Piu7UDh8Zc03c+MxhV+gMC+cqZYe
	 NqRbbqWBX3E78mb6sVz1yl1L/MFyUNRzMOGAnARDFxjXzs/j6Uz3CKSFvu2HtL7GeW
	 5IagsUgsPvxog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1263CC61DFD;
	Sat, 21 Feb 2026 18:18:14 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Sat, 21 Feb 2026 10:16:59 -0800
Subject: [PATCH 1/2] net:ethernet:enic: add VIC subsystem ids
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260221-enic-cscwi36355-v1-1-5a01a6046d5e@cisco.com>
References: <20260221-enic-cscwi36355-v1-0-5a01a6046d5e@cisco.com>
In-Reply-To: <20260221-enic-cscwi36355-v1-0-5a01a6046d5e@cisco.com>
To: netdev@vger.kernel.org
Cc: Satish Kharat <satishkh@cisco.com>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771697893; l=2264;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=dmiiJ3fxTUP7u8ZrF0g2EZDSbfEDLnZtm8vLm5JCiQk=;
 b=4pUmsOqoXDGWoNIcqlH72YM9e9kxNZnNw+dF4HQ/XWKUcMDbKAbOrWEqIxXxUaKgKPEfG1EyP
 LGcEFrQTIFnB0LNvqqSy+qp6JQn6Y+NfcTqppJqYEAuBlGLnEkC4gsT
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259832-lists,netdev=lfdr.de,satishkh.cisco.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E44E616D797
X-Rspamd-Action: no action

From: Satish Kharat <satishkh@cisco.com>

Add VIC subsystem id for 12xx, 13xx, 14xx and 15xxx series

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h | 39 ++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 301b3f311..6959e85ab 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -22,6 +22,45 @@
 #define DRV_NAME		"enic"
 #define DRV_DESCRIPTION		"Cisco VIC Ethernet NIC Driver"
 
+#define PCI_SUBDEV_ID_CISCO_VIC_1225	0x085
+#define PCI_SUBDEV_ID_CISCO_VIC_1225T	0x0CE
+#define PCI_SUBDEV_ID_CISCO_VIC_1227	0x12E
+#define PCI_SUBDEV_ID_CISCO_VIC_1227T	0x139
+#define PCI_SUBDEV_ID_CISCO_VIC_1240	0x084
+#define PCI_SUBDEV_ID_CISCO_VIC_1280	0x04F
+#define PCI_SUBDEV_ID_CISCO_VIC_1285	0x0CD
+
+#define PCI_SUBDEV_ID_CISCO_VIC_1340	0x12C
+#define PCI_SUBDEV_ID_CISCO_VIC_1380	0x137
+#define PCI_SUBDEV_ID_CISCO_VIC_1385	0x14D
+#define PCI_SUBDEV_ID_CISCO_VIC_1387	0x15D
+
+#define PCI_SUBDEV_ID_CISCO_VIC_1440	0x0215
+#define PCI_SUBDEV_ID_CISCO_VIC_1455	0x0217
+#define PCI_SUBDEV_ID_CISCO_VIC_1457	0x0218
+#define PCI_SUBDEV_ID_CISCO_VIC_1467	0x02AF
+#define PCI_SUBDEV_ID_CISCO_VIC_1477	0x2B0
+#define PCI_SUBDEV_ID_CISCO_VIC_1480	0x0216
+#define PCI_SUBDEV_ID_CISCO_VIC_1485	0x0219
+#define PCI_SUBDEV_ID_CISCO_VIC_1487	0x021A
+#define PCI_SUBDEV_ID_CISCO_VIC_1495	0x024A
+#define PCI_SUBDEV_ID_CISCO_VIC_1497	0x024B
+#define PCI_SUBDEV_ID_CISCO_VIC_14425	0x02CF
+#define PCI_SUBDEV_ID_CISCO_VIC_14825	0x02D0
+
+#define PCI_SUBDEV_ID_CISCO_VIC_15230	0x02DF
+#define PCI_SUBDEV_ID_CISCO_VIC_15231	0x02DB
+#define PCI_SUBDEV_ID_CISCO_VIC_15235	0x02E4
+#define PCI_SUBDEV_ID_CISCO_VIC_15237	0x02F3
+#define PCI_SUBDEV_ID_CISCO_VIC_15238	0x02E8
+#define PCI_SUBDEV_ID_CISCO_VIC_15411	0x02DC
+#define PCI_SUBDEV_ID_CISCO_VIC_15412	0x02E2
+#define PCI_SUBDEV_ID_CISCO_VIC_15420	0x02DE
+#define PCI_SUBDEV_ID_CISCO_VIC_15422	0x02E1
+#define PCI_SUBDEV_ID_CISCO_VIC_15425	0x02F2
+#define PCI_SUBDEV_ID_CISCO_VIC_15427	0x02E0
+#define PCI_SUBDEV_ID_CISCO_VIC_15428	0x02DD
+
 #define ENIC_BARS_MAX		6
 
 #define ENIC_WQ_MAX		256

-- 
2.43.0



