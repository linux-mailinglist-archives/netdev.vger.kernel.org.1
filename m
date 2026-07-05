Return-Path: <netdev+bounces-304809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b6B7AlOrSmo/FwEAu9opvQ
	(envelope-from <netdev+bounces-304809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 21:06:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 839B870AD9F
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 21:06:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304809-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304809-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14F243007E07
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 19:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB822F8EB7;
	Sun,  5 Jul 2026 19:06:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from h8.fbrelay.privateemail.com (h8.fbrelay.privateemail.com [162.0.218.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0D3288BA;
	Sun,  5 Jul 2026 19:06:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278414; cv=none; b=Od5wvVbyp/eEvE4yQ8MY4znFc4UH4X12vT+sDvymg79ky1A3uS9DS9zVrcJ+kSw1cNltrzoZETcUAcGiI1uyywhwLUPAE8KnanHzKwez/ZOwPspamCtZMuDMXqHAt3rj/Q277PjJPyVzMWst9oxk8/dhMuHoU4hYgvpD656gZqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278414; c=relaxed/simple;
	bh=lVuLe5DKccN3BSNZnJ5IgF8cRkXFuHfGfiCHhThWpdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cizv50EIJJ+Vq3KMoCiRLNLUXvfE6s0DrrJ3bF7tVfH4xrywdFNtUDNI/MiFPhuhOySc94g//bGQWm2EdfHymLbkDYXpwiYfh+n6JOX4OX1nGdZk9f93onuEr7Ub/31HN1iY9ckZCRhr7/vz+0ZM9EO9E/iLyjlmWNZmDcQULtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=162.0.218.231
Received: from MTA-11-3.privateemail.com (mta-11.privateemail.com [198.54.118.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by h7.fbrelay.privateemail.com (Postfix) with ESMTPSA id 4gtcRZ6CBsz2xC6;
	Sun,  5 Jul 2026 15:06:50 -0400 (EDT)
Received: from mail.privateemail.com (K8S-PROD-WORKER-13 [87.215.145.39])
	by mta-11.privateemail.com (Postfix) with ESMTPA id 4gtcR73L4Lz3hhT9;
	Sun,  5 Jul 2026 15:06:27 -0400 (EDT)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	David Heidelberg <david@ixit.cz>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] nfc: s3fwrn5: support the S3NRN4V variant
Date: Sun,  5 Jul 2026 21:06:18 +0200
Message-ID: <20260705190621.128257-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304809-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:jorijnvdgraaf@catcrafts.net,m:david@ixit.cz,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:conor+dt@kernel.org,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jorijnvdgraaf@catcrafts.net,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	DMARC_NA(0.00)[catcrafts.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jorijnvdgraaf@catcrafts.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 839B870AD9F

This adds support for the Samsung S3NRN4V, an S3FWRN5-family NFC
controller found e.g. on the Fairphone 6 (SM7635), to the s3fwrn5
driver.

The S3NRN4V differs from the already-supported parts in three ways: it
ships with working firmware behind a bootloader protocol the driver
does not implement (so firmware download is skipped), it loads its RF
registers through a different proprietary command (DUAL_OPTION), and it
gates its reference clock through a CLK_REQ line that the driver must
service for the chip to be able to generate the 13.56 MHz poll carrier.

Patch 1 adds the compatible and the clk-req-gpios property to the
binding; patch 2 implements the variant in the driver.

Tested on a Fairphone 6 running a milos-mainline kernel: reader mode polls
and reads ISO 14443-4 tags reliably, both from a fresh boot and across
driver reloads.

Changes in v2:
 - Drop the -i2c bus suffix from the new compatible: it is now plain
   samsung,s3nrn4v (Requested by: Conor Dooley).
 - Close a race in the probe-time CLK_REQ seeding by reading the GPIO
   level under clk_lock, so a stale level can never overwrite a fresher
   state applied by the irq thread (found by the Sashiko AI review of
   v1).
 - Binding completeness: document the PVDD supply (required for the
   S3NRN4V), add an S3NRN4V example exercising the new properties, make
   clk-req-gpios depend on clocks, and describe the CLK_REQ pin in
   hardware terms.
 - Rework the binding commit message: justify the GPIO modelling in
   hardware terms and explain why no fallback compatible applies.
 - Add an s3nrn4v i2c_device_id entry carrying the variant so both
   match paths agree, and describe the of_match_ptr() removal in the
   driver commit message.
 - Reject malformed rfreg blobs (word alignment, single-byte section
   index bound) up front instead of failing at STOP_UPDATE.
 - Handle gpiod_get_value_cansleep() failure in the CLK_REQ sync
   instead of treating an error as "clock off".
v1: https://lore.kernel.org/20260703202601.78563-1-jorijnvdgraaf@catcrafts.net

Jorijn van der Graaf (2):
  dt-bindings: net: nfc: samsung,s3fwrn5: add S3NRN4V and clk-req-gpios
  nfc: s3fwrn5: support the S3NRN4V variant

 .../bindings/net/nfc/samsung,s3fwrn5.yaml     |  65 ++++++++-
 drivers/nfc/s3fwrn5/core.c                    |  40 ++++-
 drivers/nfc/s3fwrn5/i2c.c                     | 138 ++++++++++++++++--
 drivers/nfc/s3fwrn5/nci.c                     | 119 ++++++++++++++-
 drivers/nfc/s3fwrn5/nci.h                     |  32 +++-
 drivers/nfc/s3fwrn5/s3fwrn5.h                 |  14 +-
 drivers/nfc/s3fwrn5/uart.c                    |   2 +-
 7 files changed, 394 insertions(+), 16 deletions(-)


base-commit: 805185b7c7a1069e407b6f7b3bc98e44d415f484
-- 
2.55.0


