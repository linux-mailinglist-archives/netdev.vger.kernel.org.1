Return-Path: <netdev+bounces-289038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMJUGM4GC2rt/QQAu9opvQ
	(envelope-from <netdev+bounces-289038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:32:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F6356CB4D
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B9503047AED
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1022A410D38;
	Mon, 18 May 2026 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="V7msvNaN"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70768405861;
	Mon, 18 May 2026 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107225; cv=none; b=Gwq/3afxH2/NFaGgFJMKQvomLoEzva4+LV1pISeXk25Mi0v3/SMR+/t6Z8C+my19c1pZhtK1mgvD8SyD7lzFklxWH6+LPWC/lMVxnP7jwK2XNSn2kqYlnyisjpdMNqRd4/F2eCHYc+X6MQbg9RrvRmFU4gCcuUqzjmrSfExpEgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107225; c=relaxed/simple;
	bh=iRAdE7ESmRMOn16/VUkQGGl1EydyVvlUj0/+lawNEeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LKxDhyTbMvZEdrywNSawffeWLIb/tpCutvFjx3TDiDochFeHk/rtlo0F7NzLbeUgJpGvbR15dnOEuzCmMJqOU8FuzX8csBksklrgrit36ByTmrPozCGK/RR7UvkUmhHa8Fo/TAKrXDOVzRksGufJjIomsv4Si03s97AN7NoAYKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=V7msvNaN; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1779107223; x=1810643223;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=iRAdE7ESmRMOn16/VUkQGGl1EydyVvlUj0/+lawNEeE=;
  b=V7msvNaNhDSAaNqVvqAuCSciN2LxzGpDtq4XYJ6aFi0QCGk+ODv0AYhR
   5/T/YpqLnWO4t172Xzdl4rzr3IJ50RX0LOQHCvLMj+g7UsWK6iy/Z9D9w
   L4Usb+FPZ3ZyI8bQDBpbOAuwL5gnRC+Te6olxIIve9EMA/x8Q+sxM/LCA
   MGthHzEaAFwMlykPYnizW680NKQseVS4zpTYWXY5/s2Y1N1FwMCRgRVKc
   0vS+pDcXqeWtPUNXlpkbd97aO0LezJMWsNXqIeJNw6ZWMmatWoaRTF59l
   FTT0N7GShKeCL1v8UUc4mQI5fG99iKCHbusMpAXkkNyLzlTYgTgwK3yz9
   Q==;
X-CSE-ConnectionGUID: Or1WqUuFRaiqf7jsXgMrjg==
X-CSE-MsgGUID: oY5WqQJUQBy0zd7XCUGdtA==
X-IronPort-AV: E=Sophos;i="6.23,241,1770620400"; 
   d="scan'208";a="66412997"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 May 2026 05:27:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 18 May 2026 05:27:01 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 18 May 2026 05:26:58 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Mon, 18 May 2026 14:25:02 +0200
Subject: [PATCH net-next v5 7/9] net: dsa: lan9645x: add mac table
 integration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260518-dsa_lan9645x_switch_driver_base-v5-7-968fbf34ffa3@microchip.com>
References: <20260518-dsa_lan9645x_switch_driver_base-v5-0-968fbf34ffa3@microchip.com>
In-Reply-To: <20260518-dsa_lan9645x_switch_driver_base-v5-0-968fbf34ffa3@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, Russell King
	<linux@armlinux.org.uk>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev
X-Rspamd-Queue-Id: F2F6356CB4D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289038-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Add MAC table support, and dsa fdb callback integration. The mactable is
keyed on (vid,mac) and each bucket has 4 slots. A mac table entry
typically points to a PGID index, the first 9 of which represent a front
port.

Mac table entries for L2 multicast will use a PGID containing a group
port mask. For IP multicast entries in the mac table a trick us used,
where the group port mask is packed into the MAC data, exploiting the
fact that the top bits are fixed, and that the number of switch ports is
small enough to fit in the redundant bits.

Therefore, we can avoid using sparse PGID resources for IP multicast
entries in the mac table.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
Changes in v5:
- lan9645x_mac_init returns error on table init timeout
- add comment about skipping LOCKED entries on fdb dump

Changes in v4:
- remove mac_entries list and just do direct IO to mac table from
  fdb_add/fdb_del

Changes in v3:
- avoid mac add/del dealloc when mac table writes fail
- add mact_lock to change ageing time
- dealloc all mac_entries on deinit
- dsa_dump returns mac table timeout error

Changes in v2:
- use a single lock for hw and sw
- remove unused row struct field and define
- remove list element INIT_LIST_HEAD
- consistent use of err vs ret
- remove mutex_lock in init
- use empty initializer { 0 } -> {}
- do not move fwd_domain_lock init to this unit
- add newline to dev_* log statements
---
 drivers/net/dsa/microchip/lan9645x/Makefile        |   1 +
 drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c  | 292 +++++++++++++++++++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.c |  87 +++++-
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.h |  27 ++
 4 files changed, 406 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/lan9645x/Makefile b/drivers/net/dsa/microchip/lan9645x/Makefile
index e049114b3563..70815edca5b9 100644
--- a/drivers/net/dsa/microchip/lan9645x/Makefile
+++ b/drivers/net/dsa/microchip/lan9645x/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_NET_DSA_MICROCHIP_LAN9645X) += mchp-lan9645x.o
 
 mchp-lan9645x-objs := \
