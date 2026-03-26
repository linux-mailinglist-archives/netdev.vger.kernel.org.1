Return-Path: <netdev+bounces-272193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKBRJ6N5xWnw+QQAu9opvQ
	(envelope-from <netdev+bounces-272193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:23:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 070B433A04B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41E5E30547C5
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E0739FCA7;
	Thu, 26 Mar 2026 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="hxeD51F+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A343368BE
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549038; cv=none; b=L/dUneyFxlrQwDnU8BdtjD+4Cj+h5S1v4JNk8WQ5bogvg5QK5X/lihphWLSd+3DJKhJ6LZOqMDbKKDgaYfb4u/87pAUqzKLMBiBSVfWMBCAmkHtnlMuQ6z/t3OdvhohjIryZv0xpWzK8DrtbGGBZrKSxIzdnrybXSVDLpFYOlxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549038; c=relaxed/simple;
	bh=/s7mUG5Fv9kdG+vGSLKGdiphjJXIw7IkX1WF0aGUmUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTKfVkk6DbDYY+i+czs6z6YjbmUPgAvV3MofiQjNvrfVZJkREyyIgdCJRXA47mAVaOwEnB5BbfkMjzJr6YmCHUDxnYr+Uv7Cq52CabKtGKeSTLqj9fpc9tekFBfUiYrCdgpvm9MI38oShAhb2IWniUOF6A5H75cqnEYYAEv4JQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=hxeD51F+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2adbfab4501so6274745ad.2
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 11:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774549035; x=1775153835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE8phg7go9B6C5XM74Kv5AapiNe7XDiY/VQZh3AQgvY=;
        b=hxeD51F+wfrdXVVfiTTIW38uGUn4VWizY3MoXuiZcIY8U/7HbXukA030/DUNI5aY/c
         Mli9SrbBOpIBDdrR4qTQeDu8yVaxlf7c5NBXEpbHHTFVPGTXDxFVOpPr6D/ayODhEEYo
         BWV/HozGdfdXfavqjfBD5my+xI3td4zEe+8Cn4/3Ixc93g5si4Nv+NwvQVXk51qb0jYs
         8c+sRxBYTtv2rdaaKdz7CBsZhIlTGOH0J8PsO3noE+vc0XLBUK/oGKbUH8sJus9HeX4T
         zW8ux4chS4VOphADnpdbtaLhgTAdXbWEm52wv8/7ElGH6glHAqeo0BAZMgNyeLPcaCk7
         zr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549035; x=1775153835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AE8phg7go9B6C5XM74Kv5AapiNe7XDiY/VQZh3AQgvY=;
        b=IGqefa67jtNsfQBqBMk5G9jpR8gcyZ2GO2aCb4dTy/DdJdTiyPcpj1aoQl98CQmUQT
         ONdm+CCS7OZC1GOkT/G79/8ZfGlkz/6dTXL5XqbqZyoD0F2xpumU/0CGdHyJ+S70xmFp
         2qIJYnfL7Y7uKzpu9Y0Xzh49F7ThZYciIZy4ae/krauoZuGe5KV4b6s+Yv3dI65zHmhf
         MCh+kbX4ip57aQKXTunkNAe3whrvO7C30eACk4GYidvQytkMHGdwthwBinDcp7YQUaBh
         P5XpYOWMTFAsBTthjbejHODebY1cXlwgkOYeGsdHBi38sRxNyGW/bbLRIR8U2xiVhVdd
         6dMQ==
X-Gm-Message-State: AOJu0YxcRlKGXNoLa7UpfO1XwEZXvRNQamArX73kqft9eJVEsot75CwS
	Sg+ZldHR2ghuwX6bQmnxMpHf8QPvb3IbcieoqIF6nzIvrV5br20Zm0AMPmjV4amIBMJmCeKIvJi
	dZfg6
X-Gm-Gg: ATEYQzzHkMvkOAJ2wM5pAP9JfjL5gs4mMKWOPEh+z6z9Is9UBL6UmmxQ/H884ncn/3t
	HkITX1x2xkreIFiweM6pwBnpk/bHenFJfd2n+gZZJYIpt9VSRlV4UoQIAqbcIqff7Z0V+k0HLVS
	l7QieJPqdF2QvTAoQ4x2qlUJ0o8PFLZXhg9WTRAFCQzJrmW783LTXfbC2GMSwnY2k226pMH82wC
	HJsru9/ld/1Ir23XesagDyyQMi0+9d90vxzlOw2Emu5yjZ+azZx1W7/P/m/qd/RYc/yzThoUHuO
	i3h1AN8zjsTYiC3q5pOvgTsTaxXZF876uI969neHe8nMYoYbPFVcHr7uCr1k/GPgdgxTyMHb3bw
	3ZOgdfN9MA6F/Bhi+h4Cm26NhPTolD1Hdz3o5tg8QrBIzAN6ztFiiPuXx1gBjmgIehg7ErUhj+q
	7O/7AoU3Gek+lqjME9EINL8Ub7DiORmaRG
X-Received: by 2002:a17:903:2bce:b0:2ae:63a4:3baf with SMTP id d9443c01a7336-2b0b0b0f401mr99782905ad.46.1774549035400;
        Thu, 26 Mar 2026 11:17:15 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8c4bd3sm38590245ad.63.2026.03.26.11.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:17:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/7] net: Introduce skb tc depth field to track packet loops
