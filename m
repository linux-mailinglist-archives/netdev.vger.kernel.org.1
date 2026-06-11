Return-Path: <netdev+bounces-298367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7B97Lu8uK2ov3wMAu9opvQ
	(envelope-from <netdev+bounces-298367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:55:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F9567580F
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:55:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=nWnrCgGg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298367-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298367-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B848432E7861
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815E8389E05;
	Thu, 11 Jun 2026 21:55:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550E33806A1;
	Thu, 11 Jun 2026 21:55:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781214953; cv=none; b=nuZRyxdu5dMzKdS7KfoAPHplUath6FCgTX8baXHv+/zTkwLQ3Oxpxjy/74vJe06B8eGb2ktniewCaU8rom21a+oQdM1taqqiRkbir59DlMf6UTE5yoPGhblQ0uROTPSuSZhF8/SNQxwvm8XuU1easBpKm6UDW+T+O1k8Dh0zdKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781214953; c=relaxed/simple;
	bh=Mx5f6xZMrf4AEZMl2qB5kpZYfcH4Mh0IHXybydzATbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oVZjGzS7h1UTsO5hXtV3L8vlgLdvU+nJ7z0eFvSAVqdiMjMqBjxa9ctzzXRO5ZB43rLiCdlf+Vcecdi4cBbKS2QWHs/S/uR3NKd8SFoTfBiro7XnW4k/9QxL6cZ6fr3z5ctCGoT/jq7qX2ENxuJC7KqGLgHeL07j8XbwrLw0wBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWnrCgGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24CABC4AF14;
	Thu, 11 Jun 2026 21:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781214953;
	bh=Mx5f6xZMrf4AEZMl2qB5kpZYfcH4Mh0IHXybydzATbc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nWnrCgGgvXn/y5NuFB712CZdR/pnwhv3JeoMG+Bkw4UM3vfrAOYouQuc4YwFRhx8+
	 33/1UPjt7BCU75EEYQwB6r8+Grbmx6RL0oRzZxsEFiNowLYOWEbGuoDu6Y1TBa+SBT
	 H9yYj5YTKu0wRA+R4kuOlHtmDduZcUNyqz8VFDHRSgLuTE6qwqsKtDaajYDfv7V23Y
	 IYTeZoNsn0gAHqzkvUKc6NVds/5L/TLd0w8JM+HPEoT+/sS68Wv5lGPFEZ9p5GwGsH
	 QDTlbk8zFIx2V4RY5sa4uFxa76i9ko5OYQ1jCqgojnanJ6M1upr7j7YW+xfFJGNcw5
	 yu9re3urX96NQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8A2CD98D6;
	Thu, 11 Jun 2026 21:55:53 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Thu, 11 Jun 2026 14:55:40 -0700
Subject: [PATCH net v5 3/4] net: ethernet: oa_tc6: Remove FCS size in RX
 frame
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-level-trigger-v5-3-4533a9e85ce2@onsemi.com>
References: <20260611-level-trigger-v5-0-4533a9e85ce2@onsemi.com>
In-Reply-To: <20260611-level-trigger-v5-0-4533a9e85ce2@onsemi.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781214947; l=1897;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=YZshO9vJiupuwF8u2s55Iy23XRYxDayecyVSa8eiy20=;
 b=UpSME0oOCYqxWCD3IkDDk6YqIiDW9UbcinlWaws8ptJWT3MI53GJpjSZRJBoA+TIa5JosNOcq
 VOciggEh+NDBc6So4IKCVhZQ05xrhAiD2XSK4/vbOSoL89whQr0k5UX
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
	TAGGED_FROM(0.00)[bounces-298367-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
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
X-Rspamd-Queue-Id: 58F9567580F

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

OA TC6 MAC-PHY appends FCS to the incoming frame. It must be
removed from the frame before being passed to the stack.

With FCS in the frame, many applications, like ping or any
application that uses IP layer may work as they may
carry the packet size information in the protocol.

Application like ptp4l, particularly if it uses layer 2
for its communication, it will fail with "bad message" due to
the extra 4 bytes added by the presence of FCS.

Fixes: d70a0d8f2f2d ("net: ethernet: oa_tc6: implement receive path to receive rx ethernet frames")
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v5
  - Removed FCS present at the end of the MAC frame before being
    passed to the stack.
  - new patch
---
 drivers/net/ethernet/oa_tc6.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 477ceefde2c5..0727d53345a3 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -785,6 +785,17 @@ static int oa_tc6_process_rx_chunk_footer(struct oa_tc6 *tc6, u32 footer)
 
 static void oa_tc6_submit_rx_skb(struct oa_tc6 *tc6)
 {
+	/* MAC-PHY delivers each frame with its Ethernet FCS attached.
+	 * Strip it before handing over to the stack, unless the user
+	 * has asked to keep it via NETIF_F_RXFCS. Keeping the FCS
+	 * in the frame is harmless for IP traffic, but is parsed as
+	 * a (malformed) suffix TLV by PTP, which makes ptp4l reject
+	 * every message with "bad message" error.
+	 */
+	if (!(tc6->netdev->features & NETIF_F_RXFCS) &&
+	    tc6->rx_skb->len > ETH_FCS_LEN)
+		skb_trim(tc6->rx_skb, tc6->rx_skb->len - ETH_FCS_LEN);
+
 	tc6->rx_skb->protocol = eth_type_trans(tc6->rx_skb, tc6->netdev);
 	tc6->netdev->stats.rx_packets++;
 	tc6->netdev->stats.rx_bytes += tc6->rx_skb->len;

-- 
2.43.0



