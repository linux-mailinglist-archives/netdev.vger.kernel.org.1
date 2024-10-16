Return-Path: <netdev+bounces-136302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6CA9A1420
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E560B1C2277C
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9694D21830E;
	Wed, 16 Oct 2024 20:34:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D68E218304
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 20:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110877; cv=none; b=Kchi8HOv/Q9PhUP9gc0UQ+Ffx6U/SDNguZBeR+tHV2IpJOObvv3cBaAEgtJRDVoAHK3ni/zVSoKVgcfg+UmtgHcL7ZsiQ3Pihzu7yFUsCD2zudKuzNGZr//DyTRr3L0x8sWjkD7/l5AEWkeHKWhRPuPBOMu67+Ud5DWCJpQRErg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110877; c=relaxed/simple;
	bh=k7uXbcrhbzP8K055+WyplYpJpaVE+a1Q1HejtDhedYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWqkyvuYVI9IlDunjmwob5nhwuxKXpDckJoYCNz1a0Wz5/XYX6lqWqXyzzDeWV0YuGlDfrrGrVlRdCfFxCme2Ev0JxVxM4DMK4+ut605aQN7tSGaIDQ5JRY1CIdhAOz/zSm43H15JQKhFlLrSnx6SS0SbLTG2va2hoo2GLOILEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e3686088c3so183103a91.0
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 13:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110875; x=1729715675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLyMP4azBwRpdtrx/e0g3jtBqjD3VddbI/H/8FwQDZM=;
        b=JP+wuxfGqrBr1JUHv/qNuprHnKyxcJxNU6wY8uNJmGUsHmK4IQxw4WfAV4DoOVt9Ar
         YeCKOI879xwDIA6nII/VKEGHQR+LTJtA/NZr4o1k+zkgCLqPr2HUAFUW8ts8gZe8DUyh
         l5ju+YVR1KFnLy8eqPXoXVqTuaraaOI+sJ5UNIueo7VjIjQPAek2Or6buD0svnEG518+
         2No6Hp4r2BUPp1t91kmtyNeGBpToK8lTjtDkq9Pibk/RRMyjSZeZeuU6eJPJVyO23ZYC
         FD+jZcp5oD9kPWqXJgPzUhUkiTBaVrYqPGntqS6vrBu9WoTr1jJZBDKSHjkUDKbgZ98M
         +eSw==
X-Gm-Message-State: AOJu0Yzr5KBnQbBUQtDZnNKaio8hhIsLzAHHlMHYLSz7wVv8WDWGriCB
	tRvHnB7ImwOAzKWO4y5M8Wcycv5nsFWu8rQQT7DHLQQY6Lsdkvcvmyafkhg=
X-Google-Smtp-Source: AGHT+IFtnznKlaXszyFkUjYO9xwhAPFFuVaoSUx/IlvS2e832nxVhfa/PWG5sQYNi/lWDL0JsGxG2w==
X-Received: by 2002:a17:90b:1056:b0:2e0:db81:4f79 with SMTP id 98e67ed59e1d1-2e2f0a2fb2cmr21905993a91.2.1729110875275;
        Wed, 16 Oct 2024 13:34:35 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e094a1b1sm231464a91.49.2024.10.16.13.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:34:34 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v4 10/12] selftests: ncdevmem: Run selftest when none of the -s or -c has been provided
Date: Wed, 16 Oct 2024 13:34:20 -0700
Message-ID: <20241016203422.1071021-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016203422.1071021-1-sdf@fomichev.me>
References: <20241016203422.1071021-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will be used as a 'probe' mode in the selftest to check whether
the device supports the devmem or not. Use hard-coded queue layout
(two last queues) and prevent user from passing custom -q and/or -t.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 42 ++++++++++++++++++++------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index a7f7bf0da792..4c6baee972ba 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -76,7 +76,7 @@ static char *client_ip;
 static char *port;
 static size_t do_validation;
 static int start_queue = -1;
-static int num_queues = 1;
+static int num_queues = -1;
 static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
@@ -718,19 +718,31 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if (!server_ip)
-		error(1, 0, "Missing -s argument\n");
-
-	if (!port)
-		error(1, 0, "Missing -p argument\n");
-
 	if (!ifname)
 		error(1, 0, "Missing -f argument\n");
 
 	ifindex = if_nametoindex(ifname);
 
-	if (start_queue < 0) {
-		start_queue = rxq_num(ifindex) - 1;
+	if (!server_ip && !client_ip) {
+		if (start_queue < 0 && num_queues < 0) {
+			num_queues = rxq_num(ifindex);
+			if (num_queues < 0)
+				error(1, 0, "couldn't detect number of queues\n");
+			/* make sure can bind to multiple queues */
+			start_queue = num_queues / 2;
+			num_queues /= 2;
+		}
+
+		if (start_queue < 0 || num_queues < 0)
+			error(1, 0, "Both -t and -q are requred\n");
+
+		run_devmem_tests();
+		return 0;
+	}
+
+	if (start_queue < 0 && num_queues < 0) {
+		num_queues = 1;
+		start_queue = rxq_num(ifindex) - num_queues;
 
 		if (start_queue < 0)
 			error(1, 0, "couldn't detect number of queues\n");
@@ -741,7 +753,17 @@ int main(int argc, char *argv[])
 	for (; optind < argc; optind++)
 		fprintf(stderr, "extra arguments: %s\n", argv[optind]);
 
-	run_devmem_tests();
+	if (start_queue < 0)
+		error(1, 0, "Missing -t argument\n");
+
+	if (num_queues < 0)
+		error(1, 0, "Missing -q argument\n");
+
+	if (!server_ip)
+		error(1, 0, "Missing -s argument\n");
+
+	if (!port)
+		error(1, 0, "Missing -p argument\n");
 
 	mem = provider->alloc(getpagesize() * NUM_PAGES);
 	ret = is_server ? do_server(mem) : 1;
-- 
2.47.0


