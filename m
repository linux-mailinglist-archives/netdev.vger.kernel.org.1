Return-Path: <netdev+bounces-261254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBANILINoGnbfQQAu9opvQ
	(envelope-from <netdev+bounces-261254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:09:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 250851A329D
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E68E307F21F
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32F0396D3D;
	Thu, 26 Feb 2026 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="LybXDPSi"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1A238F23D
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096797; cv=none; b=TrbAh3nN+zDd4q8igTWJhb+viwkEWuXH0TEGCWm+XTniM0NMky+QIoXrNDh+ERjKmXbGYVuJyR1b7RKWKkMzKJP31osRubNe0A6iLK5zuoaWavuzxxKo0fWqUaB4litjFLHe3onoXkqwsY4ikp31xKXAcoBGbKPAaeMs4oJSFTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096797; c=relaxed/simple;
	bh=dDrmBb634TNCj5r7MMnHj38e/QyEBjVcJp9qlY+JoSs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=q+7upHcb3t5bQM6LkZyu2Jjj+WwWOMciOWGAD5gwXC8AiU3PYsG0dJ3coS6okd9ZuaY5Uzqel/ry98wit9j8ZsvMXG79o4WKYVYe1pvTAWWvLhI9MFb2BE/6l7lNhvulLyzkZrHC2UJ5RuhBIr9zwlWSCgQ6vZMdOoAfYYdYNrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=LybXDPSi; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AD26EA0372;
	Thu, 26 Feb 2026 10:06:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772096792; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=l8B0OMHfLFSuLOWAHyEEI3zopmx9McEFHVfG1MAo93o=;
	b=LybXDPSiltEDPQyuyvu/7aTwmqCt01cicji3WhyvBW/pK/cfTa2n1ahUhmY5MLDjZZnO+U
	T9zvqy/x72zVPP+CXI1GL754K6/2ZTBcfmi8kdbPaGUBcrxClcHi+apNuRDrC28ON0TZqp
	ibOpxdN3sHBiss/pblyxEQyeN4/rlygSBtI4LoiVZlmghid2NHiY/I3fqXJuMEROdHKSSS
	AR0F+xQQRJa3VDP42Lr86azt1kUT3aAMff2RmYI3l4+U50d1Za7UzNbR9kDtN0GJ9edoLW
	huGa1UUdmYYBqLIU8nAAD7RAx6HMhgIR/Z4ilT5hsaw0v+EF5zOWhNiHvLeBXw==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	claudiu.beznea@tuxon.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	nicolas.ferre@microchip.com,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	theo.lebrun@bootlin.com,
	rmk+kernel@armlinux.org.uk,
	phil@raspberrypi.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v4 0/4] net: cadence: macb: add IEEE 802.3az EEE support
Date: Thu, 26 Feb 2026 10:06:04 +0100
Message-Id: <20260226090608.54802-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261254-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:mid,tipi-net.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Queue-Id: 250851A329D
X-Rspamd-Action: no action

Add Energy Efficient Ethernet (IEEE 802.3az) support to the Cadence GEM
(macb) driver using phylink's managed EEE framework. The GEM MAC has
hardware LPI registers but no built-in idle timer, so the driver
implements software-managed TX LPI using a delayed_work timer while
delegating EEE negotiation and ethtool state to phylink.

Changes from v3:
  - Dropped the register-definitions-only patch; LPI counter offsets
    (GEM_RXLPI/RXLPITIME/TXLPI/TXLPITIME) now land in the statistics
    patch, and TXLPIEN + MACB_CAPS_EEE are introduced alongside the TX
    LPI implementation where they are first used. Series is now 4 patches.
  - Add Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com> to all patches.
  - Split chained assignment in macb_tx_lpi_set() (suggested by checkpatch).

Changes from v2:
  - macb_tx_lpi_set() now returns bool indicating whether the register
    value actually changed, avoiding redundant writes.
  - Removed tx_lpi_enabled field from struct macb; LPI state is tracked
    entirely within the spinlock-protected register read/modify/write.
  - macb_tx_lpi_wake() uses the return value of macb_tx_lpi_set() to
    skip the cancel/udelay when TXLPIEN was already clear.
  All changes based on feedback from Russell King.

Changes from v1:
  - Rewrote to use phylink managed EEE (mac_enable_tx_lpi /
    mac_disable_tx_lpi callbacks) instead of the obsolete
    phy_init_eee() approach, as recommended by Russell King.
  - ethtool get_eee/set_eee are now pure phylink passthroughs.
  - Removed all manual EEE state tracking from mac_link_up/down;
    phylink handles the lifecycle.

The series is structured as follows:

  1. LPI statistics: Expose the four hardware EEE counters (RX/TX LPI
     transitions and time) through ethtool -S, accumulated in software
     since they are clear-on-read. Adds register offset definitions
     GEM_RXLPI/RXLPITIME/TXLPI/TXLPITIME (0x270-0x27c).

  2. TX LPI engine: Introduces GEM_TXLPIEN (NCR bit 19) and
     MACB_CAPS_EEE alongside the implementation that uses them.
     phylink mac_enable_tx_lpi / mac_disable_tx_lpi callbacks with a
     delayed_work-based idle timer. LPI entry is deferred 1 second
     after link-up per IEEE 802.3az. Wake before transmit with a
     conservative 50us PHY wake delay (IEEE 802.3az Tw_sys_tx).

  3. ethtool EEE ops: get_eee/set_eee delegating to phylink for PHY
     negotiation and timer management.

  4. RP1 enablement: Set MACB_CAPS_EEE for the Raspberry Pi 5's RP1
     southbridge (Cadence GEM_GXL rev 0x00070109 + BCM54213PE PHY).
     Other GEM variants sharing the same LPI register layout (SAMA5D2,
     SAME70, PIC32CZ) can be enabled once tested.

Tested on Raspberry Pi 5 (1000BASE-T, BCM54213PE PHY, 250ms LPI timer):

  iperf3 throughput (no regression):
    TCP TX: 937.8 Mbit/s (EEE on) vs 937.0 Mbit/s (EEE off)
    TCP RX: 936.5 Mbit/s both

  Latency (ping RTT, small expected increase from LPI wake):
    1s interval:  0.273 ms (EEE on) vs 0.181 ms (EEE off)
    10ms interval: 0.206 ms (EEE on) vs 0.168 ms (EEE off)
    flood ping:   0.200 ms (EEE on) vs 0.156 ms (EEE off)

  LPI counters (ethtool -S, 1s-interval ping, EEE on):
    tx_lpi_transitions: 112
    tx_lpi_time: 15574651

  Zero packet loss across all tests. Also verified with
  ethtool --show-eee / --set-eee and cable unplug/replug cycling.

Nicolai Buchwitz (4):
  net: cadence: macb: add EEE LPI statistics counters
  net: cadence: macb: implement EEE TX LPI support
  net: cadence: macb: add ethtool EEE support
  net: cadence: macb: enable EEE for Raspberry Pi RP1

 drivers/net/ethernet/cadence/macb.h      |  20 ++++
 drivers/net/ethernet/cadence/macb_main.c | 137 ++++++++++++++++++++++-
 2 files changed, 156 insertions(+), 1 deletion(-)

-- 
2.51.0


