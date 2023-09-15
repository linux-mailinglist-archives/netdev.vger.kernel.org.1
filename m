Return-Path: <netdev+bounces-34063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327F87A1EA7
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 14:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3ED282AF1
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 12:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AB11079B;
	Fri, 15 Sep 2023 12:24:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DDF10788
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:24:29 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D716268E
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 05:24:18 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5657add1073so1526708a12.0
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 05:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694780658; x=1695385458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lz+KwltvljtV/MAPhQIKZt+LMsG+MjU6bvq7aqjMrAg=;
        b=b4YmHcN4Am22cYKSuL/PiXsUH0SAsAYyykE79ikxUJzj2S7DJ8Y29D6eCCDAkPoJZ7
         3jPgcwNXn9+jPw2mk/G/IQDl2oDcl50B/2JHrnR+DFZ8FOb7gQrhDBk6v0ShHO5jEyfn
         KX/esqqf4bmbHo5aIN/X7ShQBy6fCiQ2taBho36byWN8pgJUw5+77VLYVTw8e050TB0Q
         hsVziGF5ED5Pz3KGAMOFHJjUxqcAKN9xlsK3BjSdDUC6kb9VZaIxMOfJbwB6M79+yyfO
         dPVRZPigUEzNU8PyAKeLXOpheghlW7dMPukP87GlOkIrCQxEyWPTtn+TYLSkcgKFlUCl
         tKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694780658; x=1695385458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lz+KwltvljtV/MAPhQIKZt+LMsG+MjU6bvq7aqjMrAg=;
        b=fRCnkXRiNt9DmVRohQqDR5MY7Krp3UOLUwizf0TersIGWxkMD4Fi3ox59pz26B1OBp
         +t2sVWae1oD9b54gjAMqESsKZrfiYYngPCfGF57jzD5hUmOAirK7ZFXN0SiuH2AvfWma
         qiOGB89zJkBr+JADqA2llKeM0+howvrpgpZUEygaZmRJkFafTFlwkkPNbD6yEThhCInc
         HgLcbMZhM9lemkwTKkyBwTsgmpLO9XMhLdNtp+fb0hE+SJqD0x6A1Hj9yQVgnlsFlTCo
         Jnnp+10ue5Jb5kSMASptANHMlWXNotfL7BF9VZdZ9dEV6Ssx61T/Z9/+8Bwc0fByetjB
         yuIg==
X-Gm-Message-State: AOJu0Yxv5grG9PPr644T/o2zTfe23XztbeJR15XXI92w7nrRmIlNa8z8
	IuQwrrcwok7WvM+CKrpsrMLm3cbOavUg3Q==
X-Google-Smtp-Source: AGHT+IG9tfu/vaUFy5XipV53xEIlZP2C0sUshnq2L6iUOHSz0VkYqmEMAOC8j3t4JpiiphUymHoevA==
X-Received: by 2002:a17:90b:a43:b0:273:e090:6096 with SMTP id gw3-20020a17090b0a4300b00273e0906096mr2087317pjb.11.1694780657995;
        Fri, 15 Sep 2023 05:24:17 -0700 (PDT)
Received: from 192.168.0.123 ([199.119.202.101])
        by smtp.googlemail.com with ESMTPSA id 23-20020a17090a199700b00267eead2f16sm3167231pji.36.2023.09.15.05.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 05:24:16 -0700 (PDT)
From: Liang Chen <liangchen.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	benjamin.poirier@gmail.com
Cc: netdev@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH net-next v3 2/2] pktgen: Introducing 'SHARED' flag for testing with non-shared skb
Date: Fri, 15 Sep 2023 20:23:17 +0800
Message-Id: <20230915122317.100390-2-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230915122317.100390-1-liangchen.linux@gmail.com>
References: <20230915122317.100390-1-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, skbs generated by pktgen always have their reference count
incremented before transmission, causing their reference count to be
always greater than 1, leading to two issues:
  1. Only the code paths for shared skbs can be tested.
  2. In certain situations, skbs can only be released by pktgen.
