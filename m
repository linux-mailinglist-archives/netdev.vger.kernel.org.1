Return-Path: <netdev+bounces-251821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAW2DoOecGlyYgAAu9opvQ
	(envelope-from <netdev+bounces-251821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:38:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA43F5486F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9BDE8292A4
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828DF47D92D;
	Wed, 21 Jan 2026 09:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LtCcDuK7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4981D47B42C;
	Wed, 21 Jan 2026 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987423; cv=none; b=C1qvf7xPjSZPihBhX/NEyNXWQAQtFsnqHb2REtjJUKq0jAZbR+9pdVgFjp28JOv9KnFQVDOqSYlYXboDGxRe3fB+Rg1Sh9hy0ovdG2G5HR4ibfuUVDHHz4yHN9Dd41QyPSodEf+ho9JPjpqZ9IsmDN8huAVUGLKYD6PaJPsTglQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987423; c=relaxed/simple;
	bh=xNWCmW31pGZmF7lTIVjzCHLl1hqt60gUK/dvIqhGBIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8zzN4Prbj+yATyB0T+RSUH63qmOLdEjGVagBtjw9RBHHV9ssAnOnBsRrRgmIpfxVe6Y1bMlbU6dNJRRKDV1EHYonWtYZsf06V4tzrJLtHQAB6Xf0lZUwBZzIU7dUYz6wbbqMihJT9ere4VL7CzxyTYl3uQDCSKjor62Ywy+NsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LtCcDuK7; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768987421; x=1800523421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xNWCmW31pGZmF7lTIVjzCHLl1hqt60gUK/dvIqhGBIo=;
  b=LtCcDuK7a7b2sva9u5w7oVRCcJxEx0fCqr3RF/8RFhgF3yguDoHqkqda
   WzGKVnau6kXCaNIgv/viBnq8/KzRGyegCulb1NHCATQheHtxyaBDpTDlb
   PU/6w6wuesXexZaLDTUP/4sjqMAjzzot8N5un3A1ZGvwPBU+EDl+k2F2K
   XSiiyshzgYQxbjzlyXXYYnF5Wf7NtvRzxdfSkBJKJ1qUPcKKuT/AQqAAx
   oqceeCm3C9LkvQgZpAGMTS2Rxz7uHjcyT9pIY3YtyhYizo/7C6S1rSeuM
   tXQSvtZAv27Ek/k3utSuj5Y5uey6th1w2KTDUJ+C5jeBBtwJcRXiBGt28
   Q==;
X-CSE-ConnectionGUID: V6LQ2jrXQAyJ7yExUbJj/A==
X-CSE-MsgGUID: U0s324AETJetjDpFoIXXqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="57773286"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="57773286"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 01:23:40 -0800
X-CSE-ConnectionGUID: Ydd0iDNfTzmreqfJY5KpAg==
X-CSE-MsgGUID: MLLY5h18S8W26brRs1IpWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="210561009"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 21 Jan 2026 01:23:39 -0800
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] i2c: Add SMBus ARP target mode test driver
Date: Wed, 21 Jan 2026 10:23:28 +0100
Message-ID: <20260121092328.2308705-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121092328.2308705-1-heikki.krogerus@linux.intel.com>
References: <20260121092328.2308705-1-heikki.krogerus@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251821-lists,netdev=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.intel.com:mid]
X-Rspamd-Queue-Id: BA43F5486F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Backend that the hosts can enumerate by using the SMBus
Address Resolution Protocol.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/i2c/Kconfig          |   6 ++
 drivers/i2c/Makefile         |   1 +
 drivers/i2c/i2c-target-arp.c | 201 +++++++++++++++++++++++++++++++++++
 3 files changed, 208 insertions(+)
 create mode 100644 drivers/i2c/i2c-target-arp.c

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index c232054fddd6..4b97a66fc698 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -134,6 +134,12 @@ config I2C_SLAVE_TESTUNIT
 	  multi-master, SMBus Host Notify, etc. Please read
 	  Documentation/i2c/slave-testunit-backend.rst for further details.
 
