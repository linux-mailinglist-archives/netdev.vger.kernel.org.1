Return-Path: <netdev+bounces-39814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A38E7C4894
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 05:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D84281F1E
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 03:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF9ACA68;
	Wed, 11 Oct 2023 03:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCp/9yGs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E2D2E2
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 03:44:35 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EBF92
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 20:44:34 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3af608eb34bso4376314b6e.1
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 20:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696995873; x=1697600673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icbcgm9xSygTZ84fa5AdWx/TaKno2CPM52PibGcRS+M=;
        b=CCp/9yGsdONTVBL+uzChuAmaWwuTbJHsNQn6bbHOoWuzy8BdmKGva11/wA2DJ6CPET
         q0pLUAWFW9skrMzJlYKnh7WbtVWKyJOgSALvagihAaRun/28eUa7SFhN/y0wPzgPH7k2
         YLI8aoeA19t6a4OgYGfIZ56vL0fgYhKxHX6hVSl+WIZpen+j0XxSqde0B5AC7B5zOYk9
         chBfLWXbGAw1lLUXAFT2jrwLPA08sE5UCPwJJDsuPpB2nNCp16AOE/HVH1I4YOEPdVba
         txarfkCjYn8gERsXMqZR6X7KuEoS73moB+bz/ERmsrLLQpds6V0qcpXbWsO9dJqvtKKP
         4T7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696995873; x=1697600673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icbcgm9xSygTZ84fa5AdWx/TaKno2CPM52PibGcRS+M=;
        b=c2+78R+7NEuROYRySegArggAw0nRE/UhM8i7+RvZa5FvgcNkdVtpx9OogQ7FQts5ib
         PSZYG6z4vtibzOOdLpcRuA6T7ygewRE5UvFjtz58QxtdKIo757V8uHftgt3rLNlHqH8B
         CjH811xd3EzQ5FT4+z8s1Y0kEI5ON0zTn76hzXEYPhoPxqLpnWaIeq4/b4UHdF2DkHvg
         UkjcidOH1pkWcWWEEWffvbIPiVPLII1TySvNpAAoqsHDQxEwhJBM5jlr+PF4k1yNXmkU
         ZkRM0pEFgNISx2fD26oeSjXgyc3y0QHf7pmYtVAKfh+cU7X2TnH5p3cjenn2Ae6OiQSy
         W8zA==
X-Gm-Message-State: AOJu0YwXPcIZLIB7cINU3X6M05eIvfxJeiTsst7R3GmtVPW/0xnZJiz8
	WDombB0M6gWK3gAj3m4SusJG3pCPoC6SVw==
X-Google-Smtp-Source: AGHT+IG2DT+GotU2rg/r7ctBPCz3Th6AsDi1xYW5tdM63vjMkGpdFmMl0iu8DNjNiZBKSjfK7EVXKQ==
X-Received: by 2002:a05:6808:19a6:b0:3a4:4b42:612b with SMTP id bj38-20020a05680819a600b003a44b42612bmr27095344oib.42.1696995873209;
        Tue, 10 Oct 2023 20:44:33 -0700 (PDT)
Received: from wheely.local0.net ([1.128.220.51])
        by smtp.gmail.com with ESMTPSA id q30-20020a638c5e000000b0058a9621f583sm7873656pgn.44.2023.10.10.20.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 20:44:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: netdev@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	dev@openvswitch.org,
	Pravin B Shelar <pshelar@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	"Eelco Chaudron" <echaudro@redhat.com>,
	"Ilya Maximets" <imaximet@redhat.com>,
	"Flavio Leitner" <fbl@redhat.com>
Subject: [PATCH 7/7] net: openvswitch: Reduce stack usage in ovs_dp_process_packet
Date: Wed, 11 Oct 2023 13:43:44 +1000
Message-ID: <20231011034344.104398-8-npiggin@gmail.com>
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

The upcall in ovs_dp_process_packet some stack and is not involved in
the recursive call. Move it out of line, reducing stack overhead of
ovs_dp_process_packet from 144 to 96 bytes.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 net/openvswitch/datapath.c | 56 ++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 11c69415c605..fdc24b1e9bbc 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -242,6 +242,37 @@ void ovs_dp_detach_port(struct vport *p)
 	ovs_vport_del(p);
 }
 
+static noinline_for_stack
+void do_packet_upcall(struct sk_buff *skb, struct sw_flow_key *key,
+		      const struct vport *p, struct datapath *dp)
+{
+	struct dp_upcall_info upcall;
+	int error;
+
+	memset(&upcall, 0, sizeof(upcall));
+	upcall.cmd = OVS_PACKET_CMD_MISS;
+
+	if (dp->user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU)
+		upcall.portid =
+		    ovs_dp_get_upcall_portid(dp, smp_processor_id());
+	else
+		upcall.portid = ovs_vport_find_upcall_portid(p, skb);
+
+	upcall.mru = OVS_CB(skb)->mru;
+	error = ovs_dp_upcall(dp, skb, key, &upcall, 0);
+	switch (error) {
+	case 0:
+	case -EAGAIN:
+	case -ERESTARTSYS:
+	case -EINTR:
+		consume_skb(skb);
+		break;
+	default:
+		kfree_skb(skb);
+		break;
+	}
+}
+
 /* Must be called with rcu_read_lock. */
 void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
 {
@@ -261,30 +292,7 @@ void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
 	flow = ovs_flow_tbl_lookup_stats(&dp->table, key, skb_get_hash(skb),
 					 &n_mask_hit, &n_cache_hit);
 	if (unlikely(!flow)) {
-		struct dp_upcall_info upcall;
-
-		memset(&upcall, 0, sizeof(upcall));
-		upcall.cmd = OVS_PACKET_CMD_MISS;
-
-		if (dp->user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU)
-			upcall.portid =
-			    ovs_dp_get_upcall_portid(dp, smp_processor_id());
-		else
-			upcall.portid = ovs_vport_find_upcall_portid(p, skb);
-
-		upcall.mru = OVS_CB(skb)->mru;
-		error = ovs_dp_upcall(dp, skb, key, &upcall, 0);
-		switch (error) {
-		case 0:
-		case -EAGAIN:
-		case -ERESTARTSYS:
-		case -EINTR:
-			consume_skb(skb);
-			break;
-		default:
-			kfree_skb(skb);
-			break;
-		}
+		do_packet_upcall(skb, key, p, dp);
 		stats_counter = &stats->n_missed;
 		goto out;
 	}
-- 
2.42.0


