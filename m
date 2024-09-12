Return-Path: <netdev+bounces-127894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F77F976F60
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29F01C23BE7
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D471C1720;
	Thu, 12 Sep 2024 17:13:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBF01BF7FD
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726161188; cv=none; b=SI4GvCcNnz+Qn5jZPSMhmX7iCjQd7ESz+WMFzhfv0SXNETHrdORE3kj/3oJzlEZuKkv6eeysRNqx3FBQlGXE8qMYjehG7Dku/XfBuUuOjfE08S4UMWqJgVmD2DFF0kGDaK2UXwHV4F7xz4zc5S1iLuJmlTDB4AGtRiGXlw2A0/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726161188; c=relaxed/simple;
	bh=OtM7OkwCkwZOGC/t9yoQNZ4wLyLXtx0Cq9BiZbwZOJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7kSJMzwFA8HPMw9TSyCycsi2ZwN5kh1rjzw1+hsXkLyZ8neeTrchCWObLYc68YCJ1Mgn+dJn3A2DrFYBfaxltIZR02n1UcWhPwWdX6MN16jDdQcbB5aI7xXbTVYnOIixQLPGBEesxlRKHPhNO+lK6CKrUFZp1hrWnj1SpqHB8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7193010d386so88424b3a.1
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726161186; x=1726765986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3voLT4nupCS3bzXGwt3osaY5RB07RUpOg9hQ3Gg5c8=;
        b=Vbx3jERr1/eFU36yHs7hYhofu/ot/xw4NGz0aHy0nAGHbza2Va+8lcp78sA2G1xoB5
         cngUtw5GAn/H904jFxna8fI8tZKU+Vlju783EzW53wooix5Rp6wyqGQAHJgT+e6+GUOP
         YiNyWuppMZDkAVMUXuopwHTFEg7pMOGfIQ+NuUtouEPgMBBQ1CZojrcYwnCKj5Zzrcmg
         On2p7ocA+9tsnwr1fYlm7w+uOynITy8++4083GNMw1GM+EBle15VHeC3vNTsekQQLBrD
         n4WHNL8hl7eh0dAnW/Sjw+odkq/Ur5dJHqjJPsM15564bNGuYeQ8yps7l2PO0wwh5E8w
         uUKw==
X-Gm-Message-State: AOJu0Yykac92MDk4dOJYH7ALPro4SYM/Wa/sLXx9pAo6jfBIJwnGILP0
	UrG1mxVIWceuGSj4x3Kd1hRVcQlSYPS2hWL66BBNYhMsFGmv0WX0LW3Y
X-Google-Smtp-Source: AGHT+IHMFUvkSQMHdh5WNOAzoCsjn7PpyrPMPADDxm1NVMVds/Bn46cPYimhlQMbBb2KR2xhmRVtpQ==
X-Received: by 2002:a05:6a00:2d91:b0:717:85d4:939c with SMTP id d2e1a72fcca58-71926206257mr5707357b3a.23.1726161186348;
        Thu, 12 Sep 2024 10:13:06 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7190f888a78sm4623039b3a.140.2024.09.12.10.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:13:05 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next 11/13] selftests: ncdevmem: Remove hard-coded queue numbers
Date: Thu, 12 Sep 2024 10:12:49 -0700
Message-ID: <20240912171251.937743-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912171251.937743-1-sdf@fomichev.me>
References: <20240912171251.937743-1-sdf@fomichev.me>
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
index f5cfaafb6509..3883a67d387f 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -45,8 +45,8 @@
 
 static char *server_ip;
 static char *port;
-static int start_queue = 8;
-static int num_queues = 8;
+static int start_queue = -1;
+static int num_queues = 1;
 static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
@@ -171,6 +171,33 @@ static void print_nonzero_bytes(void *ptr, size_t size)
 		putchar(p[i]);
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
@@ -630,6 +657,15 @@ int main(int argc, char *argv[])
 
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


