Return-Path: <netdev+bounces-39809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF0E7C488F
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 05:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383AE1C20C3C
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 03:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230F8C2EB;
	Wed, 11 Oct 2023 03:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUEyIAgk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51461D2E9
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 03:44:08 +0000 (UTC)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3F594
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 20:44:06 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d8168d08bebso6739960276.0
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 20:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696995846; x=1697600646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vb8OHizWZvFBlQGkon8r50KJO0iPtRKwrbcTXutZ2v0=;
        b=hUEyIAgkRVNt0ni2j30fMJY42jJTYXUQe4qGEfG2UAoHObGrgZefeCnVSavQerrhrW
         sV3zqOkqHJHS4gZfBNwE2E2FbfAgUq8K88W/GCr32dkzJNymhbGzGcHxgz4gN6ApVyWu
         Iws+4qiLDJqLdp8H4xQt4hO0bCgZS6A55Wp61qMSJ1tmfZXdLbpOq6umBR4qrPyfqReH
         eIokvPW8TtAqp0HQ7p1GRB+gVAdj2uQVuu3YtqXHUDrFeO2B27HDYr5ndJq3jZJnJPhI
         hTBzGePKVD4f2eiUF4BWQQ+s1Qk1QyhHaHKNc0aR6r2tgUfvUQyQqZCQnwP66tczwfHU
         OhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696995846; x=1697600646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vb8OHizWZvFBlQGkon8r50KJO0iPtRKwrbcTXutZ2v0=;
        b=p8+nJLo3QoP6am9J8QyHwhIzKSL3/WP4pni24k4dyTq+9NYapp4EeTyQ07rD8CQALh
         ZwOom4epg7xGhczqEIeN4i9wqRYQvoAMU/dUXjBCSGwMkASuhGg/6JiyJjPmwIwxWets
         hiUjrd3XQk6b+8JqLd+xS/IUYnHQ25G8WA4kSOM3CYyOkGeFmU7H2QA4rf1Cq4XR+rQd
         xJq2EXG91PFGrrGmrmJEXqMdgQ0gKposU624ogXsCu12srrLOxq/6ujhFQfyOpZ2Lq7L
         T06OviH9Khzot21hTDRNl9LQZmvMK4CCgsxgBwDlzBFtR7DUDI8tgxGbifZH4bJ11VH3
         z5Uw==
X-Gm-Message-State: AOJu0YyppW6vnWpNEAhbdQ47locVim9QZLxiEu/+J/AC+Rz0i9tQJ6UM
	z/grV/05yqicEOLYf+sf0mnE9CiH3qmQHA==
X-Google-Smtp-Source: AGHT+IGIEL5xAXUpX1rGYL4QHMgr2UzhKeiAJCCmxhWXNbz8SfmPiq6UtxlyaFh36nhvyH7g8iphGQ==
X-Received: by 2002:a5b:4d2:0:b0:d81:504f:f879 with SMTP id u18-20020a5b04d2000000b00d81504ff879mr17613855ybp.28.1696995845737;
        Tue, 10 Oct 2023 20:44:05 -0700 (PDT)
Received: from wheely.local0.net ([1.128.220.51])
        by smtp.gmail.com with ESMTPSA id q30-20020a638c5e000000b0058a9621f583sm7873656pgn.44.2023.10.10.20.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 20:44:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: netdev@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	dev@openvswitch.org,
	Pravin B Shelar <pshelar@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	"Eelco Chaudron" <echaudro@redhat.com>,
	"Ilya Maximets" <imaximet@redhat.com>,
	"Flavio Leitner" <fbl@redhat.com>
Subject: [PATCH 2/7] net: openvswitch: Use flow key allocator in ovs_vport_receive
Date: Wed, 11 Oct 2023 13:43:39 +1000
Message-ID: <20231011034344.104398-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011034344.104398-1-npiggin@gmail.com>
References: <20231011034344.104398-1-npiggin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Rather than allocate the flow key on stack in ovs_vport_receive,
use the per-cpu flow key allocator introduced with the previous
change.

The number of keys are increased because ovs_vport_receive can
be in the recursion path too.

