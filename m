Return-Path: <netdev+bounces-287242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEJ4LSteA2qE5QEAu9opvQ
	(envelope-from <netdev+bounces-287242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:06:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ACD5256E3
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF9C730D9FE8
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D72C3D5C10;
	Tue, 12 May 2026 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="LEixIodf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FOk3mRJd"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993453C8C56
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605086; cv=none; b=lJVwHPWFisjba0Ab+Ns3i72W5kFlpYZwsN55yeYzLuIwfMBCOddiEParM2tRlnE67K1++JL3DD3v/fboXWfkdMP6QeVTh3lDZMeWtKfwGJK7CaNi/SL/tmivxML9iNAXRyQnH+OpoRy+g7eKYOanJ+9CtSOB6Gy/hfqbTf+ngSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605086; c=relaxed/simple;
	bh=LYO28w/vatzILRqMViTx9/quD1mD+r9tqUUt+p9iM6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQ/5sEDtIQVx231XZl3l1cUIqdIqgcXCPuUjt0hfFFWgSc6dSB1nHEN34CVHSiKKn4UHGphKCrYgmr+iJkgQVH57UXVexC5QJoqLltIFqIMIwJiXL+YzeoYJl6ei5y2TPtCca4LHWBMxT+6vqB/V3ZH0NxlacVKXgQKepQPPGDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=LEixIodf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FOk3mRJd; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A492814000A7;
	Tue, 12 May 2026 12:58:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 12 May 2026 12:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1778605083; x=
	1778691483; bh=LHiQfTHyETI1dxH8h/QYy2J8CbZWqHqqCzMiGRcrZHo=; b=L
	EixIodfDNfMRUOSEHDq5YZU0k8WgNWfajTMTVqEuwWP2C6kU625FRjCKwzT6nEkj
	/W5F4Cw4xodhUerCYkOn5txj8EZI3CZZStpN603jGcF6AlF/J83re2A4jb7q0x4m
	uecxsdAjHZxVb1vcYSMhGGwnZ5DzXliMVJ8XT9dOn6VMN1ULOSiN1gSjNdauj1+O
	+56x5bii0I0iSTTWwIhaKvYr1JpzQZAUqtcfz8KODmDSnDGK/OYYoTyRpbPepXP1
	aFSv9OpGbpDjpUZexPDsnFsAffg3eqdoEIMOC0Vz7qYfn5UvEQt5dh5AVyElCn/k
	eA7FtZcAZ31OYPPBEuuig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778605083; x=1778691483; bh=L
	HiQfTHyETI1dxH8h/QYy2J8CbZWqHqqCzMiGRcrZHo=; b=FOk3mRJdRtR4M7tP5
	pYu6l2OmWwthJotluh+UcAXu8IYY4Mz8V+NcIWGjeZidJCeg9yXOkyjuMJ3hS/hj
	YIkoEwHzdTDUyquIe0JAH9nw+YWMx1KxoxnAmpF+2IncOIBapasD2fVsD32qoBIN
	45WBOZh//3yO1FoJZ/YRwGgNj/qD730GSUv2LHjwSfLZbkTUx87AFZSgsh5UOekp
	AtL4NgjBlWoWfSGkc7iSTLwJ++gtLJuJ8Btpv0mhOi2G43tjhvi/BkyL3MO6Z7Zi
	+QN8Xw6jKn5OgcurQR9kkyvy1tnEHmnYikIwZmXg+6axMnpIVQYI2LmStnxucSRz
	WSnZA==
X-ME-Sender: <xms:G1wDauCmVLmsyIpuqk4Ec501Y9gu_hEZ4n3lIyNX5rXnsRHAsRVEig>
    <xme:G1wDanCL_uzfB9F8uVgs4SVd2dYWSq5zhZ0YX2nBM69UEir0LS8vZB2Nmyw3GW0vZ
    FNOqMcxMN42T_hjYQMyd7-DJHKjd9j_zGBUaZJlVAXMZtN3gHii3Y8>
X-ME-Received: <xmr:G1wDaoYa5LrT-h9k1Mb0qYqTiGtAulV3eDIHvkLhZvzF9U9mhDXJFczjsneM81Ba0NTFplk0zBr877boqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddvfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepteffleejfedvhfehieejlefgkeeljeevueeggeev
    tefhgfeuhfduffegkedvtddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhn
    sggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhutghivghnrdigihhnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopeifihhllhgvmhgssehgohhoghhlvgdrtg
    homhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:G1wDasz64fux5Q6DxDGpBuzZSy77WIfg9-4VfYWP5NFtuIOpMTmLww>
    <xmx:G1wDardOmjKx0KTHSytSueP4F01pbsp_vq-Kc9dCw9tEAzhr5JkELQ>
    <xmx:G1wDaiJsWK3w5anxueGVECCHGhmKL-ibkSPlPKZpYemLpfO8xwqejQ>
    <xmx:G1wDak2c0Uldi7jCvdEYKK55Mfii_cmw86Dif4cvJ3FUwHEWC6M4kw>
    <xmx:G1wDagLRzk3jna3szlvjGLSn2aUfY6IGjwAacNIHbON22zYE5tBJ2i-j>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 12:58:02 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v4 03/12] geneve: Fix off-by-one comparing with GRO_LEGACY_MAX_SIZE
Date: Tue, 12 May 2026 18:56:39 +0200
Message-ID: <20260512165648.386518-4-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512165648.386518-1-alice.kernel@fastmail.im>
References: <20260512165648.386518-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 19ACD5256E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-287242-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.973];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:email,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fastmail.im:mid,fastmail.im:dkim]
X-Rspamd-Action: no action

From: Alice Mikityanska <alice@isovalent.com>

GRO_LEGACY_MAX_SIZE = 65536; total_len being 65536 is too big to fit
into a u16. As can be seen in skb_gro_receive, packets bigger or equal
to gro_max_size (or GRO_LEGACY_MAX_SIZE) are dropped with -E2BIG. Apply
the same boundary to geneve_post_decap_hint to avoid writing 65536 to a
16-bit iph->tot_len field with an overflow.

Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/geneve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index b36fad833724..aee05be69d1e 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -603,7 +603,7 @@ static int geneve_post_decap_hint(const struct sock *sk, struct sk_buff *skb,
 	ipv6h = (void *)skb->data + gro_hint->nested_nh_offset;
 	iph = (struct iphdr *)ipv6h;
 	total_len = skb->len - gro_hint->nested_nh_offset;
-	if (total_len > GRO_LEGACY_MAX_SIZE)
+	if (total_len >= GRO_LEGACY_MAX_SIZE)
 		return -E2BIG;
 
 	/*
-- 
2.54.0


