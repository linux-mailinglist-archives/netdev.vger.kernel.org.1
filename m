Return-Path: <netdev+bounces-259995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNH3CbYtnGkKAgQAu9opvQ
	(envelope-from <netdev+bounces-259995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:36:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A77EF174FA3
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC12F3099152
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A34E35CB61;
	Mon, 23 Feb 2026 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6OeqFXW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC34635C1A6
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842485; cv=none; b=D81uYIEzLyv/WmrSJhW/vIObr0Ce5/uGfBHU6Bh/bVeGDlRtoeqDloB9ppOpvFQYbpAhBDR9tfvBxVZlwHOfvp2gHakZqcxXNUUSh6K7X+Ce66PaLieipPVFNXhv33HJco1EhJ5X3R36/P6GVHSbkijXetERdfIj8xFI61opBk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842485; c=relaxed/simple;
	bh=BhJ48uuWboluACMnIhJ5XbzlO5XIOLObwV7qKhTfYmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P54m2gqHjtap2lYfzRgqWCEQiHgsWQj18MenJ9oqSxJlykbzESANwQtsESoMWUddrQEuWgfyp39KP4NndoGWKW/Kaw/49lkj7ZOrMuBcUL8xrTclALKrzSAUggLSzAZkXTAmZlKArpyDFv3pBQQynUgv4ER+jfQzYNq3EEhdR8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6OeqFXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49C3EC19424;
	Mon, 23 Feb 2026 10:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771842485;
	bh=BhJ48uuWboluACMnIhJ5XbzlO5XIOLObwV7qKhTfYmQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=C6OeqFXWHEcvRUBGHGBk5+6N+I5eon9ptcWUELamVJ/KMqJhdR8yH+s9Nmrmm2WSr
	 QUp4LHGK6aU7U2mPI16FP9k8nCyv1OE+J3gcoMfJ6lMQ/ZPXpXoVovrhz/eZ07q4fH
	 RSaiCab1qxejpUGtrC4UCl9+mVLqPZCEoVtRPooy0bcx1q8K1UI/Ap5gf+jjTh0D5S
	 1okv3j2cNjRKN9dEpH+BEfLGnxViZDDLmYqbLmvYbYqc+0H0Bmf8SyBG3v7QjUnkym
	 BhdlBtVN+1c6Kkq2k7Pnr757bXU7kBrbvQs0R+xm3fxU3ZQ/nhl9zuZzgdLxQycDeX
	 VJoOptfSJcg/g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3996DE98E1C;
	Mon, 23 Feb 2026 10:28:05 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Mon, 23 Feb 2026 02:27:20 -0800
Subject: [PATCH v2 1/2] net:ethernet:enic: add VIC subsystem ids
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-enic-cscwi36355-v2-1-63488194a974@cisco.com>
References: <20260223-enic-cscwi36355-v2-0-63488194a974@cisco.com>
In-Reply-To: <20260223-enic-cscwi36355-v2-0-63488194a974@cisco.com>
To: netdev@vger.kernel.org
Cc: Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771842484; l=2264;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=dmiiJ3fxTUP7u8ZrF0g2EZDSbfEDLnZtm8vLm5JCiQk=;
 b=pyfckAyhVR58o2HdR9UbUSXu2Poucs1lIYmPJxUdS2/KDEN1mey9nSbTSRF+1uPrALcUolE6/
 H//Km4jNUqvC+8I6HqBKpXElqmsFXsv+ZrXcg7xpr7sTuPTejWwx6nZ
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259995-lists,netdev=lfdr.de,satishkh.cisco.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:mid,cisco.com:email,cisco.com:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A77EF174FA3
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



