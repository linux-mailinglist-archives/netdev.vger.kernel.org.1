Return-Path: <netdev+bounces-296138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2lSgDiByJGq/6gEAu9opvQ
	(envelope-from <netdev+bounces-296138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 21:16:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9455B64E1B7
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 21:16:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=IxUY91m+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296138-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296138-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0201304B2BB
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 19:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CE33BE164;
	Sat,  6 Jun 2026 19:14:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299193BED77
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 19:14:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780773275; cv=none; b=QgSfT4oeycY5xbPSkMsafQT/+WsK1+NzHMVTz6iTrhqsc0vQcCptCWMYyuh97vh2iKT9a6eY82ZwaSFqo2ECJRPIAVfJ5tHGvlaQg09q3zjnm4E+b4QWJkxEWHg72wrIGfsYUP/GyDqMa4eH8XrMhznMspAL5qPb7m+HSolUEF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780773275; c=relaxed/simple;
	bh=7Lj0FqVDmeiNPWCn3u/fKwFl3wYP02Jhmq4tu2IuAwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uornu9T5XMFnffMQiQArugL99PSpfopC2vWSn3yzw2+59Y+Wz70Iwp8dre08p1nH/VVx/dPp3sJHScS3T5rnacAXrBiHOPnNjMVk3eB2EFDFpcL91cnwOXqtL8pketRqW2Pi2nfDIhnKSW8VXaCM5U+EFodRh9axmwcUJZd2o3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxUY91m+; arc=none smtp.client-ip=209.85.222.177
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-91591f19c30so481548585a.1
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 12:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780773272; x=1781378072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnT0GMlKGTyqTQGZDUa8kd6IyJCEjxPnkabKrmHLnAA=;
        b=IxUY91m+nA0/oU1RfhEcEqEw/Bakf5U+1aQtJbS/8aR2mwreDnUilff8xbNQZ9MAK9
         XOSWuIuSHnNRXeBA6N9h6ejTIYc2hkY/aQQxYcaWGeDjIcDlzPkMg6wOoJfKTlDQ17nR
         zrDK6kj4f4m9HjH81pG6qijPg9zAhNGHW1vEVA9mnkxfMtMcFONO66R0Ls19MwO2v7+E
         Qx0sSLI/amcq9/9Oq0KUa+vIZSC7fW6WMaTYpxEGtrkmQCQ71yQvVWIEmyg9AOErDmYi
         2wiVlNq/dFhmS70th0i2m6phdft8HAg/pvB6DmfNEHy9gZSso3Cl0KcbvJL2pkgdDKAK
         P8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780773272; x=1781378072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vnT0GMlKGTyqTQGZDUa8kd6IyJCEjxPnkabKrmHLnAA=;
        b=lihF/oYa8Un4XG9koyc4KBhOevYI9HnM0cUa/54e6uYX6tC0YD2r4cNe1YYXAqtWkw
         a/AB55A5XsOY+n5u+uW8Gs0lY5RfAuj6/azUNOH6rCgq0jMGh8R2JVTtyjqGTEHT2e58
         U4x4cLNlupik9aPrxRGTgzg0ggygllWVrPj2wP5gC5BPCtZ4WGO/dkXc42gV7shura+D
         TqzDhi4HkVIhTscFBuyXTp7jG/Itj2rACBM2AggDoA5lQSEUktM0Y3+02vKRS5A0VJvd
         bgDjEK7CpI10sRAqui/CuTY/nVbKY9jrIYe1Wl2TW1GOj8+z+9IGOGPObsaI+B47iUvU
         2pWA==
X-Forwarded-Encrypted: i=1; AFNElJ+x7QSiSXvxLocun84yoA+F+tSTrB3nXdUrOWCvNHWkdu1i2QTg7F6FI6ubKybg27kg/nwB0Pc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9yeyAazf2d9E/kX7RQlmJq7QMjdltC91iFXWWJEwhqqxNujUc
	lOHLP8H1h+xj3QKXrxhXh90lVipqspi2pHz3RiGKFHAAkFR2bvDCePKW
X-Gm-Gg: Acq92OGkKXjO87jbRuldHBhsbfEuKdM068VV0aXdvfZKjP5JWIjXK+tIRQHixKG6Ow2
	SwjWW3h9EzmsgEo3Utmpz2RXieVvE4REbqhhFnheFDGatqCcyMMWXZfd0G1AankkZwzWlbIg85a
	6cMdpsletba8jdWaVUqU+O1hwqWZuF4at1RJuqacB6N7sBf/i/mwsFgQem60OwFMn3nrdFCt0lF
	ob7fs6aMAA34S09PLP5Tim7e9lC3+trsikBZTKymRn5Xd8OHitk/N2qICo6LJtZQGXp+9/UtoFF
	tCRSVf0Outt/4/qtyAOaxYQz40mGLpMM7stDGRg9kWFkdozHvhIpMac2zHo/R1ueLX1ZR4MKkFO
	thohMn2Ra7kxJCnzAwy6eY/Y8FvoIGFzIRL2CZQY0d5qkm9lgBwrihVzVLN5en4AkR0d2/rVn2u
	tAv4iMbAKR/b11vhnrKtv6n9VubwDyPhJ99qREdkW7L8CT6XXcjXxXJiX9BvVuuWMyt+CXDVM53
	vbrhXA9kUVNY3Bu0dWroqN3k+0NllM=
X-Received: by 2002:a05:620a:6011:b0:915:9bc2:8019 with SMTP id af79cd13be357-915a9dcbc87mr1702881385a.53.1780773272045;
        Sat, 06 Jun 2026 12:14:32 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00a4f4sm1311699285a.3.2026.06.06.12.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 12:14:31 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/4] tipc: validate discovery message length before reading media address
