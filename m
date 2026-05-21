Return-Path: <netdev+bounces-290267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFxvLki6DmrBBgYAu9opvQ
	(envelope-from <netdev+bounces-290267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 09:54:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ACF5A072D
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 09:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF6783064079
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 07:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2495A385D9A;
	Thu, 21 May 2026 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WMevoW8Z"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326E822D4C3;
	Thu, 21 May 2026 07:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349976; cv=none; b=PnVoXPp3NIXpXC6wY+u2ZCLwBzAo1Funo2VQ81ohCkYe2qfMAMJxa1SjMfmfJa1H+Ik1Nm08CCEvSfvoBCwYkCcZViG3uWOTd70QHFCMb+qOIRkfUB9Ok5a7IaRtsosrCFHeTOZEoxSPLjFLW0O0YyjSlSG9pTmvgH53AhW1DKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349976; c=relaxed/simple;
	bh=JpYfcqolUQUESLv0yAbvxf6JOmMjx5s+lsifDRceO8M=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=naR8CGEcefro+3EHoncMyaWFB0W7DWvPqNYtFHSl1svICaSjjuu0N4h4VAowC3o4kHnwA2iPvAwHSQrdHO6CtBOaU4yDctjhtaqQdB/797S3WRKbR1wRLx21ZIbB6w3PIZhuuw7nP8opZEUcTRR3ZebtfmqCoz4BQIzQ2EZg9xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WMevoW8Z; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=s971WaSb15A/nflk7KdW6+vdvRisVrLU5ekFzr8cEGY=;
	b=WMevoW8Zs6YS5z80FVrObmHO2bSkWwdnAgcmIxOJHTTrWx7jg9VcooMcyzIodukQV31+dffrj
	XvRsaIvnRXr02v+o3ZYRS0O2/OXi7txOWhFD8i2auYD1ljVlQ+JmPVrRmPUdlNbDwStwMynLUvi
	BPDOC4brp++1WMN22H2uk/I=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gLgSG6bKlzpStZ;
	Thu, 21 May 2026 15:45:34 +0800 (CST)
Received: from dggpemr100009.china.huawei.com (unknown [7.185.36.78])
	by mail.maildlp.com (Postfix) with ESMTPS id 628B34056A;
	Thu, 21 May 2026 15:52:50 +0800 (CST)
Received: from dggpemf200012.china.huawei.com (7.185.36.146) by
 dggpemr100009.china.huawei.com (7.185.36.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 21 May 2026 15:52:50 +0800
Received: from dggpemf200012.china.huawei.com ([7.185.36.146]) by
 dggpemf200012.china.huawei.com ([7.185.36.146]) with mapi id 15.02.1544.011;
 Thu, 21 May 2026 15:52:50 +0800
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
Subject: [PATCH net] xfrm: esp: restore combined single-frag length gate
Thread-Topic: [PATCH net] xfrm: esp: restore combined single-frag length gate
Thread-Index: Adzo9XCK9NlxNTA8Q1unEJo+/Nc3cQ==
Date: Thu, 21 May 2026 07:52:50 +0000
Message-ID: <48c8f59972cc407092834fb73e06ff2c@huawei.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[huawei.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290267-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:email,huawei.com:mid,huawei.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tanjingguo@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 31ACF5A072D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From 1e6d45378b272fe2f1fce48ed89d6eaa415c00c2 Mon Sep 17 00:00:00 2001
From: Jingguo Tan <tanjingguo@huawei.com>
Date: Mon, 18 May 2026 17:06:48 +0800
Subject: [PATCH net] xfrm: esp: restore combined single-frag length gate

The ESP out-of-place fast path still consumes the combined post-trailer
skb->data_len as a single destination frag in esp_output_tail()/
esp6_output_tail(). The head-side gate must therefore reject any case
where ALIGN(skb->data_len + tailen, L1_CACHE_BYTES) exceeds PAGE_SIZE,
otherwise skb_page_frag_refill() may fall back to a single page and the
destination sg will overrun it.

Restore a combined-length page gate before entering the page-frag fast
path for both IPv4 and IPv6.

Fixes: 5bd8baab087d ("esp: limit skb_page_frag_refill use to a single page"=
)
Cc: stable@vger.kernel.org
Signed-off-by: Lin Ma <malin89@huawei.com>
Signed-off-by: Chenyuan Mi <michenyuan@huawei.com>
Signed-off-by: Jingguo Tan <tanjingguo@huawei.com>
---

 net/ipv4/esp4.c | 5 +++--
 net/ipv6/esp6.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 6a5febbdbee49..2d7daca8516c2 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -410,6 +410,7 @@ int esp_output_head(struct xfrm_state *x, struct sk_buf=
f *skb, struct esp_info *
 	struct page *page;
 	struct sk_buff *trailer;
 	int tailen =3D esp->tailen;
+	unsigned int allocsize;
=20
 	/* this is non-NULL only with TCP/UDP Encapsulation */
 	if (x->encap) {
@@ -419,8 +420,8 @@ int esp_output_head(struct xfrm_state *x, struct sk_buf=
f *skb, struct esp_info *
 			return err;
 	}
=20
-	if (ALIGN(tailen, L1_CACHE_BYTES) > PAGE_SIZE ||
-	    ALIGN(skb->data_len, L1_CACHE_BYTES) > PAGE_SIZE)
+	allocsize =3D ALIGN(skb->data_len + tailen, L1_CACHE_BYTES);
+	if (allocsize > PAGE_SIZE)
 		goto cow;
=20
 	if (!skb_cloned(skb)) {
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 9c06c5a1419dc..0fad1dc558b84 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -440,6 +440,7 @@ int esp6_output_head(struct xfrm_state *x, struct sk_bu=
ff *skb, struct esp_info
 	struct page *page;
 	struct sk_buff *trailer;
 	int tailen =3D esp->tailen;
+	unsigned int allocsize;
=20
 	if (x->encap) {
 		int err =3D esp6_output_encap(x, skb, esp);
@@ -448,8 +449,8 @@ int esp6_output_head(struct xfrm_state *x, struct sk_bu=
ff *skb, struct esp_info
 			return err;
 	}
=20
-	if (ALIGN(tailen, L1_CACHE_BYTES) > PAGE_SIZE ||
-	    ALIGN(skb->data_len, L1_CACHE_BYTES) > PAGE_SIZE)
+	allocsize =3D ALIGN(skb->data_len + tailen, L1_CACHE_BYTES);
+	if (allocsize > PAGE_SIZE)
 		goto cow;
=20
 	if (!skb_cloned(skb)) {
--=20
2.43.0