To enhance testing comprehensiveness, we are introducing the "SHARED"
flag to indicate whether an SKB is shared. This flag is enabled by
default, aligning with the current behavior. However, disabling this
flag allows skbs with a reference count of 1 to be transmitted.
So we can test non-shared skbs and code paths where skbs are released
within the stack.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>

---
 Changes from v2:
- Lifted the check on 'count' when 'not shared' is configured.
- Fixed a use-after-free problem when sending failed
---
 Documentation/networking/pktgen.rst | 12 ++++++++
 net/core/pktgen.c                   | 47 ++++++++++++++++++++++++-----
 2 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/pktgen.rst b/Documentation/networking/pktgen.rst
index 1225f0f63ff0..c945218946e1 100644
--- a/Documentation/networking/pktgen.rst
+++ b/Documentation/networking/pktgen.rst
@@ -178,6 +178,7 @@ Examples::
 			      IPSEC # IPsec encapsulation (needs CONFIG_XFRM)
 			      NODE_ALLOC # node specific memory allocation
 			      NO_TIMESTAMP # disable timestamping
+			      SHARED # enable shared SKB
  pgset 'flag ![name]'    Clear a flag to determine behaviour.
 			 Note that you might need to use single quote in
 			 interactive mode, so that your shell wouldn't expand
@@ -288,6 +289,16 @@ To avoid breaking existing testbed scripts for using AH type and tunnel mode,
 you can use "pgset spi SPI_VALUE" to specify which transformation mode
 to employ.
 
+Disable shared SKB
+==================
+By default, SKBs sent by pktgen are shared (user count > 1).
+To test with non-shared SKBs, remove the "SHARED" flag by simply setting::
+
+	pg_set "flag !SHARED"
+
+However, if the "clone_skb" or "burst" parameters are configured, the skb
+still needs to be held by pktgen for further access. Hence the skb must be
+shared.
 
 Current commands and configuration options
 ==========================================
@@ -357,6 +368,7 @@ Current commands and configuration options
     IPSEC
     NODE_ALLOC
     NO_TIMESTAMP
+    SHARED
 
     spi (ipsec)
 
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index ffd659dbd6c3..5cc69feec7d7 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -200,6 +200,7 @@
 	pf(VID_RND)		/* Random VLAN ID */			\
 	pf(SVID_RND)		/* Random SVLAN ID */			\
 	pf(NODE)		/* Node memory alloc*/			\
+	pf(SHARED)		/* Shared SKB */			\
 
 #define pf(flag)		flag##_SHIFT,
 enum pkt_flags {
@@ -1198,7 +1199,8 @@ static ssize_t pktgen_if_write(struct file *file,
 		    ((pkt_dev->xmit_mode == M_NETIF_RECEIVE) ||
 		     !(pkt_dev->odev->priv_flags & IFF_TX_SKB_SHARING)))
 			return -ENOTSUPP;
-		if (value > 0 && pkt_dev->n_imix_entries > 0)
+		if (value > 0 && (pkt_dev->n_imix_entries > 0 ||
+				  !(pkt_dev->flags & F_SHARED)))
 			return -EINVAL;
 
 		i += len;
@@ -1257,6 +1259,10 @@ static ssize_t pktgen_if_write(struct file *file,
 		     ((pkt_dev->xmit_mode == M_START_XMIT) &&
 		     (!(pkt_dev->odev->priv_flags & IFF_TX_SKB_SHARING)))))
 			return -ENOTSUPP;
+
+		if ((value > 1) && !(pkt_dev->flags & F_SHARED))
+			return -EINVAL;
+
 		pkt_dev->burst = value < 1 ? 1 : value;
 		sprintf(pg_result, "OK: burst=%u", pkt_dev->burst);
 		return count;