Date: Sat,  6 Jun 2026 15:14:11 -0400
Message-ID: <357fb271180356b1ab2355da9702927f4785f805.1780766454.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780766454.git.michael.bommarito@gmail.com>
References: <cover.1780766454.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296138-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ying.xue@windriver.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9455B64E1B7

tipc_disc_rcv() reads the sender's media address from the fixed
media-info area of the header (msg_media_addr(), offset
TIPC_MEDIA_INFO_OFFSET) and, when the peer advertises 128-bit node
ids, copies a NODE_ID_LEN node id appended after the header. Neither
read is bounded against the actual received length: tipc_msg_validate()
only enforces a header size in the range [MIN_H_SIZE, MAX_H_SIZE], so a
LINK_CONFIG message as short as MIN_H_SIZE (24 bytes) passes validation
while the media-address read reaches up to MAX_H_SIZE and the node-id
read reaches MAX_H_SIZE + NODE_ID_LEN.

A node always builds discovery messages at MAX_H_SIZE + NODE_ID_LEN
(tipc_disc_init_msg()), so a shorter LINK_CONFIG message is malformed.
Drop such messages before the reads so the media address and node id
are taken from received data rather than from uninitialised tail room
or memory beyond the buffer.

A crafted short LINK_CONFIG datagram otherwise makes tipc_disc_rcv()
read past the received message data when a bearer is enabled.

Fixes: 3d749a6a26b0 ("tipc: Hide media-specific addressing details from generic bearer code")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/tipc/discover.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/tipc/discover.c b/net/tipc/discover.c
index 3e54d2df5683a..daf5f11fc82b4 100644
--- a/net/tipc/discover.c
+++ b/net/tipc/discover.c
@@ -217,6 +217,20 @@ void tipc_disc_rcv(struct net *net, struct sk_buff *skb,
 	}
 	hdr = buf_msg(skb);
 
+	/* A discovery message carries the sender's media address within the
+	 * fixed-size header and, when 128-bit ids are advertised, a node id
+	 * appended after it.  A node always builds these messages at
+	 * MAX_H_SIZE + NODE_ID_LEN, so drop anything too short to hold what
+	 * is read below and keep msg2addr() and the node-id copy within the
+	 * received data.
+	 */
+	if (skb->len < MAX_H_SIZE ||
+	    ((caps & TIPC_NODE_ID128) && skb->len < MAX_H_SIZE + NODE_ID_LEN)) {
+		pr_warn_ratelimited("Rcv corrupt discovery message\n");
+		kfree_skb(skb);
+		return;
+	}
+
 	if (caps & TIPC_NODE_ID128)
 		memcpy(peer_id, msg_node_id(hdr), NODE_ID_LEN);
 	else
-- 
2.53.0


