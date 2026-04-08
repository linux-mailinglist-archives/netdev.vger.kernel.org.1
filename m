Return-Path: <netdev+bounces-276644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAN6LXWF1mmwFwgAu9opvQ
	(envelope-from <netdev+bounces-276644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:42:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAF53BEFE1
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0267530729CD
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 16:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3372A3D3009;
	Wed,  8 Apr 2026 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="aSM0QS4o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vdfseClZ"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFA63D3304
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775666325; cv=none; b=oy+C4fkvpWFbDNahKppJdUKFrvBLMBSmhO1uSbg/8mjPZ3Zg6z3bSZJO2x2fDiyxXu5hGW8TmydPxtt4b+wwKSaEuNMjYUk0UJp2TPiDZXIndumkGrRKX2R9aXn4VXJ2ZlJluZL1wnEjLCUtnwD8A0BF32DQcqz2b1M7vw5BEoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775666325; c=relaxed/simple;
	bh=NrK77Jqz0H1Z4gEPw11EO1Vqdzxsx9s9eUBFsgEurG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXrw4Y/Tv1hf7KMlOf+mKR74vK2pdrLaGADjf+/NHj+FXd6yi00/TrNRZx3iXh0vMpvsojqgrWTdCOijuGNZlx7RciHc7tJlxLp5Pv/SZ/NREL8AbGjMG9V6IpoTBsOOhK2sboNF0Hbh1E03AsgR5UA6pIwht4qy7KjiUbZbdac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=aSM0QS4o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vdfseClZ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C81B7140002C;
	Wed,  8 Apr 2026 12:38:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 08 Apr 2026 12:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1775666322; x=
	1775752722; bh=EOuvHsWmuP1bXxuecZWKK4JnfNTsRRIbnAkUXym9jDo=; b=a
	SM0QS4odulakx4GVpfZRvGaY3UmlrJQ1r3SW/1eW1FwemFsya5DI3kb8s+IcoHlM
	HDSuvObE3wMF2llnrKDTi4HY9Np6/DFEwiyRMsvURrVL6eEqtu+hPh0A2LzsnADY
	oXjXYgD5xlfvjpNxeOjYBQ0OhJnoYTfcd1jPF58mWuWT8j0bq2g8wFB75J/XPjNQ
	PwnUlYcP1Lbt+GcofFkcskWQHdlDIj8MhMgoZtkL40QySIkbuVvlpw/9KOngMGly
	vENxuhJFZcI00h5Py8F1La+IzcmgA45+TDGL/Ne7azDn4Ufqt0nDIRpdsz36E2UP
	WL9CEKhsE+zK68t5nx2Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775666322; x=1775752722; bh=E
	OuvHsWmuP1bXxuecZWKK4JnfNTsRRIbnAkUXym9jDo=; b=vdfseClZmmZZgYZYT
	jMVFUOpoeR7/3X6pU26XTKBTk0McQAAM7ORnbOAk3SNG0k/Qvayi3GS3bFyBlZUV
	dd5QdUn/OYz0U+PRufT0n+qJsgBJ66JmS3ExXq5kLUH4cWvSRFCH5HvLVtL33J/x
	cCEomdlTBzkfNpyfgy1wdiVmpS+ycXbfjgelNRo3fuScfOwvCHma9fjDH4VSklMD
	eLoD6fSUaoJZbtUOm/hkO5bqo6TWdLigYI8RPFOfiXG3fW2kWZs+DYoaoSeAVKQ2
	gEFw+4BAuHB+1NPa8mKxZS8LXSl4NuiF7jcLeT49LciB8ArXEhL+27guPvJFH2PX
	OJkJg==
X-ME-Sender: <xms:koTWadra3xrU509T2QpMph61XvHzphn3cuPP-dTHhMbaT-vZG3d_RQ>
    <xme:koTWaVqqezVg6z9CcJUvt2P_mN_zGiYMTvnNcoGjSw4HkEbS8J9IUja4_kK50IJIc
    sN9Vmnvbk4Aer6AWwJKwduBlAoo0gS6vMKh987wMgsiw_xaVmkrKpw>
X-ME-Received: <xmr:koTWaX1a9SuMCmlsIFL_k6PcArZM9AD04Z6uBzj4T2sJc8jmMdg4jqSH1fhEm865a56jnBo06DIddRN5SWc3y5wL-reChjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhurghnlhhuucfjvghrrhgvrhhouceojhhurghnlhhusehfrghs
    thhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgeeiieegudejfedvheehjedutd
    fgffekgffguedvhfehkedtvdekkeehkeefheevnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepjhhurghnlhhusehfrghsthhmrghilhdrtghomh
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhurghnlhhuse
    hfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:koTWaUAe2h8BzVoZdViDiDANyYWs5KqDNp2u6VI-msJ4q7lk1r6rUA>
    <xmx:koTWaffe0tMknbeuxMpf6Y3Bl-tEX-c_YBF4CAhMImkv9zpJGxXwdg>
    <xmx:koTWaZjEZgBVB8oCnUOqkA3eeqK2WG3JDIeZQxsFbnLMaXpmeh1E4Q>
    <xmx:koTWaXr3FmgMEgo_DMRKavj29yUJZ1_hWdYmJurr_Vz1mpfXtRdjJQ>
    <xmx:koTWaRBeDU7JH4XY_-xaXzCCt6YMmMP8MDH3NlxFZYt0yx-jv8MtrV24>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 12:38:42 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: netdev@vger.kernel.org
Cc: Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH 4/5] selftests: net: add multithread server support to iou-zcrx
Date: Wed,  8 Apr 2026 11:38:15 -0500
Message-ID: <20260408163816.2760-5-juanlu@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408163816.2760-1-juanlu@fastmail.com>
References: <20260408163816.2760-1-juanlu@fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.com,none];
	R_DKIM_ALLOW(-0.20)[fastmail.com:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[fastmail.com];
	TAGGED_FROM(0.00)[bounces-276644-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juanlu@fastmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.com:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	FREEMAIL_FROM(0.00)[fastmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim,fastmail.com:dkim,fastmail.com:email,fastmail.com:mid]
X-Rspamd-Queue-Id: 6BAF53BEFE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move server state (io_uring ring, zcrx area, receive tracking) from
global variables into struct thread_ctx and thread the server side.

The main thread creates a single listening socket, spawns N worker
threads (each setting up its own io_uring and zcrx instance), then
accepts N connections and distributes them to the workers via
pthread barriers for synchronization.

Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
---
 .../selftests/drivers/net/hw/iou-zcrx.c       | 247 ++++++++++--------
 1 file changed, 140 insertions(+), 107 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index 6185c855b85c..646682167bb0 100644
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
@@ -89,20 +89,22 @@ static bool cfg_dry_run;
 static int cfg_num_threads = 1;
 
 static char *payload;
+static pthread_barrier_t barrier;
 
 struct thread_ctx {
+	struct io_uring		ring;
+	void			*area_ptr;
+	void			*ring_ptr;
+	size_t			ring_size;
+	struct io_uring_zcrx_rq	rq_ring;
+	unsigned long		area_token;
+	int			connfd;
+	bool			stop;
+	size_t			received;
+	int			queue_id;
 	int			thread_id;
 };
 
-static void *area_ptr;
-static void *ring_ptr;
-static size_t ring_size;
-static struct io_uring_zcrx_rq rq_ring;
-static unsigned long area_token;
-static int connfd;
-static bool stop;
-static size_t received;
-
 static unsigned long gettimeofday_ms(void)
 {
 	struct timeval tv;
@@ -145,7 +147,7 @@ static inline size_t get_refill_ring_size(unsigned int rq_entries)
 	return ALIGN_UP(size, page_size);
 }
 
-static void setup_zcrx(struct io_uring *ring)
+static void setup_zcrx(struct thread_ctx *ctx)
 {
 	unsigned int ifindex;
 	unsigned int rq_entries = 4096;
@@ -156,58 +158,58 @@ static void setup_zcrx(struct io_uring *ring)
 		error(1, 0, "bad interface name: %s", cfg_ifname);
 
 	if (cfg_rx_buf_len && cfg_rx_buf_len != page_size) {
-		area_ptr = mmap(NULL,
-				AREA_SIZE,
-				PROT_READ | PROT_WRITE,
-				MAP_ANONYMOUS | MAP_PRIVATE |
-				MAP_HUGETLB | MAP_HUGE_2MB,
-				-1,
-				0);
-		if (area_ptr == MAP_FAILED) {
+		ctx->area_ptr = mmap(NULL,
+				     AREA_SIZE,
+				     PROT_READ | PROT_WRITE,
+				     MAP_ANONYMOUS | MAP_PRIVATE |
+				     MAP_HUGETLB | MAP_HUGE_2MB,
+				     -1,
+				     0);
+		if (ctx->area_ptr == MAP_FAILED) {
 			printf("Can't allocate huge pages\n");
 			exit(SKIP_CODE);
 		}
 	} else {
-		area_ptr = mmap(NULL,
-				AREA_SIZE,
-				PROT_READ | PROT_WRITE,
-				MAP_ANONYMOUS | MAP_PRIVATE,
-				0,
-				0);
-		if (area_ptr == MAP_FAILED)
+		ctx->area_ptr = mmap(NULL,
+				     AREA_SIZE,
+				     PROT_READ | PROT_WRITE,
+				     MAP_ANONYMOUS | MAP_PRIVATE,
+				     0,
+				     0);
+		if (ctx->area_ptr == MAP_FAILED)
 			error(1, 0, "mmap(): zero copy area");
 	}
 
-	ring_size = get_refill_ring_size(rq_entries);
-	ring_ptr = mmap(NULL,
-			ring_size,
-			PROT_READ | PROT_WRITE,
-			MAP_ANONYMOUS | MAP_PRIVATE,
-			0,
-			0);
+	ctx->ring_size = get_refill_ring_size(rq_entries);
+	ctx->ring_ptr = mmap(NULL,
+			     ctx->ring_size,
+			     PROT_READ | PROT_WRITE,
+			     MAP_ANONYMOUS | MAP_PRIVATE,
+			     0,
+			     0);
 
 	struct io_uring_region_desc region_reg = {
-		.size = ring_size,
-		.user_addr = (__u64)(unsigned long)ring_ptr,
+		.size = ctx->ring_size,
+		.user_addr = (__u64)(unsigned long)ctx->ring_ptr,
 		.flags = IORING_MEM_REGION_TYPE_USER,
 	};
 
 	struct io_uring_zcrx_area_reg area_reg = {
-		.addr = (__u64)(unsigned long)area_ptr,
+		.addr = (__u64)(unsigned long)ctx->area_ptr,
 		.len = AREA_SIZE,
 		.flags = 0,
 	};
 
 	struct t_io_uring_zcrx_ifq_reg reg = {
 		.if_idx = ifindex,
-		.if_rxq = cfg_queue_id,
+		.if_rxq = ctx->queue_id,
 		.rq_entries = rq_entries,
 		.area_ptr = (__u64)(unsigned long)&area_reg,
 		.region_ptr = (__u64)(unsigned long)&region_reg,
 		.rx_buf_len = cfg_rx_buf_len,
 	};
 
-	ret = io_uring_register_ifq(ring, (void *)&reg);
+	ret = io_uring_register_ifq(&ctx->ring, (void *)&reg);
 	if (cfg_rx_buf_len && (ret == -EINVAL || ret == -EOPNOTSUPP ||
 			       ret == -ERANGE)) {
 		printf("Large chunks are not supported %i\n", ret);
@@ -216,64 +218,40 @@ static void setup_zcrx(struct io_uring *ring)
 		error(1, 0, "io_uring_register_ifq(): %d", ret);
 	}
 
-	rq_ring.khead = (unsigned int *)((char *)ring_ptr + reg.offsets.head);
-	rq_ring.ktail = (unsigned int *)((char *)ring_ptr + reg.offsets.tail);
-	rq_ring.rqes = (struct io_uring_zcrx_rqe *)((char *)ring_ptr + reg.offsets.rqes);
-	rq_ring.rq_tail = 0;
-	rq_ring.ring_entries = reg.rq_entries;
-
-	area_token = area_reg.rq_area_token;
-}
-
-static void add_accept(struct io_uring *ring, int sockfd)
-{
-	struct io_uring_sqe *sqe;
-
-	sqe = io_uring_get_sqe(ring);
+	ctx->rq_ring.khead = (unsigned int *)((char *)ctx->ring_ptr + reg.offsets.head);
+	ctx->rq_ring.ktail = (unsigned int *)((char *)ctx->ring_ptr + reg.offsets.tail);
+	ctx->rq_ring.rqes = (struct io_uring_zcrx_rqe *)((char *)ctx->ring_ptr + reg.offsets.rqes);
+	ctx->rq_ring.rq_tail = 0;
+	ctx->rq_ring.ring_entries = reg.rq_entries;
 
-	io_uring_prep_accept(sqe, sockfd, NULL, NULL, 0);
-	sqe->user_data = 1;
+	ctx->area_token = area_reg.rq_area_token;
 }
 
-static void add_recvzc(struct io_uring *ring, int sockfd)
+static void add_recvzc(struct thread_ctx *ctx, int sockfd)
 {
 	struct io_uring_sqe *sqe;
 
-	sqe = io_uring_get_sqe(ring);
+	sqe = io_uring_get_sqe(&ctx->ring);
 
 	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, sockfd, NULL, 0, 0);
 	sqe->ioprio |= IORING_RECV_MULTISHOT;
 	sqe->user_data = 2;
 }
 
-static void add_recvzc_oneshot(struct io_uring *ring, int sockfd, size_t len)
+static void add_recvzc_oneshot(struct thread_ctx *ctx, int sockfd, size_t len)
 {
 	struct io_uring_sqe *sqe;
 
-	sqe = io_uring_get_sqe(ring);
+	sqe = io_uring_get_sqe(&ctx->ring);
 
 	io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, sockfd, NULL, len, 0);
 	sqe->ioprio |= IORING_RECV_MULTISHOT;
 	sqe->user_data = 2;
 }
 
-static void process_accept(struct io_uring *ring, struct io_uring_cqe *cqe)
+static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe)
 {
-	if (cqe->res < 0)
-		error(1, 0, "accept()");
-	if (connfd)
-		error(1, 0, "Unexpected second connection");
-
-	connfd = cqe->res;
-	if (cfg_oneshot)
-		add_recvzc_oneshot(ring, connfd, page_size);
-	else
-		add_recvzc(ring, connfd);
-}
-
-static void process_recvzc(struct io_uring *ring, struct io_uring_cqe *cqe)
-{
-	unsigned rq_mask = rq_ring.ring_entries - 1;
+	unsigned rq_mask = ctx->rq_ring.ring_entries - 1;
 	struct io_uring_zcrx_cqe *rcqe;
 	struct io_uring_zcrx_rqe *rqe;
 	uint64_t mask;
@@ -282,7 +260,7 @@ static void process_recvzc(struct io_uring *ring, struct io_uring_cqe *cqe)
 	int i;
 
 	if (cqe->res == 0 && cqe->flags == 0 && cfg_oneshot_recvs == 0) {
-		stop = true;
+		ctx->stop = true;
 		return;
 	}
 
@@ -291,59 +269,99 @@ static void process_recvzc(struct io_uring *ring, struct io_uring_cqe *cqe)
 
 	if (cfg_oneshot) {
 		if (cqe->res == 0 && cqe->flags == 0 && cfg_oneshot_recvs) {
-			add_recvzc_oneshot(ring, connfd, page_size);
+			add_recvzc_oneshot(ctx, ctx->connfd, page_size);
 			cfg_oneshot_recvs--;
 		}
 	} else if (!(cqe->flags & IORING_CQE_F_MORE)) {
-		add_recvzc(ring, connfd);
+		add_recvzc(ctx, ctx->connfd);
 	}
 
 	rcqe = (struct io_uring_zcrx_cqe *)(cqe + 1);
 
 	n = cqe->res;
 	mask = (1ULL << IORING_ZCRX_AREA_SHIFT) - 1;
-	data = (char *)area_ptr + (rcqe->off & mask);
+	data = (char *)ctx->area_ptr + (rcqe->off & mask);
 
 	for (i = 0; i < n; i++) {
-		if (*(data + i) != payload[(received + i)])
+		if (*(data + i) != payload[(ctx->received + i)])
 			error(1, 0, "payload mismatch at %d", i);
 	}
-	received += n;
+	ctx->received += n;
 
-	rqe = &rq_ring.rqes[(rq_ring.rq_tail & rq_mask)];
-	rqe->off = (rcqe->off & ~IORING_ZCRX_AREA_MASK) | area_token;
+	rqe = &ctx->rq_ring.rqes[(ctx->rq_ring.rq_tail & rq_mask)];
+	rqe->off = (rcqe->off & ~IORING_ZCRX_AREA_MASK) | ctx->area_token;
 	rqe->len = cqe->res;
-	io_uring_smp_store_release(rq_ring.ktail, ++rq_ring.rq_tail);
+	io_uring_smp_store_release(ctx->rq_ring.ktail, ++ctx->rq_ring.rq_tail);
 }
 
