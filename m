Return-Path: <netdev+bounces-59016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DDA818F9F
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 19:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7362B288728
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 18:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31F938DFA;
	Tue, 19 Dec 2023 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="IQhZ1HGZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAE138FB6
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d3b8184a84so12837675ad.1
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 10:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703009803; x=1703614603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDvT9VuU1y9t4j/S2F1F5G7C890Q9oSjtXtpmwdatBE=;
        b=IQhZ1HGZaqjrhBmV9OFJUK5lhXnktXWgMN3HCIGgXn9wVYrYrY18hjVy/Sfwwg7dg9
         r88IKqatqHJa7pRs4IO2EpXDHoMaOfs5fGyXXOmSGImQltRMlSlbkzcpJOqHP7t7PUz3
         Sx1+49Sk/TFoUj2uEqSa3nBHLDvqaMoTDWHGqP0+oGt3ovAMCQ6xSVcsq8iImuGxOtsP
         c1Z1SalQ7HNV88CsRFeKCGS4Bwg/27ZkTn9uKYQM3IJzV5BQV4xlXzEU/yocgz+Fc5XA
         h9ZOV5Dvtlia+nxaTLCc5AfqViZ64CHQN70+WcO7Juds3ABjw9xwC9VRSe0UJYSJb7W4
         Dg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703009803; x=1703614603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDvT9VuU1y9t4j/S2F1F5G7C890Q9oSjtXtpmwdatBE=;
        b=gTRpUbxc8rqYBpq/NJnXbH7SROqQCT3Gq3NtdcCdHQsKL+pmc0nC7acirOOcnig4hN
         5UUbEKuC3zhAQESoIh7HgqXOlpDlkxtXaQF9tr2gJ/Zry8iKh8qjJHCnncOJ3OMM19PS
         0ZpJC3qVoskLmMp+L+EGI71la0fbU0MQ+ZNgH2iIwdo9sM2hCRAVpZIZTNktkFRJNObl
         BXq4bV8+Rwtc6PZSkbXC7MeBYnUC9mDB/ec7+YoMPLDJmQsXyi4Zkq/9zdlp1Wd7e/KE
         1of/3fiGA4PGYPnCSzPq6p6ZuRUSlcw9LJVsIfnTmou0trSm3N/62WbOrkxwbBULE3UT
         UeLA==
X-Gm-Message-State: AOJu0YzMkpr1R7RuqQjnbjDcUCehjeMmggHa9fR55kNOI/K/j3+O5uFi
	bE0Y7HxE+ABFK4Ri8onrtS4M1Q==
X-Google-Smtp-Source: AGHT+IHVKpTS1AUgYpiKjV1bRgOFynpf9EDTG3OcEtBtnfH3Q7TlBQpbd4PsTxgoR0kT2wRU6iRnSw==
X-Received: by 2002:a17:902:e543:b0:1d3:da07:5741 with SMTP id n3-20020a170902e54300b001d3da075741mr1524792plf.91.1703009802958;
        Tue, 19 Dec 2023 10:16:42 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:60e3:4c1:486f:7eda:5fb5])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f54b00b001d348571ccesm4372188plf.240.2023.12.19.10.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:16:42 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Cc: mleitner@redhat.com,
	vladbu@nvidia.com,
	paulb@nvidia.com,
	pctammela@mojatatu.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next v8 3/5] net/sched: act_mirred: Create function tcf_mirred_to_dev and improve readability
Date: Tue, 19 Dec 2023 15:16:21 -0300
Message-ID: <20231219181623.3845083-4-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219181623.3845083-1-victor@mojatatu.com>
References: <20231219181623.3845083-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As a preparation for adding block ID to mirred, separate the part of
mirred that redirect/mirrors to a dev into a specific function so that it
can be called by blockcast for each dev.

Also improve readability. Eg. rename use_reinsert to dont_clone and skb2
to skb_to_send.

Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/act_mirred.c | 129 +++++++++++++++++++++++------------------
 1 file changed, 72 insertions(+), 57 deletions(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 0a711c184c29..6f2544c1e396 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -225,48 +225,26 @@ static int tcf_mirred_forward(bool want_ingress, struct sk_buff *skb)
 	return err;
 }
 
-TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
-				     const struct tc_action *a,
-				     struct tcf_result *res)
+static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
+			     struct net_device *dev,
+			     const bool m_mac_header_xmit, int m_eaction,
+			     int retval)
 {
-	struct tcf_mirred *m = to_mirred(a);
-	struct sk_buff *skb2 = skb;
-	bool m_mac_header_xmit;
-	struct net_device *dev;
-	unsigned int nest_level;
-	int retval, err = 0;
-	bool use_reinsert;
+	struct sk_buff *skb_to_send = skb;
 	bool want_ingress;
 	bool is_redirect;
 	bool expects_nh;
 	bool at_ingress;
-	int m_eaction;
+	bool dont_clone;
 	int mac_len;
 	bool at_nh;
+	int err;
 
-	nest_level = __this_cpu_inc_return(mirred_nest_level);
-	if (unlikely(nest_level > MIRRED_NEST_LIMIT)) {
-		net_warn_ratelimited("Packet exceeded mirred recursion limit on dev %s\n",
-				     netdev_name(skb->dev));
-		__this_cpu_dec(mirred_nest_level);
-		return TC_ACT_SHOT;
-	}
-
-	tcf_lastuse_update(&m->tcf_tm);
-	tcf_action_update_bstats(&m->common, skb);
-
-	m_mac_header_xmit = READ_ONCE(m->tcfm_mac_header_xmit);
-	m_eaction = READ_ONCE(m->tcfm_eaction);
-	retval = READ_ONCE(m->tcf_action);
-	dev = rcu_dereference_bh(m->tcfm_dev);
-	if (unlikely(!dev)) {
-		pr_notice_once("tc mirred: target device is gone\n");
-		goto out;
-	}
-
+	is_redirect = tcf_mirred_is_act_redirect(m_eaction);
 	if (unlikely(!(dev->flags & IFF_UP)) || !netif_carrier_ok(dev)) {
 		net_notice_ratelimited("tc mirred to Houston: device %s is down\n",
 				       dev->name);
+		err = -ENODEV;
 		goto out;
 	}
 
@@ -274,61 +252,98 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 	 * since we can't easily detect the clsact caller, skip clone only for
 	 * ingress - that covers the TC S/W datapath.
 	 */
-	is_redirect = tcf_mirred_is_act_redirect(m_eaction);
 	at_ingress = skb_at_tc_ingress(skb);
-	use_reinsert = at_ingress && is_redirect &&
-		       tcf_mirred_can_reinsert(retval);
-	if (!use_reinsert) {
-		skb2 = skb_clone(skb, GFP_ATOMIC);
-		if (!skb2)
+	dont_clone = skb_at_tc_ingress(skb) && is_redirect &&
+		tcf_mirred_can_reinsert(retval);
+	if (!dont_clone) {
+		skb_to_send = skb_clone(skb, GFP_ATOMIC);
+		if (!skb_to_send) {
+			err =  -ENOMEM;
 			goto out;
+		}
 	}
 
 	want_ingress = tcf_mirred_act_wants_ingress(m_eaction);
 
 	/* All mirred/redirected skbs should clear previous ct info */
-	nf_reset_ct(skb2);
+	nf_reset_ct(skb_to_send);
 	if (want_ingress && !at_ingress) /* drop dst for egress -> ingress */
-		skb_dst_drop(skb2);
+		skb_dst_drop(skb_to_send);
 
 	expects_nh = want_ingress || !m_mac_header_xmit;
 	at_nh = skb->data == skb_network_header(skb);
 	if (at_nh != expects_nh) {
-		mac_len = skb_at_tc_ingress(skb) ? skb->mac_len :
+		mac_len = at_ingress ? skb->mac_len :
 			  skb_network_offset(skb);
 		if (expects_nh) {
 			/* target device/action expect data at nh */
-			skb_pull_rcsum(skb2, mac_len);
+			skb_pull_rcsum(skb_to_send, mac_len);
 		} else {
 			/* target device/action expect data at mac */
-			skb_push_rcsum(skb2, mac_len);
+			skb_push_rcsum(skb_to_send, mac_len);
 		}
 	}
 
-	skb2->skb_iif = skb->dev->ifindex;
-	skb2->dev = dev;
+	skb_to_send->skb_iif = skb->dev->ifindex;
+	skb_to_send->dev = dev;
 
-	/* mirror is always swallowed */
 	if (is_redirect) {
-		skb_set_redirected(skb2, skb2->tc_at_ingress);
-
-		/* let's the caller reinsert the packet, if possible */
-		if (use_reinsert) {
-			err = tcf_mirred_forward(want_ingress, skb);
-			if (err)
-				tcf_action_inc_overlimit_qstats(&m->common);
-			__this_cpu_dec(mirred_nest_level);
-			return TC_ACT_CONSUMED;
-		}
+		if (skb == skb_to_send)
+			retval = TC_ACT_CONSUMED;
+
+		skb_set_redirected(skb_to_send, skb_to_send->tc_at_ingress);
+
+		err = tcf_mirred_forward(want_ingress, skb_to_send);
+	} else {
+		err = tcf_mirred_forward(want_ingress, skb_to_send);
 	}
 
-	err = tcf_mirred_forward(want_ingress, skb2);
 	if (err) {
 out:
 		tcf_action_inc_overlimit_qstats(&m->common);
-		if (tcf_mirred_is_act_redirect(m_eaction))
+		if (is_redirect)
 			retval = TC_ACT_SHOT;
 	}
+
+	return retval;
+}
+
+TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
+				     const struct tc_action *a,
+				     struct tcf_result *res)
+{
+	struct tcf_mirred *m = to_mirred(a);
+	int retval = READ_ONCE(m->tcf_action);
+	unsigned int nest_level;
+	bool m_mac_header_xmit;
+	struct net_device *dev;
+	int m_eaction;
+
+	nest_level = __this_cpu_inc_return(mirred_nest_level);
+	if (unlikely(nest_level > MIRRED_NEST_LIMIT)) {
+		net_warn_ratelimited("Packet exceeded mirred recursion limit on dev %s\n",
+				     netdev_name(skb->dev));
+		retval = TC_ACT_SHOT;
+		goto dec_nest_level;
+	}
+
+	tcf_lastuse_update(&m->tcf_tm);
+	tcf_action_update_bstats(&m->common, skb);
+
+	dev = rcu_dereference_bh(m->tcfm_dev);
+	if (unlikely(!dev)) {
+		pr_notice_once("tc mirred: target device is gone\n");
+		tcf_action_inc_overlimit_qstats(&m->common);
+		goto dec_nest_level;
+	}
+
+	m_mac_header_xmit = READ_ONCE(m->tcfm_mac_header_xmit);
+	m_eaction = READ_ONCE(m->tcfm_eaction);
+
+	retval = tcf_mirred_to_dev(skb, m, dev, m_mac_header_xmit, m_eaction,
+				   retval);
+
+dec_nest_level:
 	__this_cpu_dec(mirred_nest_level);
 
 	return retval;
-- 
2.25.1


