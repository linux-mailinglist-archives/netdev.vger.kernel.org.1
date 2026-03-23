Return-Path: <netdev+bounces-270810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aELgLhvMwWlUWgQAu9opvQ
	(envelope-from <netdev+bounces-270810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:26:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6922FEF16
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B960C3001471
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211C23845AC;
	Mon, 23 Mar 2026 23:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="YFvWX9c6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VCs+KzP5"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981F2258CE5
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 23:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774308376; cv=none; b=kOcj1TNHKNsrBd+TboEvpgyS4lxFvSEDCNYYdJqKkiQHrgaHnFUsvoZftQI6+7C54st+/jGweHdKZanbkCC0d3zOlk6g93lBGeqtP6SmyRdOMGTYECjzOWRjI1MG+lDDA4H8uhjwmOWVlaDvhw4AMnB+oIyovbTM9Dza8j6YphY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774308376; c=relaxed/simple;
	bh=g+yeSBcfpyOQChjq8o9jHCC37WCN/l3WnoLG/O9wPU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t3nm6bIJW0JTCTbRmGpUYI9dMcCeWaGRhBXQtGVnnvIxslA0K2Ervsr76HohJPeA9WZKJ6D7AVfXZ02kv3O3NsWCjKB4CL3FExZwxlkKxJGpbca65H31qn2of4+QTLW0scsSxsCejM3zFE0YZF6tGdEKNMcfAhZaCvjTn1xC/10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=YFvWX9c6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VCs+KzP5; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A327BEC00C3;
	Mon, 23 Mar 2026 19:26:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 23 Mar 2026 19:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1774308372; x=1774394772; bh=JhKCDwrryr
	XOsJbTrSJg+rCKrWRXn09whueuN1bGecw=; b=YFvWX9c6QZoPjAw/o0wXXv0qne
	Ldoi8sq9wDVluSf37Ad98vAdkrXXnOAuUNGp1OJHeZajeYkwkehzpsBSQlrXIwYu
	XKm9KK0fDhMxxn3TekllBA7XIrrLpw/94+idu9BU1OmbCbNDJs/6GkjYSY5mti0u
	qzWLVs/6++rzSLDXv3TmLjUyL8S42zAA6GQ03FYSHyK1cPg5skZDUa0SFzO1Wj29
	yh2KTonwypbQVhcKt8Pmq8eSatd5BUZVtR+Ys0vvEBWCpF+z/TVXAa2YN5ASn9ci
	7IiNgjTMXASciY8eC38UFCqCY0VOO92RIzsOprT7H6VVYM2eUdJ2uYEOjgzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774308372; x=1774394772; bh=JhKCDwrryrXOsJbTrSJg+rCKrWRXn09whue
	uN1bGecw=; b=VCs+KzP5Wt+3JKekXrbPgEkMw47nwl01LXWWGDVQUoQd+H0LS9Z
	CtRxvv++/K7jiyE/SG3hZFh0fgxuQ2SIkdThdZv9oOx5fiCNgmaV3Wo+vOcwy00F
	QXcjgXhuAkZTwz42y2+gEAdNBZE+/U8Hm+a3eFGZy2SsN9tuStsypnTjmnctnC9C
	aExDcmaVAQaje/uAlwpAJi89rXsh56/U4wx2qmG7T2ptOCgUawxheYCfY8Ec3tJz
	1IFqscvVJG/UXzrfnlUtdlNj0QhfFTB1/cpzvADdoPtC9cez5AN9t52kzQyyXdeN
	zR6xV/MsfXNp8UK2PUHDkCAFUMK5c135WOg==
X-ME-Sender: <xms:FMzBacLB4CutR_2T74taoSBtUSI-W4oxt9lMAI_F1SvcSKggY2NLZw>
    <xme:FMzBaRGBK4W5QYPlRIFvMtcrPgCA9d9jraMQH6rCh6qfxacUHE2sKF3nuYViMXBvZ
    2VFmwOfYlmzXcmvQWM5su845SjotjfUH8-rgYjf8mMvPPwxS5kPaSY>
X-ME-Received: <xmr:FMzBaQ9qpwRc-njwxrAswXbtRfB25Be_sw0tVoV4KKXUFU86tqq1cFvPmn1n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddttdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrsghrihhnrgcu
    ffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrth
    htvghrnhepjedtuefgffekjeefheekieeivdejhedvudffveefteeuffehgeettedvhfff
    veffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    gusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehsugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtphhtthho
    pegvsghivgguvghrmhesgihmihhsshhiohhnrdgtohhmpdhrtghpthhtohepkhhunhhihi
    husehgohhoghhlvgdrtghomhdprhgtphhtthhopehgnhgruhhlthesrhgvughhrghtrdgt
    ohhmpdhrtghpthhtohepthgrnhihuhgrnhelkeesohhuthhlohhokhdrtghomhdprhgtph
    htthhopeihihhfrghnfihutghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhomhgr
    phhufhgtkhhgmhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghirhgusehliihurd
    gvughurdgtnh
X-ME-Proxy: <xmx:FMzBaZJYBz52Q12TFPLiHfHoh_nDvcDejhuJ4PS5DnrMBGC3OG3hpA>
    <xmx:FMzBaWveUg4vK-GrWPOu_fGtaylnSIhtvIVpQ7gbKfLA0iUh8o7gRQ>
    <xmx:FMzBaYC8jNluUNFwDYeWD-HQO2P5xXHrKHcnU4l1fj2L_mtQ9noSjA>
    <xmx:FMzBaWN77UsmBIJZVmOv6VbUYw4tJJ9pKNOX-UfhB2iIcGEsw_1OnQ>
    <xmx:FMzBaSrushb0uBlJPk5VWAzy12B7gw-1LMkFuiyBaucVzpegaVXbtHqb>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 19:26:11 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Guillaume Nault <gnault@redhat.com>,
	Yuan Tan <tanyuan98@outlook.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>
Subject: [PATCH net] mpls: add seqcount to protect the platform_label{,s} pair
Date: Tue, 24 Mar 2026 00:25:57 +0100
Message-ID: <cd8fca15e3eb7e212b094064cd83652e20fd9d31.1774284088.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270810-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[queasysnail.net,xmission.com,google.com,redhat.com,outlook.com,gmail.com,lzu.edu.cn];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:email,queasysnail.net:dkim,queasysnail.net:email,queasysnail.net:mid,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 5E6922FEF16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RCU-protected codepaths (mpls_forward, mpls_dump_routes) can have
an inconsistent view of platform_labels vs platform_label in case of a
concurrent resize (resize_platform_label_table, under
platform_mutex). This can lead to OOB accesses.

This patch adds a seqcount, so that we get a consistent snapshot.

Note that mpls_label_ok is also susceptible to this, so the check
against RTA_DST in rtm_to_route_config, done outside platform_mutex,
is not sufficient. This value gets passed to mpls_label_ok once more
in both mpls_route_add and mpls_route_del, so there is no issue, but
that additional check must not be removed.

Reported-by: Yuan Tan <tanyuan98@outlook.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Fixes: 7720c01f3f590 ("mpls: Add a sysctl to control the size of the mpls label table")
Fixes: dde1b38e873c ("mpls: Convert mpls_dump_routes() to RCU.")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 include/net/netns/mpls.h |  1 +
 net/mpls/af_mpls.c       | 29 +++++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/net/netns/mpls.h b/include/net/netns/mpls.h
index 6682e51513ef..2073cbac2afb 100644
--- a/include/net/netns/mpls.h
+++ b/include/net/netns/mpls.h
@@ -17,6 +17,7 @@ struct netns_mpls {
 	size_t platform_labels;
 	struct mpls_route __rcu * __rcu *platform_label;
 	struct mutex platform_mutex;
+	seqcount_mutex_t platform_label_seq;
 
 	struct ctl_table_header *ctl;
 };
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index d5417688f69e..18d3da8ab384 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -83,14 +83,30 @@ static struct mpls_route *mpls_route_input(struct net *net, unsigned int index)
 	return mpls_dereference(net, platform_label[index]);
 }
 
