Return-Path: <netdev+bounces-34062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7017A1EA4
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 14:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7618D282B0A
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 12:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BC6107A9;
	Fri, 15 Sep 2023 12:24:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FA310948
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:24:06 +0000 (UTC)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D343268F
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 05:24:04 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-573d52030fbso1701619a12.0
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 05:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694780643; x=1695385443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nNLIWA4i5VL9jGjfNW9VF4j/lei4wxTdyKGKThaxys0=;
        b=fCh1/+XU9LO4Xx14uEnuDfhsuQN/ocSsVzHAkRY0v08EMNgNjFadwOkxGj+RG9junX
         lq7dWa/iyTKQc3sV7TFqA6shmU0I4Kc5QQmdsLh05SZbNLTAqS15suHzxK+wxfNUv5UI
         mrElIZkchBTe3/XxLk3aE1em9gzWm9B4G9fT14OvcIEyd64A06vuZ+FJp15J4VjrqbRi
         LPU2Jppr0F9sgvmquedYFOjSoCgSNB3FRqDF8BOsnXoaFTrkfUC1FQQigBnMgPw5AW7n
         9HxkyjDhKfnUxkQEQlM2Ha6XSXlMhF34jUXAjz2QKR8tkE/yYy7On/nvXQ3nH2M/4bOQ
         Tewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694780643; x=1695385443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNLIWA4i5VL9jGjfNW9VF4j/lei4wxTdyKGKThaxys0=;
        b=CeH8O9mNmsYTCfnrJ34Q/GJlPEa8gafFlxb/6WF3A1Zi/7VUWjFkHU53aZ9Q3/s579
         d1xwiA5El420nQ9Ymi4U5ri2VDaHxrAsI/D3jW+cRpOVZ62/KdpnFk9F1CIvd6ZNvVkJ
         o0qo9EeWcjJJX6ndAq4bi+iCCnSA6hsUYwfp71wHxtad0fxFLSwoXdpfBeTHChXuk4KL
         hGIxyQ++o4Qa7RgfkOAAN+EYpSWaLXZ0LG7UmB0TEFHwnjvmnZtNZrR6LLq0M5lcU9fe
         ZRpxh6hZtBtz2zlYTV6k9jhqeHy+FRY/9FiCmUq/av4J5/99o+fRNow7DvX+WtLohZwL
         hYcg==
X-Gm-Message-State: AOJu0Yx0B1c0q8psQAVkRzZwBg9pVHU+lYKz1Gh0brPVXxTprQ9sFdE+
	Vb1zViHfUxnvL53LaR+OM+M=
X-Google-Smtp-Source: AGHT+IEFcsHo5Sbczc2DW8TTln1k9tGayeZNOacQvgbqGBAekY0hmybmjRE1B8Q5ySMWM2iHId9UvQ==
X-Received: by 2002:a17:90a:1189:b0:274:2523:fc7f with SMTP id e9-20020a17090a118900b002742523fc7fmr1238141pja.47.1694780643546;
        Fri, 15 Sep 2023 05:24:03 -0700 (PDT)
Received: from 192.168.0.123 ([199.119.202.101])
        by smtp.googlemail.com with ESMTPSA id 23-20020a17090a199700b00267eead2f16sm3167231pji.36.2023.09.15.05.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 05:24:02 -0700 (PDT)
From: Liang Chen <liangchen.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	benjamin.poirier@gmail.com
Cc: netdev@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH net-next v3 1/2] pktgen: Automate flag enumeration for unknown flag handling
Date: Fri, 15 Sep 2023 20:23:16 +0800
Message-Id: <20230915122317.100390-1-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When specifying an unknown flag, it will print all available flags.
Currently, these flags are provided as fixed strings, which requires
manual updates when flags change. Replacing it with automated flag
enumeration.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 net/core/pktgen.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index f56b8d697014..ffd659dbd6c3 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -1318,6 +1318,7 @@ static ssize_t pktgen_if_write(struct file *file,
 		return count;
 	}
 	if (!strcmp(name, "flag")) {
+		unsigned int n;
 		__u32 flag;
 		char f[32];
 		bool disable = false;
@@ -1339,18 +1340,19 @@ static ssize_t pktgen_if_write(struct file *file,
 			else
 				pkt_dev->flags |= flag;
 		} else {
-			sprintf(pg_result,
-				"Flag -:%s:- unknown\nAvailable flags, (prepend ! to un-set flag):\n%s",
-				f,
-				"IPSRC_RND, IPDST_RND, UDPSRC_RND, UDPDST_RND, "
-				"MACSRC_RND, MACDST_RND, TXSIZE_RND, IPV6, "
-				"MPLS_RND, VID_RND, SVID_RND, FLOW_SEQ, "
-				"QUEUE_MAP_RND, QUEUE_MAP_CPU, UDPCSUM, "
-				"NO_TIMESTAMP, "
-#ifdef CONFIG_XFRM
-				"IPSEC, "
+			pg_result += sprintf(pg_result,
+				"Flag -:%s:- unknown\n%s", f,
+				"Available flags, (prepend ! to un-set flag):\n");
+			for (n = 0; n < NR_PKT_FLAGS; n++) {
+#ifndef CONFIG_XFRM
+				if (!strcmp("IPSEC", pkt_flag_names[n]))
+					continue;
 #endif
-				"NODE_ALLOC\n");
+				pg_result += sprintf(pg_result, "%s, ", pkt_flag_names[n]);
+			}
+			/* Remove the comma and whitespace at the end */
+			*(pg_result - 2) = '\n';
+
 			return count;
 		}
 		sprintf(pg_result, "OK: flags=0x%x", pkt_dev->flags);
-- 
2.40.1


