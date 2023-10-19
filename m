Return-Path: <netdev+bounces-42767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25E67D00EF
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632D228228C
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0781A3AC3B;
	Thu, 19 Oct 2023 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IHt+seyv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1068237C8D
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 17:50:05 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3A1126
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:50:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d86766bba9fso10701721276.1
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697737802; x=1698342602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V0I4G40SDem9EoiqhIJykQ6xj2oh6w8HOKaxFOFx5CY=;
        b=IHt+seyv2y4ZwqGyMBOWqc5Vh5EmC7tL4kEn19s6YYOyHSkSsJC3S3wtRzlsNy61Gw
         /q53T2vez89VaT4UrOAZlcVEmizxMHH0i1aBps51182/z44EkBZq7Q7epmurESWiA9Zq
         yuXpYbLwe26nYRenCu2tWUHPb07y1uj5qW6lFmXmameDqLfkrylhzerGt0xJbG5U4mB/
         2TPwpWN8OC3T01Za7EzLatt+rFl0+VPcksbay6jNYnZtREAZXyXb/fVw73mVzjclOjh1
         AyNb68aX+vouDsMrQWGnOCdUe29lBUzt6bslA5IIoUvy1K3hWFKLi0fYgpAifENkkJKn
         iTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697737802; x=1698342602;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0I4G40SDem9EoiqhIJykQ6xj2oh6w8HOKaxFOFx5CY=;
        b=lU+zLm5BtJCz5a2kceWuMtB/fEf5f6JMyoiTLNjkCNtGW0+HDrSNKj6/pNJN2aZyFJ
         oLg+52SmoenOYegZUV3JDGRKkMj5USdJeA0LDx6AMe8dmnd2M4pfxKDtLQM9H8joBTsX
         RJ1/TyILPT60F0UyLYOk00+ba7IU2M8QxnR06GXqdGxndICVkGQKVIJS3wQD22OJdBc4
         48jv7SuSK/sNCberyvklDWOQqu6/FeBuLdGNFUaB4apFqeLguLA1ql7ddCmWn3kBOltp
         BphTd47EwrJL2q5ybpxmWhGwBrTk9m0jmjMP7X9j+k945zGKn0xROnQPJ9GNtVScSrLt
         ilZA==
X-Gm-Message-State: AOJu0YysGZuXTEVJrjmWsY9Q7uiE8W22LIkrLn6ic+1XaZILuFScSSmZ
	DJNNZ2acUXqb/q6q8xDUEKrPRR4=
X-Google-Smtp-Source: AGHT+IHaK0IYER8v/qgm6gwZC2fZEmiPS33Jo+8bcfZVlSY0p21zvAQ1tceoITSieB3T+3ZALvV1JOU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:2443:0:b0:d9a:42b5:d160 with SMTP id
 k64-20020a252443000000b00d9a42b5d160mr65800ybk.10.1697737802491; Thu, 19 Oct
 2023 10:50:02 -0700 (PDT)
Date: Thu, 19 Oct 2023 10:49:42 -0700
In-Reply-To: <20231019174944.3376335-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231019174944.3376335-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019174944.3376335-10-sdf@google.com>
Subject: [PATCH bpf-next v4 09/11] selftests/bpf: Convert xdp_hw_metadata to XDP_USE_NEED_WAKEUP
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"

This is the recommended way to run af_xdp, so let's use it in the test.

Also, come unrelated changes to now blow up the log too much:
- change default mode to zerocopy and add -c to use copy mode
- small fixes for the flags/sizes/prints
- add print_tstamp_delta to print timestamp + reference

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 73 +++++++++++++------
 1 file changed, 49 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 17c0f92ff160..057f7c145f62 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -32,7 +32,7 @@
 
 #include "xdp_metadata.h"
 
-#define UMEM_NUM 16
+#define UMEM_NUM 256
 #define UMEM_FRAME_SIZE XSK_UMEM__DEFAULT_FRAME_SIZE
 #define UMEM_SIZE (UMEM_FRAME_SIZE * UMEM_NUM)
 #define XDP_FLAGS (XDP_FLAGS_DRV_MODE | XDP_FLAGS_REPLACE)
@@ -48,7 +48,7 @@ struct xsk {
 };
 
 struct xdp_hw_metadata *bpf_obj;
-__u16 bind_flags = XDP_COPY;
+__u16 bind_flags = XDP_USE_NEED_WAKEUP | XDP_ZEROCOPY;
 struct xsk *rx_xsk;
 const char *ifname;
 int ifindex;
@@ -68,7 +68,7 @@ static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
 		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
 		.comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
 		.frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE,
-		.flags = XDP_UMEM_UNALIGNED_CHUNK_FLAG,
+		.flags = XSK_UMEM__DEFAULT_FLAGS,
 	};
 	__u32 idx;
 	u64 addr;
@@ -110,7 +110,7 @@ static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
 	for (i = 0; i < UMEM_NUM / 2; i++) {
 		addr = (UMEM_NUM / 2 + i) * UMEM_FRAME_SIZE;
 		printf("%p: rx_desc[%d] -> %lx\n", xsk, i, addr);
-		*xsk_ring_prod__fill_addr(&xsk->fill, i) = addr;
+		*xsk_ring_prod__fill_addr(&xsk->fill, idx + i) = addr;
 	}
 	xsk_ring_prod__submit(&xsk->fill, ret);
 
