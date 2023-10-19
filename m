Return-Path: <netdev+bounces-42768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D49A7D00F0
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E278D28221D
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D979A39861;
	Thu, 19 Oct 2023 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OgVWqd81"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E73139874
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 17:50:03 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C5E112
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:50:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a60a104b6so947759276.1
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697737800; x=1698342600; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1tVrf0osI1+3/xQU/AA9dhM9nXvYB7Bs3oYDJm+/bCI=;
        b=OgVWqd81p+IuHXJih+nGnFqjxlnu5i3jrYWnHFrNMtfz6poxI5N2Htw4o+LgPmP8Tq
         xN65aApTLAiFGQpzMWF/c4D2P0lNDf8W7leNm3Qs9RM/uEnN63ysecoa1WE4JBFUMOxD
         umYsGl8jMszv83CBqG1FE/hp6BSHafIqQ4qZqXL9zoLYuOaVthaiiUvCb57hkWhGyJmH
         usUnUtl7Pv2/3feGdTelN+w+TDMQTRe0KJbnYQQEIGGLoxrSbUA3sltRaGrFbLqPjTMy
         vb7UuCBtnew7dfbGaV0ra21CViWCB4w9IkLFxKGQmoBIjtyMy6YyxD0J7GPADye4t5mp
         U8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697737800; x=1698342600;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1tVrf0osI1+3/xQU/AA9dhM9nXvYB7Bs3oYDJm+/bCI=;
        b=cN7U1Jew0aHSePm1ZbLG4cx0qJ1YWl0wQmDxl08ywoE69t1/b8x4PCYHkNLiLm8wRB
         YxOuPRhD2mstPHRlj8gI00aF1Ixfg11lTRafRQ3WF6t9gdoINifdluLHRZK3GOJYKtK0
         4C0Ey+T7qaZvJMHw6ZOwKnh1SKRF/7KZCGIIdv+ZaSt1Yq9k5Hxx/SVp4V2IKJB95UFM
         +YE47xmAYt61iuGiMAIumiuFZV/q9geY472a/k9yZRUvR23FcI/MU0N4dAAdufaI0L7x
         59Nvxx/CSk3J3H5hGPezUGg5e+tUxa9MxK4l3qKyn62kl+ER3kD6NpQFaI36DbS3xLqv
         Vv3Q==
X-Gm-Message-State: AOJu0YxYchDF2dFvYgKgh3olAXovX4TMykfv+unNwrQmFYHQiqMVex75
	0/9Qnp6mnFzWRQUIdn4dMfBHMN8=
X-Google-Smtp-Source: AGHT+IGzyaRcZkGE3ht7tWT4tPXTNDiBhOc3sxxyx9CC1+YhWywewpSludRbZTm8rVl7NF4StpgWFOI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:1202:b0:d9a:b81b:fd66 with SMTP id
 s2-20020a056902120200b00d9ab81bfd66mr79680ybu.2.1697737800664; Thu, 19 Oct
 2023 10:50:00 -0700 (PDT)
Date: Thu, 19 Oct 2023 10:49:41 -0700
In-Reply-To: <20231019174944.3376335-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231019174944.3376335-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019174944.3376335-9-sdf@google.com>
Subject: [PATCH bpf-next v4 08/11] selftests/bpf: Add TX side to xdp_metadata
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

Request TX timestamp and make sure it's not empty.
Request TX checksum offload (SW-only) and make sure it's resolved
to the correct one.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 31 +++++++++++++++++--
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 4439ba9392f8..79e043370923 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -57,6 +57,7 @@ static int open_xsk(int ifindex, struct xsk *xsk)
 		.comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
 		.frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE,
 		.flags = XDP_UMEM_UNALIGNED_CHUNK_FLAG,
+		.tx_metadata_len = sizeof(struct xsk_tx_metadata),
 	};
 	__u32 idx;
 	u64 addr;
