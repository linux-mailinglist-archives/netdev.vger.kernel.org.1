Return-Path: <netdev+bounces-295300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TMQGNhqbIWouJwEAu9opvQ
	(envelope-from <netdev+bounces-295300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:34:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EF76417BB
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:34:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295300-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295300-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=hotmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6853E3084406
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 15:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F69334C1F;
	Thu,  4 Jun 2026 15:16:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373B83321A1
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 15:16:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586178; cv=none; b=d3pOOTWbXbZG5KxzgcVyRP/No+kaNt5IdvIlsEnXI9/0TRQ8pjPU0q2ca9CPKkcfFkyVarMoO0uMzul9oSECFFZ36AOvYhmQu89W7BkV6PwXK4pSekHISHxx8kSc36VPSTF003XP/+2ImI6gbIuK5UhKmAqN6xkzb0NvY0dnzhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586178; c=relaxed/simple;
	bh=qp3uSgXMXi3JidF0cUk72uprgKSiEqRV6mAUrfSXZNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WoVzlXm6oFF41Ta3IzjnNFFifE+HqbiKEp6pfQpTp5+49XFoYwU0gafrrymwfXTyONsOy0+VQe7h88WNopaV45Gl/HAdLFg93QEvD2UZwgKcU0rCQQY8bgueIdr0eUusvQi/fsraIRaxo9ex2th/5rTwv78P5UrHqzgwrruvJ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.174
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4854166e1efso750782b6e.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 08:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780586175; x=1781190975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KsIpI/Vh8UZ3BGn8UGQQwPxQbsfP6AVGDXkTgZRzCw=;
        b=RkoK4cdTAS4Z37JkINUo1yyMDdla3OL1Z06zTJU+6J7frGY3P9fYj6cU1D8qLZHqT6
         Dnv33OFx6xnX+UzbnOtbwIw9ZMhhGEELF8MAf+ucoM/C75BjJ/0rcor4fzuXlLSDEwXM
         NBSarhRLNRTtvhkL3iYXW8eu6HvP2EDtU7UixvLPNS+8yT/nscMvFd90MU7YdZgqNhIA
         /GrenzDfDCSlVLGlGH9xuxbob8OYs/q2BPceJtSGDCfx8k380bpqF3s4nvc0vzYznFQ1
         amvn6MXnQVW/FPsd+TAOtEEnE9naPDBgQPKAtjEGTYEqk/4GI9nfNX11cHVxaXMxL9nm
         aXUg==
X-Gm-Message-State: AOJu0YywCOg7RBqIwxNWA25+WYWgvWlm4u1RVX7+vIiWKYT5kSSCESVa
	UOPo4cxb22hNFz+4t0/7PTeFbW/N+xAuatzELtpvTfEVCSB8lZdHopCK
X-Gm-Gg: Acq92OGbfqZ1uP5Euh1cR0wXIRlmldwyt2ubw2DRbc1t3zfxiEAFuPn9g2/z7xbgakY
	823quOkEFJeyL2WBMMCou7KNvjp3pMuSa9WBdqnQBM8SXiTHxmxnNXFseSrAzMKWIA2RLxHbY6v
	9fOtHh9nYvbOMIJAegZ7XNG4jKJheDOROEYgA3/8bdWclidwgMZKFAAUoP0vTZZquBVygSAf2NX
	9LXI6cV8VgZCUp9WTIurcDwjqUiaQT1bY+gB0LM88g5g9VQY3QBUG2Im304UI8p2dKnSCdRzwRf
	3ceaH0msPsVIgXIe+QeZK1h8fLeAsR9dFh4ETHsf/2Rzwq76Xodyl4cAwJzSvGDkMeB/dsLQfW8
	yJycguRvJmdXpTbQLginKii8T+Mbsg99Z8w0zTvSLN5/+HsI3Eks3EZFz6Vy9pr9FB7w/DTRgPp
	//KWnvhZcJwlmbZqx3pX60L8en2wor/+hCWEa+ZXkVXZSkxL6O1WestzupBWxZ3KDWw3W7Q9l/R
	Xk1U1tVqjrmIR+v95gTIlttADK/XyIt
X-Received: by 2002:a05:6808:2225:b0:47a:ae7:b604 with SMTP id 5614622812f47-4865aa88e9emr5352994b6e.21.1780586175042;
        Thu, 04 Jun 2026 08:16:15 -0700 (PDT)
Received: from lxc-docker-tertiary.local (pool-108-45-26-115.washdc.fios.verizon.net. [108.45.26.115])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c08234sm54243621cf.6.2026.06.04.08.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:16:14 -0700 (PDT)
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
Subject: [PATCH net-next v2] net: phy: sfp: detect presence via I2C when no MOD_DEF0 GPIO
Date: Thu,  4 Jun 2026 15:16:14 +0000
Message-ID: <20260604151614.3310544-1-gregspatrick@hotmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
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
	TAGGED_FROM(0.00)[bounces-295300-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[hotmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5EF76417BB

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
consumed by TX_DISABLE, and there is no RTL8231).

For such an SFP cage, derive presence from a throttled single-byte I2C read
of the module EEPROM instead: an ACK asserts SFP_F_PRESENT, two consecutive
failures clear it (to ride out a transient error on a live module). The
existing poll then emits SFP_E_INSERT / SFP_E_REMOVE normally, giving
working hot-plug and silencing the boot-time -EIO spam on empty cages.

A soldered-down module (compatible "sff,sff") has no presence signal and is
genuinely always present, so it continues to use sff_gpio_get_state(); the
new path is gated on the cage type advertising SFP_F_PRESENT.

Signed-off-by: Greg Patrick <gregspatrick@hotmail.com>
---
v2:
 - Keep sff_gpio_get_state() and gate the new I2C-probe presence on the
   cage advertising SFP_F_PRESENT (an "sff,sfp" cage), so a soldered
   "sff,sff" module keeps its always-present behaviour. (Andrew Lunn)
 - Reword the commit message to state precisely that no presence signal
   reaches a readable input on the affected board, and that the cage bus
   is the RTL9303 SMBus master. (Andrew Lunn)
 - On using a 0-byte read like i2cdetect: not available on this board --
   the cage master advertises only I2C_FUNC_SMBUS_BYTE_DATA (no
   I2C_FUNC_I2C, no SMBus Quick Command), so sfp_i2c_configure() selects
   sfp_smbus_byte_read() and a 1-byte read is the lightest presence
   primitive; it also works through sfp->read on both raw-I2C and
   SMBus-only adapters, whereas a zero-length transfer does not. (Andrew Lunn)

v1: https://lore.kernel.org/netdev/20260602235528.2795028-1-gregspatrick@hotmail.com/

 drivers/net/phy/sfp.c | 77 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 376c705a9..056bbe6de 100644
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
@@ -863,6 +875,44 @@ static int sfp_read(struct sfp *sfp, bool a2, u8 addr, void *buf, size_t len)
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
@@ -3168,9 +3218,30 @@ static int sfp_probe(struct platform_device *pdev)
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


