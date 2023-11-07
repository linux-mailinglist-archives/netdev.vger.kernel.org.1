Return-Path: <netdev+bounces-46384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0AC7E3846
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 10:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD887280FBF
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 09:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7896514F87;
	Tue,  7 Nov 2023 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="adFYU4MQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9738D13AE1
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 09:54:39 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E9411F
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 01:54:37 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507adc3381cso7005888e87.3
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 01:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699350876; x=1699955676; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xqcp7l3sLztmXNgaaMhSUStMniJux5ggXCgPLhgfhw=;
        b=adFYU4MQxEKKhXpBtF7fw+thICJ5HzrvT+a7pdKXbaMYgHsw1EhSFc3jMKUj5Tu+tD
         CiyQZs6odu83KWCO67Y1/2RMJQEp0TOr1bjeqnrIurfnrBlttONhJzYUqzlMBdfVCg5N
         UGLBfCMVOlhU4TbjisXu85yPVgN+AULp/jC9vurJsl904JB/ZdZoEMi1c4gU1U3ANRL6
         UjYnsHaeOoP3x/VPjpazXLV4OyoxmoZLlvpXdbfy57MyNN2ox+tSPrLsbOmP91uhbyfx
         KKRINZzME6aJpVnFztFQcrGYRzt64CFv4c6h6r+v0HBcfQXzHq1Z1465CYKEcTYCs8xW
         yajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699350876; x=1699955676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xqcp7l3sLztmXNgaaMhSUStMniJux5ggXCgPLhgfhw=;
        b=frQfZFO2aKqpLitzSolTfDp2yd/n4djByxXaGrtGcDlpLW8J17GH4iBCbGbtPIb6XO
         N7b4bHRPwVTHhAvkt1ZFC7+G6qKXRuKczdySA4AmLWkIo6HRvF6OlSfrx8TczZOTv0Vc
         xLDGHIOUDM2Wij/EPSQyXjvdDLUrd3D0AsfYmsR8ocH5pQ0J3QVGKUUOah1ebZWAuWsU
         FRKrx1a9uc7BVYUNLHVMXbrOGuQDq+lTigMyXekF9eQveZbKpJM+HHHtwacnYojLiLS4
         zhNcdTCEhFUdnPVjN+4YNmw9yb6m2gqg0m5O3xb7157aUqmgGpdb5WXHofI+XtWuDHbq
         9NYw==
X-Gm-Message-State: AOJu0Yy6l/DwA3527pFhd7jhTPRmpQ/mFJW2TitYQ21GMVoF+pu7YYKL
	t5Pmt2pptZtP8KG/JUSZFZYOiw==
X-Google-Smtp-Source: AGHT+IEF5MBAZYuBJjtXQUrFPyFp3vNlwVPxymtsM4RhEBsU9XfIdzPTR44CE8k76aI55w2oKoPhpw==
X-Received: by 2002:ac2:504d:0:b0:509:4a02:49f7 with SMTP id a13-20020ac2504d000000b005094a0249f7mr11388717lfm.44.1699350876033;
        Tue, 07 Nov 2023 01:54:36 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id m25-20020ac24ad9000000b005091314185asm296356lfp.285.2023.11.07.01.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 01:54:35 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 07 Nov 2023 10:54:28 +0100
Subject: [PATCH net v3 3/4] net: ethernet: cortina: Handle large frames
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231107-gemini-largeframe-fix-v3-3-e3803c080b75@linaro.org>
References: <20231107-gemini-largeframe-fix-v3-0-e3803c080b75@linaro.org>
In-Reply-To: <20231107-gemini-largeframe-fix-v3-0-e3803c080b75@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

The Gemini ethernet controller provides hardware checksumming
for frames up to 1514 bytes including ethernet headers but not
FCS.

If we start sending bigger frames (after first bumping up the MTU
on both interfaces sending and receiveing the frames), truncated
packets start to appear on the target such as in this tcpdump
resulting from ping -s 1474:

23:34:17.241983 14:d6:4d:a8:3c:4f (oui Unknown) > bc:ae:c5:6b:a8:3d (oui Unknown),
ethertype IPv4 (0x0800), length 1514: truncated-ip - 2 bytes missing!
(tos 0x0, ttl 64, id 32653, offset 0, flags [DF], proto ICMP (1), length 1502)
OpenWrt.lan > Fecusia: ICMP echo request, id 1672, seq 50, length 1482

