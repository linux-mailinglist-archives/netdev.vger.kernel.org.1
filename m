Return-Path: <netdev+bounces-298629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y4v5I+H9K2qUJAQAu9opvQ
	(envelope-from <netdev+bounces-298629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:38:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 71259679657
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:38:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=mchp header.b="vN/L2t12";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298629-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298629-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92527300D347
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BF23E16AD;
	Fri, 12 Jun 2026 12:38:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CD23E0098;
	Fri, 12 Jun 2026 12:38:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267921; cv=none; b=qCA+XN13EUDxv2TbeCBMvgCNpsoRI9UVLY+DjZT6WjRa/rAEvYCoWehZcMbvZx14k5LC5f7ra+i7QIXv98SgxTRepxEOkUBfgm5f+U7nvrLBmkKvFtLDb4rTSoYsuufrOaFkOb2mPMkRAq41TZDCnpyfvxdICaUNQCj5Z/7pzjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267921; c=relaxed/simple;
	bh=IgGqUBZjEIGGw39Bto0aYqXBNI28GTbplPNY/xcUd5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=g97SpjGtj0TsTrsBzp+4A2lKEAO9btxSnsEEek2r8fyOcY8EYgwrievUXoI4fsDBhoNOcdXSpsxgUF92VOAUerrBLyA4a3KnOGy98jKusS3SN3ahtnNLUmHJbV10jHan86GmitDZe4U5sLXZfkbM7w2bIIcNImJR6NMg8OTiNpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vN/L2t12; arc=none smtp.client-ip=68.232.153.233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781267919; x=1812803919;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=IgGqUBZjEIGGw39Bto0aYqXBNI28GTbplPNY/xcUd5g=;
  b=vN/L2t12Tg05oyGSFMBuzuSJPUso2F/QsehpVIxOxuKH9+Zb9HJAVV2Z
   AKGEk4IfT+t6I/bi/a8zmcKwiyPadoMGeCtfqRPO7P4pTJHvrvQdx5cJJ
   tTuDKlO19JUvhUe3oJsNApm+VhyHTcVgoBNvs212Llqwtl2pSp12nKWZy
   yVrAMM3j4Wno+wyibKNIyncrqBJGkioojw7oHNPzV20R6qVSsOse7su45
   EB53a8TzToiPEMVVckELBdW4iWVjZY6zA8N058HT2BJo7mMoF1n3eBfUV
   f/rWNOTUQdWKrJi7zcIt0hdjLSCEancaks9hymTBaqp/LdHqQu3xZygvL
   w==;
X-CSE-ConnectionGUID: biWOJ6pnSv6QV8cPpDhLEw==
X-CSE-MsgGUID: r5ARXr0ERLWrn4t+kBjprA==
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="68073237"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2026 05:38:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 12 Jun 2026 05:38:37 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 12 Jun 2026 05:38:34 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Fri, 12 Jun 2026 14:37:10 +0200
Subject: [PATCH net-next 1/9] net: microchip: vcap: fix rule move for rules
 of coprime size
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260612-sparx5_l3_routing-v1-1-fc3c10160f49@microchip.com>
References: <20260612-sparx5_l3_routing-v1-0-fc3c10160f49@microchip.com>
In-Reply-To: <20260612-sparx5_l3_routing-v1-0-fc3c10160f49@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Machon
	<daniel.machon@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-hardening@vger.kernel.org>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298629-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:horatiu.vultur@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:daniel.machon@microchip.com,m:Steen.Hegelund@microchip.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-hardening@vger.kernel.org,m:jensemil.schulzostergaard@microchip.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,microchip.com:dkim,microchip.com:email,microchip.com:mid,microchip.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71259679657

Fix a discrepancy between how software and hardware moves rule
addresses on insert and delete. Hardware moves a block of addresses by a
uniform offset. The software representation stores the addresses of
rules. These are updated individually by computing a space-optimal
address relative to its neighbor.

This worked when all rule sizes in a VCAP formed a divisibility
chain (e.g. 1, 2, 6, 12), because any valid offset for the largest
rule was also valid for all smaller rules. At the moment all clients of
the VCAP library only uses rules for which this is true.

But the LPM VCAP, necessary for l3 routing, will introduce rule types of
coprime size, so the algorithm must be fixed. This is in preparation for
adding support for L3 routing to sparx5 and lan969x, which requires the
LPM VCAP with rules of size 2 and 3. This patch fixes the issue by
making sure the software representation is updated in the same way as
the hardware.

The VCAP rule model has the following properties:

- A rule has keyset size K and actionset size M; rule size N =
  max(K, M).
- Rules are naturally aligned to their size (start_addr % N == 0).
- Rules are sorted by size with larger rules at higher addresses.
- HW moves a contiguous block of addresses by a uniform offset.

Introducing rules of coprime size 2 and 3 exposes these four bugs:

1) Move count on insert includes addresses beyond the moved block.
   When padding exists between rules of different sizes, the count
   overshoots, corrupting the rule above.

