Return-Path: <netdev+bounces-276702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMJaDmq71mnLHggAu9opvQ
	(envelope-from <netdev+bounces-276702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 22:32:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B30E3C3CEA
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 22:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2D87303DAF6
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 20:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6783DA7F4;
	Wed,  8 Apr 2026 20:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6feco9E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE163DB622
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775680286; cv=none; b=Vza8yRimjJmUPNfefgd1gAW4wVXaA+Ivo72wAfpdYsBj2IvF+lC690tQJlAjLKMVBKBZseit3bTMmmcNEsSpz8tl/G4CgCPYRVpePRPLGjt3c/ReU8odug55yyts3tXBLvrdrDHjYyzXEoMIwROnm6p/LUGD++wUYyqxOkbB3PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775680286; c=relaxed/simple;
	bh=QGij33wJFhH6BDsZbp1EjU0Ee4dTRv8svV4bvtTfqWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WHeaRC6KrUZ96UhLBknRhH6mTT+vNAIN54zENPtPwKsVkmxIJRXUIy2StLqLukBjolnSuemYi8JldIF4ovckU16/puOIUuFWbBUnHONN5XVye6RBwIlqefnVOfnwmJQrdpIAU/S/ejySkbQ5wxsrftF3Pid0egEB+FYvKpcoXRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6feco9E; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b2589c26e3so2136135ad.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 13:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775680283; x=1776285083; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAHM66Ym2oGH+/cDJZYepjZly6TJiBADgwKTb2PsNjY=;
        b=M6feco9EH1P0rYDBAGglmWXGDbATO7+QsGMMo1+V6tttHwGtouTG+81HN+eZSbgqnU
         xwZIxMVVIzi9aSCm/Rk3Dtrz9GwZVsW3xrZBLyzzEAmJ8c0rm+E/pWi6G+uDNV7lD/n8
         /9TZVXz8weJXX/d+u/tzXb2DhAoC3AtD7+rcn19OEJBkYxo778A72t8dyFm1qAl2FKDU
         49JRI2Dlzio9nJ4Lvajs2ue14vM2rqemihJ3iPcbuCaudSnfWkzNNTeKeUC+wtmIYyYD
         xvDQBAI7RnJ/Nyw20CcnNtxBPcN+chuwF+XLiAe661kDYREz0akVy/Au1l1P/1Ye6f8S
         8jVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775680283; x=1776285083;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NAHM66Ym2oGH+/cDJZYepjZly6TJiBADgwKTb2PsNjY=;
        b=Ry06uHmBB+XceNUYaHqpU/QnCZPNxYkiZxKQBch3dBmKp9EZ5DGBfppWXqpLJuL6iw
         bxtznafkl1lBTCVEQNB0CCFlmtO/V1WYA5PghTavXoZVojbKVnjx9GEjREOoRwkEcOKi
         9PK+E5jAD0Zn7h7RqFx6oEUrDWhqux5BGvAVasQ48qDUUtCXyR/Sqbq8/MGqopdiYLlB
         8uIJvmqj4hhRdX1LrcbNYUYvZj4kaGTj3txxdzVp0EfYMLpwvHtX3hDiWSSnAv5lwtQt
         /HBQX/B1K52JgqWtsic1qzM+XrLzCJHl7rlKueWefCyAl5tTUVrOBX5odfR1bt0HR2gI
         22+g==
X-Gm-Message-State: AOJu0YzxEm4N1iaxIQbLUokStpLX7eihTebw2EMvpNcx4e8A9xnzNxOL
	pc7XxeYojQhsYkIRDGf3T7WaB7Q5jusk3YZMO5HXqoEtDe5wr2ZyUkv8
X-Gm-Gg: AeBDietR11kc3gXRqoqyGDHMwGjZk/tfV8cqYRnyyOUNwyKd+MOSN9nxgtsrCxofaj2
	hsrpj5qJaf7dAIUKXSEyVfXlk4NuH2kzOTKdKoXlGU+fq0aaoEe1hXaSe6ejjWhvt4XP35/dC+0
	hrgjwRnqd2I9QJNpEg0QWP98hTOzZS8WNz8U0IkGru3sFkiQc00P0u6w8L2dfd4Jv7pEc3WOvgW
	nvvwtyCptKqO23lSHvBecSqNtJZm0TsIK0+FxhkNfEO+ma1kHy40kkgr+0MFQe0HRnpwhcFy3c9
	iH80B4YgBspOrTmhJ+L9Tanncf7kJnLIDjuANqElpKJCvNBcllfb0kO16EINjO3HhYaIf6C0aof
	JZmcK58MgM0O0xWisJaOBq/Kpejxw5251+Ga5drhNTOma3Y7Fq+/N/sWfPI4ILrjIFLr/E6UUh3
	vMQzKdNnsLBsS7Fgqbcv8H5ERjO3uq6vFDqXjl2g==
X-Received: by 2002:a05:7301:4090:b0:2c8:6361:ab58 with SMTP id 5a478bee46e88-2cbfaaaaf92mr11577252eec.13.1775680282474;
        Wed, 08 Apr 2026 13:31:22 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d16d115c00sm9556512eec.12.2026.04.08.13.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 13:31:21 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 08 Apr 2026 17:31:01 -0300
Subject: [net-next PATCH 1/2] net: dsa: tag_rtl8_4: update format
 description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260408-realtek_fixes-v1-1-915ff1404d56@gmail.com>
References: <20260408-realtek_fixes-v1-0-915ff1404d56@gmail.com>
In-Reply-To: <20260408-realtek_fixes-v1-0-915ff1404d56@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.1
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276702-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,bang-olufsen.dk,kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bang-olufsen.dk:email]
X-Rspamd-Queue-Id: 8B30E3C3CEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Document the updated tag layout fields (EFID, VSEL/VIDX) and clarify
which bits are set/cleared when emitting tags.