-static void server_loop(struct io_uring *ring)
+static void server_loop(struct thread_ctx *ctx)
 {
 	struct io_uring_cqe *cqe;
 	unsigned int count = 0;
 	unsigned int head;
 	int i, ret;
 
-	io_uring_submit_and_wait(ring, 1);
+	io_uring_submit_and_wait(&ctx->ring, 1);
 
-	io_uring_for_each_cqe(ring, head, cqe) {
-		if (cqe->user_data == 1)
-			process_accept(ring, cqe);
-		else if (cqe->user_data == 2)
-			process_recvzc(ring, cqe);
+	io_uring_for_each_cqe(&ctx->ring, head, cqe) {
+		if (cqe->user_data == 2)
+			process_recvzc(ctx, cqe);
 		else
 			error(1, 0, "unknown cqe");
 		count++;
 	}
-	io_uring_cq_advance(ring, count);
+	io_uring_cq_advance(&ctx->ring, count);
 }
 
-static void run_server(void)
+static void *server_worker(void *arg)
 {
+	struct thread_ctx *ctx = arg;
 	unsigned int flags = 0;
-	struct io_uring ring;
-	int fd, enable, ret;
 	uint64_t tstop;
 
+	flags |= IORING_SETUP_COOP_TASKRUN;
+	flags |= IORING_SETUP_SINGLE_ISSUER;
+	flags |= IORING_SETUP_DEFER_TASKRUN;
+	flags |= IORING_SETUP_SUBMIT_ALL;
+	flags |= IORING_SETUP_CQE32;
+
+	io_uring_queue_init(512, &ctx->ring, flags);
+
+	setup_zcrx(ctx);
+
+	pthread_barrier_wait(&barrier);
+
+	if (cfg_dry_run)
+		return NULL;
+
+	pthread_barrier_wait(&barrier);
+
+	if (cfg_oneshot)
+		add_recvzc_oneshot(ctx, ctx->connfd, page_size);
+	else
+		add_recvzc(ctx, ctx->connfd);
+
+	tstop = gettimeofday_ms() + 5000;
+	while (!ctx->stop && gettimeofday_ms() < tstop)
+		server_loop(ctx);
+
+	if (!ctx->stop)
+		error(1, 0, "test failed\n");
+
+	return NULL;
+}
+
+static void run_server(void)
+{
+	struct thread_ctx *ctxs;
+	pthread_t *threads;
+	int fd, ret, i, enable;
+
+	ctxs = calloc(cfg_num_threads, sizeof(*ctxs));
+	threads = calloc(cfg_num_threads, sizeof(*threads));
+	if (!ctxs || !threads)
+		error(1, 0, "calloc()");
+
 	fd = socket(AF_INET6, SOCK_STREAM, 0);
 	if (fd == -1)
 		error(1, 0, "socket()");
@@ -360,26 +378,41 @@ static void run_server(void)
 	if (listen(fd, 1024) < 0)
 		error(1, 0, "listen()");
 
-	flags |= IORING_SETUP_COOP_TASKRUN;
-	flags |= IORING_SETUP_SINGLE_ISSUER;
-	flags |= IORING_SETUP_DEFER_TASKRUN;
-	flags |= IORING_SETUP_SUBMIT_ALL;
-	flags |= IORING_SETUP_CQE32;
+	pthread_barrier_init(&barrier, NULL, cfg_num_threads + 1);
+
+	for (i = 0; i < cfg_num_threads; i++) {
+		ctxs[i].queue_id = cfg_queue_id + i;
+		ctxs[i].thread_id = i;
+	}
 
-	io_uring_queue_init(512, &ring, flags);
+	for (i = 0; i < cfg_num_threads; i++) {
+		ret = pthread_create(&threads[i], NULL, server_worker,
+				     &ctxs[i]);
+		if (ret)
+			error(1, ret, "pthread_create()");
+	}
+
+	pthread_barrier_wait(&barrier);
 
-	setup_zcrx(&ring);
 	if (cfg_dry_run)
-		return;
+		goto join;
+
+	for (i = 0; i < cfg_num_threads; i++) {
+		ctxs[i].connfd = accept(fd, NULL, NULL);
+		if (ctxs[i].connfd < 0)
+			error(1, 0, "accept()");
+	}
 
-	add_accept(&ring, fd);
+	pthread_barrier_wait(&barrier);
 
-	tstop = gettimeofday_ms() + 5000;
-	while (!stop && gettimeofday_ms() < tstop)
-		server_loop(&ring);
+join:
+	for (i = 0; i < cfg_num_threads; i++)
+		pthread_join(threads[i], NULL);
 
-	if (!stop)
-		error(1, 0, "test failed\n");
+	pthread_barrier_destroy(&barrier);
+	close(fd);
+	free(threads);
+	free(ctxs);
 }
 
 static void *client_worker(void *arg)
-- 
2.53.0


