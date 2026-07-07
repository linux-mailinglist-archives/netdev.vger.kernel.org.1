Return-Path: <netdev+bounces-305549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xtKDExA7TWqGxAEAu9opvQ
	(envelope-from <netdev+bounces-305549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 19:44:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DD671E5DF
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 19:44:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=tNlfMC7T;
	dmarc=pass (policy=none) header.from=samsung.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305549-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305549-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3F92301A7DE
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 17:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC36437863;
	Tue,  7 Jul 2026 17:44:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294FC377555
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:44:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446282; cv=none; b=YKMjcveBiCnRYL86cUmmNBbze9XgtKJqmnSSXN2z/dN+XYsIWBpHF18B41SZHZOjTWXYOmFR+T9dFZnmYieUsfUbeIahj9DwSHORtsDlhGSSzNzt57UgcjYNCPQTEvE4nkD/kGzjfy0WzDXSjyon5fJoH0n2wGoOniNwUIx+u24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446282; c=relaxed/simple;
	bh=fnlYx/J0et0q0k2a4BMf1NHjS5PaQMS97DIOQN7/maw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=uJFiHXTFRtCIYQCEtTaz2VzYYcgCr9PyKJ6jqcF6g3QQcwPei6uJ974cNFYy9w38wBLuXl9U5DxHYmSkxRTlSrGTKPs3cKNyYJmzTfAxqttUHDIh9Ccd49UTeI79wRXgv2oyW33Fv3KBU8qjaWjxGYieM3sIHKMGps4ThFLMzm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tNlfMC7T; arc=none smtp.client-ip=210.118.77.11
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260707174439euoutp0190390c0822f5f73bce0d776ec1451a72~AEvExPwfp0163301633euoutp01u
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:44:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260707174439euoutp0190390c0822f5f73bce0d776ec1451a72~AEvExPwfp0163301633euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783446279;
	bh=GNXbq9Cu+WTMH+abx/696AHzFIv8/SkoGRDgk6ijN8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tNlfMC7TWCquHCU6lnZSXb3kReavyuQAQxZFlA+sF64kY8S5odkbRnoXNs9WltHNy
	 HLzIvfcsav6HMb3Czbd+84QWfzvr5R8IBPLKSaStnq0wSfRMUtvBv2eRg5T6Hesllb
	 SKvxw8PolsqVaYqtnSgRMNkHSIy2Ydkyg8NGkD4M=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260707174438eucas1p132b5c02ceed2493cc7de98ab28c390ee~AEvDeEAs-0453604536eucas1p1Z;
	Tue,  7 Jul 2026 17:44:38 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260707174437eusmtip24d81a31a7f75f7524d8d04fbaa19b62b~AEvCzl9WA1305113051eusmtip2a;
	Tue,  7 Jul 2026 17:44:37 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: k.tegowski@samsung.com, k.domagalski@samsung.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jakub
	Raczynski <j.raczynski@samsung.com>
Subject: [PATCH net 1/2] net/stmmac: Protect against zero queue DTS config
Date: Tue,  7 Jul 2026 19:44:30 +0200
Message-Id: <20260707174431.1264520-2-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707174431.1264520-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260707174438eucas1p132b5c02ceed2493cc7de98ab28c390ee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260707174438eucas1p132b5c02ceed2493cc7de98ab28c390ee
X-EPHeader: CA
X-CMS-RootMailID: 20260707174438eucas1p132b5c02ceed2493cc7de98ab28c390ee
References: <20260707174431.1264520-1-j.raczynski@samsung.com>
	<CGME20260707174438eucas1p132b5c02ceed2493cc7de98ab28c390ee@eucas1p1.samsung.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[samsung.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305549-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:k.tegowski@samsung.com,m:k.domagalski@samsung.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:j.raczynski@samsung.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[samsung.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,st-md-mailman.stormreply.com,lists.infradead.org,vger.kernel.org];
	DKIM_TRACE(0.00)[samsung.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,samsung.com:from_mime,samsung.com:email,samsung.com:mid,samsung.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C7DD671E5DF

Commit 8a7bca6de6de protected against inputing number of tx/rx_queues_to_use
over kernel supported limit in DTS config. AI review mentioned that we also
should protect against zero queue input, because this would cause issues
down the line. Missing config is not an issue as stmmac_plat_dat_alloc()
does apply '1' by default.

Fix this by adding check for zero queues input during DTS parsing

Fixes: 8a7bca6de6de ("net/stmmac: Apply MTL_MAX queue limit if config missing")
Reported-by: Sashiko AI <sashiko-bot@kernel.org>
Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index dc5f951a311d..9112cd69b9b1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -158,6 +158,8 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 	if (!of_property_read_u32(rx_node, "snps,rx-queues-to-use", &value)) {
 		if (value > MTL_MAX_RX_QUEUES)
 			value = MTL_MAX_RX_QUEUES;
+		else if (value == 0)
+			value = 1;
 		plat->rx_queues_to_use = value;
 	}
 
@@ -212,6 +214,8 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 	if (!of_property_read_u32(tx_node, "snps,tx-queues-to-use", &value)) {
 		if (value > MTL_MAX_TX_QUEUES)
 			value = MTL_MAX_TX_QUEUES;
+		else if (value == 0)
+			value = 1;
 		plat->tx_queues_to_use = value;
 	}
 
-- 
2.34.1


