Return-Path: <netdev+bounces-35249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBE67A8236
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 14:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B321C20C81
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 12:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AE3328C5;
	Wed, 20 Sep 2023 12:58:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A2315AE6
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 12:58:36 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF0F8F;
	Wed, 20 Sep 2023 05:58:33 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68fcb4dc8a9so6246554b3a.2;
        Wed, 20 Sep 2023 05:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695214713; x=1695819513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDRuM5iIQM0BZNn2tI7zshD9p2FInxL6x1zhrO2i6c8=;
        b=QbhJgnNbn3dUsQH2Bl4u9N9AR8+AGPWMY9h5g7Sss2T6hoPCzdOKm7/MjCm9h7Sooy
         GMA76fkazUFDxERycgTVbG6zBn9VzzI40JraN/3lpK7rYC7oHdJrFfq6XUz3sHmGNtn9
         t27XIkwaR2i0LB8lV0HgNE06BVkFAxivGNjFI3R0hnT6ht1X9/9sc9t4BAeWi1lAmY/6
         yntu0N/M2tXStcQdiMpJ8HJte2ULFYVcSDo3tqbFYpdn0YHxXIH6ETfE+w9MjhF3SJRk
         GwsD/xEhKkiyioJ4QE0P0X7LMm/YCNDuiXo/N86P/hixU9KwSFwJStmq4SYF3AVQdiD8
         tRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695214713; x=1695819513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDRuM5iIQM0BZNn2tI7zshD9p2FInxL6x1zhrO2i6c8=;
        b=L5IuaejCvaEAZ/LnOIhH2z2lhKNShHW+KVt2/XAu+g+p7BNcqcggTw/Bn4YSIiBKIA
         N5Y/9v1vwDV2AYRsfIxH6xzdkiEzWXkj++LqBB1jPDHj862fYDrqxO81n74fUZ/R2tHZ
         hvjjGoHbKKYb1XtecfTsfrUADeuBj0dTzYCCGjzDkecptC7Yh33irdb0/xGUIx5i8OKW
         pyhXZG6uPG0HI5xGGsxdtIxgPlH2QUbSBBTXx1sRN9ngCSylhpXgY4kYeosb9PNf91Vx
         5FVfkHELZ5IpIRvXu9DfruvUJ4O5U1PAYa5xKv49u59lzRXyMCuWKxiWusF7wz7K4Sbd
         QhJw==
X-Gm-Message-State: AOJu0YxgRZlC02TJS5423QDWcsocSaoqVvrDpuK3ZqAZHaw38aByQSfQ
	ssnfvDKUirwM2btx0Jj8KXY=
X-Google-Smtp-Source: AGHT+IEYjjWVnuVbHCLHflw8h8Q1deQlLprFeWfjy1owE3D3KSrx3bUPixrY2oIpn/rHn5Pe05ux+Q==
X-Received: by 2002:a05:6a20:9781:b0:154:bfaf:a710 with SMTP id hx1-20020a056a20978100b00154bfafa710mr2080307pzc.41.1695214712771;
        Wed, 20 Sep 2023 05:58:32 -0700 (PDT)
Received: from localhost.localdomain ([50.7.159.34])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902e74800b001ba066c589dsm11839614plf.137.2023.09.20.05.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 05:58:31 -0700 (PDT)
From: Liang Chen <liangchen.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bpoirier@nvidia.com,
	corbet@lwn.net
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	gregkh@linuxfoundation.org,
	keescook@chromium.org,
	Jason@zx2c4.com,
	djwong@kernel.org,
	jack@suse.cz,
	linyunsheng@huawei.com,
	ulf.hansson@linaro.org,
	liangchen.linux@gmail.com
Subject: [PATCH net-next v5 2/2] pktgen: Introducing 'SHARED' flag for testing with non-shared skb
Date: Wed, 20 Sep 2023 20:56:58 +0800
Message-Id: <20230920125658.46978-2-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230920125658.46978-1-liangchen.linux@gmail.com>
References: <20230920125658.46978-1-liangchen.linux@gmail.com>
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
Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 Changes from v4:
- read the shared flag once in pktgen_xmit to avoid inconsistent burst,
  clone and shared flag values.
---
 Documentation/networking/pktgen.rst | 12 ++++++
 net/core/pktgen.c                   | 64 ++++++++++++++++++++++++-----
 2 files changed, 66 insertions(+), 10 deletions(-)

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
index 48306a101fd9..5e865af82e5b 100644
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
+		if (value > 1 && !(pkt_dev->flags & F_SHARED))
+			return -EINVAL;
+
 		pkt_dev->burst = value < 1 ? 1 : value;
 		sprintf(pg_result, "OK: burst=%u", pkt_dev->burst);
 		return count;
