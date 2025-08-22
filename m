Return-Path: <netdev+bounces-215983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 555ABB313DA
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 11:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B13626E20
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179E62F6189;
	Fri, 22 Aug 2025 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jpx7TfgQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mGf/scZ3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jpx7TfgQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mGf/scZ3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519B12F6170
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855318; cv=none; b=D/HRdNlDCL+/jpEixkpFuV5wgqDqKU3VEkF3077aqbYgiDfeOeHEluYvsf2uPNJCfTzObQggZyycsr8+MEVTRe0bdvtlukWlLhBG858pYKPkTF4AYyeh9KI6vMLVISf/FB9QCWN3xMkVOS4q//zB9quLvfk2nkUw9b4iM18aUHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855318; c=relaxed/simple;
	bh=hgYdNHj46jyV1++Z1X9BmJtAZOVALQGUo9Ik4ijBfFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fclT6oYDtfU0QCoKnzyrrH+exgJC7k5brUh56tBsjCXg2tcwnf26adwI5Luea1Kpvq2UA1FS2IXgrk25oHRfozj/oo12X0YD4Wjsksv6i1mBo9eBlOoQqoImANCRdIOpYuxP5ewtco5iYv9ZZ6BUJvQbUAClSzFNisWiY+7HxHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jpx7TfgQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mGf/scZ3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jpx7TfgQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mGf/scZ3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C4F741F38E;
	Fri, 22 Aug 2025 09:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755855309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=w8K4Di+TZqJGeQ9KtefzzYJDRnJQ8lETdLbz+OS9Z8k=;
	b=Jpx7TfgQD3LLv427Zjr/QW2NdVqj+Wb4P4cnkQVBrS5vX5vHuK9VLVLDlsWS8lDPZ3IT3L
	xNe+dSfyh2ziAB+O/qdovrlpW6maVum0GQD/R91IgK6fEkoxTVd1TIYVsxELGK3au5aJst
	N+hfNcylMSdF8vhKRbCuVJ1lFc/zKg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755855309;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=w8K4Di+TZqJGeQ9KtefzzYJDRnJQ8lETdLbz+OS9Z8k=;
	b=mGf/scZ3dMXHqk/8rGPyOrCWWiPWdFZp2Kb6RWmbBa1GGbCBHiyuZ9mbfT20j/mep9cpcU
	yK1k7muhbIpaSoCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755855309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=w8K4Di+TZqJGeQ9KtefzzYJDRnJQ8lETdLbz+OS9Z8k=;
	b=Jpx7TfgQD3LLv427Zjr/QW2NdVqj+Wb4P4cnkQVBrS5vX5vHuK9VLVLDlsWS8lDPZ3IT3L
	xNe+dSfyh2ziAB+O/qdovrlpW6maVum0GQD/R91IgK6fEkoxTVd1TIYVsxELGK3au5aJst
	N+hfNcylMSdF8vhKRbCuVJ1lFc/zKg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755855309;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=w8K4Di+TZqJGeQ9KtefzzYJDRnJQ8lETdLbz+OS9Z8k=;
	b=mGf/scZ3dMXHqk/8rGPyOrCWWiPWdFZp2Kb6RWmbBa1GGbCBHiyuZ9mbfT20j/mep9cpcU
	yK1k7muhbIpaSoCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB6BE139B7;
	Fri, 22 Aug 2025 09:35:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 79ZjL8w5qGihMAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 22 Aug 2025 09:35:08 +0000
From: Stanimir Varbanov <svarbanov@suse.de>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>
Subject: [PATCH v2 0/5] dd ethernet support for RPi5
Date: Fri, 22 Aug 2025 12:34:35 +0300
Message-ID: <20250822093440.53941-1-svarbanov@suse.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,spinics.net:url];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_RCPT(0.00)[dt,netdev];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.30

Hello,

Changes in v2:
 - In 1/5 updates according to review comments (Nicolas)
 - In 1/5 added Fixes tag (Nicolas)
 - Added Reviewed-by and Acked-by tags.

v1 can found at [1].

Comments are welcome!

regards,
~Stan

[1] www.spinics.net/lists/netdev/msg1115266.html

Dave Stevenson (2):
  dt-bindings: net: cdns,macb: Add compatible for Raspberry Pi RP1
  net: cadence: macb: Add support for Raspberry Pi RP1 ethernet
    controller

Stanimir Varbanov (3):
  net: cadence: macb: Set upper 32bits of DMA ring buffer
  arm64: dts: rp1: Add ethernet DT node
  arm64: dts: broadcom: Enable RP1 ethernet for Raspberry Pi 5

 .../devicetree/bindings/net/cdns,macb.yaml     |  1 +
 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts      | 18 ++++++++++++++++++
 arch/arm64/boot/dts/broadcom/rp1-common.dtsi   | 16 ++++++++++++++++
 drivers/net/ethernet/cadence/macb_main.c       | 18 +++++++++++++++++-
 4 files changed, 52 insertions(+), 1 deletion(-)

-- 
2.47.0