+config I2C_TARGET_ARP
+	tristate "SMBus ARP target mode test driver"
+	help
+	  This backend makes Linux respond to SMBus Address Resolution Protocol
+	  commands.
+
 endif
 
 config I2C_DEBUG_CORE
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index 4fdb37b94aa4..3ea292dab065 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -19,5 +19,6 @@ obj-y				+= algos/ busses/ muxes/
 obj-$(CONFIG_I2C_STUB)		+= i2c-stub.o
 obj-$(CONFIG_I2C_SLAVE_EEPROM)	+= i2c-slave-eeprom.o
 obj-$(CONFIG_I2C_SLAVE_TESTUNIT)	+= i2c-slave-testunit.o
+obj-$(CONFIG_I2C_TARGET_ARP)	+= i2c-target-arp.o
 
 ccflags-$(CONFIG_I2C_DEBUG_CORE) := -DDEBUG
diff --git a/drivers/i2c/i2c-target-arp.c b/drivers/i2c/i2c-target-arp.c
new file mode 100644
index 000000000000..458749e4681e
--- /dev/null
+++ b/drivers/i2c/i2c-target-arp.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SMBus Address Resolution Protocol target mode test driver
+ *
+ * Copyright (C) 2026 Intel Corporation
+ */
+#include <linux/bits.h>
+#include <linux/device/devres.h>
+#include <linux/i2c.h>
+#include <linux/i2c-smbus.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/string.h>
+
+#define ARP_ADDRESS_VALID	BIT(0)
+#define ARP_ADDRESS_RESOLVED	BIT(1)
+
+#define I2C_SMBUS_HOST		0x08
+#define I2C_SMBUS_DEFAULT_ADDR	0x61
+
+#define ARP_CMD_PREPARE_TO_ARP	0x01
+#define ARP_CMD_RESET_DEVICE	0x02
+#define ARP_CMD_GET_UDID	0x03
+#define ARP_CMD_ASSIGN_ADDRESS	0x04
+
+struct get_udid_data {
+	struct i2c_arp_udid	udid;
+	u8			target_addr;
+} __packed;
+
+struct arp_target {
+	struct i2c_client target;
+	struct i2c_client *client;
+
+	int read_count;
+	int write_count;
+	unsigned char buf[24];
+
+	struct get_udid_data data;
+	unsigned char flag;
+};
+
+static u8 i2c_arp_pec(struct arp_target *arp, bool read)
+{
+	u8 addr = I2C_SMBUS_DEFAULT_ADDR << 1;
+	u8 len = sizeof(arp->data);
+	u8 pec = 0;
+
+	pec = i2c_smbus_pec(pec, &addr, 1);
+	pec = i2c_smbus_pec(pec, arp->buf, arp->write_count);
+
+	if (read) {
+		addr |= 1;
+		pec = i2c_smbus_pec(pec, &addr, 1);
+		pec = i2c_smbus_pec(pec, &len, 1);
+		pec = i2c_smbus_pec(pec, (void *)&arp->data, len);
+	}
+
+	return pec;
+}
+
+static int i2c_target_arp_cb(struct i2c_client *target, enum i2c_slave_event event, u8 *val)
+{
+	struct arp_target *arp = container_of(target, struct arp_target, target);
+
+	switch (event) {
+	case I2C_SLAVE_READ_PROCESSED:
+		if (arp->flag)
+			break;
+
+		if (arp->read_count == sizeof(arp->data))
+			*val = i2c_arp_pec(arp, 1);
+		else
+			*val = ((u8 *)&arp->data)[arp->read_count];
+
+		arp->read_count++;
+		break;
+	case I2C_SLAVE_READ_REQUESTED:
+		if (arp->flag)
+			break;
+
+		*val = sizeof(arp->data);
+		break;
+	case I2C_SLAVE_STOP:
+		switch (arp->buf[0]) {
+		case ARP_CMD_PREPARE_TO_ARP:
+			arp->flag = 0;
+			break;
+		case ARP_CMD_ASSIGN_ADDRESS:
+			/* If the UDID matches, this address is for us. */
+			if (!memcmp(&arp->buf[2], &arp->data.udid, sizeof(arp->data.udid)))
+				arp->flag = ARP_ADDRESS_VALID | ARP_ADDRESS_RESOLVED;
+			break;
+		default:
+			break;
+		}
+
+		arp->read_count = 0;
+		arp->write_count = 0;
+		break;
+	case I2C_SLAVE_WRITE_REQUESTED:
+		arp->read_count = 0;
+		arp->write_count = 0;
+		break;
+	case I2C_SLAVE_WRITE_RECEIVED:
+		arp->buf[arp->write_count] = *val;
+		arp->write_count++;
+		break;
+	}
+
+	return 0;
+}
+
+static void i2c_notify_arp_controller(struct i2c_client *client)
+{
+	union i2c_smbus_data data = { };
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
+		return;
+
+	ret = i2c_smbus_xfer(client->adapter, I2C_SMBUS_HOST, client->flags,
+			     I2C_SMBUS_WRITE, client->addr,
+			     I2C_SMBUS_WORD_DATA, &data);
+	if (ret)
+		dev_warn(&client->dev, "Failed to Notify ARP Controller (%d)\n", ret);
+}
+
+static int i2c_target_arp_probe(struct i2c_client *client)
+{
+	struct arp_target *arp;
+	int ret;
+
+	arp = devm_kzalloc(&client->dev, sizeof(*arp), GFP_KERNEL);
+	if (!arp)
+		return -ENOMEM;
+
+	arp->client = client;
+	i2c_set_clientdata(client, arp);
+
+	arp->target = *client;
+	arp->target.addr = I2C_SMBUS_DEFAULT_ADDR;
+	arp->target.flags |= I2C_CLIENT_SLAVE;
+
+	/*
+	 * The vendor and device ID are left undefined. Some hosts may not
+	 * support this. If that's the case, supply values for them.
+	 *
+	 * arp->data.udid.vendor = 0xXXXX;
+	 * arp->data.udid.device = 0xXXXX;
+	 *
+	 * The capabilities are also 0. That makes this a fixed address device
+	 * without support for PEC.
+	 */
+	arp->data.udid.version = BIT(3); /* UDID Version 1 */
+	arp->data.udid.interface = SMBUS_INTERFACE_SMBUS_V2_0;
+	arp->data.target_addr = client->addr;
+
+	/*
+	 * NOTE: This target is only for the ARP. After the address has been
+	 * assigned, another target should be registered for the actual device,
+	 * but this test code does _not_ register it.
+	 */
+	ret = i2c_slave_register(&arp->target, i2c_target_arp_cb);
+	if (ret)
+		return ret;
+
+	i2c_notify_arp_controller(client);
+
+	return 0;
+}
+
+static void i2c_target_arp_remove(struct i2c_client *client)
+{
+	struct arp_target *arp;
+
+	if (IS_ERR_OR_NULL(client))
+		return;
+
+	arp = i2c_get_clientdata(client);
+	i2c_slave_unregister(&arp->target);
+}
+
+static const struct i2c_device_id i2c_target_arp_id[] = {
+	{ "target-arp" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, i2c_target_arp_id);
+
+static struct i2c_driver i2c_target_arp_driver = {
+	.driver = {
+		.name = "i2c-target-arp",
+	},
+	.probe = i2c_target_arp_probe,
+	.remove = i2c_target_arp_remove,
+	.id_table = i2c_target_arp_id,
+};
+module_i2c_driver(i2c_target_arp_driver);
+
+MODULE_DESCRIPTION("SMBus ARP target mode test driver");
+MODULE_LICENSE("GPL");
-- 
2.50.1