@@ -1335,10 +1341,18 @@ static ssize_t pktgen_if_write(struct file *file,
 		flag = pktgen_read_flag(f, &disable);
 
 		if (flag) {
-			if (disable)
+			if (disable) {
+				/* If "clone_skb", or "burst" parameters are
+				 * configured, it means that the skb still needs to be
+				 * referenced by the pktgen, so the skb must be shared.
+				 */
+				if (flag == F_SHARED && (pkt_dev->clone_skb ||
+							 pkt_dev->burst > 1))
+					return -EINVAL;
 				pkt_dev->flags &= ~flag;
-			else
+			} else {
 				pkt_dev->flags |= flag;
+			}
 		} else {
 			pg_result += sprintf(pg_result,
 				"Flag -:%s:- unknown\n%s", f,
@@ -3485,7 +3499,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 	if (pkt_dev->xmit_mode == M_NETIF_RECEIVE) {
 		skb = pkt_dev->skb;
 		skb->protocol = eth_type_trans(skb, skb->dev);
-		refcount_add(burst, &skb->users);
+		if (pkt_dev->flags & F_SHARED)
+			refcount_add(burst, &skb->users);
 		local_bh_disable();
 		do {
 			ret = netif_receive_skb(skb);
@@ -3493,6 +3508,10 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 				pkt_dev->errors++;
 			pkt_dev->sofar++;
 			pkt_dev->seq_num++;
+			if (unlikely(!(pkt_dev->flags & F_SHARED))) {
+				pkt_dev->skb = NULL;
+				break;
+			}
 			if (refcount_read(&skb->users) != burst) {
 				/* skb was queued by rps/rfs or taps,
 				 * so cannot reuse this skb
@@ -3511,9 +3530,14 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 		goto out; /* Skips xmit_mode M_START_XMIT */
 	} else if (pkt_dev->xmit_mode == M_QUEUE_XMIT) {
 		local_bh_disable();
-		refcount_inc(&pkt_dev->skb->users);
+		if (pkt_dev->flags & F_SHARED)
+			refcount_inc(&pkt_dev->skb->users);
 
 		ret = dev_queue_xmit(pkt_dev->skb);
+
+		if (!(pkt_dev->flags & F_SHARED) && dev_xmit_complete(ret))
+			pkt_dev->skb = NULL;
+
 		switch (ret) {
 		case NET_XMIT_SUCCESS:
 			pkt_dev->sofar++;
@@ -3551,11 +3575,15 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 		pkt_dev->last_ok = 0;
 		goto unlock;
 	}
-	refcount_add(burst, &pkt_dev->skb->users);
+	if (pkt_dev->flags & F_SHARED)
+		refcount_add(burst, &pkt_dev->skb->users);
 
 xmit_more:
 	ret = netdev_start_xmit(pkt_dev->skb, odev, txq, --burst > 0);
 
+	if (!(pkt_dev->flags & F_SHARED) && dev_xmit_complete(ret))
+		pkt_dev->skb = NULL;
+
 	switch (ret) {
 	case NETDEV_TX_OK:
 		pkt_dev->last_ok = 1;
@@ -3577,7 +3605,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 		fallthrough;
 	case NETDEV_TX_BUSY:
 		/* Retry it next time */
-		refcount_dec(&(pkt_dev->skb->users));
+		if (!(pkt_dev->flags & F_SHARED))
+			refcount_dec(&(pkt_dev->skb->users));
 		pkt_dev->last_ok = 0;
 	}
 	if (unlikely(burst))
@@ -3590,7 +3619,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 
 	/* If pkt_dev->count is zero, then run forever */
 	if ((pkt_dev->count != 0) && (pkt_dev->sofar >= pkt_dev->count)) {
-		pktgen_wait_for_skb(pkt_dev);
+		if (pkt_dev->skb)
+			pktgen_wait_for_skb(pkt_dev);
 
 		/* Done with this */
 		pktgen_stop_device(pkt_dev);
@@ -3773,6 +3803,7 @@ static int pktgen_add_device(struct pktgen_thread *t, const char *ifname)
 	pkt_dev->svlan_id = 0xffff;
 	pkt_dev->burst = 1;
 	pkt_dev->node = NUMA_NO_NODE;
+	pkt_dev->flags = F_SHARED;	/* SKB shared by default */
 
 	err = pktgen_setup_dev(t->net, pkt_dev, ifname);
 	if (err)
-- 
2.40.1