2) Move offset does not preserve alignment for the entire block.
   Per-rule optimal offsets differ from the uniform HW offset,
   causing HW/SW desync and misaligned rules.

3) On deletion, HW memory at the removed rule's addresses is not
   initialized. The moved block may not fully cover them due to
   padding, leaving stale data.

4) On deletion, padding between rules is not reclaimed.

Example for issue 1, insert corrupts rule above:

Starting state (X6 rule followed by X2):

  Addr  Rule
    35  X6
    34  X6
    33  X6
    32  X6
    31  X6
    30  X6
    29  X2
    28  X2
    27

Insert X3 between X6 and X2. SW places rules optimally, X2 needs
padding:

  Addr  Rule (SW)
    35  X6
    34  X6
    33  X6
    32  X6
    31  X6
    30  X6
    29  X3
    28  X3
    27  X3
    26       (pad)
    25  X2
    24  X2

Move count = X3.addr - X2.addr = 27 - 24 = 3. HW moves 3 addresses
starting at 28: addrs {28, 29, 30}. But addr 30 is the base of X6,
so the move corrupts it:

  Addr  Rule (HW)
    35  X6
    34  X6
    33  X6
    32  X6
    31  X6
    30  ??   <- corrupted, was base of X6
    ...
    26  X6   <- stale copy of addr 30
    25  X2
    24  X2

Example for issue 2, delete misaligns rule:

Starting state:

  Addr  Rule
    38       <- LAST_VALID_ADDR
    35  X6
    34  X6
    33  X6
    32  X6
    31  X6
    30  X6
    29  X3
    28  X3
    27  X3
    26       (pad)
    25  X2
    24  X2

Delete X6. Old code computes: offset = 39 - 30 - 6 = 3, gap = 0,
each rule moves by 6 + 0 + 3 = 9:

  X3: 27 + 9 = 36   (36 % 3 == 0, OK)
  X2: 24 + 9 = 33   (33 % 2 == 1, MISALIGNED)

Offset 9 is not a multiple of LCM(3, 2) = 6, breaking X2 alignment.

Example for issues 1 + 2, insert desyncs HW/SW and misaligns:

Starting state:

  Addr  Rule
    26  X3   <- LAST_VALID_ADDR
    25  X3
    24  X3
    23  X2
    22  X2

Insert X6. SW calculates different per-rule offsets:

  X3 needs offset  9 (to addr 15)
  X2 needs offset 10 (to addr 12)

Old code computes: count = 18 - 12 = 6 (should be 5), offset = 10.
HW applies uniform offset 10 to 6 addresses:

  Addr  Rule (SW)     Addr  Rule (HW)
    17  X3              17
    16  X3              16  X3
    15  X3              15  X3
    14                  14  X3  <- misaligned (14 % 3 != 0)
    13  X2              13  X2
    12  X2              12  X2

HW and SW are out of sync, and X3 is misaligned in HW.

The new move algorithm computes a single uniform offset for the
entire block, aligned to the LCM of all rule sizes in that block.
This guarantees that every rule lands on a naturally aligned address
after the HW move, and that HW and SW stay in sync.

On insert:

1. Determine the move block: all rules below the insertion point.
2. Compute the LCM of all rule sizes in the block
   (vcap_find_move_block_lcm).
3. Compute the move offset as the inserted rule's size rounded up
   to the next LCM multiple (vcap_move_from_block). This is the
   uniform offset applied to the entire block.
4. Move count is exactly the number of addresses occupied by the
   block (no overshoot into the rule above).
5. Issue a single HW move, then update all SW rule addresses by
   the same uniform offset (vcap_move_rules_sw).
6. Place the new rule in the gap created by the move.

On delete:

