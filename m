Return-Path: <netdev+bounces-298263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nfpjM675KmpT0QMAu9opvQ
	(envelope-from <netdev+bounces-298263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:08:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 271F067450C
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:08:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=hotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298263-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298263-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73E1E322D621
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA3843635E;
	Thu, 11 Jun 2026 17:53:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B61409E1B
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 17:53:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200426; cv=none; b=KEJC7Op/v2joaqEJ9yMFnOz680NEZm2B/EeYdIckMOYHsUBYBtuVBAZ5U+pyD/npjztOw2GpVvbL8ffqTcNlcYNu6NbK5bdP8FU3KYIGWOURb9oirGyo3uhMIXzqTjyZPxTz1xo6e34oWAThcQKKaJXnbzrzjKlqGnsnXTxg/W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200426; c=relaxed/simple;
	bh=C1/9WqMIikG4TbvGYvRTRnQML9kGjmx5W4qtV8KonoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kGqEX2H800rmAs9PWbfjjlpElgSmmT0TpvrIJrO1dVctx68fFfPHglr6j2lluWJ5KfXDmkqU2Xf8unKaj9kBy1yvf3ykFmRautX4BmRAjypIVqzAeJRnTDcWNPCFHi51Vm9pa8pSJlDNpPyWP9EShR4ydHPJc0F1ux5AubGfp/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.175
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9155183b42cso24738785a.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 10:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781200423; x=1781805223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0fUEOqCBAKWY+jF2nwnPfkq3UUQaayGSCWrTMCmKlk=;
        b=TQ77IHXgwEPWOtCnVHMlMOEgOr+bXNL+frlnBmsKkcVUKPpcjTH51CxLH//PmbfF+2
         dXAozr1cJbX133sW0c1xGsi0qC7diES6WYsNqI38vUSzbLn3zPLJHVUs4Oj5TBsLUskk
         9hOxqbIpLkEdfVz8dm/rMOLjJEq89h5224No8AviP3BwOpXYGh5Qa1KfvAeX9c0HEQAn
         B1BwHEww1wNy1ebgF+MYCWL42NqRxxp3uEr9DyW1BaFIMWDqfs4WFp2fcDcXteskED7O
         CcY3cNaVHb4ZS8niELVmr5gpe9VAID6iafmj6EFQR5RAjjo9OvbVzEwKFv3Ib2aJnpEA
         zv9Q==
X-Gm-Message-State: AOJu0Yx6VbgC3GR1M5pAVy7KtQ5vMZMpMVI0PHl8Bajgm+4yRLA2NQrm
	xZ2yf3vTR+ssI93qJftMOH2uIMVaiRfazPQosJa1ZbeOmtFws9YFBK6W
X-Gm-Gg: Acq92OETS4pl5XLGf+kB4PsBtW6EMfsWSJ6FtVCT1QILjesXn87i8Po5m6JdkW6Cb7z
	Vxl6JHi0mLp7Z4L2OUB+hJP2LJO50We0GvDbrO0JOMDGdiiWKjsyjzg/MddXtfOfojoKkM9qODh
	4vX7THxZnXBZnC6FRsALCXu09hQs8uvcE7As2hjHZRCpx+VgGhAdAW6rkO+dULFFxFoWxM8t36C
	n6BI9bfBSRcfbpvhjj8Nmevb6JO8GAXt5X3HrGSEHcuk+2CBLR4Nhhei2MUmcsTsE4FgqyRHlq0
	HUY/ELKxX88mW6s23ZYPZnhiLtOGLL+ipljU5P3ocYroCJDa1zLD7+uKLoEJvUGpD1iL+sxNWBV
	9bGxQGeMNwehtSA66DUus2LFnjyhjpVPHrdL3MboLKWlW873R9yCdWgV0ExwS+djifCSyRiFhw1
	tfYDAHQJLrOieK7lKD3LNrU6RHTuxNgRtEKJyCS925o3tPHGLSrKct1TEZw4DbyU/JyfciQOx91
	VHkrJ6KnxicWp5/t0abitCCViX5crM1
X-Received: by 2002:a05:620a:6cca:b0:915:351b:3ad5 with SMTP id af79cd13be357-9160ae074efmr523111085a.29.1781200423338;
        Thu, 11 Jun 2026 10:53:43 -0700 (PDT)
Received: from lxc-docker-tertiary.local (pool-108-45-26-115.washdc.fios.verizon.net. [108.45.26.115])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9160aca2ee9sm246142985a.13.2026.06.11.10.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 10:53:42 -0700 (PDT)
From: Greg Patrick <gregspatrick@hotmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Manuel Stocker <mensi@mensi.ch>
Subject: [PATCH net-next v3] net: phy: sfp: detect presence via I2C when no MOD_DEF0 GPIO
Date: Thu, 11 Jun 2026 17:53:41 +0000
Message-ID: <20260611175341.2223184-1-gregspatrick@hotmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[hotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:mensi@mensi.ch,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[gregspatrick@hotmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-298263-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[hotmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 271F067450C

An SFP cage (compatible "sff,sfp") whose MOD_DEF0 signal is not wired to a
GPIO currently falls back to sff_gpio_get_state(), which unconditionally
reports the module as present. An empty cage therefore fails its probe and
is parked in SFP_MOD_ERROR forever; because SFP_F_PRESENT never deasserts
there is no REMOVE event to recover the state machine, so a module inserted
after boot is never detected, and empty cages spam -EIO at boot.

This affects boards that route none of the cage presence signal to a
software-readable input. On the NicGiga S100-0800S-M (RTL9303, 8x SFP+) the
cage I2C bus is the switch's SMBus master; TX_DISABLE is driven via a
PCA9534 I/O expander, but no MOD_ABS/MOD_DEF0 line reaches a readable GPIO
(the RTL9303 gpio0 lines read stuck-low, the single PCA9534 is fully
consumed by TX_DISABLE, and there is no RTL8231). The Horaco ZX-SW82TS-L2P
(RTL9302D, 2x SFP+) is independently affected in the same way.

For such an SFP cage, derive presence from a throttled single-byte I2C read
of the module EEPROM instead: a successful read asserts SFP_F_PRESENT,
R_PROBE_ABSENT consecutive failures clear it (to ride out a transient error
on a live module). The existing poll then emits SFP_E_INSERT / SFP_E_REMOVE
normally, giving working hot-plug and silencing the boot-time -EIO spam on
empty cages. Presence is re-probed every T_PROBE_PRESENT, so insertion is
detected within that interval and removal within
T_PROBE_PRESENT * R_PROBE_ABSENT.

A soldered-down module (compatible "sff,sff") has no presence signal and is
genuinely always present, so it continues to use sff_gpio_get_state(); the
new path is gated on the cage type advertising SFP_F_PRESENT.

Signed-off-by: Greg Patrick <gregspatrick@hotmail.com>
Tested-by: Manuel Stocker <mensi@mensi.ch>
---
v3:
 - Reduce the presence re-probe interval to 500 ms and require 3 consecutive
   failed probes (R_PROBE_ABSENT) to declare a live module removed, cutting
   removal-detection latency from ~4 s to ~1.5 s while still riding out a
   transient I2C error on a live module. Polling is gated by the existing
   need_poll path (100 ms), so this is one single-byte SMBus read per cage
   every 500 ms. Note that, as a polled scheme with no presence edge, a
   same-cage swap to a different module within the removal window cannot be
   observed; this is inherent to boards lacking a readable presence line.
   (Maxime Chevallier)
 - Hardware-validated on the NicGiga (now running from flash): insertion into
   a cage that was empty at boot is detected and links within ~1 s, and clean
   removal of a live module is detected in ~1.2-1.5 s.
 - Note the Horaco ZX-SW82TS-L2P (RTL9302D, 2x SFP+) as a second, independent
   board with the same no-MOD_DEF0 wiring. The Tested-by reflects a test of
   the I2C-presence mechanism on that board; the v3 delta is the timing
   constants above.

v2: https://lore.kernel.org/netdev/20260604151614.3310544-1-gregspatrick@hotmail.com/
v1: https://lore.kernel.org/netdev/20260602235528.2795028-1-gregspatrick@hotmail.com/

 drivers/net/phy/sfp.c | 83 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 376c705a9..5e952d095 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -206,6 +206,16 @@ static const enum gpiod_flags gpio_flags[] = {
 #define T_PROBE_RETRY_SLOW	msecs_to_jiffies(5000)
 #define R_PROBE_RETRY_SLOW	12
 
+/* Polling interval and consecutive-failure threshold for the I2C presence
+ * probe used on boards without a MOD_DEF0 GPIO (see sfp_i2c_get_state()).
+ * A single successful read asserts presence immediately; R_PROBE_ABSENT
+ * consecutive failures are required to declare a live module removed, to ride
+ * out a transient I2C error. Insertion is thus detected within
+ * T_PROBE_PRESENT and removal within T_PROBE_PRESENT * R_PROBE_ABSENT.
+ */
+#define T_PROBE_PRESENT		msecs_to_jiffies(500)
+#define R_PROBE_ABSENT		3
+
 /* SFP modules appear to always have their PHY configured for bus address
  * 0x56 (which with mdio-i2c, translates to a PHY address of 22).
  * RollBall SFPs access phy via SFP Enhanced Digital Diagnostic Interface
@@ -249,6 +259,13 @@ struct sfp {
 
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
@@ -863,6 +880,45 @@ static int sfp_read(struct sfp *sfp, bool a2, u8 addr, void *buf, size_t len)
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
+ * presence; R_PROBE_ABSENT consecutive failures clear it, to ride out a
+ * transient I2C error on a live module.
+ */
+static unsigned int sfp_i2c_get_state(struct sfp *sfp)
+{
+	unsigned int state = sfp_gpio_get_state(sfp);
+
+	if (time_after_eq(jiffies, sfp->i2c_present_next)) {
+		if (sfp_module_present_i2c(sfp)) {
+			sfp->i2c_present = true;
+			sfp->i2c_present_nak = 0;
+		} else if (sfp->i2c_present &&
+			   ++sfp->i2c_present_nak >= R_PROBE_ABSENT) {
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
@@ -3168,9 +3224,30 @@ static int sfp_probe(struct platform_device *pdev)
 	sfp->get_state = sfp_gpio_get_state;
 	sfp->set_state = sfp_gpio_set_state;
 
-	/* Modules that have no detect signal are always present */
-	if (!(sfp->gpio[GPIO_MODDEF0]))
-		sfp->get_state = sff_gpio_get_state;
+	/* An SFP cage with no MOD_DEF0 GPIO has no hardware presence signal.
+	 * Assuming the module is always present traps an empty cage in
+	 * MOD_ERROR and never detects hot-insertion, so derive presence from a
+	 * throttled I2C probe and poll for changes instead. sfp_i2c_configure()
+	 * has already set i2c_max_block_size; seed i2c_block_size so the
+	 * presence read does not issue a zero-length transfer before the first
+	 * EEPROM read. Seed i2c_present_next to jiffies so the first probe
+	 * happens immediately (a zero value would be in the past relative to
+	 * the negative INITIAL_JIFFIES at boot and delay detection).
+	 *
+	 * A soldered-down module (sff,sff) has no presence signal and is
+	 * genuinely always present, so it keeps the always-present behaviour;
+	 * the I2C probe is gated on the cage type advertising SFP_F_PRESENT.
+	 */
+	if (!sfp->gpio[GPIO_MODDEF0]) {
+		if (sff->gpios & SFP_F_PRESENT) {
+			sfp->get_state = sfp_i2c_get_state;
+			sfp->i2c_block_size = sfp->i2c_max_block_size;
+			sfp->i2c_present_next = jiffies;
+			sfp->need_poll = true;
+		} else {
+			sfp->get_state = sff_gpio_get_state;
+		}
+	}
 
 	device_property_read_u32(&pdev->dev, "maximum-power-milliwatt",
 				 &sfp->max_power_mW);
-- 
2.53.0


