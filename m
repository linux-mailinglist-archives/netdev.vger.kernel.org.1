Return-Path: <netdev+bounces-39808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82F87C488E
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 05:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2E6282333
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 03:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80386CA79;
	Wed, 11 Oct 2023 03:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+IKjl74"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF62C2EB
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 03:44:02 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42C7CF
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 20:44:00 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-690fa0eea3cso5745289b3a.0
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 20:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696995840; x=1697600640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTCjODxOYvvUIwFtBooSecITmfw9zxGLvgL/AQYXLPc=;
        b=j+IKjl74uJ6QLf8yvvv1zgBOjj5wOAwuTjbtv2QA1UbBpvFv52IfzUHfoigblZc1pH
         WZztehjJRCLZ6KCfST15l3l6npRwk7cPb0G6Hp6IvCy0gLqJKCpcIITOyvEDhwLTijb8
         KHy4Y2sdn4vr7EJcU+EGcU6OC0vP0I8erle43qNgNk/VTbn9joMsz16Z+SCcQSBi+ZnE
         UKrW9F0uNCSLlC2+JvUdx60PsgCpltEOVbeqgAH4VDkCNGVqrwQSxXe+DDIg5BhDr8pR
         vNTuwmdm9Ez1cQAif7QkYD9eJc6FxVM0eybCBefRsO/3tvy3r+3d7x6RkibTertJwcVB
         J5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696995840; x=1697600640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTCjODxOYvvUIwFtBooSecITmfw9zxGLvgL/AQYXLPc=;
        b=LIN9QtJZyRi1Av0oPtCxRBQIxtM5yFKrfVj///eUjncXx/IfpNUH6v/dzzoPT72wLZ
         oIxBLqLMr0JzNNRX8NSRiffyoAnk3MCz2dihGdCn++LCFyEOwddnHWSAgnTwX6uBeIPh
         gxh0Scf+imZcMoZQm7B5FdqbM8M98W0HCAUbamK5NEn3yepu2FTsmeDsDR71wrS1gqdW
         RTHKrC2GRNnD/UTurwD8rw2SVa1txLz6nNDtDBCIfWDTPsVSZpwtJI9i1/JomSJi1kXh
         FVoOYdtN+I94XdBSWjudXGXJQrR516rUNynAYsXVNSfDdwGgwKHA8rBU7m46BsAKuCgJ
         5hZg==
X-Gm-Message-State: AOJu0YwGPCmaXxhhnQtimQHGg+THuo1eSfR4gn+kXTN8FXuFNDPE1Hbt
	8kcSIyvqkBP7PyPwPZ/ZYkPxPCO0XUObKw==
X-Google-Smtp-Source: AGHT+IHMae1JIQoONMnP/2F212m0xc6ZnKS8nE3V1egaMwCvENPf21Sh4YYY5n3ai3TEtco2oAI5RQ==
X-Received: by 2002:a05:6a00:22ca:b0:690:454a:dc7b with SMTP id f10-20020a056a0022ca00b00690454adc7bmr22503365pfj.28.1696995840033;
        Tue, 10 Oct 2023 20:44:00 -0700 (PDT)
Received: from wheely.local0.net ([1.128.220.51])
        by smtp.gmail.com with ESMTPSA id q30-20020a638c5e000000b0058a9621f583sm7873656pgn.44.2023.10.10.20.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 20:43:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: netdev@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	dev@openvswitch.org,
	Pravin B Shelar <pshelar@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	"Eelco Chaudron" <echaudro@redhat.com>,
	"Ilya Maximets" <imaximet@redhat.com>,
	"Flavio Leitner" <fbl@redhat.com>
Subject: [PATCH 1/7] net: openvswitch: generalise the per-cpu flow key allocation stack
Date: Wed, 11 Oct 2023 13:43:38 +1000
Message-ID: <20231011034344.104398-2-npiggin@gmail.com>
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

