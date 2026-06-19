Return-Path: <netdev+bounces-300675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F1NrKdoSNWqSmgYAu9opvQ
	(envelope-from <netdev+bounces-300675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:58:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1091C6A512D
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:58:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=WCtI4nRV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300675-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300675-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C7E33019833
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80034285CA4;
	Fri, 19 Jun 2026 09:58:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f100.google.com (mail-vs1-f100.google.com [209.85.217.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFD3369992
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 09:58:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781863091; cv=none; b=q7qHhx/+2GOhsdu2Ng6PzGY8mBdzAr+bsLVhZaendHv5sH81P9ZSVj614BBzZU0QNlxLJ6OvNzTTlZCw1/7uuF+WFsfY4oreWTE3qaDvgBCfpAjzMIhuLU0XpPzID2+67V7OzEIpB9MzCSXsTWQsrpUD8UonNops+owDacJTOP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781863091; c=relaxed/simple;
	bh=gnqYplrvnOKhysmkaWxCDnkGO5zvC2BvTJjxuHPuzak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SiibAoyVTWplyf3ohB//YsSs0YEkkhZL0WZuNlJv6jmjy3/4wJV4ZR/0bK+gAMkxAZHE3Qa8E8NaN9IUEk9aiWa2I6Qiz7VjHXeffIPnIT+694t1YwiNeeVk+z5nLX2ibko6eegrIIRhYUg+abdJtMBMLUrDFRX6bWwlhn0w80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WCtI4nRV; arc=none smtp.client-ip=209.85.217.100
Received: by mail-vs1-f100.google.com with SMTP id ada2fe7eead31-6ca94e539f9so1126050137.2
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 02:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781863084; x=1782467884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMj6/kEzjl1ru5UHUZhZ/YyeC10jEp1W8ogblv+QKRE=;
        b=TzTZwMD5dR/E6M24MhOuqvt64dHvxsBgvB+PODlyMF0lJKdf7Z1kaa6nLvborADEc2
         5ERPTlK25HfsihUvdT7NFgMWke8VXewueUgHk5lCLEVK3dTZUiV9LeftuJ2b0dEDFIZJ
         nYo2uyNTH8K43CEGsI1F43CZZrm31YnI9zS32FPwQHSxcRHQZ4rFfyRr9Qj9prRhNEoE
         pWPzNFrD7X7aAMX10aEmDjhOL+preaoR9fhNimUnOA+BADom8lKnDwQ8o64ETHov9hAr
         YLuP4ASR5nNBM8DkZPDWf9VAuYkhUX/XqsJig/wZ5Th71DfZPy8QkxX01Q51kDz9NgZe
         LXDQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5So2+/fa6IIy9sjWix5sAQWjANJ8L6Afts83TgfOJavBUoHKTiZzYC3I49562inyPCGRD5vE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxurwI7ivpq1BEXrFRvbNo9fHEFwzzv/LZIjPy8LAMTXW9alp83
	f4XyVkvWiQJ5IEIxj/kcYqj0jgZPRQzF2Ny3oOOI5+WQPPtYLxTykO+rM0kdd6cvwiwDb6BEod/
	IMBEXpQ2vroNZ3cC9JrY2+DNAeEjyTyqubfweFCywrrTgj+JNosbrbteWDn2UrhD7XBvdQTbDZA
	ODC05/RILhOmORw+Z3aVB0MMXzOXOD3KgSYFFWMf1b/08ezBvKKMRPFZ3Q+YMCifUhvUgp/aZz0
	WU/xQ5s2zrgHdttFQ==
X-Gm-Gg: AfdE7cmERdQMnX4neQaKsDnA2s7XNO8MO/mGOZbj6gGBKTWVzpfxoG62OZiu1rPZgZt
	KSnS8QrNcj4Dgljmo1WNJFQiYqpWYD8mr7YrnaZ1JSht52dpHecd2Z43E9D7+yzwRBRuVfbXxAe
	GiewrtrwJ/c58GeAKrphsX4H+fKrlJQv6JhUwcERK4nNKKK+oktOY8flZdD1mrodVzi0liqfVli
	MPmk/Lsr/WRH183OAiYiP7fgHY3W6xGh1QB158Zbj7Y2srxHuXX0N0BgT0ubjGMK/eQr1NIca7R
	xHBRFkJdc+iHoMH15/kGDsFimRupL4x4Iqk1hvhpUYMtirPmsU/yN4LsgO9f8Ji5gcMTf5AMz1/
	FZTGoSwr93ptzaihEXF3tQnsH6wM7k66KAwZtaw+BibEKpwJm/5YLdX6anYgsqFvZWlQ3K0vEIe
	syc49PmNRbtWv/gI27tQfcd9f6qELKDdc/IeSgoTlA3bdRLlgSig==
X-Received: by 2002:a05:6102:4415:b0:726:cd42:d039 with SMTP id ada2fe7eead31-72a03fb3994mr2055360137.24.1781863083905;
        Fri, 19 Jun 2026 02:58:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-72a343ea873sm162925137.5.2026.06.19.02.58.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2026 02:58:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30beab99453so3155720eec.1
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 02:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781863083; x=1782467883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMj6/kEzjl1ru5UHUZhZ/YyeC10jEp1W8ogblv+QKRE=;
        b=WCtI4nRVRHE+sflh9YeAaN74he+ZXuZaJvY5HUjbJtJlqv+PUhtodFVxLqL2N53z51
         Q2HDeIwK7YTQeoSY/EtijfweP/J3Giq1GqWybrdnhnsDE9IpG7XQ34fmoAC+a0wFwDKY
         XjYcsXKwXq1oyyyfGhbpRrTHKbvQ+xj8wQGpA=
X-Forwarded-Encrypted: i=1; AFNElJ8GRnFgus4bl9lrwbgchVmdntqpxIB4Fip6FAfBT5YZY+LlOCo6aYcBnf3Q8oQugONPKePDRfk=@vger.kernel.org
X-Received: by 2002:a05:7300:cd8d:b0:30b:bda8:a70b with SMTP id 5a478bee46e88-30c06fb6c08mr1706541eec.4.1781863082636;
        Fri, 19 Jun 2026 02:58:02 -0700 (PDT)
X-Received: by 2002:a05:7300:cd8d:b0:30b:bda8:a70b with SMTP id 5a478bee46e88-30c06fb6c08mr1706518eec.4.1781863082047;
        Fri, 19 Jun 2026 02:58:02 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c06d5bec5sm1851910eec.26.2026.06.19.02.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 02:58:01 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v6.1 1/3] netfilter: nf_tables: always increment set element count
Date: Fri, 19 Jun 2026 02:28:48 -0700
Message-Id: <20260619092850.1274076-2-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619092850.1274076-1-shivani.agarwal@broadcom.com>
References: <20260619092850.1274076-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:vamsi-krishna.brahmajosyula@broadcom.com,m:yin.ding@broadcom.com,m:tapas.kundu@broadcom.com,m:shivani.agarwal@broadcom.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[shivani.agarwal@broadcom.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,strlen.de:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300675-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shivani.agarwal@broadcom.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1091C6A512D

From: Florian Westphal <fw@strlen.de>

[ Upstream commit d4b7f29eb85c93893bc27388b37709efbc3c9a0e ]

At this time, set->nelems counter only increments when the set has
a maximum size.

All set elements decrement the counter unconditionally, this is
confusing.

Increment the counter unconditionally to make this symmetrical.
This would also allow changing the set maximum size after set creation
in a later patch.

Signed-off-by: Florian Westphal <fw@strlen.de>
[ Shivani: Modified to apply on 6.1.y ]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 net/netfilter/nf_tables_api.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 0c4224282..ec4bfe53b 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6670,10 +6670,13 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 		goto err_element_clash;
 	}
 
-	if (!(flags & NFT_SET_ELEM_CATCHALL) && set->size &&
-	    !atomic_add_unless(&set->nelems, 1, set->size + set->ndeact)) {
-		err = -ENFILE;
-		goto err_set_full;
+	if (!(flags & NFT_SET_ELEM_CATCHALL)) {
+		unsigned int max = set->size ? set->size + set->ndeact : UINT_MAX;
+
+		if (!atomic_add_unless(&set->nelems, 1, max)) {
+			err = -ENFILE;
+			goto err_set_full;
+		}
 	}
 
 	nft_trans_elem(trans) = elem;
-- 
2.53.0


