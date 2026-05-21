Return-Path: <netdev+bounces-290373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GN5cGzn0Dmq+DgYAu9opvQ
	(envelope-from <netdev+bounces-290373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:02:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B7F5A46C6
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0719E3011F35
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803A03C872C;
	Thu, 21 May 2026 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="AFLaUq1C"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2CA3C5855;
	Thu, 21 May 2026 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779364868; cv=none; b=pVtxbdms7gfmb/tCom+a8mx+O14ulb7RdNssA3nzkYnNBCJgf11FwR2vlFUp+6jPJ/MQPMPXkId3QlNa317oM8nyjvxk69i09pnvj95vjClTMl40EyKE73LDKfinpZ/IiOv7GVXTxrTp2gvUdfSLCzksStxfILFD9/+ywGMIuVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779364868; c=relaxed/simple;
	bh=LXIdM/Dw7daNjJglA/3yb0Ui85fWaEti7AaHv/Tx6K4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=C7hjHtxTreRFB/gUiH7hmpQ6+mODxzamS4eZ5D3FNfNSWAZlmQ1Zi028J6+2dOXwG2+dzeJO3qpXTAevu2pjJ+Qwbcpcajp+yKBaR/lbyVqi6y2VemhigooBqvdoe+VVTvwwOrVaEDmGFkcR+dCnCApqqO9tg4wHYXV8q5vls2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=AFLaUq1C; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Ws5sM1DRdOMVHc7ogYvGny/0fUwxt8XYdNzPpyIKzbc=;
	b=AFLaUq1C8RkRP05k5YmUkKds46+cWtfO3z1LfbwfSCxcg2hxBtd+gCBu+luy0Xnl3FWbcT2ew
	fF/cls7LJ2XJLV4y76gsVDe8moaZiQ5I64sIxzeg8RivEHVT9jv9hzuKa2jx9cNePju6iHd4qd8
	godZPzmL+1TFxBYUGY7bt8w=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gLmy81l4lzcb4G;
	Thu, 21 May 2026 19:53:20 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E8594056A;
	Thu, 21 May 2026 20:00:56 +0800 (CST)
Received: from kwepemq200001.china.huawei.com (7.202.195.16) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 May 2026 20:00:56 +0800
Received: from dggpemf200012.china.huawei.com (7.185.36.146) by
 kwepemq200001.china.huawei.com (7.202.195.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 May 2026 20:00:55 +0800
Received: from dggpemf200012.china.huawei.com ([7.185.36.146]) by
 dggpemf200012.china.huawei.com ([7.185.36.146]) with mapi id 15.02.1544.011;
 Thu, 21 May 2026 20:00:55 +0800
From: tanjingguo <tanjingguo@huawei.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Chenzhe <chenzhe@huawei.com>, "malin (R)" <malin89@huawei.com>, michenyuan
	<michenyuan@huawei.com>, cenxianlong <cenxianlong@huawei.com>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"davem@davemloft.net" <davem@davemloft.net>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "sd@queasysnail.net"
	<sd@queasysnail.net>
Subject: [PATCH ipsec v2] xfrm: esp: restore combined single-frag length gate
Thread-Topic: [PATCH ipsec v2] xfrm: esp: restore combined single-frag length
 gate
Thread-Index: AdzpGVwnLXqMWgBUQOC6hdwItlHJ6g==
Date: Thu, 21 May 2026 12:00:55 +0000
Message-ID: <ab4c5808478d48978292c318d85c4484@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_FROM(0.00)[bounces-290373-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:mid,huawei.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[tanjingguo.huawei.com:query timed out,malin89.huawei.com:query timed out];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tanjingguo@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: C4B7F5A46C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From 1e6d45378b272fe2f1fce48ed89d6eaa415c00c2 Mon Sep 17 00:00:00 2001
From: Jingguo Tan <tanjingguo@huawei.com>
Date: Mon, 18 May 2026 17:06:48 +0800
Subject: [PATCH ipsec v2] xfrm: esp: restore combined single-frag length ga=
te

The ESP out-of-place fast path appends the trailer in esp_output_head()
before esp_output_tail() allocates the destination page frag. The
head-side gate currently checks skb->data_len and tailen separately, but
the tail code allocates a single destination frag from the combined
post-trailer skb->data_len.

Reject the page-frag fast path when the combined aligned length exceeds a
page. Otherwise skb_page_frag_refill() may fall back to a single page while
the destination sg still spans the combined skb->data_len.

Restore this combined-length page gate for both IPv4 and IPv6.

Fixes: 5bd8baab087d ("esp: limit skb_page_frag_refill use to a single page"=
)
Cc: stable@vger.kernel.org
Signed-off-by: Lin Ma <malin89@huawei.com>
Signed-off-by: Chenyuan Mi <michenyuan@huawei.com>
Signed-off-by: Jingguo Tan <tanjingguo@huawei.com>
---
Changes in v2:
  - Use the ipsec tree subject prefix.
  - Clarify that esp_output_tail() allocates after esp_output_head() append=
s
    tailen.
  - Avoid shadowing the existing allocsize variable.
  - v1: https://lore.kernel.org/netdev/ag7kxJ39XQaVY1Mb@krikkit/T/#t

 net/ipv4/esp4.c | 4 ++--
 net/ipv6/esp6.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 6a5febbdbee49..c62dfe049ee7 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -419,8 +419,8 @@ int esp_output_head(struct xfrm_state *x, struct sk_buf=
f *skb, struct esp_info *
 			return err;
 	}
=20
-	if (ALIGN(tailen, L1_CACHE_BYTES) > PAGE_SIZE ||
-	    ALIGN(skb->data_len, L1_CACHE_BYTES) > PAGE_SIZE)
+	if (ALIGN(skb->data_len + tailen, L1_CACHE_BYTES) >
+	    PAGE_SIZE)
 		goto cow;
=20
 	if (!skb_cloned(skb)) {
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 9c06c5a1419dc..2516a4dc6d78 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -448,8 +448,8 @@ int esp6_output_head(struct xfrm_state *x, struct sk_bu=
ff *skb, struct esp_info
 			return err;
 	}
=20
-	if (ALIGN(tailen, L1_CACHE_BYTES) > PAGE_SIZE ||
-	    ALIGN(skb->data_len, L1_CACHE_BYTES) > PAGE_SIZE)
+	if (ALIGN(skb->data_len + tailen, L1_CACHE_BYTES) >
+	    PAGE_SIZE)
 		goto cow;
=20
 	if (!skb_cloned(skb)) {
--=20
2.43.0