1. Initialize HW memory at the deleted rule's addresses before
   moving, since the moved block may not fully cover them due to
   padding.
2. Reclaim any padding between rules in the block.
3. Compute the LCM-aligned uniform offset and move count as above.
4. Issue a single HW move and update SW addresses uniformly.

No VCAP api client uses rules of coprime size today, so the bug does not
fire in any existing configuration. The LPM VCAP for sparx5 and lan969x,
added later in this series, is the first instance with rules of coprime
sizes (2 and 3), and therefore the first to reach this bug.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
 drivers/net/ethernet/microchip/vcap/vcap_api.c     | 178 +++++++++++++--------
 .../net/ethernet/microchip/vcap/vcap_api_kunit.c   |  81 ++++++----
 2 files changed, 164 insertions(+), 95 deletions(-)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.c b/drivers/net/ethernet/microchip/vcap/vcap_api.c
index 0fdb5e363bad..6946fd738458 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api.c
@@ -4,7 +4,9 @@
  * Copyright (c) 2022 Microchip Technology Inc. and its subsidiaries.
  */
 
+#include <linux/lcm.h>
 #include <linux/types.h>
+#include <linux/minmax.h>
 
 #include "vcap_api_private.h"
 
@@ -2096,12 +2098,63 @@ static u32 vcap_set_rule_id(struct vcap_rule_internal *ri)
 	return ri->data.id;
 }
 
