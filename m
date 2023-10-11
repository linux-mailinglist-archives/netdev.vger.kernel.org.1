Return-Path: <netdev+bounces-39812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD127C4892
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 05:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7F21C20D02
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 03:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AF4CA5F;
	Wed, 11 Oct 2023 03:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlG2Oufr"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0637DC8FD
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 03:44:25 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE2993
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 20:44:24 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1e10ba12fd3so3848262fac.1
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 20:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696995863; x=1697600663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uN4ekHeyBAgLi1+j+3U4VuxqLSHSBtMr1w74fOLOgV4=;
        b=AlG2OufrLmbu+tXfD6g4rWQU5hEt8IsrF1pYqGtpjsmoNd5Lo3rdkjZWLjaOFoQLZz
         rXmH6k+Oo2+mbsPdJ73jfw/Tbnq7fZFE9AtzNaoAGzTRcWsP8VyfotBJjlmmt0EE3vCH
         FEUVoMV71ZOUO5TsUQIdp99bzImSRppyP14CttsYhXA9kdgnRfYKUIYHogepA4h47DWR
         OSHRxWZMPieEiVTo2ZOt4YR+hCPiXGHppOtNvHwO3nZhlLkOus+Z5iKdKDcorA9tfoOK
         vQAtpaDCuGEJZnyZjuZwdhP6xMrydfhrZ8cXJezxsubWDBz6yLFjNJq28cO3l1UxfWTQ
         QD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696995863; x=1697600663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uN4ekHeyBAgLi1+j+3U4VuxqLSHSBtMr1w74fOLOgV4=;
        b=nhOfDsC7GUFN2KAR0mjw8oaK5a9N9aDkTw475RDZFwxJaOlCczarQJLmlVoYrUgJtV
         89IUczl4B4Ey0fvszdsVFMXs82elYYDUtf2yxguOyaqeXOzEr8DQ5SY8Hu2241fDoEzm
         UFELq4eT5JDmAIfFfiyU3TcDT2bdU5/0GRm9u/xMCrWcBOflKuXfuj+rpJllUvZNHJsu
         Iy3BFnTm5w3xYi7N1l+Rsxb8L1/lTlUlIYbHb61ODuFrSjZPzjm8Jba1Km5/TcJXRd6M
         +rUut4+lUcs8PfbDHvY9TyDoKs7hTP51Vn16QSTDfm56fFsPfodFyw1qz7cf2bcTvxRa
         c/KA==
X-Gm-Message-State: AOJu0YxqieL0wb8bOe4DSN72qjw/AlL2oFJefaAWxdAHHwB6OWZ5h5Zw
	I6mPsczwGiNqGH7o9iwtM38Tx59HL+9BCw==
X-Google-Smtp-Source: AGHT+IFWmQ1O/yx42gCkftT/nMYXAeFxfbh9K8vwJtnwIPUr1LoWlwfp8fY8lPR/robKbE1Tr/zPOA==
X-Received: by 2002:a05:6871:439a:b0:1e9:8d3f:a158 with SMTP id lv26-20020a056871439a00b001e98d3fa158mr997075oab.56.1696995863445;
        Tue, 10 Oct 2023 20:44:23 -0700 (PDT)
Received: from wheely.local0.net ([1.128.220.51])
        by smtp.gmail.com with ESMTPSA id q30-20020a638c5e000000b0058a9621f583sm7873656pgn.44.2023.10.10.20.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 20:44:23 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: netdev@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	dev@openvswitch.org,
	Pravin B Shelar <pshelar@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	"Eelco Chaudron" <echaudro@redhat.com>,
	"Ilya Maximets" <imaximet@redhat.com>,
	"Flavio Leitner" <fbl@redhat.com>
Subject: [PATCH 5/7] net: openvswitch: uninline action execution
Date: Wed, 11 Oct 2023 13:43:42 +1000
Message-ID: <20231011034344.104398-6-npiggin@gmail.com>
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

A function tends to use as much stack as the maximum of any control
flow path. Compilers can "shrink wrap" to special-case stack allocation,
but that only works well for exclusive paths. The switch statement in
the loop in do_execute_actions uses as much stack as the maximum of its
cases, and so inlining large actions increases overall stack uage. This
is particularly bad because the actions that cause recursion are not the
largest stack users.

Uninline action execution functions, which reduces the stack usage of
do_execute_actions from 288 bytes to 112 bytes.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 net/openvswitch/actions.c | 69 +++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 31 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index fa53e22f3ebe..87ec668d5556 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -964,8 +964,9 @@ static void ovs_fragment(struct net *net, struct vport *vport,
 	ovs_kfree_skb_reason(skb, reason);
 }
 
-static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
-		      struct sw_flow_key *key)
+static noinline_for_stack void do_output(struct datapath *dp,
+					 struct sk_buff *skb, int out_port,
+					 struct sw_flow_key *key)
 {
 	struct vport *vport = ovs_vport_rcu(dp, out_port);
 
@@ -995,10 +996,11 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
 	}
 }
 
