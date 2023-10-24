Return-Path: <netdev+bounces-43986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B757D5BD2
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 21:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39C80B20F79
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 19:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008223CD19;
	Tue, 24 Oct 2023 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyeOZbTc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5181E266A9
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 19:50:05 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E4510DB
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 12:50:03 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7789a4c01easo314858885a.0
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 12:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698177002; x=1698781802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=maw6NhMTUWspoHmkMBm+asPwHK+fd6vySlok/+0d7pw=;
        b=PyeOZbTciYhmStcZ6R5P+CVNnvS2Fftd/q9qTYnQbdnBXxs/1ZBA4OVxkfjqHaNEnn
         MGyJFY4SaMyGAUM5XZIpuzZDAs3fhdSLLg5syeCzPlN49oOBi6+J5xNncsmhDQe9W8+P
         ww+JqYkyFrCQP6B3y0kvx2qfodjPGEf93655nKbrBm7ijTJ44ty0N4aI1/TLfa1O1Pev
         q3K/OS2LL+bxfepwM1S7WPAr+3o/EEtukfv0q6TA7Fph0WqxRbORhW2GZADJpBqe4ZMl
         slvETm1L05e3P53I+4zzfQNQIpfKdCuiOTDSVlO3ekTNcZKUE3VbO7GDaSEB/crkRO+y
         tUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698177002; x=1698781802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maw6NhMTUWspoHmkMBm+asPwHK+fd6vySlok/+0d7pw=;
        b=q1QFDHKRMZle8rDr5D7Zm3MwAxxvNPyFOAakpepVvinPMYmbWT1/gb4vih/Fxy4Nrt
         7L5XEZhopbkGaPpaWIbH+HFwDwKpR9jPlNj1oGb2+/E2ekbb2g5hqSY0AzvTD9R2wNQ/
         MfFYb5yfASWus1Z0JdaMiynk+ZG7EzMBXWmKHowMyXlEIl7/dfWu/th2BIQCOfzWgMKK
         85I7ytjLeJpibEyz9ptfVecrj/poSBHvWIYUpPdGL+SZuh48ds5xR0CYTRx2dvTJbw+Q
         4A82e8wI/MIIVPs1Q+yhLj+ZcGSczmshT8u+hDhaJWfAazOyH/BevWhy2hMDwxtuLXO1
         YngQ==
X-Gm-Message-State: AOJu0YyOqBWC2dC9F3Zoo4dEQgcHOj2X+nXSb3ILlNhzsxCHU1GO1ItK
	DHc2cr1z9+JAiTz+l96CpcppH6Wr8Ws=
X-Google-Smtp-Source: AGHT+IGTPuA2V8sRPZDCyToeMaCzb76Fhwyk122lkv766VWtv3wQ41yDSjzAbf/89EPfH8CcNTTgqA==
X-Received: by 2002:a05:620a:280b:b0:76d:bda0:e48e with SMTP id f11-20020a05620a280b00b0076dbda0e48emr15223354qkp.46.1698177002275;
        Tue, 24 Oct 2023 12:50:02 -0700 (PDT)
Received: from willemb.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id r16-20020a05620a299000b0076ef3e6e6a4sm3674792qkp.42.2023.10.24.12.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 12:50:01 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Willem de Bruijn <willemb@google.com>,
	syzbot+a8c7be6dee0de1b669cc@syzkaller.appspotmail.com
Subject: [PATCH net] llc: verify mac len before reading mac header
Date: Tue, 24 Oct 2023 15:49:36 -0400
Message-ID: <20231024194958.3522281-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

LLC reads the mac header with eth_hdr without verifying that the skb
has an Ethernet header.

