Return-Path: <netdev+bounces-281181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOW1Of1i7mnTtAAAu9opvQ
	(envelope-from <netdev+bounces-281181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 21:09:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE7046AD92
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 21:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1812D30158A1
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 19:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE2437BE6C;
	Sun, 26 Apr 2026 19:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="zo+/LYcF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF09137B413
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777230567; cv=none; b=pzSPW/fXNoL+ALUh46ydMbHzMTp+e11xLp6zaouPp1T9oQ2THh6lp4PqzJ7hVTvg1eC8ZKSYk77x4DNZcsdmsQucDTdMDvq5MZ1kgBjZTk6VxWvO2RKGVr/IGxsOVpr3IeM7ri2CUCYcAJJ29Qu7NRT9Afh6Rh0mRpsq9k1be68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777230567; c=relaxed/simple;
	bh=uht/ytIfJZUvtfyZvAnoc9y1ESSoeslgs1x6DpFWk6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JecZgcRFMf7KxyyrBLC+iYNvmMH3Bz6Z7XzZfNe8Pi9TNKZFl6cyJBOIH0VPPcNtX1Cq5at1HyEX1u4bbNKIOcdQiprI7D2YqtVZ82zVDvNtD/IXSfh7g5SfMEo+HICG7FRbVOpBR/Ooa7du+RQdP8+5dFvPGe0OkHRidLbdsv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=zo+/LYcF; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8acb856a674so116473976d6.0
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 12:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777230563; x=1777835363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCwOAZeZ1LlowPc0KFmOXmjLH5JgO97oYg4ckm9uhX8=;
        b=zo+/LYcF5UfeKNhLXm3/MoM5WA6ADVY2hEaEwTT90kiAhf5EboT8Gwx2R5NEaqZPf9
         tm76QBu51sd2b0p9N3TgaRqTJG6tZaayytDiVFqeswrAoHTkZJi1AJFlHITDQUmr/TFj
         /KRx4BzWrT0EvGGWMStcaTCdT9OkDl13tvgKyJk3esOm154Ur9tdGm+B5HVgyy3d05Wo
         va+pK+fCaa6C02Xx7oI3D0/OAa5uhekEU2wFy8xYs5uz3NvRizQVIMESivmPEs/1SYg9
         +0CDdNZGcz4aZ24dlKCXohiJ02GkOHblmggBkKEVLx3Hb643ZDT4y/+fhxYzLF9sif9p
         IEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777230563; x=1777835363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zCwOAZeZ1LlowPc0KFmOXmjLH5JgO97oYg4ckm9uhX8=;
        b=jLBNNrFz+3tj1418yoVXU9YfEfQuTA6XKgCH16iC0QX4IGxzp3EJKz27TGpcvQgwhm
         Yy9/ptbN34AuowpoaBUDfWbDe9XiKU2UOHKRIZjQYckpodMCkBItrYoPLSCULxgxmnv1
         bx2i86p5x0iI8ecj9NVDt1vf6btQkmz7zOS28b1oXubNsDEvci0XTilhtmDufRJrcxH2
         yp9h3Ug3fSrxBpxSWtr/skr/8lZpXCvgP0o7SqjXdcIhxwoyLDoCsepaO7oi5RUDQ/hv
         viwdhn3YvMuBYcvhyOq3tEoTl6kSU4XuAxAg92OMOqZ/QI+I3dnEjztO0yLzHpQlrHbP
         AVaA==
X-Gm-Message-State: AOJu0YxyurdyLYwpBvyMr3hKhInSo5EAh7ok7596q6L83ngxQM+IaW2E
	8fF55JWgoT9stNYJU0ZCKhkQwcTSW/utzPFoBnTEylH09moxsFcKaO5OeSai2Wlkrwy1Xd3GToL
	MHjc=
X-Gm-Gg: AeBDiesJOXEuu4LeCkoFLGhmgaHGyCveuEjcSf/rGAAcafxlkLmVp0tlUeJ23xdCdYO
	z8AXbOP8rruOeEm8DSxBYZWPVuogQIm5skCJER7NLtHP1hjuU07u9J2b5juwPyY9TCV62KM19ia
	h39jHF//lJ0dxGRqZwUR4AV0tol+roXrC8nEyiBC1f2oJXEGTXd9gyBkh4eMcLggxaHiEpIrD+s
	qoCDPXRMV7hhsHo9MR2OXYLj/v/H9+zQ9jp8hfr7J474oQVuRBFvPIDWgxMjCqlmlWMctcbhVY4
	YxqJztS2oZQhfjtnw8JKPzhe/cc+g+cr6N+fqdZ3OgSUjr9zonbWWJkIhmH85JEiU+aXzgz0gtX
	Ywbjg5tHUDsDW95xA6S4TMHd6M/nRuGlCyaWz2bZT3PGVOgneskggNG01vGCoZx94GwOY5x6RI0
	cD6aT+9sIVFss/xs5FUoEFAafeD3FSrfpv/6bNnkccyIqU8aMER37NiZuEjFxEZyGB53U18fxne
	6GT8VGrsBw+EpVowvQL6dGoVZdlxks=
X-Received: by 2002:a05:6214:1d0a:b0:89c:87b9:a5c3 with SMTP id 6a1803df08f44-8b02876c6ccmr515117736d6.25.1777230563511;
        Sun, 26 Apr 2026 12:09:23 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5eaf1sm245421306d6.30.2026.04.26.12.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 12:09:22 -0700 (PDT)
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
Subject: [PATCH net 1/9] net: Introduce skb tc depth field to track packet loops
Date: Sun, 26 Apr 2026 15:09:08 -0400
Message-Id: <20260426190916.128489-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260426190916.128489-1-jhs@mojatatu.com>
References: <20260426190916.128489-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4BE7046AD92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281181-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,mojatatu.com,syst3mfailure.io,willsroot.io,asu.edu,toke.dk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu-com.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:mid,mojatatu.com:email,networkplumber.org:email]

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
unused by that time, due to remove earlier in commit c19ae86a510c
("tc: remove unused redirect ttl").

The first user of this field is netem, which increments tc_depth on
duplicated packets before re-enqueueing them at the root qdisc.  On
re-entry, netem skips duplication for any skb with tc_depth already set,
bounding recursion to a single level regardless of tree topology.

The other user is mirred which increments it on each pass
and limits to depth to MIRRED_DEFER_LIMIT (3).

The new field was called ttl in earlier versions of this patch
but renamed to tc_depth to avoid confusion with IP ttl.

Note (looking at you Sashiko!):
1. Since both mirred and netem utilize the same 2-bit tc_depth field it is
   possible when netem and mirred are used together that netem qdisc to skip
   the duplication step. This is a known trade-off, as a 2-bit field cannot
   independently track both features' recursion depths and it is not considered
   sane to have a setup that addresses both features on at the same time.

2. skb_scrub_packet does not clear tc_depth. This means a packet's loop history
  is preserved even across namespaces. While this might be restrictive for
  some topologies, it is also design intent to provide robustness against loops
  across namespaces.

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
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


