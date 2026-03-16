Return-Path: <netdev+bounces-268298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCqjG56EuGltfAEAu9opvQ
	(envelope-from <netdev+bounces-268298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:30:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BD12A17F2
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE112303A4B2
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F9F372ED3;
	Mon, 16 Mar 2026 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAqOjnGG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7F8374729
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 22:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773700168; cv=none; b=EDCOVwFnlITjGz0e9haz7nXzu4a5LqTQmUFLLm/Vx/1zyKY3/M8t2kN/fggAOFyKgiYAPHMTzb65RSNsf22QJXZXs8j2RlqnwdgAKZoGuXzdyOQdhAvR5sFa1zQMtilNCz7bRsGkRyCX3fbu6Y6fOabQKSCr7NeSWw99KgmEy1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773700168; c=relaxed/simple;
	bh=/P0d+nw6nfgOf/J+mWp3OvTpE+gexpCsKViZnKl4q1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YztKFaZ9GFgnuTw3S9sK3A8eMGF56yYutfW/rr7kln9hYXx28AR7WhQZGwlPvmAUETVGfWsQ+LQP58e0yGPDWgqGCDQXegzv+AP+o+XtoKdIPQ0tvf3DI1cCsjzYe0gyTqIKcgiv/ykkUzU5d05RTIdysVaSJxWzKp+tlROSQio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAqOjnGG; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64ae2ce2fe1so4980954d50.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 15:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773700163; x=1774304963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S96bHHsurulXmzp5TnD3Oxl/rMQZJqmo/NVotofYdL8=;
        b=QAqOjnGG0Jv2OURrXwx7PmcDsowNCIK0MRaxWCN6KFwiag+AaCAw1Cf5WGo8N33byL
         4s4eHKURikLcxJ9LFDzULH3YOfKLg3LGBAoiKTwrB3rBlBbl5GXU6xmOIjmZOHXozb/R
         JLWWf5uT+FoUNeLVgMYFl9VgllYkQKjIDJbACYNL+ct2der+FYRYI4+6ywMcusyEYyJT
         bb6t6TO41s/afoJveIB2x6db6mIqIDT6ouH0whvqw0h9gFGR5InF79IFV2veFr0RsHYY
         CKXaI1r7LX2d5VxV6xVSyncJgVZAVrBS1slXdF/vYWXInwUGoqD2GVHxzldNBAALQXUx
         IIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773700163; x=1774304963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S96bHHsurulXmzp5TnD3Oxl/rMQZJqmo/NVotofYdL8=;
        b=qTBU9Ud2vLoa28jMWpI5VYFhDSV4UeLqUgPzBUVBIa1Mtuwx3sWCnpc8Xg6y194x26
         X/clugFJZFaxcK8pKVxHSmYTknJxM9KERiuIEx4N5x01/ZoXMLTMOb1fmNC/vxoYxoMk
         p3op9gz461CSF5EaTdnhs8HeSaMGhfR+y52L8lFPJuTiFY5LdF3CWG1DBkwiX5Lh3+Xj
         m+GsQkmQhypYQ2E663TyWJ0eY2sVZgFvr1Qj6/Thq0NkJlr522WWSFtdu0AWLb4nOnpk
         9g11j/g7YFC9hqwEovORdEw776HT8jf6X7qpdFep4zW20J8nINugmicxF7RXoGnhOY0z
         CSuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt8T9WLZvYLJjcd54DO56jrGwVGV3PTudMCVk+LGkkpslOJQStgKYueo0/nvy8RZdcozYmzfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFfR1umWQS1bF0cHubvn5YoyN+QZuomYddYr7+zc9YjVQccjC9
	J6EI2Jgg2y6GUSCfwve8ukRyyJ9V3oT4zsTlGmmf57LJP60/Dfyx6vr+
X-Gm-Gg: ATEYQzzIWKrTp4loc5PefX/y8B1Or8nxbk8ih/+9q5CrKyRxo6TpMUg3/P+ySXuRWgM
	RrzhKvZyLsRK9qT30FZ3RQGg7GWmz2vqSO+SpAA2yB7OzfIMySgV7g6iwNCuZSFaQkInVmXBAmW
	BYG4eQSb0BFPujddyYVvBJ8FNmXVkUzz83YhgIP+JRJYRNDAb6EQEEthTLk3lZxGlweshQoa49t
	cHVef7TrAVE2T5v3wwMPGO8p6I1DA8gTyTk12TMEW/xMSQN/raxnCthf/tGdU/WuVdvxrWwohpb
	iFWmvi8ZJSsD6jYfGTmm2/4IioL6Gf0J8PmYF8+9ar00l/TbSs2CI0ir9Vg7jIJa9TMnfl/3Ikg
	oL6SYX5R2ZwKNbggYTIj/XdZqw5+UDOEy2DSfRKsBCUBe0EsADYfj0zPF9nmyv6Da+7p1X3YJhk
	axq84IHOqCs2+Qqu/aANJk6A==
X-Received: by 2002:a53:7404:0:b0:64c:97ae:2e75 with SMTP id 956f58d0204a3-64e6309ab39mr10701854d50.69.1773700163558;
        Mon, 16 Mar 2026 15:29:23 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4a::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e65a3bedcsm6286875d50.1.2026.03.16.15.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 15:29:23 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Mar 2026 15:29:14 -0700
Subject: [PATCH net-next 3/6] selftests: drv-net: add skip-config flag to
 ncdevmem
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-3-b53c8cd72b23@meta.com>
References: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
In-Reply-To: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, 
 Mina Almasry <almasrymina@google.com>, Wei Wang <weibunny@fb.com>, 
 David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268298-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 17BD12A17F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add a -n flag to ncdevmem that skips hardware configuration (header
split, RSS, flow steering). This is needed when ncdevmem is run inside a
netkit namespace where hardware configuration is managed externally by
the test harness.

When -n is set, ncdevmem skips configure_headersplit(), configure_rss(),
and configure_flow_steering(). The calling environment is expected to
perform this setup prior to invoking ncdevmem.

This is used in subsequent patches of this series that bring up netkit
devmem TX testing. ncdevmem will only have access to the netkit inside
the namespace, and not the physical device. Therefore, in those tests,
the test harness itself does the physical device setup.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 58 +++++++++++++----------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index e098d6534c3c..d96e8a3b5a65 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -93,6 +93,7 @@ static char *port;
 static size_t do_validation;
 static int start_queue = -1;
 static int num_queues = -1;
+static int skip_config;
 static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
@@ -828,7 +829,7 @@ static struct netdev_queue_id *create_queues(void)
 
 static int do_server(struct memory_buffer *mem)
 {
-	struct ethtool_rings_get_rsp *ring_config;
+	struct ethtool_rings_get_rsp *ring_config = NULL;
 	char ctrl_data[sizeof(int) * 20000];
 	size_t non_page_aligned_frags = 0;
 	struct sockaddr_in6 client_addr;
@@ -851,27 +852,29 @@ static int do_server(struct memory_buffer *mem)
 		return -1;
 	}
 
-	ring_config = get_ring_config();
-	if (!ring_config) {
-		pr_err("Failed to get current ring configuration");
-		return -1;
-	}
+	if (!skip_config) {
+		ring_config = get_ring_config();
+		if (!ring_config) {
+			pr_err("Failed to get current ring configuration");
+			return -1;
+		}
 
-	if (configure_headersplit(ring_config, 1)) {
-		pr_err("Failed to enable TCP header split");
-		goto err_free_ring_config;
-	}
+		if (configure_headersplit(ring_config, 1)) {
+			pr_err("Failed to enable TCP header split");
+			goto err_free_ring_config;
+		}
 
-	/* Configure RSS to divert all traffic from our devmem queues */
-	if (configure_rss()) {
-		pr_err("Failed to configure rss");
-		goto err_reset_headersplit;
-	}
+		/* Configure RSS to divert all traffic from our devmem queues */
+		if (configure_rss()) {
+			pr_err("Failed to configure rss");
+			goto err_reset_headersplit;
+		}
 
-	/* Flow steer our devmem flows to start_queue */
-	if (configure_flow_steering(&server_sin)) {
-		pr_err("Failed to configure flow steering");
-		goto err_reset_rss;
+		/* Flow steer our devmem flows to start_queue */
+		if (configure_flow_steering(&server_sin)) {
+			pr_err("Failed to configure flow steering");
+			goto err_reset_rss;
+		}
 	}
 
 	if (bind_rx_queue(ifindex, mem->fd, create_queues(), num_queues, &ys)) {
@@ -1052,13 +1055,17 @@ static int do_server(struct memory_buffer *mem)
 err_unbind:
 	ynl_sock_destroy(ys);
 err_reset_flow_steering:
-	reset_flow_steering();
+	if (!skip_config)
+		reset_flow_steering();
 err_reset_rss:
-	reset_rss();
+	if (!skip_config)
+		reset_rss();
 err_reset_headersplit:
-	restore_ring_config(ring_config);
+	if (!skip_config)
+		restore_ring_config(ring_config);
 err_free_ring_config:
-	ethtool_rings_get_rsp_free(ring_config);
+	if (!skip_config)
+		ethtool_rings_get_rsp_free(ring_config);
 	return err;
 }
 
@@ -1404,7 +1411,7 @@ int main(int argc, char *argv[])
 	int is_server = 0, opt;
 	int ret, err = 1;
 
-	while ((opt = getopt(argc, argv, "Lls:c:p:v:q:t:f:z:")) != -1) {
+	while ((opt = getopt(argc, argv, "Lls:c:p:v:q:t:f:z:n")) != -1) {
 		switch (opt) {
 		case 'L':
 			fail_on_linear = true;
@@ -1436,6 +1443,9 @@ int main(int argc, char *argv[])
 		case 'z':
 			max_chunk = atoi(optarg);
 			break;
+		case 'n':
+			skip_config = 1;
+			break;
 		case '?':
 			fprintf(stderr, "unknown option: %c\n", optopt);
 			break;

-- 
2.52.0


