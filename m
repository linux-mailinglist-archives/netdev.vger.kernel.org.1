Return-Path: <netdev+bounces-304664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EuN/FjEdSGrYmQAAu9opvQ
	(envelope-from <netdev+bounces-304664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 22:36:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C3F705824
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 22:36:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304664-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304664-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABAE33027698
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 20:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8217934FF79;
	Fri,  3 Jul 2026 20:35:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from h8.fbrelay.privateemail.com (h8.fbrelay.privateemail.com [162.0.218.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C806346FA0;
	Fri,  3 Jul 2026 20:35:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783110931; cv=none; b=kM+fIA2fmQIeH8ISddsnt/bPP3mVdW1vfTKlARLWfB7kZ3BmmWvpDhCFkx6x+widSPyku5tgnLJRwwCDSWObYHhk5iufiruX7V7tJpulC3uijAsq4Ny99Oh7USbQMjbx7R9/tO4/bIQ9lUQkmqdsV4edkDdVWqH8bjoajCN0HGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783110931; c=relaxed/simple;
	bh=UTlCBVva1207VYobcU/wMQX8vMFYMo1s5bO+OZW/kD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NemebIb5gParMRQiP4wkYQYSuBOrQsMJYijskvZxGir+/hF7S0ToH+Ab/5i+urxOUW7q9ucot3HHD6n0W4PR58Wgwf60X4zmMwb1HvxYimOlOOftHaM/DzTqwDNLJ8TcCOc4+sWFIzBk94ar2erT279ivSEE4MbiFU73/YlSa7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=162.0.218.231
Received: from MTA-14-3.privateemail.com (mta-14-1.privateemail.com [198.54.122.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by h7.fbrelay.privateemail.com (Postfix) with ESMTPSA id 4gsQJS37Ppz2xDR;
	Fri,  3 Jul 2026 16:26:32 -0400 (EDT)
Received: from mail.privateemail.com (K8S-PROD-WORKER-02 [87.215.145.39])
	by mta-14.privateemail.com (Postfix) with ESMTPA id 4gsQJ02STWz3hhTD;
	Fri,  3 Jul 2026 16:26:08 -0400 (EDT)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: David Heidelberg <david@ixit.cz>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Subject: [PATCH net-next 0/2] nfc: s3fwrn5: support the S3NRN4V variant
Date: Fri,  3 Jul 2026 22:25:59 +0200
Message-ID: <20260703202601.78563-1-jorijnvdgraaf@catcrafts.net>
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
	TAGGED_FROM(0.00)[bounces-304664-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:david@ixit.cz,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:conor+dt@kernel.org,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jorijnvdgraaf@catcrafts.net,m:andrew@lunn.ch,m:conor@kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,catcrafts.net:mid,catcrafts.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9C3F705824

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

Tested on a Fairphone 6 running a mainline kernel: reader mode polls
and reads ISO 14443-4 tags reliably, both from a fresh boot and across
driver reloads. Existing S3FWRN5/S3FWRN82 setups are unaffected.

Jorijn van der Graaf (2):
  dt-bindings: net: nfc: samsung,s3fwrn5: add S3NRN4V and clk-req-gpios
  nfc: s3fwrn5: support the S3NRN4V variant

 .../bindings/net/nfc/samsung,s3fwrn5.yaml     |  23 +++-
 drivers/nfc/s3fwrn5/core.c                    |  40 +++++-
 drivers/nfc/s3fwrn5/i2c.c                     | 114 ++++++++++++++++--
 drivers/nfc/s3fwrn5/nci.c                     | 111 ++++++++++++++++-
 drivers/nfc/s3fwrn5/nci.h                     |  32 ++++-
 drivers/nfc/s3fwrn5/s3fwrn5.h                 |  14 ++-
 drivers/nfc/s3fwrn5/uart.c                    |   2 +-
 7 files changed, 321 insertions(+), 15 deletions(-)

base-commit: 805185b7c7a1069e407b6f7b3bc98e44d415f484
-- 
2.55.0


