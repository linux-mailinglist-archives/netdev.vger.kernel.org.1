Return-Path: <netdev+bounces-127885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F50976F56
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE91285900
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7451BF80A;
	Thu, 12 Sep 2024 17:12:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F6C1BF7F5
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726161177; cv=none; b=lA5VqBA9YAROrcsjxwQLUYzPZOzQqJ2i5CBk6BoV/8O2DtnK5pIzKn3NhyRWBAPKQ3bbRyZ3Aj2kTGb/O+GhfzQ3xxuoKWiXHCet6TzaLBCO6PbQpb6PX1QdP/pyqHWPjsMkdfMi9MYOQubzIZI0nYuGxGqATF7vPL1TYQoo8cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726161177; c=relaxed/simple;
	bh=ZZwG2rA865vWgcFv5hZ893muSsVy0VO4tdc8D/RR4Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nc+UTMoEqcr417K9+HcLK8tDzraJT+AcamNBofYiwmrYGT4EDDjgA1nEEgxuo4RUUoXT2kCyElQvVImWvJB5Wjy/LoMGON+lN9Ml1w6jC4GaNHRnHjoM9liVa3/buI78E7UlGgN+yDaOQUeqk4qOEJaqgSz1sgRwdLoxMjiC/Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7d916b6a73aso835929a12.1
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726161175; x=1726765975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5M2BKgPdX1r5+Ca91xOL66iD0WupjvW0MfHAuV+BcDo=;
        b=XRZ/3azL588g8DMeZlBNua6v0wIPak5THCZ0HIa15cSS5CW0kcfPwdGnTGMUqeHO3q
         8gG1O45BH7snMIcyBm6oWGlhLXpfcHH6RnDp4fwQkbqvv/GUtYe1iDq1WI2R3L5dYyWT
         9ZyX1kPK+nMGH69tWQl0/ZJUgV0elwlGE50S8/bJIp4icF1s/UYsZhdEWDXTEPBhT5KP
         3VUauW6xB9VKoQUw+HU3xk12oqcF58BGXMu8i2CBPOmfKxCigv8DNkzQPvmSIgLsMqV9
         74AYE5ubfgUVXbb/LuOLixoLBIyqJ9T/RNCN+6trKJXaMc3rQOxc+NvNHEayGwjQ1JD2
         jqVw==
X-Gm-Message-State: AOJu0YzVJLsvd50MBNFqC5VAs9P97YZmVA3+Ewde3ni5hpzvE3jWjIl/
	CHPNFCZnpmP3NAfFIzhQjuE3GDSkQX3M4C7JYRDTEeKnJZJYG8Efv5I6
X-Google-Smtp-Source: AGHT+IE08q9U+FFpqWsxTPciAB/N0YS2pvsQkPY4UbhySf0mFOZyE2Tpuk71+E3CCQ+ZHBTwC3XLvA==
X-Received: by 2002:a17:90a:2f23:b0:2d8:82a2:b093 with SMTP id 98e67ed59e1d1-2db9ffcaab5mr3965099a91.13.1726161174790;
        Thu, 12 Sep 2024 10:12:54 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadb42e6fasm13008750a91.0.2024.09.12.10.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:12:54 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next 02/13] selftests: ncdevmem: Remove validation
Date: Thu, 12 Sep 2024 10:12:40 -0700
Message-ID: <20240912171251.937743-3-sdf@fomichev.me>
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

ncdevmem should (see next patches) print the payload on the stdout.
The validation can and should be done by the callers:

$ ncdevmem -l ... > file
$ sha256sum file

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 56 +++-----------------------
 1 file changed, 6 insertions(+), 50 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 352dba211fb0..3712296d997b 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -64,24 +64,13 @@
 static char *server_ip = "192.168.1.4";
 static char *client_ip = "192.168.1.2";
 static char *port = "5201";
-static size_t do_validation;
 static int start_queue = 8;
 static int num_queues = 8;
 static char *ifname = "eth1";
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
 
-void print_bytes(void *ptr, size_t size)
-{
-	unsigned char *p = ptr;
-	int i;
-
-	for (i = 0; i < size; i++)
-		printf("%02hhX ", p[i]);
-	printf("\n");
-}
-
-void print_nonzero_bytes(void *ptr, size_t size)
+static void print_nonzero_bytes(void *ptr, size_t size)
 {
 	unsigned char *p = ptr;
 	unsigned int i;
@@ -91,30 +80,6 @@ void print_nonzero_bytes(void *ptr, size_t size)
 	printf("\n");
 }
 
-void validate_buffer(void *line, size_t size)
-{
-	static unsigned char seed = 1;
-	unsigned char *ptr = line;
-	int errors = 0;
-	size_t i;
-
-	for (i = 0; i < size; i++) {
-		if (ptr[i] != seed) {
-			fprintf(stderr,
-				"Failed validation: expected=%u, actual=%u, index=%lu\n",
-				seed, ptr[i], i);
-			errors++;
-			if (errors > 20)
-				error(1, 0, "validation failed.");
-		}
-		seed++;
-		if (seed == do_validation)
-			seed = 0;
-	}
-
-	fprintf(stdout, "Validated buffer\n");
-}
-
 #define run_command(cmd, ...)                                           \
 	({                                                              \
 		char command[256];                                      \
@@ -414,16 +379,10 @@ int do_server(void)
 			sync.flags = DMA_BUF_SYNC_READ | DMA_BUF_SYNC_START;
 			ioctl(buf, DMA_BUF_IOCTL_SYNC, &sync);
 
-			if (do_validation)
-				validate_buffer(
-					((unsigned char *)buf_mem) +
-						dmabuf_cmsg->frag_offset,
-					dmabuf_cmsg->frag_size);
-			else
-				print_nonzero_bytes(
-					((unsigned char *)buf_mem) +
-						dmabuf_cmsg->frag_offset,
-					dmabuf_cmsg->frag_size);
+			print_nonzero_bytes(
+				((unsigned char *)buf_mem) +
+					dmabuf_cmsg->frag_offset,
+				dmabuf_cmsg->frag_size);
 
 			sync.flags = DMA_BUF_SYNC_READ | DMA_BUF_SYNC_END;
 			ioctl(buf, DMA_BUF_IOCTL_SYNC, &sync);
@@ -525,7 +484,7 @@ int main(int argc, char *argv[])
 	int is_server = 0, opt;
 	int probe = 0;
 
-	while ((opt = getopt(argc, argv, "ls:c:p:v:q:t:f:P")) != -1) {
+	while ((opt = getopt(argc, argv, "ls:c:p:q:t:f:P")) != -1) {
 		switch (opt) {
 		case 'l':
 			is_server = 1;
@@ -539,9 +498,6 @@ int main(int argc, char *argv[])
 		case 'p':
 			port = optarg;
 			break;
-		case 'v':
-			do_validation = atoll(optarg);
-			break;
 		case 'q':
 			num_queues = atoi(optarg);
 			break;
-- 
2.46.0


