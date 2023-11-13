Return-Path: <netdev+bounces-47402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2384C7EA190
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 17:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7268EB2089F
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 16:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8911420B38;
	Mon, 13 Nov 2023 16:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="tbZSuFmy"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E28D22309
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 16:57:31 +0000 (UTC)
X-Greylist: delayed 408 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Nov 2023 08:57:31 PST
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150C9D59
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 08:57:31 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id E20D5C0000F8;
	Mon, 13 Nov 2023 08:50:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com E20D5C0000F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1699894241;
	bh=9tYcZbeteCSzUeb5BAfg8kvTY0sU1YEKvYdln3CCNik=;
	h=From:To:Cc:Subject:Date:From;
	b=tbZSuFmytvRL6cUeBvX0cXJNotWkz40/rESxo0FWqj9EUBDiEM2lFh2GulcVak1tJ
	 RGqKRJexXnPVvp0GsVV6SbAnelsfRJGAHpe4b0TaV6GBWYlz8sSo+LrgtxOLY5XeCG
	 u4tUECbOFHwaBQHMtRDlozFAYBOLljjmNikPev9o=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 8836A18041CAC4;
	Mon, 13 Nov 2023 08:50:40 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: dsa: tag_rtl4_a: Use existing ETH_P_REALTEK constant
Date: Mon, 13 Nov 2023 08:50:30 -0800
Message-Id: <20231113165030.2440083-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional change, uses the existing ETH_P_REALTEK constant already
defined in if_ether.h.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 net/dsa/tag_rtl4_a.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/dsa/tag_rtl4_a.c b/net/dsa/tag_rtl4_a.c
index 4da5bad1a7aa..a019226ec6d2 100644
--- a/net/dsa/tag_rtl4_a.c
+++ b/net/dsa/tag_rtl4_a.c
@@ -23,7 +23,6 @@
 #define RTL4_A_NAME		"rtl4a"
 
 #define RTL4_A_HDR_LEN		4
-#define RTL4_A_ETHERTYPE	0x8899
 #define RTL4_A_PROTOCOL_SHIFT	12
 /*
  * 0x1 = Realtek Remote Control protocol (RRCP)
@@ -54,7 +53,7 @@ static struct sk_buff *rtl4a_tag_xmit(struct sk_buff *skb,
 
 	/* Set Ethertype */
 	p = (__be16 *)tag;
-	*p = htons(RTL4_A_ETHERTYPE);
+	*p = htons(ETH_P_REALTEK);
 
 	out = (RTL4_A_PROTOCOL_RTL8366RB << RTL4_A_PROTOCOL_SHIFT);
 	/* The lower bits indicate the port number */
@@ -82,7 +81,7 @@ static struct sk_buff *rtl4a_tag_rcv(struct sk_buff *skb,
 	tag = dsa_etype_header_pos_rx(skb);
 	p = (__be16 *)tag;
 	etype = ntohs(*p);
-	if (etype != RTL4_A_ETHERTYPE) {
+	if (etype != ETH_P_REALTEK) {
 		/* Not custom, just pass through */
 		netdev_dbg(dev, "non-realtek ethertype 0x%04x\n", etype);
 		return skb;
-- 
2.34.1


