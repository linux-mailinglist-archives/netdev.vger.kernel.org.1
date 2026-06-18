Return-Path: <netdev+bounces-300356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OQlGBaKuM2oSFAYAu9opvQ
	(envelope-from <netdev+bounces-300356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:38:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6796669E812
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:38:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=Z3PbnRG7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300356-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300356-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 682FD304E431
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 08:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE97C3B47C6;
	Thu, 18 Jun 2026 08:37:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607CD3B2FE3
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 08:37:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771854; cv=none; b=Hw91Z6L8nHo66A686nSen8maJJ6x4PCopXfE69ugnjJwy4caCYfn328od4WM/LE4ZCg1MnbJwB2OZBGYw/wbIbJt/TYL2t5ZAV7Yki/1mqUrqC9IWaIpvWx0W28M7g6PjD6uEFP3VhikYdS2nXQ3Lt+v3kBi7DPbseYbYjPoV1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771854; c=relaxed/simple;
	bh=pOwuoiQjzretG7oDfDmFYA3hIp2H88a2vhblAg1egbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R2CkqTUwYtUcXIpp3Fgbu2+qIyk12sIk7C8yfje9qbibKMkx47Daox1/xZxflRBHf+zTePnb6WtQdrGrtd+5iSmSMFo74Z7vigXn5DqY20OgPLg8DqQAcRtDBjxBMHJxqZboudOxZ+w3hnf7qrs0FktmVK3Wq7gfVc0no+I+9kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Z3PbnRG7; arc=none smtp.client-ip=209.85.160.226
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-5174a3d9598so5865561cf.3
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 01:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781771852; x=1782376652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ali2EOfmsyhEzhaOAaUOh+zn1fjnnog9jkuNp7bauLU=;
        b=Yb7XBiyk6U56zMB1zBaLSTyLzmhiQAz8IMZ75W/1jvn3zuLbFFnU9I0UugwkbfzS0Q
         1mToK8IyFeSfp9EfP0ZSblASDIAh2WkoY0vGN9RErDpt31FWf+Up77+kgBnRxLJwd9oE
         BgV+i8ppxDE3cy+TqedFjAh6aNW2gD90drUEP1nG0WGPe2WT5Skw522WLm9eckrJcxH7
         o/VYz6LjDqkmZKo2nhQ5CMey8S4RRU0U0d8t0anL5tVqZJl8Au8rj/a1pmcU8f/DY8QW
         nI9DecIzLow+qd39c0hsvkmZadomAqWAm32p0BrKdM+g1Ccz6WglnW6tfmL2tEWvUOpu
         jYpA==
X-Forwarded-Encrypted: i=1; AFNElJ8f4liOw+zHTtTCrDgDsqrfHnABYB/5iDUIfsltOit4PgxR7C/k6kQ+tzED+bCw4l7LSQ3faC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylwOQX8Z+WvV59TBPtpQL89ybTWhG5qIdQ1XqwpVPSFolccQmm
	NSGpbgoJffjDZv9jOnb9bxGGIN/Gbx+sMghgLe92BvSWDvNRWncKPm3uZnZcPFyva6EVr2bHlbK
	6gLkhSgK2t66dFdOmeHJ96zr0W+4veiix71iarRs+bE9YUK+Hv+i8qQIy0zrFNpN3U87hMmKjy1
	wYev6xSPCODc/pe4oopw68G3cKleWIIJ0iJS8frdk1ve+FE6Tbg71rOgdVKo2kCxI7ekmw9k/tO
	iDa98a4E5+ozc1jCw==
X-Gm-Gg: Acq92OFxMIvG7oslRos8nBxjIo8qHt/dc0k8oDO6vpEJdROf59ui62witEsIUg3KAMZ
	QomgXZ9+HcxbDqaVrpnwiQdtg36EFQPxOGe3YcuzWjzGcI1JxODY8cNMHb/73geyT5c2FfI8HOx
	yY6kIPMFzK9/V662Q8KQVMC8OfThOqlPrvl4x0LgvlVCR2E7mFAWI5X1PPfbP5vrbhb+Vh1KqXs
	TdPOT2a0Swbsb4MthCqv9sCyejXW7nCNJyc5Gd1FjTZPJZN2DI3cjR5fN4QD17emOAe3Fk1w0wM
	IwvHhKKZJVKx9PhiBJpChe6v33SQl70TPd+Ox8rbDZCMWnP/MU5Khw44tM0jh3i1ONN96p/wCz4
	OlExuZWD1lzpyWm5lZpfcUTLhPaF1QGnW64HThQEzbjCrEMlx78YumsH3GoHfuBLygWFIauYkQZ
	WRRfx/H09ShO/gHa1HmbCacm8TIYpcv7oeJ85VQ06i7gHakit84Q==
X-Received: by 2002:a05:622a:820c:b0:515:189c:e0f8 with SMTP id d75a77b69052e-519ac21a298mr78830491cf.17.1781771852174;
        Thu, 18 Jun 2026 01:37:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-51954a8b6e0sm7342771cf.1.2026.06.18.01.37.31
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2026 01:37:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bdfcf7c14so2894741eec.0
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 01:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781771851; x=1782376651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ali2EOfmsyhEzhaOAaUOh+zn1fjnnog9jkuNp7bauLU=;
        b=Z3PbnRG7RwUZNKm8nE+twtL1ioxcp80xQhoiFoIcELbKVpRmTdeTtHkO4hnauimVlf
         PciG5XllfT0QaCFWHvr2+6euHEIk4+xeeMeHFKVAt8+zjcGkeri75tbkDv/bi9FDbgOu
         97VjlMarbuULn1IId0mSY0ytf/8NO9HZDSg60=
X-Forwarded-Encrypted: i=1; AFNElJ8SFASVJeqPmT41LLZzamPfPToR2E7GCGSRF+bmEbnbphM/JPyKQMAd+cP47rDP39JYGpskV7g=@vger.kernel.org
X-Received: by 2002:a05:7300:8608:b0:30b:c6f0:1cd9 with SMTP id 5a478bee46e88-30bca0cd6e3mr4005744eec.26.1781771850896;
        Thu, 18 Jun 2026 01:37:30 -0700 (PDT)
X-Received: by 2002:a05:7300:8608:b0:30b:c6f0:1cd9 with SMTP id 5a478bee46e88-30bca0cd6e3mr4005706eec.26.1781771850085;
        Thu, 18 Jun 2026 01:37:30 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48e412sm27475037eec.4.2026.06.18.01.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 01:37:29 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaosuo@gmail.com,
	iri@resnulli.us,
	jhs@mojatatu.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Bin Lan <lanbincn@139.com>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10 1/2] net: add skb_header_pointer_careful() helper
