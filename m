Return-Path: <netdev+bounces-265929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QECdGZ3Zr2kzdAIAu9opvQ
	(envelope-from <netdev+bounces-265929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:43:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 088FF24779A
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D9C830AB8C5
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A2B29DB65;
	Tue, 10 Mar 2026 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="mIO2iMDW"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3723326461F;
	Tue, 10 Mar 2026 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132138; cv=pass; b=P0aj3B1J7RA/dOrE9mfCDO/rLknWG7Jj5cEdUkvASkjSm12hiuDMSQT65bvd2sYV8oG9r9gCKkhHgIaVaFWnM11eIob25njICHcj5AlNfzftJktU8d2aMKqvPf+TeTU3NNm+w5HERHZr/MPe2MqaA3Aje2I3Nl7yd1VD+sQuWOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132138; c=relaxed/simple;
	bh=O+PtupKhJUb1UiVgJ52/W3koo44cp91XMGRu/Yk+jj8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jQQ0PSxc+yx3ecA5CyTMFM8618RxyRkjrJCKSOOnJYeeruivwDepF6LXT1tB7khh2S+WXfYFw/Dl05hj//WslQjGiyrVkta41aSNyaUwyOgVckBpxIcjfRBjGlpIp14bnxIRkfdhXp9VNZ4NdJnyxhPU0B0Xki3F4MZdrjT3sps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=mIO2iMDW; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1773132104; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Qd3h3KFo8CtJ0BcQ9PmwEuSZGAFvxHDPBUX+IuoAi5TPTveJMtETpmnpDzBpmfdGI9S7uQXxAMF/yLZStUfAEPuHmXgt8DO7uxACbXvdhEg4o7WkqzcJsikwcFHoTZxnC0YBZgKzRTxhjeJf6jxEu3XfB4nTlUYb20BN9PJLjTs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773132104; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6QAKNaYZQ3oPbyfRehX2Ps756j69nJ1JrR6pbMmlzHI=; 
	b=HYTsmRQTLlpE83eSqdybsp9GvqEVLDH7c01y1e30TPtbgarHQLNURfLP3TeuTP7KjXpE7PGTzKtwx06bVkr87hYe9yzAbvvSAENIa1Caxz4Pt1kFVx+Hb8vfMsQVKyiQ9btrdTk4VRXVnCfXUUzNfeN90mzPkYd23kFNgFbmrXU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773132104;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=6QAKNaYZQ3oPbyfRehX2Ps756j69nJ1JrR6pbMmlzHI=;
	b=mIO2iMDWPi71XBeTyfVNIkwLFXY1LkkYQf17cONxWCj/t9GAPD85ay3yKKMETCw5
	SLEMZTa0tq1fvD4znvgQu77PhX+vw3CVZ6NW0Acij2pfHbDF8bo+gIpivAsKMD1ZDI2
	PkaYMQ41mXhKcT2YsYLJoSLP4t/1EsmKhD31WHfY=
Received: by mx.zohomail.com with SMTPS id 1773132101727222.80993575966113;
	Tue, 10 Mar 2026 01:41:41 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH RFC 0/8] clk: sunxi-ng: Add support for Allwinner A733 CCU
 and PRCM
Date: Tue, 10 Mar 2026 16:33:53 +0800
Message-Id: <20260310-a733-clk-v1-0-36b4e9b24457@pigmoral.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIKGbaG5srJuck61rkGKSlmxgkGiZZpmsBFReUJSallkBNipaKcjNWSm
 2thYAxo8A6F8AAAA=
