Return-Path: <netdev+bounces-295170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y4fUHwpUIWqiDgEAu9opvQ
	(envelope-from <netdev+bounces-295170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:31:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 146FD63F0B1
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:31:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=rk94LKrm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295170-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295170-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D7BD301C894
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 10:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7587B3DD505;
	Thu,  4 Jun 2026 10:28:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ACC3911BC;
	Thu,  4 Jun 2026 10:27:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568883; cv=none; b=CXcfbhI0eH2zPp7IEgVHHymtNaNKLMIQ1GtTXFc9uTVtEOQ6ShVN425XIqfSXyPw2XeGzFgVeAQ9cOv4sYg9KHXygkk92dQSeilxpPDNb2QsEvmoWSGBhDv/twoMyFBmUmAnnjNg0r6bFq9wlQ91BYUtFPZvcsf6lrVhzxJeCAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568883; c=relaxed/simple;
	bh=FOWr1dS/VmH3RWVUUohezGkEz6nOgu0fOj5E3dqrBQ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=txFhzKdTQnz6sXG/MP0NX0oXbKItmCavm4MQ6bHFoPnrEjJc2aGDLtfNLZlO+kxQPqLvInCWZi/CU8OxUSgh67sQIBic5OFDmiaQyprIhnY+Ychl8m0RaeEy7YmMzLmTd39eOetHRM/p2kefOUrdhAZRJjg4230ybWf/k2uuQuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=rk94LKrm; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 654ARYHx8272239, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780568855;
	bh=c3bw1u7Z6gLT9P5QUbS4UkwNKwbb5+C0+ng3u2/fU7Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=rk94LKrm8DZhjoud1EiPBNV1Jc+Ox+wHKZdSk3vy25V4sup4RHueFhs6P+aG+dTfy
	 DUE2AiYEw+TthlBG1cfD9NuikHtmVpBCWWY6nlfm1IjNqCUoOWyMeAGzsv84b7HkuA
	 kFq1v/QVUne+XwkOlcsW+6wQH9DH7ISDuo5svcEL9ap3hcZHxUiEXFTVNappp6s8OW
	 TSGn2oTpEHmzWytC4T2nF3Pjy4ZD+T2WC5VH7e6NXbH5UrDs2XgS28b8FqoR+9nnev
	 FKSxLkkKKmNONe2B3A5bXimLW3Rg4djiptskhV3bx+C1IDjAXEZizQW53a6J3O3pEj
	 wbeERDP8LS4Dg==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 654ARYHx8272239
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jun 2026 18:27:35 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Jun 2026 18:27:35 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 4 Jun 2026 18:27:35 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v7 0/7] r8169: add RSS support for RTL8127
Date: Thu, 4 Jun 2026 18:27:26 +0800
Message-ID: <20260604102733.1582-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295170-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 146FD63F0B1

From: Javen Xu <javen_xu@realsil.com.cn>

This patch series adds RSS (Receive Side Scaling) support for the r8169
ethernet driver, specifically for RTL8127 (RTL_GIGA_MAC_VER_80).

RSS enables packet distribution across multiple receive queues, which can
significantly improve network throughput on multi-core systems by allowing
parallel processing of incoming packets.

Key features:
- Multi-queue RX support (up to 8 queues)
- MSI-X interrupt with vector mapping
- Dynamic queue configuration via ethtool (-L)
- RSS hash computation for flow classification

Experiments:
Platform: AMD Ryzen Embedded R2514 with Radeon Graphics(4 Cores/8 Threads)
Arch: x86_64
Test command: 
  Server: iperf3 -s
  Client: iperf3 -c 192.168.2.1 -P 20 -t 3600
Monitor: mpstat -P ALL 1

Before this patch (Without RSS):
  Throughput: Unstable, fluctuating between 3.76 Gbits/sec and
  8.2 Gbits/sec.
  CPU Usage: A single CPU core is fully occupied with softirq reaching 
  up to 96%.

After this patch (With RSS enabled):
  Throughput: Stable at 9.42 Gbits/sec.
  CPU Usage: The traffic load is evenly distributed across multiple CPU
  cores. The maximum softirq on a single core dropped to 63%.
  
Other Experiments:
Link: https://lore.kernel.org/netdev/0A5279953D81BB9C+f50c9b49-3e5d-467f-b69a-7e49ed223383@radxa.com/


Javen Xu (7):
  r8169: add support for multi irqs
  r8169: add support for multi rx queues
  r8169: add support for new interrupt mapping
  r8169: enable new interrupt mapping
  r8169: add support and enable rss
  r8169: move struct ethtool_ops
  r8169: support setting rx queue numbers via ethtool

 drivers/net/ethernet/realtek/r8169_main.c | 1099 ++++++++++++++++++---
 1 file changed, 955 insertions(+), 144 deletions(-)

-- 
2.43.0


