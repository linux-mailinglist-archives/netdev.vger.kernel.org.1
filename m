Return-Path: <netdev+bounces-46015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD137E0D87
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 04:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B911C20A53
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 03:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398D53D78;
	Sat,  4 Nov 2023 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2VJ7ChI6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0B31FC9
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 03:40:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84478BF;
	Fri,  3 Nov 2023 20:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=4mCxdG9T2wmKjWyKacxf7Q3fDFsqsmniLHS/1fYzUhw=; b=2VJ7ChI6RysLfYXFkxskUFnrQI
	h3HQEUaIQcovrCqDginVglHl66WEtTXngyjtNFIGD17jcpUI7Gwi6gM/q2/Dy6NCD9c8qjKvvruDi
	v8PawS3YXhXo6N9r1oHY4x7rPoJH1uAgc7/lZYyTAVcF9JiCaGYBLQZWzLBEDEPWQg0qtJiFfEKuK
	awVqDSxQUSsfl2/Nwd2LT2k0vPfGQqrlHkfmIddYf4hSfUt/FWjsMPhg2cAMmkkpJWqbrJ+LA92pI
	3jree4dQK7uUi3on9LX0F+nP/4YVO3Za8eYloFjkteAoIOj+JtGFJVrZZ9Cg8uIhbUcp1qujlCHtZ
	m8PiYYMw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qz7WG-00CZj5-3B;
	Sat, 04 Nov 2023 03:40:21 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: [PATCH] netfilter: nat: add MODULE_DESCRIPTION
Date: Fri,  3 Nov 2023 20:40:17 -0700
Message-ID: <20231104034017.14909-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a MODULE_DESCRIPTION() to iptable_nat.c to avoid a build warning:

WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/netfilter/iptable_nat.o

This is only exposed when using "W=n".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org
---
 net/ipv4/netfilter/iptable_nat.c |    1 +
 1 file changed, 1 insertion(+)

diff -- a/net/ipv4/netfilter/iptable_nat.c b/net/ipv4/netfilter/iptable_nat.c
--- a/net/ipv4/netfilter/iptable_nat.c
+++ b/net/ipv4/netfilter/iptable_nat.c
@@ -169,4 +169,5 @@ static void __exit iptable_nat_exit(void
 module_init(iptable_nat_init);
 module_exit(iptable_nat_exit);
 
+MODULE_DESCRIPTION("Netfilter NAT module");
 MODULE_LICENSE("GPL");