-static int output_userspace(struct datapath *dp, struct sk_buff *skb,
-			    struct sw_flow_key *key, const struct nlattr *attr,
-			    const struct nlattr *actions, int actions_len,
-			    uint32_t cutlen)
+static noinline_for_stack
+int output_userspace(struct datapath *dp, struct sk_buff *skb,
+		     struct sw_flow_key *key, const struct nlattr *attr,
+		     const struct nlattr *actions, int actions_len,
+		     uint32_t cutlen)
 {
 	struct dp_upcall_info upcall;
 	const struct nlattr *a;
@@ -1073,9 +1075,9 @@ static int dec_ttl_exception_handler(struct datapath *dp, struct sk_buff *skb,
  * Otherwise, sample() should keep 'skb' intact regardless what
  * actions are executed within sample().
  */
-static int sample(struct datapath *dp, struct sk_buff *skb,
-		  struct sw_flow_key *key, const struct nlattr *attr,
-		  bool last)
+static noinline_for_stack int sample(struct datapath *dp, struct sk_buff *skb,
+				     struct sw_flow_key *key,
+				     const struct nlattr *attr, bool last)
 {
 	struct nlattr *actions;
 	struct nlattr *sample_arg;
@@ -1104,9 +1106,10 @@ static int sample(struct datapath *dp, struct sk_buff *skb,
  * Otherwise, clone() should keep 'skb' intact regardless what
  * actions are executed within clone().
  */
-static int clone(struct datapath *dp, struct sk_buff *skb,
-		 struct sw_flow_key *key, const struct nlattr *attr,
-		 bool last)
+static noinline_for_stack int clone(struct datapath *dp,
+				    struct sk_buff *skb,
+				    struct sw_flow_key *key,
+				    const struct nlattr *attr, bool last)
 {
 	struct nlattr *actions;
 	struct nlattr *clone_arg;
@@ -1122,8 +1125,9 @@ static int clone(struct datapath *dp, struct sk_buff *skb,
 			     !dont_clone_flow_key);
 }
 
-static void execute_hash(struct sk_buff *skb, struct sw_flow_key *key,
-			 const struct nlattr *attr)
+static noinline_for_stack void execute_hash(struct sk_buff *skb,
+					    struct sw_flow_key *key,
+					    const struct nlattr *attr)
 {
 	struct ovs_action_hash *hash_act = nla_data(attr);
 	u32 hash = 0;
@@ -1145,9 +1149,9 @@ static void execute_hash(struct sk_buff *skb, struct sw_flow_key *key,
 	key->ovs_flow_hash = hash;
 }
 
-static int execute_set_action(struct sk_buff *skb,
-			      struct sw_flow_key *flow_key,
-			      const struct nlattr *a)
+static noinline_for_stack int execute_set_action(struct sk_buff *skb,
+						 struct sw_flow_key *flow_key,
+						 const struct nlattr *a)
 {
 	/* Only tunnel set execution is supported without a mask. */
 	if (nla_type(a) == OVS_KEY_ATTR_TUNNEL_INFO) {
@@ -1165,9 +1169,9 @@ static int execute_set_action(struct sk_buff *skb,
 /* Mask is at the midpoint of the data. */
 #define get_mask(a, type) ((const type)nla_data(a) + 1)
 
-static int execute_masked_set_action(struct sk_buff *skb,
-				     struct sw_flow_key *flow_key,
-				     const struct nlattr *a)
+static noinline_for_stack
+int execute_masked_set_action(struct sk_buff *skb, struct sw_flow_key *flow_key,
+			      const struct nlattr *a)
 {
 	int err = 0;
 
@@ -1240,9 +1244,9 @@ static int execute_masked_set_action(struct sk_buff *skb,
 	return err;
 }
 
-static int execute_recirc(struct datapath *dp, struct sk_buff *skb,
-			  struct sw_flow_key *key,
-			  const struct nlattr *a, bool last)
+static noinline_for_stack
+int execute_recirc(struct datapath *dp, struct sk_buff *skb,
+		   struct sw_flow_key *key, const struct nlattr *a, bool last)
 {
 	u32 recirc_id;
 
@@ -1259,9 +1263,10 @@ static int execute_recirc(struct datapath *dp, struct sk_buff *skb,
 	return clone_execute(dp, skb, key, recirc_id, NULL, 0, last, true);
 }
 
-static int execute_check_pkt_len(struct datapath *dp, struct sk_buff *skb,
-				 struct sw_flow_key *key,
-				 const struct nlattr *attr, bool last)
+static noinline_for_stack
+int execute_check_pkt_len(struct datapath *dp, struct sk_buff *skb,
+			  struct sw_flow_key *key, const struct nlattr *attr,
+			  bool last)
 {
 	struct ovs_skb_cb *ovs_cb = OVS_CB(skb);
 	const struct nlattr *actions, *cpl_arg;
@@ -1298,7 +1303,8 @@ static int execute_check_pkt_len(struct datapath *dp, struct sk_buff *skb,
 			     nla_len(actions), last, clone_flow_key);
 }
 
-static int execute_dec_ttl(struct sk_buff *skb, struct sw_flow_key *key)
+static noinline_for_stack int execute_dec_ttl(struct sk_buff *skb,
+					      struct sw_flow_key *key)
 {
 	int err;
 
@@ -1558,10 +1564,11 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
  * The execution may be deferred in case the actions can not be executed
  * immediately.
  */
-static int clone_execute(struct datapath *dp, struct sk_buff *skb,
-			 struct sw_flow_key *key, u32 recirc_id,
-			 const struct nlattr *actions, int len,
-			 bool last, bool clone_flow_key)
+static noinline_for_stack
+int clone_execute(struct datapath *dp, struct sk_buff *skb,
+		  struct sw_flow_key *key, u32 recirc_id,
+		  const struct nlattr *actions, int len, bool last,
+		  bool clone_flow_key)
 {
 	struct deferred_action *da;
 	struct sw_flow_key *clone;
-- 
2.42.0