+static struct mpls_route __rcu **mpls_platform_label_rcu(struct net *net, size_t *platform_labels)
+{
+	struct mpls_route __rcu **platform_label;
+	unsigned int sequence;
+
+	do {
+		sequence = read_seqcount_begin(&net->mpls.platform_label_seq);
+		platform_label = rcu_dereference(net->mpls.platform_label);
+		*platform_labels = net->mpls.platform_labels;
+	} while (read_seqcount_retry(&net->mpls.platform_label_seq, sequence));
+
+	return platform_label;
+}
+
 static struct mpls_route *mpls_route_input_rcu(struct net *net, unsigned int index)
 {
 	struct mpls_route __rcu **platform_label;
+	size_t platform_labels;
+
+	platform_label = mpls_platform_label_rcu(net, &platform_labels);
 
-	if (index >= net->mpls.platform_labels)
+	if (index >= platform_labels)
 		return NULL;
 
-	platform_label = rcu_dereference(net->mpls.platform_label);
 	return rcu_dereference(platform_label[index]);
 }
 
@@ -2240,8 +2256,7 @@ static int mpls_dump_routes(struct sk_buff *skb, struct netlink_callback *cb)
 	if (index < MPLS_LABEL_FIRST_UNRESERVED)
 		index = MPLS_LABEL_FIRST_UNRESERVED;
 
-	platform_label = rcu_dereference(net->mpls.platform_label);
-	platform_labels = net->mpls.platform_labels;
+	platform_label = mpls_platform_label_rcu(net, &platform_labels);
 
 	if (filter.filter_set)
 		flags |= NLM_F_DUMP_FILTERED;
@@ -2645,8 +2660,12 @@ static int resize_platform_label_table(struct net *net, size_t limit)
 	}
 
 	/* Update the global pointers */
+	local_bh_disable();
+	write_seqcount_begin(&net->mpls.platform_label_seq);
 	net->mpls.platform_labels = limit;
 	rcu_assign_pointer(net->mpls.platform_label, labels);
+	write_seqcount_end(&net->mpls.platform_label_seq);
+	local_bh_enable();
 
 	mutex_unlock(&net->mpls.platform_mutex);
 
@@ -2728,6 +2747,8 @@ static __net_init int mpls_net_init(struct net *net)
 	int i;
 
 	mutex_init(&net->mpls.platform_mutex);
+	seqcount_mutex_init(&net->mpls.platform_label_seq, &net->mpls.platform_mutex);
+
 	net->mpls.platform_labels = 0;
 	net->mpls.platform_label = NULL;
 	net->mpls.ip_ttl_propagate = 1;
-- 
2.51.2


