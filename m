Return-Path: <netdev+bounces-22911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E922C76A006
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 20:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96BC7281663
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 18:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9141D318;
	Mon, 31 Jul 2023 18:09:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC5819BA5
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 18:09:02 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED401724
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:08:59 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-63cf69f3c22so33837836d6.3
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690826938; x=1691431738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JQmEtTVVFfdslS8ihiuXoTeg61h1aNINsAVkkDnon2U=;
        b=B2vm8FazTeucL8Z+RofinWJi5oZuiPdP3Jpk3XxulUbgF91yCruAWyn4cCGJluPsZS
         C2B0WfFnH8btzC+94yfquj1WojbtG6658KCnZCcut36WHKD+TuKinStmy9SYE/1Ic+ad
         28Z2XYGtIPlqhzK/ABtscxg4n5dXrVKweVtuU9vRg/A9OnNImmvMZ/sOg9vaouz1eHt8
         IS8H+APG9rjuyG4SF6dkep4hilHkgPvngLBFE+LyVpHDCZAeQ6jOBV7AjdzMCTCyGuD6
         h4xGYgvbzbhZ8DBDDB3/SSuOidXWMH8+FvNpgrGAVibkfcz8pre2acKvJq98Vhrry2wq
         CrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690826938; x=1691431738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQmEtTVVFfdslS8ihiuXoTeg61h1aNINsAVkkDnon2U=;
        b=IrgU864CpB01CP+KXvtGsoGAWSl+4fGTVHZGSAJv6GVSfrsRMQDKTEXpvXu/dq31oH
         qkTZgpKdWzmkvZWRuKt6l3i31BHpAvXpPmZH829/ijCUL+6wHT3jyXjOnlJBttwjx2Ka
         CTG7QrmbQgsfsxq0o0bslYNB+cY0wU7kReC9p2tKEMTeUaaTxT5qBfwcf6uJW4uG8M6r
         ElGhYrhK0ae0eRisMhIY4le2twBELSwohjCqS+XfNQ3Lw0AUnw3V+99C10TQXTXgfhCv
         RruTKdfUDITO0YuvLuHcrm6q/WL+iY451b/aC5GE0KRAbc01PlwYIhfX274Qq+Z1zLFX
         hJnA==
X-Gm-Message-State: ABy/qLYqljQUkmnZa9qEp8RjOTc6etvoIWzlZ0AV0+4pl779kwpaE19t
	HtFMT6yjGtIdl2Cky+A/zFeL1E9eRk8=
X-Google-Smtp-Source: APBJJlHCaB1wbJwaNUvmyxCsDHUZhvVzC3N0+bq8xG6cxzvQhzJEj08pBZhalZks8QDLYEf4NgacmA==
X-Received: by 2002:a05:6214:15d2:b0:63c:f453:681f with SMTP id p18-20020a05621415d200b0063cf453681fmr10406263qvz.54.1690826938450;
        Mon, 31 Jul 2023 11:08:58 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id g7-20020a0cdf07000000b0062df126ca11sm3932060qvl.21.2023.07.31.11.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 11:08:58 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] selftests/net: report rcv_mss in tcp_mmap
Date: Mon, 31 Jul 2023 14:08:09 -0400
Message-ID: <20230731180846.1560539-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Willem de Bruijn <willemb@google.com>

tcp_mmap tests TCP_ZEROCOPY_RECEIVE. If 0% of data is received using
mmap, this may be due to mss. Report rcv_mss to identify this cause.

Output of a run failed due to too small mss:

    received 32768 MB (0 % mmap'ed) in 8.40458 s, 32.7057 Gbit
      cpu usage user:0.027922 sys:8.21126, 251.44 usec per MB, 3252 c-switches, rcv_mss 1428

Output on a successful run:

    received 32768 MB (99.9507 % mmap'ed) in 4.69023 s, 58.6064 Gbit
      cpu usage user:0.029172 sys:2.56105, 79.0473 usec per MB, 57591 c-switches, rcv_mss 4096

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/tcp_mmap.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_mmap.c b/tools/testing/selftests/net/tcp_mmap.c
index 6e59b1461dcc..4fcce5150850 100644
--- a/tools/testing/selftests/net/tcp_mmap.c
+++ b/tools/testing/selftests/net/tcp_mmap.c
@@ -153,6 +153,19 @@ static void *mmap_large_buffer(size_t need, size_t *allocated)
 	return buffer;
 }
 
+static uint32_t tcp_info_get_rcv_mss(int fd)
+{
+	socklen_t sz = sizeof(struct tcp_info);
+	struct tcp_info info;
+
+	if (getsockopt(fd, IPPROTO_TCP, TCP_INFO, &info, &sz)) {
+		fprintf(stderr, "Error fetching TCP_INFO\n");
+		return 0;
+	}
+
+	return info.tcpi_rcv_mss;
+}
+
 void *child_thread(void *arg)
 {
 	unsigned char digest[SHA256_DIGEST_LENGTH];
@@ -288,7 +301,7 @@ void *child_thread(void *arg)
 		total_usec = 1000000*ru.ru_utime.tv_sec + ru.ru_utime.tv_usec +
 			     1000000*ru.ru_stime.tv_sec + ru.ru_stime.tv_usec;
 		printf("received %lg MB (%lg %% mmap'ed) in %lg s, %lg Gbit\n"
-		       "  cpu usage user:%lg sys:%lg, %lg usec per MB, %lu c-switches\n",
+		       "  cpu usage user:%lg sys:%lg, %lg usec per MB, %lu c-switches, rcv_mss %u\n",
 				total / (1024.0 * 1024.0),
 				100.0*total_mmap/total,
 				(double)delta_usec / 1000000.0,
@@ -296,7 +309,8 @@ void *child_thread(void *arg)
 				(double)ru.ru_utime.tv_sec + (double)ru.ru_utime.tv_usec / 1000000.0,
 				(double)ru.ru_stime.tv_sec + (double)ru.ru_stime.tv_usec / 1000000.0,
 				(double)total_usec/mb,
-				ru.ru_nvcsw);
+				ru.ru_nvcsw,
+				tcp_info_get_rcv_mss(fd));
 	}
 error:
 	munmap(buffer, buffer_sz);
-- 
2.41.0.585.gd2178a4bd4-goog


