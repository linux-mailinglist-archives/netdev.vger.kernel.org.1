Return-Path: <netdev+bounces-259476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKXcJBkdl2ktuwIAu9opvQ
	(envelope-from <netdev+bounces-259476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:24:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B4815F72E
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E76FC3015884
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 14:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2CC33A9FA;
	Thu, 19 Feb 2026 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCpXpIpb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C4A17ADE0
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511062; cv=none; b=QdFg/84986UrQpHx0XqFeDhDNE4lU/ZTG1eucBD3SF/G0m9916F+vtRvNJF4EcnalSnAH8tG4dRNsMFoo4PDT3t4uo8Ag0kVXBUVZKuu0YQrfakqr6NOLeWnft3d//+TwSE100QrLZUVM9293QoPiLGxq/+nuIjSwgInTG16Du8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511062; c=relaxed/simple;
	bh=Yp73P+rId257jRD8Fs1WrD4V+WNSe47EekE0NHyfNFQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bzPrnGsxi2ORSOjB3/yXp/LBLavZV+GQeQ5ygk+HUBnBMnq75HvMwqlqTt2FM7R6JNMXYZqv6XrsZAY/7RiFLIFjOXDG5vbYpLbZSvPqQhnTvfgyPMmqRBdl7vD6Oy7BMOTwKG5i7zDV8GFcmMdZzsNnbSLHUomlSSPXSYHWo2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCpXpIpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA9FC4CEF7;
	Thu, 19 Feb 2026 14:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771511062;
	bh=Yp73P+rId257jRD8Fs1WrD4V+WNSe47EekE0NHyfNFQ=;
	h=From:Subject:Date:To:Cc:From;
	b=nCpXpIpbKTcqzggcyd6WFGf8bq6jCzDbkG2hLi55Yr/BbCtKVoiV1hBuhDlTSaXi7
	 5sjcP9M+2yxUVUtVNwYFJNBR3rFGPUsy8rAuGXIjd4H0D45DJKebaCvgADQSPg9L9C
	 N5Dd4ui1mqa2PLF2OeckGGh1Jupz9heFfXf2Y6o1cxoYL9YAkApskACMUiXr3Qs8Ur
	 DPs/iPd36cYp4FS1JGT35UqXovxGC/faRDwChGu5wRdDCeG3zjD3Oxms3SNCTAYaaN
	 FTOn1/fFqcqxadK6sk+XJ3MIRV/gvGWZOkPFAwWs6dyGtyHH4BrKX21M5YXYdGcEwK
	 U3UHdzvSQo7jg==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH net v3 0/5] net: dsa: ks8995: Post-move fixes
Date: Thu, 19 Feb 2026 15:24:16 +0100
Message-Id: <20260219-ks8995-fixups-v3-0-a7fc63fe1916@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw7CIBREf6W5azG8quDK/zAusFxaUkMbqETT9
 N8lrNTE5czknFkhYfSY4NSsEDH75KdQgtg10A0m9Ei8LRk45QfKmCJjUlq3xPnnY05EScdb0wk
 n6REKM0csS/VdIOAC11IOPi1TfNWPzOr0R5cZoYRRI7VwVAhtzyPGgPf9FPuqyvwT1784L7hWN
 0uFNNQy/oVv2/YG1rSwcO8AAAA=
X-Change-ID: 20260118-ks8995-fixups-84f25ac3f407
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259476-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,microchip.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 02B4815F72E
X-Rspamd-Action: no action

This fixes some glearing issues in the Micrel KS8995 driver
pointed out by Vladimir.

This patch series implements some required functionality
and strips the driver down to just KS8995 deeming the other
"micrel" variants to be actually handled by the Microchip
KSZ driver.

If the KS8995 should actually *also* be managed by the Microchip
driver and this driver deleted remains to be seen. It is clearly
the origin chip for that hardware: it is very close to the
"KSZ8 family" but there are differences.

It definitely has a different custom tag format for proper DSA
tagging, but I have implemented that: I now have to figure out
whether to do that on top of this driver or the KSZ driver before
continuing.

In the meantime, this patch series makes the situation better.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Changes in v3:
- Re-tag the series for net since they are fixes.
- Implement mutual exclusion between .remove() and .shutdown()
  as found by the AI reviewer.
- Fix a typo in the patch dropping the KSZ chips support, 8955->8995,
  found by the AI reviewer.
- Add fallback compatibles for the deleted chips to the KSZ
  SPI driver.
- Implement port isolation.
- Link to v2: https://lore.kernel.org/r/20260119-ks8995-fixups-v2-0-98bd034a0d12@kernel.org

Changes in v2:
- Do port_bitmask in another way and fix a bug where BIT(port_bitmask)
  was used instead of just port_bitmask.
- Link to v1: https://lore.kernel.org/r/20260118-ks8995-fixups-v1-0-10a493f0339d@kernel.org

---
Linus Walleij (5):
      net: dsa: ks8995: Add shutdown callback
      net: dsa: microchip: Add fallback Micrel compatibles
      net: dsa: ks8955: Delete KSZ8864 and KSZ8795 support
      net: dsa: ks8995: Add stub bridge join/leave
      net: dsa: ks8995: Implement port isolation

 drivers/net/dsa/ks8995.c            | 325 +++++++++++++++++++++---------------
 drivers/net/dsa/microchip/ksz_spi.c |  15 ++
 2 files changed, 208 insertions(+), 132 deletions(-)
---
base-commit: 3841d04322c568c47d1effc869fd79fd6c967bd0
change-id: 20260118-ks8995-fixups-84f25ac3f407

Best regards,
-- 
Linus Walleij <linusw@kernel.org>