@@ -1334,10 +1340,19 @@ static ssize_t pktgen_if_write(struct file *file,
 
 		flag = pktgen_read_flag(f, &disable);
 		if (flag) {
-			if (disable)
+			if (disable) {
+				/* If "clone_skb", or "burst" parameters are
+				 * configured, it means that the skb still
+				 * needs to be referenced by the pktgen, so
+				 * the skb must be shared.
+				 */
+				if (flag == F_SHARED && (pkt_dev->clone_skb ||
+							 pkt_dev->burst > 1))
+					return -EINVAL;
 				pkt_dev->flags &= ~flag;
-			else
+			} else {
 				pkt_dev->flags |= flag;
+			}
 
 			sprintf(pg_result, "OK: flags=0x%x", pkt_dev->flags);
 			return count;
@@ -3446,12 +3461,24 @@ static void pktgen_wait_for_skb(struct pktgen_dev *pkt_dev)
 
 static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 {
-	unsigned int burst = READ_ONCE(pkt_dev->burst);
+	bool skb_shared = !!(READ_ONCE(pkt_dev->flags) & F_SHARED);
 	struct net_device *odev = pkt_dev->odev;
 	struct netdev_queue *txq;
+	unsigned int burst = 1;
 	struct sk_buff *skb;
+	int clone_skb = 0;
 	int ret;
 
+	/* If 'skb_shared' is false, the read of possible
+	 * new values (if any) for 'burst' and 'clone_skb' will be skipped to
+	 * prevent some concurrent changes from slipping in. And the stabilized
+	 * config will be read in during the next run of pktgen_xmit.
+	 */
+	if (skb_shared) {
+		burst = READ_ONCE(pkt_dev->burst);
+		clone_skb = READ_ONCE(pkt_dev->clone_skb);
+	}
+
 	/* If device is offline, then don't send */
 	if (unlikely(!netif_running(odev) || !netif_carrier_ok(odev))) {
 		pktgen_stop_device(pkt_dev);
@@ -3468,7 +3495,7 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 
 	/* If no skb or clone count exhausted then get new one */
 	if (!pkt_dev->skb || (pkt_dev->last_ok &&
-			      ++pkt_dev->clone_count >= pkt_dev->clone_skb)) {
+			      ++pkt_dev->clone_count >= clone_skb)) {
 		/* build a new pkt */
 		kfree_skb(pkt_dev->skb);
 
@@ -3489,7 +3516,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 	if (pkt_dev->xmit_mode == M_NETIF_RECEIVE) {
 		skb = pkt_dev->skb;
 		skb->protocol = eth_type_trans(skb, skb->dev);
-		refcount_add(burst, &skb->users);
+		if (skb_shared)
+			refcount_add(burst, &skb->users);
 		local_bh_disable();
 		do {
 			ret = netif_receive_skb(skb);
@@ -3497,6 +3525,10 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 				pkt_dev->errors++;
 			pkt_dev->sofar++;
 			pkt_dev->seq_num++;
+			if (unlikely(!skb_shared)) {
+				pkt_dev->skb = NULL;
+				break;
+			}
 			if (refcount_read(&skb->users) != burst) {
 				/* skb was queued by rps/rfs or taps,
 				 * so cannot reuse this skb
@@ -3515,9 +3547,14 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 		goto out; /* Skips xmit_mode M_START_XMIT */
 	} else if (pkt_dev->xmit_mode == M_QUEUE_XMIT) {
 		local_bh_disable();
-		refcount_inc(&pkt_dev->skb->users);
+		if (skb_shared)
+			refcount_inc(&pkt_dev->skb->users);
 
 		ret = dev_queue_xmit(pkt_dev->skb);
+
+		if (!skb_shared && dev_xmit_complete(ret))
+			pkt_dev->skb = NULL;
+
 		switch (ret) {
 		case NET_XMIT_SUCCESS:
 			pkt_dev->sofar++;
@@ -3555,11 +3592,15 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 		pkt_dev->last_ok = 0;
 		goto unlock;
 	}
-	refcount_add(burst, &pkt_dev->skb->users);
+	if (skb_shared)
+		refcount_add(burst, &pkt_dev->skb->users);
 
 xmit_more:
 	ret = netdev_start_xmit(pkt_dev->skb, odev, txq, --burst > 0);
 
+	if (!skb_shared && dev_xmit_complete(ret))
+		pkt_dev->skb = NULL;
+
 	switch (ret) {
 	case NETDEV_TX_OK:
 		pkt_dev->last_ok = 1;
@@ -3581,7 +3622,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 		fallthrough;
 	case NETDEV_TX_BUSY:
 		/* Retry it next time */
-		refcount_dec(&(pkt_dev->skb->users));
+		if (skb_shared)
+			refcount_dec(&pkt_dev->skb->users);
 		pkt_dev->last_ok = 0;
 	}
 	if (unlikely(burst))
@@ -3594,7 +3636,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 
 	/* If pkt_dev->count is zero, then run forever */
 	if ((pkt_dev->count != 0) && (pkt_dev->sofar >= pkt_dev->count)) {
-		pktgen_wait_for_skb(pkt_dev);
+		if (pkt_dev->skb)
+			pktgen_wait_for_skb(pkt_dev);
 
 		/* Done with this */
 		pktgen_stop_device(pkt_dev);
@@ -3777,6 +3820,7 @@ static int pktgen_add_device(struct pktgen_thread *t, const char *ifname)
 	pkt_dev->svlan_id = 0xffff;
 	pkt_dev->burst = 1;
 	pkt_dev->node = NUMA_NO_NODE;
+	pkt_dev->flags = F_SHARED;	/* SKB shared by default */
 
 	err = pktgen_setup_dev(t->net, pkt_dev, ifname);
 	if (err)
-- 
2.31.1