+	lan9645x_mac.o \
 	lan9645x_main.o \
 	lan9645x_npi.o \
 	lan9645x_phylink.o \
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c
new file mode 100644
index 000000000000..1079e49f6271
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2026 Microchip Technology Inc.
+ */
+
+#include "lan9645x_main.h"
+
+#define CMD_IDLE		0
+#define CMD_LEARN		1
+#define CMD_FORGET		2
+#define CMD_AGE			3
+#define CMD_GET_NEXT		4
+#define CMD_INIT		5
+#define CMD_READ		6
+#define CMD_WRITE		7
+#define CMD_SYNC_GET_NEXT	8
+
+static int lan9645x_mac_wait_for_completion(struct lan9645x *lan9645x,
+					    u32 *maca)
+{
+	u32 val = 0;
+	int err;
+
+	lockdep_assert_held(&lan9645x->mact_lock);
+
+	err = lan9645x_rd_poll_timeout(lan9645x, ANA_MACACCESS, val,
+				       ANA_MACACCESS_MAC_TABLE_CMD_GET(val) ==
+				       CMD_IDLE);
+	if (err)
+		return err;
+
+	if (maca)
+		*maca = val;
+
+	return 0;
+}
+
+static void lan9645x_mac_select(struct lan9645x *lan9645x,
+				const unsigned char *addr, u16 vid)
+{
+	u64 maddr = ether_addr_to_u64(addr);
+
+	lockdep_assert_held(&lan9645x->mact_lock);
+
+	lan_wr(ANA_MACHDATA_VID_SET(vid) |
+	       ANA_MACHDATA_MACHDATA_SET(maddr >> 32),
+	       lan9645x,
+	       ANA_MACHDATA);
+
+	lan_wr(maddr & GENMASK(31, 0),
+	       lan9645x,
+	       ANA_MACLDATA);
+}
+
+static int __lan9645x_mact_forget(struct lan9645x *lan9645x,
+				  const unsigned char mac[ETH_ALEN],
+				  unsigned int vid,
+				  enum macaccess_entry_type type)
+{
+	lockdep_assert_held(&lan9645x->mact_lock);
+
+	lan9645x_mac_select(lan9645x, mac, vid);
+
+	lan_wr(ANA_MACACCESS_ENTRYTYPE_SET(type) |
+	       ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_FORGET),
+	       lan9645x,
+	       ANA_MACACCESS);
+
+	return lan9645x_mac_wait_for_completion(lan9645x, NULL);
+}
+
+int lan9645x_mact_forget(struct lan9645x *lan9645x,
+			 const unsigned char mac[ETH_ALEN], unsigned int vid,
+			 enum macaccess_entry_type type)
+{
+	int err;
+
+	mutex_lock(&lan9645x->mact_lock);
+	err = __lan9645x_mact_forget(lan9645x, mac, vid, type);
+	mutex_unlock(&lan9645x->mact_lock);
+
+	return err;
+}
+
+static bool lan9645x_mac_ports_use_cpu(const unsigned char *mac,
+				       enum macaccess_entry_type type)
+{
+	u32 mc_ports;
+
+	switch (type) {
+	case ENTRYTYPE_MACV4:
+		mc_ports = (mac[1] << 8) | mac[2];
+		break;
+	case ENTRYTYPE_MACV6:
+		mc_ports = (mac[0] << 8) | mac[1];
+		break;
+	default:
+		return false;
+	}
+
+	return !!(mc_ports & BIT(CPU_PORT));
+}
+
+static int __lan9645x_mact_learn_cpu_copy(struct lan9645x *lan9645x, int port,
+					  const unsigned char *addr, u16 vid,
+					  enum macaccess_entry_type type,
+					  bool cpu_copy)
+{
+	lockdep_assert_held(&lan9645x->mact_lock);
+
+	lan9645x_mac_select(lan9645x, addr, vid);
+
+	lan_wr(ANA_MACACCESS_VALID_SET(1) |
+	       ANA_MACACCESS_DEST_IDX_SET(port) |
+	       ANA_MACACCESS_MAC_CPU_COPY_SET(cpu_copy) |
+	       ANA_MACACCESS_ENTRYTYPE_SET(type) |
+	       ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_LEARN),
+	       lan9645x, ANA_MACACCESS);
+
+	return lan9645x_mac_wait_for_completion(lan9645x, NULL);
+}
+
+static int __lan9645x_mact_learn(struct lan9645x *lan9645x, int port,
+				 const unsigned char *addr, u16 vid,
+				 enum macaccess_entry_type type)
+{
+	bool cpu_copy = lan9645x_mac_ports_use_cpu(addr, type);
+
+	return __lan9645x_mact_learn_cpu_copy(lan9645x, port, addr, vid, type,
+					      cpu_copy);
+}
+
+int lan9645x_mact_learn(struct lan9645x *lan9645x, int port,
+			const unsigned char *addr, u16 vid,
+			enum macaccess_entry_type type)
+{
+	int err;
+
+	mutex_lock(&lan9645x->mact_lock);
+	err = __lan9645x_mact_learn(lan9645x, port, addr, vid, type);
+	mutex_unlock(&lan9645x->mact_lock);
+
+	return err;
+}
+
+int lan9645x_mact_flush(struct lan9645x *lan9645x, int port)
+{
+	int err;
+
+	mutex_lock(&lan9645x->mact_lock);
+	/* MAC table entries with dst index matching port are aged on scan. */
+	lan_wr(ANA_ANAGEFIL_PID_EN_SET(1) |
+	       ANA_ANAGEFIL_PID_VAL_SET(port),
+	       lan9645x, ANA_ANAGEFIL);
+
+	/* Flushing requires two scans. First sets AGE_FLAG=1, second removes
+	 * entries with AGE_FLAG=1.
+	 */
+	lan_wr(ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_AGE),
+	       lan9645x,
+	       ANA_MACACCESS);
+
+	err = lan9645x_mac_wait_for_completion(lan9645x, NULL);
+	if (err)
+		goto mact_unlock;
+
+	lan_wr(ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_AGE),
+	       lan9645x,
+	       ANA_MACACCESS);
+
+	err = lan9645x_mac_wait_for_completion(lan9645x, NULL);
+
+mact_unlock:
+	lan_wr(0, lan9645x, ANA_ANAGEFIL);
+	mutex_unlock(&lan9645x->mact_lock);
+	return err;
+}
+
+int lan9645x_mac_init(struct lan9645x *lan9645x)
+{
+	u32 val;
+	int err;
+
+	/* Clear the MAC table */
+	lan_wr(ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_INIT), lan9645x,
+	       ANA_MACACCESS);
+
+	err = lan9645x_rd_poll_timeout(lan9645x, ANA_MACACCESS, val,
+				       ANA_MACACCESS_MAC_TABLE_CMD_GET(val) ==
+				       CMD_IDLE);
+	if (err) {
+		dev_err(lan9645x->dev, "MAC table clear timeout\n");
+		return err;
+	}
+
+	mutex_init(&lan9645x->mact_lock);
+	return 0;
+}
+
+void lan9645x_mac_deinit(struct lan9645x *lan9645x)
+{
+	mutex_destroy(&lan9645x->mact_lock);
+}
+
+int lan9645x_mact_dsa_dump(struct lan9645x *lan9645x, int port,
+			   dsa_fdb_dump_cb_t *cb, void *data)
+{
+	u8 mac[ETH_ALEN] __aligned(2);
+	u32 mach, macl, maca;
+	int err = 0;
+	u32 autoage;
+	u64 addr;
+	u16 vid;
+	u8 type;
+
+	mutex_lock(&lan9645x->mact_lock);
+
+	/* The aging filter works both for aging scans and GET_NEXT table scans.
+	 * With it, the HW table iteration only stops at entries matching our
+	 * filter. Since DSA calls us for each port on a table dump, this helps
+	 * avoid unnecessary work.
+	 *
+	 * Disable automatic aging temporarily. First save current state.
+	 */
+	autoage = lan_rd(lan9645x, ANA_AUTOAGE);
+
+	/* Disable aging */
+	lan_rmw(ANA_AUTOAGE_AGE_PERIOD_SET(0),
+		ANA_AUTOAGE_AGE_PERIOD,
+		lan9645x, ANA_AUTOAGE);
+
+	/* Setup filter on our port */
+	lan_wr(ANA_ANAGEFIL_PID_EN_SET(1) |
+	       ANA_ANAGEFIL_PID_VAL_SET(port),
+	       lan9645x, ANA_ANAGEFIL);
+
+	lan_wr(0, lan9645x, ANA_MACHDATA);
+	lan_wr(0, lan9645x, ANA_MACLDATA);
+
+	type = ENTRYTYPE_NORMAL;
+
+	while (1) {
+		/* NOTE: we rely on mach, macl and type being set correctly in
+		 * the registers from previous round, vis a vis the GET_NEXT
+		 * semantics, so locking entire loop is important.
+		 */
+		lan_wr(ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_GET_NEXT) |
+		       ANA_MACACCESS_ENTRYTYPE_SET(type),
+		       lan9645x, ANA_MACACCESS);
+
+		err = lan9645x_mac_wait_for_completion(lan9645x, &maca);
+		if (err)
+			break;
+
+		if (ANA_MACACCESS_VALID_GET(maca) == 0)
+			break;
+
+		type = ANA_MACACCESS_ENTRYTYPE_GET(maca);
+		mach = lan_rd(lan9645x, ANA_MACHDATA);
+		macl = lan_rd(lan9645x, ANA_MACLDATA);
+
+		/* Only dynamic entries are surfaced through the user port dump.
+		 * ENTRYTYPE_LOCKED entries are already reported by the bridge
+		 * master's ndo_fdb_dump as NTF_MASTER, so we avoid duplicating
+		 * them as NTF_SELF.
+		 * Entries toward the host (NTF_SELF) have DEST_IDX == CPU_PORT
+		 * and are filtered out by the DEST_IDX check.
+		 */
+		if (ANA_MACACCESS_DEST_IDX_GET(maca) == port &&
+		    type == ENTRYTYPE_NORMAL) {
+			addr = (u64)ANA_MACHDATA_MACHDATA_GET(mach) << 32 |
+			       macl;
+			u64_to_ether_addr(addr, mac);
+			vid = ANA_MACHDATA_VID_GET(mach);
+			if (vid > VLAN_MAX)
+				vid = 0;
+
+			err = cb(mac, vid, false, data);
+			if (err)
+				break;
+		}
+	}
+
+	/* Remove aging filters and restore aging */
+	lan_wr(0, lan9645x, ANA_ANAGEFIL);
+	lan_rmw(ANA_AUTOAGE_AGE_PERIOD_SET(ANA_AUTOAGE_AGE_PERIOD_GET(autoage)),
+		ANA_AUTOAGE_AGE_PERIOD,
+		lan9645x, ANA_AUTOAGE);
+
+	mutex_unlock(&lan9645x->mact_lock);
+
+	return err;
+}
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
index eb13dfadbd3c..a76e61fb3709 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
@@ -69,6 +69,7 @@ static void lan9645x_teardown(struct dsa_switch *ds)
 
 	destroy_workqueue(lan9645x->owq);
 	lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