Co-developed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 net/dsa/tag_rtl8_4.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/dsa/tag_rtl8_4.c b/net/dsa/tag_rtl8_4.c
index 2464545da4d2..b7ed39c5419f 100644
--- a/net/dsa/tag_rtl8_4.c
+++ b/net/dsa/tag_rtl8_4.c
@@ -17,8 +17,8 @@
  *  |              (8-bit)              |              (8-bit)              |
  *  |          Protocol [0x04]          |              REASON               | b
  *  |-----------------------------------+-----------------------------------| y
- *  |   (1)  | (1) | (2) |   (1)  | (3) | (1)  | (1) |    (1)    |   (5)    | t
- *  | FID_EN |  X  | FID | PRI_EN | PRI | KEEP |  X  | LEARN_DIS |    X     | e
+ *  |   (1)   |   (3)  |   (1)  |  (3)  | (1)  | (1)  |    (1)     |  (5)   | t
+ *  | EFID_EN |  EFID  | PRI_EN |  PRI  | KEEP | VSEL | LEARN_DIS  |  VIDX  | e
  *  |-----------------------------------+-----------------------------------| s
  *  |   (1)  |                       (15-bit)                               | |
  *  |  ALLOW |                        TX/RX                                 | v
@@ -32,19 +32,22 @@
  *     EtherType |         note that Realtek uses the same EtherType for
  *               |         other incompatible tag formats (e.g. tag_rtl4_a.c)
  *    Protocol   | 0x04: indicates that this tag conforms to this format
- *    X          | reserved
  *   ------------+-------------
  *    REASON     | reason for forwarding packet to CPU
  *               | 0: packet was forwarded or flooded to CPU
  *               | 80: packet was trapped to CPU
- *    FID_EN     | 1: packet has an FID
- *               | 0: no FID
- *    FID        | FID of packet (if FID_EN=1)
+ *    EFID_EN    | 1: packet has an EFID
+ *               | 0: no EFID
+ *    EFID       | Extended filter ID (EFID) of packet (if EFID_EN=1)
  *    PRI_EN     | 1: force priority of packet
  *               | 0: don't force priority
  *    PRI        | priority of packet (if PRI_EN=1)
  *    KEEP       | preserve packet VLAN tag format
+ *    VSEL       | 0: switch should classify packet according to VLAN tag
+ *               | 1: switch should classify packet according to VLAN membership
+ *               |    configuration with index VIDX
  *    LEARN_DIS  | don't learn the source MAC address of the packet
+ *    VIDX       | index of a VLAN membership configuration to use with VSEL
  *    ALLOW      | 1: treat TX/RX field as an allowance port mask, meaning the
  *               |    packet may only be forwarded to ports specified in the
  *               |    mask
@@ -111,7 +114,7 @@ static void rtl8_4_write_tag(struct sk_buff *skb, struct net_device *dev,
 	/* Set Protocol; zero REASON */
 	tag16[1] = htons(FIELD_PREP(RTL8_4_PROTOCOL, RTL8_4_PROTOCOL_RTL8365MB));
 
-	/* Zero FID_EN, FID, PRI_EN, PRI, KEEP; set LEARN_DIS */
+	/* Zero EFID_EN, EFID, PRI_EN, PRI, VSEL, VIDX, KEEP; set LEARN_DIS */
 	tag16[2] = htons(FIELD_PREP(RTL8_4_LEARN_DIS, 1));
 
 	/* Zero ALLOW; set RX (CPU->switch) forwarding port mask */

-- 
2.53.0