Rather than an implicit key allocation index based on the recursion
level, make this a standalone FIFO allocator. This makes it usable
in other places without modifying the recursion accounting.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 net/openvswitch/actions.c | 104 ++++++++++++++++++++++++++------------
 1 file changed, 72 insertions(+), 32 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index fd66014d8a76..bc7a8c2fff91 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -59,9 +59,10 @@ struct ovs_frag_data {
 
 static DEFINE_PER_CPU(struct ovs_frag_data, ovs_frag_data_storage);
 
-#define DEFERRED_ACTION_FIFO_SIZE 10
 #define OVS_RECURSION_LIMIT 5
-#define OVS_DEFERRED_ACTION_THRESHOLD (OVS_RECURSION_LIMIT - 2)
+#define NR_FLOW_KEYS 5
+#define DEFERRED_ACTION_FIFO_SIZE 10
+
 struct action_fifo {
 	int head;
 	int tail;
@@ -69,27 +70,64 @@ struct action_fifo {
 	struct deferred_action fifo[DEFERRED_ACTION_FIFO_SIZE];
 };
 
-struct action_flow_keys {
-	struct sw_flow_key key[OVS_DEFERRED_ACTION_THRESHOLD];
+struct flow_key_stack {
+	struct sw_flow_key key[NR_FLOW_KEYS];
 };
 
-static struct action_fifo __percpu *action_fifos;
-static struct action_flow_keys __percpu *flow_keys;
 static DEFINE_PER_CPU(int, exec_actions_level);
 
+static struct flow_key_stack __percpu *flow_key_stack;
+static DEFINE_PER_CPU(int, flow_keys_allocated);
+
+static struct action_fifo __percpu *action_fifos;
+
+/*
+ * ovs_flow_key_alloc provides a per-CPU sw_flow_key allocator. keys must be
+ * freed in the reverse order that they were allocated in (i.e., a stack).
+ */
+static struct sw_flow_key *ovs_flow_key_alloc(void)
+{
+	struct flow_key_stack *keys = this_cpu_ptr(flow_key_stack);
+	int level = this_cpu_read(flow_keys_allocated);
+
+	if (unlikely(level >= NR_FLOW_KEYS))
+		return NULL;
+
+	__this_cpu_inc(flow_keys_allocated);
+
+	return &keys->key[level];
+}
+
+static void ovs_flow_key_free(struct sw_flow_key *key)
+{
+	struct flow_key_stack *keys = this_cpu_ptr(flow_key_stack);
+	int level = this_cpu_read(flow_keys_allocated);
+
+	/*
+	 * If these debug checks fire then keys will cease being freed
+	 * and the allocator will become exhausted and stop working. This
+	 * gives a graceful failure mode for programming errors.
+	 */
+
+	if (WARN_ON_ONCE(level == 0))
+		return; /* Underflow */
+
+	if (WARN_ON_ONCE(key != &keys->key[level - 1]))
+		return; /* Mismatched alloc/free order */
+
+	__this_cpu_dec(flow_keys_allocated);
+}
+
 /* Make a clone of the 'key', using the pre-allocated percpu 'flow_keys'
  * space. Return NULL if out of key spaces.
  */
 static struct sw_flow_key *clone_key(const struct sw_flow_key *key_)
 {
-	struct action_flow_keys *keys = this_cpu_ptr(flow_keys);
-	int level = this_cpu_read(exec_actions_level);
-	struct sw_flow_key *key = NULL;
+	struct sw_flow_key *key;
 
-	if (level <= OVS_DEFERRED_ACTION_THRESHOLD) {
-		key = &keys->key[level - 1];
+	key = ovs_flow_key_alloc();
+	if (likely(key))
 		*key = *key_;
-	}
 
 	return key;
 }
@@ -1522,9 +1560,10 @@ static int clone_execute(struct datapath *dp, struct sk_buff *skb,
 {
 	struct deferred_action *da;
 	struct sw_flow_key *clone;
+	int err = 0;
 
 	skb = last ? skb : skb_clone(skb, GFP_ATOMIC);
-	if (!skb) {
+	if (unlikely(!skb)) {
 		/* Out of memory, skip this action.
 		 */
 		return 0;
@@ -1536,26 +1575,27 @@ static int clone_execute(struct datapath *dp, struct sk_buff *skb,
 	 * 'flow_keys'. If clone is successful, execute the actions
 	 * without deferring.
 	 */
-	clone = clone_flow_key ? clone_key(key) : key;
-	if (clone) {
-		int err = 0;
+	if (clone_flow_key) {
+		clone = clone_key(key);
+		if (unlikely(!clone))
+			goto defer;
+	} else {
+		clone = key;
+	}
 
-		if (actions) { /* Sample action */
-			if (clone_flow_key)
-				__this_cpu_inc(exec_actions_level);
+	if (actions) { /* Sample action */
+		err = do_execute_actions(dp, skb, clone, actions, len);
+	} else { /* Recirc action */
+		clone->recirc_id = recirc_id;
+		ovs_dp_process_packet(skb, clone);
+	}
 
-			err = do_execute_actions(dp, skb, clone,
-						 actions, len);
+	if (clone_flow_key)
+		ovs_flow_key_free(clone);
 
-			if (clone_flow_key)
-				__this_cpu_dec(exec_actions_level);
-		} else { /* Recirc action */
-			clone->recirc_id = recirc_id;
-			ovs_dp_process_packet(skb, clone);
-		}
-		return err;
-	}
+	return err;
 
+defer:
 	/* Out of 'flow_keys' space. Defer actions */
 	da = add_deferred_actions(skb, key, actions, len);
 	if (da) {
@@ -1642,8 +1682,8 @@ int action_fifos_init(void)
 	if (!action_fifos)
 		return -ENOMEM;
 
-	flow_keys = alloc_percpu(struct action_flow_keys);
-	if (!flow_keys) {
+	flow_key_stack = alloc_percpu(struct flow_key_stack);
+	if (!flow_key_stack) {
 		free_percpu(action_fifos);
 		return -ENOMEM;
 	}
@@ -1654,5 +1694,5 @@ int action_fifos_init(void)
 void action_fifos_exit(void)
 {
 	free_percpu(action_fifos);
-	free_percpu(flow_keys);
+	free_percpu(flow_key_stack);
 }
-- 
2.42.0


