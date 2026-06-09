Return-Path: <netdev+bounces-297129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rlKbKEwzKGobAAMAu9opvQ
	(envelope-from <netdev+bounces-297129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:37:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F16661DA6
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:37:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=Bkr1qhBz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297129-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297129-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C83531887BE
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F6A48C3EE;
	Tue,  9 Jun 2026 15:28:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A4543CEFB;
	Tue,  9 Jun 2026 15:28:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018890; cv=none; b=WtmbQEsJW+bCprKlXYOWr8NP7RO/XD0UdkgDSQN9c2B9VJj/f1XCBSAuojXwEEFUVmCPHStZkccWsKKQC8jghtGhWBVU9Hg/Pav1x5wl1RpSNKfw0SdsfIEbZUmgU22J7P2qmVl4S0jOhPTOmAv26J1frmMA4Ut0TLK4LdfxZTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018890; c=relaxed/simple;
	bh=LvRNsNFNEG/rnxEYVCFUUIiZRK00izaZ3UhZU2drJgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FMAcaC9Z83eADJz95kmCmON7sVrJGfm93T/jPy7DVZP12FrpxuRsC6dVuS7/05zwPbW7+QeHIP4mT4X1fL28lIK5VV9rS3e856xxFQ5+ZLdp638lZryd5ffboo74ZDkeosGgVE3P2bJRlxS46YAQjYjQ7PZoqQzZY4O9k+VhPH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bkr1qhBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8473C4AF0F;
	Tue,  9 Jun 2026 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781018889;
	bh=LvRNsNFNEG/rnxEYVCFUUIiZRK00izaZ3UhZU2drJgU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Bkr1qhBzsG10HTOV5lCHcySyB5vrI8khl7Q9w7tPkP29A2X2CIVjCogPW50h55Oh5
	 xKlOhlRJx0dsr4T4L7w82MumlkxBkepquekgS/hh9fu9K/owFe1NMY8qTZI4aGhJc5
	 2NcvM7Hm+KIpQplCfFzpJoVi5swZHEJiJ0e/lcokTtJo1dj+kEMGRxJCbK7IxPq2R9
	 nFReauEn/gbICB9/rVcRIhLoOHU9tDvQVNB/bL1aYaCSBpVPkktm/mrI6QsU0Czq0b
	 M/PIZYIIFNWlO57Xc0aabMCgbsS3QU3b0qMdf77k8ahiDYcbdluqzcbBcN0QmOqXqP
	 xhD76sj2K7ImA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE970CD98C5;
	Tue,  9 Jun 2026 15:28:09 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Tue, 09 Jun 2026 18:28:08 +0300
Subject: [PATCH net-next v4 09/13] net: ethernet: oa_tc6: Add new register
 address defines
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-adin1140-driver-v4-9-0753e28ee004@analog.com>
References: <20260609-adin1140-driver-v4-0-0753e28ee004@analog.com>
In-Reply-To: <20260609-adin1140-driver-v4-0-0753e28ee004@analog.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781018886; l=1399;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=jiT9FC0dcuxvAAteaU7y1TQSwqloCqPp/Jj5qWjXSYA=;
 b=aCqSLx+D9VW5+Mbv4MyjXlKO8sAnm4IkzyVPYGgRAVWyNb0a+xfBNqfPkrnMMBGwKVcUOL0pk
 gv25NJTepxwBN+s3Rth2sqIMmlvguPBt43WUtJfOKx2RG08PmwWqN4S
X-Developer-Key: i=ciprian.regus@analog.com; a=ed25519;
 pk=8WoNhI0kQcQUl8YqJO5ZevROYk9HP8lOIeIgIYgjfbc=
X-Endpoint-Received: by B4 Relay for ciprian.regus@analog.com/20260330 with
 auth_id=703
X-Original-From: Ciprian Regus <ciprian.regus@analog.com>
Reply-To: ciprian.regus@analog.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297129-lists,netdev=lfdr.de,ciprian.regus.analog.com];
	FORGED_RECIPIENTS(0.00)[m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:devicetree@vger.kernel.org,m:ciprian.regus@analog.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[ciprian.regus@analog.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,analog.com:replyto,analog.com:email,analog.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49F16661DA6

From: Ciprian Regus <ciprian.regus@analog.com>

Add macro defines for the CONFIG2 register and the MMS1 memory map.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
v4 changelog:
 - rename OA_TC6_VEND_MMS1 to OA_TC6_MAC_MMS1.
 - group the MMS1 entry with the other MMS values and update the comment
   describing that set of macros.
v3 changelog:
 - New patch
---
 include/linux/oa_tc6.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index cace67cfc709..24c5899912c0 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -25,6 +25,9 @@
 #define OA_TC6_CONFIG0_ZARFE_ENABLE		BIT(12)
 #define OA_TC6_CONFIG0_PROTE			BIT(5)
 
+/* Configuration Register #2 */
+#define OA_TC6_REG_CONFIG2			0x0006
+
 /* Status Register #0 */
 #define OA_TC6_REG_STATUS0			0x0008
 #define OA_TC6_STATUS0_RESETC			BIT(6)	/* Reset Complete */
@@ -49,9 +52,10 @@
 #define OA_TC6_PHY_STD_REG_ADDR_BASE		0xFF00
 #define OA_TC6_PHY_STD_REG_ADDR_MASK		0x1F
 
-/* PHY – Clause 45 registers memory map selector (MMS) as per table 6 in the
+/* Memory map selector (MMS) values as per table 6 in the
  * OPEN Alliance specification.
  */
+#define OA_TC6_MAC_MMS1				1
 #define OA_TC6_PHY_C45_PCS_MMS2			2	/* MMD 3 */
 #define OA_TC6_PHY_C45_PMA_PMD_MMS3		3	/* MMD 1 */
 #define OA_TC6_PHY_C45_VS_PLCA_MMS4		4	/* MMD 31 */

-- 
2.43.0



