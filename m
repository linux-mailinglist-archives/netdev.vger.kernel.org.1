Return-Path: <netdev+bounces-45834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A61CD7DFD1C
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 00:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3C3281E47
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 23:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA8723763;
	Thu,  2 Nov 2023 22:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lbifFUed"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCF4241F5
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 22:59:01 +0000 (UTC)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E65133
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 15:59:00 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cc29f3afe0so12292945ad.2
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 15:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698965940; x=1699570740; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dQa6UGFIhvagf5iHtxwy2S77Dl6tSWrDDUnqP4yyJ24=;
        b=lbifFUedPSbct5C/LAuzmY3kzBRK14uSoFZRJUTn9jcQT9Xa5cNZ28YkDXuHSv03Sr
         m5vFeCiBBgrbHv6m/Vub+FJmZY2ysZhGgB58g7Ijfd7HabndMvIkLWNbCrVNYpEyNk/f
         ahXhkEQAfUbd3N6M9BCWzpMZJHXpdCQlA1CCczqoQrdM9e9g0glw5LAMB+Vfb0UlaBT3
         vD+b1D/AxZtcSVcWbcJ5NpXh/oHugHtmRhVdlPI+lisbC1PdNrzibtGGrk49L6N6X2nr
         JOZ9gXlDeUtol1N9XK9rBXUJJ/3xl9QpNCpBBg5Tju3c7tGSxo2kfEKhndHV7ozWEPlx
         HQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698965940; x=1699570740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQa6UGFIhvagf5iHtxwy2S77Dl6tSWrDDUnqP4yyJ24=;
        b=GJONGO7PjBsAevHfxeRDc/ZCB3azfZXGxH1yWrev2BFwWTU7xJCn0yLIkTZU90aykh
         U4WZ47bjLnza75grYe/oqO8Jm/qDqJ2j2GD0CgWjQsbAwQbxQJBEpeyaHi+2gT4b5nCb
         PfG1Caswi6K1uhEeHGq8PXJ1a2o6POAnCtDzWy3tt0PwtkhkhpsmZCCGPdz3ca+51fVe
         ERnw9OVIi36vJfdPEUQECJi4CWqOXT4BQYBFjbwcdUJHnaar2iWdphfHr0WsK5Pbx8R6
         4zfGktoxZ/MNmUYsFnbi4R++YQrgBZ5H4/2w4x3ful99hJjjWRaUuNTwlw3n2rSVfVj2
         0uYA==
X-Gm-Message-State: AOJu0YxfVzngR7equpHAVoZ/sVBu6GDmBu8es2Lm9Ox8LcIkKb8wm3t5
	n8ioTzXg5pxZOkoWnRe4yy1m9AA=
X-Google-Smtp-Source: AGHT+IHv0MEzw3LQnjLafs43YmbvepD2LmqtZjHeCsplTM331Pz+i8egVtOE5buydbeig+TVsZuQU3o=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:f7d6:b0:1cc:23d2:bb94 with SMTP id
 h22-20020a170902f7d600b001cc23d2bb94mr322063plw.1.1698965940246; Thu, 02 Nov
 2023 15:59:00 -0700 (PDT)
Date: Thu,  2 Nov 2023 15:58:36 -0700
In-Reply-To: <20231102225837.1141915-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102225837.1141915-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102225837.1141915-13-sdf@google.com>
Subject: [PATCH bpf-next v5 12/13] selftests/bpf: Convert xdp_hw_metadata to XDP_USE_NEED_WAKEUP
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

This is the recommended way to run AF_XDP, so let's use it in the test.

Also, some unrelated changes to now blow up the log too much:
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
2.42.0.869.gea05f2083d-goog


