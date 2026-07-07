Return-Path: <netdev+bounces-305364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EM2EOxnGTGonpgEAu9opvQ
	(envelope-from <netdev+bounces-305364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:25:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50447719BAF
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:25:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XVx8VmDX;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305364-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305364-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C961A3129DC9
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 09:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4B03955F4;
	Tue,  7 Jul 2026 09:11:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B1C39524E
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 09:11:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415482; cv=none; b=AvW0czQn8LXTblnV7mVG7tsd5P+ptNlZQBFpfy4KCgTL77xATRmXjju2WzK3zjhLi9sncAslO6Blu57n61Nez/lbFDThvFwVlehWeB5e/NJgV4kXm5/l8VLKSvWhcmlMcVMJ12E8fMBQ8LYzFNYCMzzp5Mek8XxovVi7ZfNPhmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415482; c=relaxed/simple;
	bh=LwGdfVE6zCNMfNmWNHYheA/PzogaUt5+b/oAPBRLVHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzACKRRN5AGQJJW8h+uR1q+VuEvaVC/dtQV+YcdLL3MLnn8snQF+2fY1Q67dUGX5ikdGwumcSgs2G9PjnYwNeks8Zxm3DFBcwJYHUQ+uR8gcWHihi9iS19a90efeb7zM7uhVEMMovv7lC9O5QaNBYFYN/tID9Y+3CSTjSfpOAXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVx8VmDX; arc=none smtp.client-ip=209.85.208.43
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6974a6e54dbso6058369a12.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 02:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783415479; x=1784020279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=017gAsipokr31hcEOs9r+XS73NV9N5N3+SvjZqA1EbI=;
        b=XVx8VmDXH0Hs7kW8toIo8uufVGYvgCrAZfFRzPimBYfUefqmKvGBL5/4APTSmFqd/l
         hPBmgd+SO2J3Yv47ZVmOjlJfVOGC0TOiuPa8i5ZLfxCdvob5IsoWLPirsJzv0fE/OH2/
         QyARwi68gRWoUcEfY9kB8Fj0pd07GY2uDB+bxV8ek5IbGMCvjpCRL6fXeb3QFinysdAl
         wPCEXv0ey/sszQ+0U+RAbaHjK9dEDVHEqDi5kATDWUwoxr4zELcsQE1qpX/ejNZeW368
         xkW4GNQV15UYP1DA8tWX0WQ29mO8dfDRuSH3A5AfvjOel1IdCuvoXxdBpEcatO4NWpJZ
         HoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415479; x=1784020279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=017gAsipokr31hcEOs9r+XS73NV9N5N3+SvjZqA1EbI=;
        b=n6Gpj+OVEFcZgHH5iehDqwwYQ3gg0O94Zc/LUhUicbOpdO/4CCvVpgDIzrCaq44dHQ
         iWVEgtTywBfdI48ociq0dzHBqviTBCtJhvBM4j6B/qMTMgUjTGwFosEoT5MMKYcdmD79
         /NaATZT68+Yr74RzypgPDAncaeRvpYPsruTd8NgUQ3vImGliUKoCNquOeshl4fut98Aq
         Z9g2iA0dcpQUPlxxsKzdpqTewyPPwKJnW7yRTyXlvD1XylIyUd6qb+EtmZJqHNrrVc1L
         tvbGnOXnlxLrKYKxIDO1IF1fGCTBdoTCZt/PuFLIsQP6Io52nFY3jXvzU7oKyEZ37ZFj
         CN8g==
X-Gm-Message-State: AOJu0YwKwvNHZ8fgUth9tt2RF3p3/ZSWhneLgl62pshEwzhetFZjov7g
	NvAqmCoxy7NGxFX4ol9XMx6I+MuSW0biL9acZTTG6bSjrH30UWipnhag
X-Gm-Gg: AfdE7ckBsvkqiZU2bvvJWUGFcOinp5xjKdZWjytp8a3cEUnRbpqDMGLmOCvj2CE+L55
	oTq4zjMXNA4gvrRppHndszDqc3/gM5IPxnVNXXanjQ8AMU1mmkvfdGUNFlRRhqXXwGHGyRfBEC7
	T2dNZadz4yzr/xsqZnpooqVoyERg+fHjbS6/v/NX+2u8ADAe3giky8oKBhJ1bBGpmr3nRTLwwjC
	4ZCcLrC/Xq3eQm9gmkpRpNStwVIL+e8ggstO+E2jbi/Jmced6WA/RihrZd7sXMDeogEqcbmJQcx
	b5wij4MlYAjEaFI/Yv82cbEnprwewEE184Tqjo7ZO92gMEIJJ2yMuDc25hjZKjBqfJ7D64iJoTe
	LxJrG0W9FOEYcitP4CUhBI6jzOjA3Vq386fW5G8qdxQC4RYZ3iUzsIzIw27RAGLT5+aDX6sNX4L
	T/nc/UKB4ip0+YRnOnTXfr9PmYHXkkN0rIn4bnwdVTcqAM609Rbd4MIAHKLSgsxv3DhdPqi+z/n
	dxeZ/a79Fy0yx6nOshu4ZBvMQvShADZe0M4JY0YP21nMvbyeGihYXs=
X-Received: by 2002:aa7:c588:0:b0:698:be56:d7cf with SMTP id 4fb4d7f45d1cf-69a85bb21cfmr1640778a12.16.1783415479480;
        Tue, 07 Jul 2026 02:11:19 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19cd87d6sm5297152a12.6.2026.07.07.02.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:11:19 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>
Cc: netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v12 nf-next 4/7] netfilter: nf_flow_table_inet: Add nf_flowtable_type flowtable_bridge
Date: Tue,  7 Jul 2026 11:10:42 +0200
Message-ID: <20260707091045.967678-5-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707091045.967678-1-ericwouds@gmail.com>
References: <20260707091045.967678-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305364-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,netfilter.org,strlen.de,nwl.cc,blackwall.org,nvidia.com,gmail.com,uwaterloo.ca];
	FORGED_SENDER(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:razor@blackwall.org,m:idosch@nvidia.com,m:kuniyu@google.com,m:sdf.kernel@gmail.com,m:skhawaja@google.com,m:liuhangbin@gmail.com,m:krikku@gmail.com,m:mkarsten@uwaterloo.ca,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:bridge@lists.linux.dev,m:ericwouds@gmail.com,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,blackwall.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50447719BAF

This will allow a flowtable to be added to the nft bridge family.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nf_flow_table_inet.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/netfilter/nf_flow_table_inet.c b/net/netfilter/nf_flow_table_inet.c
index b0f1991719324..80b238196f29b 100644
--- a/net/netfilter/nf_flow_table_inet.c
+++ b/net/netfilter/nf_flow_table_inet.c
@@ -65,6 +65,16 @@ static int nf_flow_rule_route_inet(struct net *net,
 	return err;
 }
 
+static struct nf_flowtable_type flowtable_bridge = {
+	.family		= NFPROTO_BRIDGE,
+	.init		= nf_flow_table_init,
+	.setup		= nf_flow_table_offload_setup,
+	.action		= nf_flow_rule_bridge,
+	.free		= nf_flow_table_free,
+	.hook		= nf_flow_offload_inet_hook,
+	.owner		= THIS_MODULE,
+};
+
 static struct nf_flowtable_type flowtable_inet = {
 	.family		= NFPROTO_INET,
 	.init		= nf_flow_table_init,
@@ -97,6 +107,7 @@ static struct nf_flowtable_type flowtable_ipv6 = {
 
 static int __init nf_flow_inet_module_init(void)
 {
+	nft_register_flowtable_type(&flowtable_bridge);
 	nft_register_flowtable_type(&flowtable_ipv4);
 	nft_register_flowtable_type(&flowtable_ipv6);
 	nft_register_flowtable_type(&flowtable_inet);
@@ -109,6 +120,7 @@ static void __exit nf_flow_inet_module_exit(void)
 	nft_unregister_flowtable_type(&flowtable_inet);
 	nft_unregister_flowtable_type(&flowtable_ipv6);
 	nft_unregister_flowtable_type(&flowtable_ipv4);
+	nft_unregister_flowtable_type(&flowtable_bridge);
 }
 
 module_init(nf_flow_inet_module_init);
@@ -118,5 +130,6 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Pablo Neira Ayuso <pablo@netfilter.org>");
 MODULE_ALIAS_NF_FLOWTABLE(AF_INET);
 MODULE_ALIAS_NF_FLOWTABLE(AF_INET6);
+MODULE_ALIAS_NF_FLOWTABLE(AF_BRIDGE);
 MODULE_ALIAS_NF_FLOWTABLE(1); /* NFPROTO_INET */
 MODULE_DESCRIPTION("Netfilter flow table mixed IPv4/IPv6 module");
-- 
2.53.0