@@ -138,6 +139,7 @@ static void ip_csum(struct iphdr *iph)
 
 static int generate_packet(struct xsk *xsk, __u16 dst_port)
 {
+	struct xsk_tx_metadata *meta;
 	struct xdp_desc *tx_desc;
 	struct udphdr *udph;
 	struct ethhdr *eth;
@@ -151,10 +153,14 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
 		return -1;
 
 	tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx);
-	tx_desc->addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE;
+	tx_desc->addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE + sizeof(struct xsk_tx_metadata);
 	printf("%p: tx_desc[%u]->addr=%llx\n", xsk, idx, tx_desc->addr);
 	data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
 
+	meta = data - sizeof(struct xsk_tx_metadata);
+	memset(meta, 0, sizeof(*meta));
+	meta->flags = XDP_TX_METADATA_TIMESTAMP;
+
 	eth = data;
 	iph = (void *)(eth + 1);
 	udph = (void *)(iph + 1);
@@ -178,11 +184,17 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
 	udph->source = htons(AF_XDP_SOURCE_PORT);
 	udph->dest = htons(dst_port);
 	udph->len = htons(sizeof(*udph) + UDP_PAYLOAD_BYTES);
-	udph->check = 0;
+	udph->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr,
+					 ntohs(udph->len), IPPROTO_UDP, 0);
 
 	memset(udph + 1, 0xAA, UDP_PAYLOAD_BYTES);
 
+	meta->flags |= XDP_TX_METADATA_CHECKSUM | XDP_TX_METADATA_CHECKSUM_SW;
+	meta->csum_start = sizeof(*eth) + sizeof(*iph);
+	meta->csum_offset = offsetof(struct udphdr, check);
+
 	tx_desc->len = sizeof(*eth) + sizeof(*iph) + sizeof(*udph) + UDP_PAYLOAD_BYTES;
+	tx_desc->options |= XDP_TX_METADATA;
 	xsk_ring_prod__submit(&xsk->tx, 1);
 
 	ret = sendto(xsk_socket__fd(xsk->socket), NULL, 0, MSG_DONTWAIT, NULL, 0);
@@ -194,13 +206,21 @@ static int generate_packet(struct xsk *xsk, __u16 dst_port)
 
 static void complete_tx(struct xsk *xsk)
 {
-	__u32 idx;
+	struct xsk_tx_metadata *meta;
 	__u64 addr;
+	void *data;
+	__u32 idx;
 
 	if (ASSERT_EQ(xsk_ring_cons__peek(&xsk->comp, 1, &idx), 1, "xsk_ring_cons__peek")) {
 		addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx);
 
 		printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx, addr);
+
+		data = xsk_umem__get_data(xsk->umem_area, addr);
+		meta = data - sizeof(struct xsk_tx_metadata);
+
+		ASSERT_NEQ(meta->completion.tx_timestamp, 0, "tx_timestamp");
+
 		xsk_ring_cons__release(&xsk->comp, 1);
 	}
 }
@@ -221,6 +241,7 @@ static int verify_xsk_metadata(struct xsk *xsk)
 	const struct xdp_desc *rx_desc;
 	struct pollfd fds = {};
 	struct xdp_meta *meta;
+	struct udphdr *udph;
 	struct ethhdr *eth;
 	struct iphdr *iph;
 	__u64 comp_addr;
@@ -257,6 +278,7 @@ static int verify_xsk_metadata(struct xsk *xsk)
 	ASSERT_EQ(eth->h_proto, htons(ETH_P_IP), "eth->h_proto");
 	iph = (void *)(eth + 1);
 	ASSERT_EQ((int)iph->version, 4, "iph->version");
+	udph = (void *)(iph + 1);
 
 	/* custom metadata */
 
@@ -270,6 +292,9 @@ static int verify_xsk_metadata(struct xsk *xsk)
 
 	ASSERT_EQ(meta->rx_hash_type, 0, "rx_hash_type");
 
+	/* checksum offload */
+	ASSERT_EQ(udph->check, 0x1c72, "csum");
+
 	xsk_ring_cons__release(&xsk->rx, 1);
 	refill_rx(xsk, comp_addr);
 
-- 
2.42.0.655.g421f12c284-goog