This brings ovs_vport_receive stack usage from 544 bytes to 64
bytes on ppc64le.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 net/openvswitch/actions.c |  6 +++---
 net/openvswitch/flow.h    |  3 +++
 net/openvswitch/vport.c   | 27 ++++++++++++++++++++-------
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index bc7a8c2fff91..7a66574672d3 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -60,7 +60,7 @@ struct ovs_frag_data {
 static DEFINE_PER_CPU(struct ovs_frag_data, ovs_frag_data_storage);
 
 #define OVS_RECURSION_LIMIT 5
-#define NR_FLOW_KEYS 5
+#define NR_FLOW_KEYS 10
 #define DEFERRED_ACTION_FIFO_SIZE 10
 
 struct action_fifo {
@@ -85,7 +85,7 @@ static struct action_fifo __percpu *action_fifos;
  * ovs_flow_key_alloc provides a per-CPU sw_flow_key allocator. keys must be
  * freed in the reverse order that they were allocated in (i.e., a stack).
  */
-static struct sw_flow_key *ovs_flow_key_alloc(void)
+struct sw_flow_key *ovs_flow_key_alloc(void)
 {
 	struct flow_key_stack *keys = this_cpu_ptr(flow_key_stack);
 	int level = this_cpu_read(flow_keys_allocated);
@@ -98,7 +98,7 @@ static struct sw_flow_key *ovs_flow_key_alloc(void)
 	return &keys->key[level];
 }
 
-static void ovs_flow_key_free(struct sw_flow_key *key)
+void ovs_flow_key_free(struct sw_flow_key *key)
 {
 	struct flow_key_stack *keys = this_cpu_ptr(flow_key_stack);
 	int level = this_cpu_read(flow_keys_allocated);
diff --git a/net/openvswitch/flow.h b/net/openvswitch/flow.h
index b5711aff6e76..612459518af9 100644
--- a/net/openvswitch/flow.h
+++ b/net/openvswitch/flow.h
@@ -285,6 +285,9 @@ void ovs_flow_stats_get(const struct sw_flow *, struct ovs_flow_stats *,
 void ovs_flow_stats_clear(struct sw_flow *);
 u64 ovs_flow_used_time(unsigned long flow_jiffies);
 
+struct sw_flow_key *ovs_flow_key_alloc(void);
+void ovs_flow_key_free(struct sw_flow_key *key);
+
 int ovs_flow_key_update(struct sk_buff *skb, struct sw_flow_key *key);
 int ovs_flow_key_update_l3l4(struct sk_buff *skb, struct sw_flow_key *key);
 int ovs_flow_key_extract(const struct ip_tunnel_info *tun_info,
diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
index 972ae01a70f7..80887a17e23b 100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -494,7 +494,7 @@ u32 ovs_vport_find_upcall_portid(const struct vport *vport,
 int ovs_vport_receive(struct vport *vport, struct sk_buff *skb,
 		      const struct ip_tunnel_info *tun_info)
 {
-	struct sw_flow_key key;
+	struct sw_flow_key *key;
 	int error;
 
 	OVS_CB(skb)->input_vport = vport;
@@ -509,14 +509,27 @@ int ovs_vport_receive(struct vport *vport, struct sk_buff *skb,
 		tun_info = NULL;
 	}
 
-	/* Extract flow from 'skb' into 'key'. */
-	error = ovs_flow_key_extract(tun_info, skb, &key);
-	if (unlikely(error)) {
-		kfree_skb(skb);
-		return error;
+	key = ovs_flow_key_alloc();
+	if (unlikely(!key)) {
+		error = -ENOMEM;
+		goto err_skb;
 	}
-	ovs_dp_process_packet(skb, &key);
+
+	/* Extract flow from 'skb' into 'key'. */
+	error = ovs_flow_key_extract(tun_info, skb, key);
+	if (unlikely(error))
+		goto err_key;
+
+	ovs_dp_process_packet(skb, key);
+	ovs_flow_key_free(key);
+
 	return 0;
+
+err_key:
+	ovs_flow_key_free(key);
+err_skb:
+	kfree_skb(skb);
+	return error;
 }
 
 static int packet_length(const struct sk_buff *skb,
-- 
2.42.0