Date: Thu, 26 Mar 2026 11:01:00 -0700
Message-ID: <20260326181701.308275-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326181701.308275-1-stephen@networkplumber.org>
References: <20260326181701.308275-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272193-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,mojatatu.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 070B433A04B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jamal Hadi Salim <jhs@mojatatu.com>

Add a 2-bit per-skb tc depth field to track packet loops across the stack.

The previous per-CPU loop counters like MIRRED_NEST_LIMIT
assume a single call stack and lose state in two cases:
1) When a packet is queued and reprocessed later (e.g., egress->ingress
   via backlog), the per-cpu state is gone by the time it is dequeued.
2) With XPS/RPS a packet may arrive on one CPU and be processed on
   another.

A per-skb field solves both by travelling with the packet itself.

The field fits in existing padding, using 2 bits that were previously a
hole:

pahole before(-) and after (+) diff looks like:
   __u8       slow_gro:1;           /*   132: 3  1 */
   __u8       csum_not_inet:1;      /*   132: 4  1 */
   __u8       unreadable:1;         /*   132: 5  1 */
 + __u8       tc_depth:2;           /*   132: 6  1 */

 - /* XXX 2 bits hole, try to pack */
   /* XXX 1 byte hole, try to pack */

   __u16      tc_index;             /*   134     2 */

There used to be a ttl field which was removed as part of tc_verd in commit
aec745e2c520 ("net-tc: remove unused tc_verd fields").  It was already
unused by that time, due to remove earlier in commit c19ae86a510c ("tc: remove
unused redirect ttl").

The first user of this field is netem, which increments tc_depth on
duplicated packets before re-enqueueing them at the root qdisc.  On
re-entry, netem skips duplication for any skb with tc_depth already set,
bounding recursion to a single level regardless of tree topology.

The other user is mirred which increments it on each pass
and limits to depth to MIRRED_DEFER_LIMIT (3).

The new field was called ttl in earlier versions of this patch
but renamed to tc_depth to avoid confusion with IP ttl.

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 include/linux/skbuff.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index daa4e4944ce3..aba4c88a1b3f 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -821,6 +821,7 @@ enum skb_tstamp_type {
  *	@_sk_redir: socket redirection information for skmsg
  *	@_nfct: Associated connection, if any (with nfctinfo bits)
  *	@skb_iif: ifindex of device we arrived on
+ *	@tc_depth: counter for packet duplication
  *	@tc_index: Traffic control index
  *	@hash: the packet hash
  *	@queue_mapping: Queue mapping for multiqueue devices
@@ -1030,6 +1031,7 @@ struct sk_buff {
 	__u8			csum_not_inet:1;
 #endif
 	__u8			unreadable:1;
+	__u8			tc_depth:2;
 #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
 	__u16			tc_index;	/* traffic control index */
 #endif
-- 
2.53.0