+	lan9645x_mac_deinit(lan9645x);
 	mutex_destroy(&lan9645x->fwd_domain_lock);
 }
 
@@ -150,6 +151,9 @@ static int lan9645x_setup(struct dsa_switch *ds)
 
 	mutex_init(&lan9645x->fwd_domain_lock);
 	err = lan9645x_vlan_init(lan9645x);
+	if (err)
+		goto err_mutex;
+	err = lan9645x_mac_init(lan9645x);
 	if (err)
 		goto err_mutex;
 
@@ -263,7 +267,7 @@ static int lan9645x_setup(struct dsa_switch *ds)
 						dev_name(lan9645x->dev));
 	if (!lan9645x->owq) {
 		err = -ENOMEM;
-		goto err_mutex;
+		goto err_mac;
 	}
 
 	ds->mtu_enforcement_ingress = true;
@@ -283,6 +287,8 @@ static int lan9645x_setup(struct dsa_switch *ds)
 
 	return 0;
 
+err_mac:
+	lan9645x_mac_deinit(lan9645x);
 err_mutex:
 	mutex_destroy(&lan9645x->fwd_domain_lock);
 	lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
@@ -300,6 +306,8 @@ static int lan9645x_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 	u32 age_secs = max(1, msecs / MSEC_PER_SEC / 2);
 	struct lan9645x *lan9645x = ds->priv;
 
