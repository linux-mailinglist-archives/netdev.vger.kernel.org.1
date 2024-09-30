Return-Path: <netdev+bounces-130494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A24998AAF5
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0978A1C230EA
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26A119882B;
	Mon, 30 Sep 2024 17:18:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF44199259
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716691; cv=none; b=rhM7HwOtWY0d3ePdRUIOP1n4HxzBkvSaEK/iPj9I9RORW4bKLdquLnRIoOCPycH41CIngy4egxmQ8goijsuMr6I4Oe3g5c6MQLk5STCjFKZasb9Pl1t8crH3rfy48MH12obzV8gS1/HOkuExvcMnwz4kuJJLd7PcNGiB3vtOeqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716691; c=relaxed/simple;
	bh=qYRlGVnaaqv8eSx7X6S4XG72C9yMTQv+zK2ngSN9Wr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HK/WJEmh/oa81UaZhA9BNYX0sGG3u14MBom9+TYnr0aNzgNEoafjJzrro0EyfvK8m0tE1jRy0qsrCxVv7bfRgwORpfRWbk1vfh9YUk75SLSyPTT1+8t3YouyJCF91i5b+3bDTfY8WI6vq2dLDsEW6/UTkNNgbnPqtr6vckuOZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e039666812so2422345b6e.1
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 10:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727716689; x=1728321489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+G4c17G8hd9HZGpYLt07D8EV4bOd7F7lOCgcyvo2vc=;
        b=C/TQAxclEhTbIhrOdAdqXqGEr0mHFo1E6BcK9tsiy0eea4oybIOvS+NAuAxEYiqnRB
         gppJnlWAZdM6OUrwPKLaNqQWYhVX5G9v2CANFwzQanpPvIwrSUo4IbCwrAWJPyU69sid
         ljVB8sic8lBy4Py0nThHMrzW5aOWnSN3l/MdbFUXwXmdnQqC54oAs3lE/anogAzB4rHd
         Q5fSnIWUZKAtQBgmDu4MCSAo7HkEUBX1USZam/ECmvClqzFg6k0IIi3A0SFuk0k0cDcG
         PCQ+V0g6BRE3eZZN64cE62R22RyaZ+wpGZ5NzVhGATwxjTYCMKZs/UuT3fAIfXSnmaaX
         E/EA==
X-Gm-Message-State: AOJu0Yx5s6bOnNR8ONUJzzyvin8Y7OxzIg+Y/T1piy+S8SE31voxvOj9
	le3TqL7J8YkB1ll5K9BneUjG2JrE/ZNwIAs+LLPoZR0tKsZw2PT6l085
X-Google-Smtp-Source: AGHT+IHZGXV46Ci4q5S5p6V+KJ8eBzgcbjCNFWNOwFDV7gi/D+gjb5d4cwHaZoAdHkQTJnqk/8uwag==
X-Received: by 2002:a05:6808:338b:b0:3e0:83fb:ec24 with SMTP id 5614622812f47-3e393967c1emr7428840b6e.16.1727716689226;
        Mon, 30 Sep 2024 10:18:09 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2942ecsm6809999a12.6.2024.09.30.10.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:18:08 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v2 09/12] selftests: ncdevmem: Remove hard-coded queue numbers
Date: Mon, 30 Sep 2024 10:17:50 -0700
Message-ID: <20240930171753.2572922-10-sdf@fomichev.me>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240930171753.2572922-1-sdf@fomichev.me>
References: <20240930171753.2572922-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use single last queue of the device and probe it dynamically.

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 40 ++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index a1fa818c8229..900a661a61af 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -48,8 +48,8 @@ static char *server_ip;
 static char *client_ip;
 static char *port;
 static size_t do_validation;
-static int start_queue = 8;
-static int num_queues = 8;
+static int start_queue = -1;
+static int num_queues = 1;
 static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
@@ -198,6 +198,33 @@ void validate_buffer(void *line, size_t size)
 	fprintf(stdout, "Validated buffer\n");
 }
 
+static int rxq_num(int ifindex)
+{
+	struct ethtool_channels_get_req *req;
+	struct ethtool_channels_get_rsp *rsp;
+	struct ynl_error yerr;
+	struct ynl_sock *ys;
+	int num = -1;
+
+	ys = ynl_sock_create(&ynl_ethtool_family, &yerr);
+	if (!ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return -1;
+	}
+
+	req = ethtool_channels_get_req_alloc();
+	ethtool_channels_get_req_set_header_dev_index(req, ifindex);
+	rsp = ethtool_channels_get(ys, req);
+	if (rsp)
+		num = rsp->rx_count + rsp->combined_count;
+	ethtool_channels_get_req_free(req);
+	ethtool_channels_get_rsp_free(rsp);
+
+	ynl_sock_destroy(ys);
+
+	return num;
+}
+
 #define run_command(cmd, ...)                                           \
 	({                                                              \
 		char command[256];                                      \
@@ -672,6 +699,15 @@ int main(int argc, char *argv[])
 
 	ifindex = if_nametoindex(ifname);
 
+	if (start_queue < 0) {
+		start_queue = rxq_num(ifindex) - 1;
+
+		if (start_queue < 0)
+			error(1, 0, "couldn't detect number of queues\n");
+
+		fprintf(stderr, "using queues %d..%d\n", start_queue, start_queue + num_queues);
+	}
+
 	for (; optind < argc; optind++)
 		fprintf(stderr, "extra arguments: %s\n", argv[optind]);
 
-- 
2.46.0


