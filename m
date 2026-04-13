Return-Path: <netdev+bounces-277953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DH6Jk503Gn1RAkAu9opvQ
	(envelope-from <netdev+bounces-277953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 06:42:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5EF3E7561
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 06:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E9643030B12
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 04:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61498383C86;
	Mon, 13 Apr 2026 04:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Bsl+aEeG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097C931E835
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 04:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776055233; cv=none; b=Q/LzEQnfcKlK5XfjMuJXethYKiqyXjxz9HdN6AQjy6zzOmZoeyxoW2HlyLPhr8SFHWi/ylbBxYL7Sq896gICk46isHrOSxPccqSKDBaN+BG7PpRatxHHUo1vBzYM8krS2EpKC9Di/+VikM1Z00ILDvVUxvH57+jSBstpVxO/kto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776055233; c=relaxed/simple;
	bh=eUByrnPJ2nona1QXhiPKoFAJ4ou5D+Pn4Dg2jpFDt6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LEle8RnXFyZvBgo/m8O+nHADK4mDJJ7TOauB4N7KkETiHgZGUbvPLvvLdaSTYghpKbSwVF7BmIA6P1GxG+K24q+B699ZHajGyExUA8bPL4obQ1FQjUs/hgxa+alPLIViD4NcahAe7u1XaofsKIW/VDqtOmvrkLjdW5eCBshybXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Bsl+aEeG; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-8aca4efb81cso1835186d6.1
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 21:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776055231; x=1776660031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2l7i8vnpUJQTdJaWwY66SR5P0SKGOILNorZy9BBZKRQ=;
        b=GYr+bPbyKzg3vRMCJ2IVboRuxO9S6eM5KJ7dTflL7AAV5E5r5njuRqN82rHWAiZwRd
         BZYKSYzqYRqJ/B+HEX05gJZhRr4ntNJatRU8JlD1KjKCiQpIY0tX5jKrJmO3epZ1vjXh
         iTAFqRP2psjGTtpsHoD2xERfvyMXGRB1TGzd/e3dM55mWUc6PuAojDj82eWpwG4r4EA/
         4MnJA9GcuF3fVqq0/LmmRyOjKAK8RgYQhdpWuwG9Lx6XzaBwZBgIV6CfqWqFoxVOtkox
         6Jbcz75ljN6uaiJI2am5WaMS1bmNnNM4dGYAxssap5y6CIlkOYKyUP93P8SeSt6d84+N
         gYTw==
X-Forwarded-Encrypted: i=1; AJvYcCVGvElIvXXwCJNRSkmFJ3DIS09wyxSAKSCcoYAwR/266qwriX388zI8LJ4Pm+/Js9W/9ZOAAEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRLHgxf5tVdV9qSJ/bO5JgsK9ygd+4IgqU+ShQIrhSTRP1A09w
	El+h4FCs5OFsMHx8Zpm+OKR2EMwbbkdLpPMIsM3cmN39OH4SjqtNfvDw7tMqZR4bAoKOxAVaySa
	81WVim5orP4lcmmTAKXuw1SMzpNkE33iuc9cPXz7hW/I1eMQLYcTYaJhLvIo1UsIUeuoAFrVJ5g
	kvY6aHzQuPFAT221/DeRzIyWqzxHi1tvVGkL78StfYB1aogSYnR/bfhPzWzb7kT2hZ63N7nmbK1
	BARZxSIuRbcMaWwCPaZMzrjlB1z
X-Gm-Gg: AeBDieupWy7g3/7Gg8diX/9yV+039o1Oh5gTz1ym+2SMl9awd221opawsebRzGAmeOd
	kY3H35GgcA9SqFYdyyZR87hUgWGSpZ+LSlL+yTh24jV8yQPL8JrFF305qpGy2+oeN+fSH0AY3lT
	B/bwejmQ2ESO8C5vA70IngD/0qcgeTV3GzlZvE07ezNo2jiYkUuo+L35BPgGEGRlJfUyc84dC17
	bRkuTN2GOYVnZzHLWDEmKOYxG0Q5ZmZbsktNJWJmh/wwzQ2GAecMKhwY1QPEAzWF+TuJ5kwIK5R
	x8q0Ejc8aoM/e6b3+5M61TFjb0NnBq0QPAnSTmD2vsU8rSsE9rdzS+iHgMo8LMYKUz/oXrINEls
	GWP+Svqj6rWVxd0oczT1CYSHD5ZWQEQN0nK0qOf7PxpIRdbJeASW8DF76fxXIQD6RFOsEiHlHQ+
	NBQYiaQ8lgYp5UHJN5XYJVcbcpnidU284j+tcDOdoIMgtBQ/JRK5La7PPelZw4iwTlXmAfC99eT
	g==
X-Received: by 2002:ac8:5c92:0:b0:509:39b5:a97a with SMTP id d75a77b69052e-50dd7934795mr118096551cf.0.1776055230874;
        Sun, 12 Apr 2026 21:40:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50dd5488029sm5588501cf.9.2026.04.12.21.40.29
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2026 21:40:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-12714223a5cso461794c88.0
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 21:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776055229; x=1776660029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2l7i8vnpUJQTdJaWwY66SR5P0SKGOILNorZy9BBZKRQ=;
        b=Bsl+aEeG4YLqFSpfbtV7Jd9pMFk2JSju6AQGoN4NqSduQqZnCgkIF8Ld5R94KaR51M
         sZC4bVByMRuFyGBgGuFzVzda/YmbojVV8OZcHIi1Rt4g0GOAK5gxZsC4S8UrTTrtYUOW
         nA/q1LToHVseQb6q9tXlIO6+Si3rQ2LsU54pA=
X-Forwarded-Encrypted: i=1; AFNElJ8EpSVuQGeNCyW32XWMHX2RWp3T5KdEK75JyaloKySHTskRNB/1KH25ad1cLxykMFfyQYdxfNs=@vger.kernel.org
X-Received: by 2002:a05:7301:1e84:b0:2cb:de38:c76f with SMTP id 5a478bee46e88-2d5c3f14ed2mr2494770eec.6.1776055228862;
        Sun, 12 Apr 2026 21:40:28 -0700 (PDT)
X-Received: by 2002:a05:7301:1e84:b0:2cb:de38:c76f with SMTP id 5a478bee46e88-2d5c3f14ed2mr2494757eec.6.1776055228195;
        Sun, 12 Apr 2026 21:40:28 -0700 (PDT)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d562db64c4sm14677061eec.27.2026.04.12.21.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 21:40:27 -0700 (PDT)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Stefano Brivio <sbrivio@redhat.com>,
	Mukul Sikka <mukul.sikka@broadcom.com>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10] netfilter: nft_set_pipapo: do not rely on ZERO_SIZE_PTR