+	mutex_lock(&lan9645x->mact_lock);
+
 	/* Entry must suffer two aging scans before it is removed, so it is
 	 * aged after 2*AGE_PERIOD, and the unit is in seconds.
 	 * An age period of 0 disables automatic aging.
@@ -307,6 +315,8 @@ static int lan9645x_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 	lan_rmw(ANA_AUTOAGE_AGE_PERIOD_SET(msecs ? age_secs : 0),
 		ANA_AUTOAGE_AGE_PERIOD,
 		lan9645x, ANA_AUTOAGE);
+
+	mutex_unlock(&lan9645x->mact_lock);
 	return 0;
 }
 
@@ -609,6 +619,75 @@ static int lan9645x_port_vlan_del(struct dsa_switch *ds, int port,
 	return lan9645x_vlan_port_del_vlan(p, vlan->vid);
 }
 
+static void lan9645x_port_fast_age(struct dsa_switch *ds, int port)
+{
+	lan9645x_mact_flush(ds->priv, port);
+}
+
+static int lan9645x_fdb_dump(struct dsa_switch *ds, int port,
+			     dsa_fdb_dump_cb_t *cb, void *data)
+{
+	return lan9645x_mact_dsa_dump(ds->priv, port, cb, data);
+}
+
+static struct net_device *lan9645x_db2bridge(struct dsa_db db)
+{
+	switch (db.type) {
+	case DSA_DB_PORT:
+	case DSA_DB_LAG:
+		return NULL;
+	case DSA_DB_BRIDGE:
+		return db.bridge.dev;
+	default:
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+}
+
+static int lan9645x_fdb_add(struct dsa_switch *ds, int port,
+			    const unsigned char *addr, u16 vid,
+			    struct dsa_db db)
+{
+	struct net_device *br = lan9645x_db2bridge(db);
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct lan9645x *lan9645x = ds->priv;
+	int dest;
+
+	if (IS_ERR(br))
+		return PTR_ERR(br);
+
+	if (dsa_port_is_cpu(dp) && !br &&
+	    dsa_fdb_present_in_other_db(ds, port, addr, vid, db))
+		return 0;
+
+	if (!vid)
+		vid = lan9645x_vlan_unaware_pvid(!!br);
+
+	dest = dsa_port_is_cpu(dp) ? PGID_CPU : port;
+
+	return lan9645x_mact_learn(lan9645x, dest, addr, vid, ENTRYTYPE_LOCKED);
+}
+
+static int lan9645x_fdb_del(struct dsa_switch *ds, int port,
+			    const unsigned char *addr, u16 vid,
+			    struct dsa_db db)
+{
+	struct net_device *br = lan9645x_db2bridge(db);
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct lan9645x *lan9645x = ds->priv;
+
+	if (IS_ERR(br))
+		return PTR_ERR(br);
+
+	if (dsa_port_is_cpu(dp) && !br &&
+	    dsa_fdb_present_in_other_db(ds, port, addr, vid, db))
+		return 0;
+
+	if (!vid)
+		vid = lan9645x_vlan_unaware_pvid(!!br);
+
+	return lan9645x_mact_forget(lan9645x, addr, vid, ENTRYTYPE_LOCKED);
+}
+
 static const struct dsa_switch_ops lan9645x_switch_ops = {
 	.get_tag_protocol		= lan9645x_get_tag_protocol,
 
@@ -636,6 +715,12 @@ static const struct dsa_switch_ops lan9645x_switch_ops = {
 	.port_vlan_filtering		= lan9645x_port_vlan_filtering,
 	.port_vlan_add			= lan9645x_port_vlan_add,
 	.port_vlan_del			= lan9645x_port_vlan_del,
+
+	/* MAC table integration */
+	.port_fast_age			= lan9645x_port_fast_age,
+	.port_fdb_dump			= lan9645x_fdb_dump,
+	.port_fdb_add			= lan9645x_fdb_add,
+	.port_fdb_del			= lan9645x_fdb_del,
 };
 
 static int lan9645x_request_target_regmaps(struct lan9645x *lan9645x)
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
index baf23a372f35..f5d8b7042d57 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
@@ -164,6 +164,19 @@ struct lan9645x_vlan {
 	    s_fwd_ena: 1;
 };
 