If we bypass the hardware checksumming and provide a software
fallback, everything starts working fine up to the max TX MTU
of 2047 bytes, for example ping -s2000 192.168.1.2:

00:44:29.587598 bc:ae:c5:6b:a8:3d (oui Unknown) > 14:d6:4d:a8:3c:4f (oui Unknown),
ethertype IPv4 (0x0800), length 2042:
(tos 0x0, ttl 64, id 51828, offset 0, flags [none], proto ICMP (1), length 2028)
Fecusia > OpenWrt.lan: ICMP echo reply, id 1683, seq 4, length 2008

The bit enabling to bypass hardware checksum (or any of the
"TSS" bits) are undocumented in the hardware reference manual.
The entire hardware checksum unit appears undocumented. The
conclusion that we need to use the "bypass" bit was found by
trial-and-error.

Since no hardware checksum will happen, we slot in a software
checksum fallback.

Check for the condition where we need to compute checksum on the
skb with either hardware or software using == CHECKSUM_PARTIAL instead
of != CHECKSUM_NONE which is an incomplete check according to
<linux/skbuff.h>.

We delete the code disabling the hardware checksum for large
MTU:s: this is suboptimal because it will disable hardware
checksumming also on small packets which the checksumming
engine can handle just fine, which is a waste of resources.

On the D-Link DIR-685 router this fixes a bug on the conduit
interface to the RTL8366RB DSA switch: as the switch needs to add
space for its tag it increases the MTU on the conduit interface
to 1504 and that means that when the router sends packages
of 1500 bytes these get an extra 4 bytes of DSA tag and the
transfer fails because of the erroneous hardware checksumming,
affecting such basic functionality as the LuCI web interface.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index b21a94b4ab5c..78287cfcbf63 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1145,6 +1145,7 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	dma_addr_t mapping;
 	unsigned short mtu;
 	void *buffer;
+	int ret;
 
 	mtu  = ETH_HLEN;
 	mtu += netdev->mtu;
@@ -1159,9 +1160,30 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 		word3 |= mtu;
 	}
 
-	if (skb->ip_summed != CHECKSUM_NONE) {
+	if (skb->len >= ETH_FRAME_LEN) {
+		/* Hardware offloaded checksumming isn't working on frames
+		 * bigger than 1514 bytes. A hypothesis about this is that the
+		 * checksum buffer is only 1518 bytes, so when the frames get
+		 * bigger they get truncated, or the last few bytes get
+		 * overwritten by the FCS.
+		 *
+		 * Just use software checksumming and bypass on bigger frames.
+		 */
+		if (skb->ip_summed == CHECKSUM_PARTIAL) {
+			ret = skb_checksum_help(skb);
+			if (ret)
+				return ret;
+		}
+		word1 |= TSS_BYPASS_BIT;
+	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		int tcp = 0;
 
+		/* We do not switch off the checksumming on non TCP/UDP
+		 * frames: as is shown from tests, the checksumming engine
+		 * is smart enough to see that a frame is not actually TCP
+		 * or UDP and then just pass it through without any changes
+		 * to the frame.
+		 */
 		if (skb->protocol == htons(ETH_P_IP)) {
 			word1 |= TSS_IP_CHKSUM_BIT;
 			tcp = ip_hdr(skb)->protocol == IPPROTO_TCP;
@@ -1978,15 +2000,6 @@ static int gmac_change_mtu(struct net_device *netdev, int new_mtu)
 	return 0;
 }
 
-static netdev_features_t gmac_fix_features(struct net_device *netdev,
-					   netdev_features_t features)
-{
-	if (netdev->mtu + ETH_HLEN + VLAN_HLEN > MTU_SIZE_BIT_MASK)
-		features &= ~GMAC_OFFLOAD_FEATURES;
-
-	return features;
-}
-
 static int gmac_set_features(struct net_device *netdev,
 			     netdev_features_t features)
 {
@@ -2212,7 +2225,6 @@ static const struct net_device_ops gmac_351x_ops = {
 	.ndo_set_mac_address	= gmac_set_mac_address,
 	.ndo_get_stats64	= gmac_get_stats64,
 	.ndo_change_mtu		= gmac_change_mtu,
-	.ndo_fix_features	= gmac_fix_features,
 	.ndo_set_features	= gmac_set_features,
 };
 

-- 
2.34.1