Syzbot was able to enter llc_rcv on a tun device. Tun can insert
packets without mac len and with user configurable skb->protocol
(passing a tun_pi header when not configuring IFF_NO_PI).

    BUG: KMSAN: uninit-value in llc_station_ac_send_test_r net/llc/llc_station.c:81 [inline]
    BUG: KMSAN: uninit-value in llc_station_rcv+0x6fb/0x1290 net/llc/llc_station.c:111
    llc_station_ac_send_test_r net/llc/llc_station.c:81 [inline]
    llc_station_rcv+0x6fb/0x1290 net/llc/llc_station.c:111
    llc_rcv+0xc5d/0x14a0 net/llc/llc_input.c:218
    __netif_receive_skb_one_core net/core/dev.c:5523 [inline]
    __netif_receive_skb+0x1a6/0x5a0 net/core/dev.c:5637
    netif_receive_skb_internal net/core/dev.c:5723 [inline]
    netif_receive_skb+0x58/0x660 net/core/dev.c:5782
    tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1555
    tun_get_user+0x54c5/0x69c0 drivers/net/tun.c:2002

Add a mac_len test before all three eth_hdr(skb) calls under net/llc.

There are further uses in include/net/llc_pdu.h. All these are
protected by a test skb->protocol == ETH_P_802_2. Which does not
protect against this tun scenario.

But the mac_len test added in this patch in llc_fixup_skb will
indirectly protect those too. That is called from llc_rcv before any
other LLC code.

It is tempting to just add a blanket mac_len check in llc_rcv, but
not sure whether that could break valid LLC paths that do not assume
an Ethernet header. 802.2 LLC may be used on top of non-802.3
protocols in principle.

Reported-by: syzbot+a8c7be6dee0de1b669cc@syzkaller.appspotmail.com
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 net/llc/llc_input.c   | 10 ++++++++--
 net/llc/llc_s_ac.c    |  3 +++
 net/llc/llc_station.c |  3 +++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index 7cac441862e21..51bccfb00a9cd 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -127,8 +127,14 @@ static inline int llc_fixup_skb(struct sk_buff *skb)
 	skb->transport_header += llc_len;
 	skb_pull(skb, llc_len);
 	if (skb->protocol == htons(ETH_P_802_2)) {
-		__be16 pdulen = eth_hdr(skb)->h_proto;
-		s32 data_size = ntohs(pdulen) - llc_len;
+		__be16 pdulen;
+		s32 data_size;
+
+		if (skb->mac_len < ETH_HLEN)
+			return 0;
+
+		pdulen = eth_hdr(skb)->h_proto;
+		data_size = ntohs(pdulen) - llc_len;
 
 		if (data_size < 0 ||
 		    !pskb_may_pull(skb, data_size))
diff --git a/net/llc/llc_s_ac.c b/net/llc/llc_s_ac.c
index 79d1cef8f15a9..7923c064773cc 100644
--- a/net/llc/llc_s_ac.c
+++ b/net/llc/llc_s_ac.c
@@ -153,6 +153,9 @@ int llc_sap_action_send_test_r(struct llc_sap *sap, struct sk_buff *skb)
 	int rc = 1;
 	u32 data_size;
 
+	if (skb->mac_len < ETH_HLEN)
+		return 0;
+
 	llc_pdu_decode_sa(skb, mac_da);
 	llc_pdu_decode_da(skb, mac_sa);
 	llc_pdu_decode_ssap(skb, &dsap);
diff --git a/net/llc/llc_station.c b/net/llc/llc_station.c
index 05c6ae0920534..f506542925109 100644
--- a/net/llc/llc_station.c
+++ b/net/llc/llc_station.c
@@ -76,6 +76,9 @@ static int llc_station_ac_send_test_r(struct sk_buff *skb)
 	u32 data_size;
 	struct sk_buff *nskb;
 
+	if (skb->mac_len < ETH_HLEN)
+		goto out;
+
 	/* The test request command is type U (llc_len = 3) */
 	data_size = ntohs(eth_hdr(skb)->h_proto) - 3;
 	nskb = llc_alloc_frame(NULL, skb->dev, LLC_PDU_TYPE_U, data_size);
-- 
2.42.0.758.gaed0368e0e-goog


