Return-Path: <netdev+bounces-298368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mCl1IvMuK2oy3wMAu9opvQ
	(envelope-from <netdev+bounces-298368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:56:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD6A67581C
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:56:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=fYVkFY5g;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298368-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298368-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EF0732F9EDE
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8409F38A722;
	Thu, 11 Jun 2026 21:55:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55174382393;
	Thu, 11 Jun 2026 21:55:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781214953; cv=none; b=PbVIx+xYC76T48uTHd8/f65HmKAn6Aggd4bB+gXlzsC1eVABGc42+cTL6a+hUmc/Tcrm0uJFOvM4HdhYk9W1Gsl9LBgf84y7aVQAqx9piptKgWmGc+UzsQEqdVusC+ugGKjPzTCjHzhFYiruA27t7fARatPcph8XACWj06uIZFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781214953; c=relaxed/simple;
	bh=G8O/fgkg40yzWQsZV7+qSg2DX9SUdeFeRtf+xvaV66c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JGHFg0z4c/Hi/qb/gEO2oT+gHE9N4Hu96pvRM+p+veWvIzvPDKxAcGrwft1BwbdYynbnusE8i4gTTwrt1K0ujv/fU26810uIXwoTqT4X2Z69CoRCR4lpAQNLB2iMH1yS4XcK2tKuPci2KGXFUtXjQLzMigiQNO7fRv5GVbeciXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYVkFY5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1B6DC2BCB9;
	Thu, 11 Jun 2026 21:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781214953;
	bh=G8O/fgkg40yzWQsZV7+qSg2DX9SUdeFeRtf+xvaV66c=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=fYVkFY5ghFjUVtNKLogRoNOMEobOvXQn1CFFGTlwIqHPE4zmKfkdnn45ChQTezzSI
	 +QvyE8p9cGYXMAaULInwTOFZqdMzhY4Xii0ykasbMC8gf7xdR1LS1wAZ9ZiFy3qrzf
	 H4F+6igkWb8Tr7T7afFMqRWzPoQ84v0cC9nBR1zzOjFvMSq81Fuk/vA0AJaGuk1Ncn
	 rs80PAA8Lav8gHJet1Vh0xtMq4yinCkrqzDt8M2eBGWaiIkB7yNCOStkoOOVbUW3+9
	 QrPVt0K4j3m3ctcgXgtWuQQdENye0boZC653AYNsC6KIfL2FGLRKW9SQ3SXwjEG6SO
	 G26tnBE7gN7RA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7621CD98CC;
	Thu, 11 Jun 2026 21:55:52 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Subject: [PATCH net v5 0/4] MAC-PHY interrupt changed to level triggered
 interrupt
Date: Thu, 11 Jun 2026 14:55:37 -0700
Message-Id: <20260611-level-trigger-v5-0-4533a9e85ce2@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANouK2oC/12NywqDMBREf0Xuuil5+Oyq/1G6iOaqFzQpiYQW8
 d8bsmpdzgznzA4BPWGAW7GDx0iBnE2huhQwzNpOyMikDJLLmldKsAUjLmzzNE3oWTv0QrdKj1y
 VkJiXx5He2fcAixs8UzlT2Jz/5I+o8pR1NT/romKcGd0obLhId/LubMCVroNbsyqWv3h3xsuE1
 6NqO90bI7p//DiOLwZj3WLvAAAA
X-Change-ID: 20260531-level-trigger-8cb1a83af034
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 devicetree@vger.kernel.org, 
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781214947; l=2947;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=G8O/fgkg40yzWQsZV7+qSg2DX9SUdeFeRtf+xvaV66c=;
 b=Q7Ins9Yrrl0dk8bb2U2sSVW/lnT974k5lqVNm7Gn8eZR3FMWqKX/E4xuR37i5FbXrecRpOjzT
 K6VyCS9kQOEDM+fBFTje55mc0+k3LiF1fY4xnZ4vLq3z+V1LREywOWH
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
	TAGGED_FROM(0.00)[bounces-298368-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
	FORGED_RECIPIENTS(0.00)[m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:pier.beruto@onsemi.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:conor.dooley@microchip.com,m:devicetree@vger.kernel.org,m:Parthiban.Veerasooran@microchip.com,m:Selvamani.Rajagopal@onsemi.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,onsemi.com:replyto,onsemi.com:email,onsemi.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0CD6A67581C

According to OPEN Alliance 10BASE-T1x MAC-PHY Serial Interface
specification, MAC-PHY interrupt is "active low, level triggered".
The specification mentions about the conditions in which the IRQ
is asserted and deasserted.

Bug is inadvertently introduced by treating the IRQ in the OA TC6
framework driver and in dt-binding YAML file as edge triggered.

With the changes to use level triggered interrupt, use of threaded
irq is more efficient than the current method that has interrupt hander
working with work queue.

This change of interrupt handler mechanism exposed couple of race
conditions due to the fact that interrupts were not masked on protocol
error. And pointers were not initialized with null after skbs are freed.

Changes are done in two files
 - OA TC6 framework Ethernet driver
 - YAML file for the vendor that already uses OA TC6 framework.

Maintainer for this driver is already informed and aware of these
changes. Testing for these changes was done in onsemi's setup and
found to be working.

Changes in v5:
  - Removed the extraneous FCS that came with the frame before passing
    to the stack
  - Base commit was upadted on few patches to ensure that it is pointing
    to the correct commit ID.
  - Commit messages have been updated to be more descriptive and
    gives more detail now.
  - Couple of race conditions pointed out by AI review is fixed.

- Link to v4: https://lore.kernel.org/r/20260609-level-trigger-v4-0-6f389abdd192@onsemi.com

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

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
Selvamani Rajagopal (4):
      net: ethernet: oa_tc6: Interrupt is active low, level triggered.
      net: ethernet: oa_tc6: mdiobus->parent initialized with NULL
      net: ethernet: oa_tc6: Remove FCS size in RX frame
      dt-bindings: net: updated interrupt type to be active low, level triggered

 .../devicetree/bindings/net/microchip,lan8650.yaml |   2 +-
 drivers/net/ethernet/oa_tc6.c                      | 140 +++++++++++++--------
 2 files changed, 89 insertions(+), 53 deletions(-)
---
base-commit: 22e2036479cb77df6281ebbd376ae6c330774790
change-id: 20260531-level-trigger-8cb1a83af034

Best regards,
--  
Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>



