Return-Path: <netdev+bounces-270992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDrQDKRtwmmncwQAu9opvQ
	(envelope-from <netdev+bounces-270992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:55:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A717B306D4E
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AFB130BAB75
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ED03ECBF2;
	Tue, 24 Mar 2026 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="E4Ism2kG"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E493E557B;
	Tue, 24 Mar 2026 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349468; cv=none; b=ZfNZr+ddRlBH8S6rkgjNcEDM1keFgaxx4GGZFlxfhLR/vaiKeTEmSe53vHbxr2F+yfF6Cu9UYG4BpP1GA2bZqXlVoQSXsPwsJ8x+gQ7+CXRxKJBN8zc4xcfS//QVKvrsAaRNM50KHOll+6A3QmBmHFFy9j2Ng6P/h6w+joIYAxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349468; c=relaxed/simple;
	bh=WK71VhuSQkRGxvrZRmbYVz6TJl47kismoZOBQp+09ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Z6i36LGOhvmAaj/cMnwr4z6+UN95fZTvV5yUUsBaWOkJtzWSY8EXDBRxT+oFyEnmgoJBLtKFlhi+qk0dhMtaFOeEoUW1TqBPcsWStaqYTRx8Z4vScEUIlrfdvW41nzEWaRhgCErCtFUhzZGH2X25hEpqu5RSDe+GuBOnXf1nhps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=E4Ism2kG; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774349461; x=1805885461;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=WK71VhuSQkRGxvrZRmbYVz6TJl47kismoZOBQp+09ak=;
  b=E4Ism2kGNcnsxJ9OC9XHacTwepamWiF334X10e/HX1WGRsbmUg5Uqd0g
   nBz0QeAgXs2lFGNPUm9wteS7rQWKfNYsuzElwWqTaUQKdkHlZl1ZN3qJk
   X3qt+0WxQykGEk50S42NbBj72eEEIts2JTXETlm4lH1P9bSn3+TCImNs9
   TWeyAYdQGxODlizx223qmAoqIOkol+o4BTXJ43QK0ubZiyB4tLgWPT5tt
   bM7HP0LBrnaXDV3mf8y/h6DzxrRBRzrY7stqiEHNHCOgrw/ORsZB3TgYj
   7SDLhJeI36oOKrQ9KFol0Sa05bsi1pnh/JcfHAKhPYYFCvFTxerm2LQr2
   w==;
X-CSE-ConnectionGUID: av7DD6XARYCJBGtV0zHjGA==
X-CSE-MsgGUID: 3iVAlBRyRzil91OLaw6hYw==
X-IronPort-AV: E=Sophos;i="6.23,138,1770620400"; 
   d="scan'208";a="222375824"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 03:51:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 24 Mar 2026 03:50:30 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 24 Mar 2026 03:50:27 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Tue, 24 Mar 2026 11:46:50 +0100
Subject: [PATCH net-next v2 7/9] net: dsa: lan9645x: add mac table
 integration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260324-dsa_lan9645x_switch_driver_base-v2-7-f7504e3b0681@microchip.com>
References: <20260324-dsa_lan9645x_switch_driver_base-v2-0-f7504e3b0681@microchip.com>
In-Reply-To: <20260324-dsa_lan9645x_switch_driver_base-v2-0-f7504e3b0681@microchip.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270992-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:email,microchip.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A717B306D4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c  | 406 +++++++++++++++++++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.c |  91 +++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.h |  46 +++
 4 files changed, 544 insertions(+)

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
index 000000000000..6335714dca21
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c
@@ -0,0 +1,406 @@
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
+static bool lan9645x_mact_entry_equal(struct lan9645x_mact_entry *entry,
+				      const unsigned char *mac, u16 vid)
+{
+	/* The hardware table is keyed on (vid,mac) */
+	return entry->common.key.vid == vid &&
+	       ether_addr_equal(mac, entry->common.key.mac);
+}
+
+static struct lan9645x_mact_entry *
+lan9645x_mact_entry_find(struct lan9645x *lan9645x, const unsigned char *mac,
+			 u16 vid)
+{
+	struct lan9645x_mact_entry *entry;
+
+	lockdep_assert_held(&lan9645x->mact_lock);
+
+	list_for_each_entry(entry, &lan9645x->mac_entries, list)
+		if (lan9645x_mact_entry_equal(entry, mac, vid))
+			return entry;
+
+	return NULL;
+}
+
+static struct lan9645x_mact_entry *
+lan9645x_mact_entry_alloc(struct lan9645x *lan9645x, const unsigned char *mac,
+			  u16 vid, u8 pgid, enum macaccess_entry_type type)
+{
+	struct lan9645x_mact_entry *entry;
+
+	entry = kzalloc_obj(*entry);
+	if (!entry)
+		return NULL;
+
+	ether_addr_copy(entry->common.key.mac, mac);
+	entry->common.key.vid = vid;
+	entry->common.pgid = pgid;
+	entry->common.type = type;
+
+	dev_dbg(lan9645x->dev,
+		"mac=%pM vid=%u pgid=%u type=%d\n",
+		entry->common.key.mac, entry->common.key.vid,
+		entry->common.pgid, entry->common.type);
+
+	return entry;
+}
+
+static void lan9645x_mact_entry_dealloc(struct lan9645x *lan9645x,
+					struct lan9645x_mact_entry *entry)
+{
+	if (!entry)
+		return;
+
+	dev_dbg(lan9645x->dev,
+		"mac=%pM vid=%u pgid=%u type=%d\n",
+		entry->common.key.mac, entry->common.key.vid,
+		entry->common.pgid, entry->common.type);
+
+	list_del(&entry->list);
+	kfree(entry);
+}
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
+static void lan9645x_mact_parse(u32 machi, u32 maclo, u32 maca,
+				struct lan9645x_mact_common *rentry)
+{
+	u64 addr = ANA_MACHDATA_MACHDATA_GET(machi);
+
+	addr = addr << 32 | maclo;
+	u64_to_ether_addr(addr, rentry->key.mac);
+	rentry->key.vid = ANA_MACHDATA_VID_GET(machi);
+	rentry->pgid = ANA_MACACCESS_DEST_IDX_GET(maca);
+	rentry->type = ANA_MACACCESS_ENTRYTYPE_GET(maca);
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
+int lan9645x_mact_entry_add(struct lan9645x *lan9645x, int pgid,
+			    const unsigned char *mac, u16 vid)
+{
+	struct lan9645x_mact_entry *entry;
+	int err;
+
+	mutex_lock(&lan9645x->mact_lock);
+
+	/* Users can not move (vid,mac) to a different port, without removing
+	 * the original entry first. But we overwrite entry in HW, and update
+	 * software pgid for good measure.
+	 */
+	entry = lan9645x_mact_entry_find(lan9645x, mac, vid);
+	if (entry) {
+		entry->common.pgid = pgid;
+		goto mac_learn;
+	}
+
+	entry = lan9645x_mact_entry_alloc(lan9645x, mac, vid, pgid,
+					  ENTRYTYPE_LOCKED);
+	if (!entry) {
+		mutex_unlock(&lan9645x->mact_lock);
+		return -ENOMEM;
+	}
+
+	list_add_tail(&entry->list, &lan9645x->mac_entries);
+
+mac_learn:
+	err = __lan9645x_mact_learn(lan9645x, pgid, mac, vid, ENTRYTYPE_LOCKED);
+	if (err)
+		lan9645x_mact_entry_dealloc(lan9645x, entry);
+
+	mutex_unlock(&lan9645x->mact_lock);
+	return err;
+}
+
+int lan9645x_mact_entry_del(struct lan9645x *lan9645x, int pgid,
+			    const unsigned char *mac, u16 vid)
+{
+	struct lan9645x_mact_entry *entry;
+	int err;
+
+	mutex_lock(&lan9645x->mact_lock);
+
+	entry = lan9645x_mact_entry_find(lan9645x, mac, vid);
+	if (!entry) {
+		mutex_unlock(&lan9645x->mact_lock);
+		return -ENOENT;
+	}
+
+	WARN_ON(entry->common.pgid != pgid);
+	lan9645x_mact_entry_dealloc(lan9645x, entry);
+	err = __lan9645x_mact_forget(lan9645x, mac, vid, ENTRYTYPE_LOCKED);
+
+	mutex_unlock(&lan9645x->mact_lock);
+	return err;
+}
+
+void lan9645x_mac_init(struct lan9645x *lan9645x)
+{
+	u32 val;
+
+	mutex_init(&lan9645x->mact_lock);
+	INIT_LIST_HEAD(&lan9645x->mac_entries);
+
+	/* Clear the MAC table */
+	lan_wr(ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_INIT),
+	       lan9645x, ANA_MACACCESS);
+
+	if (lan9645x_rd_poll_timeout(lan9645x, ANA_MACACCESS, val,
+				     ANA_MACACCESS_MAC_TABLE_CMD_GET(val) ==
+				     CMD_IDLE))
+		dev_err(lan9645x->dev, "mac init timeout\n");
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
+	struct lan9645x_mact_entry entry = {};
+	u32 mach, macl, maca;
+	int err = 0;
+	u32 autoage;
+
+	entry.common.type = ENTRYTYPE_NORMAL;
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
+	while (1) {
+		/* NOTE: we rely on mach, macl and type being set correctly in
+		 * the registers from previous round, vis a vis the GET_NEXT
+		 * semantics, so locking entire loop is important.
+		 */
+		lan_wr(ANA_MACACCESS_MAC_TABLE_CMD_SET(CMD_GET_NEXT) |
+		       ANA_MACACCESS_ENTRYTYPE_SET(entry.common.type),
+		       lan9645x, ANA_MACACCESS);
+
+		if (lan9645x_mac_wait_for_completion(lan9645x, &maca))
+			break;
+
+		if (ANA_MACACCESS_VALID_GET(maca) == 0)
+			break;
+
+		mach = lan_rd(lan9645x, ANA_MACHDATA);
+		macl = lan_rd(lan9645x, ANA_MACLDATA);
+
+		lan9645x_mact_parse(mach, macl, maca, &entry.common);
+
+		if (ANA_MACACCESS_DEST_IDX_GET(maca) == port &&
+		    entry.common.type == ENTRYTYPE_NORMAL) {
+			if (entry.common.key.vid > VLAN_MAX)
+				entry.common.key.vid = 0;
+
+			err = cb(entry.common.key.mac, entry.common.key.vid,
+				 false, data);
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
index 046c95a72242..32c0301030a4 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
@@ -71,6 +71,7 @@ static void lan9645x_teardown(struct dsa_switch *ds)
 
 	destroy_workqueue(lan9645x->owq);
 	lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
+	lan9645x_mac_deinit(lan9645x);
 	mutex_destroy(&lan9645x->fwd_domain_lock);
 }
 
@@ -157,6 +158,7 @@ static int lan9645x_setup(struct dsa_switch *ds)
 
 	mutex_init(&lan9645x->fwd_domain_lock);
 	lan9645x_vlan_init(lan9645x);
+	lan9645x_mac_init(lan9645x);
 
 	/* Link Aggregation Mode: NETDEV_LAG_HASH_L2 */
 	lan_wr(ANA_AGGR_CFG_AC_SMAC_ENA |
@@ -584,6 +586,89 @@ static int lan9645x_port_vlan_del(struct dsa_switch *ds, int port,
 	return 0;
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
+	if (dsa_port_is_cpu(dp))
+		return lan9645x_mact_learn(lan9645x, PGID_CPU, addr, vid,
+					   ENTRYTYPE_LOCKED);
+
+	return lan9645x_mact_entry_add(lan9645x, port, addr, vid);
+}
+
+static int lan9645x_fdb_del(struct dsa_switch *ds, int port,
+			    const unsigned char *addr, u16 vid,
+			    struct dsa_db db)
+{
+	struct net_device *br = lan9645x_db2bridge(db);
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct lan9645x *lan9645x = ds->priv;
+	int err;
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
+	if (dsa_port_is_cpu(dp))
+		return lan9645x_mact_forget(lan9645x, addr, vid,
+					    ENTRYTYPE_LOCKED);
+
+	err = lan9645x_mact_entry_del(lan9645x, port, addr, vid);
+	if (err == -ENOENT) {
+		dev_dbg(lan9645x->dev,
+			"fdb not found port=%d addr=%pM vid=%u\n", port, addr,
+			vid);
+		return 0;
+	}
+
+	return err;
+}
+
 static const struct dsa_switch_ops lan9645x_switch_ops = {
 	.get_tag_protocol		= lan9645x_get_tag_protocol,
 
@@ -611,6 +696,12 @@ static const struct dsa_switch_ops lan9645x_switch_ops = {
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
index b2b2a88083c3..012d5bb17013 100644
--- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
@@ -162,6 +162,33 @@ struct lan9645x_vlan {
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
+struct lan9645x_mact_common {
+	struct lan9645x_mact_key {
+		u16 vid;
+		u8 mac[ETH_ALEN] __aligned(2);
+	} key;
+	u32 pgid: 6, /* 0-63 general purpose pgids. */
+	    type: 2;
+};
+
+struct lan9645x_mact_entry {
+	struct lan9645x_mact_common common;
+	struct list_head list;
+};
+
 struct lan9645x {
 	struct device *dev;
 	struct dsa_switch *ds;
@@ -185,6 +212,8 @@ struct lan9645x {
 	u16 bridge_mask; /* Mask for bridged ports */
 	u16 bridge_fwd_mask; /* Mask for forwarding bridged ports */
 	struct mutex fwd_domain_lock; /* lock forwarding configuration */
+	struct list_head mac_entries;
+	struct mutex mact_lock; /* lock mac table and mac_entries list */
 
 	/* VLAN entries */
 	struct lan9645x_vlan vlans[VLAN_N_VID];
@@ -377,4 +406,21 @@ int lan9645x_vlan_port_add_vlan(struct lan9645x_port *p, u16 vid, bool pvid,
 void lan9645x_vlan_port_del_vlan(struct lan9645x_port *p, u16 vid);
 void lan9645x_vlan_set_hostmode(struct lan9645x_port *p);
 
+/* MAC table: lan9645x_mac.c */
+int lan9645x_mact_flush(struct lan9645x *lan9645x, int port);
+int lan9645x_mact_learn(struct lan9645x *lan9645x, int port,
+			const unsigned char *addr, u16 vid,
+			enum macaccess_entry_type type);
+int lan9645x_mact_forget(struct lan9645x *lan9645x,
+			 const unsigned char mac[ETH_ALEN], unsigned int vid,
+			 enum macaccess_entry_type type);
+void lan9645x_mac_init(struct lan9645x *lan9645x);
+void lan9645x_mac_deinit(struct lan9645x *lan9645x);
+int lan9645x_mact_dsa_dump(struct lan9645x *lan9645x, int port,
+			   dsa_fdb_dump_cb_t *cb, void *data);
+int lan9645x_mact_entry_del(struct lan9645x *lan9645x, int pgid,
+			    const unsigned char *mac, u16 vid);
+int lan9645x_mact_entry_add(struct lan9645x *lan9645x, int pgid,
+			    const unsigned char *mac, u16 vid);
+
 #endif /* __LAN9645X_MAIN_H__ */

-- 
2.52.0