+static void vcap_move_from_block(u32 base_addr,
+				 struct vcap_rule_internal *block_first,
+				 struct vcap_rule_internal *block_last,
+				 int block_lcm, struct vcap_rule_move *move)
+{
+	int unaligned_offset;
+
+	if (!block_first || !block_last)
+		return;
+
+	move->addr = block_last->addr;
+	move->count = block_first->addr + block_first->size - block_last->addr;
+	/* Integer division rounds toward zero. We want to round toward +inf
+	 * for the positive case (insertion) to ensure enough room.
+	 */
+	unaligned_offset = (block_first->addr + block_first->size) - base_addr;
+	if (unaligned_offset > 0)
+		move->offset =
+			((unaligned_offset + (block_lcm - 1)) / block_lcm) *
+			block_lcm;
+	else
+		move->offset = (unaligned_offset / block_lcm) * block_lcm;
+}
+
+static void vcap_move_rules_sw(struct vcap_admin *admin,
+			       struct vcap_rule_internal *pos,
+			       struct vcap_rule_move const *move)
+{
+	if (move->count == 0 || move->offset == 0)
+		return;
+
+	list_for_each_entry_continue(pos, &admin->rules, list)
+		pos->addr -= move->offset;
+}
+
+static int vcap_find_move_block_lcm(struct vcap_admin *admin,
+				    struct vcap_rule_internal *pos)
+{
+	int block_lcm = 1;
+
+	list_for_each_entry_continue(pos, &admin->rules, list) {
+		block_lcm = lcm(block_lcm, pos->size);
+		if (pos->size <= 2)
+			break;
+	}
+
+	return block_lcm;
+}
+
 static int vcap_insert_rule(struct vcap_rule_internal *ri,
 			    struct vcap_rule_move *move)
 {
+	struct vcap_rule_internal *duprule, *iter, *block_first = NULL,
+						   *block_last;
 	int sw_count = ri->vctrl->vcaps[ri->admin->vtype].sw_count;
-	struct vcap_rule_internal *duprule, *iter, *elem = NULL;
 	struct vcap_admin *admin = ri->admin;
+	int block_lcm;
 	u32 addr;
 
 	ri->sort_key = vcap_sort_key(sw_count, ri->size, ri->data.user,
@@ -2114,12 +2167,12 @@ static int vcap_insert_rule(struct vcap_rule_internal *ri,
 	 */
 	list_for_each_entry(iter, &admin->rules, list) {
 		if (ri->sort_key < iter->sort_key) {
-			elem = iter;
+			block_first = iter;
 			break;
 		}
 	}
 
-	if (!elem) {
+	if (!block_first) {
 		ri->addr = vcap_next_rule_addr(admin->last_used_addr, ri);
 		admin->last_used_addr = ri->addr;
 
@@ -2132,10 +2185,13 @@ static int vcap_insert_rule(struct vcap_rule_internal *ri,
 		return 0;
 	}
 
-	/* Reuse the space of the current rule */
-	addr = elem->addr + elem->size;
+	block_last = list_last_entry(&admin->rules, typeof(*ri), list);
+
+	/* Reuse the space and padding of the current rule */
+	addr = admin->last_valid_addr + 1;
+	if (!list_is_first(&block_first->list, &admin->rules))
+		addr = list_prev_entry(block_first, list)->addr;
 	ri->addr = vcap_next_rule_addr(addr, ri);
-	addr = ri->addr;
 
 	/* Add a copy of the rule to the VCAP list */
 	duprule = vcap_dup_rule(ri, ri->state == VCAP_RS_DISABLED);
@@ -2143,29 +2199,34 @@ static int vcap_insert_rule(struct vcap_rule_internal *ri,
 		return PTR_ERR(duprule);
 
 	/* Add before the current entry */
-	list_add_tail(&duprule->list, &elem->list);
+	list_add_tail(&duprule->list, &block_first->list);
 
-	/* Update the current rule */
-	elem->addr = vcap_next_rule_addr(addr, elem);
-	addr = elem->addr;
+	/* Collect block move info in struct move, to update VCAP HW later */
+	block_lcm = vcap_find_move_block_lcm(admin, duprule);
+	vcap_move_from_block(ri->addr, block_first, block_last, block_lcm,
+			     move);
 
-	/* Update the address in the remaining rules in the list */
-	list_for_each_entry_continue(elem, &admin->rules, list) {
-		elem->addr = vcap_next_rule_addr(addr, elem);
-		addr = elem->addr;
+	if ((int)block_last->addr - move->offset < admin->first_valid_addr) {
+		pr_err("%s:%d: No room for rule size: %u, %u\n", __func__,
+		       __LINE__, duprule->size, admin->first_valid_addr);
+		list_del(&duprule->list);
+		vcap_free_rule(&duprule->data);
+		return -ENOSPC;
 	}
 
-	/* Update the move info */
-	move->addr = admin->last_used_addr;
-	move->count = ri->addr - addr;
-	move->offset = admin->last_used_addr - addr;
-	admin->last_used_addr = addr;
+	/* Apply move to SW */
+	vcap_move_rules_sw(admin, duprule, move);
+	admin->last_used_addr =
+		list_last_entry(&admin->rules, typeof(*ri), list)->addr;
 	return 0;
 }
 
 static void vcap_move_rules(struct vcap_rule_internal *ri,
 			    struct vcap_rule_move *move)
 {
+	if (move->count == 0 || move->offset == 0)
+		return;
+
 	ri->vctrl->ops->move(ri->ndev, ri->admin, move->addr,
 			 move->offset, move->count);
 }
@@ -2275,8 +2336,7 @@ int vcap_add_rule(struct vcap_rule *rule)
 		       __func__, __LINE__, ret);
 		goto out;
 	}
-	if (move.count > 0)
-		vcap_move_rules(ri, &move);
+	vcap_move_rules(ri, &move);
 
 	/* Set the counter to zero */
 	ret = vcap_write_counter(ri, &ctr);
@@ -2488,59 +2548,52 @@ int vcap_mod_rule(struct vcap_rule *rule)
 }
 EXPORT_SYMBOL_GPL(vcap_mod_rule);
 
-/* Return the alignment offset for a new rule address */
-static int vcap_valid_rule_move(struct vcap_rule_internal *el, int offset)
-{
-	return (el->addr + offset) % el->size;
-}
-
-/* Update the rule address with an offset */
-static void vcap_adjust_rule_addr(struct vcap_rule_internal *el, int offset)
-{
-	el->addr += offset;
-}
-
 /* Rules needs to be moved to fill the gap of the deleted rule */
 static int vcap_fill_rule_gap(struct vcap_rule_internal *ri)
 {
+	struct vcap_rule_internal *block_first = NULL, *block_last = NULL;
 	struct vcap_admin *admin = ri->admin;
-	struct vcap_rule_internal *elem;
-	struct vcap_rule_move move;
-	int gap = 0, offset = 0;
+	struct net_device *ndev = ri->ndev;
+	struct vcap_rule_move move = {};
+	int block_lcm, addr;
 
-	/* If the first rule is deleted: Move other rules to the top */
-	if (list_is_first(&ri->list, &admin->rules))
-		offset = admin->last_valid_addr + 1 - ri->addr - ri->size;
+	if (!list_is_last(&ri->list, &admin->rules)) {
+		block_first = list_next_entry(ri, list);
+		block_last = list_last_entry(&admin->rules, typeof(*ri), list);
+	}
 
-	/* Locate gaps between odd size rules and adjust the move */
-	elem = ri;
-	list_for_each_entry_continue(elem, &admin->rules, list)
-		gap += vcap_valid_rule_move(elem, ri->size);
+	addr = admin->last_valid_addr + 1;
+	if (!list_is_first(&ri->list, &admin->rules))
+		addr = list_prev_entry(ri, list)->addr;
 
-	/* Update the address in the remaining rules in the list */
-	elem = ri;
-	list_for_each_entry_continue(elem, &admin->rules, list)
-		vcap_adjust_rule_addr(elem, ri->size + gap + offset);
+	block_lcm = vcap_find_move_block_lcm(admin, ri);
+	vcap_move_from_block(addr, block_first, block_last, block_lcm, &move);
 
-	/* Update the move info */
-	move.addr = admin->last_used_addr;
-	move.count = ri->addr - admin->last_used_addr - gap;
-	move.offset = -(ri->size + gap + offset);
+	/* Apply move to SW representation */
+	vcap_move_rules_sw(admin, ri, &move);
 
-	/* Do the actual move operation */
+	/* Initialize space used by ri, as it may not be overwritten by move */
+	ri->vctrl->ops->init(ndev, admin, ri->addr, ri->size);
+
+	/* Apply move to HW. The VCAP move command automatically disables
+	 * (initializes) the source addresses, so no separate init is needed
+	 * for the vacated positions.
+	 */
 	vcap_move_rules(ri, &move);
 
-	return gap + offset;
+	if (block_last)
+		return block_last->addr;
+
+	return addr;
 }
 
 /* Delete rule in a VCAP instance */
 int vcap_del_rule(struct vcap_control *vctrl, struct net_device *ndev, u32 id)
 {
-	struct vcap_rule_internal *ri, *elem;
+	struct vcap_rule_internal *ri;
 	struct vcap_admin *admin;
-	int gap = 0, err;
+	int err;
 
-	/* This will later also handle rule moving */
 	if (!ndev)
 		return -ENODEV;
 	err = vcap_api_check(vctrl);
@@ -2553,23 +2606,12 @@ int vcap_del_rule(struct vcap_control *vctrl, struct net_device *ndev, u32 id)
 
 	admin = ri->admin;
 
-	if (ri->addr > admin->last_used_addr)
-		gap = vcap_fill_rule_gap(ri);
+	admin->last_used_addr = vcap_fill_rule_gap(ri);
 
 	/* Delete the rule from the list of rules and the cache */
 	list_del(&ri->list);
-	vctrl->ops->init(ndev, admin, admin->last_used_addr, ri->size + gap);
 	vcap_free_rule(&ri->data);
 
-	/* Update the last used address, set to default when no rules */
-	if (list_empty(&admin->rules)) {
-		admin->last_used_addr = admin->last_valid_addr + 1;
-	} else {
-		elem = list_last_entry(&admin->rules, struct vcap_rule_internal,
-				       list);
-		admin->last_used_addr = elem->addr;
-	}
-
 	mutex_unlock(&admin->lock);
 	return err;
 }
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
index ce26ccbdccdf..cec818938ec9 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
@@ -1575,7 +1575,7 @@ static void vcap_api_rule_insert_in_order_test(struct kunit *test)
 		.lookups = 4,
 		.last_valid_addr = 3071,
 		.first_valid_addr = 0,
-		.last_used_addr = 800,
+		.last_used_addr = 804,
 		.cache = {
 			.keystream = keydata,
 			.maskstream = mskdata,
@@ -1583,15 +1583,28 @@ static void vcap_api_rule_insert_in_order_test(struct kunit *test)
 		},
 	};
 
+	struct vcap_rule_internal ri0 = {
+		.data = {
+			.id = 2001,
+		},
+		.addr = 804,
+		.size = 12,
+		.sort_key = vcap_sort_key(12, 12, 0, 0),
+		.admin = &admin,
+		.counter_id = 2002,
+		.vctrl = &test_vctrl,
+	};
+
 	vcap_test_api_init(&admin);
+	list_add_tail(&ri0.list, &admin.rules);
 
 	/* Create rules with different sizes and check that they are placed
 	 * at the correct address in the VCAP according to size
 	 */
-	test_vcap_xn_rule_creator(test, 10000, VCAP_USER_QOS, 10, 500, 12, 780);
-	test_vcap_xn_rule_creator(test, 10000, VCAP_USER_QOS, 20, 400, 6, 774);
-	test_vcap_xn_rule_creator(test, 10000, VCAP_USER_QOS, 30, 300, 3, 771);
-	test_vcap_xn_rule_creator(test, 10000, VCAP_USER_QOS, 40, 200, 2, 768);
+	test_vcap_xn_rule_creator(test, 10000, VCAP_USER_QOS, 10, 500, 12, 792);
+	test_vcap_xn_rule_creator(test, 10000, VCAP_USER_QOS, 20, 400, 6, 786);
+	test_vcap_xn_rule_creator(test, 10000, VCAP_USER_QOS, 30, 300, 3, 783);
+	test_vcap_xn_rule_creator(test, 10000, VCAP_USER_QOS, 40, 200, 2, 780);
 
 	vcap_del_rule(&test_vctrl, &test_netdev, 200);
 	vcap_del_rule(&test_vctrl, &test_netdev, 300);
@@ -1613,7 +1626,7 @@ static void vcap_api_rule_insert_reverse_order_test(struct kunit *test)
 		.lookups = 4,
 		.last_valid_addr = 3071,
 		.first_valid_addr = 0,
-		.last_used_addr = 800,
+		.last_used_addr = 804,
 		.cache = {
 			.keystream = keydata,
 			.maskstream = mskdata,
@@ -1621,40 +1634,54 @@ static void vcap_api_rule_insert_reverse_order_test(struct kunit *test)
 		},
 	};
 	struct vcap_rule_internal *elem;
-	u32 exp_addr[] = {780, 774, 771, 768, 767};
+	u32 exp_addr[] = {804, 792, 786, 783, 780};
 	int idx;
 
+	/* Existing X12 rule at last_used_addr */
+	struct vcap_rule_internal ri0 = {
+		.data = {
+			.id = 2001,
+		},
+		.addr = 804,
+		.size = 12,
+		.sort_key = vcap_sort_key(12, 12, 0, 0),
+		.admin = &admin,
+		.counter_id = 2002,
+		.vctrl = &test_vctrl,
+	};
+
 	vcap_test_api_init(&admin);
+	list_add_tail(&ri0.list, &admin.rules);
 
 	/* Create rules with different sizes and check that they are placed
 	 * at the correct address in the VCAP according to size
 	 */
-	test_vcap_xn_rule_creator(test, 10000, VCAP_USER_QOS, 20, 200, 2, 798);
+	test_vcap_xn_rule_creator(test, 10000, VCAP_USER_QOS, 20, 200, 2, 802);
 	KUNIT_EXPECT_EQ(test, 0, test_move_offset);
 	KUNIT_EXPECT_EQ(test, 0, test_move_count);
 	KUNIT_EXPECT_EQ(test, 0, test_move_addr);
 
-	test_vcap_xn_rule_creator(test, 10000, VCAP_USER_QOS, 30, 300, 3, 795);
-	KUNIT_EXPECT_EQ(test, 6, test_move_offset);
-	KUNIT_EXPECT_EQ(test, 3, test_move_count);
-	KUNIT_EXPECT_EQ(test, 798, test_move_addr);
+	test_vcap_xn_rule_creator(test, 10000, VCAP_USER_QOS, 30, 300, 3, 801);
+	KUNIT_EXPECT_EQ(test, 4, test_move_offset);
+	KUNIT_EXPECT_EQ(test, 2, test_move_count);
+	KUNIT_EXPECT_EQ(test, 802, test_move_addr);
 
-	test_vcap_xn_rule_creator(test, 10000, VCAP_USER_QOS, 40, 400, 6, 792);
+	test_vcap_xn_rule_creator(test, 10000, VCAP_USER_QOS, 40, 400, 6, 798);
 	KUNIT_EXPECT_EQ(test, 6, test_move_offset);
 	KUNIT_EXPECT_EQ(test, 6, test_move_count);
-	KUNIT_EXPECT_EQ(test, 792, test_move_addr);
+	KUNIT_EXPECT_EQ(test, 798, test_move_addr);
 
-	test_vcap_xn_rule_creator(test, 10000, VCAP_USER_QOS, 50, 500, 12, 780);
-	KUNIT_EXPECT_EQ(test, 18, test_move_offset);
+	test_vcap_xn_rule_creator(test, 10000, VCAP_USER_QOS, 50, 500, 12, 792);
+	KUNIT_EXPECT_EQ(test, 12, test_move_offset);
 	KUNIT_EXPECT_EQ(test, 12, test_move_count);
-	KUNIT_EXPECT_EQ(test, 786, test_move_addr);
+	KUNIT_EXPECT_EQ(test, 792, test_move_addr);
 
 	idx = 0;
 	list_for_each_entry(elem, &admin.rules, list) {
 		KUNIT_EXPECT_EQ(test, exp_addr[idx], elem->addr);
 		++idx;
 	}
-	KUNIT_EXPECT_EQ(test, 768, admin.last_used_addr);
+	KUNIT_EXPECT_EQ(test, 780, admin.last_used_addr);
 
 	vcap_del_rule(&test_vctrl, &test_netdev, 500);
 	vcap_del_rule(&test_vctrl, &test_netdev, 400);
@@ -1774,7 +1801,7 @@ static void vcap_api_rule_remove_in_middle_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 768, test_move_addr);
 	KUNIT_EXPECT_EQ(test, -6, test_move_offset);
 	KUNIT_EXPECT_EQ(test, 6, test_move_count);
