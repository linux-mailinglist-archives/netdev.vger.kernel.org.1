Return-Path: <netdev+bounces-286750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HvCOUIWAmr+ngEAu9opvQ
	(envelope-from <netdev+bounces-286750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:47:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9ED513BE0
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9370E30D1BA2
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F7444B696;
	Mon, 11 May 2026 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZfUWEIkh"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC26C43D515
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 16:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518477; cv=none; b=WJA96w7UxqBd8Pvqvr6QmV7Kyuqz9Wf4v/H82TD2NNYoa1oGuXCDipQCmmhqICfC9rPKtwgGNfPg1VPglEnST6rr+YT0O/Ghfpw3u7CxquL29ARo1Z9yqOQpd6P+28FAzzKesTXFYsLP9+NvOeGJb19plTxpBZhaml1m9oDqFcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518477; c=relaxed/simple;
	bh=ic0H4UO1h2Q2Xbgoso/ZmLLxCtYkuq0XQxbDjRMp1+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=ktIRzWho880/4Vnoh1jPd6ZGskUa9bq2txa24Lsi60hV8AYuxccoKAddeDsMP9ElzRuYhW5Igjlf0GU2jBRY1njhIUv/gP0DGR7D59Afi6SZfz9A0111HxHhnozeWv42+TuVqBuDw2RV6RRWR1bqbuMYPM33ThmcG4lgOF3GHzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZfUWEIkh; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260511165432euoutp02c55ff58bc8947ae96efa1d46cca935eb~ukSC_rt3K2270322703euoutp02e
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 16:54:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260511165432euoutp02c55ff58bc8947ae96efa1d46cca935eb~ukSC_rt3K2270322703euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1778518472;
	bh=HiP2hwWPH30nfu3+Qan9TooCkOWsRZoMyJjPB9uIt4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZfUWEIkhFYvK4ng1l0+DzkhjzFJZgPKeWwski8lSEqNQgcwEFO6I3zA9ceC08ToV+
	 gNsx8C2S07b9MDK4AZxITf2hR2mY3COx3kU67zsqEmmlVMcsZzAfdTRz7RMlvjsqU/
	 mbJHFu9V5pR2k45x9YrRqPaLH4KiSgAt9ismIWSo=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260511165432eucas1p1954811c2d67a64f9577ee8d92e903915~ukSCrHq8B0893208932eucas1p1n;
	Mon, 11 May 2026 16:54:32 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260511165431eusmtip17be03aa00d67bfff28614ebc2468254c~ukSCF3tUU2739027390eusmtip1E;
	Mon, 11 May 2026 16:54:31 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	k.domagalski@samsung.com, k.tegowski@samsung.com, Jakub Raczynski
	<j.raczynski@samsung.com>
Subject: [PATCH net-next 3/3] include/stmmac: Increase max DMA/MTL channel
 count from 8 to 16
Date: Mon, 11 May 2026 18:54:16 +0200
Message-Id: <20260511165416.3093015-4-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511165416.3093015-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260511165432eucas1p1954811c2d67a64f9577ee8d92e903915
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260511165432eucas1p1954811c2d67a64f9577ee8d92e903915
X-EPHeader: CA
X-CMS-RootMailID: 20260511165432eucas1p1954811c2d67a64f9577ee8d92e903915
References: <20260511165416.3093015-1-j.raczynski@samsung.com>
	<CGME20260511165432eucas1p1954811c2d67a64f9577ee8d92e903915@eucas1p1.samsung.com>
X-Rspamd-Queue-Id: 1E9ED513BE0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,samsung.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286750-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[samsung.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:email,samsung.com:mid,samsung.com:dkim]
X-Rspamd-Action: no action

Newer XGMAC hardware does support up to 16 DMA/MTL queues.
Add support for these after previous modifications of driver to accomodate for
that.

Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 include/linux/stmmac.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 4430b967abde..a9d19e2c388c 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -15,9 +15,9 @@
 #include <linux/platform_device.h>
 #include <linux/phylink.h>
 
-#define MTL_MAX_RX_QUEUES	8
-#define MTL_MAX_TX_QUEUES	8
-#define STMMAC_CH_MAX		8
+#define MTL_MAX_RX_QUEUES	16
+#define MTL_MAX_TX_QUEUES	16
+#define STMMAC_CH_MAX		16
 
 #define STMMAC_RX_COE_NONE	0
 #define STMMAC_RX_COE_TYPE1	1
-- 
2.34.1