Date: Thu, 18 Jun 2026 01:08:06 -0700
Message-Id: <20260618080807.1269070-2-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260618080807.1269070-1-shivani.agarwal@broadcom.com>
References: <20260618080807.1269070-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SEM_URIBL(3.50)[139.com:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300356-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,resnulli.us,mojatatu.com,broadcom.com,139.com];
	R_DKIM_ALLOW(0.00)[broadcom.com:s=google];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xiaosuo@gmail.com,m:iri@resnulli.us,m:jhs@mojatatu.com,m:ajay.kaher@broadcom.com,m:alexey.makhalov@broadcom.com,m:vamsi-krishna.brahmajosyula@broadcom.com,m:yin.ding@broadcom.com,m:tapas.kundu@broadcom.com,m:lanbincn@139.com,m:shivani.agarwal@broadcom.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[shivani.agarwal@broadcom.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[broadcom.com,reject];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,139.com:email,msgid.link:url,vger.kernel.org:from_smtp,linuxfoundation.org:email,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shivani.agarwal@broadcom.com,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6796669E812

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 13e00fdc9236bd4d0bff4109d2983171fbcb74c4 ]

This variant of skb_header_pointer() should be used in contexts
where @offset argument is user-controlled and could be negative.

Negative offsets are supported, as long as the zone starts
between skb->head and skb->data.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260128141539.3404400-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Adjust context ]
Signed-off-by: Bin Lan <lanbincn@139.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Shivani: Modified to apply on 5.10.y ]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 include/linux/skbuff.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 8abbb64bd..a2daeba8b 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3686,6 +3686,18 @@ skb_header_pointer(const struct sk_buff *skb, int offset, int len, void *buffer)
 				    skb_headlen(skb), buffer);
 }
 
+/* Variant of skb_header_pointer() where @offset is user-controlled
+ * and potentially negative.
+ */
+static inline void * __must_check
+skb_header_pointer_careful(const struct sk_buff *skb, int offset,
+			   int len, void *buffer)
+{
+	if (unlikely(offset < 0 && -offset > skb_headroom(skb)))
+		return NULL;
+	return skb_header_pointer(skb, offset, len, buffer);
+}
+
 /**
  *	skb_needs_linearize - check if we need to linearize a given skb
  *			      depending on the given device features.
-- 
2.53.0


