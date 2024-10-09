Return-Path: <netdev+bounces-133832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2B99972C9
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0072826D0
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224111E1A20;
	Wed,  9 Oct 2024 17:13:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06271DE4CE
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493986; cv=none; b=sVEnBzLEaNxxhtfJdz0jvPFQr7TnXy8EUC46KI/DLsEWA8dM/HCgZyWZf36vAHzKb1kbNoSqN01zlZ8Lmtxa+dR43CicJ8bUc+GLk5GhU/WkuI7kmf9iibO40OrgynP2iG6H1dM9NvA2RhSsLankBGxcpuovdH74LQ4czpo/pSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493986; c=relaxed/simple;
	bh=vtF1aQjlg7zJIjdWfRXwwXxmJ53MtTbM82Io71VQxAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OE208Tv0suU97ciCO+WWsV25KQ7+ewskHIVUhv9z+8Quo0FyBQ+KkK/Zh/NkH8OeQpYDlinrN/s3W9tIYnWv+nLRwiiyX5RQW1X+7i9Ct+rFT5NcfiJrqdz/eXQJ+9KzbOBcgjXV7hryl8v1AC9xSuWgcx9uS/21LuXk9lRST1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7db908c9c83so4519146a12.2
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 10:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728493984; x=1729098784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6EPX6T6P41rWnZDYYT4pKZI/4MKdk+tIinSmqSIRYpI=;
        b=W7Of3ygVA0ee0lWYiu/0eyQ+ooicKi1u1NhK42HxzZkJA1Q1hIor3baWBGfTGkpaYP
         njy1953TwRS1whC59xhcQc0BqUDPVTPSeLos8N547wJ2+5vXcMSo9SIK1HGrknMyYL5I
         XSF9wxhO9Z6ZukU1kc0/ktJMLMqY1FRK67ybXizNTNisTr4iaeIUb4GXPvF46x6/Ues1
         cttDdVAU3reZg9H/FohyHk5+f+J8isgQfWdbZ6Qv37brpi0uMeC9wvTrzXs0P4z5A4mS
         siDLZcUGGfQ1Ivsonzq5U5bOk/8t0SqOH05rTjcJ1tOqmTpoAi4Q4OoXLi5ZBgjP+Dxb
         1MFA==
X-Gm-Message-State: AOJu0YzWqbLIda9oTlaJaNUCMchT6iYeFqgtGtu8tJduO8CDd/EqGTJN
	BGhQI+Gq0UpOESTl0Is7Lc+A7ZzeI/8mJRbN7Ls3afaQN1IogmztO+R1
X-Google-Smtp-Source: AGHT+IFkyfSCzFHuGDd1KUm+goCGpDZlQ5fOKvLuk2D2v658tN28OqdRJXbSc8DOHJFnNP4NcW6RDA==
X-Received: by 2002:a17:90a:bd83:b0:2d8:cd04:c8f0 with SMTP id 98e67ed59e1d1-2e2a25a1149mr3648204a91.39.1728493983770;
        Wed, 09 Oct 2024 10:13:03 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a55f9970sm1942852a91.8.2024.10.09.10.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:13:03 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v3 09/12] selftests: ncdevmem: Remove hard-coded queue numbers
Date: Wed,  9 Oct 2024 10:12:49 -0700
Message-ID: <20241009171252.2328284-10-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241009171252.2328284-1-sdf@fomichev.me>
References: <20241009171252.2328284-1-sdf@fomichev.me>
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
index 02ba3f368888..90aacfb3433f 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -63,8 +63,8 @@ static char *server_ip;
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
@@ -196,6 +196,33 @@ void validate_buffer(void *line, size_t size)
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
@@ -690,6 +717,15 @@ int main(int argc, char *argv[])
 
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
2.47.0


