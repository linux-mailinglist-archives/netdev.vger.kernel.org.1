Return-Path: <netdev+bounces-58080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4A6814F7C
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 19:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B8BCB2255C
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 18:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9614630129;
	Fri, 15 Dec 2023 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="n55saHvd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF2B3FE2F
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 18:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so569213a12.0
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 10:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702663714; x=1703268514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4p2CbY6NEiZ/sNOgRGgOlppaEA6UsUiUottjLp3tgkU=;
        b=n55saHvdniFWycb/uEtlRkbu6F7OeXjE1a6DW0JtteuNurZIW/jevm5/P3dfD3Sf+a
         bipD8jz1UustldkOgdWBCgB0BtjsNDZOQfDqfBkByxKhndMKKBDmFkFv625HojA54000
         NU5k0VoEVYCZI2+81/S4Fv33dpKmtNgZ3mT6EU/DPa89MG6fRcO86l5/DkQPTn/Swx9v
         serHBSGEjINEapkLOUoztClov7R6JXA8NNe1qTYw0smjT5LhyHGu2WDnrBycUsiDv6ps
         iDeuN59hfn8lTDQ+FaVl4WGwsNeUulnT0W3ZoxVScX9qoXmPaQSDJQ23zENdFZTmr5NM
         f9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702663714; x=1703268514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4p2CbY6NEiZ/sNOgRGgOlppaEA6UsUiUottjLp3tgkU=;
        b=g8KRJAU6xQOxI0qGL66/MSI/F5xWQVBag4BGhD6ZLEg5hO2ySXUQtUgLFfw1V3Ln+2
         Z79Vc61PJSR+nX1Bmm0muOALfvw9ioH9zE3QH0iOc5nllEJgBkgIsI4J4gQ8lfmrWA3v
         2sr+oGrQV/kzhrgbdwiKOlkk0rsLUsYsZlQq7Ah2+Rc4Bxgem96oD6Lqug+Tus5oZAmS
         8hmdB5kjDp/FZe9wJYNJZpwVoh6yQ5Z/CtgOde66E4ql/mVtVDil3WL7tIiyPY0ax6r8
         v4+53yaQC8pIvnRbJNOK0HxP1B4CkGNGlr1WEuHs8KmE+dhpujHTesDLMwC1HO/Jcd5b
         zqHQ==
X-Gm-Message-State: AOJu0Yxytfxx5rwrAUBLhE/XeNFIEFTSbASng9jMiDk3q6B++/U5wyea
	IchxXuPpEt48JjCuvD0BFA0M4g==
X-Google-Smtp-Source: AGHT+IEFZgY0o50lQClkJjMF3Jsyu6mpJiNWdmfj0IhtYgsUVbgVCLv5uCATDDpzoWnnHiLlqWhGeA==
X-Received: by 2002:a17:902:8ec6:b0:1d3:948d:2288 with SMTP id x6-20020a1709028ec600b001d3948d2288mr384253plo.89.1702663714432;
        Fri, 15 Dec 2023 10:08:34 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:60e3:4c1:486f:7eda:5fb5])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902e74200b001d08dc3913fsm14488861plf.115.2023.12.15.10.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 10:08:34 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	dcaratti@redhat.com
Cc: mleitner@redhat.com,
	pctammela@mojatatu.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH RFC net-next] net: sched: act_mirred: Extend the cpu mirred nest guard with an explicit loop ttl
Date: Fri, 15 Dec 2023 15:08:27 -0300
Message-ID: <20231215180827.3638838-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As pointed out by Jamal in:
https://lore.kernel.org/netdev/CAM0EoMn4C-zwrTCGzKzuRYukxoqBa8tyHyFDwUSZYwkMOUJ4Lw@mail.gmail.com/

Mirred is allowing for infinite loops in certain use cases, such as the
following:

----
sudo ip netns add p4node
sudo ip link add p4port0 address 10:00:00:01:AA:BB type veth peer \
   port0 address 10:00:00:02:AA:BB

