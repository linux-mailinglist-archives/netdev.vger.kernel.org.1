Return-Path: <netdev+bounces-305758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +5vQGocoTmocEQIAu9opvQ
	(envelope-from <netdev+bounces-305758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:37:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1A0724679
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:37:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Q2spR+fO;
	dkim=pass header.d=redhat.com header.s=google header.b=ZJ+eCHMK;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305758-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305758-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF32730A1F63
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 10:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A6142255B;
	Wed,  8 Jul 2026 10:29:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FB841B36E
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 10:29:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506568; cv=none; b=h26NDfXiEVyLrecmngBXzoQPdbHBwNzSN3Tq6l1QrBdrxbLeC5/h4DhERLK/BUvZeG2tK07iIMq1V4otjKe65C+u5nZCj/S9NWkMNsStXH60tjVPK2XyZeC4SnZkbD94+C6rciKuVttf8RJ3l7NOI7uQtm125PLD9AKAUmdx3TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506568; c=relaxed/simple;
	bh=qNZiJSTEfc7fTVZbT1Hdz+TpSbOWakYcGAe5W8RAZ0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcF6vhQZXgniIhPSBG87+dZT8VQT+gqc6IPkvB2o/hXZhS24g2ovErxge0lNNmZNnnBPMT4JeFs7lUafZ2IInBq3FLzcTwdKj7h6Z2WbVPW2QMwl9H/ygSkVaB/4AeRFqsxzvxg9E3w5kmXgsRo2FErlF2vjlozKU379KF4sf9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q2spR+fO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJ+eCHMK; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783506560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s31Zp5IE8kvOUi9c30CVIvqfz2iKzORtScqC5v+Omgg=;
	b=Q2spR+fOfLu0Yua9vZr1N9oDGS4sKdckEsu0FVoWJErat8SRaeUYmWb8pws44ilhJFlgF6
	gDsQv+5QMBWZfTgxpgwVwMcoL9b33jiLI+eHHVGi4MIuVRIduiozN0w+uP6LEVX32/gmBY
	mV/Hw1f0UYKnOBU443C6zoe2lVWvIFk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-lGvOyoH-PFiaD9wGNczeoQ-1; Wed, 08 Jul 2026 06:29:18 -0400
X-MC-Unique: lGvOyoH-PFiaD9wGNczeoQ-1
X-Mimecast-MFC-AGG-ID: lGvOyoH-PFiaD9wGNczeoQ_1783506557
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-472bdd6f529so406544f8f.1
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 03:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783506557; x=1784111357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s31Zp5IE8kvOUi9c30CVIvqfz2iKzORtScqC5v+Omgg=;
        b=ZJ+eCHMK3R7j+L+r/kYfzRJdAwh3wE9G80wMTBjO0LrNgrErx1NBt0A+00cDJcr7HU
         XE8Sc/pfwxfbji9rroVv1ISaHmlGKMHZy6O//shgkDc6gkcz+QgvFqS3TX4H/vXQ31qO
         7ccy38zOdqJgdkFaqpOFlRGWBitfU8iER9FpysmarUj4AszOvkVqd2VT/dvDlMYvWPw6
         nCR+dbpxiKJVf1cRQOGEOx0VdeNh3Cq5vvtUU2NSfORPm7m3DT/MnXXY82Qw3FZ3ZZUa
         Fw5rJSNejtpbN2zTU71W122vJik+SLkZrzVEBjAGULGiNrMXBrLrMN9vrX3nOVQUlf6E
         Y2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783506557; x=1784111357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s31Zp5IE8kvOUi9c30CVIvqfz2iKzORtScqC5v+Omgg=;
        b=cJs4Ewrx7b0pZ4sMmqM8HiM5TYbOywtBKB5KJmcunVR7KXPpXozRTtATfj5Ab55DSc
         x/R8cmh4yD67SBh8xjKtBjymqetUdjjmmdLYsvsFVRxbpxa4r2HasseYNOiSpJudOFoT
         vzv8QeHs8Cv0QGt6i5R/djRRLz3VfktyADnrx6YeWxh7GVrsiWrDm6YompvmudEE/TWX
         IE1yQ6uWy4ZqxmEfFDQbQHcGNiakGFa3gPniBq1Wk3Rk0SDa/wKaSoMin5wcqvFupBk4
         uXQxw3vXmI2uALHrj/hi1Xo4nEhbD7ZMHNuIiYMhDrOZk3Ub+5qHAF8KIfbcYFSCBBoo
         r89w==
X-Gm-Message-State: AOJu0YzsnC/Bc/zawkwMW6paxnaUGRa639SUennQXpvS7fIu/dr9q2Op
	aYqCBL5itU+j1IEcxHB6oy3/4CpjfEPS/ass43XGFZmbxVIl/r6KDrNskAud6C+8WVdq7TvwNwE
	u0k8lTpJGv3jbURXVK3j6dF2fMOZfHgPFQsbGd4SmlCnaIqLr/V8PUKcRhwxMITZ8DTktsj4enQ
	/Sw7VZvETJM8/ZJXKTEdlBEIriCNZJiRTamlsAo2H+1Q==
X-Gm-Gg: AfdE7ckZMhH4LCtOWC6MUMOl7LJrmRxfymr25ZyOauhxnpITFI7UIpVKMbsUPjvWqqw
	TtXVYO9Mcag53vrKAs2NTiMo+3ZrctQg1fTwafF/t528AN6IfF2Vbgmo/UYYyFjuL7E2CTgtN9+
	iKkMI/jzphghWIBAYinatOOSpK9KX+mxC1U1rqtGeeuvdrb9qwyDPWb83TnpBRS/qTVXeHXK3m2
	iMe7PPM/bmaJIRvRoApG/Kq1B8Gj32LT4OpUZmCzuZGZ2AxE1hEIsw8iWqrC2owcFMT9vUMQrak
	T2MKZlB48VdVoAWbrWSbj4OkXJ/+BTIveEMXBy5rVL93poLn5tPCFDvasVMIr8Vb5tP93JCrv0o
	oSRrTqocD0jkk81fKISDGm5jJzsrSH4Ts0oeNRltK94YS36Y=
X-Received: by 2002:a05:6000:24ca:b0:462:e086:35f with SMTP id ffacd0b85a97d-47df0725e5cmr2146647f8f.21.1783506556986;
        Wed, 08 Jul 2026 03:29:16 -0700 (PDT)
X-Received: by 2002:a05:6000:24ca:b0:462:e086:35f with SMTP id ffacd0b85a97d-47df0725e5cmr2146583f8f.21.1783506556408;
        Wed, 08 Jul 2026 03:29:16 -0700 (PDT)
Received: from stex1 (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f214d2sm40461480f8f.33.2026.07.08.03.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 03:29:15 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Jason Wang <jasowangio@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH net v2 2/2] vsock/test: add test for small packets under pressure
Date: Wed,  8 Jul 2026 12:29:04 +0200
Message-ID: <20260708102904.50732-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708102904.50732-1-sgarzare@redhat.com>
References: <20260708102904.50732-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305758-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,linux.alibaba.com,google.com,kernel.org,davemloft.net,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jasowangio@gmail.com,m:sgarzare@redhat.com,m:xuanzhuo@linux.alibaba.com,m:edumazet@google.com,m:eperezma@redhat.com,m:horms@kernel.org,m:stefanha@redhat.com,m:davem@davemloft.net,m:linux-kernel@vger.kernel.org,m:mst@redhat.com,m:kvm@vger.kernel.org,m:pabeni@redhat.com,m:virtualization@lists.linux.dev,m:kuba@kernel.org,m:jasowang@redhat.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC1A0724679

From: Stefano Garzarella <sgarzare@redhat.com>

Add a test that sends 2 MB of data using randomly sized small packets
(129-512 bytes) over a SOCK_STREAM connection. Packets above
GOOD_COPY_LEN (128) bypass the in-place coalescing in recv_enqueue(),
forcing each one into its own skb.

Without receive queue collapsing, the per-skb overhead eventually
exceeds buf_alloc and the connection is reset. The test verifies
that all data arrives and that content integrity is preserved.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 87 ++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 76be0e4a7f0e..b4ff9f946565 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -2347,6 +2347,88 @@ static void test_stream_tx_credit_bounds_server(const struct test_opts *opts)
 	close(fd);
 }
 
