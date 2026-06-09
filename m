Return-Path: <netdev+bounces-297256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pif3N3ZvKGpfEgMAu9opvQ
	(envelope-from <netdev+bounces-297256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:54:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51790663EEF
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:54:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=h6llugOy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297256-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297256-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03B1A30210E1
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 19:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914E44A1393;
	Tue,  9 Jun 2026 19:50:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011CE41166A;
	Tue,  9 Jun 2026 19:50:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034640; cv=none; b=Pyp98Cis3712PfSJrSAl9ck46K9ceWu4DS0b0vbPBI/RwQ3sj81jAj8bSatNRmAwPrE7TMHpoqO+65cc+cYE+BZvJptojjhg+jGqw2aH0w0H1fcKP1RbcpPfH0ls+VXYYULK+GzJt1GkBx82mGRqCELRLfJirBdhVsHKFBS6qHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034640; c=relaxed/simple;
	bh=fEc6RgFqgArsWG6l+smx1XCQosDlspRNYDFL91PwLD0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ISusHZduAHSU/WSLhls9qR0hj+lcqFs8RnxiWb/HnjPJlmKUsRdxTF9QIRvTQPC6w/KLW8+xl9hbRXKFWKLVsFAdXfGKFOrKvvJ9Zs9TFOrzGZjjGB0Q5Wmq9KEnQLuHj7dZcL2X4SfvNZjEzQj27L0BN9L7NKR7V5kL8sc+PYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6llugOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61D44C2BCB9;
	Tue,  9 Jun 2026 19:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781034639;
	bh=fEc6RgFqgArsWG6l+smx1XCQosDlspRNYDFL91PwLD0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=h6llugOybMri4FBoedAzCaF3QxhQ38AXq9WowDReZrQoJWR9FGB6672SE3kRFnm08
	 vh209GK4jMhn7jk//JGlka+MiqoeIWS2r067MY6LDASLqgdmiCj7xqA3l3f69VV+st
	 EejXA7C3BeJ5i+E1HpwcgNAVAeafUdgx5X2E3BOXobtVaDdz1VX2QIxiHuyIzZALgy
	 Y0ljZPclZuNdp7a8I/ZU9nzN8HqypQVBtXu/0Fa/4ft107jrzGFvinUAx5S0MR5MNB
	 KzAbmS9IV1cJWZiv/WYMypQnKNArik0tkWvSjsOcRS4Kge3B9YoQwBmK/bIu3Lg5yQ
	 r/3q4AfmB2q6Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42522CD8CB2;
	Tue,  9 Jun 2026 19:50:39 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Subject: [PATCH net v4 0/4] MAC-PHY interrupt changed to level triggered
 interrupt
Date: Tue, 09 Jun 2026 12:50:23 -0700
Message-Id: <20260609-level-trigger-v4-0-6f389abdd192@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH9uKGoC/12NywrDIBREfyXcdS0+0iR01f8oWVhzYy4kWlSkJ
 fjvFZddzgxzzgkRA2GEe3dCwEyRvKuhv3RgNu0sMlpqBsnlwG9KsB0z7iwFshYDm8xL6Enplas
 e6ucdcKVP4z3BYYK5lhvF5MO3ObJqU8MN/B+XFeNs0aPCkYuqkw/vIh50Nf6AuZTyA7OOn7+wA
 AAA
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>, 
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 devicetree@vger.kernel.org, Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781034634; l=2779;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=fEc6RgFqgArsWG6l+smx1XCQosDlspRNYDFL91PwLD0=;
 b=wrNsvzyOigtKx2OTV9speqae9RVqFkm2T1m5PXBBjQ6ub6iumIQb78jQrnNSTDwsxFOrDyWW9
 EV6Xl8JpGg2Atk8rK6xRLfCR0bzXl0RCB5WN9x+A0iJfaJAtDZpBTqD
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297256-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
	FORGED_RECIPIENTS(0.00)[m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Parthiban.Veerasooran@microchip.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:conor.dooley@microchip.com,m:devicetree@vger.kernel.org,m:pier.beruto@onsemi.com,m:Selvamani.Rajagopal@onsemi.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[Selvamani.Rajagopal@onsemi.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,onsemi.com:replyto,onsemi.com:email,onsemi.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:email,microchip.com:email,davemloft.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51790663EEF

According to OPEN Alliance 10BASE-T1x MAC-PHY Serial Interface
specification, MAC-PHY interrupt is "active low, level triggered".
The specification mentions about the conditions in which the IRQ
is asserted and deasserted.

Bug is inadvertently introduced by treating the IRQ in the OA TC6
framework driver and in dt-binding YAML file as edge triggered.

Changes are done in two files
 - OA TC6 framework Ethernet driver
 - YAML file for the vendor that already uses OA TC6 framework.

Maintainer for this driver is already informed and aware of these
changes. Testing for these changes was done in onsemi's setup and
found to be working.

To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: Piergiorgio Beruto <pier.beruto@onsemi.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>
Cc: devicetree@vger.kernel.org
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Changes in v4:

- IRQ handler is changed to interrupt handler + wake up thread
  to interrupt handler + threaded irq. Threaded irq mechanism
  is better suited for level triggered interrupt. Because it can
  keep the interrupt disabled until interrupting conditions are 
  handled by a handler thread.
- SPI data handling function is called again on EAGAIN error code
  as it indicates RX buffer overflow error, which requires draining
  the bad data chunks.
 
  - Changed wakeup thread to threaded IRQ 
  - RX buffer overflow is handled before threaded irq returns

- Link to v3: https://lore.kernel.org/r/20260601-level-trigger-v3-0-da73e7010532@onsemi.com

---
Selvamani Rajagopal (4):
      net: ethernet: oa_tc6: Interrupt is active low, level triggered.
      net: ethernet: oa_tc6: No return on rx buffer overflow error
      net: ethernet: oa_tc6: mdiobus->parent initialized with NULL
      dt-bindings: net: updated interrupt type to be active low, level triggered

 .../devicetree/bindings/net/microchip,lan8650.yaml |  2 +-
 drivers/net/ethernet/oa_tc6.c                      | 66 +++++++---------------
 2 files changed, 21 insertions(+), 47 deletions(-)
---
base-commit: 0aa05daef7848a5ac11158949dc73cd741995dc1
change-id: 20260531-level-trigger-8cb1a83af034

Best regards,
-- 
Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>