sudo ip link set dev port0 netns p4node
sudo ip a add 10.0.0.1/24 dev p4port0
sudo ip neigh add 10.0.0.2 dev p4port0 lladdr 10:00:00:02:aa:bb
sudo ip netns exec p4node ip a add 10.0.0.2/24 dev port0
sudo ip netns exec p4node ip l set dev port0 up
sudo ip l set dev p4port0 up
sudo ip netns exec p4node tc qdisc add dev port0 clsact
sudo ip netns exec p4node tc filter add dev port0 ingress protocol ip \
   prio 10 matchall action mirred ingress redirect dev port0

ping -I p4port0 10.0.0.2 -c 1
-----

To solve this, we reintroduced a ttl variable attached to the skb (in
struct tc_skb_cb) which will prevent infinite loops for use cases such as
the one described above.

The nest per cpu variable (tcf_mirred_nest_level) is now only used for
detecting whether we should call netif_rx or netif_receive_skb when
sending the packet to ingress.

Note that we do increment the ttl in every redirect/mirror so if you
have policies that redirect or mirror between devices of up to
MAX_REC_LOOP (4) with this patch that will be considered to be a loop.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 include/net/pkt_sched.h | 11 +++++++++++
 net/sched/act_mirred.c  | 11 +++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 9fa1d0794dfa..fb8234fd5324 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -282,6 +282,7 @@ struct tc_skb_cb {
 	u8 post_ct:1;
 	u8 post_ct_snat:1;
 	u8 post_ct_dnat:1;
+	u8 ttl:3;
 	u16 zone; /* Only valid if post_ct = true */
 };
 
@@ -293,6 +294,16 @@ static inline struct tc_skb_cb *tc_skb_cb(const struct sk_buff *skb)
 	return cb;
 }
 
+static inline void tcf_ttl_set(struct sk_buff *skb, const u8 ttl)
+{
+	tc_skb_cb(skb)->ttl = ttl;
+}
+
+static inline u8 tcf_ttl_get(struct sk_buff *skb)
+{
+	return tc_skb_cb(skb)->ttl;
+}
+
 static inline bool tc_qdisc_stats_dump(struct Qdisc *sch,
 				       unsigned long cl,
 				       struct qdisc_walker *arg)
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 0a711c184c29..42b267817f3c 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -29,7 +29,7 @@
 static LIST_HEAD(mirred_list);
 static DEFINE_SPINLOCK(mirred_list_lock);
 
-#define MIRRED_NEST_LIMIT    4
+#define MAX_REC_LOOP    4
 static DEFINE_PER_CPU(unsigned int, mirred_nest_level);
 
 static bool tcf_mirred_is_act_redirect(int action)
@@ -233,7 +233,6 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 	struct sk_buff *skb2 = skb;
 	bool m_mac_header_xmit;
 	struct net_device *dev;
-	unsigned int nest_level;
 	int retval, err = 0;
 	bool use_reinsert;
 	bool want_ingress;
@@ -243,9 +242,12 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 	int m_eaction;
 	int mac_len;
 	bool at_nh;
+	u8 ttl;
 
-	nest_level = __this_cpu_inc_return(mirred_nest_level);
-	if (unlikely(nest_level > MIRRED_NEST_LIMIT)) {
+	__this_cpu_inc(mirred_nest_level);
+
+	ttl = tcf_ttl_get(skb);
+	if (unlikely(ttl + 1 > MAX_REC_LOOP)) {
 		net_warn_ratelimited("Packet exceeded mirred recursion limit on dev %s\n",
 				     netdev_name(skb->dev));
 		__this_cpu_dec(mirred_nest_level);
@@ -307,6 +309,7 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 
 	skb2->skb_iif = skb->dev->ifindex;
 	skb2->dev = dev;
+	tcf_ttl_set(skb2, ttl + 1);
 
 	/* mirror is always swallowed */
 	if (is_redirect) {
-- 
2.25.1