+/* Test that many small packets don't cause a connection reset under pressure
+ * and that data integrity is preserved.  Packet sizes vary randomly between
+ * 129 and 512 bytes, above GOOD_COPY_LEN (128) to bypass in-place coalescing
+ * in recv_enqueue, forcing each one into its own skb.  Without receive queue
+ * collapsing, the per-skb overhead eventually exceeds buf_alloc and the
+ * connection is reset.
+ */
+#define COLLAPSE_PKT_MIN 129
+#define COLLAPSE_PKT_MAX 512
+#define COLLAPSE_TOTAL (2 * 1024 * 1024)
+
+static void test_stream_collapse_client(const struct test_opts *opts)
+{
+	unsigned char *data;
+	unsigned long hash;
+	size_t offset = 0;
+	int i, fd;
+
+	data = malloc(COLLAPSE_TOTAL);
+	if (!data) {
+		perror("malloc");
+		exit(EXIT_FAILURE);
+	}
+
+	for (i = 0; i < COLLAPSE_TOTAL; i++)
+		data[i] = rand() & 0xff;
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	while (offset < COLLAPSE_TOTAL) {
+		size_t pkt_size = COLLAPSE_PKT_MIN +
+			rand() % (COLLAPSE_PKT_MAX - COLLAPSE_PKT_MIN + 1);
+
+		pkt_size = min(pkt_size, COLLAPSE_TOTAL - offset);
+
+		send_buf(fd, data + offset, pkt_size, 0, pkt_size);
+		offset += pkt_size;
+	}
+
+	hash = hash_djb2(data, COLLAPSE_TOTAL);
+	control_writeulong(hash);
+
+	free(data);
+	close(fd);
+}
+
+static void test_stream_collapse_server(const struct test_opts *opts)
+{
+	unsigned long hash, remote_hash;
+	unsigned char *data;
+	int fd;
+
+	data = malloc(COLLAPSE_TOTAL);
+	if (!data) {
+		perror("malloc");
+		exit(EXIT_FAILURE);
+	}
+
+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	recv_buf(fd, data, COLLAPSE_TOTAL, 0, COLLAPSE_TOTAL);
+
+	hash = hash_djb2(data, COLLAPSE_TOTAL);
+	remote_hash = control_readulong();
+	if (hash != remote_hash) {
+		fprintf(stderr, "hash mismatch: local %lu remote %lu\n",
+			hash, remote_hash);
+		exit(EXIT_FAILURE);
+	}
+
+	free(data);
+	close(fd);
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM connection reset",
@@ -2546,6 +2628,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_msg_peek_client,
 		.run_server = test_stream_peek_after_recv_server,
 	},
+	{
+		.name = "SOCK_STREAM small packets backpressure",
+		.run_client = test_stream_collapse_client,
+		.run_server = test_stream_collapse_server,
+	},
 	{},
 };
 
-- 
2.55.0


