Return-Path: <netdev+bounces-268969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EHkLsiCumnrXQIAu9opvQ
	(envelope-from <netdev+bounces-268969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:47:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 224FB2BA299
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D46AC30B4F8A
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF64390C96;
	Wed, 18 Mar 2026 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="t421XnB6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F7hqibrm"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA523921E6
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773830768; cv=none; b=rfM1Cwyj0ID7w6jT3AWwQjOq30KGYtWu6tpRGte8iBlCW6GMHeB5MOpkRYSZ4HSthl85iLbs8+7IHhZL3T8/FWSOuw78pYa7tvXKz71FXm7QM4f56w8qGjEd5TsUqZzpKFfp6mTuDrHWGLhkarhwKIz9/VfhRXDL63wsJjCe7Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773830768; c=relaxed/simple;
	bh=OqFvdn6kszKpfauZAhz1e6kMGNa4Rb93kWbpKZhfO7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHxkwb0IOHhTVei1uo8AUL2yYbjKhP0gBQ2toO1NVMsbk3m4XnTWN0d9X8k8/K3/83cLXdxyNKNk8nZ6neGPO36pzkic4A4NDeX1rwZrFYtfhdbCUqv6QC5DOzToaautTLJn363zYZQ5HNex1a35pfvmviPEQ+uyvNUfVh8JMSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=t421XnB6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F7hqibrm; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 04FDA1D00136;
	Wed, 18 Mar 2026 06:46:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 18 Mar 2026 06:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773830764; x=
	1773917164; bh=GdEjspRaDvVTtf7PkfnLUq8fFsaLcc0PMZBbW/XOL84=; b=t
	421XnB6SQabVVw2V6gnX6vCAEYf9rR9Pw/QPNfuFw+nVy2dR1rArfoV8DlK3tF+j
	D/eLAW1TpaHHR6du6FHh1aLxPy7TZEdflvZiS8yXNq5poZ5EMIU7OyuA5xWs1ig3
	7bxlmiPkDYlIBLjXEP10VaekdYNqz3rmJDR7UyejNT8Co2K16foALj72FVY5d7Ue
	T2KnaXCrG/7uAw2rHTASsWnR3miIKmuFUMPz4EBFRTXz2ZPvzgDcKeCGrcIHMB7z
	AelhfS/Fe81x6d/cNmZuMU8Y3Ddn26Y4kMuZdAtTO2gUrd4H8AGxefEXbni55hVk
	DL5q9b8mIrdMax/ncbmsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773830764; x=1773917164; bh=G
	dEjspRaDvVTtf7PkfnLUq8fFsaLcc0PMZBbW/XOL84=; b=F7hqibrmheSp7jlAN
	NLSjNz2LxuDCrB4OPG2j3npmOkT7zRHYh/42lxD596nLhINxR+UvOKKq03zYkSmn
	s3emIWV+Ip/eW2pxXSmaYQlXfv1UDTK8GURU1BUV832Ct73ekQzl0/DAuG4Ifk+8
	D96nxETros4RjOehG6QwwcWfrThRWA97ibmn/AQYk2zhg47KaQJLP4bVIyuH1yn3
	WoOLUU1LRBCCEMTgZlQ2jW8RI8/UTfQ1AEoykqO0HJiaqtwHUs0RAOwVOzrm2FuW
	0rbc7DPOhjod8cbOSWDkK8334N3Ay1l/921nKbPmP/JAeztrL03AgZOWYFz44gUM
	w0AgA==
X-ME-Sender: <xms:bIK6aXb751z87DhFLH48Vg2Sg59EtMxMO3XBY_tYgDKZrtgjWOte3w>
    <xme:bIK6ad0MTNFSe-LU1bWV210Tm5i1LespgpbMrawZkV7me8dothF9KQSyMz6nWCwMi
    TdCpC-Dcth-z5RkHS0Mj2nbQYaqEfOvJ5cE4xM70Ufv6kRUW2840v8>
X-ME-Received: <xmr:bIK6aXUQKieNgEi-VxzxuAxYiG4JET9Oh78Ybo6Nwg6nqUGVCPUduOuHzCgP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdefledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepieeiueeiteehtdefheekhffhgeevuefhteevueeljeeijeeiveehgfeh
    udfghefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtphht
    thhopehjihhrihesrhgvshhnuhhllhhirdhush
X-ME-Proxy: <xmx:bIK6aXWjWALkTqOpRuqKBk1sRZMEIto1C41ZELKA0pimIz7jPGZcJQ>
    <xmx:bIK6aWcy1jLE3e0HUaH0wJRg6jBwIYzSe5Biy7GV2ZRjFxY-IZ2Waw>
    <xmx:bIK6aQWBAer6xB9Xj6N3rhfM01reQpaZBwxzFKCvz3ue1FQvjmciRA>
    <xmx:bIK6afd2_bBQ3Zke4NtyFbLPwnzH5kgCe-B_NDntr4-lr1ybC9QXJA>
    <xmx:bIK6aQWUBEBvXMUiDPnU2EaSa6DgDSNQYdMoJI5EiggvOddvbR0i2wwO>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 06:46:04 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net 2/2] rtnetlink: count IFLA_INFO_SLAVE_KIND in if_nlmsg_size
Date: Wed, 18 Mar 2026 11:45:53 +0100
Message-ID: <52c1bac69cbbe82cfe0da2615d6a7f3f69254bb5.1773829376.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1773829376.git.sd@queasysnail.net>
References: <cover.1773829376.git.sd@queasysnail.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268969-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:dkim,queasysnail.net:email,queasysnail.net:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 224FB2BA299
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rtnl_link_get_slave_info_data_size counts IFLA_INFO_SLAVE_DATA, but
rtnl_link_slave_info_fill adds both IFLA_INFO_SLAVE_DATA and
IFLA_INFO_SLAVE_KIND.

Fixes: ba7d49b1f0f8 ("rtnetlink: provide api for getting and setting slave info")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/core/rtnetlink.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index a116362f5f32..cebc00d02fbb 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -707,11 +707,14 @@ static size_t rtnl_link_get_slave_info_data_size(const struct net_device *dev)
 		goto out;
 
 	ops = master_dev->rtnl_link_ops;
-	if (!ops || !ops->get_slave_size)
+	if (!ops)
+		goto out;
+	size += nla_total_size(strlen(ops->kind) + 1);  /* IFLA_INFO_SLAVE_KIND */
+	if (!ops->get_slave_size)
 		goto out;
 	/* IFLA_INFO_SLAVE_DATA + nested data */
-	size = nla_total_size(sizeof(struct nlattr)) +
-	       ops->get_slave_size(master_dev, dev);
+	size += nla_total_size(sizeof(struct nlattr)) +
+		ops->get_slave_size(master_dev, dev);
 
 out:
 	rcu_read_unlock();
-- 
2.51.2