Date: Mon, 13 Apr 2026 04:33:04 +0000
Message-ID: <20260413043304.3327873-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277953-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_NEQ_ENVFROM(0.00)[keerthana.kalyanasundaram@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1E5EF3E7561
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Florian Westphal <fw@strlen.de>

commit 07ace0bbe03b3d8e85869af1dec5e4087b1d57b8 upstream

pipapo relies on kmalloc(0) returning ZERO_SIZE_PTR (i.e., not NULL
but pointer is invalid).

Rework this to not call slab allocator when we'd request a 0-byte
allocation.

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Mukul Sikka <mukul.sikka@broadcom.com>
Signed-off-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
[Keerthana: In older stable branches (v6.6 and earlier), the allocation logic in
pipapo_clone() still relies on `src->rules` rather than `src->rules_alloc`
(introduced in v6.9 via 9f439bd6ef4f). Consequently, the previously
backported INT_MAX clamping check uses `src->rules`. This patch correctly
moves that `src->rules > (INT_MAX / ...)` check inside the new
`if (src->rules > 0)` block]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 net/netfilter/nft_set_pipapo.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index a4fdd1587bb3..83606dfde033 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -524,6 +524,9 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 	struct nft_pipapo_field *f;
 	int i;
 
+	if (m->bsize_max == 0)
+		return ret;
+
 	res_map = kmalloc_array(m->bsize_max, sizeof(*res_map), GFP_ATOMIC);
 	if (!res_map) {
 		ret = ERR_PTR(-ENOMEM);
@@ -1363,14 +1366,20 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 		       src->bsize * sizeof(*dst->lt) *
 		       src->groups * NFT_PIPAPO_BUCKETS(src->bb));
 
-		if (src->rules > (INT_MAX / sizeof(*src->mt)))
-			goto out_mt;
+		if (src->rules > 0) {
+			if (src->rules > (INT_MAX / sizeof(*src->mt)))
+				goto out_mt;
 
-		dst->mt = kvmalloc(src->rules * sizeof(*src->mt), GFP_KERNEL);
-		if (!dst->mt)
-			goto out_mt;
+			dst->mt = kvmalloc_array(src->rules, sizeof(*src->mt),
+						 GFP_KERNEL);
+			if (!dst->mt)
+				goto out_mt;
+
+			memcpy(dst->mt, src->mt, src->rules * sizeof(*src->mt));
+		} else {
+			dst->mt = NULL;
+		}
 
-		memcpy(dst->mt, src->mt, src->rules * sizeof(*src->mt));
 		src++;
 		dst++;
 	}
-- 
2.43.7