-	KUNIT_EXPECT_EQ(test, 768, test_init_start);
+	KUNIT_EXPECT_EQ(test, 774, test_init_start);
 	KUNIT_EXPECT_EQ(test, 6, test_init_count);
 	KUNIT_EXPECT_EQ(test, 774, admin.last_used_addr);
 
@@ -1784,8 +1811,8 @@ static void vcap_api_rule_remove_in_middle_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 774, test_move_addr);
 	KUNIT_EXPECT_EQ(test, -4, test_move_offset);
 	KUNIT_EXPECT_EQ(test, 2, test_move_count);
-	KUNIT_EXPECT_EQ(test, 774, test_init_start);
-	KUNIT_EXPECT_EQ(test, 4, test_init_count);
+	KUNIT_EXPECT_EQ(test, 777, test_init_start);
+	KUNIT_EXPECT_EQ(test, 3, test_init_count);
 	KUNIT_EXPECT_EQ(test, 778, admin.last_used_addr);
 
 	test_init_rule_deletion();
@@ -1794,8 +1821,8 @@ static void vcap_api_rule_remove_in_middle_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 778, test_move_addr);
 	KUNIT_EXPECT_EQ(test, -20, test_move_offset);
 	KUNIT_EXPECT_EQ(test, 2, test_move_count);