+/* MAC table entry types.
+ * ENTRYTYPE_NORMAL is subject to aging.
+ * ENTRYTYPE_LOCKED is not subject to aging.
+ * ENTRYTYPE_MACv4 is not subject to aging. For IPv4 multicast.
+ * ENTRYTYPE_MACv6 is not subject to aging. For IPv6 multicast.
+ */
+enum macaccess_entry_type {
+	ENTRYTYPE_NORMAL = 0,
+	ENTRYTYPE_LOCKED,
+	ENTRYTYPE_MACV4,
+	ENTRYTYPE_MACV6,
+};
+
 struct lan9645x {
 	struct device *dev;
 	struct dsa_switch *ds;
@@ -187,6 +200,7 @@ struct lan9645x {
 	u16 bridge_mask; /* Mask for bridged ports */
 	u16 bridge_fwd_mask; /* Mask for forwarding bridged ports */
 	struct mutex fwd_domain_lock; /* lock forwarding configuration */
+	struct mutex mact_lock; /* serialize mac table register access */
 
 	/* VLAN entries */
 	struct lan9645x_vlan vlans[VLAN_N_VID];
@@ -381,4 +395,17 @@ int lan9645x_vlan_port_del_vlan(struct lan9645x_port *p, u16 vid);
 void lan9645x_vlan_set_hostmode(struct lan9645x_port *p);
 void lan9645x_vlan_clear_hostmode(struct lan9645x_port *p);
 
+/* MAC table: lan9645x_mac.c */
+int lan9645x_mact_flush(struct lan9645x *lan9645x, int port);
+int lan9645x_mact_learn(struct lan9645x *lan9645x, int port,
+			const unsigned char *addr, u16 vid,
+			enum macaccess_entry_type type);
+int lan9645x_mact_forget(struct lan9645x *lan9645x,
+			 const unsigned char mac[ETH_ALEN], unsigned int vid,
+			 enum macaccess_entry_type type);
+int lan9645x_mac_init(struct lan9645x *lan9645x);
+void lan9645x_mac_deinit(struct lan9645x *lan9645x);
+int lan9645x_mact_dsa_dump(struct lan9645x *lan9645x, int port,
+			   dsa_fdb_dump_cb_t *cb, void *data);
+
 #endif /* __LAN9645X_MAIN_H__ */

-- 
2.52.0


