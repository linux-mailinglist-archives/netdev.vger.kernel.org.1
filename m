Return-Path: <netdev+bounces-296045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e++6OqyzI2oLxQEAu9opvQ
	(envelope-from <netdev+bounces-296045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 07:44:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4903264C9C1
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 07:44:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=I29lxOed;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296045-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296045-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B229305687B
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 05:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D99C318146;
	Sat,  6 Jun 2026 05:42:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8294305676;
	Sat,  6 Jun 2026 05:42:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780724569; cv=none; b=TqYe2HZnMrfUfTWLDFzWI9ly0FlmpIIF5ykBhwxjTtHpDecKSmGHojQ4gQQTjS+h1cxn1Waf8TLmvZFs1KNjUtI0jZp08xyuKAzWFlHt/XNetK5E6GDcOOfdTeztSDlmqAsIscUfNGZJx3UZ9TqPv+OS6aDmOORGuS5oK2AtfZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780724569; c=relaxed/simple;
	bh=pZvTlPEHnVoq7eY/dHY7MDK1DnQZ3Ydm8xyowN1LaiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hK78hi6cf7aEOQXD7oH+cnTOCwCzicZihcxfaoqTRgEkaQOYEoPFpQh5+4STuYTwsew9+JeoQbUffBfT1XqXL6tKahkhH3FLkqY5NsFkMCANMNlL0ZwGArCGYcDy3WoVV6GB1lt7fJhr7sfLp0UbngsZZOWyEjthtQyzm+HHUn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I29lxOed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EEDDC2BCFD;
	Sat,  6 Jun 2026 05:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780724569;
	bh=pZvTlPEHnVoq7eY/dHY7MDK1DnQZ3Ydm8xyowN1LaiU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=I29lxOedxsboQnhEI0SONS1bEEYZBrkNjQ90YqRMstupDQE5n3OgIN+2LpQmMKwBJ
	 OrXvj9ASj2AkNi1oQzASF46bF6VWnm7pl16m+QkwvZoFOjOZKkiFKvFGBN7yQjlK6E
	 iTRnZp0fxSCP7uaVUz8jMFAjqOmmoIowC5IBtPDCKTL4bzMe+UIX/2RKrkIZqjM0Qc
	 n+ktvTeOmO2Nj5k3y38E4CispczWJOSHTzmAOyTBhEZ8qSN3rnfgOOKqs47yK9NK4i
	 CiGl7ryykkGOQm6fylxlKmPsu889zcxs4VjnR6/QQrOLITg4j+GzowOfhJA3aj3hze
	 gdbPVBRwtzzKg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982E6CD8C90;
	Sat,  6 Jun 2026 05:42:49 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 05 Jun 2026 22:42:39 -0700
Subject: [PATCH net-next v4 08/16] net: ethernet: oa_tc6: Remove FCS size
 in RX frame
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-s2500-mac-phy-support-v4-8-de0fbc13c6d8@onsemi.com>
References: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
In-Reply-To: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780724562; l=1396;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=Nwz8ph63R7fgKGIZDndf/9epwjHtj0F853lNYFbk53o=;
 b=EkPoE0N561Rn6mpFwlh2B8OkMCBA4T9JKP5di9atN9IusrrG4l799ud9ZyAEVXZYpc5C9VJS3
 +mSc/YXu2pyAT0kjQIiCQ85m8Tqggx1D5x6K486h+gwMsU2u0b79nSm
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296045-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:pier.beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:selvamani.rajagopal@onsemi.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:Selvamani.Rajagopal@onsemi.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[Selvamani.Rajagopal@onsemi.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4903264C9C1

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

OA TC6 MAC-PHY appends FCS to the incoming frame.
It is removed from the frame before being passed to the stack.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 drivers/net/ethernet/oa_tc6/oa_tc6.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6.c b/drivers/net/ethernet/oa_tc6/oa_tc6.c
index 2f9ace655e81..26033373f16f 100644
--- a/drivers/net/ethernet/oa_tc6/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6/oa_tc6.c
@@ -782,12 +782,22 @@ static void oa_tc6_submit_rx_skb(struct oa_tc6 *tc6)
 {
 	oa_tc6_update_ts_in_rx_skb(tc6);
 
+	/* MAC-PHY delivers each frame with its Ethernet FCS attached.
+	 * Strip it before handing over to the stack, unless the user
+	 * has asked to keep it via NETIF_F_RXFCS. Keeping the FCS
+	 * in the frame is harmless for IP traffic, but is parsed as
+	 * a (malformed) suffix TLV by PTP, which makes ptp4l reject
+	 * every message with "bad message" error.
+	 */
+	if (!(tc6->netdev->features & NETIF_F_RXFCS) &&
+			tc6->rx_skb->len > ETH_FCS_LEN)
+		skb_trim(tc6->rx_skb, tc6->rx_skb->len - ETH_FCS_LEN);
+
 	tc6->rx_skb->protocol = eth_type_trans(tc6->rx_skb, tc6->netdev);
 	tc6->netdev->stats.rx_packets++;
 	tc6->netdev->stats.rx_bytes += tc6->rx_skb->len;
 
 	netif_rx(tc6->rx_skb);
-
 	tc6->rx_skb = NULL;
 }
 

-- 
2.43.0