-	KUNIT_EXPECT_EQ(test, 778, test_init_start);
-	KUNIT_EXPECT_EQ(test, 20, test_init_count);
+	KUNIT_EXPECT_EQ(test, 780, test_init_start);
+	KUNIT_EXPECT_EQ(test, 12, test_init_count);
 	KUNIT_EXPECT_EQ(test, 798, admin.last_used_addr);
 
 	test_init_rule_deletion();
@@ -1855,11 +1882,11 @@ static void vcap_api_rule_remove_in_front_test(struct kunit *test)
 	ret = vcap_del_rule(&test_vctrl, &test_netdev, 400);
 	KUNIT_EXPECT_EQ(test, 0, ret);
 	KUNIT_EXPECT_EQ(test, 786, test_move_addr);
-	KUNIT_EXPECT_EQ(test, -8, test_move_offset);
+	KUNIT_EXPECT_EQ(test, -6, test_move_offset);
 	KUNIT_EXPECT_EQ(test, 6, test_move_count);
-	KUNIT_EXPECT_EQ(test, 786, test_init_start);
-	KUNIT_EXPECT_EQ(test, 8, test_init_count);
-	KUNIT_EXPECT_EQ(test, 794, admin.last_used_addr);
+	KUNIT_EXPECT_EQ(test, 792, test_init_start);
+	KUNIT_EXPECT_EQ(test, 6, test_init_count);
+	KUNIT_EXPECT_EQ(test, 792, admin.last_used_addr);
 
 	vcap_del_rule(&test_vctrl, &test_netdev, 200);
 	vcap_del_rule(&test_vctrl, &test_netdev, 300);

-- 
2.52.0


