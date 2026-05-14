Return-Path: <netdev+bounces-288006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDtrHoXiBWqNdAIAu9opvQ
	(envelope-from <netdev+bounces-288006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:56:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C67BA543919
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BEFC30CB9C2
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ACB421EE2;
	Thu, 14 May 2026 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="EPKdib+D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB2441B35F
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770088; cv=none; b=UDym9q+bmP84a2D8tLdlKzmdiiIgQgGOcq07TTFggvcYQqAaTHodURBvF8GklhRDI3tHuWjs6THwQ0N8dspAa86/5FyqwtDe/TYP16X01W0RxnkNifmQZT0dWjrT1I9IV6AChSKJZracN6h+oOQFjWBJhfDoV9aORUvkm107keI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770088; c=relaxed/simple;
	bh=0X/Qlg/qBk19uNluQtTMn6fYbTZlVEgqOLOhHV3tu74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gAaJAqhLchcfx370q7z40XbkrDd1PCrUKs8wYlRYbKgTSFjdF+DDNtxFL3qVw6NkC6ymlNknxQB40Xg6ll0d97mthl85UZd29P0suTD3f6rGp0NKc8DTLMhWbcm53AZYiMJHKJrPTPQiNIiILsQAHn0mgEwU+8dtOj4pEKk10sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=EPKdib+D; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50d876329bbso75073161cf.2
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 07:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1778770084; x=1779374884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbUCXnKocSpDF9GHJTSkpxIzixr3Yn++mlpZxToj45k=;
        b=EPKdib+DNox6Gwjede5bHZPdGXMuTy2W0NLssPOthODNIklXpMprcrKpN220wr2oi6
         FWcYK4dmfbSD53LcYIyz8JGefgGtBL4xwFhcArSLrt4V7n0052AsMyGMrumodF7ln+iN
         prtfzBExiLl4x+uGow+KerTjHZJMxHkPpWttjYf/+kWQwoJsyP7bZWsl7MyIsKlrRiTm
         gQxFhp+tbzJzIF2Dq1Aj9V5x8epN16YVdopwlytNYvVvqU3aPPRz+6cqcQ5rdnwsi7DL
         5jhbBTlAJ3NchX+TeDbhVdVA/PC9Z1cHuDk/JUwOzOlrbPy96w2n5o+PzacBQKItPBFs
         ncDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778770084; x=1779374884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bbUCXnKocSpDF9GHJTSkpxIzixr3Yn++mlpZxToj45k=;
        b=NTk6fp4CxsKdsD+/H9jarr2T5n+ERQ4S7dG4fsFODncJyxUlUZqPgFdD2S+GxIMC0a
         mb6qwuf23tzODolsJYso4EeZHwW3teaWnf5H0g+Qy9+HnTKo8J8awcyIoI4mQQn+QkRw
         Z7JLTAO0p6/GXseMVVOz4vpsZrUlcs62hEqetoH6ooXHhhLCIa2Y8z1aQXflB6JqTbYh
         BGKzrkeDQj2LUJeIRIMup3s89tqrboHq/r/9TXD4ng/BtjZwOnUj0kf4EysxRAx38gNY
         A/VUp0gFf8vpTxj+QoCLx5/mHW00PPmQ0bA26qIy7iFfFOAmLT2m49ybLGokVLtXkRVP
         Gr3g==
X-Gm-Message-State: AOJu0Yz0DWAfQIqfouCSgGN9l/98mT/0Aw0r5Bjsr9Ijqp9hvnZJLn32
	IFpPgYhPgKHr6JhruPQzBu6xS7lumDnGUQHdycr7EJcEc83qkRxpw0eLBu9eHaxISpIGI0Su812
	7U0wkEg==
X-Gm-Gg: Acq92OFnkZer2wKjzrjuWYOvA73spq9prHkXzwjHFGxf/vzP3oNZ2kJldMdVoJ7FETX
	aQ8c7ROey7vbx0ue492nemPYaifwVP6YPf6w336w8UgcP7n7Czp+I36Z5XAzDLrfTgzfk8mhA6z
	vqDw+uizyozAJTA7QfsI+Z4esG55kbRIjqzpavUv7aKb1rCtrr/zkJzm7tnYs+hNnfo8ZJ27Y7D
	/M37bwseRIe0Uqqn3zUeJoHOZdoMhjbWXgIP/mDJAtGj1gaT/yEEh3h+Fxefx3suILB0ciSZ7ip
	CsgQw6/0tfBB8pCsgXXA2Erv7z4MuahbaxCKhcbrZ29f/pqBYE4wSrdjSNb8oazDzmIrqRN0fA6
	vWDKSBXPZMTFIEv7+GDmJTMNFQb2nEqgiQfq1XpWPPxn/Uhax0u1FoFBqpsQHHpOqDMHj5mQQCx
	t18ElRw1S3/E3Y3jYy/QvWSioM19w=
X-Received: by 2002:a05:622a:60f:b0:50f:ae24:ecdb with SMTP id d75a77b69052e-5162f58e2f1mr118283911cf.37.1778770083717;
        Thu, 14 May 2026 07:48:03 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456c0a42sm19125461cf.10.2026.05.14.07.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:48:03 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	stephen@networkplumber.org,
	victor@mojatatu.com,
	savy@syst3mfailure.io,
	will@willsroot.io,
	xmei5@asu.edu,
	pctammela@mojatatu.com,
	kuniyu@google.com,
	toke@toke.dk,
	willemdebruijnkernel@gmail.com,
	hxzene@gmail.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v5 1/9] net: Introduce skb tc depth field to track packet loops
Date: Thu, 14 May 2026 10:47:39 -0400
Message-Id: <20260514144747.527175-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514144747.527175-1-jhs@mojatatu.com>
References: <20260514144747.527175-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C67BA543919
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288006-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,mojatatu.com,syst3mfailure.io,willsroot.io,asu.edu,toke.dk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:email,mojatatu.com:mid,networkplumber.org:email,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

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

Note (looking at you Sashiko! Dont ignore me and continue bringing this up):
1. Since both mirred and netem utilize the same 2-bit tc_depth field it is
   possible when netem and mirred are used together that netem qdisc to skip
   the duplication step. This is a known trade-off, as a 2-bit field cannot
   independently track both features' recursion depths and it is not considered
   sane to have a setup that addresses both features on at the same time.

2. skb_scrub_packet does not clear tc_depth. This means a packet's loop history
  is preserved even across namespaces. While this might be restrictive for
  some topologies, it is also design intent to provide robustness against loops
  across namespaces.

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/linux/skbuff.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2bcf78a4de7b..3f06254ab1b7 100644
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
2.34.1