X-Change-ID: 20260202-a733-clk-0d4fc00a9f9c
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773132092; l=3110;
 i=junhui.liu@pigmoral.tech; s=20251228; h=from:subject:message-id;
 bh=O+PtupKhJUb1UiVgJ52/W3koo44cp91XMGRu/Yk+jj8=;
 b=LCoE9uot8A3TIPpldMu+FwiyMrSb7oaPhzcG1a5yrSDDfPFX9wLrX2xjT2hzw2TAqEHJJecU0
 jGR11DR8AEbA5rykLaol+JTtYu8QPfSVi0wz5T9AXt5NwJoGI4cVTZb
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=3vU0qIPJAH8blXmLyqBhKx+nLOjcLwwYhZXelEpw7h4=
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 088FF24779A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[pigmoral.tech:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,gmail.com,sholland.org,pengutronix.de,pigmoral.tech,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pigmoral.tech];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265929-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[junhui.liu@pigmoral.tech,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[pigmoral.tech:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pigmoral.tech:dkim,pigmoral.tech:email,pigmoral.tech:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add support for the main CCU and the PRCM module (R-CCU) found in the
Allwinner A733 SoC. The clock architecture of the A733 is an evolution
of the previous A523 design but introduces several significant changes.

One of the key changes is the introduction of a "pll-ref" clock that
normalizes the physical oscillator frequency (which can be 19.2MHz,
24MHz, or 26MHz) into a consistent 24MHz reference for the entire clock
tree. Additionally, while the A733 inherits many module clock structures
from the A523, the MCU_CCU has been removed, and the overall clock tree
has been expanded to support more new functional units.

Also update the sunxi-ng SDM (Sigma-Delta Modulation) helper to support
a new dual-pattern register design. On the A733, the SDM enable bit has
been moved from the main PLL register to a second pattern register
(PATTERN1). The driver is updated to handle this register layout to
ensure accurate frequency synthesis for "pll-audio0".

This is marked as RFC because the parent clocks for several instances in
the main CCU are difficult to determine as the user manual provides
limited information on their specific clock sources. In these cases, the
implementation follows vendor practices and previous SoC designs,
generally defaulting to "hosc" where documentation is lacking. In
contrast, the bus clock gates in the PRCM (R-CCU) are explicitly defined
based on the Memory Map in the manual, which clearly associates each
module with its respective bus. Feedback or insights on these specific
clock parents would be greatly appreciated.

This functionally relies on the RTC series for the A733 SoC [1].

Link: https://lore.kernel.org/all/20260121-a733-rtc-v1-0-d359437f23a7@pigmoral.tech/ [1]

---
Junhui Liu (8):
      dt-bindings: clk: sun60i-a733-ccu: Add allwinner A733 support
      clk: sunxi-ng: sdm: Add dual patterns support
      clk: sunxi-ng: a733: Add PRCM CCU
      clk: sunxi-ng: a733: Add PLL clocks support
      clk: sunxi-ng: a733: Add bus clocks support
      clk: sunxi-ng: a733: Add mod clocks support
      clk: sunxi-ng: a733: Add bus clock gates
      clk: sunxi-ng: a733: Add reset lines

 .../bindings/clock/allwinner,sun60i-a733-ccu.yaml  |  107 +
 drivers/clk/sunxi-ng/Kconfig                       |   10 +
 drivers/clk/sunxi-ng/Makefile                      |    4 +
 drivers/clk/sunxi-ng/ccu-sun60i-a733-r.c           |  276 +++
 drivers/clk/sunxi-ng/ccu-sun60i-a733.c             | 2375 ++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_sdm.c                     |   51 +-
 drivers/clk/sunxi-ng/ccu_sdm.h                     |   32 +-
 include/dt-bindings/clock/sun60i-a733-ccu.h        |  289 +++
 include/dt-bindings/clock/sun60i-a733-r-ccu.h      |   39 +
 include/dt-bindings/reset/sun60i-a733-ccu.h        |  131 ++
 include/dt-bindings/reset/sun60i-a733-r-ccu.h      |   23 +
 11 files changed, 3311 insertions(+), 26 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260202-a733-clk-0d4fc00a9f9c

Best regards,
-- 
Junhui Liu <junhui.liu@pigmoral.tech>


