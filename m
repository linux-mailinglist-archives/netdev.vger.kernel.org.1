Return-Path: <netdev+bounces-34294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B092E7A30A9
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 15:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE361C20D78
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 13:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92D713FED;
	Sat, 16 Sep 2023 13:30:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C537F6134
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 13:30:14 +0000 (UTC)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFA7139
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 06:30:13 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5780040cb81so2127343a12.1
        for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 06:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694871013; x=1695475813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1pGmqeXOoWUx5yrStmRUGR+pBm9HnM3potR2mWJnXSQ=;
        b=XM5Oi+QimkNu/7YX2xMNrvxE3tCrrnFnRc9Ftl+VSkVlzrwUjmIWwYTFtw8Kd8q0PO
         PeXzajsN0N3EQD50Q5S0oVZelaxBO5D1tvL+cCWPrdyAoG/KCskkM+n0p3cOf2RLYsS7
         WYHt3xHSMaExn44I8OZHbx1Frznos3tbOT411GU1dTNZvroMShWRydqRcV4KAz5Z9UM6
         Kvrhrsm/77+kvANNIjaWt6XdBTP8LsmxG89u4ty/v11xT00msVUuzfpwsmUZfCD6l1RC
         u2oc9Af5fwbkSZ7Aij5HD6Zk5yqbAVLf/dzlx3jfbjsXTFWj3n+N1SxBfbH3fluYZNnw
         b9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694871013; x=1695475813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1pGmqeXOoWUx5yrStmRUGR+pBm9HnM3potR2mWJnXSQ=;
        b=b2qyxn7OieGkr2C/A84ifJLe5Ip47KmWBFXW8VzIvxcQw9DomT5lXiAye2jOBKUSEI
         Pnik+XunM039cWNsAy06/x9pQwkbNYMWF1+hxLA1f8pbLJi12RQUQZWp/3S3nM67muv0
         O65XGeDJgYb+ntXYG3/TX+2r5vMLnoLXmJfT+NkVcQFRPwcxhoAI7CIOEs+xCGIk9T/8
         swtvY74KJBw9cy9N2atyjs+feB7pa8raLI4L6nSZrhL+rRTPMnQD+SyBB7dmvw3PKn5p
         cCAliM0xUwI7ys1JHQL3YbJAFMn8HfDg3wq1Z3Dt0brBfo2aVb/yrWmE/1TkcXix1xt9
         tcgw==
X-Gm-Message-State: AOJu0YwpMhCmc00ZZ3Vo0wTPuWwcern1bg7YJyTUDyt11hIVi+iqAOYN
	7q5D9hcE9ojEwFNglZLHbGQ=
X-Google-Smtp-Source: AGHT+IGTeEpRWToqzT8pYi/axSUlaqOpPqQXNn6MNljTlWnodx1GGZB5PlX0uVoBq8cbbWoF6nrLNw==
X-Received: by 2002:a17:90a:6482:b0:274:945b:6979 with SMTP id h2-20020a17090a648200b00274945b6979mr3896613pjj.16.1694871012798;
        Sat, 16 Sep 2023 06:30:12 -0700 (PDT)
Received: from 192.168.0.123 ([66.150.196.58])
        by smtp.googlemail.com with ESMTPSA id nb2-20020a17090b35c200b00274b035246esm1516744pjb.1.2023.09.16.06.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 06:30:11 -0700 (PDT)
From: Liang Chen <liangchen.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	benjamin.poirier@gmail.com
Cc: netdev@vger.kernel.org,
	liangchen.linux@gmail.com,
	Benjamin Poirier <bpoirier@nvidia.com>
Subject: [PATCH net-next v4 1/2] pktgen: Automate flag enumeration for unknown flag handling
Date: Sat, 16 Sep 2023 21:29:31 +0800
Message-Id: <20230916132932.361875-1-liangchen.linux@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When specifying an unknown flag, it will print all available flags.
Currently, these flags are provided as fixed strings, which requires
manual updates when flags change. Replacing it with automated flag
enumeration.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 Changes from v3:
- check "n == IPSEC_SHIFT" instead of string comparison
- use snprintf and check that the result does not overrun pkg_dev->result[]
- avoid double '\n' at the end
- move "return" in the OK case to remove "else" and decrease indent
---
 net/core/pktgen.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index f56b8d697014..48306a101fd9 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -1318,9 +1318,10 @@ static ssize_t pktgen_if_write(struct file *file,
 		return count;
 	}
 	if (!strcmp(name, "flag")) {
+		bool disable = false;
 		__u32 flag;
 		char f[32];
-		bool disable = false;
+		char *end;
 
 		memset(f, 0, 32);
 		len = strn_len(&user_buffer[i], sizeof(f) - 1);
@@ -1332,28 +1333,33 @@ static ssize_t pktgen_if_write(struct file *file,
 		i += len;
 
 		flag = pktgen_read_flag(f, &disable);
-
 		if (flag) {
 			if (disable)
 				pkt_dev->flags &= ~flag;
 			else
 				pkt_dev->flags |= flag;
-		} else {
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
-#endif
-				"NODE_ALLOC\n");
+
+			sprintf(pg_result, "OK: flags=0x%x", pkt_dev->flags);
 			return count;
 		}
-		sprintf(pg_result, "OK: flags=0x%x", pkt_dev->flags);
+
+		/* Unknown flag */
+		end = pkt_dev->result + sizeof(pkt_dev->result);
+		pg_result += sprintf(pg_result,
+			"Flag -:%s:- unknown\n"
+			"Available flags, (prepend ! to un-set flag):\n", f);
+
+		for (int n = 0; n < NR_PKT_FLAGS && pg_result < end; n++) {
+			if (!IS_ENABLED(CONFIG_XFRM) && n == IPSEC_SHIFT)
+				continue;
+			pg_result += snprintf(pg_result, end - pg_result,
+					      "%s, ", pkt_flag_names[n]);
+		}
+		if (!WARN_ON_ONCE(pg_result >= end)) {
+			/* Remove the comma and whitespace at the end */
+			*(pg_result - 2) = '\0';
+		}
+
 		return count;
 	}
 	if (!strcmp(name, "dst_min") || !strcmp(name, "dst")) {
-- 
2.40.1