@@ -131,12 +131,22 @@ static void refill_rx(struct xsk *xsk, __u64 addr)
 	__u32 idx;
 
 	if (xsk_ring_prod__reserve(&xsk->fill, 1, &idx) == 1) {
-		printf("%p: complete idx=%u addr=%llx\n", xsk, idx, addr);
+		printf("%p: complete rx idx=%u addr=%llx\n", xsk, idx, addr);
 		*xsk_ring_prod__fill_addr(&xsk->fill, idx) = addr;
 		xsk_ring_prod__submit(&xsk->fill, 1);
 	}
 }
 
+static int kick_tx(struct xsk *xsk)
+{
+	return sendto(xsk_socket__fd(xsk->socket), NULL, 0, MSG_DONTWAIT, NULL, 0);
+}
+
+static int kick_rx(struct xsk *xsk)
+{
+	return recvfrom(xsk_socket__fd(xsk->socket), NULL, 0, MSG_DONTWAIT, NULL, NULL);
+}
+
 #define NANOSEC_PER_SEC 1000000000 /* 10^9 */
 static __u64 gettime(clockid_t clock_id)
 {
@@ -152,6 +162,17 @@ static __u64 gettime(clockid_t clock_id)
 	return (__u64) t.tv_sec * NANOSEC_PER_SEC + t.tv_nsec;
 }
 
+static void print_tstamp_delta(const char *name, const char *refname,
+			       __u64 tstamp, __u64 reference)
+{
+	__s64 delta = (__s64)reference - (__s64)tstamp;
+
+	printf("%s:   %llu (sec:%0.4f) delta to %s sec:%0.4f (%0.3f usec)\n",
+	       name, tstamp, (double)tstamp / NANOSEC_PER_SEC, refname,
+	       (double)delta / NANOSEC_PER_SEC,
+	       (double)delta / 1000);
+}
+
 static void verify_xdp_metadata(void *data, clockid_t clock_id)
 {
 	struct xdp_meta *meta;
@@ -167,22 +188,13 @@ static void verify_xdp_metadata(void *data, clockid_t clock_id)
 	printf("rx_timestamp:  %llu (sec:%0.4f)\n", meta->rx_timestamp,
 	       (double)meta->rx_timestamp / NANOSEC_PER_SEC);
 	if (meta->rx_timestamp) {
-		__u64 usr_clock = gettime(clock_id);
-		__u64 xdp_clock = meta->xdp_timestamp;
-		__s64 delta_X = xdp_clock - meta->rx_timestamp;
-		__s64 delta_X2U = usr_clock - xdp_clock;
-
-		printf("XDP RX-time:   %llu (sec:%0.4f) delta sec:%0.4f (%0.3f usec)\n",
-		       xdp_clock, (double)xdp_clock / NANOSEC_PER_SEC,
-		       (double)delta_X / NANOSEC_PER_SEC,
-		       (double)delta_X / 1000);
-
-		printf("AF_XDP time:   %llu (sec:%0.4f) delta sec:%0.4f (%0.3f usec)\n",
-		       usr_clock, (double)usr_clock / NANOSEC_PER_SEC,
-		       (double)delta_X2U / NANOSEC_PER_SEC,
-		       (double)delta_X2U / 1000);
-	}
+		__u64 ref_tstamp = gettime(clock_id);
 
+		print_tstamp_delta("HW RX-time", "User RX-time",
+				   meta->rx_timestamp, ref_tstamp);
+		print_tstamp_delta("XDP RX-time", "User RX-time",
+				   meta->xdp_timestamp, ref_tstamp);
+	}
 }
 
 static void verify_skb_metadata(int fd)
@@ -252,6 +264,13 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
 
 	while (true) {
 		errno = 0;
+
+		for (i = 0; i < rxq; i++) {
+			ret = kick_rx(&rx_xsk[i]);
+			if (ret)
+				printf("kick_rx ret=%d\n", ret);
+		}
+
 		ret = poll(fds, rxq + 1, 1000);
 		printf("poll: %d (%d) skip=%llu fail=%llu redir=%llu\n",
 		       ret, errno, bpf_obj->bss->pkts_skip,
@@ -420,8 +439,9 @@ static void print_usage(void)
 {
 	const char *usage =
 		"Usage: xdp_hw_metadata [OPTIONS] [IFNAME]\n"
-		"  -m    Enable multi-buffer XDP for larger MTU\n"
+		"  -c    Run in copy mode (zerocopy is default)\n"
 		"  -h    Display this help and exit\n\n"
+		"  -m    Enable multi-buffer XDP for larger MTU\n"
 		"Generate test packets on the other machine with:\n"
 		"  echo -n xdp | nc -u -q1 <dst_ip> 9091\n";
 
@@ -432,14 +452,19 @@ static void read_args(int argc, char *argv[])
 {
 	char opt;
 
-	while ((opt = getopt(argc, argv, "mh")) != -1) {
+	while ((opt = getopt(argc, argv, "chm")) != -1) {
 		switch (opt) {
-		case 'm':
-			bind_flags |= XDP_USE_SG;
+		case 'c':
+			bind_flags &= ~XDP_USE_NEED_WAKEUP;
+			bind_flags &= ~XDP_ZEROCOPY;
+			bind_flags |= XDP_COPY;
 			break;
 		case 'h':
 			print_usage();
 			exit(0);
+		case 'm':
+			bind_flags |= XDP_USE_SG;
+			break;
 		case '?':
 			if (isprint(optopt))
 				fprintf(stderr, "Unknown option: -%c\n", optopt);
-- 
2.42.0.655.g421f12c284-goog


