Return-Path: <netdev+bounces-271956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGgfFpEGxWnZ5gQAu9opvQ
	(envelope-from <netdev+bounces-271956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:12:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE5E3330FE
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C9903197E36
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C543CF05C;
	Thu, 26 Mar 2026 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLY0P4ju"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA993CF052
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 09:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519057; cv=none; b=aJcDjNkngXgBudcbvjMQJHPa8TD6ONxwv/hj4VSOkKlRRm03NWOesTyTcD1PKt53Vxgff3BBr/2LP+rxiES9be6uKPeeLSezGikNiXkKopCpwuy397gesvoajHPXTcpotj6D6CzSNqB/7uOLLgHy4X6AFnJ6CXAr4GHM7tRiWAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519057; c=relaxed/simple;
	bh=MR4kj0xpn91eNGWeC5rwKgyiy01MtgWWFZqZWQNGIfk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kObyr9e2c9TYR4OYbO7lgVHue1mhyM6Tb6dXxiNd+Vxmb/D0wZ+oKDqlww8nooLw+dw/llHPYO6dHbLDE2jgLCviHhwQ8Pcsdi+FfGLJ+2byfIJkIlnBMTPq5W/G5LeHOdjlRMwqzw5isF6iRVbW6VSilwDAD4gGu/o2EdaBTHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLY0P4ju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC62C116C6;
	Thu, 26 Mar 2026 09:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774519056;
	bh=MR4kj0xpn91eNGWeC5rwKgyiy01MtgWWFZqZWQNGIfk=;
	h=From:Subject:Date:To:Cc:From;
	b=YLY0P4juzrZ/hNTdPESmQIuoWIIlfpXq95jKnLiXfP7aHruZMkowTC9WCLuwnVHkT
	 Oprb7kw46gkgrpV7Z5BPSmIjPzugRHld6j0JFpfVNOrL+ZweUSZ5ZYYkcP/pq6jrZY
	 3w/yVaaOiu7dkJmZ8JNu09KeehPv8M/5D6UHFmx0HiIZjWDDywvwmHc+mgQTUcVZZC
	 YKhIgxsZgoG+W55slBN/e7FwOnpxab6caIfzO6Hjpj9t2fCwL9uBMvPbKbtXi8lqC+
	 Qp/7o53wtQmLrNUuR9S1X+nNzU0JGZodTCgzFSXzJSjT2OLoGfTYWm4SkflGT9Y9Ln
	 p0+BfMElWqeFg==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH net v4 0/4] net: dsa: ks8995: Post-move fixes
Date: Thu, 26 Mar 2026 10:57:31 +0100
Message-Id: <20260326-ks8995-fixups-v4-0-989abba8f077@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNyw7CIBAF0F8xrMXwaguu/A/jAsvQkhraQCWap
 v8uYeOjcXnn5txZUITgIKLjbkEBkotu9DmI/Q61vfYdYGdyRoywmlAq8RClUhW27nGfIpbCskq
 33ArSoGymALkpe2fkYUaXfOxdnMfwLD8SLdWfuUQxwZRoobglnCtzGiB4uB3G0JWpxD65+uUsc
 yWvhnChiaFsw/mbsy3nmevGtjW3QBWtv/i6ri8y9Y6XLgEAAA==
X-Change-ID: 20260118-ks8995-fixups-84f25ac3f407
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271956-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,microchip.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BAE5E3330FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Changes in v4:
- Drop the final "port isolation" (should be better named "port separation")
  patch, due to lack of time to revise the patch. Let's keep this one
  for later.
- Hope we can merge this first round of fixups so the driver is in some
  reasonable state.
- Link to v3: https://lore.kernel.org/r/20260219-ks8995-fixups-v3-0-a7fc63fe1916@kernel.org

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
Linus Walleij (4):
      net: dsa: ks8995: Add shutdown callback
      net: dsa: microchip: Add fallback Micrel compatibles
      net: dsa: ks8955: Delete KSZ8864 and KSZ8795 support
      net: dsa: ks8995: Add stub bridge join/leave

 drivers/net/dsa/ks8995.c            | 198 ++++++++++++------------------------
 drivers/net/dsa/microchip/ksz_spi.c |  15 +++
 2 files changed, 81 insertions(+), 132 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260118-ks8995-fixups-84f25ac3f407

Best regards,
-- 
Linus Walleij <linusw@kernel.org>


