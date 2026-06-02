Return-Path: <netdev+bounces-294466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zTy4GsNtH2p2lwAAu9opvQ
	(envelope-from <netdev+bounces-294466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 01:56:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD783633070
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 01:56:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294466-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294466-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=hotmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B011030597BC
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 23:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB1D3C457C;
	Tue,  2 Jun 2026 23:55:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7AD3A6EFC
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 23:55:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444533; cv=none; b=MyBrqW2F06WUmr5wtUmMIgXqLfQxTj61K7pWbPVn2Xx83p4Woh/NDXyzPu0yj6TuBTKWnylFe7DeJnzjYwncoKaC9ImjKWB4DsnXwDiOIIEfiHdS0l4LUwwF/vJOg6pr+2DKy59cfqy0qc5KNGLKP3WS53hKatr2tZ3jzuNZJfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444533; c=relaxed/simple;
	bh=wpBrehQFmNvRP0r6KS8akDFh40prvkx7Ba1gqXcCN9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H63cjD/w7z9VEGUQ8irkRy1MgqSY4dyxY2x1CKrY3Hhl2ZhSITTcqK4oNbe9KCKOE8DWSz6Iny7GAT2JmwxNOOuoK+mZDBpU+MLoxGsZ1pfuwaWXYwsZHiZjKKV0pT3I62QQKuaVBk6uLYHXxJnYdV9dc53CeTr5siC7XzFlRFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.178
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5174a3a025aso31961901cf.3
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 16:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780444530; x=1781049330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzZ6s0AznRAk34C0Bcc3By/ncVdYtLX2scOr3Lki/eU=;
        b=Q1AqJO/kt/zeT1+0BhmkkBXCwDGS0pBVyXjwjfYMW9B448G/FBVU9GqRbNZo8kBhEa
         b2SefiQIGc60m338S99RA2xMiamdI3KdFMI6omKlV7jUr1z6uEygeAERQH6t/5IxZwWU
         A9gWnHusccu1Wma6QTXnDYZZm9vriUhhSK6TX5UtMumcGzxWZICDHc+Rbs/8gyV2ULSv
         Broc4szpNjznRejC+6bPSQu/A7z6fYtD2u5xABxnIbFHxY3ef9N0PKBshhhprm6ssT65
         /9Lyj1aRa+LU411dKNq6w5NesbM+aFcyZTZ2e4sC21UYXw/oSkULKZybNVDUOgkpyexj
         d3+w==
X-Gm-Message-State: AOJu0YzfpFyfMUQD6WrtFqy5VJmVVv/lqmtjYVea/HTqwg5EOEy4tDuD
	7ycklxdwGAYy06K71Yq7tZrQEpVzFWO6m0EOGQ/lZNmrE6UcSt3Ba8/9
X-Gm-Gg: Acq92OFgGcxmklgVqr5ohxVuc/8CkZ13SJDcsl07Fr1TmqgpTSfHNEe69mblDVUjhRA
	oafQhqZX7bqRMuqTea93zTcf8i6jF4K81VXyBtMztIJ8KfP1PoODjwvQpAWO0GrfKHC/ZT/aM0t
	jkRh1EIBkhS6CL4BpUO2V7S1Le9a6OPtb7HIsNJ6htLJT+K63POGGBogWDwm5qmsX9mWZ7jaqvy
	YawX38QR902fSbsIb74BQ78zwd4TTkgMvWmaQiPzvOy1lA2seUwAsgdvUnCPCUo7o1x8454edLp
	6xyOaelwV/I3XfgsXB0wLTiVOvwLT6M3zh02tyDM1kqNFIvobohL41KH7ckES4btpAzhwmPOQfi
	07t+ig+2oPhXn/Eh7kCmIK13AuRz2ArI9FY8/pAv1KMGLewg8iDK0rNDeW2CSYq2b6+/h/5nu8m
	BD3Bj8WmikyX4ywZTBBnG7HzO0FEuRrD2olRauFy5siJNUodsFyvtGKVXC7nOqik/idEfjnpqVY
	1juHW1vM4djvjW1dn4Fm6g6dZlSv39v
X-Received: by 2002:a05:622a:346:b0:50d:d1ea:65dd with SMTP id d75a77b69052e-517785cd83cmr21015931cf.14.1780444529845;
        Tue, 02 Jun 2026 16:55:29 -0700 (PDT)
Received: from lxc-docker-tertiary.local (pool-108-45-26-115.washdc.fios.verizon.net. [108.45.26.115])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdb5e92sm5810016d6.11.2026.06.02.16.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 16:55:29 -0700 (PDT)
From: Greg Patrick <gregspatrick@hotmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v1] net: phy: sfp: detect presence via I2C when no MOD_DEF0 GPIO
Date: Tue,  2 Jun 2026 23:55:28 +0000
Message-ID: <20260602235528.2795028-1-gregspatrick@hotmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[hotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[gregspatrick@hotmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-294466-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregspatrick@hotmail.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[hotmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD783633070

Boards that do not wire the SFP cage MOD_DEF0 signal to a GPIO (for
example the NicGiga S100-0800S-M, where the I/O expander is fully
consumed by TX_DISABLE) currently use sff_gpio_get_state(), which
unconditionally reports the module as present. An empty cage therefore
fails its probe and is parked in SFP_MOD_ERROR forever; because
SFP_F_PRESENT never deasserts there is no REMOVE event to recover the
state machine, so a module inserted after boot is never detected.

Derive presence from a throttled single-byte I2C read of the module
EEPROM instead: an ACK asserts SFP_F_PRESENT, two consecutive failures
clear it (to ride out a transient error on a live module). The existing
poll then emits SFP_E_INSERT / SFP_E_REMOVE normally, giving working
hot-plug and avoiding the boot-time -EIO spam on empty cages.

Signed-off-by: Greg Patrick <gregspatrick@hotmail.com>
---
Posting for review per a downstream discussion (OpenWrt PR #23579) on adding
the NicGiga S100-0800S-M, an RTL9303 8x SFP+ switch that wires none of the
cage sideband signals to a software-visible GPIO. I'd value your steer before
this is carried downstream.

Open design question: this changes behaviour for *all* boards without a
MOD_DEF0 GPIO, from "always present" (sff_gpio_get_state) to I2C-probed
presence. That fixes hot-plug and the empty-cage -EIO spam on boards that
simply lack a wired MOD_ABS, but it also affects boards that intentionally
carry a permanently-fitted module and relied on the always-present path.
Would you prefer this gated behind a DT opt-in property rather than changing
the default? Happy to respin either way. The 2s re-probe interval is likewise
a first guess.

Tested on a NicGiga S100-0800S-M (RTL9303, 8x SFP+, no MOD_DEF0 GPIO):
inserting a module into a cage that was empty at boot now links within ~2s,
removal is detected, and the boot-time -EIO burst on empty cages is gone. No
behaviour change observed on cages populated at boot.

 drivers/net/phy/sfp.c | 74 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 376c705a9..fd99638e9 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -206,6 +206,11 @@ static const enum gpiod_flags gpio_flags[] = {
 #define T_PROBE_RETRY_SLOW	msecs_to_jiffies(5000)
 #define R_PROBE_RETRY_SLOW	12
 
+/* Interval at which sfp_i2c_get_state() re-probes the I2C bus for module
+ * presence on boards without a MOD_DEF0 GPIO (see sfp_i2c_get_state()).
+ */
+#define T_PROBE_PRESENT		msecs_to_jiffies(2000)
+
 /* SFP modules appear to always have their PHY configured for bus address
  * 0x56 (which with mdio-i2c, translates to a PHY address of 22).
  * RollBall SFPs access phy via SFP Enhanced Digital Diagnostic Interface
@@ -249,6 +254,13 @@ struct sfp {
 
 	bool need_poll;
 
+	/* I2C-probed presence, for boards without a MOD_DEF0 GPIO.
+	 * Access rules: st_mutex held (updated from the poll/state machine).
+	 */
+	bool i2c_present;
+	u8 i2c_present_nak;
+	unsigned long i2c_present_next;
+
 	/* Access rules:
 	 * state_hw_drive: st_mutex held
 	 * state_hw_mask: st_mutex held
@@ -651,11 +663,6 @@ static unsigned int sfp_gpio_get_state(struct sfp *sfp)
 	return state;
 }
 
-static unsigned int sff_gpio_get_state(struct sfp *sfp)
-{
-	return sfp_gpio_get_state(sfp) | SFP_F_PRESENT;
-}
-
 static void sfp_gpio_set_state(struct sfp *sfp, unsigned int state)
 {
 	unsigned int drive;
@@ -863,6 +870,44 @@ static int sfp_read(struct sfp *sfp, bool a2, u8 addr, void *buf, size_t len)
 	return sfp->read(sfp, a2, addr, buf, len);
 }
 
+/* Probe whether a module is physically present by attempting a single-byte
+ * I2C read of the EEPROM identifier (an empty cage NAKs). Used as the presence
+ * source on boards that do not wire MOD_DEF0 to a GPIO.
+ */
+static bool sfp_module_present_i2c(struct sfp *sfp)
+{
+	u8 id;
+
+	return sfp_read(sfp, false, SFP_PHYS_ID, &id, sizeof(id)) == sizeof(id);
+}
+
+/* get_state variant for boards without a MOD_DEF0 GPIO. Instead of assuming
+ * the module is always present, derive SFP_F_PRESENT from a throttled I2C
+ * probe so that hot-insertion and removal are detected. A single ACK asserts
+ * presence; two consecutive failures clear it, to ride out a transient I2C
+ * error on a live module.
+ */
+static unsigned int sfp_i2c_get_state(struct sfp *sfp)
+{
+	unsigned int state = sfp_gpio_get_state(sfp);
+
+	if (time_after_eq(jiffies, sfp->i2c_present_next)) {
+		if (sfp_module_present_i2c(sfp)) {
+			sfp->i2c_present = true;
+			sfp->i2c_present_nak = 0;
+		} else if (sfp->i2c_present && ++sfp->i2c_present_nak >= 2) {
+			sfp->i2c_present = false;
+			sfp->i2c_present_nak = 0;
+		}
+		sfp->i2c_present_next = jiffies + T_PROBE_PRESENT;
+	}
+
+	if (sfp->i2c_present)
+		state |= SFP_F_PRESENT;
+
+	return state;
+}
+
 static int sfp_write(struct sfp *sfp, bool a2, u8 addr, void *buf, size_t len)
 {
 	return sfp->write(sfp, a2, addr, buf, len);
@@ -3168,9 +3213,22 @@ static int sfp_probe(struct platform_device *pdev)
 	sfp->get_state = sfp_gpio_get_state;
 	sfp->set_state = sfp_gpio_set_state;
 
-	/* Modules that have no detect signal are always present */
-	if (!(sfp->gpio[GPIO_MODDEF0]))
-		sfp->get_state = sff_gpio_get_state;
+	/* Boards with no MOD_DEF0 GPIO have no hardware presence signal. Rather
+	 * than assume the module is always present (which traps an empty cage
+	 * in MOD_ERROR and never detects hot-insertion), derive presence from a
+	 * throttled I2C probe and poll for changes. sfp_i2c_configure() has
+	 * already set i2c_max_block_size; seed i2c_block_size so the presence
+	 * read does not issue a zero-length transfer before the first probe.
+	 * Seed i2c_present_next to jiffies so the first probe happens
+	 * immediately (a zero value would be in the past relative to the
+	 * negative INITIAL_JIFFIES at boot and delay detection).
+	 */
+	if (!(sfp->gpio[GPIO_MODDEF0])) {
+		sfp->get_state = sfp_i2c_get_state;
+		sfp->i2c_block_size = sfp->i2c_max_block_size;
+		sfp->i2c_present_next = jiffies;
+		sfp->need_poll = true;
+	}
 
 	device_property_read_u32(&pdev->dev, "maximum-power-milliwatt",
 				 &sfp->max_power_mW);
-- 
2.53.0


